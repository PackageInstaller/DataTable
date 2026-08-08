using System.Runtime.InteropServices;

namespace System.Net.NetworkInformation;

internal struct Win32_IP_ADDR_STRING
{
	public IntPtr Next;

	[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 16)]
	public string IpAddress;

	[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 16)]
	public string IpMask;

	public uint Context;
}
