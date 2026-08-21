using System.Collections.Generic;
using System.Text;

namespace System.Globalization;

internal class DateTimeFormatInfoScanner
{
	private enum FoundDatePattern
	{
		None = 0,
		FoundYearPatternFlag = 1,
		FoundMonthPatternFlag = 2,
		FoundDayPatternFlag = 4,
		FoundYMDPatternFlag = 7
	}

	internal List<string> m_dateWords = new List<string>();

	private static volatile Dictionary<string, string> s_knownWords;

	private FoundDatePattern _ymdFlags;

	private static Dictionary<string, string> KnownWords
	{
		get
		{
			if (s_knownWords == null)
			{
				s_knownWords = new Dictionary<string, string>
				{
					{
						"/",
						string.Empty
					},
					{
						"-",
						string.Empty
					},
					{
						".",
						string.Empty
					},
					{
						"年",
						string.Empty
					},
					{
						"月",
						string.Empty
					},
					{
						"日",
						string.Empty
					},
					{
						"년",
						string.Empty
					},
					{
						"월",
						string.Empty
					},
					{
						"일",
						string.Empty
					},
					{
						"시",
						string.Empty
					},
					{
						"분",
						string.Empty
					},
					{
						"초",
						string.Empty
					},
					{
						"時",
						string.Empty
					},
					{
						"时",
						string.Empty
					},
					{
						"分",
						string.Empty
					},
					{
						"秒",
						string.Empty
					}
				};
			}
			return s_knownWords;
		}
	}

	internal static int SkipWhiteSpacesAndNonLetter(string pattern, int currentIndex)
	{
		while (currentIndex < pattern.Length)
		{
			char c = pattern[currentIndex];
			if (c == '\\')
			{
				currentIndex++;
				if (currentIndex >= pattern.Length)
				{
					break;
				}
				c = pattern[currentIndex];
				if (c == '\'')
				{
					continue;
				}
			}
			if (char.IsLetter(c) || c == '\'' || c == '.')
			{
				break;
			}
			currentIndex++;
		}
		return currentIndex;
	}

	internal void AddDateWordOrPostfix(string formatPostfix, string str)
	{
		if (str.Length <= 0)
		{
			return;
		}
		if (str.Equals("."))
		{
			AddIgnorableSymbols(".");
		}
		else
		{
			if (KnownWords.TryGetValue(str, out var _))
			{
				return;
			}
			if (m_dateWords == null)
			{
				m_dateWords = new List<string>();
			}
			if (formatPostfix == "MMMM")
			{
				string item = "\ue000" + str;
				if (!m_dateWords.Contains(item))
				{
					m_dateWords.Add(item);
				}
				return;
			}
			if (!m_dateWords.Contains(str))
			{
				m_dateWords.Add(str);
			}
			if (str[str.Length - 1] == '.')
			{
				string item2 = str.Substring(0, str.Length - 1);
				if (!m_dateWords.Contains(item2))
				{
					m_dateWords.Add(item2);
				}
			}
		}
	}

	internal int AddDateWords(string pattern, int index, string formatPostfix)
	{
		int num = SkipWhiteSpacesAndNonLetter(pattern, index);
		if (num != index && formatPostfix != null)
		{
			formatPostfix = null;
		}
		index = num;
		StringBuilder stringBuilder = new StringBuilder();
		while (index < pattern.Length)
		{
			char c = pattern[index];
			switch (c)
			{
			case '\'':
				break;
			case '\\':
				index++;
				if (index < pattern.Length)
				{
					stringBuilder.Append(pattern[index]);
					index++;
				}
				continue;
			default:
				if (char.IsWhiteSpace(c))
				{
					AddDateWordOrPostfix(formatPostfix, stringBuilder.ToString());
					if (formatPostfix != null)
					{
						formatPostfix = null;
					}
					stringBuilder.Length = 0;
					index++;
				}
				else
				{
					stringBuilder.Append(c);
					index++;
				}
				continue;
			}
			AddDateWordOrPostfix(formatPostfix, stringBuilder.ToString());
			index++;
			break;
		}
		return index;
	}

	internal static int ScanRepeatChar(string pattern, char ch, int index, out int count)
	{
		count = 1;
		while (++index < pattern.Length && pattern[index] == ch)
		{
			count++;
		}
		return index;
	}

	internal void AddIgnorableSymbols(string text)
	{
		if (m_dateWords == null)
		{
			m_dateWords = new List<string>();
		}
		string item = "\ue001" + text;
		if (!m_dateWords.Contains(item))
		{
			m_dateWords.Add(item);
		}
	}

	internal void ScanDateWord(string pattern)
	{
		_ymdFlags = FoundDatePattern.None;
		int num = 0;
		while (num < pattern.Length)
		{
			char c = pattern[num];
			int count;
			switch (c)
			{
			case '\'':
				num = AddDateWords(pattern, num + 1, null);
				break;
			case 'M':
				num = ScanRepeatChar(pattern, 'M', num, out count);
				if (count >= 4 && num < pattern.Length && pattern[num] == '\'')
				{
					num = AddDateWords(pattern, num + 1, "MMMM");
				}
				_ymdFlags |= FoundDatePattern.FoundMonthPatternFlag;
				break;
			case 'y':
				num = ScanRepeatChar(pattern, 'y', num, out count);
				_ymdFlags |= FoundDatePattern.FoundYearPatternFlag;
				break;
			case 'd':
				num = ScanRepeatChar(pattern, 'd', num, out count);
				if (count <= 2)
				{
					_ymdFlags |= FoundDatePattern.FoundDayPatternFlag;
				}
				break;
			case '\\':
				num += 2;
				break;
			case '.':
				if (_ymdFlags == FoundDatePattern.FoundYMDPatternFlag)
				{
					AddIgnorableSymbols(".");
					_ymdFlags = FoundDatePattern.None;
				}
				num++;
				break;
			default:
				if (_ymdFlags == FoundDatePattern.FoundYMDPatternFlag && !char.IsWhiteSpace(c))
				{
					_ymdFlags = FoundDatePattern.None;
				}
				num++;
				break;
			}
		}
	}

	internal string[] GetDateWordsOfDTFI(DateTimeFormatInfo dtfi)
	{
		string[] allDateTimePatterns = dtfi.GetAllDateTimePatterns('D');
		for (int i = 0; i < allDateTimePatterns.Length; i++)
		{
			ScanDateWord(allDateTimePatterns[i]);
		}
		allDateTimePatterns = dtfi.GetAllDateTimePatterns('d');
		for (int i = 0; i < allDateTimePatterns.Length; i++)
		{
			ScanDateWord(allDateTimePatterns[i]);
		}
		allDateTimePatterns = dtfi.GetAllDateTimePatterns('y');
		for (int i = 0; i < allDateTimePatterns.Length; i++)
		{
			ScanDateWord(allDateTimePatterns[i]);
		}
		ScanDateWord(dtfi.MonthDayPattern);
		allDateTimePatterns = dtfi.GetAllDateTimePatterns('T');
		for (int i = 0; i < allDateTimePatterns.Length; i++)
		{
			ScanDateWord(allDateTimePatterns[i]);
		}
		allDateTimePatterns = dtfi.GetAllDateTimePatterns('t');
		for (int i = 0; i < allDateTimePatterns.Length; i++)
		{
			ScanDateWord(allDateTimePatterns[i]);
		}
		string[] array = null;
		if (m_dateWords != null && m_dateWords.Count > 0)
		{
			array = new string[m_dateWords.Count];
			for (int i = 0; i < m_dateWords.Count; i++)
			{
				array[i] = m_dateWords[i];
			}
		}
		return array;
	}

	internal static FORMATFLAGS GetFormatFlagGenitiveMonth(string[] monthNames, string[] genitveMonthNames, string[] abbrevMonthNames, string[] genetiveAbbrevMonthNames)
	{
		if (EqualStringArrays(monthNames, genitveMonthNames) && EqualStringArrays(abbrevMonthNames, genetiveAbbrevMonthNames))
		{
			return FORMATFLAGS.None;
		}
		return FORMATFLAGS.UseGenitiveMonth;
	}

	internal static FORMATFLAGS GetFormatFlagUseSpaceInMonthNames(string[] monthNames, string[] genitveMonthNames, string[] abbrevMonthNames, string[] genetiveAbbrevMonthNames)
	{
		return (FORMATFLAGS)(0 | ((ArrayElementsBeginWithDigit(monthNames) || ArrayElementsBeginWithDigit(genitveMonthNames) || ArrayElementsBeginWithDigit(abbrevMonthNames) || ArrayElementsBeginWithDigit(genetiveAbbrevMonthNames)) ? 32 : 0) | ((ArrayElementsHaveSpace(monthNames) || ArrayElementsHaveSpace(genitveMonthNames) || ArrayElementsHaveSpace(abbrevMonthNames) || ArrayElementsHaveSpace(genetiveAbbrevMonthNames)) ? 4 : 0));
	}

	internal static FORMATFLAGS GetFormatFlagUseSpaceInDayNames(string[] dayNames, string[] abbrevDayNames)
	{
		if (!ArrayElementsHaveSpace(dayNames) && !ArrayElementsHaveSpace(abbrevDayNames))
		{
			return FORMATFLAGS.None;
		}
		return FORMATFLAGS.UseSpacesInDayNames;
	}

	internal static FORMATFLAGS GetFormatFlagUseHebrewCalendar(int calID)
	{
		if (calID != 8)
		{
			return FORMATFLAGS.None;
		}
		return (FORMATFLAGS)10;
	}

	private static bool EqualStringArrays(string[] array1, string[] array2)
	{
		if (array1 == array2)
		{
			return true;
		}
		if (array1.Length != array2.Length)
		{
			return false;
		}
		for (int i = 0; i < array1.Length; i++)
		{
			if (!array1[i].Equals(array2[i]))
			{
				return false;
			}
		}
		return true;
	}

	private static bool ArrayElementsHaveSpace(string[] array)
	{
		for (int i = 0; i < array.Length; i++)
		{
			for (int j = 0; j < array[i].Length; j++)
			{
				if (char.IsWhiteSpace(array[i][j]))
				{
					return true;
				}
			}
		}
		return false;
	}

	private static bool ArrayElementsBeginWithDigit(string[] array)
	{
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].Length <= 0 || array[i][0] < '0' || array[i][0] > '9')
			{
				continue;
			}
			int j;
			for (j = 1; j < array[i].Length && array[i][j] >= '0' && array[i][j] <= '9'; j++)
			{
			}
			if (j == array[i].Length)
			{
				return false;
			}
			if (j == array[i].Length - 1)
			{
				char c = array[i][j];
				if (c == '月' || c == '월')
				{
					return false;
				}
			}
			if (j == array[i].Length - 4 && array[i][j] == '\'' && array[i][j + 1] == ' ' && array[i][j + 2] == '月' && array[i][j + 3] == '\'')
			{
				return false;
			}
			return true;
		}
		return false;
	}
}
