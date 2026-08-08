using System;
using System.Runtime.InteropServices;

namespace Mono.Btls;

internal static class MonoBtlsError
{
	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_error_clear_error();

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_error_get_error_line(out IntPtr file, out int line);

	[DllImport("libmono-btls-shared")]
	private static extern void mono_btls_error_get_error_string_n(int error, IntPtr buf, int len);

	[DllImport("libmono-btls-shared")]
	private static extern int mono_btls_error_get_reason(int error);

	public static void ClearError()
	{
		mono_btls_error_clear_error();
	}

	public static string GetErrorString(int error)
	{
		int num = 1024;
		IntPtr intPtr = Marshal.AllocHGlobal(num);
		if (intPtr == IntPtr.Zero)
		{
			throw new OutOfMemoryException();
		}
		try
		{
			mono_btls_error_get_error_string_n(error, intPtr, num);
			return Marshal.PtrToStringAnsi(intPtr);
		}
		finally
		{
			Marshal.FreeHGlobal(intPtr);
		}
	}

	public static int GetError(out string file, out int line)
	{
		int result = mono_btls_error_get_error_line(out var file2, out line);
		if (file2 != IntPtr.Zero)
		{
			file = Marshal.PtrToStringAnsi(file2);
			return result;
		}
		file = null;
		return result;
	}

	public static int GetErrorReason(int error)
	{
		return mono_btls_error_get_reason(error);
	}
}
