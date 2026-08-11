using System.Runtime.CompilerServices;

namespace System.Threading;

public static class Volatile
{
	private struct VolatileBoolean
	{
		public volatile bool Value;
	}

	private struct VolatileInt32
	{
		public volatile int Value;
	}

	private struct VolatileObject
	{
		public volatile object Value;
	}

	[Intrinsic]
	public static bool Read(ref bool location)
	{
		return Unsafe.As<bool, VolatileBoolean>(ref location).Value;
	}

	[Intrinsic]
	public static void Write(ref bool location, bool value)
	{
		Unsafe.As<bool, VolatileBoolean>(ref location).Value = value;
	}

	[Intrinsic]
	public static int Read(ref int location)
	{
		return Unsafe.As<int, VolatileInt32>(ref location).Value;
	}

	[Intrinsic]
	public static void Write(ref int location, int value)
	{
		Unsafe.As<int, VolatileInt32>(ref location).Value = value;
	}

	[Intrinsic]
	public static T Read<T>(ref T location) where T : class
	{
		return Unsafe.As<T>(Unsafe.As<T, VolatileObject>(ref location).Value);
	}

	[Intrinsic]
	public static void Write<T>(ref T location, T value) where T : class
	{
		Unsafe.As<T, VolatileObject>(ref location).Value = value;
	}
}
