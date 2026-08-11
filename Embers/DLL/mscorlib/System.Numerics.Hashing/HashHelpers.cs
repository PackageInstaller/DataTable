namespace System.Numerics.Hashing;

internal static class HashHelpers
{
	public static readonly int RandomSeed = new Random().Next(int.MinValue, int.MaxValue);

	public static int Combine(int h1, int h2)
	{
		return (((h1 << 5) | (h1 >>> 27)) + h1) ^ h2;
	}
}
