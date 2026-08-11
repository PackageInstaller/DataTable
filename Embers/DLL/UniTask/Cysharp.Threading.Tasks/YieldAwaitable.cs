using System;
using System.Runtime.CompilerServices;
using System.Threading;

namespace Cysharp.Threading.Tasks;

public readonly struct YieldAwaitable(PlayerLoopTiming timing)
{
	public readonly struct Awaiter(PlayerLoopTiming timing) : ICriticalNotifyCompletion, INotifyCompletion
	{
		private readonly PlayerLoopTiming timing = timing;

		public bool IsCompleted => false;

		public void GetResult()
		{
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

	private readonly PlayerLoopTiming timing = timing;

	public Awaiter GetAwaiter()
	{
		return new Awaiter(timing);
	}

	public UniTask ToUniTask()
	{
		return UniTask.Yield(timing, CancellationToken.None);
	}
}
