#define UNITY_ASSERTIONS
using System;
using System.Collections.Generic;
using System.Diagnostics;

namespace UnityEngine.Assertions;

[DebuggerStepThrough]
public static class Assert
{
	[Obsolete("Future versions of Unity are expected to always throw exceptions and not have this field.")]
	public static bool raiseExceptions = true;

	[Conditional("UNITY_ASSERTIONS")]
	public static void IsTrue(bool condition)
	{
		if (!condition)
		{
			IsTrue(condition, null);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void IsTrue(bool condition, string message)
	{
		if (!condition)
		{
			Fail(AssertionMessageUtil.BooleanFailureMessage(expected: true), message);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void IsFalse(bool condition, string message)
	{
		if (condition)
		{
			Fail(AssertionMessageUtil.BooleanFailureMessage(expected: false), message);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void AreEqual(int expected, int actual)
	{
		if (expected != actual)
		{
			AreEqual(expected, actual, null);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void IsNull<T>(T value) where T : class
	{
		IsNull(value, null);
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void IsNull<T>(T value, string message) where T : class
	{
		if (typeof(Object).IsAssignableFrom(typeof(T)))
		{
			IsNull(value as Object, message);
		}
		else if (value != null)
		{
			Fail(AssertionMessageUtil.NullFailureMessage(value, expectNull: true), message);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void IsNull(Object value, string message)
	{
		if (value != null)
		{
			Fail(AssertionMessageUtil.NullFailureMessage(value, expectNull: true), message);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void IsNotNull<T>(T value) where T : class
	{
		IsNotNull(value, null);
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void IsNotNull<T>(T value, string message) where T : class
	{
		if (typeof(Object).IsAssignableFrom(typeof(T)))
		{
			IsNotNull(value as Object, message);
		}
		else if (value == null)
		{
			Fail(AssertionMessageUtil.NullFailureMessage(value, expectNull: false), message);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void IsNotNull(Object value, string message)
	{
		if (value == null)
		{
			Fail(AssertionMessageUtil.NullFailureMessage(value, expectNull: false), message);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void AreEqual<T>(T expected, T actual)
	{
		AreEqual(expected, actual, null);
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void AreEqual<T>(T expected, T actual, string message)
	{
		AreEqual(expected, actual, message, EqualityComparer<T>.Default);
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void AreEqual<T>(T expected, T actual, string message, IEqualityComparer<T> comparer)
	{
		if (typeof(Object).IsAssignableFrom(typeof(T)))
		{
			AreEqual(expected as Object, actual as Object, message);
		}
		else if (!comparer.Equals(actual, expected))
		{
			Fail(AssertionMessageUtil.GetEqualityMessage(actual, expected, expectEqual: true), message);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void AreEqual(Object expected, Object actual, string message)
	{
		if (actual != expected)
		{
			Fail(AssertionMessageUtil.GetEqualityMessage(actual, expected, expectEqual: true), message);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void AreNotEqual<T>(T expected, T actual)
	{
		AreNotEqual(expected, actual, null);
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void AreNotEqual<T>(T expected, T actual, string message)
	{
		AreNotEqual(expected, actual, message, EqualityComparer<T>.Default);
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void AreNotEqual<T>(T expected, T actual, string message, IEqualityComparer<T> comparer)
	{
		if (typeof(Object).IsAssignableFrom(typeof(T)))
		{
			AreNotEqual(expected as Object, actual as Object, message);
		}
		else if (comparer.Equals(actual, expected))
		{
			Fail(AssertionMessageUtil.GetEqualityMessage(actual, expected, expectEqual: false), message);
		}
	}

	[Conditional("UNITY_ASSERTIONS")]
	public static void AreNotEqual(Object expected, Object actual, string message)
	{
		if (actual == expected)
		{
			Fail(AssertionMessageUtil.GetEqualityMessage(actual, expected, expectEqual: false), message);
		}
	}

	private static void Fail(string message, string userMessage)
	{
		if (!raiseExceptions)
		{
			if (message == null)
			{
				message = "Assertion has failed\n";
			}
			if (userMessage != null)
			{
				message = userMessage + "\n" + message;
			}
			Debug.LogAssertion(message);
			return;
		}
		throw new AssertionException(message, userMessage);
	}
}
