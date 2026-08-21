using System;
using System.Runtime.CompilerServices;

namespace GameFramework.Runtime;

public struct TransitionAwaiter(Transition transition) : IAwaiter, ICriticalNotifyCompletion, INotifyCompletion
{
	private Transition transition = transition ?? throw new ArgumentNullException("transition");

	public bool IsCompleted => transition.IsDone;

	public void GetResult()
	{
		if (!IsCompleted)
		{
			throw new Exception("The task is not finished yet");
		}
	}

	public void OnCompleted(Action continuation)
	{
		UnsafeOnCompleted(continuation);
	}

	public void UnsafeOnCompleted(Action continuation)
	{
		if (continuation == null)
		{
			throw new ArgumentNullException("continuation");
		}
		transition.OnFinish(continuation);
	}
}
