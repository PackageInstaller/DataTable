using System.Net.Mime;

namespace System.Net.Mail;

internal static class QuotedPairReader
{
	internal static int CountQuotedChars(string data, int index, bool permitUnicodeEscaping)
	{
		if (index <= 0 || data[index - 1] != MailBnfHelper.Backslash)
		{
			return 0;
		}
		int num = CountBackslashes(data, index - 1);
		if (num % 2 == 0)
		{
			return 0;
		}
		if (!permitUnicodeEscaping && data[index] > MailBnfHelper.Ascii7bitMaxValue)
		{
			throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", data[index]));
		}
		return num + 1;
	}

	private static int CountBackslashes(string data, int index)
	{
		int num = 0;
		do
		{
			num++;
			index--;
		}
		while (index >= 0 && data[index] == MailBnfHelper.Backslash);
		return num;
	}
}
