using System;

namespace Mono.Math.Prime;

internal sealed class PrimalityTests
{
	private static int GetSPPRounds(BigInteger bi, ConfidenceFactor confidence)
	{
		int num = bi.BitCount();
		int num2;
		if (num <= 100)
		{
			num2 = 27;
		}
		else if (num <= 150)
		{
			num2 = 18;
		}
		else if (num <= 200)
		{
			num2 = 15;
		}
		else if (num <= 250)
		{
			num2 = 12;
		}
		else if (num <= 300)
		{
			num2 = 9;
		}
		else if (num <= 350)
		{
			num2 = 8;
		}
		else if (num <= 400)
		{
			num2 = 7;
		}
		else if (num <= 500)
		{
			num2 = 6;
		}
		else if (num <= 600)
		{
			num2 = 5;
		}
		else if (num <= 800)
		{
			num2 = 4;
		}
		else
		{
			num2 = ((num > 1250) ? 2 : 3);
		}
		switch (confidence)
		{
		case ConfidenceFactor.ExtraLow:
			num2 >>= 2;
			if (num2 == 0)
			{
				return 1;
			}
			return num2;
		case ConfidenceFactor.Low:
			num2 >>= 1;
			if (num2 == 0)
			{
				return 1;
			}
			return num2;
		case ConfidenceFactor.Medium:
			return num2;
		case ConfidenceFactor.High:
			return num2 << 1;
		case ConfidenceFactor.ExtraHigh:
			return num2 << 2;
		case ConfidenceFactor.Provable:
			throw new Exception("The Rabin-Miller test can not be executed in a way such that its results are provable");
		default:
			throw new ArgumentOutOfRangeException("confidence");
		}
	}

	public static bool Test(BigInteger n, ConfidenceFactor confidence)
	{
		if (n.BitCount() < 33)
		{
			return SmallPrimeSppTest(n, confidence);
		}
		return RabinMillerTest(n, confidence);
	}

	public static bool RabinMillerTest(BigInteger n, ConfidenceFactor confidence)
	{
		int num = n.BitCount();
		int sPPRounds = GetSPPRounds(num, confidence);
		BigInteger bigInteger = n - 1;
		int num2 = bigInteger.LowestSetBit();
		BigInteger bigInteger2 = bigInteger >> num2;
		BigInteger.ModulusRing modulusRing = new BigInteger.ModulusRing(n);
		BigInteger bigInteger3 = null;
		if (n.BitCount() > 100)
		{
			bigInteger3 = modulusRing.Pow(2u, bigInteger2);
		}
		for (int i = 0; i < sPPRounds; i++)
		{
			if (i > 0 || bigInteger3 == null)
			{
				BigInteger bigInteger4 = null;
				do
				{
					bigInteger4 = BigInteger.GenerateRandom(num);
				}
				while (bigInteger4 <= 2 && bigInteger4 >= bigInteger);
				bigInteger3 = modulusRing.Pow(bigInteger4, bigInteger2);
			}
			if (bigInteger3 == 1u)
			{
				continue;
			}
			for (int j = 0; j < num2; j++)
			{
				if (!(bigInteger3 != bigInteger))
				{
					break;
				}
				bigInteger3 = modulusRing.Pow(bigInteger3, 2);
				if (bigInteger3 == 1u)
				{
					return false;
				}
			}
			if (bigInteger3 != bigInteger)
			{
				return false;
			}
		}
		return true;
	}

	public static bool SmallPrimeSppTest(BigInteger bi, ConfidenceFactor confidence)
	{
		int sPPRounds = GetSPPRounds(bi, confidence);
		BigInteger bigInteger = bi - 1;
		int num = bigInteger.LowestSetBit();
		BigInteger exp = bigInteger >> num;
		BigInteger.ModulusRing modulusRing = new BigInteger.ModulusRing(bi);
		for (int i = 0; i < sPPRounds; i++)
		{
			BigInteger bigInteger2 = modulusRing.Pow(BigInteger.smallPrimes[i], exp);
			if (bigInteger2 == 1u)
			{
				continue;
			}
			bool flag = false;
			for (int j = 0; j < num; j++)
			{
				if (bigInteger2 == bigInteger)
				{
					flag = true;
					break;
				}
				bigInteger2 = bigInteger2 * bigInteger2 % bi;
			}
			if (!flag)
			{
				return false;
			}
		}
		return true;
	}
}
