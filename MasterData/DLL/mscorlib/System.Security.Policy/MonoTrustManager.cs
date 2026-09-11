namespace System.Security.Policy;

internal class MonoTrustManager : IApplicationTrustManager, ISecurityEncodable
{
	public ApplicationTrust DetermineApplicationTrust(ActivationContext activationContext, TrustManagerContext context)
	{
		if (activationContext == null)
		{
			throw new ArgumentNullException("activationContext");
		}
		return null;
	}

	public SecurityElement ToXml()
	{
		SecurityElement securityElement = new SecurityElement("IApplicationTrustManager");
		securityElement.AddAttribute("class", typeof(MonoTrustManager).AssemblyQualifiedName);
		securityElement.AddAttribute("version", "1");
		return securityElement;
	}
}
