using System;

namespace GameFramework.Runtime;

public static class TimerTimeUtility
{
	private static readonly long Epoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc).Ticks;

	public static long Now()
	{
		return (DateTime.UtcNow.Ticks - Epoch) / 10000;
	}
}
