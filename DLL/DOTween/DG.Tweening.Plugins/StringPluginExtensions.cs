using System.Text;
using UnityEngine;

namespace DG.Tweening.Plugins;

internal static class StringPluginExtensions
{
	public static readonly char[] ScrambledCharsAll;

	public static readonly char[] ScrambledCharsUppercase;

	public static readonly char[] ScrambledCharsLowercase;

	public static readonly char[] ScrambledCharsNumerals;

	private static int _lastRndSeed;

	static StringPluginExtensions()
	{
		ScrambledCharsAll = new char[60]
		{
			'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
			'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
			'U', 'V', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e',
			'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
			'p', 'q', 'r', 's', 't', 'u', 'v', 'x', 'y', 'z',
			'1', '2', '3', '4', '5', '6', '7', '8', '9', '0'
		};
		ScrambledCharsUppercase = new char[25]
		{
			'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
			'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
			'U', 'V', 'X', 'Y', 'Z'
		};
		ScrambledCharsLowercase = new char[25]
		{
			'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
			'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
			'u', 'v', 'x', 'y', 'z'
		};
		ScrambledCharsNumerals = new char[10] { '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' };
		ScrambledCharsAll.ScrambleChars();
		ScrambledCharsUppercase.ScrambleChars();
		ScrambledCharsLowercase.ScrambleChars();
		ScrambledCharsNumerals.ScrambleChars();
	}

	internal static void ScrambleChars(this char[] chars)
	{
		int num = chars.Length;
		for (int i = 0; i < num; i++)
		{
			char c = chars[i];
			int num2 = Random.Range(i, num);
			chars[i] = chars[num2];
			chars[num2] = c;
		}
	}

	internal static StringBuilder AppendScrambledChars(this StringBuilder buffer, int length, char[] chars)
	{
		if (length <= 0)
		{
			return buffer;
		}
		int num = chars.Length;
		int num2;
		for (num2 = _lastRndSeed; num2 == _lastRndSeed; num2 = Random.Range(0, num))
		{
		}
		_lastRndSeed = num2;
		for (int i = 0; i < length; i++)
		{
			if (num2 >= num)
			{
				num2 = 0;
			}
			buffer.Append(chars[num2]);
			num2++;
		}
		return buffer;
	}
}
