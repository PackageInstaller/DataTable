using System;

namespace GameFramework.Runtime;

public class ThreadExecutor : AbstractExecutor, IThreadExecutor
{
	public virtual IAsyncResult Execute(Action action)
	{
		AsyncResult result = new AsyncResult(cancelable: true);
		Executors.RunAsyncNoReturn(delegate
		{
			try
			{
				if (result.IsCancellationRequested)
				{
					result.SetCancelled();
				}
				else
				{
					action();
					result.SetResult();
				}
			}
			catch (Exception exception)
			{
				result.SetException(exception);
			}
		});
		return result;
	}

	public virtual IAsyncResult Execute<TResult>(Func<TResult> func)
	{
		AsyncResult<TResult> result = new AsyncResult<TResult>(cancelable: true);
		Executors.RunAsyncNoReturn(delegate
		{
			try
			{
				if (result.IsCancellationRequested)
				{
					result.SetCancelled();
				}
				else
				{
					TResult result2 = func();
					result.SetResult(result2);
				}
			}
			catch (Exception exception)
			{
				result.SetException(exception);
			}
		});
		return result;
	}

	public virtual IAsyncResult Execute(Action<IPromise> action)
	{
		AsyncResult result = new AsyncResult(cancelable: true);
		Executors.RunAsyncNoReturn(delegate
		{
			try
			{
				if (result.IsCancellationRequested)
				{
					result.SetCancelled();
				}
				else
				{
					action(result);
					if (!result.IsDone)
					{
						result.SetResult();
					}
				}
			}
			catch (Exception exception)
			{
				if (!result.IsDone)
				{
					result.SetException(exception);
				}
			}
		});
		return result;
	}

	public virtual IProgressResult<TProgress> Execute<TProgress>(Action<IProgressPromise<TProgress>> action)
	{
		ProgressResult<TProgress> result = new ProgressResult<TProgress>(cancelable: true);
		Executors.RunAsyncNoReturn(delegate
		{
			try
			{
				if (result.IsCancellationRequested)
				{
					result.SetCancelled();
				}
				else
				{
					action(result);
					if (!result.IsDone)
					{
						result.SetResult();
					}
				}
			}
			catch (Exception exception)
			{
				if (!result.IsDone)
				{
					result.SetException(exception);
				}
			}
		});
		return result;
	}

	public virtual IAsyncResult Execute<TResult>(Action<IPromise<TResult>> action)
	{
		AsyncResult<TResult> result = new AsyncResult<TResult>(cancelable: true);
		Executors.RunAsyncNoReturn(delegate
		{
			try
			{
				if (result.IsCancellationRequested)
				{
					result.SetCancelled();
				}
				else
				{
					action(result);
					if (!result.IsDone)
					{
						result.SetResult();
					}
				}
			}
			catch (Exception exception)
			{
				if (!result.IsDone)
				{
					result.SetException(exception);
				}
			}
		});
		return result;
	}

	public virtual IProgressResult<TProgress, TResult> Execute<TProgress, TResult>(Action<IProgressPromise<TProgress, TResult>> action)
	{
		ProgressResult<TProgress, TResult> result = new ProgressResult<TProgress, TResult>(cancelable: true);
		Executors.RunAsyncNoReturn(delegate
		{
			try
			{
				if (result.IsCancellationRequested)
				{
					result.SetCancelled();
				}
				else
				{
					action(result);
					if (!result.IsDone)
					{
						result.SetResult();
					}
				}
			}
			catch (Exception exception)
			{
				if (!result.IsDone)
				{
					result.SetException(exception);
				}
			}
		});
		return result;
	}
}
