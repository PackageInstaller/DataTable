using System.Globalization;
using System.Text;

namespace Sirenix.Serialization.Utilities;

internal static class StringExtensions
{
	public static string ToTitleCase(this string input)
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < input.Length; i++)
		{
			char c = input[i];
			if (c == '_' && i + 1 < input.Length)
			{
				char c2 = input[i + 1];
				if (char.IsLower(c2))
				{
					c2 = char.ToUpper(c2, CultureInfo.InvariantCulture);
				}
				stringBuilder.Append(c2);
				i++;
			}
			else
			{
				stringBuilder.Append(c);
			}
		}
		return stringBuilder.ToString();
	}

	public static bool IsNullOrWhitespace(this string str)
	{
		if (!string.IsNullOrEmpty(str))
		{
			for (int i = 0; i < str.Length; i++)
			{
				if (!char.IsWhiteSpace(str[i]))
				{
					return false;
				}
			}
		}
		return true;
	}
}
