using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal static class Subscribe
{
	public static readonly Action<Exception> NopError = (Exception _) =>
	{
	};

	public static readonly Action NopCompleted = () =>
	{
	};

	public static async UniTaskVoid SubscribeCore<TSource>(IUniTaskAsyncEnumerable<TSource> source, Action<TSource> onNext, Action<Exception> onError, Action onCompleted, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				try
				{
					onNext(e.Current);
				}
				catch (Exception ex)
				{
					UniTaskScheduler.PublishUnobservedTaskException(ex);
				}
			}
			onCompleted();
		}
		catch (Exception ex2)
		{
			if (onError == NopError)
			{
				UniTaskScheduler.PublishUnobservedTaskException(ex2);
				return;
			}
			if (ex2 is OperationCanceledException)
			{
				return;
			}
			onError(ex2);
		}
		finally
		{
			IAsyncDisposable asyncDisposable = e as IAsyncDisposable;
			if (asyncDisposable != null)
			{
				await asyncDisposable.DisposeAsync();
			}
		}
	}

	public static async UniTaskVoid SubscribeCore<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTaskVoid> onNext, Action<Exception> onError, Action onCompleted, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				try
				{
					onNext(e.Current).Forget();
				}
				catch (Exception ex)
				{
					UniTaskScheduler.PublishUnobservedTaskException(ex);
				}
			}
			onCompleted();
		}
		catch (Exception ex2)
		{
			if (onError == NopError)
			{
				UniTaskScheduler.PublishUnobservedTaskException(ex2);
				return;
			}
			if (ex2 is OperationCanceledException)
			{
				return;
			}
			onError(ex2);
		}
		finally
		{
			IAsyncDisposable asyncDisposable = e as IAsyncDisposable;
			if (asyncDisposable != null)
			{
				await asyncDisposable.DisposeAsync();
			}
		}
	}

	public static async UniTaskVoid SubscribeCore<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTaskVoid> onNext, Action<Exception> onError, Action onCompleted, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				try
				{
					onNext(e.Current, cancellationToken).Forget();
				}
				catch (Exception ex)
				{
					UniTaskScheduler.PublishUnobservedTaskException(ex);
				}
			}
			onCompleted();
		}
		catch (Exception ex2)
		{
			if (onError == NopError)
			{
				UniTaskScheduler.PublishUnobservedTaskException(ex2);
				return;
			}
			if (ex2 is OperationCanceledException)
			{
				return;
			}
			onError(ex2);
		}
		finally
		{
			IAsyncDisposable asyncDisposable = e as IAsyncDisposable;
			if (asyncDisposable != null)
			{
				await asyncDisposable.DisposeAsync();
			}
		}
	}

	public static async UniTaskVoid SubscribeCore<TSource>(IUniTaskAsyncEnumerable<TSource> source, IObserver<TSource> observer, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				try
				{
					observer.OnNext(e.Current);
				}
				catch (Exception ex)
				{
					UniTaskScheduler.PublishUnobservedTaskException(ex);
				}
			}
			observer.OnCompleted();
		}
		catch (Exception ex2)
		{
			if (ex2 is OperationCanceledException)
			{
				return;
			}
			observer.OnError(ex2);
		}
		finally
		{
			IAsyncDisposable asyncDisposable = e as IAsyncDisposable;
			if (asyncDisposable != null)
			{
				await asyncDisposable.DisposeAsync();
			}
		}
	}

	public static async UniTaskVoid SubscribeAwaitCore<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask> onNext, Action<Exception> onError, Action onCompleted, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			_ = 1;
			try
			{
				while (await e.MoveNextAsync())
				{
					try
					{
						await onNext(e.Current);
					}
					catch (Exception ex)
					{
						UniTaskScheduler.PublishUnobservedTaskException(ex);
					}
				}
				onCompleted();
			}
			catch (Exception ex2)
			{
				if (onError == NopError)
				{
					UniTaskScheduler.PublishUnobservedTaskException(ex2);
					return;
				}
				if (ex2 is OperationCanceledException)
				{
					return;
				}
				onError(ex2);
			}
		}
		finally
		{
			IAsyncDisposable asyncDisposable = e as IAsyncDisposable;
			if (asyncDisposable != null)
			{
				await asyncDisposable.DisposeAsync();
			}
		}
	}

	public static async UniTaskVoid SubscribeAwaitCore<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask> onNext, Action<Exception> onError, Action onCompleted, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			_ = 1;
			try
			{
				while (await e.MoveNextAsync())
				{
					try
					{
						await onNext(e.Current, cancellationToken);
					}
					catch (Exception ex)
					{
						UniTaskScheduler.PublishUnobservedTaskException(ex);
					}
				}
				onCompleted();
			}
			catch (Exception ex2)
			{
				if (onError == NopError)
				{
					UniTaskScheduler.PublishUnobservedTaskException(ex2);
					return;
				}
				if (ex2 is OperationCanceledException)
				{
					return;
				}
				onError(ex2);
			}
		}
		finally
		{
			IAsyncDisposable asyncDisposable = e as IAsyncDisposable;
			if (asyncDisposable != null)
			{
				await asyncDisposable.DisposeAsync();
			}
		}
	}
}
