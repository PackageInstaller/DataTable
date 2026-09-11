using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;

namespace System.Runtime.CompilerServices;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public readonly struct YieldAwaitable
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	public readonly struct YieldAwaiter : ICriticalNotifyCompletion, INotifyCompletion
	{
		private static readonly WaitCallback s_waitCallbackRunAction = RunAction;

		private static readonly SendOrPostCallback s_sendOrPostCallbackRunAction = RunAction;

		public bool IsCompleted => false;

		public void OnCompleted(Action continuation)
		{
			QueueContinuation(continuation, flowContext: true);
		}

		public void UnsafeOnCompleted(Action continuation)
		{
			QueueContinuation(continuation, flowContext: false);
		}

		private static void QueueContinuation(Action continuation, bool flowContext)
		{
			if (continuation == null)
			{
				throw new ArgumentNullException("continuation");
			}
			SynchronizationContext currentNoFlow = SynchronizationContext.CurrentNoFlow;
			if (currentNoFlow != null && currentNoFlow.GetType() != typeof(SynchronizationContext))
			{
				currentNoFlow.Post(s_sendOrPostCallbackRunAction, continuation);
				return;
			}
			TaskScheduler current = TaskScheduler.Current;
			if (current == TaskScheduler.Default)
			{
				if (flowContext)
				{
					ThreadPool.QueueUserWorkItem(s_waitCallbackRunAction, continuation);
				}
				else
				{
					ThreadPool.UnsafeQueueUserWorkItem(s_waitCallbackRunAction, continuation);
				}
			}
			else
			{
				Task.Factory.StartNew(continuation, default(CancellationToken), TaskCreationOptions.PreferFairness, current);
			}
		}

		private static void RunAction(object state)
		{
			((Action)state)();
		}

		public void GetResult()
		{
		}
	}

	public YieldAwaiter GetAwaiter()
	{
		return default(YieldAwaiter);
	}
}
