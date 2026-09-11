using System.Collections.Generic;

namespace System.Threading;

public class CancellationTokenSource : IDisposable
{
	private sealed class Linked1CancellationTokenSource : CancellationTokenSource
	{
		private readonly CancellationTokenRegistration _reg1;

		internal Linked1CancellationTokenSource(CancellationToken token1)
		{
			_reg1 = token1.InternalRegisterWithoutEC(LinkedNCancellationTokenSource.s_linkedTokenCancelDelegate, this);
		}

		protected override void Dispose(bool disposing)
		{
			if (disposing && !_disposed)
			{
				_reg1.Dispose();
				base.Dispose(disposing);
			}
		}
	}

	private sealed class Linked2CancellationTokenSource : CancellationTokenSource
	{
		private readonly CancellationTokenRegistration _reg1;

		private readonly CancellationTokenRegistration _reg2;

		internal Linked2CancellationTokenSource(CancellationToken token1, CancellationToken token2)
		{
			_reg1 = token1.InternalRegisterWithoutEC(LinkedNCancellationTokenSource.s_linkedTokenCancelDelegate, this);
			_reg2 = token2.InternalRegisterWithoutEC(LinkedNCancellationTokenSource.s_linkedTokenCancelDelegate, this);
		}

		protected override void Dispose(bool disposing)
		{
			if (disposing && !_disposed)
			{
				_reg1.Dispose();
				_reg2.Dispose();
				base.Dispose(disposing);
			}
		}
	}

	private sealed class LinkedNCancellationTokenSource : CancellationTokenSource
	{
		internal static readonly Action<object> s_linkedTokenCancelDelegate = delegate(object s)
		{
			((CancellationTokenSource)s).NotifyCancellation(throwOnFirstException: false);
		};

		private CancellationTokenRegistration[] _linkingRegistrations;

		internal LinkedNCancellationTokenSource(params CancellationToken[] tokens)
		{
			_linkingRegistrations = new CancellationTokenRegistration[tokens.Length];
			for (int i = 0; i < tokens.Length; i++)
			{
				if (tokens[i].CanBeCanceled)
				{
					_linkingRegistrations[i] = tokens[i].InternalRegisterWithoutEC(s_linkedTokenCancelDelegate, this);
				}
			}
		}

		protected override void Dispose(bool disposing)
		{
			if (!disposing || _disposed)
			{
				return;
			}
			CancellationTokenRegistration[] linkingRegistrations = _linkingRegistrations;
			if (linkingRegistrations != null)
			{
				_linkingRegistrations = null;
				for (int i = 0; i < linkingRegistrations.Length; i++)
				{
					linkingRegistrations[i].Dispose();
				}
			}
			base.Dispose(disposing);
		}
	}

	internal static readonly CancellationTokenSource s_canceledSource = new CancellationTokenSource
	{
		_state = 3
	};

	internal static readonly CancellationTokenSource s_neverCanceledSource = new CancellationTokenSource
	{
		_state = 0
	};

	private static readonly int s_nLists = ((PlatformHelper.ProcessorCount > 24) ? 24 : PlatformHelper.ProcessorCount);

	private volatile ManualResetEvent _kernelEvent;

	private volatile SparselyPopulatedArray<CancellationCallbackInfo>[] _registeredCallbacksLists;

	private const int CannotBeCanceled = 0;

	private const int NotCanceledState = 1;

	private const int NotifyingState = 2;

	private const int NotifyingCompleteState = 3;

	private volatile int _state;

	private volatile int _threadIDExecutingCallbacks = -1;

	private bool _disposed;

	private volatile CancellationCallbackInfo _executingCallback;

	private volatile Timer _timer;

	private static readonly TimerCallback s_timerCallback = TimerCallbackLogic;

	public bool IsCancellationRequested => _state >= 2;

	internal bool IsCancellationCompleted => _state == 3;

	internal bool IsDisposed => _disposed;

	internal int ThreadIDExecutingCallbacks
	{
		get
		{
			return _threadIDExecutingCallbacks;
		}
		set
		{
			_threadIDExecutingCallbacks = value;
		}
	}

	public CancellationToken Token
	{
		get
		{
			ThrowIfDisposed();
			return new CancellationToken(this);
		}
	}

	internal bool CanBeCanceled => _state != 0;

	internal WaitHandle WaitHandle
	{
		get
		{
			ThrowIfDisposed();
			if (_kernelEvent != null)
			{
				return _kernelEvent;
			}
			ManualResetEvent manualResetEvent = new ManualResetEvent(initialState: false);
			if (Interlocked.CompareExchange(ref _kernelEvent, manualResetEvent, null) != null)
			{
				manualResetEvent.Dispose();
			}
			if (IsCancellationRequested)
			{
				_kernelEvent.Set();
			}
			return _kernelEvent;
		}
	}

	internal CancellationCallbackInfo ExecutingCallback => _executingCallback;

	public CancellationTokenSource()
	{
		_state = 1;
	}

	public CancellationTokenSource(TimeSpan delay)
	{
		long num = (long)delay.TotalMilliseconds;
		if (num < -1 || num > int.MaxValue)
		{
			throw new ArgumentOutOfRangeException("delay");
		}
		InitializeWithTimer((int)num);
	}

	public CancellationTokenSource(int millisecondsDelay)
	{
		if (millisecondsDelay < -1)
		{
			throw new ArgumentOutOfRangeException("millisecondsDelay");
		}
		InitializeWithTimer(millisecondsDelay);
	}

	private void InitializeWithTimer(int millisecondsDelay)
	{
		_state = 1;
		_timer = new Timer(s_timerCallback, this, millisecondsDelay, -1);
	}

	public void Cancel()
	{
		Cancel(throwOnFirstException: false);
	}

	public void Cancel(bool throwOnFirstException)
	{
		ThrowIfDisposed();
		NotifyCancellation(throwOnFirstException);
	}

	public void CancelAfter(TimeSpan delay)
	{
		long num = (long)delay.TotalMilliseconds;
		if (num < -1 || num > int.MaxValue)
		{
			throw new ArgumentOutOfRangeException("delay");
		}
		CancelAfter((int)num);
	}

	public void CancelAfter(int millisecondsDelay)
	{
		ThrowIfDisposed();
		if (millisecondsDelay < -1)
		{
			throw new ArgumentOutOfRangeException("millisecondsDelay");
		}
		if (IsCancellationRequested)
		{
			return;
		}
		if (_timer == null)
		{
			Timer timer = new Timer(s_timerCallback, this, -1, -1);
			if (Interlocked.CompareExchange(ref _timer, timer, null) != null)
			{
				timer.Dispose();
			}
		}
		try
		{
			_timer.Change(millisecondsDelay, -1);
		}
		catch (ObjectDisposedException)
		{
		}
	}

	private static void TimerCallbackLogic(object obj)
	{
		CancellationTokenSource cancellationTokenSource = (CancellationTokenSource)obj;
		if (cancellationTokenSource.IsDisposed)
		{
			return;
		}
		try
		{
			cancellationTokenSource.Cancel();
		}
		catch (ObjectDisposedException)
		{
			if (!cancellationTokenSource.IsDisposed)
			{
				throw;
			}
		}
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
		if (!disposing || _disposed)
		{
			return;
		}
		_timer?.Dispose();
		_registeredCallbacksLists = null;
		if (_kernelEvent != null)
		{
			ManualResetEvent manualResetEvent = Interlocked.Exchange(ref _kernelEvent, null);
			if (manualResetEvent != null && _state != 2)
			{
				manualResetEvent.Dispose();
			}
		}
		_disposed = true;
	}

	internal void ThrowIfDisposed()
	{
		if (_disposed)
		{
			ThrowObjectDisposedException();
		}
	}

	private static void ThrowObjectDisposedException()
	{
		throw new ObjectDisposedException(null, "The CancellationTokenSource has been disposed.");
	}

	internal CancellationTokenRegistration InternalRegister(Action<object> callback, object stateForCallback, SynchronizationContext targetSyncContext, ExecutionContext executionContext)
	{
		if (!IsCancellationRequested)
		{
			if (_disposed)
			{
				return default(CancellationTokenRegistration);
			}
			int num = Environment.CurrentManagedThreadId % s_nLists;
			CancellationCallbackInfo cancellationCallbackInfo = ((targetSyncContext != null) ? new CancellationCallbackInfo.WithSyncContext(callback, stateForCallback, executionContext, this, targetSyncContext) : new CancellationCallbackInfo(callback, stateForCallback, executionContext, this));
			SparselyPopulatedArray<CancellationCallbackInfo>[] array = _registeredCallbacksLists;
			if (array == null)
			{
				SparselyPopulatedArray<CancellationCallbackInfo>[] array2 = new SparselyPopulatedArray<CancellationCallbackInfo>[s_nLists];
				array = Interlocked.CompareExchange(ref _registeredCallbacksLists, array2, null);
				if (array == null)
				{
					array = array2;
				}
			}
			SparselyPopulatedArray<CancellationCallbackInfo> sparselyPopulatedArray = Volatile.Read(ref array[num]);
			if (sparselyPopulatedArray == null)
			{
				SparselyPopulatedArray<CancellationCallbackInfo> value = new SparselyPopulatedArray<CancellationCallbackInfo>(4);
				Interlocked.CompareExchange(ref array[num], value, null);
				sparselyPopulatedArray = array[num];
			}
			SparselyPopulatedArrayAddInfo<CancellationCallbackInfo> registrationInfo = sparselyPopulatedArray.Add(cancellationCallbackInfo);
			CancellationTokenRegistration result = new CancellationTokenRegistration(cancellationCallbackInfo, registrationInfo);
			if (!IsCancellationRequested)
			{
				return result;
			}
			if (!result.Unregister())
			{
				return result;
			}
		}
		callback(stateForCallback);
		return default(CancellationTokenRegistration);
	}

	private void NotifyCancellation(bool throwOnFirstException)
	{
		if (!IsCancellationRequested && Interlocked.CompareExchange(ref _state, 2, 1) == 1)
		{
			_timer?.Dispose();
			ThreadIDExecutingCallbacks = Environment.CurrentManagedThreadId;
			_kernelEvent?.Set();
			ExecuteCallbackHandlers(throwOnFirstException);
		}
	}

	private void ExecuteCallbackHandlers(bool throwOnFirstException)
	{
		LowLevelListWithIList<Exception> lowLevelListWithIList = null;
		SparselyPopulatedArray<CancellationCallbackInfo>[] registeredCallbacksLists = _registeredCallbacksLists;
		if (registeredCallbacksLists == null)
		{
			Interlocked.Exchange(ref _state, 3);
			return;
		}
		try
		{
			for (int i = 0; i < registeredCallbacksLists.Length; i++)
			{
				SparselyPopulatedArray<CancellationCallbackInfo> sparselyPopulatedArray = Volatile.Read(ref registeredCallbacksLists[i]);
				if (sparselyPopulatedArray == null)
				{
					continue;
				}
				for (SparselyPopulatedArrayFragment<CancellationCallbackInfo> sparselyPopulatedArrayFragment = sparselyPopulatedArray.Tail; sparselyPopulatedArrayFragment != null; sparselyPopulatedArrayFragment = sparselyPopulatedArrayFragment.Prev)
				{
					for (int num = sparselyPopulatedArrayFragment.Length - 1; num >= 0; num--)
					{
						_executingCallback = sparselyPopulatedArrayFragment[num];
						if (_executingCallback != null)
						{
							CancellationCallbackCoreWorkArguments cancellationCallbackCoreWorkArguments = new CancellationCallbackCoreWorkArguments(sparselyPopulatedArrayFragment, num);
							try
							{
								if (_executingCallback is CancellationCallbackInfo.WithSyncContext withSyncContext)
								{
									withSyncContext.TargetSyncContext.Send(CancellationCallbackCoreWork_OnSyncContext, cancellationCallbackCoreWorkArguments);
									ThreadIDExecutingCallbacks = Environment.CurrentManagedThreadId;
								}
								else
								{
									CancellationCallbackCoreWork(cancellationCallbackCoreWorkArguments);
								}
							}
							catch (Exception item)
							{
								if (throwOnFirstException)
								{
									throw;
								}
								if (lowLevelListWithIList == null)
								{
									lowLevelListWithIList = new LowLevelListWithIList<Exception>();
								}
								lowLevelListWithIList.Add(item);
							}
						}
					}
				}
			}
		}
		finally
		{
			_state = 3;
			_executingCallback = null;
			Interlocked.MemoryBarrier();
		}
		if (lowLevelListWithIList == null)
		{
			return;
		}
		throw new AggregateException(lowLevelListWithIList);
	}

	private void CancellationCallbackCoreWork_OnSyncContext(object obj)
	{
		CancellationCallbackCoreWork((CancellationCallbackCoreWorkArguments)obj);
	}

	private void CancellationCallbackCoreWork(CancellationCallbackCoreWorkArguments args)
	{
		CancellationCallbackInfo cancellationCallbackInfo = args._currArrayFragment.SafeAtomicRemove(args._currArrayIndex, _executingCallback);
		if (cancellationCallbackInfo == _executingCallback)
		{
			cancellationCallbackInfo.CancellationTokenSource.ThreadIDExecutingCallbacks = Environment.CurrentManagedThreadId;
			cancellationCallbackInfo.ExecuteCallback();
		}
	}

	public static CancellationTokenSource CreateLinkedTokenSource(CancellationToken token1, CancellationToken token2)
	{
		if (token1.CanBeCanceled)
		{
			if (!token2.CanBeCanceled)
			{
				return new Linked1CancellationTokenSource(token1);
			}
			return new Linked2CancellationTokenSource(token1, token2);
		}
		return CreateLinkedTokenSource(token2);
	}

	internal static CancellationTokenSource CreateLinkedTokenSource(CancellationToken token)
	{
		if (!token.CanBeCanceled)
		{
			return new CancellationTokenSource();
		}
		return new Linked1CancellationTokenSource(token);
	}

	public static CancellationTokenSource CreateLinkedTokenSource(params CancellationToken[] tokens)
	{
		if (tokens == null)
		{
			throw new ArgumentNullException("tokens");
		}
		return tokens.Length switch
		{
			0 => throw new ArgumentException("No tokens were supplied."), 
			1 => CreateLinkedTokenSource(tokens[0]), 
			2 => CreateLinkedTokenSource(tokens[0], tokens[1]), 
			_ => new LinkedNCancellationTokenSource(tokens), 
		};
	}

	internal void WaitForCallbackToComplete(CancellationCallbackInfo callbackInfo)
	{
		SpinWait spinWait = default(SpinWait);
		while (ExecutingCallback == callbackInfo)
		{
			spinWait.SpinOnce();
		}
	}
}
