using System.Text;

namespace System.Globalization;

public sealed class IdnMapping
{
	private bool allow_unassigned;

	private bool use_std3;

	private Punycode puny = new Punycode();

	public override bool Equals(object obj)
	{
		if (obj is IdnMapping idnMapping && allow_unassigned == idnMapping.allow_unassigned)
		{
			return use_std3 == idnMapping.use_std3;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (allow_unassigned ? 2 : 0) + (use_std3 ? 1 : 0);
	}

	public string GetAscii(string unicode)
	{
		if (unicode == null)
		{
			throw new ArgumentNullException("unicode");
		}
		return GetAscii(unicode, 0, unicode.Length);
	}

	public string GetAscii(string unicode, int index, int count)
	{
		if (unicode == null)
		{
			throw new ArgumentNullException("unicode");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index must be non-negative value");
		}
		if (count < 0 || index + count > unicode.Length)
		{
			throw new ArgumentOutOfRangeException("index + count must point inside the argument unicode string");
		}
		return Convert(unicode, index, count, toAscii: true);
	}

	private string Convert(string input, int index, int count, bool toAscii)
	{
		string text = input.Substring(index, count);
		for (int i = 0; i < text.Length; i++)
		{
			if (text[i] >= '\u0080')
			{
				text = text.ToLower(CultureInfo.InvariantCulture);
				break;
			}
		}
		string[] array = text.Split('.', '。', '．', '｡');
		int num = 0;
		for (int j = 0; j < array.Length; j++)
		{
			if (array[j].Length != 0 || j + 1 != array.Length)
			{
				if (toAscii)
				{
					array[j] = ToAscii(array[j], num);
				}
				else
				{
					array[j] = ToUnicode(array[j], num);
				}
			}
			num += array[j].Length;
		}
		return string.Join(".", array);
	}

	private string ToAscii(string s, int offset)
	{
		for (int i = 0; i < s.Length; i++)
		{
			if (s[i] < ' ' || s[i] == '\u007f')
			{
				throw new ArgumentException($"Not allowed character was found, at {offset + i}");
			}
			if (s[i] >= '\u0080')
			{
				s = NamePrep(s, offset);
				break;
			}
		}
		if (use_std3)
		{
			VerifyStd3AsciiRules(s, offset);
		}
		for (int j = 0; j < s.Length; j++)
		{
			if (s[j] >= '\u0080')
			{
				if (s.StartsWith("xn--", StringComparison.OrdinalIgnoreCase))
				{
					throw new ArgumentException($"The input string must not start with ACE (xn--), at {offset + j}");
				}
				s = puny.Encode(s, offset);
				s = "xn--" + s;
				break;
			}
		}
		VerifyLength(s, offset);
		return s;
	}

	private void VerifyLength(string s, int offset)
	{
		if (s.Length == 0)
		{
			throw new ArgumentException($"A label in the input string resulted in an invalid zero-length string, at {offset}");
		}
		if (s.Length > 63)
		{
			throw new ArgumentException($"A label in the input string exceeded the length in ASCII representation, at {offset}");
		}
	}

	private string NamePrep(string s, int offset)
	{
		s = s.Normalize(NormalizationForm.FormKC);
		VerifyProhibitedCharacters(s, offset);
		if (!allow_unassigned)
		{
			for (int i = 0; i < s.Length; i++)
			{
				if (char.GetUnicodeCategory(s, i) == UnicodeCategory.OtherNotAssigned)
				{
					throw new ArgumentException($"Use of unassigned Unicode characer is prohibited in this IdnMapping, at {offset + i}");
				}
			}
		}
		return s;
	}

	private void VerifyProhibitedCharacters(string s, int offset)
	{
		for (int i = 0; i < s.Length; i++)
		{
			switch (char.GetUnicodeCategory(s, i))
			{
			case UnicodeCategory.SpaceSeparator:
				if (s[i] < '\u0080')
				{
					continue;
				}
				break;
			case UnicodeCategory.Control:
				if (s[i] != 0 && s[i] < '\u0080')
				{
					continue;
				}
				break;
			default:
			{
				char c = s[i];
				if (('\ufddf' > c || c > '\ufdef') && (c & 0xFFFF) != 65534 && ('\ufff9' > c || c > '\ufffd') && ('⿰' > c || c > '⿻') && ('\u202a' > c || c > '\u202e') && ('\u206a' > c || c > '\u206f'))
				{
					switch (c)
					{
					case '\u0340':
					case '\u0341':
					case '\u200e':
					case '\u200f':
					case '\u2028':
					case '\u2029':
						break;
					default:
						continue;
					}
				}
				break;
			}
			case UnicodeCategory.Surrogate:
			case UnicodeCategory.PrivateUse:
				break;
			}
			throw new ArgumentException($"Not allowed character was in the input string, at {offset + i}");
		}
	}

	private void VerifyStd3AsciiRules(string s, int offset)
	{
		if (s.Length > 0 && s[0] == '-')
		{
			throw new ArgumentException($"'-' is not allowed at head of a sequence in STD3 mode, found at {offset}");
		}
		if (s.Length > 0 && s[s.Length - 1] == '-')
		{
			throw new ArgumentException($"'-' is not allowed at tail of a sequence in STD3 mode, found at {offset + s.Length - 1}");
		}
		for (int i = 0; i < s.Length; i++)
		{
			char c = s[i];
			if (c != '-' && (c <= '/' || (':' <= c && c <= '@') || ('[' <= c && c <= '`') || ('{' <= c && c <= '\u007f')))
			{
				throw new ArgumentException($"Not allowed character in STD3 mode, found at {offset + i}");
			}
		}
	}

	public string GetUnicode(string ascii)
	{
		if (ascii == null)
		{
			throw new ArgumentNullException("ascii");
		}
		return GetUnicode(ascii, 0, ascii.Length);
	}

	public string GetUnicode(string ascii, int index, int count)
	{
		if (ascii == null)
		{
			throw new ArgumentNullException("ascii");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index must be non-negative value");
		}
		if (count < 0 || index + count > ascii.Length)
		{
			throw new ArgumentOutOfRangeException("index + count must point inside the argument ascii string");
		}
		return Convert(ascii, index, count, toAscii: false);
	}

	private string ToUnicode(string s, int offset)
	{
		for (int i = 0; i < s.Length; i++)
		{
			if (s[i] >= '\u0080')
			{
				s = NamePrep(s, offset);
				break;
			}
		}
		if (!s.StartsWith("xn--", StringComparison.OrdinalIgnoreCase))
		{
			return s;
		}
		s = s.ToLower(CultureInfo.InvariantCulture);
		string strA = s;
		s = s.Substring(4);
		s = puny.Decode(s, offset);
		string result = s;
		s = ToAscii(s, offset);
		if (string.Compare(strA, s, StringComparison.OrdinalIgnoreCase) != 0)
		{
			throw new ArgumentException($"ToUnicode() failed at verifying the result, at label part from {offset}");
		}
		return result;
	}
}
