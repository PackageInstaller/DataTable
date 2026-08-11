using System;

namespace GameFramework.Runtime;

public interface ISynchronizable
{
	bool WaitForDone();

	object WaitForResult(int millisecondsTimeout = 0);

	object WaitForResult(TimeSpan timeout);
}
public interface ISynchronizable<TResult> : ISynchronizable
{
	new TResult WaitForResult(int millisecondsTimeout = 0);

	new TResult WaitForResult(TimeSpan timeout);
}
