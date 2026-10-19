using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class ToObservable<T> : IObservable<T>
{
	internal sealed class CancellationTokenDisposable : IDisposable
	{
		private readonly CancellationTokenSource cts = new CancellationTokenSource();

		public CancellationToken Token => cts.Token;

		public void Dispose()
		{
			if (!cts.IsCancellationRequested)
			{
				cts.Cancel();
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<T> source;

	public ToObservable(IUniTaskAsyncEnumerable<T> source)
	{
		this.source = source;
	}

	public IDisposable Subscribe(IObserver<T> observer)
	{
		CancellationTokenDisposable cancellationTokenDisposable = new CancellationTokenDisposable();
		RunAsync(source, observer, cancellationTokenDisposable.Token).Forget();
		return cancellationTokenDisposable;
	}

	private static async UniTaskVoid RunAsync(IUniTaskAsyncEnumerable<T> src, IObserver<T> observer, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<T> e = src.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				bool flag;
				try
				{
					flag = await e.MoveNextAsync();
				}
				catch (Exception error)
				{
					if (!cancellationToken.IsCancellationRequested)
					{
						observer.OnError(error);
					}
					return;
				}
				if (flag)
				{
					observer.OnNext(e.Current);
					continue;
				}
				observer.OnCompleted();
				return;
			}
			while (!cancellationToken.IsCancellationRequested);
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
