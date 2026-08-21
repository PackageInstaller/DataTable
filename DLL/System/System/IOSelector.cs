using System.Runtime.CompilerServices;

namespace System;

internal static class IOSelector
{
	[MethodImpl((MethodImplOptions)4096)]
	public static extern void Add(IntPtr handle, IOSelectorJob job);
}
