using System;

namespace GameFramework.Runtime;

public class RejectedExecutionException : Exception
{
	public RejectedExecutionException()
	{
	}

	public RejectedExecutionException(string message)
		: base(message)
	{
	}

	public RejectedExecutionException(string format, params object[] arguments)
		: base(string.Format(format, arguments))
	{
	}

	public RejectedExecutionException(Exception exception, string format, params object[] arguments)
		: base(string.Format(format, arguments), exception)
	{
	}
}
