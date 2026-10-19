using System;
using System.Threading;
using System.Threading.Tasks.Sources;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class Create<T> : IUniTaskAsyncEnumerable<T>
{
	private sealed class _Create : MoveNextSource, IUniTaskAsyncEnumerator<T>, IUniTaskAsyncDisposable
	{
		private readonly Func<IAsyncWriter<T>, CancellationToken, UniTask> create;

		private readonly CancellationToken cancellationToken;

		private int state = -1;

		private AsyncWriter writer;

		public T Current { get; }

		public _Create(Func<IAsyncWriter<T>, CancellationToken, UniTask> create, CancellationToken cancellationToken)
		{
			this.create = create;
			this.cancellationToken = cancellationToken;
		}

		public UniTask DisposeAsync()
		{
			writer.Dispose();
			return default;
		}

		public UniTask<bool> MoveNextAsync()
		{
			if (state == -2)
			{
				return default;
			}
			completionSource.Reset();
			MoveNext();
			return new UniTask<bool>(this, completionSource.Version);
		}

		private void MoveNext()
		{
			try
			{
				switch (state)
				{
				case -1:
					writer = new AsyncWriter(this);
					RunWriterTask(create(writer, cancellationToken)).Forget();
					if (Volatile.Read(ref state) != -2)
					{
						state = 0;
					}
					return;
				case 0:
					writer.SignalWriter();
					return;
				}
			}
			catch (Exception error)
			{
				state = -2;
				completionSource.TrySetException(error);
				return;
			}
			state = -2;
			completionSource.TrySetResult(result: false);
		}

		private async UniTaskVoid RunWriterTask(UniTask task)
		{
			try
			{
				await task;
			}
			catch (Exception error)
			{
				Volatile.Write(ref state, -2);
				completionSource.TrySetException(error);
				return;
			}
			Volatile.Write(ref state, -2);
			completionSource.TrySetResult(result: false);
		}
	}

	private sealed class AsyncWriter : IUniTaskSource, IValueTaskSource, IAsyncWriter<T>, IDisposable
	{
		private readonly _Create enumerator;

		private UniTaskCompletionSourceCore<AsyncUnit> core;

		public AsyncWriter(_Create enumerator)
		{
			this.enumerator = enumerator;
		}

		public void Dispose()
		{
			if (core.GetStatus(core.Version) == UniTaskStatus.Pending)
			{
				core.TrySetCanceled();
			}
		}

		public void GetResult(short token)
		{
			core.GetResult(token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		public void SignalWriter()
		{
			core.TrySetResult(AsyncUnit.Default);
		}
	}

	private readonly Func<IAsyncWriter<T>, CancellationToken, UniTask> create;

	public Create(Func<IAsyncWriter<T>, CancellationToken, UniTask> create)
	{
		this.create = create;
	}

	public IUniTaskAsyncEnumerator<T> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Create(create, cancellationToken);
	}
}
