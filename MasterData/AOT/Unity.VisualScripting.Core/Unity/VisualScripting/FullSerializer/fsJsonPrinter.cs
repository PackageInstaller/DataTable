using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;

namespace Unity.VisualScripting.FullSerializer;

public static class fsJsonPrinter
{
	private static void InsertSpacing(TextWriter stream, int count)
	{
		for (int i = 0; i < count; i++)
		{
			stream.Write("    ");
		}
	}

	private static string EscapeString(string str)
	{
		bool flag = false;
		foreach (char c in str)
		{
			int num = Convert.ToInt32(c);
			if (num < 0 || num > 127)
			{
				flag = true;
				break;
			}
			switch (c)
			{
			case '\0':
			case '\a':
			case '\b':
			case '\t':
			case '\n':
			case '\f':
			case '\r':
			case '"':
			case '\\':
				flag = true;
				break;
			}
			if (flag)
			{
				break;
			}
		}
		if (!flag)
		{
			return str;
		}
		StringBuilder stringBuilder = new StringBuilder();
		foreach (char c2 in str)
		{
			int num2 = Convert.ToInt32(c2);
			if (num2 < 0 || num2 > 127)
			{
				stringBuilder.Append($"\\u{num2:x4} ".Trim());
				continue;
			}
			switch (c2)
			{
			case '"':
				stringBuilder.Append("\\\"");
				break;
			case '\\':
				stringBuilder.Append("\\\\");
				break;
			case '\a':
				stringBuilder.Append("\\a");
				break;
			case '\b':
				stringBuilder.Append("\\b");
				break;
			case '\f':
				stringBuilder.Append("\\f");
				break;
			case '\n':
				stringBuilder.Append("\\n");
				break;
			case '\r':
				stringBuilder.Append("\\r");
				break;
			case '\t':
				stringBuilder.Append("\\t");
				break;
			case '\0':
				stringBuilder.Append("\\0");
				break;
			default:
				stringBuilder.Append(c2);
				break;
			}
		}
		return stringBuilder.ToString();
	}

	private static void BuildCompressedString(fsData data, TextWriter stream)
	{
		switch (data.Type)
		{
		case fsDataType.Null:
			stream.Write("null");
			break;
		case fsDataType.Boolean:
			if (data.AsBool)
			{
				stream.Write("true");
			}
			else
			{
				stream.Write("false");
			}
			break;
		case fsDataType.Double:
			stream.Write(ConvertDoubleToString(data.AsDouble));
			break;
		case fsDataType.Int64:
			stream.Write(data.AsInt64);
			break;
		case fsDataType.String:
			stream.Write('"');
			stream.Write(EscapeString(data.AsString));
			stream.Write('"');
			break;
		case fsDataType.Object:
		{
			stream.Write('{');
			bool flag2 = false;
			foreach (KeyValuePair<string, fsData> item in data.AsDictionary)
			{
				if (flag2)
				{
					stream.Write(',');
				}
				flag2 = true;
				stream.Write('"');
				stream.Write(item.Key);
				stream.Write('"');
				stream.Write(":");
				BuildCompressedString(item.Value, stream);
			}
			stream.Write('}');
			break;
		}
		case fsDataType.Array:
		{
			stream.Write('[');
			bool flag = false;
			foreach (fsData @as in data.AsList)
			{
				if (flag)
				{
					stream.Write(',');
				}
				flag = true;
				BuildCompressedString(@as, stream);
			}
			stream.Write(']');
			break;
		}
		}
	}

	private static void BuildPrettyString(fsData data, TextWriter stream, int depth)
	{
		switch (data.Type)
		{
		case fsDataType.Null:
			stream.Write("null");
			break;
		case fsDataType.Boolean:
			if (data.AsBool)
			{
				stream.Write("true");
			}
			else
			{
				stream.Write("false");
			}
			break;
		case fsDataType.Double:
			stream.Write(ConvertDoubleToString(data.AsDouble));
			break;
		case fsDataType.Int64:
			stream.Write(data.AsInt64);
			break;
		case fsDataType.String:
			stream.Write('"');
			stream.Write(EscapeString(data.AsString));
			stream.Write('"');
			break;
		case fsDataType.Object:
		{
			stream.Write('{');
			stream.WriteLine();
			bool flag2 = false;
			foreach (KeyValuePair<string, fsData> item in data.AsDictionary)
			{
				if (flag2)
				{
					stream.Write(',');
					stream.WriteLine();
				}
				flag2 = true;
				InsertSpacing(stream, depth + 1);
				stream.Write('"');
				stream.Write(item.Key);
				stream.Write('"');
				stream.Write(": ");
				BuildPrettyString(item.Value, stream, depth + 1);
			}
			stream.WriteLine();
			InsertSpacing(stream, depth);
			stream.Write('}');
			break;
		}
		case fsDataType.Array:
		{
			if (data.AsList.Count == 0)
			{
				stream.Write("[]");
				break;
			}
			bool flag = false;
			stream.Write('[');
			stream.WriteLine();
			foreach (fsData @as in data.AsList)
			{
				if (flag)
				{
					stream.Write(',');
					stream.WriteLine();
				}
				flag = true;
				InsertSpacing(stream, depth + 1);
				BuildPrettyString(@as, stream, depth + 1);
			}
			stream.WriteLine();
			InsertSpacing(stream, depth);
			stream.Write(']');
			break;
		}
		}
	}

	public static void PrettyJson(fsData data, TextWriter outputStream)
	{
		BuildPrettyString(data, outputStream, 0);
	}

	public static string PrettyJson(fsData data)
	{
		StringBuilder stringBuilder = new StringBuilder();
		using StringWriter stream = new StringWriter(stringBuilder);
		BuildPrettyString(data, stream, 0);
		return stringBuilder.ToString();
	}

	public static void CompressedJson(fsData data, StreamWriter outputStream)
	{
		BuildCompressedString(data, outputStream);
	}

	public static string CompressedJson(fsData data)
	{
		StringBuilder stringBuilder = new StringBuilder();
		using StringWriter stream = new StringWriter(stringBuilder);
		BuildCompressedString(data, stream);
		return stringBuilder.ToString();
	}

	private static string ConvertDoubleToString(double d)
	{
		if (double.IsInfinity(d) || double.IsNaN(d))
		{
			return d.ToString(CultureInfo.InvariantCulture);
		}
		string text = d.ToString(CultureInfo.InvariantCulture);
		if (!text.Contains(".") && !text.Contains("e") && !text.Contains("E"))
		{
			text += ".0";
		}
		return text;
	}
}
