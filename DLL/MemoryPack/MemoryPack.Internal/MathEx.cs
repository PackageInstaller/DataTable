using System.Runtime.CompilerServices;

namespace MemoryPack.Internal;

internal static class MathEx
{
	private const int ArrayMexLength = 2147483591;

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	public static int NewArrayCapacity(int size)
	{
		int num = size * 2;
		if ((uint)num > 2147483591u)
		{
			num = 2147483591;
		}
		return num;
	}
}
