using System.Runtime.ExceptionServices;
using System.Threading;
using System.Threading.Tasks;

namespace System.Net;

internal class WebCompletionSource<T>
{
	internal enum Status
	{
		Running,
		Completed,
		Canceled,
		Faulted
	}

	internal class Result
	{
		public Status Status { get; }

		public bool Success => Status == Status.Completed;

		public ExceptionDispatchInfo Error { get; }

		public T Argument { get; }

		public Result(T argument)
		{
			Status = Status.Completed;
			Argument = argument;
		}

		public Result(Status state, ExceptionDispatchInfo error)
		{
			Status = state;
			Error = error;
		}
	}

	private TaskCompletionSource<Result> completion;

	private Result currentResult;

	internal Result CurrentResult => currentResult;

	internal Task Task => completion.Task;

	public WebCompletionSource(bool runAsync = true)
	{
		completion = new TaskCompletionSource<Result>(runAsync ? TaskCreationOptions.RunContinuationsAsynchronously : TaskCreationOptions.None);
	}

	public bool TrySetCompleted(T argument)
	{
		Result result = new Result(argument);
		if (Interlocked.CompareExchange(ref currentResult, result, null) != null)
		{
			return false;
		}
		return completion.TrySetResult(result);
	}

	public bool TrySetCompleted()
	{
		Result result = new Result(Status.Completed, null);
		if (Interlocked.CompareExchange(ref currentResult, result, null) != null)
		{
			return false;
		}
		return completion.TrySetResult(result);
	}

	public bool TrySetCanceled()
	{
		return TrySetCanceled(new OperationCanceledException());
	}

	public bool TrySetCanceled(OperationCanceledException error)
	{
		Result result = new Result(Status.Canceled, ExceptionDispatchInfo.Capture(error));
		if (Interlocked.CompareExchange(ref currentResult, result, null) != null)
		{
			return false;
		}
		return completion.TrySetResult(result);
	}

	public bool TrySetException(Exception error)
	{
		Result result = new Result(Status.Faulted, ExceptionDispatchInfo.Capture(error));
		if (Interlocked.CompareExchange(ref currentResult, result, null) != null)
		{
			return false;
		}
		return completion.TrySetResult(result);
	}

	public void ThrowOnError()
	{
		if (completion.Task.IsCompleted)
		{
			completion.Task.Result.Error?.Throw();
		}
	}

	public async Task<T> WaitForCompletion()
	{
		Result result = await completion.Task.ConfigureAwait(continueOnCapturedContext: false);
		if (result.Status == Status.Completed)
		{
			return result.Argument;
		}
		result.Error.Throw();
		throw new InvalidOperationException("Should never happen.");
	}
}
internal class WebCompletionSource : WebCompletionSource<object>
{
	public WebCompletionSource()
		: base(true)
	{
	}
}
