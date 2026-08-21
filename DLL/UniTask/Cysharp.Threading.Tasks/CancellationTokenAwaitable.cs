using System;
using System.Runtime.CompilerServices;
using System.Threading;

namespace Cysharp.Threading.Tasks;

public struct CancellationTokenAwaitable(CancellationToken cancellationToken)
{
	public struct Awaiter(CancellationToken cancellationToken) : ICriticalNotifyCompletion, INotifyCompletion
	{
		private CancellationToken cancellationToken = cancellationToken;

		public bool IsCompleted
		{
			get
			{
				if (cancellationToken.CanBeCanceled)
				{
					return cancellationToken.IsCancellationRequested;
				}
				return true;
			}
		}

		public void GetResult()
		{
		}

		public void OnCompleted(Action continuation)
		{
			UnsafeOnCompleted(continuation);
		}

		public void UnsafeOnCompleted(Action continuation)
		{
			cancellationToken.RegisterWithoutCaptureExecutionContext(continuation);
		}
	}

	private CancellationToken cancellationToken = cancellationToken;

	public Awaiter GetAwaiter()
	{
		return new Awaiter(cancellationToken);
	}
}
