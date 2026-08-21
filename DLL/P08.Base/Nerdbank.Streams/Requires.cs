using System;
using System.Diagnostics;

namespace Nerdbank.Streams;

public static class Requires
{
	[DebuggerStepThrough]
	public static void Range(bool condition, string parameterName, string message = null)
	{
		if (!condition)
		{
			FailRange(parameterName, message);
		}
	}

	[DebuggerStepThrough]
	public static Exception FailRange(string parameterName, string message = null)
	{
		if (string.IsNullOrEmpty(message))
		{
			throw new ArgumentOutOfRangeException(parameterName);
		}
		throw new ArgumentOutOfRangeException(parameterName, message);
	}

	[DebuggerStepThrough]
	public static T NotNull<T>(T value, string parameterName) where T : class
	{
		if (value == null)
		{
			throw new ArgumentNullException(parameterName);
		}
		return value;
	}

	[DebuggerStepThrough]
	public static void Argument(bool condition, string parameterName, string message)
	{
		if (!condition)
		{
			throw new ArgumentException(message, parameterName);
		}
	}

	[DebuggerStepThrough]
	public static void Argument(bool condition, string parameterName, string message, object arg1)
	{
		if (!condition)
		{
			throw new ArgumentException(string.Format(message, arg1), parameterName);
		}
	}

	[DebuggerStepThrough]
	public static void Argument(bool condition, string parameterName, string message, object arg1, object arg2)
	{
		if (!condition)
		{
			throw new ArgumentException(string.Format(message, arg1, arg2), parameterName);
		}
	}

	[DebuggerStepThrough]
	public static void Argument(bool condition, string parameterName, string message, params object[] args)
	{
		if (!condition)
		{
			throw new ArgumentException(string.Format(message, args), parameterName);
		}
	}
}
