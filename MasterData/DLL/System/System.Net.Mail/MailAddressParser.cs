using System.Collections.Generic;
using System.Net.Mime;
using System.Text;

namespace System.Net.Mail;

internal static class MailAddressParser
{
	internal static MailAddress ParseAddress(string data)
	{
		int index = data.Length - 1;
		return ParseAddress(data, expectMultipleAddresses: false, ref index);
	}

	internal static List<MailAddress> ParseMultipleAddresses(string data)
	{
		List<MailAddress> list = new List<MailAddress>();
		for (int index = data.Length - 1; index >= 0; index--)
		{
			list.Insert(0, ParseAddress(data, expectMultipleAddresses: true, ref index));
		}
		return list;
	}

	private static MailAddress ParseAddress(string data, bool expectMultipleAddresses, ref int index)
	{
		string text = null;
		string text2 = null;
		string text3 = null;
		index = ReadCfwsAndThrowIfIncomplete(data, index);
		bool flag = false;
		if (data[index] == MailBnfHelper.EndAngleBracket)
		{
			flag = true;
			index--;
		}
		text = ParseDomain(data, ref index);
		if (data[index] != MailBnfHelper.At)
		{
			throw new FormatException("The specified string is not in the form required for an e-mail address.");
		}
		index--;
		text2 = ParseLocalPart(data, ref index, flag, expectMultipleAddresses);
		if (flag)
		{
			if (index < 0 || data[index] != MailBnfHelper.StartAngleBracket)
			{
				throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", (index >= 0) ? data[index] : MailBnfHelper.EndAngleBracket));
			}
			index--;
			index = WhitespaceReader.ReadFwsReverse(data, index);
		}
		text3 = ((index < 0 || (expectMultipleAddresses && data[index] == MailBnfHelper.Comma)) ? string.Empty : ParseDisplayName(data, ref index, expectMultipleAddresses));
		return new MailAddress(text3, text2, text);
	}

	private static int ReadCfwsAndThrowIfIncomplete(string data, int index)
	{
		index = WhitespaceReader.ReadCfwsReverse(data, index);
		if (index < 0)
		{
			throw new FormatException("The specified string is not in the form required for an e-mail address.");
		}
		return index;
	}

	private static string ParseDomain(string data, ref int index)
	{
		index = ReadCfwsAndThrowIfIncomplete(data, index);
		int num = index;
		if (data[index] == MailBnfHelper.EndSquareBracket)
		{
			index = DomainLiteralReader.ReadReverse(data, index);
		}
		else
		{
			index = DotAtomReader.ReadReverse(data, index);
		}
		string input = data.Substring(index + 1, num - index);
		index = ReadCfwsAndThrowIfIncomplete(data, index);
		return NormalizeOrThrow(input);
	}

	private static string ParseLocalPart(string data, ref int index, bool expectAngleBracket, bool expectMultipleAddresses)
	{
		index = ReadCfwsAndThrowIfIncomplete(data, index);
		int num = index;
		if (data[index] == MailBnfHelper.Quote)
		{
			index = QuotedStringFormatReader.ReadReverseQuoted(data, index, permitUnicode: true);
		}
		else
		{
			index = DotAtomReader.ReadReverse(data, index);
			if (index >= 0 && !MailBnfHelper.IsAllowedWhiteSpace(data[index]) && data[index] != MailBnfHelper.EndComment && (!expectAngleBracket || data[index] != MailBnfHelper.StartAngleBracket) && (!expectMultipleAddresses || data[index] != MailBnfHelper.Comma) && data[index] != MailBnfHelper.Quote)
			{
				throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", data[index]));
			}
		}
		string input = data.Substring(index + 1, num - index);
		index = WhitespaceReader.ReadCfwsReverse(data, index);
		return NormalizeOrThrow(input);
	}

	private static string ParseDisplayName(string data, ref int index, bool expectMultipleAddresses)
	{
		int num = WhitespaceReader.ReadCfwsReverse(data, index);
		string input;
		if (num >= 0 && data[num] == MailBnfHelper.Quote)
		{
			index = QuotedStringFormatReader.ReadReverseQuoted(data, num, permitUnicode: true);
			int num2 = index + 2;
			input = data.Substring(num2, num - num2);
			index = WhitespaceReader.ReadCfwsReverse(data, index);
			if (index >= 0 && (!expectMultipleAddresses || data[index] != MailBnfHelper.Comma))
			{
				throw new FormatException(global::SR.Format("An invalid character was found in the mail header: '{0}'.", data[index]));
			}
		}
		else
		{
			int num3 = index;
			index = QuotedStringFormatReader.ReadReverseUnQuoted(data, index, permitUnicode: true, expectMultipleAddresses);
			input = data.SubstringTrim(index + 1, num3 - index);
		}
		return NormalizeOrThrow(input);
	}

	internal static string NormalizeOrThrow(string input)
	{
		try
		{
			return input.Normalize(NormalizationForm.FormC);
		}
		catch (ArgumentException innerException)
		{
			throw new FormatException("The specified string is not in the form required for an e-mail address.", innerException);
		}
	}
}
