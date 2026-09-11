namespace System.Threading;

internal static class PlatformHelper
{
	private static volatile int s_processorCount;

	private static volatile int s_lastProcessorCountRefreshTicks;

	internal static readonly bool IsSingleProcessor = ProcessorCount == 1;

	internal static int ProcessorCount
	{
		get
		{
			int tickCount = Environment.TickCount;
			int num = s_processorCount;
			if (num == 0 || tickCount - s_lastProcessorCountRefreshTicks >= 30000)
			{
				num = (s_processorCount = Environment.ProcessorCount);
				s_lastProcessorCountRefreshTicks = tickCount;
			}
			return num;
		}
	}
}
