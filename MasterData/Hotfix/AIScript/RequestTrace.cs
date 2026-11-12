namespace AIScript;

public class RequestTrace
{
	public int trancIndex;

	public TraceStatus traceStatus;

	public void Reset(int index)
	{
		trancIndex = index;
		traceStatus = TraceStatus.Traceing;
	}
}
