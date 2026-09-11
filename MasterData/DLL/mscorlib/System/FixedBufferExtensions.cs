using System.Runtime.InteropServices;

namespace System;

internal static class FixedBufferExtensions
{
	internal unsafe static string GetStringFromFixedBuffer(this ReadOnlySpan<char> span)
	{
		fixed (char* reference = &MemoryMarshal.GetReference(span))
		{
			return new string(reference, 0, span.GetFixedBufferStringLength());
		}
	}

	internal static int GetFixedBufferStringLength(this ReadOnlySpan<char> span)
	{
		int num = span.IndexOf('\0');
		if (num >= 0)
		{
			return num;
		}
		return span.Length;
	}

	internal static bool FixedBufferEqualsString(this ReadOnlySpan<char> span, string value)
	{
		if (value == null || value.Length > span.Length)
		{
			return false;
		}
		int i;
		for (i = 0; i < value.Length; i++)
		{
			if (value[i] == '\0' || value[i] != span[i])
			{
				return false;
			}
		}
		if (i != span.Length)
		{
			return span[i] == '\0';
		}
		return true;
	}
}
