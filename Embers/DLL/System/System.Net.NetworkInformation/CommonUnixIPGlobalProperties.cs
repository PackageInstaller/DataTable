using System.Runtime.InteropServices;
using System.Text;

namespace System.Net.NetworkInformation;

internal abstract class CommonUnixIPGlobalProperties : IPGlobalProperties
{
	public override string DomainName
	{
		get
		{
			byte[] array = new byte[256];
			try
			{
				if (getdomainname(array, 256) != 0)
				{
					throw new NetworkInformationException();
				}
			}
			catch (EntryPointNotFoundException)
			{
				return string.Empty;
			}
			int num = Array.IndexOf(array, (byte)0);
			return Encoding.ASCII.GetString(array, 0, (num < 0) ? 256 : num);
		}
	}

	[DllImport("libc")]
	private static extern int getdomainname([MarshalAs(UnmanagedType.LPArray, SizeParamIndex = 1)] byte[] name, int len);
}
