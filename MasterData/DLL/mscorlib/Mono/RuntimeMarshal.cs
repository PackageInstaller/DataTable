using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;

namespace Mono;

internal static class RuntimeMarshal
{
	internal unsafe static string PtrToUtf8String(IntPtr ptr)
	{
		if (ptr == IntPtr.Zero)
		{
			return string.Empty;
		}
		byte* ptr2 = (byte*)(void*)ptr;
		int num = 0;
		try
		{
			while (*(ptr2++) != 0)
			{
				num++;
			}
		}
		catch (NullReferenceException)
		{
			throw new ArgumentOutOfRangeException("ptr", "Value does not refer to a valid string.");
		}
		return new string((sbyte*)(void*)ptr, 0, num, Encoding.UTF8);
	}

	internal static SafeStringMarshal MarshalString(string str)
	{
		return new SafeStringMarshal(str);
	}

	private unsafe static int DecodeBlobSize(IntPtr in_ptr, out IntPtr out_ptr)
	{
		byte* ptr = (byte*)(void*)in_ptr;
		uint result;
		if ((*ptr & 0x80) == 0)
		{
			result = (uint)(*ptr & 0x7F);
			ptr++;
		}
		else if ((*ptr & 0x40) == 0)
		{
			result = (uint)(((*ptr & 0x3F) << 8) + ptr[1]);
			ptr += 2;
		}
		else
		{
			result = (uint)(((*ptr & 0x1F) << 24) + (ptr[1] << 16) + (ptr[2] << 8) + ptr[3]);
			ptr += 4;
		}
		out_ptr = (IntPtr)ptr;
		return (int)result;
	}

	internal static byte[] DecodeBlobArray(IntPtr ptr)
	{
		int num = DecodeBlobSize(ptr, out var out_ptr);
		byte[] array = new byte[num];
		Marshal.Copy(out_ptr, array, 0, num);
		return array;
	}

	internal static int AsciHexDigitValue(int c)
	{
		if (c >= 48 && c <= 57)
		{
			return c - 48;
		}
		if (c >= 97 && c <= 102)
		{
			return c - 97 + 10;
		}
		return c - 65 + 10;
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern void FreeAssemblyName(ref MonoAssemblyName name, bool freeStruct);
}
