namespace System.Threading;

internal static class TimeoutHelper
{
	public static uint GetTime()
	{
		return (uint)Environment.TickCount;
	}

	public static int UpdateTimeOut(uint startTime, int originalWaitMillisecondsTimeout)
	{
		uint num = GetTime() - startTime;
		if (num > int.MaxValue)
		{
			return 0;
		}
		int num2 = originalWaitMillisecondsTimeout - (int)num;
		if (num2 <= 0)
		{
			return 0;
		}
		return num2;
	}
}
