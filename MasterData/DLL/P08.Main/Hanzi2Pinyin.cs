using Microsoft.International.Converters.PinYinConverter;

public class Hanzi2Pinyin
{
	public static string GetFirst(string str)
	{
		string text = "";
		char[] array = str.ToCharArray();
		for (int i = 0; i < array.Length; i++)
		{
			char ch = array[i];
			if (ChineseChar.IsValidChar(ch))
			{
				ChineseChar chineseChar = new ChineseChar(ch);
				string text2 = "";
				text2 += chineseChar.Pinyins[0][0];
				text += text2.ToUpper();
			}
			else
			{
				text += ch.ToString()[0];
			}
		}
		return text;
	}

	public static bool Sort(string a, string b)
	{
		int length = a.Length;
		int length2 = b.Length;
		for (int i = 0; i < length && i < length2; i++)
		{
			char c = a[i];
			char c2 = b[i];
			if (ChineseChar.IsValidChar(c) || ChineseChar.IsValidChar(c2))
			{
				if (!ChineseChar.IsValidChar(c) || !ChineseChar.IsValidChar(c2))
				{
					if (!ChineseChar.IsValidChar(c))
					{
						return false;
					}
					return true;
				}
				ChineseChar chineseChar = new ChineseChar(c);
				ChineseChar chineseChar2 = new ChineseChar(c2);
				if (chineseChar.Pinyins[0][0] != chineseChar2.Pinyins[0][0])
				{
					return chineseChar.Pinyins[0][0] < chineseChar2.Pinyins[0][0];
				}
			}
			else
			{
				if (c == c2)
				{
					continue;
				}
				if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c2 >= 'a' && c2 <= 'z') || (c2 >= 'A' && c2 <= 'Z'))
				{
					if (((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) && ((c2 >= 'a' && c2 <= 'z') || (c2 >= 'A' && c2 <= 'Z')))
					{
						char.ToUpper(c);
						char.ToUpper(c2);
						return c < c2;
					}
					if (c < 'a' || c > 'z')
					{
						if (c >= 'A')
						{
							return c <= 'Z';
						}
						return false;
					}
					return true;
				}
				return c < c2;
			}
		}
		return length < length2;
	}
}
