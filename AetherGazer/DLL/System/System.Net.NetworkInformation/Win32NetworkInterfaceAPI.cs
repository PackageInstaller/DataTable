using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace System.Net.NetworkInformation;

internal class Win32NetworkInterfaceAPI : NetworkInterfaceFactory
{
	[DllImport("iphlpapi.dll", SetLastError = true)]
	private static extern int GetAdaptersAddresses(uint family, uint flags, IntPtr reserved, IntPtr info, ref int size);

	private static Win32_IP_ADAPTER_ADDRESSES[] GetAdaptersAddresses()
	{
		IntPtr zero = IntPtr.Zero;
		int size = 0;
		uint flags = 192u;
		GetAdaptersAddresses(0u, flags, IntPtr.Zero, zero, ref size);
		if (Marshal.SizeOf(typeof(Win32_IP_ADAPTER_ADDRESSES)) > size)
		{
			throw new NetworkInformationException();
		}
		zero = Marshal.AllocHGlobal(size);
		int adaptersAddresses = GetAdaptersAddresses(0u, flags, IntPtr.Zero, zero, ref size);
		if (adaptersAddresses != 0)
		{
			throw new NetworkInformationException(adaptersAddresses);
		}
		List<Win32_IP_ADAPTER_ADDRESSES> list = new List<Win32_IP_ADAPTER_ADDRESSES>();
		IntPtr intPtr = zero;
		while (intPtr != IntPtr.Zero)
		{
			Win32_IP_ADAPTER_ADDRESSES item = Marshal.PtrToStructure<Win32_IP_ADAPTER_ADDRESSES>(intPtr);
			list.Add(item);
			intPtr = item.Next;
		}
		return list.ToArray();
	}

	public override NetworkInterface[] GetAllNetworkInterfaces()
	{
		Win32_IP_ADAPTER_ADDRESSES[] adaptersAddresses = GetAdaptersAddresses();
		NetworkInterface[] array = new NetworkInterface[adaptersAddresses.Length];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = new Win32NetworkInterface2(adaptersAddresses[i]);
		}
		return array;
	}
}
