namespace System.Threading;

public class Lock
{
	private object _lock = new object();

	public void Acquire()
	{
		Monitor.Enter(_lock);
	}

	public void Release()
	{
		Monitor.Exit(_lock);
	}
}
