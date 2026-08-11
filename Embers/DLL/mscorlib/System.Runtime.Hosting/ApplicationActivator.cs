using System.Runtime.InteropServices;
using System.Runtime.Remoting;
using System.Security;
using System.Security.Policy;

namespace System.Runtime.Hosting;

[ComVisible(true)]
[MonoTODO("missing manifest support")]
public class ApplicationActivator
{
	public virtual ObjectHandle CreateInstance(ActivationContext activationContext)
	{
		return CreateInstance(activationContext, null);
	}

	public virtual ObjectHandle CreateInstance(ActivationContext activationContext, string[] activationCustomData)
	{
		if (activationContext == null)
		{
			throw new ArgumentNullException("activationContext");
		}
		return CreateInstanceHelper(new AppDomainSetup(activationContext));
	}

	protected static ObjectHandle CreateInstanceHelper(AppDomainSetup adSetup)
	{
		if (adSetup == null)
		{
			throw new ArgumentNullException("adSetup");
		}
		if (adSetup.ActivationArguments == null)
		{
			throw new ArgumentException(string.Format(Locale.GetText("{0} is missing it's {1} property"), "AppDomainSetup", "ActivationArguments"), "adSetup");
		}
		HostSecurityManager hostSecurityManager = null;
		hostSecurityManager = ((AppDomain.CurrentDomain.DomainManager == null) ? new HostSecurityManager() : AppDomain.CurrentDomain.DomainManager.HostSecurityManager);
		Evidence evidence = new Evidence();
		evidence.AddHost(adSetup.ActivationArguments);
		TrustManagerContext context = new TrustManagerContext();
		if (!hostSecurityManager.DetermineApplicationTrust(evidence, null, context).IsApplicationTrustedToRun)
		{
			throw new PolicyException(Locale.GetText("Current policy doesn't allow execution of addin."));
		}
		return AppDomain.CreateDomain("friendlyName", null, adSetup).CreateInstance("assemblyName", "typeName", null);
	}
}
