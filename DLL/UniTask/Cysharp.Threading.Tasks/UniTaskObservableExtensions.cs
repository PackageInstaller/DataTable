using System;
using System.Threading;
using Cysharp.Threading.Tasks.Internal;

namespace Cysharp.Threading.Tasks;

public static class UniTaskObservableExtensions
{
	private class ToUniTaskObserver<T> : IObserver<T>
	{
		private static readonly Action<object> callback = OnCanceled;

		private readonly UniTaskCompletionSource<T> promise;

		private readonly SingleAssignmentDisposable disposable;

		private readonly CancellationToken cancellationToken;

		private readonly CancellationTokenRegistration registration;

		private bool hasValue;

		private T latestValue;

		public ToUniTaskObserver(UniTaskCompletionSource<T> promise, SingleAssignmentDisposable disposable, CancellationToken cancellationToken)
		{
			this.promise = promise;
			this.disposable = disposable;
			this.cancellationToken = cancellationToken;
			if (this.cancellationToken.CanBeCanceled)
			{
				registration = this.cancellationToken.RegisterWithoutCaptureExecutionContext(callback, this);
			}
		}

		private static void OnCanceled(object state)
		{
			ToUniTaskObserver<T> toUniTaskObserver = (ToUniTaskObserver<T>)state;
			toUniTaskObserver.disposable.Dispose();
			toUniTaskObserver.promise.TrySetCanceled(toUniTaskObserver.cancellationToken);
		}

		public void OnNext(T value)
		{
			hasValue = true;
			latestValue = value;
		}

		public void OnError(Exception error)
		{
			try
			{
				promise.TrySetException(error);
			}
			finally
			{
				CancellationTokenRegistration cancellationTokenRegistration = registration;
				cancellationTokenRegistration.Dispose();
				disposable.Dispose();
			}
		}

		public void OnCompleted()
		{
			try
			{
				if (hasValue)
				{
					promise.TrySetResult(latestValue);
				}
				else
				{
					promise.TrySetException(new InvalidOperationException("Sequence has no elements"));
				}
			}
			finally
			{
				CancellationTokenRegistration cancellationTokenRegistration = registration;
				cancellationTokenRegistration.Dispose();
				disposable.Dispose();
			}
		}
	}

	private class FirstValueToUniTaskObserver<T> : IObserver<T>
	{
		private static readonly Action<object> callback = OnCanceled;

		private readonly UniTaskCompletionSource<T> promise;

		private readonly SingleAssignmentDisposable disposable;

		private readonly CancellationToken cancellationToken;

		private readonly CancellationTokenRegistration registration;

		private bool hasValue;

		public FirstValueToUniTaskObserver(UniTaskCompletionSource<T> promise, SingleAssignmentDisposable disposable, CancellationToken cancellationToken)
		{
			this.promise = promise;
			this.disposable = disposable;
			this.cancellationToken = cancellationToken;
			if (this.cancellationToken.CanBeCanceled)
			{
				registration = this.cancellationToken.RegisterWithoutCaptureExecutionContext(callback, this);
			}
		}

		private static void OnCanceled(object state)
		{
			FirstValueToUniTaskObserver<T> firstValueToUniTaskObserver = (FirstValueToUniTaskObserver<T>)state;
			firstValueToUniTaskObserver.disposable.Dispose();
			firstValueToUniTaskObserver.promise.TrySetCanceled(firstValueToUniTaskObserver.cancellationToken);
		}

		public void OnNext(T value)
		{
			hasValue = true;
			try
			{
				promise.TrySetResult(value);
			}
			finally
			{
				CancellationTokenRegistration cancellationTokenRegistration = registration;
				cancellationTokenRegistration.Dispose();
				disposable.Dispose();
			}
		}

		public void OnError(Exception error)
		{
			try
			{
				promise.TrySetException(error);
			}
			finally
			{
				CancellationTokenRegistration cancellationTokenRegistration = registration;
				cancellationTokenRegistration.Dispose();
				disposable.Dispose();
			}
		}

		public void OnCompleted()
		{
			try
			{
				if (!hasValue)
				{
					promise.TrySetException(new InvalidOperationException("Sequence has no elements"));
				}
			}
			finally
			{
				CancellationTokenRegistration cancellationTokenRegistration = registration;
				cancellationTokenRegistration.Dispose();
				disposable.Dispose();
			}
		}
	}

	private class ReturnObservable<T> : IObservable<T>
	{
		private readonly T value;

		public ReturnObservable(T value)
		{
			this.value = value;
		}

		public IDisposable Subscribe(IObserver<T> observer)
		{
			observer.OnNext(value);
			observer.OnCompleted();
			return EmptyDisposable.Instance;
		}
	}

	private class ThrowObservable<T> : IObservable<T>
	{
		private readonly Exception value;

		public ThrowObservable(Exception value)
		{
			this.value = value;
		}

		public IDisposable Subscribe(IObserver<T> observer)
		{
			observer.OnError(value);
			return EmptyDisposable.Instance;
		}
	}

	public static UniTask<T> ToUniTask<T>(this IObservable<T> source, bool useFirstValue = false, CancellationToken cancellationToken = default(CancellationToken))
	{
		UniTaskCompletionSource<T> uniTaskCompletionSource = new UniTaskCompletionSource<T>();
		SingleAssignmentDisposable singleAssignmentDisposable = new SingleAssignmentDisposable();
		IObserver<T> observer2;
		if (!useFirstValue)
		{
			IObserver<T> observer = new ToUniTaskObserver<T>(uniTaskCompletionSource, singleAssignmentDisposable, cancellationToken);
			observer2 = observer;
		}
		else
		{
			IObserver<T> observer = new FirstValueToUniTaskObserver<T>(uniTaskCompletionSource, singleAssignmentDisposable, cancellationToken);
			observer2 = observer;
		}
		IObserver<T> observer3 = observer2;
		try
		{
			singleAssignmentDisposable.Disposable = source.Subscribe(observer3);
		}
		catch (Exception exception)
		{
			uniTaskCompletionSource.TrySetException(exception);
		}
		return uniTaskCompletionSource.Task;
	}

	public static IObservable<T> ToObservable<T>(this UniTask<T> task)
	{
		if (task.Status.IsCompleted())
		{
			try
			{
				return new ReturnObservable<T>(task.GetAwaiter().GetResult());
			}
			catch (Exception value)
			{
				return new ThrowObservable<T>(value);
			}
		}
		AsyncSubject<T> asyncSubject = new AsyncSubject<T>();
		Fire(asyncSubject, task).Forget();
		return asyncSubject;
	}

	public static IObservable<AsyncUnit> ToObservable(this UniTask task)
	{
		if (task.Status.IsCompleted())
		{
			try
			{
				task.GetAwaiter().GetResult();
				return new ReturnObservable<AsyncUnit>(AsyncUnit.Default);
			}
			catch (Exception value)
			{
				return new ThrowObservable<AsyncUnit>(value);
			}
		}
		AsyncSubject<AsyncUnit> asyncSubject = new AsyncSubject<AsyncUnit>();
		Fire(asyncSubject, task).Forget();
		return asyncSubject;
	}

	private static async UniTaskVoid Fire<T>(AsyncSubject<T> subject, UniTask<T> task)
	{
		T value;
		try
		{
			value = await task;
		}
		catch (Exception error)
		{
			subject.OnError(error);
			return;
		}
		subject.OnNext(value);
		subject.OnCompleted();
	}

	private static async UniTaskVoid Fire(AsyncSubject<AsyncUnit> subject, UniTask task)
	{
		try
		{
			await task;
		}
		catch (Exception error)
		{
			subject.OnError(error);
			return;
		}
		subject.OnNext(AsyncUnit.Default);
		subject.OnCompleted();
	}
}
