using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;

namespace Cysharp.Threading.Tasks;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct SwitchToTaskPoolAwaitable
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	public struct Awaiter : ICriticalNotifyCompletion, INotifyCompletion
	{
		private static readonly Action<object> switchToCallback = Callback;

		public bool IsCompleted => false;

		public void GetResult()
		{
		}

		public void OnCompleted(Action continuation)
		{
			Task.Factory.StartNew(switchToCallback, continuation, CancellationToken.None, TaskCreationOptions.DenyChildAttach, TaskScheduler.Default);
		}

		public void UnsafeOnCompleted(Action continuation)
		{
			Task.Factory.StartNew(switchToCallback, continuation, CancellationToken.None, TaskCreationOptions.DenyChildAttach, TaskScheduler.Default);
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
