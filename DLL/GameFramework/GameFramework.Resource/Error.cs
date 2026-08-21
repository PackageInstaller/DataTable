using System;
using System.Runtime.CompilerServices;

namespace GameFramework.Resource;

public static class Error
{
	[MethodImpl((MethodImplOptions)256)]
	public static void ThrowArgumentNullException<T>(T value, string paramName) where T : class
	{
		if (value == null)
		{
			ThrowArgumentNullExceptionCore(paramName);
		}
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void ThrowArgumentNullExceptionCore(string paramName)
	{
		throw new ArgumentNullException(paramName);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Exception ArgumentOutOfRange(string paramName)
	{
		return new ArgumentOutOfRangeException(paramName);
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Exception NoElements()
	{
		return new InvalidOperationException("Source sequence doesn't contain any elements.");
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Exception MoreThanOneElement()
	{
		return new InvalidOperationException("Source sequence contains more than one element.");
	}

	[MethodImpl((MethodImplOptions)8)]
	public static void ThrowArgumentException(string message)
	{
		throw new ArgumentException(message);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static void ThrowNotYetCompleted()
	{
		throw new InvalidOperationException("Not yet completed.");
	}

	[MethodImpl((MethodImplOptions)8)]
	public static T ThrowNotYetCompleted<T>()
	{
		throw new InvalidOperationException("Not yet completed.");
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void ThrowWhenContinuationIsAlreadyRegistered<T>(T continuationField) where T : class
	{
		if (continuationField != null)
		{
			ThrowInvalidOperationExceptionCore("continuation is already registered.");
		}
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void ThrowInvalidOperationExceptionCore(string message)
	{
		throw new InvalidOperationException(message);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static void ThrowOperationCanceledException()
	{
		throw new OperationCanceledException();
	}
}
