using System;
using System.Runtime.InteropServices;

namespace CriAtomDebugDetail;

public class Utility
{
	public static string PtrToStringAutoOrNull(IntPtr stringPtr)
	{
		if (!(stringPtr == IntPtr.Zero))
		{
			return Marshal.PtrToStringAnsi(stringPtr);
		}
		return null;
	}
}
