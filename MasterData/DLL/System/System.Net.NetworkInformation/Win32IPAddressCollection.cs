using System.Runtime.InteropServices;

namespace System.Net.NetworkInformation;

internal class Win32IPAddressCollection : IPAddressCollection
{
	public static readonly Win32IPAddressCollection Empty = new Win32IPAddressCollection(IntPtr.Zero);

	private Win32IPAddressCollection()
	{
	}

	public Win32IPAddressCollection(params IntPtr[] heads)
	{
		foreach (IntPtr head in heads)
		{
			AddSubsequentlyString(head);
		}
	}

	public static Win32IPAddressCollection FromDnsServer(IntPtr ptr)
	{
		Win32IPAddressCollection win32IPAddressCollection = new Win32IPAddressCollection();
		IntPtr intPtr = ptr;
		while (intPtr != IntPtr.Zero)
		{
			Win32_IP_ADAPTER_DNS_SERVER_ADDRESS win32_IP_ADAPTER_DNS_SERVER_ADDRESS = (Win32_IP_ADAPTER_DNS_SERVER_ADDRESS)Marshal.PtrToStructure(intPtr, typeof(Win32_IP_ADAPTER_DNS_SERVER_ADDRESS));
			win32IPAddressCollection.InternalAdd(win32_IP_ADAPTER_DNS_SERVER_ADDRESS.Address.GetIPAddress());
			intPtr = win32_IP_ADAPTER_DNS_SERVER_ADDRESS.Next;
		}
		return win32IPAddressCollection;
	}

	private void AddSubsequentlyString(IntPtr head)
	{
		IntPtr intPtr = head;
		while (intPtr != IntPtr.Zero)
		{
			Win32_IP_ADDR_STRING win32_IP_ADDR_STRING = (Win32_IP_ADDR_STRING)Marshal.PtrToStructure(intPtr, typeof(Win32_IP_ADDR_STRING));
			InternalAdd(IPAddress.Parse(win32_IP_ADDR_STRING.IpAddress));
			intPtr = win32_IP_ADDR_STRING.Next;
		}
	}
}
