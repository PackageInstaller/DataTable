namespace System.Net.NetworkInformation;

internal static class NetworkInterfaceFactoryPal
{
	public static NetworkInterfaceFactory Create()
	{
		NetworkInterfaceFactory networkInterfaceFactory = UnixNetworkInterfaceFactoryPal.Create();
		if (networkInterfaceFactory == null)
		{
			networkInterfaceFactory = Win32NetworkInterfaceFactoryPal.Create();
		}
		if (networkInterfaceFactory == null)
		{
			throw new NotImplementedException();
		}
		return networkInterfaceFactory;
	}
}
