using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class QueueOperator<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _Queue : IUniTaskAsyncEnumerator<TSource>, IUniTaskAsyncDisposable
	{
		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private CancellationToken cancellationToken;

		private Channel<TSource> channel;

		private IUniTaskAsyncEnumerator<TSource> channelEnumerator;

		private IUniTaskAsyncEnumerator<TSource> sourceEnumerator;

		private bool channelClosed;

		public TSource Current => channelEnumerator.Current;

		public _Queue(IUniTaskAsyncEnumerable<TSource> source, CancellationToken cancellationToken)
		{
			this.source = source;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (sourceEnumerator == null)
			{
				sourceEnumerator = source.GetAsyncEnumerator(cancellationToken);
				channel = Channel.CreateSingleConsumerUnbounded<TSource>();
				channelEnumerator = channel.Reader.ReadAllAsync().GetAsyncEnumerator(cancellationToken);
				ConsumeAll(this, sourceEnumerator, channel).Forget();
			}
			return channelEnumerator.MoveNextAsync();
		}

		private static async UniTaskVoid ConsumeAll(_Queue self, IUniTaskAsyncEnumerator<TSource> enumerator, ChannelWriter<TSource> writer)
		{
			try
			{
				while (await enumerator.MoveNextAsync())
				{
					writer.TryWrite(enumerator.Current);
				}
				writer.TryComplete();
			}
			catch (Exception error)
			{
				writer.TryComplete(error);
			}
			finally
			{
				self.channelClosed = true;
				await enumerator.DisposeAsync();
			}
		}

		public async UniTask DisposeAsync()
		{
			if (sourceEnumerator != null)
			{
				await sourceEnumerator.DisposeAsync();
			}
			if (channelEnumerator != null)
			{
				await channelEnumerator.DisposeAsync();
			}
			if (!channelClosed)
			{
				channelClosed = true;
				channel.Writer.TryComplete(new OperationCanceledException());
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	public QueueOperator(IUniTaskAsyncEnumerable<TSource> source)
	{
		this.source = source;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Queue(source, cancellationToken);
	}
}
