namespace System;

[Serializable]
[Obsolete("System.TimeZone has been deprecated.  Please investigate the use of System.TimeZoneInfo instead.")]
public abstract class TimeZone
{
	private static volatile TimeZone currentTimeZone;

	internal static void ClearCachedData()
	{
		currentTimeZone = null;
	}
}
