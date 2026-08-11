namespace System.Diagnostics;

public sealed class Trace
{
	private static volatile CorrelationManager correlationManager;

	public static TraceListenerCollection Listeners => TraceInternal.Listeners;

	public static bool AutoFlush => TraceInternal.AutoFlush;

	public static CorrelationManager CorrelationManager
	{
		get
		{
			if (correlationManager == null)
			{
				correlationManager = new CorrelationManager();
			}
			return correlationManager;
		}
	}
}
