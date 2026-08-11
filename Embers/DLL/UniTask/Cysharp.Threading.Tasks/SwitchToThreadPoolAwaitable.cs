using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Threading;

namespace Cysharp.Threading.Tasks;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct SwitchToThreadPoolAwaitable
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	public struct Awaiter : ICriticalNotifyCompletion, INotifyCompletion
	{
		private static readonly WaitCallback switchToCallback = Callback;

		public bool IsCompleted => false;

		public void GetResult()
		{
		}

		public void OnCompleted(Action continuation)
		{
			ThreadPool.QueueUserWorkItem(switchToCallback, continuation);
		}

		public void UnsafeOnCompleted(Action continuation)
		{
			ThreadPool.UnsafeQueueUserWorkItem(switchToCallback, continuation);
		}

		private static void Callback(object state)
		{
			((Action)state)();
		}
	}

	public Awaiter GetAwaiter()
	{
		return default(Awaiter);
	}
}
