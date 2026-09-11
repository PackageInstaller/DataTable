using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace System.Threading;

[DebuggerDisplay("IsCancellationRequested = {IsCancellationRequested}")]
public readonly struct CancellationToken
{
	private readonly CancellationTokenSource _source;

	private static readonly Action<object> s_actionToActionObjShunt = delegate(object obj)
	{
		((Action)obj)();
	};

	public static CancellationToken None => default(CancellationToken);

	public bool IsCancellationRequested
	{
		get
		{
			if (_source != null)
			{
				return _source.IsCancellationRequested;
			}
			return false;
		}
	}

	public bool CanBeCanceled => _source != null;

	public WaitHandle WaitHandle => (_source ?? CancellationTokenSource.s_neverCanceledSource).WaitHandle;

	internal CancellationToken(CancellationTokenSource source)
	{
		_source = source;
	}

	public CancellationToken(bool canceled)
		: this(canceled ? CancellationTokenSource.s_canceledSource : null)
	{
	}

	public CancellationTokenRegistration Register(Action callback)
	{
		return Register(s_actionToActionObjShunt, callback ?? throw new ArgumentNullException("callback"), useSynchronizationContext: false, useExecutionContext: true);
	}

	public CancellationTokenRegistration Register(Action callback, bool useSynchronizationContext)
	{
		return Register(s_actionToActionObjShunt, callback ?? throw new ArgumentNullException("callback"), useSynchronizationContext, useExecutionContext: true);
	}

	public CancellationTokenRegistration Register(Action<object> callback, object state)
	{
		return Register(callback, state, useSynchronizationContext: false, useExecutionContext: true);
	}

	public CancellationTokenRegistration Register(Action<object> callback, object state, bool useSynchronizationContext)
	{
		return Register(callback, state, useSynchronizationContext, useExecutionContext: true);
	}

	internal CancellationTokenRegistration InternalRegisterWithoutEC(Action<object> callback, object state)
	{
		return Register(callback, state, useSynchronizationContext: false, useExecutionContext: false);
	}

	[MethodImpl((MethodImplOptions)8)]
	public CancellationTokenRegistration Register(Action<object> callback, object state, bool useSynchronizationContext, bool useExecutionContext)
	{
		if (callback == null)
		{
			throw new ArgumentNullException("callback");
		}
		return _source?.InternalRegister(callback, state, useSynchronizationContext ? SynchronizationContext.Current : null, useExecutionContext ? ExecutionContext.Capture() : null) ?? default(CancellationTokenRegistration);
	}

	public bool Equals(CancellationToken other)
	{
		return _source == other._source;
	}

	public override bool Equals(object other)
	{
		if (other is CancellationToken)
		{
			return Equals((CancellationToken)other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return (_source ?? CancellationTokenSource.s_neverCanceledSource).GetHashCode();
	}

	public static bool operator ==(CancellationToken left, CancellationToken right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(CancellationToken left, CancellationToken right)
	{
		return !left.Equals(right);
	}

	public void ThrowIfCancellationRequested()
	{
		if (IsCancellationRequested)
		{
			ThrowOperationCanceledException();
		}
	}

	private void ThrowOperationCanceledException()
	{
		throw new OperationCanceledException("The operation was canceled.", this);
	}
}
