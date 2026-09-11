using System.Security.Cryptography;

namespace Mono.Security.Cryptography;

internal sealed class KeyBuilder
{
	private static RandomNumberGenerator rng;

	private static RandomNumberGenerator Rng
	{
		get
		{
			if (rng == null)
			{
				rng = RandomNumberGenerator.Create();
			}
			return rng;
		}
	}

	public static byte[] Key(int size)
	{
		byte[] array = new byte[size];
		Rng.GetBytes(array);
		return array;
	}

	public static byte[] IV(int size)
	{
		byte[] array = new byte[size];
		Rng.GetBytes(array);
		return array;
	}
}
