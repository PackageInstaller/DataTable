using System.Runtime.Hosting;
using System.Runtime.InteropServices;
using System.Security.Policy;

namespace System.Security;

[Serializable]
[ComVisible(true)]
public class HostSecurityManager
{
	public virtual ApplicationTrust DetermineApplicationTrust(Evidence applicationEvidence, Evidence activatorEvidence, TrustManagerContext context)
	{
		if (applicationEvidence == null)
		{
			throw new ArgumentNullException("applicationEvidence");
		}
		ActivationArguments activationArguments = null;
		foreach (object item in applicationEvidence)
		{
			activationArguments = item as ActivationArguments;
			if (activationArguments != null)
			{
				break;
			}
		}
		if (activationArguments == null)
		{
			throw new ArgumentException(string.Format(Locale.GetText("No {0} found in {1}."), "ActivationArguments", "Evidence"), "applicationEvidence");
		}
		if (activationArguments.ActivationContext == null)
		{
			throw new ArgumentException(string.Format(Locale.GetText("No {0} found in {1}."), "ActivationContext", "ActivationArguments"), "applicationEvidence");
		}
		if (ApplicationSecurityManager.DetermineApplicationTrust(activationArguments.ActivationContext, context))
		{
			if (activationArguments.ApplicationIdentity == null)
			{
				return new ApplicationTrust();
			}
			return new ApplicationTrust(activationArguments.ApplicationIdentity);
		}
		return null;
	}
}
