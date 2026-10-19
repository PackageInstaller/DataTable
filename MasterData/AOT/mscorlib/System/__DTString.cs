using System.Globalization;
using System.Runtime.CompilerServices;

namespace System;

internal ref struct __DTString
{
	internal ReadOnlySpan<char> Value;

	internal int Index;

	internal char m_current;

	private CompareInfo m_info;

	private bool m_checkDigitToken;

	private static readonly char[] WhiteSpaceChecks = new char[2] { ' ', '\u00a0' };

	internal int Length => Value.Length;

	internal CompareInfo CompareInfo => m_info;

	internal __DTString(ReadOnlySpan<char> str, DateTimeFormatInfo dtfi, bool checkDigitToken)
		: this(str, dtfi)
	{
		m_checkDigitToken = checkDigitToken;
	}

	internal __DTString(ReadOnlySpan<char> str, DateTimeFormatInfo dtfi)
	{
		Index = -1;
		Value = str;
		m_current = '\0';
		if (dtfi != null)
		{
			m_info = dtfi.CompareInfo;
			m_checkDigitToken = (dtfi.FormatFlags & DateTimeFormatFlags.UseDigitPrefixInTokens) != 0;
		}
		else
		{
			m_info = CultureInfo.CurrentCulture.CompareInfo;
			m_checkDigitToken = false;
		}
	}

	internal bool GetNext()
	{
		Index++;
		if (Index < Length)
		{
			m_current = Value[Index];
			return true;
		}
		return false;
	}

	internal bool AtEnd()
	{
		if (Index >= Length)
		{
			return true;
		}
		return false;
	}

	internal bool Advance(int count)
	{
		Index += count;
		if (Index < Length)
		{
			m_current = Value[Index];
			return true;
		}
		return false;
	}

	internal void GetRegularToken(out TokenType tokenType, out int tokenValue, DateTimeFormatInfo dtfi)
	{
		tokenValue = 0;
		if (Index >= Length)
		{
			tokenType = TokenType.EndOfString;
			return;
		}
		tokenType = TokenType.UnknownToken;
		while (true)
		{
			if (DateTimeParse.IsDigit(m_current))
			{
				tokenValue = m_current - 48;
				int index = Index;
				while (++Index < Length)
				{
					m_current = Value[Index];
					int num = m_current - 48;
					if (num < 0 || num > 9)
					{
						break;
					}
					tokenValue = tokenValue * 10 + num;
				}
				if (Index - index > 8)
				{
					tokenType = TokenType.NumberToken;
					tokenValue = -1;
				}
				else if (Index - index < 3)
				{
					tokenType = TokenType.NumberToken;
				}
				else
				{
					tokenType = TokenType.YearNumberToken;
				}
				if (m_checkDigitToken)
				{
					int index2 = Index;
					char current = m_current;
					Index = index;
					m_current = Value[Index];
					if (dtfi.Tokenize(TokenType.RegularTokenMask, out var tokenType2, out var tokenValue2, ref this))
					{
						tokenType = tokenType2;
						tokenValue = tokenValue2;
					}
					else
					{
						Index = index2;
						m_current = current;
					}
				}
				break;
			}
			if (char.IsWhiteSpace(m_current))
			{
				do
				{
					if (++Index < Length)
					{
						m_current = Value[Index];
						continue;
					}
					tokenType = TokenType.EndOfString;
					return;
				}
				while (char.IsWhiteSpace(m_current));
				continue;
			}
			dtfi.Tokenize(TokenType.RegularTokenMask, out tokenType, out tokenValue, ref this);
			break;
		}
	}

	internal TokenType GetSeparatorToken(DateTimeFormatInfo dtfi, out int indexBeforeSeparator, out char charBeforeSeparator)
	{
		indexBeforeSeparator = Index;
		charBeforeSeparator = m_current;
		if (!SkipWhiteSpaceCurrent())
		{
			return TokenType.SEP_End;
		}
		TokenType tokenType;
		if (!DateTimeParse.IsDigit(m_current))
		{
			if (!dtfi.Tokenize(TokenType.SeparatorTokenMask, out tokenType, out var _, ref this))
			{
				tokenType = TokenType.SEP_Space;
				return tokenType;
			}
			return tokenType;
		}
		tokenType = TokenType.SEP_Space;
		return tokenType;
	}

	[MethodImpl((MethodImplOptions)256)]
	internal bool MatchSpecifiedWord(string target)
	{
		if (Index + target.Length <= Length)
		{
			return m_info.Compare(Value.Slice(Index, target.Length), target, CompareOptions.IgnoreCase) == 0;
		}
		return false;
	}

	internal bool MatchSpecifiedWords(string target, bool checkWordBoundary, ref int matchLength)
	{
		int num = Value.Length - Index;
		matchLength = target.Length;
		if (matchLength > num || m_info.Compare(Value.Slice(Index, matchLength), target, CompareOptions.IgnoreCase) != 0)
		{
			int num2 = 0;
			int num3 = Index;
			int num4 = target.IndexOfAny(WhiteSpaceChecks, num2);
			if (num4 == -1)
			{
				return false;
			}
			do
			{
				int num5 = num4 - num2;
				if (num3 >= Value.Length - num5)
				{
					return false;
				}
				if (num5 == 0)
				{
					matchLength--;
				}
				else
				{
					if (!char.IsWhiteSpace(Value[num3 + num5]))
					{
						return false;
					}
					if (m_info.CompareOptionIgnoreCase(Value.Slice(num3, num5), target.AsSpan(num2, num5)) != 0)
					{
						return false;
					}
					num3 = num3 + num5 + 1;
				}
				num2 = num4 + 1;
				while (num3 < Value.Length && char.IsWhiteSpace(Value[num3]))
				{
					num3++;
					matchLength++;
				}
			}
			while ((num4 = target.IndexOfAny(WhiteSpaceChecks, num2)) >= 0);
			if (num2 < target.Length)
			{
				int num6 = target.Length - num2;
				if (num3 > Value.Length - num6)
				{
					return false;
				}
				if (m_info.CompareOptionIgnoreCase(Value.Slice(num3, num6), target.AsSpan(num2, num6)) != 0)
				{
					return false;
				}
			}
		}
		if (checkWordBoundary)
		{
			int num7 = Index + matchLength;
			if (num7 < Value.Length && char.IsLetter(Value[num7]))
			{
				return false;
			}
		}
		return true;
	}

	internal bool Match(string str)
	{
		if (++Index >= Length)
		{
			return false;
		}
		if (str.Length > Value.Length - Index)
		{
			return false;
		}
		if (m_info.Compare(Value.Slice(Index, str.Length), str, CompareOptions.Ordinal) == 0)
		{
			Index += str.Length - 1;
			return true;
		}
		return false;
	}

	internal bool Match(char ch)
	{
		if (++Index >= Length)
		{
			return false;
		}
		if (Value[Index] == ch)
		{
			m_current = ch;
			return true;
		}
		Index--;
		return false;
	}

	internal int MatchLongestWords(string[] words, ref int maxMatchStrLen)
	{
		int result = -1;
		for (int i = 0; i < words.Length; i++)
		{
			string text = words[i];
			int matchLength = text.Length;
			if (MatchSpecifiedWords(text, checkWordBoundary: false, ref matchLength) && matchLength > maxMatchStrLen)
			{
				maxMatchStrLen = matchLength;
				result = i;
			}
		}
		return result;
	}

	internal int GetRepeatCount()
	{
		char c = Value[Index];
		int i;
		for (i = Index + 1; i < Length && Value[i] == c; i++)
		{
		}
		int result = i - Index;
		Index = i - 1;
		return result;
	}

	[MethodImpl((MethodImplOptions)256)]
	internal bool GetNextDigit()
	{
		if (++Index < Length)
		{
			return DateTimeParse.IsDigit(Value[Index]);
		}
		return false;
	}

	internal char GetChar()
	{
		return Value[Index];
	}

	internal int GetDigit()
	{
		return Value[Index] - 48;
	}

	internal void SkipWhiteSpaces()
	{
		while (Index + 1 < Length && char.IsWhiteSpace(Value[Index + 1]))
		{
			Index++;
		}
	}

	internal bool SkipWhiteSpaceCurrent()
	{
		if (Index >= Length)
		{
			return false;
		}
		if (!char.IsWhiteSpace(m_current))
		{
			return true;
		}
		while (++Index < Length)
		{
			m_current = Value[Index];
			if (!char.IsWhiteSpace(m_current))
			{
				return true;
			}
		}
		return false;
	}

	internal void TrimTail()
	{
		int num = Length - 1;
		while (num >= 0 && char.IsWhiteSpace(Value[num]))
		{
			num--;
		}
		Value = Value.Slice(0, num + 1);
	}

	internal void RemoveTrailingInQuoteSpaces()
	{
		int num = Length - 1;
		if (num <= 1)
		{
			return;
		}
		char c = Value[num];
		if ((c == '\'' || c == '"') && char.IsWhiteSpace(Value[num - 1]))
		{
			num--;
			while (num >= 1 && char.IsWhiteSpace(Value[num - 1]))
			{
				num--;
			}
			Span<char> span = new char[num + 1];
			span[num] = c;
			Value.Slice(0, num).CopyTo(span);
			Value = span;
		}
	}

	internal void RemoveLeadingInQuoteSpaces()
	{
		if (Length <= 2)
		{
			return;
		}
		int i = 0;
		char c = Value[i];
		if (c == '\'' || c == '"')
		{
			for (; i + 1 < Length && char.IsWhiteSpace(Value[i + 1]); i++)
			{
			}
			if (i != 0)
			{
				Span<char> span = new char[Value.Length - i];
				span[0] = c;
				Value.Slice(i + 1).CopyTo(span.Slice(1));
				Value = span;
			}
		}
	}

	internal DTSubString GetSubString()
	{
		DTSubString result = new DTSubString
		{
			index = Index,
			s = Value
		};
		while (Index + result.length < Length)
		{
			char c = Value[Index + result.length];
			DTSubStringType dTSubStringType = ((c < '0' || c > '9') ? DTSubStringType.Other : DTSubStringType.Number);
			if (result.length == 0)
			{
				result.type = dTSubStringType;
			}
			else if (result.type != dTSubStringType)
			{
				break;
			}
			result.length++;
			if (dTSubStringType != DTSubStringType.Number)
			{
				break;
			}
			if (result.length > 8)
			{
				result.type = DTSubStringType.Invalid;
				return result;
			}
			int num = c - 48;
			result.value = result.value * 10 + num;
		}
		if (result.length == 0)
		{
			result.type = DTSubStringType.End;
			return result;
		}
		return result;
	}

	internal void ConsumeSubString(DTSubString sub)
	{
		Index = sub.index + sub.length;
		if (Index < Length)
		{
			m_current = Value[Index];
		}
	}
}
