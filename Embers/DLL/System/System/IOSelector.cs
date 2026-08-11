using System.Runtime.CompilerServices;

namespace System;

internal static class IOSelector
{
	[MethodImpl(MethodImplOptions.InternalCall)]
	public static extern void Add(IntPtr handle, IOSelectorJob job);
}
