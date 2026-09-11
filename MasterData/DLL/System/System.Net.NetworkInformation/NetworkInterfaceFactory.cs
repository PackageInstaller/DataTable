namespace System.Net.NetworkInformation;

internal abstract class NetworkInterfaceFactory
{
	public abstract NetworkInterface[] GetAllNetworkInterfaces();

	public static NetworkInterfaceFactory Create()
	{
		return NetworkInterfaceFactoryPal.Create();
	}
}
