namespace System.Net.NetworkInformation;

internal static class IPGlobalPropertiesFactoryPal
{
	public static IPGlobalProperties Create()
	{
		return UnixIPGlobalPropertiesFactoryPal.Create() ?? throw new NotImplementedException();
	}
}
