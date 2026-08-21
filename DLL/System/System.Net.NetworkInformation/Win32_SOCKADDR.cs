using System.Runtime.InteropServices;

namespace System.Net.NetworkInformation;

internal struct Win32_SOCKADDR
{
	public ushort AddressFamily;

	[MarshalAs(UnmanagedType.ByValArray, SizeConst = 28)]
	public byte[] AddressData;
}
