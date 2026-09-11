namespace System.Threading;

internal static class ThreadPoolGlobals
{
	public static int processorCount = Environment.ProcessorCount;

	public static volatile bool vmTpInitialized;

	public static bool enableWorkerTracking;

	public static readonly ThreadPoolWorkQueue workQueue = new ThreadPoolWorkQueue();
}
