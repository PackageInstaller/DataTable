using System;
using UnityEngine;

public static class TimeUtil
{
	public static TimerCenter NewUnityTimer()
	{
		return new TimerCenter(() => (long)(Time.time * 1000f));
	}

	public static string DescLeftTime(int secs)
	{
		int num = secs % 60;
		int num2 = secs / 60;
		if (num2 > 60)
		{
			num2 = 60;
		}
		return $"{num2:D2}:{num:D2}";
	}

	public static uint GetSystemTime()
	{
		return (uint)DateTime.Now.Ticks / 10000;
	}

	public static long TickToMilliSec(long tick)
	{
		return tick / 10000;
	}
}
