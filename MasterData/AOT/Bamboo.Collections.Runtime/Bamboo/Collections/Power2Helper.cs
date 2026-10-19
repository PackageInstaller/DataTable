namespace Bamboo.Collections;

internal static class Power2Helper
{
	private static readonly int[] _power2;

	static Power2Helper()
	{
		_power2 = new int[17]
		{
			1, 2, 4, 8, 16, 32, 64, 128, 256, 512,
			1024, 2048, 4096, 8192, 16384, 32768, 65536
		};
	}

	public static int Get(int index)
	{
		return _power2[index];
	}
}
