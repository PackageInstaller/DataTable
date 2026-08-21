using System;
using System.Diagnostics;

namespace Nerdbank.Streams;

public static class Verify
{
	[DebuggerStepThrough]
	internal static void Operation(bool condition, string message)
	{
		if (!condition)
		{
			throw new InvalidOperationException(message);
		}
	}
}
