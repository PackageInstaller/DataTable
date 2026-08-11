#define ENABLE_LOG
using System;

namespace GameFramework.Runtime;

internal class Callbackable : ICallbackable
{
	private IAsyncResult result;

	private readonly object _lock = new object();

	private Action<IAsyncResult> callback;

	public Callbackable(IAsyncResult result)
	{
		this.result = result;
	}

	public void RaiseOnCallback()
	{
		lock (_lock)
		{
			try
			{
				if (callback == null)
				{
					return;
				}
				Delegate[] invocationList = callback.GetInvocationList();
				callback = null;
				Delegate[] array = invocationList;
				for (int i = 0; i < array.Length; i++)
				{
					Action<IAsyncResult> action = (Action<IAsyncResult>)array[i];
					try
					{
						action(result);
					}
					catch (Exception arg)
					{
						Log.Warning("Class[{0}] callback exception.Error:{1}", GetType(), arg);
					}
				}
			}
			catch (Exception arg2)
			{
				Log.Warning("Class[{0}] callback exception.Error:{1}", GetType(), arg2);
			}
		}
	}

	public void OnCallback(Action<IAsyncResult> callback)
	{
		lock (_lock)
		{
			if (callback == null)
			{
				return;
			}
			if (result.IsDone)
			{
				try
				{
					callback(result);
					return;
				}
				catch (Exception arg)
				{
					Log.Warning("Class[{0}] callback exception.Error:{1}", GetType(), arg);
					return;
				}
			}
			this.callback = (Action<IAsyncResult>)Delegate.Combine(this.callback, callback);
		}
	}
}
internal class Callbackable<TResult> : ICallbackable<TResult>
{
	private IAsyncResult<TResult> result;

	private readonly object _lock = new object();

	private Action<IAsyncResult<TResult>> callback;

	public Callbackable(IAsyncResult<TResult> result)
	{
		this.result = result;
	}

	public void RaiseOnCallback()
	{
		lock (_lock)
		{
			try
			{
				if (callback == null)
				{
					return;
				}
				Delegate[] invocationList = callback.GetInvocationList();
				callback = null;
				Delegate[] array = invocationList;
				for (int i = 0; i < array.Length; i++)
				{
					Action<IAsyncResult<TResult>> action = (Action<IAsyncResult<TResult>>)array[i];
					try
					{
						action(result);
					}
					catch (Exception arg)
					{
						Log.Warning("Class[{0}] callback exception.Error:{1}", GetType(), arg);
					}
				}
			}
			catch (Exception arg2)
			{
				Log.Warning("Class[{0}] callback exception.Error:{1}", GetType(), arg2);
			}
		}
	}

	public void OnCallback(Action<IAsyncResult<TResult>> callback)
	{
		lock (_lock)
		{
			if (callback == null)
			{
				return;
			}
			if (result.IsDone)
			{
				try
				{
					callback(result);
					return;
				}
				catch (Exception arg)
				{
					Log.Warning("Class[{0}] callback exception.Error:{1}", GetType(), arg);
					return;
				}
			}
			this.callback = (Action<IAsyncResult<TResult>>)Delegate.Combine(this.callback, callback);
		}
	}
}
