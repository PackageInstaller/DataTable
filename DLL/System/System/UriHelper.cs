using System.Globalization;
using System.Text;

namespace System;

internal static class UriHelper
{
	private static readonly char[] HexUpperChars = new char[16]
	{
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
		'A', 'B', 'C', 'D', 'E', 'F'
	};

	internal unsafe static bool TestForSubPath(char* pMe, ushort meLength, char* pShe, ushort sheLength, bool ignoreCase)
	{
		ushort num = 0;
		bool flag = true;
		for (; num < meLength && num < sheLength; num++)
		{
			char c = pMe[(int)num];
			char c2 = pShe[(int)num];
			switch (c)
			{
			case '#':
			case '?':
				return true;
			case '/':
				if (c2 != '/')
				{
					return false;
				}
				if (!flag)
				{
					return false;
				}
				flag = true;
				continue;
			default:
				if (c2 == '?' || c2 == '#')
				{
					break;
				}
				if (!ignoreCase)
				{
					if (c != c2)
					{
						flag = false;
					}
				}
				else if (char.ToLower(c, CultureInfo.InvariantCulture) != char.ToLower(c2, CultureInfo.InvariantCulture))
				{
					flag = false;
				}
				continue;
			}
			break;
		}
		for (; num < meLength; num++)
		{
			char c;
			if ((c = pMe[(int)num]) != '?')
			{
				switch (c)
				{
				case '#':
					break;
				case '/':
					return false;
				default:
					continue;
				}
			}
			return true;
		}
		return true;
	}

	internal unsafe static char[] EscapeString(string input, int start, int end, char[] dest, ref int destPos, bool isUriString, char force1, char force2, char rsvd)
	{
		if (end - start >= 65520)
		{
			throw new UriFormatException(global::SR.GetString("Invalid URI: The Uri string is too long."));
		}
		int i = start;
		int num = start;
		byte* ptr = stackalloc byte[160];
		fixed (char* ptr2 = input)
		{
			for (; i < end; i++)
			{
				char c = ptr2[i];
				if (c > '\u007f')
				{
					short num2 = (short)Math.Min(end - i, 39);
					short num3 = 1;
					while (num3 < num2 && ptr2[i + num3] > '\u007f')
					{
						num3++;
					}
					if (ptr2[i + num3 - 1] >= '\ud800' && ptr2[i + num3 - 1] <= '\udbff')
					{
						if (num3 == 1 || num3 == end - i)
						{
							throw new UriFormatException(global::SR.GetString("Invalid URI: There is an invalid sequence in the string."));
						}
						num3++;
					}
					dest = EnsureDestinationSize(ptr2, dest, i, (short)(num3 * 4 * 3), 480, ref destPos, num);
					short num4 = (short)Encoding.UTF8.GetBytes(ptr2 + i, num3, ptr, 160);
					if (num4 == 0)
					{
						throw new UriFormatException(global::SR.GetString("Invalid URI: There is an invalid sequence in the string."));
					}
					i += num3 - 1;
					for (num3 = 0; num3 < num4; num3++)
					{
						EscapeAsciiChar((char)ptr[num3], dest, ref destPos);
					}
					num = i + 1;
				}
				else if (c == '%' && rsvd == '%')
				{
					dest = EnsureDestinationSize(ptr2, dest, i, 3, 120, ref destPos, num);
					if (i + 2 < end && EscapedAscii(ptr2[i + 1], ptr2[i + 2]) != '\uffff')
					{
						dest[destPos++] = '%';
						dest[destPos++] = ptr2[i + 1];
						dest[destPos++] = ptr2[i + 2];
						i += 2;
					}
					else
					{
						EscapeAsciiChar('%', dest, ref destPos);
					}
					num = i + 1;
				}
				else if (c == force1 || c == force2)
				{
					dest = EnsureDestinationSize(ptr2, dest, i, 3, 120, ref destPos, num);
					EscapeAsciiChar(c, dest, ref destPos);
					num = i + 1;
				}
				else if (c != rsvd && (isUriString ? (!IsReservedUnreservedOrHash(c)) : (!IsUnreserved(c))))
				{
					dest = EnsureDestinationSize(ptr2, dest, i, 3, 120, ref destPos, num);
					EscapeAsciiChar(c, dest, ref destPos);
					num = i + 1;
				}
			}
			if (num != i && (num != start || dest != null))
			{
				dest = EnsureDestinationSize(ptr2, dest, i, 0, 0, ref destPos, num);
			}
		}
		return dest;
	}

	private unsafe static char[] EnsureDestinationSize(char* pStr, char[] dest, int currentInputPos, short charsToAdd, short minReallocateChars, ref int destPos, int prevInputPos)
	{
		if (dest == null || dest.Length < destPos + (currentInputPos - prevInputPos) + charsToAdd)
		{
			char[] array = new char[destPos + (currentInputPos - prevInputPos) + minReallocateChars];
			if (dest != null && destPos != 0)
			{
				Buffer.BlockCopy(dest, 0, array, 0, destPos << 1);
			}
			dest = array;
		}
		while (prevInputPos != currentInputPos)
		{
			dest[destPos++] = pStr[prevInputPos++];
		}
		return dest;
	}

	internal unsafe static char[] UnescapeString(string input, int start, int end, char[] dest, ref int destPosition, char rsvd1, char rsvd2, char rsvd3, UnescapeMode unescapeMode, UriParser syntax, bool isQuery)
	{
		fixed (char* pStr = input)
		{
			return UnescapeString(pStr, start, end, dest, ref destPosition, rsvd1, rsvd2, rsvd3, unescapeMode, syntax, isQuery);
		}
	}

	internal unsafe static char[] UnescapeString(char* pStr, int start, int end, char[] dest, ref int destPosition, char rsvd1, char rsvd2, char rsvd3, UnescapeMode unescapeMode, UriParser syntax, bool isQuery)
	{
		byte[] array = null;
		byte b = 0;
		bool flag = false;
		int i = start;
		bool flag2 = Uri.IriParsingStatic(syntax) && (unescapeMode & UnescapeMode.EscapeUnescape) == UnescapeMode.EscapeUnescape;
		while (true)
		{
			fixed (char* ptr = dest)
			{
				if ((unescapeMode & UnescapeMode.EscapeUnescape) == 0)
				{
					while (start < end)
					{
						ptr[destPosition++] = pStr[start++];
					}
					return dest;
				}
				while (true)
				{
					char c = '\0';
					for (; i < end; i++)
					{
						if ((c = pStr[i]) == '%')
						{
							if ((unescapeMode & UnescapeMode.Unescape) == 0)
							{
								flag = true;
								break;
							}
							if (i + 2 < end)
							{
								c = EscapedAscii(pStr[i + 1], pStr[i + 2]);
								if (unescapeMode < UnescapeMode.UnescapeAll)
								{
									switch (c)
									{
									case '\uffff':
										if ((unescapeMode & UnescapeMode.Escape) == 0)
										{
											continue;
										}
										flag = true;
										break;
									case '%':
										i += 2;
										continue;
									default:
										if (c == rsvd1 || c == rsvd2 || c == rsvd3)
										{
											i += 2;
											continue;
										}
										if ((unescapeMode & UnescapeMode.V1ToStringFlag) == 0 && IsNotSafeForUnescape(c))
										{
											i += 2;
											continue;
										}
										if (flag2 && ((c <= '\u009f' && IsNotSafeForUnescape(c)) || (c > '\u009f' && !IriHelper.CheckIriUnicodeRange(c, isQuery))))
										{
											i += 2;
											continue;
										}
										break;
									}
									break;
								}
								if (c != '\uffff')
								{
									break;
								}
								if (unescapeMode >= UnescapeMode.UnescapeAllOrThrow)
								{
									throw new UriFormatException(global::SR.GetString("Invalid URI: There is an invalid sequence in the string."));
								}
							}
							else
							{
								if (unescapeMode < UnescapeMode.UnescapeAll)
								{
									flag = true;
									break;
								}
								if (unescapeMode >= UnescapeMode.UnescapeAllOrThrow)
								{
									throw new UriFormatException(global::SR.GetString("Invalid URI: There is an invalid sequence in the string."));
								}
							}
						}
						else if ((unescapeMode & (UnescapeMode.Unescape | UnescapeMode.UnescapeAll)) != (UnescapeMode.Unescape | UnescapeMode.UnescapeAll) && (unescapeMode & UnescapeMode.Escape) != UnescapeMode.CopyOnly)
						{
							if (c == rsvd1 || c == rsvd2 || c == rsvd3)
							{
								flag = true;
								break;
							}
							if ((unescapeMode & UnescapeMode.V1ToStringFlag) == 0 && (c <= '\u001f' || (c >= '\u007f' && c <= '\u009f')))
							{
								flag = true;
								break;
							}
						}
					}
					while (start < i)
					{
						ptr[destPosition++] = pStr[start++];
					}
					if (i != end)
					{
						if (flag)
						{
							if (b == 0)
							{
								break;
							}
							b--;
							EscapeAsciiChar(pStr[i], dest, ref destPosition);
							flag = false;
							start = ++i;
							continue;
						}
						if (c <= '\u007f')
						{
							dest[destPosition++] = c;
							i += 3;
							start = i;
							continue;
						}
						int byteCount = 1;
						if (array == null)
						{
							array = new byte[end - i];
						}
						array[0] = (byte)c;
						for (i += 3; i < end; i += 3)
						{
							if ((c = pStr[i]) != '%')
							{
								break;
							}
							if (i + 2 >= end)
							{
								break;
							}
							c = EscapedAscii(pStr[i + 1], pStr[i + 2]);
							if (c == '\uffff' || c < '\u0080')
							{
								break;
							}
							array[byteCount++] = (byte)c;
						}
						Encoding obj = (Encoding)Encoding.UTF8.Clone();
						obj.EncoderFallback = new EncoderReplacementFallback("");
						obj.DecoderFallback = new DecoderReplacementFallback("");
						char[] array2 = new char[array.Length];
						int chars = obj.GetChars(array, 0, byteCount, array2, 0);
						start = i;
						MatchUTF8Sequence(ptr, dest, ref destPosition, array2, chars, array, byteCount, isQuery, flag2);
					}
					if (i == end)
					{
						return dest;
					}
				}
				b = 30;
				char[] array3 = new char[dest.Length + b * 3];
				fixed (char* ptr2 = array3)
				{
					for (int j = 0; j < destPosition; j++)
					{
						ptr2[j] = ptr[j];
					}
				}
				dest = array3;
			}
		}
	}

	internal unsafe static void MatchUTF8Sequence(char* pDest, char[] dest, ref int destOffset, char[] unescapedChars, int charCount, byte[] bytes, int byteCount, bool isQuery, bool iriParsing)
	{
		int num = 0;
		fixed (char* ptr = unescapedChars)
		{
			for (int i = 0; i < charCount; i++)
			{
				bool flag = char.IsHighSurrogate(ptr[i]);
				byte[] bytes2 = Encoding.UTF8.GetBytes(unescapedChars, i, (!flag) ? 1 : 2);
				int num2 = bytes2.Length;
				bool flag2 = false;
				if (iriParsing)
				{
					if (!flag)
					{
						flag2 = IriHelper.CheckIriUnicodeRange(unescapedChars[i], isQuery);
					}
					else
					{
						bool surrogatePair = false;
						flag2 = IriHelper.CheckIriUnicodeRange(unescapedChars[i], unescapedChars[i + 1], ref surrogatePair, isQuery);
					}
				}
				while (true)
				{
					if (bytes[num] != bytes2[0])
					{
						EscapeAsciiChar((char)bytes[num++], dest, ref destOffset);
						continue;
					}
					bool flag3 = true;
					int j;
					for (j = 0; j < num2; j++)
					{
						if (bytes[num + j] != bytes2[j])
						{
							flag3 = false;
							break;
						}
					}
					if (flag3)
					{
						break;
					}
					for (int k = 0; k < j; k++)
					{
						EscapeAsciiChar((char)bytes[num++], dest, ref destOffset);
					}
				}
				num += num2;
				if (iriParsing)
				{
					if (!flag2)
					{
						for (int l = 0; l < bytes2.Length; l++)
						{
							EscapeAsciiChar((char)bytes2[l], dest, ref destOffset);
						}
					}
					else if (!Uri.IsBidiControlCharacter(ptr[i]))
					{
						pDest[destOffset++] = ptr[i];
						if (flag)
						{
							pDest[destOffset++] = ptr[i + 1];
						}
					}
				}
				else
				{
					pDest[destOffset++] = ptr[i];
					if (flag)
					{
						pDest[destOffset++] = ptr[i + 1];
					}
				}
				if (flag)
				{
					i++;
				}
			}
		}
		while (num < byteCount)
		{
			EscapeAsciiChar((char)bytes[num++], dest, ref destOffset);
		}
	}

	internal static void EscapeAsciiChar(char ch, char[] to, ref int pos)
	{
		to[pos++] = '%';
		to[pos++] = HexUpperChars[(ch & 0xF0) >> 4];
		to[pos++] = HexUpperChars[ch & 0xF];
	}

	internal static char EscapedAscii(char digit, char next)
	{
		if ((digit < '0' || digit > '9') && (digit < 'A' || digit > 'F') && (digit < 'a' || digit > 'f'))
		{
			return '\uffff';
		}
		int num = ((digit <= '9') ? (digit - 48) : (((digit <= 'F') ? (digit - 65) : (digit - 97)) + 10));
		if ((next < '0' || next > '9') && (next < 'A' || next > 'F') && (next < 'a' || next > 'f'))
		{
			return '\uffff';
		}
		return (char)((num << 4) + ((next <= '9') ? (next - 48) : (((next <= 'F') ? (next - 65) : (next - 97)) + 10)));
	}

	internal static bool IsNotSafeForUnescape(char ch)
	{
		if (ch <= '\u001f' || (ch >= '\u007f' && ch <= '\u009f'))
		{
			return true;
		}
		if ((ch >= ';' && ch <= '@' && (ch | 2) != 62) || (ch >= '#' && ch <= '&') || ch == '+' || ch == ',' || ch == '/' || ch == '\\')
		{
			return true;
		}
		return false;
	}

	private static bool IsReservedUnreservedOrHash(char c)
	{
		if (IsUnreserved(c))
		{
			return true;
		}
		if (UriParser.ShouldUseLegacyV2Quirks)
		{
			if (";/?:@&=+$,".IndexOf(c) < 0)
			{
				return c == '#';
			}
			return true;
		}
		return ":/?#[]@!$&'()*+,;=".IndexOf(c) >= 0;
	}

	internal static bool IsUnreserved(char c)
	{
		if (Uri.IsAsciiLetterOrDigit(c))
		{
			return true;
		}
		if (UriParser.ShouldUseLegacyV2Quirks)
		{
			return "-_.!~*'()".IndexOf(c) >= 0;
		}
		return "-._~".IndexOf(c) >= 0;
	}

	internal static bool Is3986Unreserved(char c)
	{
		if (Uri.IsAsciiLetterOrDigit(c))
		{
			return true;
		}
		return "-._~".IndexOf(c) >= 0;
	}
}
