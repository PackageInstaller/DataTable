using System.Runtime.InteropServices;

namespace Unity.Collections.LowLevel.Unsafe;

internal static class BurstRuntime
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	private struct HashCode64<T>
	{
		public static readonly long Value = HashStringWithFNV1A64(typeof(T).AssemblyQualifiedName);
	}

	public static long GetHashCode64<T>()
	{
		return HashCode64<T>.Value;
	}

	internal static long HashStringWithFNV1A64(string text)
	{
		ulong num = 14695981039346656037uL;
		foreach (char c in text)
		{
			num = 1099511628211L * (num ^ (byte)(c & 0xFF));
			num = 1099511628211L * (num ^ (byte)((int)c >> 8));
		}
		return (long)num;
	}
}
