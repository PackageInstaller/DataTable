using System;
using System.Runtime.CompilerServices;
using System.Threading;

namespace Cysharp.Threading.Tasks;

public struct SwitchToSynchronizationContextAwaitable(SynchronizationContext synchronizationContext, CancellationToken cancellationToken)
{
	public struct Awaiter(SynchronizationContext synchronizationContext, CancellationToken cancellationToken) : ICriticalNotifyCompletion, INotifyCompletion
	{
		private static readonly SendOrPostCallback switchToCallback = Callback;

		private readonly SynchronizationContext synchronizationContext = synchronizationContext;

		private readonly CancellationToken cancellationToken = cancellationToken;

		public bool IsCompleted => false;

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

	private readonly SynchronizationContext synchronizationContext = synchronizationContext;

	private readonly CancellationToken cancellationToken = cancellationToken;

	public Awaiter GetAwaiter()
	{
		return new Awaiter(synchronizationContext, cancellationToken);
	}
}
