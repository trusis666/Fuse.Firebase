using Uno;
using Uno.UX;
using Uno.Threading;
using Uno.Text;
using Uno.Platform;
using Uno.Compiler.ExportTargetInterop;
using Uno.Collections;
using Fuse;
using Fuse.Scripting;
using Fuse.Reactive;

namespace Firebase.Authentication.Facebook.JS
{
    /**
    */
    [UXGlobalModule]
    public sealed class FacebookModule : NativeModule
    {
        static readonly FacebookModule _instance;
        static NativeEvent _onAuth;

        public FacebookModule()
        {
            if(_instance != null) return;
            Uno.UX.Resource.SetGlobalKey(_instance = this, "Firebase/Authentication/Facebook");

            _onAuth = new NativeEvent("onAuth");
            AddMember(_onAuth);
            Firebase.Authentication.Facebook.FacebookService.Init();
        }

        static void Auth(string token)
        {
            _onAuth.RaiseAsync(_onAuth.Context.ThreadWorker);
        }
    }

}
