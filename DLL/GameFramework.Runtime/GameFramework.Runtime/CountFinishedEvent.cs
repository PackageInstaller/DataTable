using System.Threading;

namespace GameFramework.Runtime;

public class CountFinishedEvent
{
	private readonly ManualResetEvent resetEvent = new ManualResetEvent(initialState: false);

	private int count = 0;

	public CountFinishedEvent(int count)
	{
		this.count = count;
	}

	public bool Reset()
	{
		return resetEvent.Reset();
	}

	public bool Set()
	{
		if (Interlocked.Decrement(ref count) <= 0)
		{
			return resetEvent.Set();
		}
		return false;
	}

	public bool Wait()
	{
		return resetEvent.WaitOne();
	}

	public bool Wait(int millisecondsTimeout)
	{
		return resetEvent.WaitOne(millisecondsTimeout);
	}
}
