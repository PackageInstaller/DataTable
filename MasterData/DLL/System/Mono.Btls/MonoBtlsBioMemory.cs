using System;
using System.Runtime.InteropServices;

namespace Mono.Btls;

internal class MonoBtlsBioMemory : MonoBtlsBio
{
	[DllImport("libmono-btls-shared")]
	private static extern IntPtr mono_btls_bio_mem_new();

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_bio_mem_get_data(IntPtr handle, out IntPtr data);

	public MonoBtlsBioMemory()
		: base(new BoringBioHandle(mono_btls_bio_mem_new()))
	{
	}

	public byte[] GetData()
	{
		bool success = false;
		try
		{
			base.Handle.DangerousAddRef(ref success);
			int num = mono_btls_bio_mem_get_data(base.Handle.DangerousGetHandle(), out var data);
			CheckError(num > 0, "GetData");
			byte[] array = new byte[num];
			Marshal.Copy(data, array, 0, num);
			return array;
		}
		finally
		{
			if (success)
			{
				base.Handle.DangerousRelease();
			}
		}
	}
}
