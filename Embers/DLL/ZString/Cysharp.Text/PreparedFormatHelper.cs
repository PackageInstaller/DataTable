using System;
using System.Buffers;
using System.Collections.Generic;
using System.Text;

namespace Cysharp.Text;

internal static class PreparedFormatHelper
{
	internal static Utf16FormatSegment[] Utf16Parse(string format)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		List<Utf16FormatSegment> list = new List<Utf16FormatSegment>();
		int i = 0;
		int length = format.Length;
		int num = 0;
		while (true)
		{
			if (i < length)
			{
				ParserScanResult parserScanResult = FormatParser.ScanFormatString(format, ref i);
				if (ParserScanResult.NormalChar == parserScanResult && i < length)
				{
					continue;
				}
				int num2 = i - num;
				if (ParserScanResult.EscapedChar == parserScanResult)
				{
					num2--;
				}
				if (num2 != 0)
				{
					list.Add(new Utf16FormatSegment(num, num2, -1, 0));
				}
				num = i;
				if (parserScanResult != ParserScanResult.BraceOpen)
				{
					continue;
				}
			}
			if (i >= length)
			{
				break;
			}
			FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
			num = parseResult.LastIndex;
			i = parseResult.LastIndex;
			list.Add(new Utf16FormatSegment(parseResult.LastIndex - parseResult.FormatString.Length - 1, parseResult.FormatString.Length, parseResult.Index, parseResult.Alignment));
		}
		return list.ToArray();
	}

	internal static Utf8FormatSegment[] Utf8Parse(string format, out byte[] utf8buffer)
	{
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		List<Utf8FormatSegment> list = new List<Utf8FormatSegment>();
		utf8buffer = new byte[Encoding.UTF8.GetMaxByteCount(format.Length)];
		int num = 0;
		int i = 0;
		int length = format.Length;
		int num2 = 0;
		while (true)
		{
			if (i < length)
			{
				ParserScanResult parserScanResult = FormatParser.ScanFormatString(format, ref i);
				if (ParserScanResult.NormalChar == parserScanResult && i < length)
				{
					continue;
				}
				int num3 = i - num2;
				if (ParserScanResult.EscapedChar == parserScanResult)
				{
					num3--;
				}
				if (num3 != 0)
				{
					int bytes = Encoding.UTF8.GetBytes(format, num2, num3, utf8buffer, num);
					list.Add(new Utf8FormatSegment(num, bytes, -1, default(StandardFormat), 0));
					num += bytes;
				}
				num2 = i;
				if (parserScanResult != ParserScanResult.BraceOpen)
				{
					continue;
				}
			}
			if (i >= length)
			{
				break;
			}
			FormatParser.ParseResult parseResult = FormatParser.Parse(format, i);
			num2 = parseResult.LastIndex;
			i = parseResult.LastIndex;
			list.Add(new Utf8FormatSegment(0, 0, parseResult.Index, StandardFormat.Parse(parseResult.FormatString), parseResult.Alignment));
		}
		return list.ToArray();
	}
}
