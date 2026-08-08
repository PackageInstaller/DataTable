using System.Text;

namespace System.Net.Mime;

internal static class MailBnfHelper
{
	internal static readonly bool[] Atext = CreateCharactersAllowedInAtoms();

	internal static readonly bool[] Qtext = CreateCharactersAllowedInQuotedStrings();

	internal static readonly bool[] Dtext = CreateCharactersAllowedInDomainLiterals();

	internal static readonly bool[] Ftext = CreateCharactersAllowedInHeaderNames();

	internal static readonly bool[] Ttext = CreateCharactersAllowedInTokens();

	internal static readonly bool[] Ctext = CreateCharactersAllowedInComments();

	internal static readonly int Ascii7bitMaxValue = 127;

	internal static readonly char Quote = '"';

	internal static readonly char Space = ' ';

	internal static readonly char Tab = '\t';

	internal static readonly char CR = '\r';

	internal static readonly char LF = '\n';

	internal static readonly char StartComment = '(';

	internal static readonly char EndComment = ')';

	internal static readonly char Backslash = '\\';

	internal static readonly char At = '@';

	internal static readonly char EndAngleBracket = '>';

	internal static readonly char StartAngleBracket = '<';

	internal static readonly char StartSquareBracket = '[';

	internal static readonly char EndSquareBracket = ']';

	internal static readonly char Comma = ',';

	internal static readonly char Dot = '.';

	private static readonly char[] s_colonSeparator = new char[1] { ':' };

	private static string[] s_months = new string[13]
	{
		null, "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep",
		"Oct", "Nov", "Dec"
	};

	private static bool[] CreateCharactersAllowedInAtoms()
	{
		bool[] array = new bool[128];
		for (int i = 48; i <= 57; i++)
		{
			array[i] = true;
		}
		for (int j = 65; j <= 90; j++)
		{
			array[j] = true;
		}
		for (int k = 97; k <= 122; k++)
		{
			array[k] = true;
		}
		array[33] = true;
		array[35] = true;
		array[36] = true;
		array[37] = true;
		array[38] = true;
		array[39] = true;
		array[42] = true;
		array[43] = true;
		array[45] = true;
		array[47] = true;
		array[61] = true;
		array[63] = true;
		array[94] = true;
		array[95] = true;
		array[96] = true;
		array[123] = true;
		array[124] = true;
		array[125] = true;
		array[126] = true;
		return array;
	}

	private static bool[] CreateCharactersAllowedInQuotedStrings()
	{
		bool[] array = new bool[128];
		for (int i = 1; i <= 9; i++)
		{
			array[i] = true;
		}
		array[11] = true;
		array[12] = true;
		for (int j = 14; j <= 33; j++)
		{
			array[j] = true;
		}
		for (int k = 35; k <= 91; k++)
		{
			array[k] = true;
		}
		for (int l = 93; l <= 127; l++)
		{
			array[l] = true;
		}
		return array;
	}

	private static bool[] CreateCharactersAllowedInDomainLiterals()
	{
		bool[] array = new bool[128];
		for (int i = 1; i <= 8; i++)
		{
			array[i] = true;
		}
		array[11] = true;
		array[12] = true;
		for (int j = 14; j <= 31; j++)
		{
			array[j] = true;
		}
		for (int k = 33; k <= 90; k++)
		{
			array[k] = true;
		}
		for (int l = 94; l <= 127; l++)
		{
			array[l] = true;
		}
		return array;
	}

	private static bool[] CreateCharactersAllowedInHeaderNames()
	{
		bool[] array = new bool[128];
		for (int i = 33; i <= 57; i++)
		{
			array[i] = true;
		}
		for (int j = 59; j <= 126; j++)
		{
			array[j] = true;
		}
		return array;
	}

	private static bool[] CreateCharactersAllowedInTokens()
	{
		bool[] array = new bool[128];
		for (int i = 33; i <= 126; i++)
		{
			array[i] = true;
		}
		array[40] = false;
		array[41] = false;
		array[60] = false;
		array[62] = false;
		array[64] = false;
		array[44] = false;
		array[59] = false;
		array[58] = false;
		array[92] = false;
		array[34] = false;
		array[47] = false;
		array[91] = false;
		array[93] = false;
		array[63] = false;
		array[61] = false;
		return array;
	}

	private static bool[] CreateCharactersAllowedInComments()
	{
		bool[] array = new bool[128];
		for (int i = 1; i <= 8; i++)
		{
			array[i] = true;
		}
		array[11] = true;
		array[12] = true;
		for (int j = 14; j <= 31; j++)
		{
			array[j] = true;
		}
		for (int k = 33; k <= 39; k++)
		{
			array[k] = true;
		}
		for (int l = 42; l <= 91; l++)
		{
			array[l] = true;
		}
		for (int m = 93; m <= 127; m++)
		{
			array[m] = true;
		}
		return array;
	}

	internal static bool SkipCFWS(string data, ref int offset)
	{
		int num = 0;
		while (offset < data.Length)
		{
			if (data[offset] > '\u007f')
			{
				throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", data[offset]));
			}
			if (data[offset] == '\\' && num > 0)
			{
				offset += 2;
			}
			else if (data[offset] == '(')
			{
				num++;
			}
			else if (data[offset] == ')')
			{
				num--;
			}
			else if (data[offset] != ' ' && data[offset] != '\t' && num == 0)
			{
				return true;
			}
			if (num < 0)
			{
				throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", data[offset]));
			}
			offset++;
		}
		return false;
	}

	internal static string ReadQuotedString(string data, ref int offset, StringBuilder builder)
	{
		return ReadQuotedString(data, ref offset, builder, doesntRequireQuotes: false, permitUnicodeInDisplayName: false);
	}

	internal static string ReadQuotedString(string data, ref int offset, StringBuilder builder, bool doesntRequireQuotes, bool permitUnicodeInDisplayName)
	{
		if (!doesntRequireQuotes)
		{
			offset++;
		}
		int num = offset;
		StringBuilder stringBuilder = ((builder != null) ? builder : new StringBuilder());
		while (offset < data.Length)
		{
			if (data[offset] == '\\')
			{
				stringBuilder.Append(data, num, offset - num);
				num = ++offset;
			}
			else
			{
				if (data[offset] == '"')
				{
					stringBuilder.Append(data, num, offset - num);
					offset++;
					if (builder == null)
					{
						return stringBuilder.ToString();
					}
					return null;
				}
				if (data[offset] == '=' && data.Length > offset + 3 && data[offset + 1] == '\r' && data[offset + 2] == '\n' && (data[offset + 3] == ' ' || data[offset + 3] == '\t'))
				{
					offset += 3;
				}
				else if (permitUnicodeInDisplayName)
				{
					if (data[offset] <= Ascii7bitMaxValue && !Qtext[(uint)data[offset]])
					{
						throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", data[offset]));
					}
				}
				else if (data[offset] > Ascii7bitMaxValue || !Qtext[(uint)data[offset]])
				{
					throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", data[offset]));
				}
			}
			offset++;
		}
		if (doesntRequireQuotes)
		{
			stringBuilder.Append(data, num, offset - num);
			if (builder == null)
			{
				return stringBuilder.ToString();
			}
			return null;
		}
		throw new FormatException("The mail header is malformed.");
	}

	internal static string ReadParameterAttribute(string data, ref int offset, StringBuilder builder)
	{
		if (!SkipCFWS(data, ref offset))
		{
			return null;
		}
		return ReadToken(data, ref offset, null);
	}

	internal static string ReadToken(string data, ref int offset, StringBuilder builder)
	{
		int num = offset;
		while (offset < data.Length)
		{
			if (data[offset] > Ascii7bitMaxValue)
			{
				throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", data[offset]));
			}
			if (!Ttext[(uint)data[offset]])
			{
				break;
			}
			offset++;
		}
		if (num == offset)
		{
			throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", data[offset]));
		}
		return data.Substring(num, offset - num);
	}

	internal static void GetTokenOrQuotedString(string data, StringBuilder builder, bool allowUnicode)
	{
		int i = 0;
		int num = 0;
		for (; i < data.Length; i++)
		{
			if (CheckForUnicode(data[i], allowUnicode) || (Ttext[(uint)data[i]] && data[i] != ' '))
			{
				continue;
			}
			builder.Append('"');
			for (; i < data.Length; i++)
			{
				if (!CheckForUnicode(data[i], allowUnicode))
				{
					if (IsFWSAt(data, i))
					{
						i += 2;
					}
					else if (!Qtext[(uint)data[i]])
					{
						builder.Append(data, num, i - num);
						builder.Append('\\');
						num = i;
					}
				}
			}
			builder.Append(data, num, i - num);
			builder.Append('"');
			return;
		}
		if (data.Length == 0)
		{
			builder.Append("\"\"");
		}
		builder.Append(data);
	}

	private static bool CheckForUnicode(char ch, bool allowUnicode)
	{
		if (ch < Ascii7bitMaxValue)
		{
			return false;
		}
		if (!allowUnicode)
		{
			throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", ch));
		}
		return true;
	}

	internal static bool IsAllowedWhiteSpace(char c)
	{
		if (c != Tab && c != Space && c != CR)
		{
			return c == LF;
		}
		return true;
	}

	internal static bool HasCROrLF(string data)
	{
		for (int i = 0; i < data.Length; i++)
		{
			if (data[i] == '\r' || data[i] == '\n')
			{
				return true;
			}
		}
		return false;
	}

	internal static bool IsFWSAt(string data, int index)
	{
		if (data[index] == CR && index + 2 < data.Length && data[index + 1] == LF)
		{
			if (data[index + 2] != Space)
			{
				return data[index + 2] == Tab;
			}
			return true;
		}
		return false;
	}
}
