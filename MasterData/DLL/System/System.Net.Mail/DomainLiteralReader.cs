using System.Net.Mime;

namespace System.Net.Mail;

internal static class DomainLiteralReader
{
	internal static int ReadReverse(string data, int index)
	{
		index--;
		do
		{
			index = WhitespaceReader.ReadFwsReverse(data, index);
			if (index < 0)
			{
				break;
			}
			int num = QuotedPairReader.CountQuotedChars(data, index, permitUnicodeEscaping: false);
			if (num > 0)
			{
				index -= num;
				continue;
			}
			if (data[index] == MailBnfHelper.StartSquareBracket)
			{
				return index - 1;
			}
			if (data[index] > MailBnfHelper.Ascii7bitMaxValue || !MailBnfHelper.Dtext[(uint)data[index]])
			{
				throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", data[index]));
			}
			index--;
		}
		while (index >= 0);
		throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", MailBnfHelper.EndSquareBracket));
	}
}
