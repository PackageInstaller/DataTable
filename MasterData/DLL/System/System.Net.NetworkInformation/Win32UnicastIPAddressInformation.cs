using System.Net.Sockets;

namespace System.Net.NetworkInformation;

internal class Win32UnicastIPAddressInformation : UnicastIPAddressInformation
{
	private Win32_IP_ADAPTER_UNICAST_ADDRESS info;

	private IPAddress ipv4Mask;

	public override IPAddress Address => info.Address.GetIPAddress();

	public Win32UnicastIPAddressInformation(Win32_IP_ADAPTER_UNICAST_ADDRESS info)
	{
		this.info = info;
		IPAddress iPAddress = info.Address.GetIPAddress();
		if (iPAddress.AddressFamily == AddressFamily.InterNetwork)
		{
			ipv4Mask = PrefixLengthToSubnetMask(info.OnLinkPrefixLength, iPAddress.AddressFamily);
		}
	}

	private static IPAddress PrefixLengthToSubnetMask(byte prefixLength, AddressFamily family)
	{
		byte[] array = ((family != AddressFamily.InterNetwork) ? new byte[16] : new byte[4]);
		for (int i = 0; i < prefixLength; i++)
		{
			array[i / 8] |= (byte)(128 >> i % 8);
		}
		return new IPAddress(array);
	}
}
