using System.Threading;

namespace System;

public interface IAsyncResult
{
	bool IsCompleted { get; }

	WaitHandle AsyncWaitHandle { get; }

	object AsyncState { get; }

	bool CompletedSynchronously { get; }
}
