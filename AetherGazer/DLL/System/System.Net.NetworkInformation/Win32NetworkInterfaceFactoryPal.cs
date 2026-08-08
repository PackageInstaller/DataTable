namespace System.Net.NetworkInformation;

internal static class Win32NetworkInterfaceFactoryPal
{
	public static NetworkInterfaceFactory Create()
	{
		Version version = new Version(5, 1);
		if (Environment.OSVersion.Version >= version)
		{
			return new Win32NetworkInterfaceAPI();
		}
		return null;
	}
}
