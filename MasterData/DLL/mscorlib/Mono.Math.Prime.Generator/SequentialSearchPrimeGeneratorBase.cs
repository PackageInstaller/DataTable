namespace Mono.Math.Prime.Generator;

internal class SequentialSearchPrimeGeneratorBase : PrimeGeneratorBase
{
	protected virtual BigInteger GenerateSearchBase(int bits, object context)
	{
		BigInteger bigInteger = BigInteger.GenerateRandom(bits);
		bigInteger.SetBit(0u);
		return bigInteger;
	}

	public override BigInteger GenerateNewPrime(int bits)
	{
		return GenerateNewPrime(bits, null);
	}

	public virtual BigInteger GenerateNewPrime(int bits, object context)
	{
		BigInteger bigInteger = GenerateSearchBase(bits, context);
		uint num = bigInteger % 3234846615u;
		int trialDivisionBounds = TrialDivisionBounds;
		uint[] smallPrimes = BigInteger.smallPrimes;
		while (true)
		{
			if (num % 3 != 0 && num % 5 != 0 && num % 7 != 0 && num % 11 != 0 && num % 13 != 0 && num % 17 != 0 && num % 19 != 0 && num % 23 != 0 && num % 29 != 0)
			{
				int num2 = 10;
				while (true)
				{
					if (num2 < smallPrimes.Length && smallPrimes[num2] <= trialDivisionBounds)
					{
						if (bigInteger % smallPrimes[num2] == 0)
						{
							break;
						}
						num2++;
						continue;
					}
					if (!IsPrimeAcceptable(bigInteger, context) || !PrimalityTest(bigInteger, Confidence))
					{
						break;
					}
					return bigInteger;
				}
			}
			num += 2;
			if (num >= 3234846615u)
			{
				num -= 3234846615u;
			}
			bigInteger.Incr2();
		}
	}

	protected virtual bool IsPrimeAcceptable(BigInteger bi, object context)
	{
		return true;
	}
}
