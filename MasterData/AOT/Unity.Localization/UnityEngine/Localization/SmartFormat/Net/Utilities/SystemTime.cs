using System;

namespace UnityEngine.Localization.SmartFormat.Net.Utilities;

internal static class SystemTime
{
	public static Func<DateTime> Now = () => DateTime.Now;

	public static Func<DateTimeOffset> OffsetNow = () => DateTimeOffset.Now;

	public static void SetDateTime(DateTime dateTimeNow)
	{
		Now = () => dateTimeNow;
	}

	public static void SetDateTimeOffset(DateTimeOffset dateTimeOffset)
	{
		OffsetNow = () => dateTimeOffset;
	}

	public static void ResetDateTime()
	{
		Now = () => DateTime.Now;
		OffsetNow = () => DateTimeOffset.Now;
	}
}
