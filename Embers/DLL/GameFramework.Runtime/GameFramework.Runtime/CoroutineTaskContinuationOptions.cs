using System;

namespace GameFramework.Runtime;

[Flags]
public enum CoroutineTaskContinuationOptions
{
	None = 0,
	OnCompleted = 1,
	OnCanceled = 2,
	OnFaulted = 4
}
