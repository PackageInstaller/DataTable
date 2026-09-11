using System.Runtime.InteropServices;

namespace System.Net.NetworkInformation;

internal sealed class Win32NetworkInterface2 : NetworkInterface
{
	private Win32_IP_ADAPTER_ADDRESSES addr;

	private Win32_MIB_IFROW mib4;

	private Win32_MIB_IFROW mib6;

	private Win32IPv4InterfaceStatistics ip4stats;

	private IPInterfaceProperties ip_if_props;

	public override NetworkInterfaceType NetworkInterfaceType => addr.IfType;

	public override OperationalStatus OperationalStatus => addr.OperStatus;

	[DllImport("iphlpapi.dll", SetLastError = true)]
	private static extern int GetIfEntry(ref Win32_MIB_IFROW row);

	internal Win32NetworkInterface2(Win32_IP_ADAPTER_ADDRESSES addr)
	{
		this.addr = addr;
		mib4 = default(Win32_MIB_IFROW);
		mib4.Index = addr.Alignment.IfIndex;
		if (GetIfEntry(ref mib4) != 0)
		{
			mib4.Index = -1;
		}
		mib6 = default(Win32_MIB_IFROW);
		mib6.Index = addr.Ipv6IfIndex;
		if (GetIfEntry(ref mib6) != 0)
		{
			mib6.Index = -1;
		}
		ip4stats = new Win32IPv4InterfaceStatistics(mib4);
		ip_if_props = new Win32IPInterfaceProperties2(addr, mib4, mib6);
	}

	public override IPInterfaceProperties GetIPProperties()
	{
		return ip_if_props;
	}

	public override PhysicalAddress GetPhysicalAddress()
	{
		byte[] array = new byte[addr.PhysicalAddressLength];
		Array.Copy(addr.PhysicalAddress, 0, array, 0, array.Length);
		return new PhysicalAddress(array);
	}
}
