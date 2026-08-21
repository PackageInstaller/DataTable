#define ENABLE_DEBUG_AND_ABOVE_LOG
#define ENABLE_WARNING_AND_ABOVE_LOG
using System;
using System.Collections;
using System.Threading;
using System.Threading.Tasks;

namespace GameFramework.Runtime;

public class AsyncTask : IAsyncTask, IAsyncResult
{
	private Action action;

	private Action preCallbackOnMainThread;

	private Action preCallbackOnWorkerThread;

	private Action postCallbackOnMainThread;

	private Action postCallbackOnWorkerThread;

	private Action<Exception> errorCallbackOnMainThread;

	private Action<Exception> errorCallbackOnWorkerThread;

	private Action finishCallbackOnMainThread;

	private Action finishCallbackOnWorkerThread;

	private int running = 0;

	private AsyncResult result;

	public virtual object Result => result.Result;

	public virtual Exception Exception => result.Exception;

	public virtual bool IsDone => result.IsDone && running == 0;

	public virtual bool IsCancelled => result.IsCancelled;

	public AsyncTask(Action task, bool runOnMainThread = false)
	{
		AsyncTask asyncTask = this;
		if (task == null)
		{
			throw new ArgumentNullException("task");
		}
		result = new AsyncResult();
		if (runOnMainThread)
		{
			action = WrapAction(delegate
			{
				Executors.RunOnMainThread(task, waitForExecution: true);
				asyncTask.result.SetResult();
			});
		}
		else
		{
			action = WrapAction(delegate
			{
				task();
				asyncTask.result.SetResult();
			});
		}
	}

	public AsyncTask(Action<IPromise> task, bool runOnMainThread = false, bool cancelable = false)
	{
		AsyncTask asyncTask = this;
		if (task == null)
		{
			throw new ArgumentNullException("task");
		}
		result = new AsyncResult(!runOnMainThread & cancelable);
		if (runOnMainThread)
		{
			action = WrapAction(delegate
			{
				Executors.RunOnMainThread(delegate
				{
					task(asyncTask.result);
				}, waitForExecution: true);
				asyncTask.result.Synchronized().WaitForResult();
			});
		}
		else
		{
			action = WrapAction(delegate
			{
				task(asyncTask.result);
				asyncTask.result.Synchronized().WaitForResult();
			});
		}
	}

	public AsyncTask(IEnumerator task, bool cancelable = false)
	{
		AsyncTask asyncTask = this;
		if (task == null)
		{
			throw new ArgumentNullException("task");
		}
		result = new AsyncResult(cancelable);
		action = WrapAction(delegate
		{
			Executors.RunOnCoroutine(task, asyncTask.result);
			asyncTask.result.Synchronized().WaitForResult();
		});
	}

	protected virtual Action WrapAction(Action action)
	{
		return delegate
		{
			try
			{
				try
				{
					if (preCallbackOnWorkerThread != null)
					{
						preCallbackOnWorkerThread();
					}
				}
				catch (Exception arg)
				{
					Log.Warning("{0}", arg);
				}
				if (result.IsCancellationRequested)
				{
					result.SetCancelled();
				}
				else
				{
					action();
				}
			}
			catch (Exception exception)
			{
				result.SetException(exception);
			}
			finally
			{
				try
				{
					if (Exception != null)
					{
						if (errorCallbackOnMainThread != null)
						{
							Executors.RunOnMainThread(delegate
							{
								errorCallbackOnMainThread(Exception);
							}, waitForExecution: true);
						}
						if (errorCallbackOnWorkerThread != null)
						{
							errorCallbackOnWorkerThread(Exception);
						}
					}
					else
					{
						if (postCallbackOnMainThread != null)
						{
							Executors.RunOnMainThread(postCallbackOnMainThread, waitForExecution: true);
						}
						if (postCallbackOnWorkerThread != null)
						{
							postCallbackOnWorkerThread();
						}
					}
				}
				catch (Exception arg2)
				{
					Log.Warning("{0}", arg2);
				}
				try
				{
					if (finishCallbackOnMainThread != null)
					{
						Executors.RunOnMainThread(finishCallbackOnMainThread, waitForExecution: true);
					}
					if (finishCallbackOnWorkerThread != null)
					{
						finishCallbackOnWorkerThread();
					}
				}
				catch (Exception arg3)
				{
					Log.Warning("{0}", arg3);
				}
				Interlocked.Exchange(ref running, 0);
			}
		};
	}

	public virtual bool Cancel()
	{
		return result.Cancel();
	}

	public virtual ICallbackable Callbackable()
	{
		return result.Callbackable();
	}

	public virtual ISynchronizable Synchronized()
	{
		return result.Synchronized();
	}

	public virtual object WaitForDone()
	{
		return Executors.WaitWhile(() => !IsDone);
	}

	public IAsyncTask OnPreExecute(Action callback, bool runOnMainThread = true)
	{
		if (runOnMainThread)
		{
			preCallbackOnMainThread = (Action)Delegate.Combine(preCallbackOnMainThread, callback);
		}
		else
		{
			preCallbackOnWorkerThread = (Action)Delegate.Combine(preCallbackOnWorkerThread, callback);
		}
		return this;
	}

	public IAsyncTask OnPostExecute(Action callback, bool runOnMainThread = true)
	{
		if (runOnMainThread)
		{
			postCallbackOnMainThread = (Action)Delegate.Combine(postCallbackOnMainThread, callback);
		}
		else
		{
			postCallbackOnWorkerThread = (Action)Delegate.Combine(postCallbackOnWorkerThread, callback);
		}
		return this;
	}

	public IAsyncTask OnError(Action<Exception> callback, bool runOnMainThread = true)
	{
		if (runOnMainThread)
		{
			errorCallbackOnMainThread = (Action<Exception>)Delegate.Combine(errorCallbackOnMainThread, callback);
		}
		else
		{
			errorCallbackOnWorkerThread = (Action<Exception>)Delegate.Combine(errorCallbackOnWorkerThread, callback);
		}
		return this;
	}

	public IAsyncTask OnFinish(Action callback, bool runOnMainThread = true)
	{
		if (runOnMainThread)
		{
			finishCallbackOnMainThread = (Action)Delegate.Combine(finishCallbackOnMainThread, callback);
		}
		else
		{
			finishCallbackOnWorkerThread = (Action)Delegate.Combine(finishCallbackOnWorkerThread, callback);
		}
		return this;
	}

	public IAsyncTask Start(int delay)
	{
		if (delay <= 0)
		{
			return Start();
		}
		Executors.RunAsyncNoReturn(delegate
		{
			Task.Delay(delay).Wait();
			if (!IsDone && running != 1)
			{
				Start();
			}
		});
		return this;
	}

	public IAsyncTask Start()
	{
		if (IsDone)
		{
			Log.Warning("The task has been done!");
			return this;
		}
		if (Interlocked.CompareExchange(ref running, 1, 0) == 1)
		{
			Log.Warning("The task is running!");
			return this;
		}
		try
		{
			if (preCallbackOnMainThread != null)
			{
				Executors.RunOnMainThread(preCallbackOnMainThread, waitForExecution: true);
			}
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
		Executors.RunAsync(action);
		return this;
	}
}
public class AsyncTask<TResult> : IAsyncTask<TResult>, IAsyncResult<TResult>, IAsyncResult
{
	private Action action;

	private Action preCallbackOnMainThread;

	private Action preCallbackOnWorkerThread;

	private Action<TResult> postCallbackOnMainThread;

	private Action<TResult> postCallbackOnWorkerThread;

	private Action<Exception> errorCallbackOnMainThread;

	private Action<Exception> errorCallbackOnWorkerThread;

	private Action finishCallbackOnMainThread;

	private Action finishCallbackOnWorkerThread;

	private int running = 0;

	private AsyncResult<TResult> result;

	public virtual TResult Result => result.Result;

	object IAsyncResult.Result => result.Result;

	public virtual Exception Exception => result.Exception;

	public virtual bool IsDone => result.IsDone && running == 0;

	public virtual bool IsCancelled => result.IsCancelled;

	public AsyncTask(Func<TResult> task, bool runOnMainThread = false)
	{
		if (task == null)
		{
			throw new ArgumentNullException();
		}
		result = new AsyncResult<TResult>();
		if (runOnMainThread)
		{
			action = WrapAction(() => Executors.RunOnMainThread(task));
		}
		else
		{
			action = WrapAction(() => task());
		}
	}

	public AsyncTask(Action<IPromise<TResult>> task, bool runOnMainThread = false, bool cancelable = false)
	{
		AsyncTask<TResult> asyncTask = this;
		if (task == null)
		{
			throw new ArgumentNullException();
		}
		result = new AsyncResult<TResult>(!runOnMainThread & cancelable);
		if (runOnMainThread)
		{
			action = WrapAction(delegate
			{
				Executors.RunOnMainThread(delegate
				{
					task(asyncTask.result);
				});
				return asyncTask.result.Synchronized().WaitForResult();
			});
		}
		else
		{
			action = WrapAction(delegate
			{
				task(asyncTask.result);
				return asyncTask.result.Synchronized().WaitForResult();
			});
		}
	}

	public AsyncTask(Func<IPromise<TResult>, IEnumerator> task, bool cancelable = false)
	{
		AsyncTask<TResult> asyncTask = this;
		if (task == null)
		{
			throw new ArgumentNullException();
		}
		result = new AsyncResult<TResult>(cancelable);
		action = WrapAction(delegate
		{
			Executors.RunOnCoroutine(task(asyncTask.result), asyncTask.result);
			return asyncTask.result.Synchronized().WaitForResult();
		});
	}

	protected virtual Action WrapAction(Func<TResult> action)
	{
		return delegate
		{
			try
			{
				try
				{
					if (preCallbackOnWorkerThread != null)
					{
						preCallbackOnWorkerThread();
					}
				}
				catch (Exception arg)
				{
					Log.Warning("{0}", arg);
				}
				if (result.IsCancellationRequested)
				{
					result.SetCancelled();
				}
				else
				{
					TResult val = action();
					result.SetResult(val);
				}
			}
			catch (Exception exception)
			{
				result.SetException(exception);
			}
			finally
			{
				try
				{
					if (Exception != null)
					{
						if (errorCallbackOnMainThread != null)
						{
							Executors.RunOnMainThread(delegate
							{
								errorCallbackOnMainThread(Exception);
							}, waitForExecution: true);
						}
						if (errorCallbackOnWorkerThread != null)
						{
							errorCallbackOnWorkerThread(Exception);
						}
					}
					else
					{
						if (postCallbackOnMainThread != null)
						{
							Executors.RunOnMainThread(delegate
							{
								postCallbackOnMainThread(Result);
							}, waitForExecution: true);
						}
						if (postCallbackOnWorkerThread != null)
						{
							postCallbackOnWorkerThread(Result);
						}
					}
				}
				catch (Exception arg2)
				{
					Log.Warning("{0}", arg2);
				}
				try
				{
					if (finishCallbackOnMainThread != null)
					{
						Executors.RunOnMainThread(finishCallbackOnMainThread, waitForExecution: true);
					}
					if (finishCallbackOnWorkerThread != null)
					{
						finishCallbackOnWorkerThread();
					}
				}
				catch (Exception arg3)
				{
					Log.Warning("{0}", arg3);
				}
				Interlocked.Exchange(ref running, 0);
			}
		};
	}

	public virtual bool Cancel()
	{
		return result.Cancel();
	}

	public virtual ICallbackable<TResult> Callbackable()
	{
		return result.Callbackable();
	}

	public virtual ISynchronizable<TResult> Synchronized()
	{
		return result.Synchronized();
	}

	ICallbackable IAsyncResult.Callbackable()
	{
		return ((IAsyncResult)result).Callbackable();
	}

	ISynchronizable IAsyncResult.Synchronized()
	{
		return ((IAsyncResult)result).Synchronized();
	}

	public virtual object WaitForDone()
	{
		return Executors.WaitWhile(() => !IsDone);
	}

	public IAsyncTask<TResult> OnPreExecute(Action callback, bool runOnMainThread = true)
	{
		if (runOnMainThread)
		{
			preCallbackOnMainThread = (Action)Delegate.Combine(preCallbackOnMainThread, callback);
		}
		else
		{
			preCallbackOnWorkerThread = (Action)Delegate.Combine(preCallbackOnWorkerThread, callback);
		}
		return this;
	}

	public IAsyncTask<TResult> OnPostExecute(Action<TResult> callback, bool runOnMainThread = true)
	{
		if (runOnMainThread)
		{
			postCallbackOnMainThread = (Action<TResult>)Delegate.Combine(postCallbackOnMainThread, callback);
		}
		else
		{
			postCallbackOnWorkerThread = (Action<TResult>)Delegate.Combine(postCallbackOnWorkerThread, callback);
		}
		return this;
	}

	public IAsyncTask<TResult> OnError(Action<Exception> callback, bool runOnMainThread = true)
	{
		if (runOnMainThread)
		{
			errorCallbackOnMainThread = (Action<Exception>)Delegate.Combine(errorCallbackOnMainThread, callback);
		}
		else
		{
			errorCallbackOnWorkerThread = (Action<Exception>)Delegate.Combine(errorCallbackOnWorkerThread, callback);
		}
		return this;
	}

	public IAsyncTask<TResult> OnFinish(Action callback, bool runOnMainThread = true)
	{
		if (runOnMainThread)
		{
			finishCallbackOnMainThread = (Action)Delegate.Combine(finishCallbackOnMainThread, callback);
		}
		else
		{
			finishCallbackOnWorkerThread = (Action)Delegate.Combine(finishCallbackOnWorkerThread, callback);
		}
		return this;
	}

	public IAsyncTask<TResult> Start(int delay)
	{
		if (delay <= 0)
		{
			return Start();
		}
		Executors.RunAsyncNoReturn(delegate
		{
			Task.Delay(delay).Wait();
			if (!IsDone && running != 1)
			{
				Start();
			}
		});
		return this;
	}

	public IAsyncTask<TResult> Start()
	{
		if (IsDone)
		{
			Log.Warning("The task has been done!");
			return this;
		}
		if (Interlocked.CompareExchange(ref running, 1, 0) == 1)
		{
			Log.Warning("The task is running!");
			return this;
		}
		try
		{
			if (preCallbackOnMainThread != null)
			{
				Executors.RunOnMainThread(preCallbackOnMainThread, waitForExecution: true);
			}
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
		Executors.RunAsync(action);
		return this;
	}
}
