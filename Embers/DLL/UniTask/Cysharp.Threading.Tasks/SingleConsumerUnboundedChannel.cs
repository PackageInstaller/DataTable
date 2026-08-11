using System;
using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks;

internal class SingleConsumerUnboundedChannel<T> : Channel<T>
{
	private sealed class SingleConsumerUnboundedChannelWriter : ChannelWriter<T>
	{
		private readonly SingleConsumerUnboundedChannel<T> parent;

		public SingleConsumerUnboundedChannelWriter(SingleConsumerUnboundedChannel<T> parent)
		{
			this.parent = parent;
		}

		public override bool TryWrite(T item)
		{
			bool isWaiting;
			lock (parent.items)
			{
				if (parent.closed)
				{
					return false;
				}
				parent.items.Enqueue(item);
				isWaiting = parent.readerSource.isWaiting;
			}
			if (isWaiting)
			{
				parent.readerSource.SingalContinuation();
			}
			return true;
		}

		public override bool TryComplete(Exception error = null)
		{
			lock (parent.items)
			{
				if (parent.closed)
				{
					return false;
				}
				parent.closed = true;
				bool isWaiting = parent.readerSource.isWaiting;
				if (parent.items.Count == 0)
				{
					if (error == null)
					{
						if (parent.completedTaskSource != null)
						{
							parent.completedTaskSource.TrySetResult();
						}
						else
						{
							parent.completedTask = UniTask.CompletedTask;
						}
					}
					else if (parent.completedTaskSource != null)
					{
						parent.completedTaskSource.TrySetException(error);
					}
					else
					{
						parent.completedTask = UniTask.FromException(error);
					}
					if (isWaiting)
					{
						parent.readerSource.SingalCompleted(error);
					}
				}
				parent.completionError = error;
			}
			return true;
		}
	}

	private sealed class SingleConsumerUnboundedChannelReader : ChannelReader<T>, IUniTaskSource<bool>, IUniTaskSource
	{
		private sealed class ReadAllAsyncEnumerable : IUniTaskAsyncEnumerable<T>, IUniTaskAsyncEnumerator<T>, IUniTaskAsyncDisposable
		{
			private readonly Action<object> CancellationCallback1Delegate = CancellationCallback1;

			private readonly Action<object> CancellationCallback2Delegate = CancellationCallback2;

			private readonly SingleConsumerUnboundedChannelReader parent;

			private CancellationToken cancellationToken1;

			private CancellationToken cancellationToken2;

			private CancellationTokenRegistration cancellationTokenRegistration1;

			private CancellationTokenRegistration cancellationTokenRegistration2;

			private T current;

			private bool cacheValue;

			private bool running;

			public T Current
			{
				get
				{
					if (cacheValue)
					{
						return current;
					}
					parent.TryRead(out current);
					return current;
				}
			}

			public ReadAllAsyncEnumerable(SingleConsumerUnboundedChannelReader parent, CancellationToken cancellationToken)
			{
				this.parent = parent;
				cancellationToken1 = cancellationToken;
			}

			public IUniTaskAsyncEnumerator<T> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
			{
				if (running)
				{
					throw new InvalidOperationException("Enumerator is already running, does not allow call GetAsyncEnumerator twice.");
				}
				if (cancellationToken1 != cancellationToken)
				{
					cancellationToken2 = cancellationToken;
				}
				if (cancellationToken1.CanBeCanceled)
				{
					cancellationTokenRegistration1 = cancellationToken1.RegisterWithoutCaptureExecutionContext(CancellationCallback1Delegate, this);
				}
				if (cancellationToken2.CanBeCanceled)
				{
					cancellationTokenRegistration2 = cancellationToken2.RegisterWithoutCaptureExecutionContext(CancellationCallback2Delegate, this);
				}
				running = true;
				return this;
			}

			public UniTask<bool> MoveNextAsync()
			{
				cacheValue = false;
				return parent.WaitToReadAsync(CancellationToken.None);
			}

			public UniTask DisposeAsync()
			{
				cancellationTokenRegistration1.Dispose();
				cancellationTokenRegistration2.Dispose();
				return default(UniTask);
			}

			private static void CancellationCallback1(object state)
			{
				ReadAllAsyncEnumerable readAllAsyncEnumerable = (ReadAllAsyncEnumerable)state;
				readAllAsyncEnumerable.parent.SingalCancellation(readAllAsyncEnumerable.cancellationToken1);
			}

			private static void CancellationCallback2(object state)
			{
				ReadAllAsyncEnumerable readAllAsyncEnumerable = (ReadAllAsyncEnumerable)state;
				readAllAsyncEnumerable.parent.SingalCancellation(readAllAsyncEnumerable.cancellationToken2);
			}
		}

		private readonly Action<object> CancellationCallbackDelegate = CancellationCallback;

		private readonly SingleConsumerUnboundedChannel<T> parent;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private UniTaskCompletionSourceCore<bool> core;

		internal bool isWaiting;

		public override UniTask Completion
		{
			get
			{
				if (parent.completedTaskSource != null)
				{
					return parent.completedTaskSource.Task;
				}
				if (parent.closed)
				{
					return parent.completedTask;
				}
				parent.completedTaskSource = new UniTaskCompletionSource();
				return parent.completedTaskSource.Task;
			}
		}

		public SingleConsumerUnboundedChannelReader(SingleConsumerUnboundedChannel<T> parent)
		{
			this.parent = parent;
		}

		public override bool TryRead(out T item)
		{
			lock (parent.items)
			{
				if (parent.items.Count == 0)
				{
					item = default(T);
					return false;
				}
				item = parent.items.Dequeue();
				if (parent.closed && parent.items.Count == 0)
				{
					if (parent.completionError != null)
					{
						if (parent.completedTaskSource != null)
						{
							parent.completedTaskSource.TrySetException(parent.completionError);
						}
						else
						{
							parent.completedTask = UniTask.FromException(parent.completionError);
						}
					}
					else if (parent.completedTaskSource != null)
					{
						parent.completedTaskSource.TrySetResult();
					}
					else
					{
						parent.completedTask = UniTask.CompletedTask;
					}
				}
			}
			return true;
		}

		public override UniTask<bool> WaitToReadAsync(CancellationToken cancellationToken)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return UniTask.FromCanceled<bool>(cancellationToken);
			}
			lock (parent.items)
			{
				if (parent.items.Count != 0)
				{
					return CompletedTasks.True;
				}
				if (parent.closed)
				{
					if (parent.completionError == null)
					{
						return CompletedTasks.False;
					}
					return UniTask.FromException<bool>(parent.completionError);
				}
				cancellationTokenRegistration.Dispose();
				core.Reset();
				isWaiting = true;
				this.cancellationToken = cancellationToken;
				if (this.cancellationToken.CanBeCanceled)
				{
					cancellationTokenRegistration = this.cancellationToken.RegisterWithoutCaptureExecutionContext(CancellationCallbackDelegate, this);
				}
				return new UniTask<bool>(this, core.Version);
			}
		}

		public void SingalContinuation()
		{
			core.TrySetResult(result: true);
		}

		public void SingalCancellation(CancellationToken cancellationToken)
		{
			core.TrySetCanceled(cancellationToken);
		}

		public void SingalCompleted(Exception error)
		{
			if (error != null)
			{
				core.TrySetException(error);
			}
			else
			{
				core.TrySetResult(result: false);
			}
		}

		public override IUniTaskAsyncEnumerable<T> ReadAllAsync(CancellationToken cancellationToken = default(CancellationToken))
		{
			return new ReadAllAsyncEnumerable(this, cancellationToken);
		}

		bool IUniTaskSource<bool>.GetResult(short token)
		{
			return core.GetResult(token);
		}

		void IUniTaskSource.GetResult(short token)
		{
			core.GetResult(token);
		}

		UniTaskStatus IUniTaskSource.GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		void IUniTaskSource.OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		UniTaskStatus IUniTaskSource.UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		private static void CancellationCallback(object state)
		{
			SingleConsumerUnboundedChannelReader obj = (SingleConsumerUnboundedChannelReader)state;
			obj.SingalCancellation(obj.cancellationToken);
		}
	}

	private readonly Queue<T> items;

	private readonly SingleConsumerUnboundedChannelReader readerSource;

	private UniTaskCompletionSource completedTaskSource;

	private UniTask completedTask;

	private Exception completionError;

	private bool closed;

	public SingleConsumerUnboundedChannel()
	{
		items = new Queue<T>();
		base.Writer = new SingleConsumerUnboundedChannelWriter(this);
		readerSource = new SingleConsumerUnboundedChannelReader(this);
		base.Reader = readerSource;
	}
}
