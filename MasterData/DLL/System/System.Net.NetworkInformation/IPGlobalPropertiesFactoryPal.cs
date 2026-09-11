namespace System.Net.NetworkInformation;

internal static class IPGlobalPropertiesFactoryPal
{
	public static IPGlobalProperties Create()
	{
		IPGlobalProperties iPGlobalProperties = UnixIPGlobalPropertiesFactoryPal.Create();
		if (iPGlobalProperties == null)
		{
			iPGlobalProperties = Win32IPGlobalPropertiesFactoryPal.Create();
		}
		if (iPGlobalProperties == null)
		{
			throw new NotImplementedException();
		}
		return iPGlobalProperties;
	}
}
