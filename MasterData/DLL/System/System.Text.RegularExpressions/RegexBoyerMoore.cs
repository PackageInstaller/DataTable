using System.Globalization;

namespace System.Text.RegularExpressions;

internal sealed class RegexBoyerMoore
{
	public readonly int[] Positive;

	public readonly int[] NegativeASCII;

	public readonly int[][] NegativeUnicode;

	public readonly string Pattern;

	public readonly int LowASCII;

	public readonly int HighASCII;

	public readonly bool RightToLeft;

	public readonly bool CaseInsensitive;

	private readonly CultureInfo _culture;

	public RegexBoyerMoore(string pattern, bool caseInsensitive, bool rightToLeft, CultureInfo culture)
	{
		if (caseInsensitive)
		{
			StringBuilder stringBuilder = StringBuilderCache.Acquire(pattern.Length);
			for (int i = 0; i < pattern.Length; i++)
			{
				stringBuilder.Append(culture.TextInfo.ToLower(pattern[i]));
			}
			pattern = StringBuilderCache.GetStringAndRelease(stringBuilder);
		}
		Pattern = pattern;
		RightToLeft = rightToLeft;
		CaseInsensitive = caseInsensitive;
		_culture = culture;
		int num;
		int num2;
		int num3;
		if (!rightToLeft)
		{
			num = -1;
			num2 = pattern.Length - 1;
			num3 = 1;
		}
		else
		{
			num = pattern.Length;
			num2 = 0;
			num3 = -1;
		}
		Positive = new int[pattern.Length];
		int num4 = num2;
		char c = pattern[num4];
		Positive[num4] = num3;
		num4 -= num3;
		while (num4 != num)
		{
			if (pattern[num4] != c)
			{
				num4 -= num3;
				continue;
			}
			int num5 = num2;
			int num6 = num4;
			while (num6 != num && pattern[num5] == pattern[num6])
			{
				num6 -= num3;
				num5 -= num3;
			}
			if (Positive[num5] == 0)
			{
				Positive[num5] = num5 - num6;
			}
			num4 -= num3;
		}
		for (int num5 = num2 - num3; num5 != num; num5 -= num3)
		{
			if (Positive[num5] == 0)
			{
				Positive[num5] = num3;
			}
		}
		NegativeASCII = new int[128];
		for (int j = 0; j < 128; j++)
		{
			NegativeASCII[j] = num2 - num;
		}
		LowASCII = 127;
		HighASCII = 0;
		for (num4 = num2; num4 != num; num4 -= num3)
		{
			c = pattern[num4];
			if (c < '\u0080')
			{
				if (LowASCII > c)
				{
					LowASCII = c;
				}
				if (HighASCII < c)
				{
					HighASCII = c;
				}
				if (NegativeASCII[(uint)c] == num2 - num)
				{
					NegativeASCII[(uint)c] = num2 - num4;
				}
			}
			else
			{
				int num7 = (int)c >> 8;
				int num8 = c & 0xFF;
				if (NegativeUnicode == null)
				{
					NegativeUnicode = new int[256][];
				}
				if (NegativeUnicode[num7] == null)
				{
					int[] array = new int[256];
					for (int k = 0; k < array.Length; k++)
					{
						array[k] = num2 - num;
					}
					if (num7 == 0)
					{
						Array.Copy(NegativeASCII, 0, array, 0, 128);
						NegativeASCII = array;
					}
					NegativeUnicode[num7] = array;
				}
				if (NegativeUnicode[num7][num8] == num2 - num)
				{
					NegativeUnicode[num7][num8] = num2 - num4;
				}
			}
		}
	}

	private bool MatchPattern(string text, int index)
	{
		if (CaseInsensitive)
		{
			if (text.Length - index < Pattern.Length)
			{
				return false;
			}
			TextInfo textInfo = _culture.TextInfo;
			for (int i = 0; i < Pattern.Length; i++)
			{
				if (textInfo.ToLower(text[index + i]) != Pattern[i])
				{
					return false;
				}
			}
			return true;
		}
		return string.CompareOrdinal(Pattern, 0, text, index, Pattern.Length) == 0;
	}

	public bool IsMatch(string text, int index, int beglimit, int endlimit)
	{
		if (!RightToLeft)
		{
			if (index < beglimit || endlimit - index < Pattern.Length)
			{
				return false;
			}
			return MatchPattern(text, index);
		}
		if (index > endlimit || index - beglimit < Pattern.Length)
		{
			return false;
		}
		return MatchPattern(text, index - Pattern.Length);
	}

	public int Scan(string text, int index, int beglimit, int endlimit)
	{
		int num;
		int num2;
		int num3;
		int num4;
		int num5;
		if (!RightToLeft)
		{
			num = Pattern.Length;
			num2 = Pattern.Length - 1;
			num3 = 0;
			num4 = index + num - 1;
			num5 = 1;
		}
		else
		{
			num = -Pattern.Length;
			num2 = 0;
			num3 = -num - 1;
			num4 = index + num;
			num5 = -1;
		}
		char c = Pattern[num2];
		while (num4 < endlimit && num4 >= beglimit)
		{
			char c2 = text[num4];
			if (CaseInsensitive)
			{
				c2 = _culture.TextInfo.ToLower(c2);
			}
			int num6;
			if (c2 != c)
			{
				int[] array;
				num6 = ((c2 < '\u0080') ? NegativeASCII[(uint)c2] : ((NegativeUnicode == null || (array = NegativeUnicode[(int)c2 >> 8]) == null) ? num : array[c2 & 0xFF]));
				num4 += num6;
				continue;
			}
			int num7 = num4;
			int num8 = num2;
			do
			{
				if (num8 == num3)
				{
					if (!RightToLeft)
					{
						return num7;
					}
					return num7 + 1;
				}
				num8 -= num5;
				num7 -= num5;
				c2 = text[num7];
				if (CaseInsensitive)
				{
					c2 = _culture.TextInfo.ToLower(c2);
				}
			}
			while (c2 == Pattern[num8]);
			num6 = Positive[num8];
			if ((c2 & 0xFF80) == 0)
			{
				num7 = num8 - num2 + NegativeASCII[(uint)c2];
			}
			else
			{
				int[] array;
				if (NegativeUnicode == null || (array = NegativeUnicode[(int)c2 >> 8]) == null)
				{
					num4 += num6;
					continue;
				}
				num7 = num8 - num2 + array[c2 & 0xFF];
			}
			if (RightToLeft ? (num7 < num6) : (num7 > num6))
			{
				num6 = num7;
			}
			num4 += num6;
		}
		return -1;
	}
}
