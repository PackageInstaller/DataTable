using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace UnityEngine.Localization.SmartFormat.Utilities;

internal static class TimeSpanFormatOptionsConverter
{
	private static readonly Regex parser = new Regex("\\b(w|week|weeks|d|day|days|h|hour|hours|m|minute|minutes|s|second|seconds|ms|millisecond|milliseconds|auto|short|fill|full|abbr|noabbr|less|noless)\\b", RegexOptions.IgnoreCase | RegexOptions.Compiled);

	public static TimeSpanFormatOptions Merge(this TimeSpanFormatOptions left, TimeSpanFormatOptions right)
	{
		TimeSpanFormatOptions[] array = new TimeSpanFormatOptions[4]
		{
			TimeSpanFormatOptions.Abbreviate | TimeSpanFormatOptions.AbbreviateOff,
			TimeSpanFormatOptions.LessThan | TimeSpanFormatOptions.LessThanOff,
			TimeSpanFormatOptions.RangeMilliSeconds | TimeSpanFormatOptions.RangeSeconds | TimeSpanFormatOptions.RangeMinutes | TimeSpanFormatOptions.RangeHours | TimeSpanFormatOptions.RangeDays | TimeSpanFormatOptions.RangeWeeks,
			TimeSpanFormatOptions.TruncateShortest | TimeSpanFormatOptions.TruncateAuto | TimeSpanFormatOptions.TruncateFill | TimeSpanFormatOptions.TruncateFull
		};
		foreach (TimeSpanFormatOptions timeSpanFormatOptions in array)
		{
			if ((left & timeSpanFormatOptions) == 0)
			{
				left |= right & timeSpanFormatOptions;
			}
		}
		return left;
	}

	public static TimeSpanFormatOptions Mask(this TimeSpanFormatOptions timeSpanFormatOptions, TimeSpanFormatOptions mask)
	{
		return timeSpanFormatOptions & mask;
	}

	public static IEnumerable<TimeSpanFormatOptions> AllFlags(this TimeSpanFormatOptions timeSpanFormatOptions)
	{
		for (uint value = 1u; value <= (uint)timeSpanFormatOptions; value <<= 1)
		{
			if ((value & (uint)timeSpanFormatOptions) != 0)
			{
				yield return (TimeSpanFormatOptions)value;
			}
		}
	}

	public static TimeSpanFormatOptions Parse(string formatOptionsString)
	{
		formatOptionsString = formatOptionsString.ToLower();
		TimeSpanFormatOptions timeSpanFormatOptions = TimeSpanFormatOptions.InheritDefaults;
		foreach (Match item in parser.Matches(formatOptionsString))
		{
			switch (item.Value)
			{
			case "w":
			case "week":
			case "weeks":
				timeSpanFormatOptions |= TimeSpanFormatOptions.RangeWeeks;
				break;
			case "d":
			case "day":
			case "days":
				timeSpanFormatOptions |= TimeSpanFormatOptions.RangeDays;
				break;
			case "h":
			case "hour":
			case "hours":
				timeSpanFormatOptions |= TimeSpanFormatOptions.RangeHours;
				break;
			case "m":
			case "minute":
			case "minutes":
				timeSpanFormatOptions |= TimeSpanFormatOptions.RangeMinutes;
				break;
			case "s":
			case "second":
			case "seconds":
				timeSpanFormatOptions |= TimeSpanFormatOptions.RangeSeconds;
				break;
			case "ms":
			case "millisecond":
			case "milliseconds":
				timeSpanFormatOptions |= TimeSpanFormatOptions.RangeMilliSeconds;
				break;
			case "short":
				timeSpanFormatOptions |= TimeSpanFormatOptions.TruncateShortest;
				break;
			case "auto":
				timeSpanFormatOptions |= TimeSpanFormatOptions.TruncateAuto;
				break;
			case "fill":
				timeSpanFormatOptions |= TimeSpanFormatOptions.TruncateFill;
				break;
			case "full":
				timeSpanFormatOptions |= TimeSpanFormatOptions.TruncateFull;
				break;
			case "abbr":
				timeSpanFormatOptions |= TimeSpanFormatOptions.Abbreviate;
				break;
			case "noabbr":
				timeSpanFormatOptions |= TimeSpanFormatOptions.AbbreviateOff;
				break;
			case "less":
				timeSpanFormatOptions |= TimeSpanFormatOptions.LessThan;
				break;
			case "noless":
				timeSpanFormatOptions |= TimeSpanFormatOptions.LessThanOff;
				break;
			}
		}
		return timeSpanFormatOptions;
	}
}
