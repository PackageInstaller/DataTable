using System;
using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

public abstract class AsyncTriggerBase<T> : MonoBehaviour, IUniTaskAsyncEnumerable<T>
{
	private sealed class AsyncTriggerEnumerator : MoveNextSource, IUniTaskAsyncEnumerator<T>, IUniTaskAsyncDisposable, ITriggerHandler<T>
	{
		private static Action<object> cancellationCallback = CancellationCallback;

		private readonly AsyncTriggerBase<T> parent;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration registration;

		private bool called;

		private bool isDisposed;

		public T Current { get; private set; }

		ITriggerHandler<T> ITriggerHandler<T>.Prev { get; set; }

		ITriggerHandler<T> ITriggerHandler<T>.Next { get; set; }

		public AsyncTriggerEnumerator(AsyncTriggerBase<T> parent, CancellationToken cancellationToken)
		{
			this.parent = parent;
			this.cancellationToken = cancellationToken;
		}

		public void OnCanceled(CancellationToken cancellationToken = default(CancellationToken))
		{
			completionSource.TrySetCanceled(cancellationToken);
		}

		public void OnNext(T value)
		{
			Current = value;
			completionSource.TrySetResult(result: true);
		}

		public void OnCompleted()
		{
			completionSource.TrySetResult(result: false);
		}

		public void OnError(Exception ex)
		{
			completionSource.TrySetException(ex);
		}

		private static void CancellationCallback(object state)
		{
			AsyncTriggerEnumerator asyncTriggerEnumerator = (AsyncTriggerEnumerator)state;
			asyncTriggerEnumerator.DisposeAsync().Forget();
			asyncTriggerEnumerator.completionSource.TrySetCanceled(asyncTriggerEnumerator.cancellationToken);
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			completionSource.Reset();
			if (!called)
			{
				called = true;
				parent.AddHandler(this);
				if (cancellationToken.CanBeCanceled)
				{
					registration = cancellationToken.RegisterWithoutCaptureExecutionContext(cancellationCallback, this);
				}
			}
			return new UniTask<bool>(this, completionSource.Version);
		}

		public UniTask DisposeAsync()
		{
			if (!isDisposed)
			{
				isDisposed = true;
				registration.Dispose();
				parent.RemoveHandler(this);
			}
			return default(UniTask);
		}
	}

	private class AwakeMonitor : IPlayerLoopItem
	{
		private readonly AsyncTriggerBase<T> trigger;

		public AwakeMonitor(AsyncTriggerBase<T> trigger)
		{
			this.trigger = trigger;
		}

		public bool MoveNext()
		{
			if (trigger.calledAwake)
			{
				return false;
			}
			if (trigger == null)
			{
				trigger.OnDestroy();
				return false;
			}
			return true;
		}
	}

	private TriggerEvent<T> triggerEvent;

	protected internal bool calledAwake;

	protected internal bool calledDestroy;

	private void Awake()
	{
		calledAwake = true;
	}

	private void OnDestroy()
	{
		if (!calledDestroy)
		{
			calledDestroy = true;
			triggerEvent.SetCompleted();
		}
	}

	internal void AddHandler(ITriggerHandler<T> handler)
	{
		if (!calledAwake)
		{
			PlayerLoopHelper.AddAction(PlayerLoopTiming.Update, new AwakeMonitor(this));
		}
		triggerEvent.Add(handler);
	}

	internal void RemoveHandler(ITriggerHandler<T> handler)
	{
		if (!calledAwake)
		{
			PlayerLoopHelper.AddAction(PlayerLoopTiming.Update, new AwakeMonitor(this));
		}
		triggerEvent.Remove(handler);
	}

	protected void RaiseEvent(T value)
	{
		triggerEvent.SetResult(value);
	}

	public IUniTaskAsyncEnumerator<T> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new AsyncTriggerEnumerator(this, cancellationToken);
	}
}
