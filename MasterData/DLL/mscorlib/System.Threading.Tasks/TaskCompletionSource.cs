using System.Collections.Generic;

namespace System.Threading.Tasks;

public class TaskCompletionSource<TResult>
{
	private readonly Task<TResult> _task;

	public Task<TResult> Task => _task;

	public TaskCompletionSource()
	{
		_task = new Task<TResult>();
	}

	public TaskCompletionSource(TaskCreationOptions creationOptions)
		: this((object)null, creationOptions)
	{
	}

	public TaskCompletionSource(object state)
		: this(state, TaskCreationOptions.None)
	{
	}

	public TaskCompletionSource(object state, TaskCreationOptions creationOptions)
	{
		_task = new Task<TResult>(state, creationOptions);
	}

	private void SpinUntilCompleted()
	{
		SpinWait spinWait = default(SpinWait);
		while (!_task.IsCompleted)
		{
			spinWait.SpinOnce();
		}
	}

	public bool TrySetException(Exception exception)
	{
		if (exception == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.exception);
		}
		bool num = _task.TrySetException(exception);
		if (!num && !_task.IsCompleted)
		{
			SpinUntilCompleted();
		}
		return num;
	}

	public bool TrySetException(IEnumerable<Exception> exceptions)
	{
		if (exceptions == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.exceptions);
		}
		List<Exception> list = new List<Exception>();
		foreach (Exception exception in exceptions)
		{
			if (exception == null)
			{
				ThrowHelper.ThrowArgumentException(ExceptionResource.TaskCompletionSourceT_TrySetException_NullException, ExceptionArgument.exceptions);
			}
			list.Add(exception);
		}
		if (list.Count == 0)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.TaskCompletionSourceT_TrySetException_NoExceptions, ExceptionArgument.exceptions);
		}
		bool num = _task.TrySetException(list);
		if (!num && !_task.IsCompleted)
		{
			SpinUntilCompleted();
		}
		return num;
	}

	public void SetException(Exception exception)
	{
		if (exception == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.exception);
		}
		if (!TrySetException(exception))
		{
			ThrowHelper.ThrowInvalidOperationException(ExceptionResource.TaskT_TransitionToFinal_AlreadyCompleted);
		}
	}

	public void SetException(IEnumerable<Exception> exceptions)
	{
		if (!TrySetException(exceptions))
		{
			ThrowHelper.ThrowInvalidOperationException(ExceptionResource.TaskT_TransitionToFinal_AlreadyCompleted);
		}
	}

	public bool TrySetResult(TResult result)
	{
		bool num = _task.TrySetResult(result);
		if (!num)
		{
			SpinUntilCompleted();
		}
		return num;
	}

	public void SetResult(TResult result)
	{
		if (!TrySetResult(result))
		{
			ThrowHelper.ThrowInvalidOperationException(ExceptionResource.TaskT_TransitionToFinal_AlreadyCompleted);
		}
	}

	public bool TrySetCanceled()
	{
		return TrySetCanceled(default(CancellationToken));
	}

	public bool TrySetCanceled(CancellationToken cancellationToken)
	{
		bool num = _task.TrySetCanceled(cancellationToken);
		if (!num && !_task.IsCompleted)
		{
			SpinUntilCompleted();
		}
		return num;
	}

	public void SetCanceled()
	{
		if (!TrySetCanceled())
		{
			ThrowHelper.ThrowInvalidOperationException(ExceptionResource.TaskT_TransitionToFinal_AlreadyCompleted);
		}
	}
}
