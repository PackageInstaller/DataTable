using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.ExceptionServices;
using System.Threading;

namespace Cysharp.Threading.Tasks;

public class UniTaskCompletionSource : IUniTaskSource, IPromise, IResolvePromise, IRejectPromise, ICancelPromise
{
	private CancellationToken cancellationToken;

	private ExceptionHolder exception;

	private object gate;

	private Action<object> singleContinuation;

	private object singleState;

	private List<(Action<object>, object)> secondaryContinuationList;

	private int intStatus;

	private bool handled;

	public UniTask Task
	{
		[DebuggerHidden]
		get
		{
			return new UniTask(this, 0);
		}
	}

	[DebuggerHidden]
	internal void MarkHandled()
	{
		if (!handled)
		{
			handled = true;
		}
	}

	[DebuggerHidden]
	public bool TrySetResult()
	{
		return TrySignalCompletion(UniTaskStatus.Succeeded);
	}

	[DebuggerHidden]
	public bool TrySetCanceled(CancellationToken cancellationToken = default(CancellationToken))
	{
		if (UnsafeGetStatus() != UniTaskStatus.Pending)
		{
			return false;
		}
		this.cancellationToken = cancellationToken;
		return TrySignalCompletion(UniTaskStatus.Canceled);
	}

	[DebuggerHidden]
	public bool TrySetException(Exception exception)
	{
		if (exception is OperationCanceledException ex)
		{
			return TrySetCanceled(ex.CancellationToken);
		}
		if (UnsafeGetStatus() != UniTaskStatus.Pending)
		{
			return false;
		}
		this.exception = new ExceptionHolder(ExceptionDispatchInfo.Capture(exception));
		return TrySignalCompletion(UniTaskStatus.Faulted);
	}

	[DebuggerHidden]
	public void GetResult(short token)
	{
		MarkHandled();
		switch ((UniTaskStatus)intStatus)
		{
		case UniTaskStatus.Succeeded:
			break;
		case UniTaskStatus.Faulted:
			exception.GetException().Throw();
			break;
		case UniTaskStatus.Canceled:
			throw new OperationCanceledException(cancellationToken);
		default:
			throw new InvalidOperationException("not yet completed.");
		}
	}

	[DebuggerHidden]
	public UniTaskStatus GetStatus(short token)
	{
		return (UniTaskStatus)intStatus;
	}

	[DebuggerHidden]
	public UniTaskStatus UnsafeGetStatus()
	{
		return (UniTaskStatus)intStatus;
	}

	[DebuggerHidden]
	public void OnCompleted(Action<object> continuation, object state, short token)
	{
		if (gate == null)
		{
			Interlocked.CompareExchange(ref gate, new object(), null);
		}
		lock (Thread.VolatileRead(ref gate))
		{
			if (intStatus != 0)
			{
				continuation(state);
				return;
			}
			if (singleContinuation == null)
			{
				singleContinuation = continuation;
				singleState = state;
				return;
			}
			if (secondaryContinuationList == null)
			{
				secondaryContinuationList = new List<(Action<object>, object)>();
			}
			secondaryContinuationList.Add((continuation, state));
		}
	}

	[DebuggerHidden]
	private bool TrySignalCompletion(UniTaskStatus status)
	{
		if (Interlocked.CompareExchange(ref intStatus, (int)status, 0) == 0)
		{
			if (gate == null)
			{
				Interlocked.CompareExchange(ref gate, new object(), null);
			}
			lock (Thread.VolatileRead(ref gate))
			{
				if (singleContinuation != null)
				{
					try
					{
						singleContinuation(singleState);
					}
					catch (Exception ex)
					{
						UniTaskScheduler.PublishUnobservedTaskException(ex);
					}
				}
				if (secondaryContinuationList != null)
				{
					foreach (var (action, obj) in secondaryContinuationList)
					{
						try
						{
							action(obj);
						}
						catch (Exception ex2)
						{
							UniTaskScheduler.PublishUnobservedTaskException(ex2);
						}
					}
				}
				singleContinuation = null;
				singleState = null;
				secondaryContinuationList = null;
			}
			return true;
		}
		return false;
	}
}
public class UniTaskCompletionSource<T> : IUniTaskSource<T>, IUniTaskSource, IPromise<T>, IResolvePromise<T>, IRejectPromise, ICancelPromise
{
	private CancellationToken cancellationToken;

	private T result;

	private ExceptionHolder exception;

	private object gate;

	private Action<object> singleContinuation;

	private object singleState;

	private List<(Action<object>, object)> secondaryContinuationList;

	private int intStatus;

	private bool handled;

	public UniTask<T> Task
	{
		[DebuggerHidden]
		get
		{
			return new UniTask<T>(this, 0);
		}
	}

	[DebuggerHidden]
	internal void MarkHandled()
	{
		if (!handled)
		{
			handled = true;
		}
	}

	[DebuggerHidden]
	public bool TrySetResult(T result)
	{
		if (UnsafeGetStatus() != UniTaskStatus.Pending)
		{
			return false;
		}
		this.result = result;
		return TrySignalCompletion(UniTaskStatus.Succeeded);
	}

	[DebuggerHidden]
	public bool TrySetCanceled(CancellationToken cancellationToken = default(CancellationToken))
	{
		if (UnsafeGetStatus() != UniTaskStatus.Pending)
		{
			return false;
		}
		this.cancellationToken = cancellationToken;
		return TrySignalCompletion(UniTaskStatus.Canceled);
	}

	[DebuggerHidden]
	public bool TrySetException(Exception exception)
	{
		if (exception is OperationCanceledException ex)
		{
			return TrySetCanceled(ex.CancellationToken);
		}
		if (UnsafeGetStatus() != UniTaskStatus.Pending)
		{
			return false;
		}
		this.exception = new ExceptionHolder(ExceptionDispatchInfo.Capture(exception));
		return TrySignalCompletion(UniTaskStatus.Faulted);
	}

	[DebuggerHidden]
	public T GetResult(short token)
	{
		MarkHandled();
		switch ((UniTaskStatus)intStatus)
		{
		case UniTaskStatus.Succeeded:
			return result;
		case UniTaskStatus.Faulted:
			exception.GetException().Throw();
			return default(T);
		case UniTaskStatus.Canceled:
			throw new OperationCanceledException(cancellationToken);
		default:
			throw new InvalidOperationException("not yet completed.");
		}
	}

	[DebuggerHidden]
	void IUniTaskSource.GetResult(short token)
	{
		GetResult(token);
	}

	[DebuggerHidden]
	public UniTaskStatus GetStatus(short token)
	{
		return (UniTaskStatus)intStatus;
	}

	[DebuggerHidden]
	public UniTaskStatus UnsafeGetStatus()
	{
		return (UniTaskStatus)intStatus;
	}

	[DebuggerHidden]
	public void OnCompleted(Action<object> continuation, object state, short token)
	{
		if (gate == null)
		{
			Interlocked.CompareExchange(ref gate, new object(), null);
		}
		lock (Thread.VolatileRead(ref gate))
		{
			if (intStatus != 0)
			{
				continuation(state);
				return;
			}
			if (singleContinuation == null)
			{
				singleContinuation = continuation;
				singleState = state;
				return;
			}
			if (secondaryContinuationList == null)
			{
				secondaryContinuationList = new List<(Action<object>, object)>();
			}
			secondaryContinuationList.Add((continuation, state));
		}
	}

	[DebuggerHidden]
	private bool TrySignalCompletion(UniTaskStatus status)
	{
		if (Interlocked.CompareExchange(ref intStatus, (int)status, 0) == 0)
		{
			if (gate == null)
			{
				Interlocked.CompareExchange(ref gate, new object(), null);
			}
			lock (Thread.VolatileRead(ref gate))
			{
				if (singleContinuation != null)
				{
					try
					{
						singleContinuation(singleState);
					}
					catch (Exception ex)
					{
						UniTaskScheduler.PublishUnobservedTaskException(ex);
					}
				}
				if (secondaryContinuationList != null)
				{
					foreach (var (action, obj) in secondaryContinuationList)
					{
						try
						{
							action(obj);
						}
						catch (Exception ex2)
						{
							UniTaskScheduler.PublishUnobservedTaskException(ex2);
						}
					}
				}
				singleContinuation = null;
				singleState = null;
				secondaryContinuationList = null;
			}
			return true;
		}
		return false;
	}
}
