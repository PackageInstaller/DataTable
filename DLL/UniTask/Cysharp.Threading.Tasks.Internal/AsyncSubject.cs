using System;
using System.Runtime.ExceptionServices;

namespace Cysharp.Threading.Tasks.Internal;

internal sealed class AsyncSubject<T> : IObservable<T>, IObserver<T>
{
	private class Subscription : IDisposable
	{
		private readonly object gate = new object();

		private AsyncSubject<T> parent;

		private IObserver<T> unsubscribeTarget;

		public Subscription(AsyncSubject<T> parent, IObserver<T> unsubscribeTarget)
		{
			this.parent = parent;
			this.unsubscribeTarget = unsubscribeTarget;
		}

		public void Dispose()
		{
			lock (gate)
			{
				if (parent == null)
				{
					return;
				}
				lock (parent.observerLock)
				{
					if (parent.outObserver is ListObserver<T> listObserver)
					{
						parent.outObserver = listObserver.Remove(unsubscribeTarget);
					}
					else
					{
						parent.outObserver = EmptyObserver<T>.Instance;
					}
					unsubscribeTarget = null;
					parent = null;
				}
			}
		}
	}

	private object observerLock = new object();

	private T lastValue;

	private bool hasValue;

	private bool isStopped;

	private bool isDisposed;

	private Exception lastError;

	private IObserver<T> outObserver = EmptyObserver<T>.Instance;

	public T Value
	{
		get
		{
			ThrowIfDisposed();
			if (!isStopped)
			{
				throw new InvalidOperationException("AsyncSubject is not completed yet");
			}
			if (lastError != null)
			{
				ExceptionDispatchInfo.Capture(lastError).Throw();
			}
			return lastValue;
		}
	}

	public bool HasObservers
	{
		get
		{
			if (!(outObserver is EmptyObserver<T>) && !isStopped)
			{
				return !isDisposed;
			}
			return false;
		}
	}

	public bool IsCompleted => isStopped;

	public void OnCompleted()
	{
		IObserver<T> observer;
		T value;
		bool flag;
		lock (observerLock)
		{
			ThrowIfDisposed();
			if (isStopped)
			{
				return;
			}
			observer = outObserver;
			outObserver = EmptyObserver<T>.Instance;
			isStopped = true;
			value = lastValue;
			flag = hasValue;
		}
		if (flag)
		{
			observer.OnNext(value);
			observer.OnCompleted();
		}
		else
		{
			observer.OnCompleted();
		}
	}

	public void OnError(Exception error)
	{
		if (error == null)
		{
			throw new ArgumentNullException("error");
		}
		IObserver<T> observer;
		lock (observerLock)
		{
			ThrowIfDisposed();
			if (isStopped)
			{
				return;
			}
			observer = outObserver;
			outObserver = EmptyObserver<T>.Instance;
			isStopped = true;
			lastError = error;
		}
		observer.OnError(error);
	}

	public void OnNext(T value)
	{
		lock (observerLock)
		{
			ThrowIfDisposed();
			if (!isStopped)
			{
				hasValue = true;
				lastValue = value;
			}
		}
	}

	public IDisposable Subscribe(IObserver<T> observer)
	{
		if (observer == null)
		{
			throw new ArgumentNullException("observer");
		}
		Exception ex = null;
		T value = default(T);
		bool flag = false;
		lock (observerLock)
		{
			ThrowIfDisposed();
			if (!isStopped)
			{
				if (outObserver is ListObserver<T> listObserver)
				{
					outObserver = listObserver.Add(observer);
				}
				else
				{
					IObserver<T> observer2 = outObserver;
					if (observer2 is EmptyObserver<T>)
					{
						outObserver = observer;
					}
					else
					{
						outObserver = new ListObserver<T>(new ImmutableList<IObserver<T>>(new IObserver<T>[2] { observer2, observer }));
					}
				}
				return new Subscription(this, observer);
			}
			ex = lastError;
			value = lastValue;
			flag = hasValue;
		}
		if (ex != null)
		{
			observer.OnError(ex);
		}
		else if (flag)
		{
			observer.OnNext(value);
			observer.OnCompleted();
		}
		else
		{
			observer.OnCompleted();
		}
		return EmptyDisposable.Instance;
	}

	public void Dispose()
	{
		lock (observerLock)
		{
			isDisposed = true;
			outObserver = DisposedObserver<T>.Instance;
			lastError = null;
			lastValue = default(T);
		}
	}

	private void ThrowIfDisposed()
	{
		if (isDisposed)
		{
			throw new ObjectDisposedException("");
		}
	}
}
