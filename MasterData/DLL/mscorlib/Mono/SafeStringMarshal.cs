using System;
using System.Runtime.CompilerServices;

namespace Mono;

internal struct SafeStringMarshal : IDisposable
{
	private readonly string str;

	private IntPtr marshaled_string;

	public IntPtr Value
	{
		get
		{
			if (marshaled_string == IntPtr.Zero && str != null)
			{
				marshaled_string = StringToUtf8(str);
			}
			return marshaled_string;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern IntPtr StringToUtf8_icall(ref string str);

	public static IntPtr StringToUtf8(string str)
	{
		return StringToUtf8_icall(ref str);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void GFree(IntPtr ptr);

	public SafeStringMarshal(string str)
	{
		this.str = str;
		marshaled_string = IntPtr.Zero;
	}

	public void Dispose()
	{
		if (marshaled_string != IntPtr.Zero)
		{
			GFree(marshaled_string);
			marshaled_string = IntPtr.Zero;
		}
	}
}
