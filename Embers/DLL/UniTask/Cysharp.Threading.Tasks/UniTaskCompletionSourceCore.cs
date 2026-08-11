using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.ExceptionServices;
using System.Runtime.InteropServices;
using System.Threading;

namespace Cysharp.Threading.Tasks;

[StructLayout(LayoutKind.Auto)]
public struct UniTaskCompletionSourceCore<TResult>
{
	private TResult result;

	private object error;

	private short version;

	private bool hasUnhandledError;

	private int completedCount;

	private Action<object> continuation;

	private object continuationState;

	[DebuggerHidden]
	public short Version => version;

	[DebuggerHidden]
	public void Reset()
	{
		ReportUnhandledError();
		version++;
		completedCount = 0;
		result = default(TResult);
		error = null;
		hasUnhandledError = false;
		continuation = null;
		continuationState = null;
	}

	private void ReportUnhandledError()
	{
		if (!hasUnhandledError)
		{
			return;
		}
		try
		{
			if (error is OperationCanceledException ex)
			{
				UniTaskScheduler.PublishUnobservedTaskException(ex);
			}
			else if (error is ExceptionHolder exceptionHolder)
			{
				UniTaskScheduler.PublishUnobservedTaskException(exceptionHolder.GetException().SourceException);
			}
		}
		catch
		{
		}
	}

	internal void MarkHandled()
	{
		hasUnhandledError = false;
	}

	[DebuggerHidden]
	public bool TrySetResult(TResult result)
	{
		if (Interlocked.Increment(ref completedCount) == 1)
		{
			this.result = result;
			if (continuation != null || Interlocked.CompareExchange(ref continuation, UniTaskCompletionSourceCoreShared.s_sentinel, null) != null)
			{
				continuation(continuationState);
			}
			return true;
		}
		return false;
	}

	[DebuggerHidden]
	public bool TrySetException(Exception error)
	{
		if (Interlocked.Increment(ref completedCount) == 1)
		{
			hasUnhandledError = true;
			if (error is OperationCanceledException)
			{
				this.error = error;
			}
			else
			{
				this.error = new ExceptionHolder(ExceptionDispatchInfo.Capture(error));
			}
			if (continuation != null || Interlocked.CompareExchange(ref continuation, UniTaskCompletionSourceCoreShared.s_sentinel, null) != null)
			{
				continuation(continuationState);
			}
			return true;
		}
		return false;
	}

	[DebuggerHidden]
	public bool TrySetCanceled(CancellationToken cancellationToken = default(CancellationToken))
	{
		if (Interlocked.Increment(ref completedCount) == 1)
		{
			hasUnhandledError = true;
			error = new OperationCanceledException(cancellationToken);
			if (continuation != null || Interlocked.CompareExchange(ref continuation, UniTaskCompletionSourceCoreShared.s_sentinel, null) != null)
			{
				continuation(continuationState);
			}
			return true;
		}
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public UniTaskStatus GetStatus(short token)
	{
		ValidateToken(token);
		if (continuation != null && completedCount != 0)
		{
			if (error != null)
			{
				if (!(error is OperationCanceledException))
				{
					return UniTaskStatus.Faulted;
				}
				return UniTaskStatus.Canceled;
			}
			return UniTaskStatus.Succeeded;
		}
		return UniTaskStatus.Pending;
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public UniTaskStatus UnsafeGetStatus()
	{
		if (continuation != null && completedCount != 0)
		{
			if (error != null)
			{
				if (!(error is OperationCanceledException))
				{
					return UniTaskStatus.Faulted;
				}
				return UniTaskStatus.Canceled;
			}
			return UniTaskStatus.Succeeded;
		}
		return UniTaskStatus.Pending;
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public TResult GetResult(short token)
	{
		ValidateToken(token);
		if (completedCount == 0)
		{
			throw new InvalidOperationException("Not yet completed, UniTask only allow to use await.");
		}
		if (error != null)
		{
			hasUnhandledError = false;
			if (error is OperationCanceledException ex)
			{
				throw ex;
			}
			if (error is ExceptionHolder exceptionHolder)
			{
				exceptionHolder.GetException().Throw();
			}
			throw new InvalidOperationException("Critical: invalid exception type was held.");
		}
		return result;
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	public void OnCompleted(Action<object> continuation, object state, short token)
	{
		if (continuation == null)
		{
			throw new ArgumentNullException("continuation");
		}
		ValidateToken(token);
		object obj = this.continuation;
		if (obj == null)
		{
			continuationState = state;
			obj = Interlocked.CompareExchange(ref this.continuation, continuation, null);
		}
		if (obj != null)
		{
			if (obj != UniTaskCompletionSourceCoreShared.s_sentinel)
			{
				throw new InvalidOperationException("Already continuation registered, can not await twice or get Status after await.");
			}
			continuation(state);
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	[DebuggerHidden]
	private void ValidateToken(short token)
	{
		if (token != version)
		{
			throw new InvalidOperationException("Token version is not matched, can not await twice or get Status after await.");
		}
	}
}
