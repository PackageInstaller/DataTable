using System.IO;
using System.Text;
using UnityEngine.Localization.SmartFormat.Core.Formatting;
using UnityEngine.Localization.SmartFormat.Core.Output;

namespace UnityEngine.Localization.SmartFormat;

public static class SmartExtensions
{
	public static void AppendSmart(this StringBuilder sb, string format, params object[] args)
	{
		StringOutput output = new StringOutput(sb);
		Smart.Default.FormatInto(output, format, args);
	}

	public static void AppendLineSmart(this StringBuilder sb, string format, params object[] args)
	{
		sb.AppendSmart(format, args);
		sb.AppendLine();
	}

	public static void WriteSmart(this TextWriter writer, string format, params object[] args)
	{
		TextWriterOutput output = new TextWriterOutput(writer);
		Smart.Default.FormatInto(output, format, args);
	}

	public static void WriteLineSmart(this TextWriter writer, string format, params object[] args)
	{
		writer.WriteSmart(format, args);
		writer.WriteLine();
	}

	public static string FormatSmart(this string format, params object[] args)
	{
		return Smart.Format(format, args);
	}

	public static string FormatSmart(this string format, ref FormatCache cache, params object[] args)
	{
		return Smart.Default.FormatWithCache(ref cache, format, args);
	}
}
