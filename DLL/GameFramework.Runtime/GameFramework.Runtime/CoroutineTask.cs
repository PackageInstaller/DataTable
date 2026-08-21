using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;
using UnityEngine;

namespace GameFramework.Runtime;

public class CoroutineTask
{
	private AsyncResult asyncResult;

	public Exception Exception => asyncResult.Exception;

	public bool IsCompleted => asyncResult.IsDone && asyncResult.Exception == null;

	public bool IsCancelled => asyncResult.IsDone && asyncResult.IsCancelled;

	public bool IsFaulted => asyncResult.IsDone && !asyncResult.IsCancelled && asyncResult.Exception != null;

	public bool IsDone => asyncResult.IsDone;

	private static IEnumerator DoDelay(float secondsDelay)
	{
		yield return new WaitForSecondsRealtime(secondsDelay);
	}

	public static CoroutineTask Delay(TimeSpan delay)
	{
		return Delay((float)delay.TotalSeconds);
	}

	public static CoroutineTask Delay(int millisecondsDelay)
	{
		return Delay((float)millisecondsDelay / 1000f);
	}

	public static CoroutineTask Delay(float secondsDelay)
	{
		return new CoroutineTask(DoDelay(secondsDelay));
	}

	public static CoroutineTask Run(Action action)
	{
		return new CoroutineTask(action);
	}

	public static CoroutineTask Run(Action<object> action, object state)
	{
		return new CoroutineTask(action, state);
	}

	public static CoroutineTask Run(IEnumerator routine)
	{
		return new CoroutineTask(routine);
	}

	public static CoroutineTask<TResult> Run<TResult>(Func<TResult> function)
	{
		return new CoroutineTask<TResult>(function);
	}

	public static CoroutineTask<TResult> Run<TResult>(Func<object, TResult> function, object state)
	{
		return new CoroutineTask<TResult>(function, state);
	}

	public static CoroutineTask<TResult> Run<TResult>(Func<IPromise<TResult>, IEnumerator> function)
	{
		return new CoroutineTask<TResult>(function);
	}

	public static CoroutineTask<TResult> Run<TResult>(Func<object, IPromise<TResult>, IEnumerator> function, object state)
	{
		return new CoroutineTask<TResult>(function, state);
	}

	public static CoroutineTask WhenAll(params CoroutineTask[] tasks)
	{
		AsyncResult result = new AsyncResult(cancelable: true);
		try
		{
			if (tasks == null)
			{
				throw new ArgumentNullException("tasks");
			}
			int curr;
			int num = (curr = tasks.Length);
			bool isCancelled = false;
			List<Exception> exceptions = new List<Exception>();
			for (int i = 0; i < num; i++)
			{
				CoroutineTask coroutineTask = tasks[i];
				coroutineTask.asyncResult.Callbackable().OnCallback(delegate(IAsyncResult ar)
				{
					isCancelled |= ar.IsCancelled;
					if (ar.Exception != null)
					{
						exceptions.Add(ar.Exception);
					}
					if (Interlocked.Decrement(ref curr) <= 0)
					{
						if (isCancelled)
						{
							result.SetCancelled();
						}
						else if (exceptions.Count > 0)
						{
							result.SetException(new System.AggregateException(exceptions));
						}
						else
						{
							result.SetResult();
						}
					}
				});
			}
		}
		catch (Exception exception)
		{
			result.SetException(exception);
		}
		return new CoroutineTask(result);
	}

	public static CoroutineTask<TResult[]> WhenAll<TResult>(params CoroutineTask<TResult>[] tasks)
	{
		AsyncResult<TResult[]> result = new AsyncResult<TResult[]>(cancelable: true);
		try
		{
			if (tasks == null)
			{
				throw new ArgumentNullException("tasks");
			}
			int curr;
			int num = (curr = tasks.Length);
			bool isCancelled = false;
			List<Exception> exceptions = new List<Exception>();
			TResult[] array = new TResult[num];
			for (int i = 0; i < num; i++)
			{
				int index = i;
				CoroutineTask<TResult> coroutineTask = tasks[index];
				coroutineTask.asyncResult.Callbackable().OnCallback(delegate(IAsyncResult ar)
				{
					try
					{
						isCancelled |= ar.IsCancelled;
						if (ar.Exception != null)
						{
							exceptions.Add(ar.Exception);
						}
						else
						{
							array[index] = (TResult)ar.Result;
						}
					}
					finally
					{
						if (Interlocked.Decrement(ref curr) <= 0)
						{
							if (isCancelled)
							{
								result.SetCancelled();
							}
							else if (exceptions.Count > 0)
							{
								result.SetException(new System.AggregateException(exceptions));
							}
							else
							{
								result.SetResult(array);
							}
						}
					}
				});
			}
		}
		catch (Exception exception)
		{
			result.SetException(exception);
		}
		return new CoroutineTask<TResult[]>(result);
	}

	public static CoroutineTask<CoroutineTask> WhenAny(params CoroutineTask[] tasks)
	{
		AsyncResult<CoroutineTask> result = new AsyncResult<CoroutineTask>(cancelable: true);
		try
		{
			if (tasks == null)
			{
				throw new ArgumentNullException("tasks");
			}
			int num = tasks.Length;
			for (int i = 0; i < num; i++)
			{
				CoroutineTask task = tasks[i];
				task.asyncResult.Callbackable().OnCallback(delegate
				{
					if (!result.IsDone)
					{
						result.SetResult(task);
					}
				});
			}
		}
		catch (Exception exception)
		{
			result.SetException(exception);
		}
		return new CoroutineTask<CoroutineTask>(result);
	}

	public static CoroutineTask<CoroutineTask<TResult>> WhenAny<TResult>(params CoroutineTask<TResult>[] tasks)
	{
		AsyncResult<CoroutineTask<TResult>> result = new AsyncResult<CoroutineTask<TResult>>(cancelable: true);
		try
		{
			if (tasks == null)
			{
				throw new ArgumentNullException("tasks");
			}
			int num = tasks.Length;
			for (int i = 0; i < num; i++)
			{
				CoroutineTask<TResult> task = tasks[i];
				task.asyncResult.Callbackable().OnCallback(delegate
				{
					if (!result.IsDone)
					{
						result.SetResult(task);
					}
				});
			}
		}
		catch (Exception exception)
		{
			result.SetException(exception);
		}
		return new CoroutineTask<CoroutineTask<TResult>>(result);
	}

	protected internal CoroutineTask(AsyncResult asyncResult)
	{
		this.asyncResult = asyncResult;
	}

	public CoroutineTask(Action action)
		: this(new AsyncResult())
	{
		CoroutineTask coroutineTask = this;
		Executors.RunOnMainThread(delegate
		{
			try
			{
				action();
				coroutineTask.asyncResult.SetResult();
			}
			catch (Exception exception)
			{
				coroutineTask.asyncResult.SetException(exception);
			}
		});
	}

	public CoroutineTask(Action<object> action, object state)
		: this(new AsyncResult())
	{
		CoroutineTask coroutineTask = this;
		Executors.RunOnMainThread(delegate
		{
			try
			{
				action(state);
				coroutineTask.asyncResult.SetResult();
			}
			catch (Exception exception)
			{
				coroutineTask.asyncResult.SetException(exception);
			}
		});
	}

	public CoroutineTask(IEnumerator routine)
		: this(new AsyncResult(cancelable: true))
	{
		try
		{
			if (routine == null)
			{
				throw new ArgumentNullException("routine");
			}
			Executors.RunOnCoroutine(routine, asyncResult);
		}
		catch (Exception exception)
		{
			asyncResult.SetException(exception);
		}
	}

	public object WaitForDone()
	{
		return asyncResult.WaitForDone();
	}

	public virtual IAwaiter GetAwaiter()
	{
		return new AsyncResultAwaiter<AsyncResult>(asyncResult);
	}

	protected bool IsExecutable(IAsyncResult ar, CoroutineTaskContinuationOptions continuationOptions)
	{
		bool flag = continuationOptions == CoroutineTaskContinuationOptions.None;
		if (!flag)
		{
			flag = ar.Exception == null && (continuationOptions & CoroutineTaskContinuationOptions.OnCompleted) > CoroutineTaskContinuationOptions.None;
		}
		if (!flag)
		{
			flag = ar.IsCancelled && (continuationOptions & CoroutineTaskContinuationOptions.OnCanceled) > CoroutineTaskContinuationOptions.None;
		}
		if (!flag)
		{
			flag = !ar.IsCancelled && ar.Exception != null && (continuationOptions & CoroutineTaskContinuationOptions.OnFaulted) > CoroutineTaskContinuationOptions.None;
		}
		return flag;
	}

	public CoroutineTask ContinueWith(Action continuationAction, CoroutineTaskContinuationOptions continuationOptions = CoroutineTaskContinuationOptions.None)
	{
		AsyncResult result = new AsyncResult(cancelable: true);
		asyncResult.Callbackable().OnCallback(delegate(IAsyncResult ar)
		{
			try
			{
				if (!IsExecutable(ar, continuationOptions))
				{
					result.SetCancelled();
				}
				else
				{
					continuationAction();
					result.SetResult();
				}
			}
			catch (Exception exception)
			{
				result.SetException(exception);
			}
		});
		return new CoroutineTask(result);
	}

	public CoroutineTask ContinueWith(Action<CoroutineTask> continuationAction, CoroutineTaskContinuationOptions continuationOptions = CoroutineTaskContinuationOptions.None)
	{
		AsyncResult result = new AsyncResult(cancelable: true);
		asyncResult.Callbackable().OnCallback(delegate(IAsyncResult ar)
		{
			try
			{
				if (!IsExecutable(ar, continuationOptions))
				{
					result.SetCancelled();
				}
				else
				{
					continuationAction(this);
					result.SetResult();
				}
			}
			catch (Exception exception)
			{
				result.SetException(exception);
			}
		});
		return new CoroutineTask(result);
	}

	public CoroutineTask ContinueWith(Action<CoroutineTask, object> continuationAction, object state, CoroutineTaskContinuationOptions continuationOptions = CoroutineTaskContinuationOptions.None)
	{
		AsyncResult result = new AsyncResult(cancelable: true);
		asyncResult.Callbackable().OnCallback(delegate(IAsyncResult ar)
		{
			try
			{
				if (!IsExecutable(ar, continuationOptions))
				{
					result.SetCancelled();
				}
				else
				{
					continuationAction(this, state);
					result.SetResult();
				}
			}
			catch (Exception exception)
			{
				result.SetException(exception);
			}
		});
		return new CoroutineTask(result);
	}

	public CoroutineTask ContinueWith(IEnumerator continuationRoutine, CoroutineTaskContinuationOptions continuationOptions = CoroutineTaskContinuationOptions.None)
	{
		AsyncResult result = new AsyncResult(cancelable: true);
		asyncResult.Callbackable().OnCallback(delegate(IAsyncResult ar)
		{
			try
			{
				if (!IsExecutable(ar, continuationOptions))
				{
					result.SetCancelled();
				}
				else
				{
					Executors.RunOnCoroutine(continuationRoutine, result);
				}
			}
			catch (Exception exception)
			{
				result.SetException(exception);
			}
		});
		return new CoroutineTask(result);
	}

	public CoroutineTask ContinueWith(Func<CoroutineTask, IEnumerator> continuationFunction, CoroutineTaskContinuationOptions continuationOptions = CoroutineTaskContinuationOptions.None)
	{
		AsyncResult result = new AsyncResult(cancelable: true);
		asyncResult.Callbackable().OnCallback(delegate(IAsyncResult ar)
		{
			try
			{
				if (!IsExecutable(ar, continuationOptions))
				{
					result.SetCancelled();
				}
				else
				{
					Executors.RunOnCoroutine(continuationFunction(this), result);
				}
			}
			catch (Exception exception)
			{
				result.SetException(exception);
			}
		});
		return new CoroutineTask(result);
	}

	public CoroutineTask ContinueWith(Func<CoroutineTask, object, IEnumerator> continuationFunction, object state, CoroutineTaskContinuationOptions continuationOptions = CoroutineTaskContinuationOptions.None)
	{
		AsyncResult result = new AsyncResult(cancelable: true);
		asyncResult.Callbackable().OnCallback(delegate(IAsyncResult ar)
		{
			try
			{
				if (!IsExecutable(ar, continuationOptions))
				{
					result.SetCancelled();
				}
				else
				{
					Executors.RunOnCoroutine(continuationFunction(this, state), result);
				}
			}
			catch (Exception exception)
			{
				result.SetException(exception);
			}
		});
		return new CoroutineTask(result);
	}

	public CoroutineTask<TResult> ContinueWith<TResult>(Func<CoroutineTask, TResult> continuationFunction, CoroutineTaskContinuationOptions continuationOptions = CoroutineTaskContinuationOptions.None)
	{
		AsyncResult<TResult> result = new AsyncResult<TResult>(cancelable: true);
		asyncResult.Callbackable().OnCallback(delegate(IAsyncResult ar)
		{
			try
			{
				if (!IsExecutable(ar, continuationOptions))
				{
					result.SetCancelled();
				}
				else
				{
					TResult result2 = continuationFunction(this);
					result.SetResult(result2);
				}
			}
			catch (Exception exception)
			{
				result.SetException(exception);
			}
		});
		return new CoroutineTask<TResult>(result);
	}

	public CoroutineTask<TResult> ContinueWith<TResult>(Func<CoroutineTask, object, TResult> continuationFunction, object state, CoroutineTaskContinuationOptions continuationOptions = CoroutineTaskContinuationOptions.None)
	{
		AsyncResult<TResult> result = new AsyncResult<TResult>(cancelable: true);
		asyncResult.Callbackable().OnCallback(delegate(IAsyncResult ar)
		{
			try
			{
				if (!IsExecutable(ar, continuationOptions))
				{
					result.SetCancelled();
				}
				else
				{
					TResult result2 = continuationFunction(this, state);
					result.SetResult(result2);
				}
			}
			catch (Exception exception)
			{
				result.SetException(exception);
			}
		});
		return new CoroutineTask<TResult>(result);
	}

	public CoroutineTask<TResult> ContinueWith<TResult>(Func<CoroutineTask, IPromise<TResult>, IEnumerator> continuationFunction, CoroutineTaskContinuationOptions continuationOptions = CoroutineTaskContinuationOptions.None)
	{
		AsyncResult<TResult> result = new AsyncResult<TResult>(cancelable: true);
		asyncResult.Callbackable().OnCallback(delegate(IAsyncResult ar)
		{
			try
			{
				if (!IsExecutable(ar, continuationOptions))
				{
					result.SetCancelled();
				}
				else
				{
					Executors.RunOnCoroutine(continuationFunction(this, result), result);
				}
			}
			catch (Exception exception)
			{
				result.SetException(exception);
			}
		});
		return new CoroutineTask<TResult>(result);
	}

	public CoroutineTask<TResult> ContinueWith<TResult>(Func<CoroutineTask, object, IPromise<TResult>, IEnumerator> continuationFunction, object state, CoroutineTaskContinuationOptions continuationOptions = CoroutineTaskContinuationOptions.None)
	{
		AsyncResult<TResult> result = new AsyncResult<TResult>(cancelable: true);
		asyncResult.Callbackable().OnCallback(delegate(IAsyncResult ar)
		{
			try
			{
				if (!IsExecutable(ar, continuationOptions))
				{
					result.SetCancelled();
				}
				else
				{
					Executors.RunOnCoroutine(continuationFunction(this, state, result), result);
				}
			}
			catch (Exception exception)
			{
				result.SetException(exception);
			}
		});
		return new CoroutineTask<TResult>(result);
	}
}
public class CoroutineTask<TResult> : CoroutineTask
{
	private AsyncResult<TResult> asyncResult;

	public TResult Result => asyncResult.Result;

	protected internal CoroutineTask(AsyncResult<TResult> asyncResult)
		: base(asyncResult)
	{
		this.asyncResult = asyncResult;
	}

	public CoroutineTask(Func<TResult> function)
		: this(new AsyncResult<TResult>())
	{
		CoroutineTask<TResult> coroutineTask = this;
		Executors.RunOnMainThread(delegate
		{
			try
			{
				TResult result = function();
				coroutineTask.asyncResult.SetResult(result);
			}
			catch (Exception exception)
			{
				coroutineTask.asyncResult.SetException(exception);
			}
		});
	}

	public CoroutineTask(Func<object, TResult> function, object state)
		: this(new AsyncResult<TResult>())
	{
		CoroutineTask<TResult> coroutineTask = this;
		Executors.RunOnMainThread(delegate
		{
			try
			{
				TResult result = function(state);
				coroutineTask.asyncResult.SetResult(result);
			}
			catch (Exception exception)
			{
				coroutineTask.asyncResult.SetException(exception);
			}
		});
	}

	public CoroutineTask(Func<IPromise<TResult>, IEnumerator> function)
		: this(new AsyncResult<TResult>(cancelable: true))
	{
		try
		{
			Executors.RunOnCoroutine(function(asyncResult), asyncResult);
		}
		catch (Exception exception)
		{
			asyncResult.SetException(exception);
		}
	}

	public CoroutineTask(Func<object, IPromise<TResult>, IEnumerator> function, object state)
		: this(new AsyncResult<TResult>(cancelable: true))
	{
		try
		{
			Executors.RunOnCoroutine(function(state, asyncResult), asyncResult);
		}
		catch (Exception exception)
		{
			asyncResult.SetException(exception);
		}
	}

	public new IAwaiter<TResult> GetAwaiter()
	{
		return new AsyncResultAwaiter<AsyncResult<TResult>, TResult>(asyncResult);
	}
}
