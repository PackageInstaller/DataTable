using System.Net.Mime;

namespace System.Net.Mail;

internal static class WhitespaceReader
{
	internal static int ReadFwsReverse(string data, int index)
	{
		bool flag = false;
		while (index >= 0)
		{
			if ((data[index] == MailBnfHelper.CR) & flag)
			{
				flag = false;
			}
			else
			{
				if ((data[index] == MailBnfHelper.CR) | flag)
				{
					throw new FormatException("The specified string is not in the form required for an e-mail address.");
				}
				if (data[index] == MailBnfHelper.LF)
				{
					flag = true;
				}
				else if (data[index] != MailBnfHelper.Space && data[index] != MailBnfHelper.Tab)
				{
					break;
				}
			}
			index--;
		}
		if (flag)
		{
			throw new FormatException("The specified string is not in the form required for an e-mail address.");
		}
		return index;
	}

	internal static int ReadCfwsReverse(string data, int index)
	{
		int num = 0;
		for (index = ReadFwsReverse(data, index); index >= 0; index = ReadFwsReverse(data, index))
		{
			int num2 = QuotedPairReader.CountQuotedChars(data, index, permitUnicodeEscaping: true);
			if (num > 0 && num2 > 0)
			{
				index -= num2;
			}
			else if (data[index] == MailBnfHelper.EndComment)
			{
				num++;
				index--;
			}
			else if (data[index] == MailBnfHelper.StartComment)
			{
				num--;
				if (num < 0)
				{
					throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", MailBnfHelper.StartComment));
				}
				index--;
			}
			else
			{
				if (num <= 0 || (data[index] <= MailBnfHelper.Ascii7bitMaxValue && !MailBnfHelper.Ctext[(uint)data[index]]))
				{
					if (num <= 0)
					{
						break;
					}
					throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", data[index]));
				}
				index--;
			}
		}
		if (num > 0)
		{
			throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", MailBnfHelper.EndComment));
		}
		return index;
	}
}
