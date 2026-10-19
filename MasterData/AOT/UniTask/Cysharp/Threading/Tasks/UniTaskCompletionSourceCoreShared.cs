using System;

namespace Cysharp.Threading.Tasks;

internal static class UniTaskCompletionSourceCoreShared
{
	internal static readonly Action<object> s_sentinel = CompletionSentinel;

	private static void CompletionSentinel(object _)
	{
		throw new InvalidOperationException("The sentinel delegate should never be invoked.");
	}
}
