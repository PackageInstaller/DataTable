using System.Net.Mime;

namespace System.Net.Mail;

internal static class QuotedStringFormatReader
{
	internal static int ReadReverseQuoted(string data, int index, bool permitUnicode)
	{
		index--;
		do
		{
			index = WhitespaceReader.ReadFwsReverse(data, index);
			if (index < 0)
			{
				break;
			}
			int num = QuotedPairReader.CountQuotedChars(data, index, permitUnicode);
			if (num > 0)
			{
				index -= num;
				continue;
			}
			if (data[index] == MailBnfHelper.Quote)
			{
				return index - 1;
			}
			if (!IsValidQtext(permitUnicode, data[index]))
			{
				throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", data[index]));
			}
			index--;
		}
		while (index >= 0);
		throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", MailBnfHelper.Quote));
	}

	internal static int ReadReverseUnQuoted(string data, int index, bool permitUnicode, bool expectCommaDelimiter)
	{
		do
		{
			index = WhitespaceReader.ReadFwsReverse(data, index);
			if (index < 0)
			{
				break;
			}
			int num = QuotedPairReader.CountQuotedChars(data, index, permitUnicode);
			if (num > 0)
			{
				index -= num;
				continue;
			}
			if (expectCommaDelimiter && data[index] == MailBnfHelper.Comma)
			{
				break;
			}
			if (!IsValidQtext(permitUnicode, data[index]))
			{
				throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", data[index]));
			}
			index--;
		}
		while (index >= 0);
		return index;
	}

	private static bool IsValidQtext(bool allowUnicode, char ch)
	{
		if (ch > MailBnfHelper.Ascii7bitMaxValue)
		{
			return allowUnicode;
		}
		return MailBnfHelper.Qtext[(uint)ch];
	}
}
