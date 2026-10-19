using System.Runtime.InteropServices;

namespace System.Security.Policy;

[ComVisible(true)]
public interface IApplicationTrustManager : ISecurityEncodable
{
	ApplicationTrust DetermineApplicationTrust(ActivationContext activationContext, TrustManagerContext context);
}
