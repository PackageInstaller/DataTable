namespace System.Net.NetworkInformation;

public abstract class IPGlobalProperties
{
	public abstract string DomainName { get; }

	public static IPGlobalProperties GetIPGlobalProperties()
	{
		return IPGlobalPropertiesFactoryPal.Create();
	}

	internal static IPGlobalProperties InternalGetIPGlobalProperties()
	{
		return GetIPGlobalProperties();
	}
}
