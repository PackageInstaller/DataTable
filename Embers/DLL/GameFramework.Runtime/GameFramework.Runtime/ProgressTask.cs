#define ENABLE_DEBUG_AND_ABOVE_LOG
#define ENABLE_WARNING_AND_ABOVE_LOG
using System;
using System.Collections;
using System.Threading;
using System.Threading.Tasks;

namespace GameFramework.Runtime;

public class ProgressTask<TProgress> : IProgressTask<TProgress>, IProgressResult<TProgress>, IAsyncResult
{
	private Action action;

	private Action preCallbackOnMainThread;

	private Action preCallbackOnWorkerThread;

	private Action postCallbackOnMainThread;

	private Action postCallbackOnWorkerThread;

	private Action<TProgress> progressCallbackOnMainThread;

	private Action<TProgress> progressCallbackOnWorkerThread;

	private Action<Exception> errorCallbackOnMainThread;

	private Action<Exception> errorCallbackOnWorkerThread;

	private Action finishCallbackOnMainThread;

	private Action finishCallbackOnWorkerThread;

	private int running = 0;

	private ProgressResult<TProgress> result;

	public virtual object Result => result.Result;

	public virtual Exception Exception => result.Exception;

	public virtual bool IsDone => result.IsDone && running == 0;

	public virtual bool IsCancelled => result.IsCancelled;

	public virtual TProgress Progress => result.Progress;

	public ProgressTask(Action<IProgressPromise<TProgress>> task, bool runOnMainThread = false, bool cancelable = false)
	{
		ProgressTask<TProgress> progressTask = this;
		if (task == null)
		{
			throw new ArgumentNullException();
		}
		result = new ProgressResult<TProgress>(!runOnMainThread & cancelable);
		result.Callbackable().OnProgressCallback(OnProgressChanged);
		if (runOnMainThread)
		{
			action = WrapAction(delegate
			{
				Executors.RunOnMainThread(delegate
				{
					task(progressTask.result);
				}, waitForExecution: true);
				progressTask.result.Synchronized().WaitForResult();
			});
		}
		else
		{
			action = WrapAction(delegate
			{
				task(progressTask.result);
				progressTask.result.Synchronized().WaitForResult();
			});
		}
	}

	public ProgressTask(Func<IProgressPromise<TProgress>, IEnumerator> task, bool cancelable = false)
	{
		ProgressTask<TProgress> progressTask = this;
		if (task == null)
		{
			throw new ArgumentNullException();
		}
		result = new ProgressResult<TProgress>(cancelable);
		result.Callbackable().OnProgressCallback(OnProgressChanged);
		action = WrapAction(delegate
		{
			Executors.RunOnCoroutine(task(progressTask.result), progressTask.result);
			progressTask.result.Synchronized().WaitForResult();
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

	protected virtual IEnumerator DoUpdateProgressOnMainThread()
	{
		while (!result.IsDone)
		{
			try
			{
				if (progressCallbackOnMainThread != null)
				{
					progressCallbackOnMainThread(result.Progress);
				}
			}
			catch (Exception arg)
			{
				Log.Warning("{0}", arg);
			}
			yield return null;
		}
	}

	protected virtual void OnProgressChanged(TProgress progress)
	{
		try
		{
			if (!result.IsDone && progressCallbackOnWorkerThread != null)
			{
				progressCallbackOnWorkerThread(progress);
			}
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
	}

	public virtual bool Cancel()
	{
		return result.Cancel();
	}

	public virtual IProgressCallbackable<TProgress> Callbackable()
	{
		return result.Callbackable();
	}

	ICallbackable IAsyncResult.Callbackable()
	{
		return ((IAsyncResult)result).Callbackable();
	}

	public virtual ISynchronizable Synchronized()
	{
		return result.Synchronized();
	}

	public virtual object WaitForDone()
	{
		return Executors.WaitWhile(() => !IsDone);
	}

	public IProgressTask<TProgress> OnPreExecute(Action callback, bool runOnMainThread = true)
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

	public IProgressTask<TProgress> OnPostExecute(Action callback, bool runOnMainThread = true)
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

	public IProgressTask<TProgress> OnError(Action<Exception> callback, bool runOnMainThread = true)
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

	public IProgressTask<TProgress> OnProgressUpdate(Action<TProgress> callback, bool runOnMainThread = true)
	{
		if (runOnMainThread)
		{
			progressCallbackOnMainThread = (Action<TProgress>)Delegate.Combine(progressCallbackOnMainThread, callback);
		}
		else
		{
			progressCallbackOnWorkerThread = (Action<TProgress>)Delegate.Combine(progressCallbackOnWorkerThread, callback);
		}
		return this;
	}

	public IProgressTask<TProgress> OnFinish(Action callback, bool runOnMainThread = true)
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

	public IProgressTask<TProgress> Start(int delay)
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

	public IProgressTask<TProgress> Start()
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
			if (progressCallbackOnMainThread != null)
			{
				Executors.RunOnCoroutineNoReturn(DoUpdateProgressOnMainThread());
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
public class ProgressTask<TProgress, TResult> : IProgressTask<TProgress, TResult>, IProgressResult<TProgress, TResult>, IAsyncResult<TResult>, IAsyncResult, IProgressResult<TProgress>
{
	private Action action;

	private Action preCallbackOnMainThread;

	private Action preCallbackOnWorkerThread;

	private Action<TResult> postCallbackOnMainThread;

	private Action<TResult> postCallbackOnWorkerThread;

	private Action<TProgress> progressCallbackOnMainThread;

	private Action<TProgress> progressCallbackOnWorkerThread;

	private Action<Exception> errorCallbackOnMainThread;

	private Action<Exception> errorCallbackOnWorkerThread;

	private Action finishCallbackOnMainThread;

	private Action finishCallbackOnWorkerThread;

	private int running = 0;

	private ProgressResult<TProgress, TResult> result;

	public virtual TResult Result => result.Result;

	object IAsyncResult.Result => result.Result;

	public virtual Exception Exception => result.Exception;

	public virtual bool IsDone => result.IsDone && running == 0;

	public virtual bool IsCancelled => result.IsCancelled;

	public virtual TProgress Progress => result.Progress;

	public ProgressTask(Action<IProgressPromise<TProgress, TResult>> task, bool runOnMainThread, bool cancelable = false)
	{
		ProgressTask<TProgress, TResult> progressTask = this;
		if (task == null)
		{
			throw new ArgumentNullException();
		}
		result = new ProgressResult<TProgress, TResult>(!runOnMainThread & cancelable);
		result.Callbackable().OnProgressCallback(OnProgressChanged);
		if (runOnMainThread)
		{
			action = WrapAction(delegate
			{
				Executors.RunOnMainThread(delegate
				{
					task(progressTask.result);
				}, waitForExecution: true);
				return progressTask.result.Synchronized().WaitForResult();
			});
		}
		else
		{
			action = WrapAction(delegate
			{
				task(progressTask.result);
				return progressTask.result.Synchronized().WaitForResult();
			});
		}
	}

	public ProgressTask(Func<IProgressPromise<TProgress, TResult>, IEnumerator> task, bool cancelable = false)
	{
		ProgressTask<TProgress, TResult> progressTask = this;
		if (task == null)
		{
			throw new ArgumentNullException();
		}
		result = new ProgressResult<TProgress, TResult>(cancelable);
		result.Callbackable().OnProgressCallback(OnProgressChanged);
		action = WrapAction(delegate
		{
			Executors.RunOnCoroutine(task(progressTask.result), progressTask.result);
			return progressTask.result.Synchronized().WaitForResult();
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

	protected virtual IEnumerator DoUpdateProgressOnMainThread()
	{
		while (!result.IsDone)
		{
			try
			{
				if (progressCallbackOnMainThread != null)
				{
					progressCallbackOnMainThread(result.Progress);
				}
			}
			catch (Exception arg)
			{
				Log.Warning("{0}", arg);
			}
			yield return null;
		}
	}

	protected virtual void OnProgressChanged(TProgress progress)
	{
		try
		{
			if (!result.IsDone && progressCallbackOnWorkerThread != null)
			{
				progressCallbackOnWorkerThread(progress);
			}
		}
		catch (Exception arg)
		{
			Log.Warning("{0}", arg);
		}
	}

	public virtual bool Cancel()
	{
		return result.Cancel();
	}

	public virtual IProgressCallbackable<TProgress, TResult> Callbackable()
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

	ICallbackable<TResult> IAsyncResult<TResult>.Callbackable()
	{
		return ((IAsyncResult<TResult>)result).Callbackable();
	}

	IProgressCallbackable<TProgress> IProgressResult<TProgress>.Callbackable()
	{
		return ((IProgressResult<TProgress>)result).Callbackable();
	}

	ISynchronizable IAsyncResult.Synchronized()
	{
		return ((IAsyncResult)result).Synchronized();
	}

	public virtual object WaitForDone()
	{
		return Executors.WaitWhile(() => !IsDone);
	}

	public IProgressTask<TProgress, TResult> OnPreExecute(Action callback, bool runOnMainThread = true)
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

	public IProgressTask<TProgress, TResult> OnPostExecute(Action<TResult> callback, bool runOnMainThread = true)
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

	public IProgressTask<TProgress, TResult> OnError(Action<Exception> callback, bool runOnMainThread = true)
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

	public IProgressTask<TProgress, TResult> OnProgressUpdate(Action<TProgress> callback, bool runOnMainThread = true)
	{
		if (runOnMainThread)
		{
			progressCallbackOnMainThread = (Action<TProgress>)Delegate.Combine(progressCallbackOnMainThread, callback);
		}
		else
		{
			progressCallbackOnWorkerThread = (Action<TProgress>)Delegate.Combine(progressCallbackOnWorkerThread, callback);
		}
		return this;
	}

	public IProgressTask<TProgress, TResult> OnFinish(Action callback, bool runOnMainThread = true)
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

	public IProgressTask<TProgress, TResult> Start(int delay)
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

	public IProgressTask<TProgress, TResult> Start()
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
			if (progressCallbackOnMainThread != null)
			{
				Executors.RunOnCoroutineNoReturn(DoUpdateProgressOnMainThread());
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
