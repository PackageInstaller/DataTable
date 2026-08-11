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

	internal static bool IsAllowedWhiteSpace(char c)
	{
		if (c != Tab && c != Space && c != CR)
		{
			return c == LF;
		}
		return true;
	}
}
