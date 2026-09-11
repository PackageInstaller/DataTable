namespace System.Net.NetworkInformation;

internal static class Win32IPGlobalPropertiesFactoryPal
{
	public static IPGlobalProperties Create()
	{
		return new Win32IPGlobalProperties();
	}
}
