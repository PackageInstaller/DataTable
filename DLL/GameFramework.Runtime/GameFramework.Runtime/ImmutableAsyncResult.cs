using System;

namespace GameFramework.Runtime;

public class ImmutableAsyncResult : AsyncResult
{
	public ImmutableAsyncResult()
		: base(cancelable: false)
	{
		SetResult();
	}

	public ImmutableAsyncResult(object result)
		: base(cancelable: false)
	{
		SetResult(result);
	}

	public ImmutableAsyncResult(Exception exception)
		: base(cancelable: false)
	{
		SetException(exception);
	}
}
public class ImmutableAsyncResult<TResult> : AsyncResult<TResult>
{
	public ImmutableAsyncResult()
		: base(false)
	{
		SetResult(default(TResult));
	}

	public ImmutableAsyncResult(TResult result)
		: base(false)
	{
		SetResult(result);
	}

	public ImmutableAsyncResult(Exception exception)
		: base(false)
	{
		SetException(exception);
	}
}
