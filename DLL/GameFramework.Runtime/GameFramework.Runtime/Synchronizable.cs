using System;
using System.Threading;

namespace GameFramework.Runtime;

internal class Synchronizable : ISynchronizable
{
	private IAsyncResult result;

	private object _lock;

	public Synchronizable(IAsyncResult result, object _lock)
	{
		this.result = result;
		this._lock = _lock;
	}

	public bool WaitForDone()
	{
		if (result.IsDone)
		{
			return result.IsDone;
		}
		lock (_lock)
		{
			if (!result.IsDone)
			{
				Monitor.Wait(_lock);
			}
		}
		return result.IsDone;
	}

	public object WaitForResult(int millisecondsTimeout = 0)
	{
		if (result.IsDone)
		{
			if (result.Exception != null)
			{
				throw result.Exception;
			}
			return result.Result;
		}
		lock (_lock)
		{
			if (!result.IsDone)
			{
				if (millisecondsTimeout > 0)
				{
					Monitor.Wait(_lock, millisecondsTimeout);
				}
				else
				{
					Monitor.Wait(_lock);
				}
			}
		}
		if (!result.IsDone)
		{
			throw new TimeoutException();
		}
		if (result.Exception != null)
		{
			throw result.Exception;
		}
		return result.Result;
	}

	public object WaitForResult(TimeSpan timeout)
	{
		if (result.IsDone)
		{
			if (result.Exception != null)
			{
				throw result.Exception;
			}
			return result.Result;
		}
		lock (_lock)
		{
			if (!result.IsDone)
			{
				Monitor.Wait(_lock, timeout);
			}
		}
		if (!result.IsDone)
		{
			throw new TimeoutException();
		}
		if (result.Exception != null)
		{
			throw result.Exception;
		}
		return result.Result;
	}
}
internal class Synchronizable<TResult> : ISynchronizable<TResult>, ISynchronizable
{
	private IAsyncResult<TResult> result;

	private object _lock;

	public Synchronizable(IAsyncResult<TResult> result, object _lock)
	{
		this.result = result;
		this._lock = _lock;
	}

	public bool WaitForDone()
	{
		if (result.IsDone)
		{
			return result.IsDone;
		}
		lock (_lock)
		{
			if (!result.IsDone)
			{
				Monitor.Wait(_lock);
			}
		}
		return result.IsDone;
	}

	public TResult WaitForResult(int millisecondsTimeout = 0)
	{
		if (result.IsDone)
		{
			if (result.Exception != null)
			{
				throw result.Exception;
			}
			return result.Result;
		}
		lock (_lock)
		{
			if (!result.IsDone)
			{
				if (millisecondsTimeout > 0)
				{
					Monitor.Wait(_lock, millisecondsTimeout);
				}
				else
				{
					Monitor.Wait(_lock);
				}
			}
		}
		if (!result.IsDone)
		{
			throw new TimeoutException();
		}
		if (result.Exception != null)
		{
			throw result.Exception;
		}
		return result.Result;
	}

	public TResult WaitForResult(TimeSpan timeout)
	{
		if (result.IsDone)
		{
			if (result.Exception != null)
			{
				throw result.Exception;
			}
			return result.Result;
		}
		lock (_lock)
		{
			if (!result.IsDone)
			{
				Monitor.Wait(_lock, timeout);
			}
		}
		if (!result.IsDone)
		{
			throw new TimeoutException();
		}
		if (result.Exception != null)
		{
			throw result.Exception;
		}
		return result.Result;
	}

	object ISynchronizable.WaitForResult(int millisecondsTimeout)
	{
		return WaitForResult(millisecondsTimeout);
	}

	object ISynchronizable.WaitForResult(TimeSpan timeout)
	{
		return WaitForResult(timeout);
	}
}
