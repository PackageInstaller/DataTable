using System.Globalization;
using System.Text;

namespace Mono.Security.Cryptography;

internal sealed class CryptoConvert
{
	public static string ToHex(byte[] input)
	{
		if (input == null)
		{
			return null;
		}
		StringBuilder stringBuilder = new StringBuilder(input.Length * 2);
		foreach (byte b in input)
		{
			stringBuilder.Append(b.ToString("X2", CultureInfo.InvariantCulture));
		}
		return stringBuilder.ToString();
	}
}
