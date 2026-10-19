namespace Bamboo.Pool;

internal static class HashHelper
{
	private static readonly int _maxBit;

	private static readonly int[] _primes;

	static HashHelper()
	{
		_primes = new int[46]
		{
			3, 7, 11, 17, 23, 29, 37, 47, 59, 71,
			89, 107, 131, 163, 197, 239, 293, 353, 431, 521,
			631, 761, 919, 1103, 1327, 1597, 1931, 2333, 2801, 3371,
			4049, 4861, 5839, 7013, 8419, 10103, 12143, 14591, 17519, 21023,
			25229, 30293, 36353, 43627, 52361, 62851
		};
		_maxBit = _primes.Length - 1;
	}

	public static int GetBit(int length)
	{
		for (int i = 0; i <= _maxBit; i++)
		{
			int prime = GetPrime(i);
			if (length <= prime)
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
			int prime = GetPrime(i);
			if (alignSize <= prime)
			{
				if (alignSize != prime)
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
			int prime = GetPrime(i);
			if (length <= prime)
			{
				return prime;
			}
		}
		return length;
	}

	public static int GetPrime(int length)
	{
		for (int i = 0; i <= _maxBit; i++)
		{
			int num = _primes[i];
			if (num >= length)
			{
				return num;
			}
		}
		return length;
	}
}
