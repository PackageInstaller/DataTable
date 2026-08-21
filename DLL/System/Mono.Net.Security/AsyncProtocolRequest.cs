using System;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace Mono.Net.Security;

internal abstract class AsyncProtocolRequest
{
	private int Started;

	private int RequestedSize;

	private int WriteRequested;

	private readonly object locker = new object();

	private static int next_id;

	public MobileAuthenticatedStream Parent { get; }

	public bool RunSynchronously { get; }

	public string Name => GetType().Name;

	public int UserResult { get; protected set; }

	public AsyncProtocolRequest(MobileAuthenticatedStream parent, bool sync)
	{
		Parent = parent;
		RunSynchronously = sync;
	}

	internal void RequestRead(int size)
	{
		lock (locker)
		{
			RequestedSize += size;
		}
	}

	internal void RequestWrite()
	{
		WriteRequested = 1;
	}

	internal async Task<AsyncProtocolResult> StartOperation(CancellationToken cancellationToken)
	{
		if (Interlocked.CompareExchange(ref Started, 1, 0) != 0)
		{
			throw new InvalidOperationException();
		}
		try
		{
			await ProcessOperation(cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			return new AsyncProtocolResult(UserResult);
		}
		catch (Exception exception)
		{
			return new AsyncProtocolResult(Parent.SetException(exception));
		}
	}

	private async Task ProcessOperation(CancellationToken cancellationToken)
	{
		AsyncOperationStatus status = AsyncOperationStatus.Initialize;
		while (status != AsyncOperationStatus.Complete)
		{
			cancellationToken.ThrowIfCancellationRequested();
			int? num = await InnerRead(cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			if (num.HasValue)
			{
				if (num == 0)
				{
					status = AsyncOperationStatus.ReadDone;
				}
				else if (num < 0)
				{
					throw new IOException("Remote prematurely closed connection.");
				}
			}
			if ((uint)status <= 2u)
			{
				AsyncOperationStatus newStatus;
				try
				{
					newStatus = Run(status);
				}
				catch (Exception e)
				{
					throw MobileAuthenticatedStream.GetSSPIException(e);
				}
				if (Interlocked.Exchange(ref WriteRequested, 0) != 0)
				{
					await Parent.InnerWrite(RunSynchronously, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
				}
				status = newStatus;
				continue;
			}
			throw new InvalidOperationException();
		}
	}

	private async Task<int?> InnerRead(CancellationToken cancellationToken)
	{
		int? totalRead = null;
		int requestedSize = Interlocked.Exchange(ref RequestedSize, 0);
		while (requestedSize > 0)
		{
			int num = await Parent.InnerRead(RunSynchronously, requestedSize, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			if (num <= 0)
			{
				return num;
			}
			if (num > requestedSize)
			{
				throw new InvalidOperationException();
			}
			totalRead += num;
			requestedSize -= num;
			int num2 = Interlocked.Exchange(ref RequestedSize, 0);
			requestedSize += num2;
		}
		return totalRead;
	}

	protected abstract AsyncOperationStatus Run(AsyncOperationStatus status);

	public override string ToString()
	{
		return $"[{Name}]";
	}
}
