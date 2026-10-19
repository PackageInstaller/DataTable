namespace Bamboo.Pool;

internal static class BinaryHelper
{
	private static readonly int _maxBit;

	private static readonly int[] _power2;

	static BinaryHelper()
	{
		_power2 = new int[17]
		{
			1, 2, 4, 8, 16, 32, 64, 128, 256, 512,
			1024, 2048, 4096, 8192, 16384, 32768, 65536
		};
		_maxBit = _power2.Length - 1;
	}

	public static int GetBit(int length)
	{
		for (int i = 0; i <= _maxBit; i++)
		{
			int power = GetPower2(i);
			if (length <= power)
			{
				return i;
			}
		}
		return -1;
	}

	public static int GetBitFromAlign(int alignSize)
	{
		for (int i = 0; i <= _maxBit; i++)
		{
			int power = GetPower2(i);
			if (alignSize <= power)
			{
				if (alignSize != power)
				{
					return -1;
				}
				return i;
			}
		}
		return -1;
	}

	public static int GetAlignSize(int length)
	{
		for (int i = 0; i <= _maxBit; i++)
		{
			int power = GetPower2(i);
			if (length <= power)
			{
				return power;
			}
		}
		return length;
	}

	public static int GetPower2(int index)
	{
		return _power2[index];
	}
}
