using System.Runtime.CompilerServices;

namespace System.Runtime;

public static class RuntimeImports
{
	internal unsafe static void RhZeroMemory(ref byte b, ulong byteLength)
	{
		fixed (byte* p = &b)
		{
			ZeroMemory(p, (uint)byteLength);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void ZeroMemory(void* p, uint byteLength);

	[MethodImpl((MethodImplOptions)4096)]
	internal unsafe static extern void Memmove(byte* dest, byte* src, uint len);

	[MethodImpl((MethodImplOptions)4096)]
	internal unsafe static extern void Memmove_wbarrier(byte* dest, byte* src, uint len, IntPtr type_handle);

	[MethodImpl((MethodImplOptions)4096)]
	internal unsafe static extern void _ecvt_s(byte* buffer, int sizeInBytes, double value, int count, int* dec, int* sign);
}
