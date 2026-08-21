using System;
using System.Runtime.CompilerServices;
using System.Threading;

namespace Cysharp.Threading.Tasks;

public struct ReturnToSynchronizationContext(SynchronizationContext syncContext, bool dontPostWhenSameContext, CancellationToken cancellationToken)
{
	public struct Awaiter(SynchronizationContext synchronizationContext, bool dontPostWhenSameContext, CancellationToken cancellationToken) : ICriticalNotifyCompletion, INotifyCompletion
	{
		private static readonly SendOrPostCallback switchToCallback = Callback;

		private readonly SynchronizationContext synchronizationContext = synchronizationContext;

		private readonly bool dontPostWhenSameContext = dontPostWhenSameContext;

		private readonly CancellationToken cancellationToken = cancellationToken;

		public bool IsCompleted
		{
			get
			{
				if (!dontPostWhenSameContext)
				{
					return false;
				}
				if (SynchronizationContext.Current == synchronizationContext)
				{
					return true;
				}
				return false;
			}
		}

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
			synchronizationContext.Post(switchToCallback, continuation);
		}

		public void UnsafeOnCompleted(Action continuation)
		{
			synchronizationContext.Post(switchToCallback, continuation);
		}

		private static void Callback(object state)
		{
			((Action)state)();
		}
	}

	private readonly SynchronizationContext syncContext = syncContext;

	private readonly bool dontPostWhenSameContext = dontPostWhenSameContext;

	private readonly CancellationToken cancellationToken = cancellationToken;

	public Awaiter DisposeAsync()
	{
		return new Awaiter(syncContext, dontPostWhenSameContext, cancellationToken);
	}
}
