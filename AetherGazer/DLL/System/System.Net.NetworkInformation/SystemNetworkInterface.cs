namespace System.Net.NetworkInformation;

internal static class SystemNetworkInterface
{
	private static readonly NetworkInterfaceFactory nif = NetworkInterfaceFactory.Create();

	public static NetworkInterface[] GetNetworkInterfaces()
	{
		try
		{
			return nif.GetAllNetworkInterfaces();
		}
		catch
		{
			return new NetworkInterface[0];
		}
	}
}
