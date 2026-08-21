using System;
using System.Runtime.CompilerServices;
using System.Threading;

namespace Cysharp.Threading.Tasks;

public struct ReturnToMainThread(PlayerLoopTiming playerLoopTiming, CancellationToken cancellationToken)
{
	public readonly struct Awaiter(PlayerLoopTiming timing, CancellationToken cancellationToken) : ICriticalNotifyCompletion, INotifyCompletion
	{
		private readonly PlayerLoopTiming timing = timing;

		private readonly CancellationToken cancellationToken = cancellationToken;

		public bool IsCompleted => PlayerLoopHelper.MainThreadId == Thread.CurrentThread.ManagedThreadId;

		public Awaiter GetAwaiter()
		{
			return this;
		}

		public void GetResult()
		{
			CancellationToken cancellationToken = this.cancellationToken;
			cancellationToken.ThrowIfCancellationRequested();
		}

		public void OnCompleted(Action continuation)
		{
			PlayerLoopHelper.AddContinuation(timing, continuation);
		}

		public void UnsafeOnCompleted(Action continuation)
		{
			PlayerLoopHelper.AddContinuation(timing, continuation);
		}
	}

	private readonly PlayerLoopTiming playerLoopTiming = playerLoopTiming;

	private readonly CancellationToken cancellationToken = cancellationToken;

	public Awaiter DisposeAsync()
	{
		return new Awaiter(playerLoopTiming, cancellationToken);
	}
}
