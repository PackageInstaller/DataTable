using System.Globalization;
using System.Runtime.Versioning;

namespace System;

[Serializable]
public readonly struct Char : IComparable, IComparable<char>, IEquatable<char>, IConvertible
{
	private readonly char m_value;

	public const char MaxValue = '\uffff';

	public const char MinValue = '\0';

	private static readonly byte[] s_categoryForLatin1 = new byte[256]
	{
		14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
		14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
		14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
		14, 14, 11, 24, 24, 24, 26, 24, 24, 24,
		20, 21, 24, 25, 24, 19, 24, 24, 8, 8,
		8, 8, 8, 8, 8, 8, 8, 8, 24, 24,
		25, 25, 25, 24, 24, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 20, 24, 21, 27, 18, 27, 1, 1, 1,
		1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
		1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
		1, 1, 1, 20, 25, 21, 25, 14, 14, 14,
		14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
		14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
		14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
		11, 24, 26, 26, 26, 26, 28, 28, 27, 28,
		1, 22, 25, 19, 28, 27, 28, 25, 10, 10,
		27, 1, 28, 24, 27, 10, 1, 23, 10, 10,
		10, 24, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 25, 0, 0, 0, 0,
		0, 0, 0, 1, 1, 1, 1, 1, 1, 1,
		1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
		1, 1, 1, 1, 1, 1, 1, 25, 1, 1,
		1, 1, 1, 1, 1, 1
	};

	internal const int UNICODE_PLANE00_END = 65535;

	internal const int UNICODE_PLANE01_START = 65536;

	internal const int UNICODE_PLANE16_END = 1114111;

	internal const int HIGH_SURROGATE_START = 55296;

	internal const int LOW_SURROGATE_END = 57343;

	private static bool IsLatin1(char ch)
	{
		return ch <= 'ÿ';
	}

	private static bool IsAscii(char ch)
	{
		return ch <= '\u007f';
	}

	private static UnicodeCategory GetLatin1UnicodeCategory(char ch)
	{
		return (UnicodeCategory)s_categoryForLatin1[(uint)ch];
	}

	public override int GetHashCode()
	{
		return (int)(this | ((uint)this << 16));
	}

	public override bool Equals(object obj)
	{
		if (!(obj is char))
		{
			return false;
		}
		return this == (char)obj;
	}

	[NonVersionable]
	public bool Equals(char obj)
	{
		return this == obj;
	}

	public int CompareTo(object value)
	{
		if (value == null)
		{
			return 1;
		}
		if (!(value is char))
		{
			throw new ArgumentException("Object must be of type Char.");
		}
		return this - (char)value;
	}

	public int CompareTo(char value)
	{
		return this - value;
	}

	public override string ToString()
	{
		return ToString(this);
	}

	public string ToString(IFormatProvider provider)
	{
		return ToString(this);
	}

	public static string ToString(char c)
	{
		return string.CreateFromChar(c);
	}

	public static char Parse(string s)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if (s.Length != 1)
		{
			throw new FormatException("String must be exactly one character long.");
		}
		return s[0];
	}

	public static bool TryParse(string s, out char result)
	{
		result = '\0';
		if (s == null)
		{
			return false;
		}
		if (s.Length != 1)
		{
			return false;
		}
		result = s[0];
		return true;
	}

	public static bool IsDigit(char c)
	{
		if (IsLatin1(c))
		{
			if (c >= '0')
			{
				return c <= '9';
			}
			return false;
		}
		return CharUnicodeInfo.GetUnicodeCategory(c) == UnicodeCategory.DecimalDigitNumber;
	}

	internal static bool CheckLetter(UnicodeCategory uc)
	{
		if ((uint)uc <= 4u)
		{
			return true;
		}
		return false;
	}

	public static bool IsLetter(char c)
	{
		if (IsLatin1(c))
		{
			if (IsAscii(c))
			{
				c = (char)(c | 0x20);
				if (c >= 'a')
				{
					return c <= 'z';
				}
				return false;
			}
			return CheckLetter(GetLatin1UnicodeCategory(c));
		}
		return CheckLetter(CharUnicodeInfo.GetUnicodeCategory(c));
	}

	private static bool IsWhiteSpaceLatin1(char c)
	{
		if (c != ' ' && (uint)(c - 9) > 4u && c != '\u00a0')
		{
			return c == '\u0085';
		}
		return true;
	}

	public static bool IsWhiteSpace(char c)
	{
		if (IsLatin1(c))
		{
			return IsWhiteSpaceLatin1(c);
		}
		return CharUnicodeInfo.IsWhiteSpace(c);
	}

	public static bool IsUpper(char c)
	{
		if (IsLatin1(c))
		{
			if (IsAscii(c))
			{
				if (c >= 'A')
				{
					return c <= 'Z';
				}
				return false;
			}
			return GetLatin1UnicodeCategory(c) == UnicodeCategory.UppercaseLetter;
		}
		return CharUnicodeInfo.GetUnicodeCategory(c) == UnicodeCategory.UppercaseLetter;
	}

	public static bool IsLower(char c)
	{
		if (IsLatin1(c))
		{
			if (IsAscii(c))
			{
				if (c >= 'a')
				{
					return c <= 'z';
				}
				return false;
			}
			return GetLatin1UnicodeCategory(c) == UnicodeCategory.LowercaseLetter;
		}
		return CharUnicodeInfo.GetUnicodeCategory(c) == UnicodeCategory.LowercaseLetter;
	}

	internal static bool CheckPunctuation(UnicodeCategory uc)
	{
		if ((uint)(uc - 18) <= 6u)
		{
			return true;
		}
		return false;
	}

	public static bool IsPunctuation(char c)
	{
		if (IsLatin1(c))
		{
			return CheckPunctuation(GetLatin1UnicodeCategory(c));
		}
		return CheckPunctuation(CharUnicodeInfo.GetUnicodeCategory(c));
	}

	internal static bool CheckLetterOrDigit(UnicodeCategory uc)
	{
		if ((uint)uc <= 4u || uc == UnicodeCategory.DecimalDigitNumber)
		{
			return true;
		}
		return false;
	}

	public static bool IsLetterOrDigit(char c)
	{
		if (IsLatin1(c))
		{
			return CheckLetterOrDigit(GetLatin1UnicodeCategory(c));
		}
		return CheckLetterOrDigit(CharUnicodeInfo.GetUnicodeCategory(c));
	}

	public static char ToUpper(char c, CultureInfo culture)
	{
		if (culture == null)
		{
			throw new ArgumentNullException("culture");
		}
		return culture.TextInfo.ToUpper(c);
	}

	public static char ToUpper(char c)
	{
		return CultureInfo.CurrentCulture.TextInfo.ToUpper(c);
	}

	public static char ToUpperInvariant(char c)
	{
		return CultureInfo.InvariantCulture.TextInfo.ToUpper(c);
	}

	public static char ToLower(char c, CultureInfo culture)
	{
		if (culture == null)
		{
			throw new ArgumentNullException("culture");
		}
		return culture.TextInfo.ToLower(c);
	}

	public static char ToLower(char c)
	{
		return CultureInfo.CurrentCulture.TextInfo.ToLower(c);
	}

	public static char ToLowerInvariant(char c)
	{
		return CultureInfo.InvariantCulture.TextInfo.ToLower(c);
	}

	public TypeCode GetTypeCode()
	{
		return TypeCode.Char;
	}

	bool IConvertible.ToBoolean(IFormatProvider provider)
	{
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "Char", "Boolean"));
	}

	char IConvertible.ToChar(IFormatProvider provider)
	{
		return this;
	}

	sbyte IConvertible.ToSByte(IFormatProvider provider)
	{
		return Convert.ToSByte(this);
	}

	byte IConvertible.ToByte(IFormatProvider provider)
	{
		return Convert.ToByte(this);
	}

	short IConvertible.ToInt16(IFormatProvider provider)
	{
		return Convert.ToInt16(this);
	}

	ushort IConvertible.ToUInt16(IFormatProvider provider)
	{
		return Convert.ToUInt16(this);
	}

	int IConvertible.ToInt32(IFormatProvider provider)
	{
		return Convert.ToInt32(this);
	}

	uint IConvertible.ToUInt32(IFormatProvider provider)
	{
		return Convert.ToUInt32(this);
	}

	long IConvertible.ToInt64(IFormatProvider provider)
	{
		return Convert.ToInt64(this);
	}

	ulong IConvertible.ToUInt64(IFormatProvider provider)
	{
		return Convert.ToUInt64(this);
	}

	float IConvertible.ToSingle(IFormatProvider provider)
	{
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "Char", "Single"));
	}

	double IConvertible.ToDouble(IFormatProvider provider)
	{
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "Char", "Double"));
	}

	decimal IConvertible.ToDecimal(IFormatProvider provider)
	{
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "Char", "Decimal"));
	}

	DateTime IConvertible.ToDateTime(IFormatProvider provider)
	{
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "Char", "DateTime"));
	}

	object IConvertible.ToType(Type type, IFormatProvider provider)
	{
		return Convert.DefaultToType(this, type, provider);
	}

	public static bool IsControl(char c)
	{
		if (IsLatin1(c))
		{
			return GetLatin1UnicodeCategory(c) == UnicodeCategory.Control;
		}
		return CharUnicodeInfo.GetUnicodeCategory(c) == UnicodeCategory.Control;
	}

	public static bool IsControl(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if ((uint)index >= (uint)s.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		char ch = s[index];
		if (IsLatin1(ch))
		{
			return GetLatin1UnicodeCategory(ch) == UnicodeCategory.Control;
		}
		return CharUnicodeInfo.GetUnicodeCategory(s, index) == UnicodeCategory.Control;
	}

	public static bool IsDigit(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if ((uint)index >= (uint)s.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		char c = s[index];
		if (IsLatin1(c))
		{
			if (c >= '0')
			{
				return c <= '9';
			}
			return false;
		}
		return CharUnicodeInfo.GetUnicodeCategory(s, index) == UnicodeCategory.DecimalDigitNumber;
	}

	public static bool IsLetter(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if ((uint)index >= (uint)s.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		char c = s[index];
		if (IsLatin1(c))
		{
			if (IsAscii(c))
			{
				c = (char)(c | 0x20);
				if (c >= 'a')
				{
					return c <= 'z';
				}
				return false;
			}
			return CheckLetter(GetLatin1UnicodeCategory(c));
		}
		return CheckLetter(CharUnicodeInfo.GetUnicodeCategory(s, index));
	}

	public static bool IsLetterOrDigit(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if ((uint)index >= (uint)s.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		char ch = s[index];
		if (IsLatin1(ch))
		{
			return CheckLetterOrDigit(GetLatin1UnicodeCategory(ch));
		}
		return CheckLetterOrDigit(CharUnicodeInfo.GetUnicodeCategory(s, index));
	}

	public static bool IsLower(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if ((uint)index >= (uint)s.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		char c = s[index];
		if (IsLatin1(c))
		{
			if (IsAscii(c))
			{
				if (c >= 'a')
				{
					return c <= 'z';
				}
				return false;
			}
			return GetLatin1UnicodeCategory(c) == UnicodeCategory.LowercaseLetter;
		}
		return CharUnicodeInfo.GetUnicodeCategory(s, index) == UnicodeCategory.LowercaseLetter;
	}

	internal static bool CheckNumber(UnicodeCategory uc)
	{
		if ((uint)(uc - 8) <= 2u)
		{
			return true;
		}
		return false;
	}

	public static bool IsNumber(char c)
	{
		if (IsLatin1(c))
		{
			if (IsAscii(c))
			{
				if (c >= '0')
				{
					return c <= '9';
				}
				return false;
			}
			return CheckNumber(GetLatin1UnicodeCategory(c));
		}
		return CheckNumber(CharUnicodeInfo.GetUnicodeCategory(c));
	}

	public static bool IsNumber(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if ((uint)index >= (uint)s.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		char c = s[index];
		if (IsLatin1(c))
		{
			if (IsAscii(c))
			{
				if (c >= '0')
				{
					return c <= '9';
				}
				return false;
			}
			return CheckNumber(GetLatin1UnicodeCategory(c));
		}
		return CheckNumber(CharUnicodeInfo.GetUnicodeCategory(s, index));
	}

	public static bool IsPunctuation(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if ((uint)index >= (uint)s.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		char ch = s[index];
		if (IsLatin1(ch))
		{
			return CheckPunctuation(GetLatin1UnicodeCategory(ch));
		}
		return CheckPunctuation(CharUnicodeInfo.GetUnicodeCategory(s, index));
	}

	internal static bool CheckSeparator(UnicodeCategory uc)
	{
		if ((uint)(uc - 11) <= 2u)
		{
			return true;
		}
		return false;
	}

	private static bool IsSeparatorLatin1(char c)
	{
		if (c != ' ')
		{
			return c == '\u00a0';
		}
		return true;
	}

	public static bool IsSeparator(char c)
	{
		if (IsLatin1(c))
		{
			return IsSeparatorLatin1(c);
		}
		return CheckSeparator(CharUnicodeInfo.GetUnicodeCategory(c));
	}

	public static bool IsSeparator(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if ((uint)index >= (uint)s.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		char c = s[index];
		if (IsLatin1(c))
		{
			return IsSeparatorLatin1(c);
		}
		return CheckSeparator(CharUnicodeInfo.GetUnicodeCategory(s, index));
	}

	public static bool IsSurrogate(char c)
	{
		if (c >= '\ud800')
		{
			return c <= '\udfff';
		}
		return false;
	}

	public static bool IsSurrogate(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if ((uint)index >= (uint)s.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		return IsSurrogate(s[index]);
	}

	internal static bool CheckSymbol(UnicodeCategory uc)
	{
		if ((uint)(uc - 25) <= 3u)
		{
			return true;
		}
		return false;
	}

	public static bool IsSymbol(char c)
	{
		if (IsLatin1(c))
		{
			return CheckSymbol(GetLatin1UnicodeCategory(c));
		}
		return CheckSymbol(CharUnicodeInfo.GetUnicodeCategory(c));
	}

	public static bool IsSymbol(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if ((uint)index >= (uint)s.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		char ch = s[index];
		if (IsLatin1(ch))
		{
			return CheckSymbol(GetLatin1UnicodeCategory(ch));
		}
		return CheckSymbol(CharUnicodeInfo.GetUnicodeCategory(s, index));
	}

	public static bool IsUpper(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if ((uint)index >= (uint)s.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		char c = s[index];
		if (IsLatin1(c))
		{
			if (IsAscii(c))
			{
				if (c >= 'A')
				{
					return c <= 'Z';
				}
				return false;
			}
			return GetLatin1UnicodeCategory(c) == UnicodeCategory.UppercaseLetter;
		}
		return CharUnicodeInfo.GetUnicodeCategory(s, index) == UnicodeCategory.UppercaseLetter;
	}

	public static bool IsWhiteSpace(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if ((uint)index >= (uint)s.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		if (IsLatin1(s[index]))
		{
			return IsWhiteSpaceLatin1(s[index]);
		}
		return CharUnicodeInfo.IsWhiteSpace(s, index);
	}

	public static UnicodeCategory GetUnicodeCategory(char c)
	{
		if (IsLatin1(c))
		{
			return GetLatin1UnicodeCategory(c);
		}
		return CharUnicodeInfo.GetUnicodeCategory((int)c);
	}

	public static UnicodeCategory GetUnicodeCategory(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if ((uint)index >= (uint)s.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		if (IsLatin1(s[index]))
		{
			return GetLatin1UnicodeCategory(s[index]);
		}
		return CharUnicodeInfo.InternalGetUnicodeCategory(s, index);
	}

	public static double GetNumericValue(char c)
	{
		return CharUnicodeInfo.GetNumericValue(c);
	}

	public static double GetNumericValue(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if ((uint)index >= (uint)s.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		return CharUnicodeInfo.GetNumericValue(s, index);
	}

	public static bool IsHighSurrogate(char c)
	{
		if (c >= '\ud800')
		{
			return c <= '\udbff';
		}
		return false;
	}

	public static bool IsHighSurrogate(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if (index < 0 || index >= s.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		return IsHighSurrogate(s[index]);
	}

	public static bool IsLowSurrogate(char c)
	{
		if (c >= '\udc00')
		{
			return c <= '\udfff';
		}
		return false;
	}

	public static bool IsLowSurrogate(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if (index < 0 || index >= s.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		return IsLowSurrogate(s[index]);
	}

	public static bool IsSurrogatePair(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if (index < 0 || index >= s.Length)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		if (index + 1 < s.Length)
		{
			return IsSurrogatePair(s[index], s[index + 1]);
		}
		return false;
	}

	public static bool IsSurrogatePair(char highSurrogate, char lowSurrogate)
	{
		if (highSurrogate >= '\ud800' && highSurrogate <= '\udbff')
		{
			if (lowSurrogate >= '\udc00')
			{
				return lowSurrogate <= '\udfff';
			}
			return false;
		}
		return false;
	}

	public unsafe static string ConvertFromUtf32(int utf32)
	{
		if (utf32 < 0 || utf32 > 1114111 || (utf32 >= 55296 && utf32 <= 57343))
		{
			throw new ArgumentOutOfRangeException("utf32", "A valid UTF32 value is between 0x000000 and 0x10ffff, inclusive, and should not include surrogate codepoint values (0x00d800 ~ 0x00dfff).");
		}
		if (utf32 < 65536)
		{
			return ToString((char)utf32);
		}
		utf32 -= 65536;
		uint num = 0u;
		char* ptr = (char*)(&num);
		*ptr = (char)(utf32 / 1024 + 55296);
		ptr[1] = (char)(utf32 % 1024 + 56320);
		return new string(ptr, 0, 2);
	}

	public static int ConvertToUtf32(char highSurrogate, char lowSurrogate)
	{
		if (!IsHighSurrogate(highSurrogate))
		{
			throw new ArgumentOutOfRangeException("highSurrogate", "A valid high surrogate character is between 0xd800 and 0xdbff, inclusive.");
		}
		if (!IsLowSurrogate(lowSurrogate))
		{
			throw new ArgumentOutOfRangeException("lowSurrogate", "A valid low surrogate character is between 0xdc00 and 0xdfff, inclusive.");
		}
		return (highSurrogate - 55296) * 1024 + (lowSurrogate - 56320) + 65536;
	}

	public static int ConvertToUtf32(string s, int index)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		if (index < 0 || index >= s.Length)
		{
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		int num = s[index] - 55296;
		if (num >= 0 && num <= 2047)
		{
			if (num <= 1023)
			{
				if (index < s.Length - 1)
				{
					int num2 = s[index + 1] - 56320;
					if (num2 >= 0 && num2 <= 1023)
					{
						return num * 1024 + num2 + 65536;
					}
					throw new ArgumentException(SR.Format("Found a high surrogate char without a following low surrogate at index: {0}. The input may not be in this encoding, or may not contain valid Unicode (UTF-16) characters.", index), "s");
				}
				throw new ArgumentException(SR.Format("Found a high surrogate char without a following low surrogate at index: {0}. The input may not be in this encoding, or may not contain valid Unicode (UTF-16) characters.", index), "s");
			}
			throw new ArgumentException(SR.Format("Found a low surrogate char without a preceding high surrogate at index: {0}. The input may not be in this encoding, or may not contain valid Unicode (UTF-16) characters.", index), "s");
		}
		return s[index];
	}
}
