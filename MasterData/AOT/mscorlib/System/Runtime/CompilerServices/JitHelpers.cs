namespace System.Runtime.CompilerServices;

internal static class JitHelpers
{
	internal static T UnsafeCast<T>(object o) where T : class
	{
		return Array.UnsafeMov<object, T>(o);
	}

	internal static int UnsafeEnumCast<T>(T val) where T : struct
	{
		return Array.UnsafeMov<T, int>(val);
	}

	internal static long UnsafeEnumCastLong<T>(T val) where T : struct
	{
		return Array.UnsafeMov<T, long>(val);
	}
}
