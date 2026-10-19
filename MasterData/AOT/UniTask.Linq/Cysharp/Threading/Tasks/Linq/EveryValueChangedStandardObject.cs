using System;
using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class EveryValueChangedStandardObject<TTarget, TProperty> : IUniTaskAsyncEnumerable<TProperty> where TTarget : class
{
	private sealed class _EveryValueChanged : MoveNextSource, IUniTaskAsyncEnumerator<TProperty>, IUniTaskAsyncDisposable, IPlayerLoopItem
	{
		private readonly WeakReference<TTarget> target;

		private readonly IEqualityComparer<TProperty> equalityComparer;

		private readonly Func<TTarget, TProperty> propertySelector;

		private readonly CancellationToken cancellationToken;

		private readonly CancellationTokenRegistration cancellationTokenRegistration;

		private bool first;

		private TProperty currentValue;

		private bool disposed;

		public TProperty Current => currentValue;

		public _EveryValueChanged(WeakReference<TTarget> target, Func<TTarget, TProperty> propertySelector, IEqualityComparer<TProperty> equalityComparer, PlayerLoopTiming monitorTiming, CancellationToken cancellationToken, bool cancelImmediately)
		{
			this.target = target;
			this.propertySelector = propertySelector;
			this.equalityComparer = equalityComparer;
			this.cancellationToken = cancellationToken;
			first = true;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext((object state) =>
				{
					_EveryValueChanged everyValueChanged = (_EveryValueChanged)state;
					everyValueChanged.completionSource.TrySetCanceled(everyValueChanged.cancellationToken);
				}, this);
			}
			PlayerLoopHelper.AddAction(monitorTiming, this);
		}

		public UniTask<bool> MoveNextAsync()
		{
			if (disposed)
			{
				return CompletedTasks.False;
			}
			completionSource.Reset();
			CancellationToken cancellationToken = this.cancellationToken;
			if (cancellationToken.IsCancellationRequested)
			{
				completionSource.TrySetCanceled(this.cancellationToken);
				return new UniTask<bool>(this, completionSource.Version);
			}
			if (first)
			{
				first = false;
				if (!target.TryGetTarget(out var arg))
				{
					return CompletedTasks.False;
				}
				currentValue = propertySelector(arg);
				return CompletedTasks.True;
			}
			return new UniTask<bool>(this, completionSource.Version);
		}

		public UniTask DisposeAsync()
		{
			if (!disposed)
			{
				CancellationTokenRegistration cancellationTokenRegistration = this.cancellationTokenRegistration;
				cancellationTokenRegistration.Dispose();
				disposed = true;
			}
			return default;
		}

		public bool MoveNext()
		{
			if (disposed || !target.TryGetTarget(out var arg))
			{
				completionSource.TrySetResult(result: false);
				DisposeAsync().Forget();
				return false;
			}
			CancellationToken cancellationToken = this.cancellationToken;
			if (cancellationToken.IsCancellationRequested)
			{
				completionSource.TrySetCanceled(this.cancellationToken);
				return false;
			}
			TProperty val = default;
			try
			{
				val = propertySelector(arg);
				if (equalityComparer.Equals(currentValue, val))
				{
					return true;
				}
			}
			catch (Exception error)
			{
				completionSource.TrySetException(error);
				DisposeAsync().Forget();
				return false;
			}
			currentValue = val;
			completionSource.TrySetResult(result: true);
			return true;
		}
	}

	private readonly WeakReference<TTarget> target;

	private readonly Func<TTarget, TProperty> propertySelector;

	private readonly IEqualityComparer<TProperty> equalityComparer;

	private readonly PlayerLoopTiming monitorTiming;

	private readonly bool cancelImmediately;

	public EveryValueChangedStandardObject(TTarget target, Func<TTarget, TProperty> propertySelector, IEqualityComparer<TProperty> equalityComparer, PlayerLoopTiming monitorTiming, bool cancelImmediately)
	{
		this.target = new WeakReference<TTarget>(target, trackResurrection: false);
		this.propertySelector = propertySelector;
		this.equalityComparer = equalityComparer;
		this.monitorTiming = monitorTiming;
		this.cancelImmediately = cancelImmediately;
	}

	public IUniTaskAsyncEnumerator<TProperty> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _EveryValueChanged(target, propertySelector, equalityComparer, monitorTiming, cancellationToken, cancelImmediately);
	}
}
