public class DRandom
{
	private const uint addValue = 12345u;

	public static uint callNum = 0u;

	private const uint maxShort = 65536u;

	private const uint multiper = 1194211693u;

	private static uint nSeed = 100u;

	public static float fRandom()
	{
		callNum++;
		return (float)Random(65536u) / 65536f;
	}

	public static int GetSeed()
	{
		return (int)nSeed;
	}

	public static uint Random(uint nMax)
	{
		callNum++;
		nSeed = nSeed * 1194211693 + 12345;
		return nSeed % nMax;
	}

	public static void ResetSeed(uint seed)
	{
		nSeed = seed;
		callNum = 0u;
	}
}
