using System.Runtime.InteropServices;

namespace System.Net.NetworkInformation;

internal class Win32NetworkInterface
{
	private static Win32_FIXED_INFO fixedInfo;

	private static bool initialized;

	public unsafe static Win32_FIXED_INFO FixedInfo
	{
		get
		{
			if (!initialized)
			{
				int size = 0;
				GetNetworkParams(IntPtr.Zero, ref size);
				IntPtr ptr = Marshal.AllocHGlobal(size);
				GetNetworkParams(ptr, ref size);
				Win32_FIXED_INFO_Marshal win32_FIXED_INFO_Marshal = Marshal.PtrToStructure<Win32_FIXED_INFO_Marshal>(ptr);
				fixedInfo = new Win32_FIXED_INFO
				{
					HostName = GetStringFromMultiByte(win32_FIXED_INFO_Marshal.HostName),
					DomainName = GetStringFromMultiByte(win32_FIXED_INFO_Marshal.DomainName),
					CurrentDnsServer = win32_FIXED_INFO_Marshal.CurrentDnsServer,
					DnsServerList = win32_FIXED_INFO_Marshal.DnsServerList,
					NodeType = win32_FIXED_INFO_Marshal.NodeType,
					ScopeId = GetStringFromMultiByte(win32_FIXED_INFO_Marshal.ScopeId),
					EnableRouting = win32_FIXED_INFO_Marshal.EnableRouting,
					EnableProxy = win32_FIXED_INFO_Marshal.EnableProxy,
					EnableDns = win32_FIXED_INFO_Marshal.EnableDns
				};
				initialized = true;
			}
			return fixedInfo;
			unsafe static string GetStringFromMultiByte(byte* bytes)
			{
				int num = MultiByteToWideChar(0u, 0u, bytes, -1, null, 0);
				if (num == 0)
				{
					return string.Empty;
				}
				char[] array = new char[num];
				fixed (char* lpWideCharStr = array)
				{
					MultiByteToWideChar(0u, 0u, bytes, -1, lpWideCharStr, num);
				}
				return new string(array);
			}
		}
	}

	[DllImport("iphlpapi.dll", SetLastError = true)]
	private static extern int GetNetworkParams(IntPtr ptr, ref int size);

	[DllImport("kernel32.dll", SetLastError = true)]
	private unsafe static extern int MultiByteToWideChar(uint CodePage, uint dwFlags, byte* lpMultiByteStr, int cbMultiByte, char* lpWideCharStr, int cchWideChar);
}
