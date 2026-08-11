using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Text;
using Unity;

namespace System.Globalization;

[Serializable]
[ComVisible(true)]
public class TextInfo : ICloneable, IDeserializationCallback
{
	[OptionalField(VersionAdded = 2)]
	private string m_listSeparator;

	[OptionalField(VersionAdded = 2)]
	private bool m_isReadOnly;

	[OptionalField(VersionAdded = 3)]
	private string m_cultureName;

	[NonSerialized]
	private CultureData m_cultureData;

	[NonSerialized]
	private string m_textInfoName;

	[NonSerialized]
	private bool? m_IsAsciiCasingSameAsInvariant;

	internal static volatile TextInfo s_Invariant;

	[OptionalField(VersionAdded = 2)]
	private string customCultureName;

	[OptionalField(VersionAdded = 1)]
	internal int m_nDataItem;

	[OptionalField(VersionAdded = 1)]
	internal bool m_useUserOverride;

	[OptionalField(VersionAdded = 1)]
	internal int m_win32LangID;

	private const int wordSeparatorMask = 536672256;

	internal static TextInfo Invariant
	{
		get
		{
			if (s_Invariant == null)
			{
				s_Invariant = new TextInfo(CultureData.Invariant);
			}
			return s_Invariant;
		}
	}

	public virtual int OEMCodePage => m_cultureData.IDEFAULTOEMCODEPAGE;

	[ComVisible(false)]
	public string CultureName => m_textInfoName;

	[ComVisible(false)]
	public bool IsReadOnly => m_isReadOnly;

	public virtual string ListSeparator
	{
		get
		{
			if (m_listSeparator == null)
			{
				m_listSeparator = m_cultureData.SLIST;
			}
			return m_listSeparator;
		}
	}

	private bool IsAsciiCasingSameAsInvariant
	{
		get
		{
			if (!m_IsAsciiCasingSameAsInvariant.HasValue)
			{
				m_IsAsciiCasingSameAsInvariant = !(m_cultureData.SISO639LANGNAME == "az") && !(m_cultureData.SISO639LANGNAME == "tr");
			}
			return m_IsAsciiCasingSameAsInvariant.Value;
		}
	}

	internal TextInfo(CultureData cultureData)
	{
		m_cultureData = cultureData;
		m_cultureName = m_cultureData.CultureName;
		m_textInfoName = m_cultureData.STEXTINFO;
	}

	[OnDeserializing]
	private void OnDeserializing(StreamingContext ctx)
	{
		m_cultureData = null;
		m_cultureName = null;
	}

	private void OnDeserialized()
	{
		if (m_cultureData != null)
		{
			return;
		}
		if (m_cultureName == null)
		{
			if (customCultureName != null)
			{
				m_cultureName = customCultureName;
			}
			else if (m_win32LangID == 0)
			{
				m_cultureName = "ar-SA";
			}
			else
			{
				m_cultureName = CultureInfo.GetCultureInfo(m_win32LangID).m_cultureData.CultureName;
			}
		}
		m_cultureData = CultureInfo.GetCultureInfo(m_cultureName).m_cultureData;
		m_textInfoName = m_cultureData.STEXTINFO;
	}

	[OnDeserialized]
	private void OnDeserialized(StreamingContext ctx)
	{
		OnDeserialized();
	}

	[OnSerializing]
	private void OnSerializing(StreamingContext ctx)
	{
		m_useUserOverride = false;
		customCultureName = m_cultureName;
		m_win32LangID = CultureInfo.GetCultureInfo(m_cultureName).LCID;
	}

	[ComVisible(false)]
	public virtual object Clone()
	{
		object obj = MemberwiseClone();
		((TextInfo)obj).SetReadOnlyState(readOnly: false);
		return obj;
	}

	[ComVisible(false)]
	public static TextInfo ReadOnly(TextInfo textInfo)
	{
		if (textInfo == null)
		{
			throw new ArgumentNullException("textInfo");
		}
		if (textInfo.IsReadOnly)
		{
			return textInfo;
		}
		TextInfo obj = (TextInfo)textInfo.MemberwiseClone();
		obj.SetReadOnlyState(readOnly: true);
		return obj;
	}

	internal void SetReadOnlyState(bool readOnly)
	{
		m_isReadOnly = readOnly;
	}

	public virtual char ToLower(char c)
	{
		if (IsAscii(c) && IsAsciiCasingSameAsInvariant)
		{
			return ToLowerAsciiInvariant(c);
		}
		return ToLowerInternal(c);
	}

	public virtual string ToLower(string str)
	{
		if (str == null)
		{
			throw new ArgumentNullException("str");
		}
		return ToLowerInternal(str);
	}

	private static char ToLowerAsciiInvariant(char c)
	{
		if ('A' <= c && c <= 'Z')
		{
			c = (char)(c | 0x20);
		}
		return c;
	}

	public virtual char ToUpper(char c)
	{
		if (IsAscii(c) && IsAsciiCasingSameAsInvariant)
		{
			return ToUpperAsciiInvariant(c);
		}
		return ToUpperInternal(c);
	}

	public virtual string ToUpper(string str)
	{
		if (str == null)
		{
			throw new ArgumentNullException("str");
		}
		return ToUpperInternal(str);
	}

	internal static char ToUpperAsciiInvariant(char c)
	{
		if ('a' <= c && c <= 'z')
		{
			c = (char)(c & -33);
		}
		return c;
	}

	private static bool IsAscii(char c)
	{
		return c < '\u0080';
	}

	public override bool Equals(object obj)
	{
		if (obj is TextInfo textInfo)
		{
			return CultureName.Equals(textInfo.CultureName);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return CultureName.GetHashCode();
	}

	public override string ToString()
	{
		return "TextInfo - " + m_cultureData.CultureName;
	}

	public string ToTitleCase(string str)
	{
		if (str == null)
		{
			throw new ArgumentNullException("str");
		}
		if (str.Length == 0)
		{
			return str;
		}
		StringBuilder result = new StringBuilder();
		string text = null;
		int num;
		for (num = 0; num < str.Length; num++)
		{
			UnicodeCategory unicodeCategory = CharUnicodeInfo.InternalGetUnicodeCategory(str, num, out var charLength);
			if (char.CheckLetter(unicodeCategory))
			{
				num = AddTitlecaseLetter(ref result, ref str, num, charLength) + 1;
				int num2 = num;
				bool flag = unicodeCategory == UnicodeCategory.LowercaseLetter;
				while (num < str.Length)
				{
					unicodeCategory = CharUnicodeInfo.InternalGetUnicodeCategory(str, num, out charLength);
					if (IsLetterCategory(unicodeCategory))
					{
						if (unicodeCategory == UnicodeCategory.LowercaseLetter)
						{
							flag = true;
						}
						num += charLength;
					}
					else if (str[num] == '\'')
					{
						num++;
						if (flag)
						{
							if (text == null)
							{
								text = ToLower(str);
							}
							result.Append(text, num2, num - num2);
						}
						else
						{
							result.Append(str, num2, num - num2);
						}
						num2 = num;
						flag = true;
					}
					else
					{
						if (IsWordSeparator(unicodeCategory))
						{
							break;
						}
						num += charLength;
					}
				}
				int num3 = num - num2;
				if (num3 > 0)
				{
					if (flag)
					{
						if (text == null)
						{
							text = ToLower(str);
						}
						result.Append(text, num2, num3);
					}
					else
					{
						result.Append(str, num2, num3);
					}
				}
				if (num < str.Length)
				{
					num = AddNonLetter(ref result, ref str, num, charLength);
				}
			}
			else
			{
				num = AddNonLetter(ref result, ref str, num, charLength);
			}
		}
		return result.ToString();
	}

	private static int AddNonLetter(ref StringBuilder result, ref string input, int inputIndex, int charLen)
	{
		if (charLen == 2)
		{
			result.Append(input[inputIndex++]);
			result.Append(input[inputIndex]);
		}
		else
		{
			result.Append(input[inputIndex]);
		}
		return inputIndex;
	}

	private int AddTitlecaseLetter(ref StringBuilder result, ref string input, int inputIndex, int charLen)
	{
		if (charLen == 2)
		{
			result.Append(ToUpper(input.Substring(inputIndex, charLen)));
			inputIndex++;
		}
		else
		{
			switch (input[inputIndex])
			{
			case 'Ǆ':
			case 'ǅ':
			case 'ǆ':
				result.Append('ǅ');
				break;
			case 'Ǉ':
			case 'ǈ':
			case 'ǉ':
				result.Append('ǈ');
				break;
			case 'Ǌ':
			case 'ǋ':
			case 'ǌ':
				result.Append('ǋ');
				break;
			case 'Ǳ':
			case 'ǲ':
			case 'ǳ':
				result.Append('ǲ');
				break;
			default:
				result.Append(ToUpper(input[inputIndex]));
				break;
			}
		}
		return inputIndex;
	}

	private static bool IsWordSeparator(UnicodeCategory category)
	{
		return (0x1FFCF800 & (1 << (int)category)) != 0;
	}

	private static bool IsLetterCategory(UnicodeCategory uc)
	{
		if (uc != UnicodeCategory.UppercaseLetter && uc != UnicodeCategory.LowercaseLetter && uc != UnicodeCategory.TitlecaseLetter && uc != UnicodeCategory.ModifierLetter)
		{
			return uc == UnicodeCategory.OtherLetter;
		}
		return true;
	}

	void IDeserializationCallback.OnDeserialization(object sender)
	{
		OnDeserialized();
	}

	private unsafe string ToUpperInternal(string str)
	{
		if (str.Length == 0)
		{
			return string.Empty;
		}
		string text = string.FastAllocateString(str.Length);
		fixed (char* ptr = str)
		{
			fixed (char* ptr2 = text)
			{
				char* ptr3 = ptr2;
				char* ptr4 = ptr;
				for (int i = 0; i < str.Length; i++)
				{
					*ptr3 = ToUpper(*ptr4);
					ptr4++;
					ptr3++;
				}
			}
		}
		return text;
	}

	private unsafe string ToLowerInternal(string str)
	{
		if (str.Length == 0)
		{
			return string.Empty;
		}
		string text = string.FastAllocateString(str.Length);
		fixed (char* ptr = str)
		{
			fixed (char* ptr2 = text)
			{
				char* ptr3 = ptr2;
				char* ptr4 = ptr;
				for (int i = 0; i < str.Length; i++)
				{
					*ptr3 = ToLower(*ptr4);
					ptr4++;
					ptr3++;
				}
			}
		}
		return text;
	}

	private char ToUpperInternal(char c)
	{
		if (!m_cultureData.IsInvariantCulture)
		{
			switch (c)
			{
			case 'µ':
				return 'Μ';
			case 'ı':
				return 'I';
			case 'ſ':
				return 'S';
			case 'ǅ':
			case 'ǈ':
			case 'ǋ':
			case 'ǲ':
				return (char)(c - 1);
			case '\u0345':
				return 'Ι';
			case 'ς':
				return 'Σ';
			case 'ϐ':
				return 'Β';
			case 'ϑ':
				return 'Θ';
			case 'ϕ':
				return 'Φ';
			case 'ϖ':
				return 'Π';
			case 'ϰ':
				return 'Κ';
			case 'ϱ':
				return 'Ρ';
			case 'ϵ':
				return 'Ε';
			case 'ẛ':
				return 'Ṡ';
			case 'ι':
				return 'Ι';
			}
			if (!IsAsciiCasingSameAsInvariant)
			{
				if (c == 'i')
				{
					return 'İ';
				}
				if (IsAscii(c))
				{
					return ToUpperAsciiInvariant(c);
				}
			}
		}
		if (c >= 'à' && c <= 'ֆ')
		{
			return TextInfoToUpperData.range_00e0_0586[c - 224];
		}
		if (c >= 'ḁ' && c <= 'ῳ')
		{
			return TextInfoToUpperData.range_1e01_1ff3[c - 7681];
		}
		if (c >= 'ⅰ' && c <= 'ↄ')
		{
			return TextInfoToUpperData.range_2170_2184[c - 8560];
		}
		if (c >= 'ⓐ' && c <= 'ⓩ')
		{
			return TextInfoToUpperData.range_24d0_24e9[c - 9424];
		}
		if (c >= 'ⰰ' && c <= 'ⳣ')
		{
			return TextInfoToUpperData.range_2c30_2ce3[c - 11312];
		}
		if (c >= 'ⴀ' && c <= 'ⴥ')
		{
			return TextInfoToUpperData.range_2d00_2d25[c - 11520];
		}
		if (c >= 'ꙁ' && c <= 'ꚗ')
		{
			return TextInfoToUpperData.range_a641_a697[c - 42561];
		}
		if (c >= 'ꜣ' && c <= 'ꞌ')
		{
			return TextInfoToUpperData.range_a723_a78c[c - 42787];
		}
		if ('ａ' <= c && c <= 'ｚ')
		{
			return (char)(c - 32);
		}
		return c switch
		{
			'ᵹ' => 'Ᵹ', 
			'ᵽ' => 'Ᵽ', 
			'ⅎ' => 'Ⅎ', 
			_ => c, 
		};
	}

	private char ToLowerInternal(char c)
	{
		if (!m_cultureData.IsInvariantCulture)
		{
			switch (c)
			{
			case 'İ':
				return 'i';
			case 'ǅ':
			case 'ǈ':
			case 'ǋ':
			case 'ǲ':
				return (char)(c + 1);
			case 'ϒ':
				return 'υ';
			case 'ϓ':
				return 'ύ';
			case 'ϔ':
				return 'ϋ';
			case 'ϴ':
				return 'θ';
			case 'ẞ':
				return 'ß';
			case 'Ω':
				return 'ω';
			case 'K':
				return 'k';
			case 'Å':
				return 'å';
			}
			if (!IsAsciiCasingSameAsInvariant)
			{
				if (c == 'I')
				{
					return 'ı';
				}
				if (IsAscii(c))
				{
					return ToLowerAsciiInvariant(c);
				}
			}
		}
		if (c >= 'À' && c <= 'Ֆ')
		{
			return TextInfoToLowerData.range_00c0_0556[c - 192];
		}
		if (c >= 'Ⴀ' && c <= 'Ⴥ')
		{
			return TextInfoToLowerData.range_10a0_10c5[c - 4256];
		}
		if (c >= 'Ḁ' && c <= 'ῼ')
		{
			return TextInfoToLowerData.range_1e00_1ffc[c - 7680];
		}
		if (c >= 'Ⅰ' && c <= 'Ⅿ')
		{
			return TextInfoToLowerData.range_2160_216f[c - 8544];
		}
		if (c >= 'Ⓐ' && c <= 'Ⓩ')
		{
			return TextInfoToLowerData.range_24b6_24cf[c - 9398];
		}
		if (c >= 'Ⰰ' && c <= 'Ⱞ')
		{
			return TextInfoToLowerData.range_2c00_2c2e[c - 11264];
		}
		if (c >= 'Ⱡ' && c <= 'Ⳣ')
		{
			return TextInfoToLowerData.range_2c60_2ce2[c - 11360];
		}
		if (c >= 'Ꙁ' && c <= 'Ꚗ')
		{
			return TextInfoToLowerData.range_a640_a696[c - 42560];
		}
		if (c >= 'Ꜣ' && c <= 'Ꞌ')
		{
			return TextInfoToLowerData.range_a722_a78b[c - 42786];
		}
		if ('Ａ' <= c && c <= 'Ｚ')
		{
			return (char)(c + 32);
		}
		return c switch
		{
			'Ⅎ' => 'ⅎ', 
			'Ↄ' => 'ↄ', 
			_ => c, 
		};
	}

	internal void ToUpperAsciiInvariant(ReadOnlySpan<char> source, Span<char> destination)
	{
		for (int i = 0; i < source.Length; i++)
		{
			destination[i] = ToUpperAsciiInvariant(source[i]);
		}
	}

	internal unsafe void ChangeCase(ReadOnlySpan<char> source, Span<char> destination, bool toUpper)
	{
		if (source.IsEmpty)
		{
			return;
		}
		fixed (char* reference = &MemoryMarshal.GetReference(source))
		{
			fixed (char* reference2 = &MemoryMarshal.GetReference(destination))
			{
				int i = 0;
				char* ptr = reference;
				char* ptr2 = reference2;
				if (toUpper)
				{
					for (; i < source.Length; i++)
					{
						*(ptr2++) = ToUpper(*(ptr++));
					}
				}
				else
				{
					for (; i < source.Length; i++)
					{
						*(ptr2++) = ToLower(*(ptr++));
					}
				}
			}
		}
	}

	internal TextInfo()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
