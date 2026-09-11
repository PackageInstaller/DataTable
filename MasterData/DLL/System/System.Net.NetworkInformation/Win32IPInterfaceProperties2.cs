using System.Runtime.InteropServices;

namespace System.Net.NetworkInformation;

internal class Win32IPInterfaceProperties2 : IPInterfaceProperties
{
	private readonly Win32_IP_ADAPTER_ADDRESSES addr;

	private readonly Win32_MIB_IFROW mib4;

	private readonly Win32_MIB_IFROW mib6;

	public override IPAddressCollection DnsAddresses => Win32IPAddressCollection.FromDnsServer(addr.FirstDnsServerAddress);

	public override GatewayIPAddressInformationCollection GatewayAddresses
	{
		get
		{
			GatewayIPAddressInformationCollection gatewayIPAddressInformationCollection = new GatewayIPAddressInformationCollection();
			try
			{
				IntPtr intPtr = addr.FirstGatewayAddress;
				while (intPtr != IntPtr.Zero)
				{
					Win32_IP_ADAPTER_GATEWAY_ADDRESS win32_IP_ADAPTER_GATEWAY_ADDRESS = (Win32_IP_ADAPTER_GATEWAY_ADDRESS)Marshal.PtrToStructure(intPtr, typeof(Win32_IP_ADAPTER_GATEWAY_ADDRESS));
					gatewayIPAddressInformationCollection.InternalAdd(new SystemGatewayIPAddressInformation(win32_IP_ADAPTER_GATEWAY_ADDRESS.Address.GetIPAddress()));
					intPtr = win32_IP_ADAPTER_GATEWAY_ADDRESS.Next;
				}
			}
			catch (IndexOutOfRangeException)
			{
			}
			return gatewayIPAddressInformationCollection;
		}
	}

	public override UnicastIPAddressInformationCollection UnicastAddresses
	{
		get
		{
			try
			{
				return Win32FromUnicast(addr.FirstUnicastAddress);
			}
			catch (IndexOutOfRangeException)
			{
				return new UnicastIPAddressInformationCollection();
			}
		}
	}

	public Win32IPInterfaceProperties2(Win32_IP_ADAPTER_ADDRESSES addr, Win32_MIB_IFROW mib4, Win32_MIB_IFROW mib6)
	{
		this.addr = addr;
		this.mib4 = mib4;
		this.mib6 = mib6;
	}

	private static UnicastIPAddressInformationCollection Win32FromUnicast(IntPtr ptr)
	{
		UnicastIPAddressInformationCollection unicastIPAddressInformationCollection = new UnicastIPAddressInformationCollection();
		IntPtr intPtr = ptr;
		while (intPtr != IntPtr.Zero)
		{
			Win32_IP_ADAPTER_UNICAST_ADDRESS info = (Win32_IP_ADAPTER_UNICAST_ADDRESS)Marshal.PtrToStructure(intPtr, typeof(Win32_IP_ADAPTER_UNICAST_ADDRESS));
			unicastIPAddressInformationCollection.InternalAdd(new Win32UnicastIPAddressInformation(info));
			intPtr = info.Next;
		}
		return unicastIPAddressInformationCollection;
	}
}
