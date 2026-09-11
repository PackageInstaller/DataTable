using System.Runtime.InteropServices;

namespace System.Security.Policy;

[ComVisible(true)]
public static class ApplicationSecurityManager
{
	private static IApplicationTrustManager _appTrustManager;

	public static IApplicationTrustManager ApplicationTrustManager
	{
		get
		{
			if (_appTrustManager == null)
			{
				_appTrustManager = new MonoTrustManager();
			}
			return _appTrustManager;
		}
	}

	[MonoTODO("Missing application manifest support")]
	public static bool DetermineApplicationTrust(ActivationContext activationContext, TrustManagerContext context)
	{
		if (activationContext == null)
		{
			throw new NullReferenceException("activationContext");
		}
		return ApplicationTrustManager.DetermineApplicationTrust(activationContext, context).IsApplicationTrustedToRun;
	}
}
