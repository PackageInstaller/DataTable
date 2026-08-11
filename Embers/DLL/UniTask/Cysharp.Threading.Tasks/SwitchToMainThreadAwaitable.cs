using System;
using System.Runtime.CompilerServices;
using System.Threading;

namespace Cysharp.Threading.Tasks;

public struct SwitchToMainThreadAwaitable(PlayerLoopTiming playerLoopTiming, CancellationToken cancellationToken)
{
	public struct Awaiter(PlayerLoopTiming playerLoopTiming, CancellationToken cancellationToken) : ICriticalNotifyCompletion, INotifyCompletion
	{
		private readonly PlayerLoopTiming playerLoopTiming = playerLoopTiming;

		private readonly CancellationToken cancellationToken = cancellationToken;

		public bool IsCompleted
		{
			get
			{
				int managedThreadId = Thread.CurrentThread.ManagedThreadId;
				if (PlayerLoopHelper.MainThreadId == managedThreadId)
				{
					return true;
				}
				return false;
			}
		}

		public void GetResult()
		{
			CancellationToken cancellationToken = this.cancellationToken;
			cancellationToken.ThrowIfCancellationRequested();
		}

		public void OnCompleted(Action continuation)
		{
			PlayerLoopHelper.AddContinuation(playerLoopTiming, continuation);
		}

		public void UnsafeOnCompleted(Action continuation)
		{
			PlayerLoopHelper.AddContinuation(playerLoopTiming, continuation);
		}
	}

	private readonly PlayerLoopTiming playerLoopTiming = playerLoopTiming;

	private readonly CancellationToken cancellationToken = cancellationToken;

	public Awaiter GetAwaiter()
	{
		return new Awaiter(playerLoopTiming, cancellationToken);
	}
}
