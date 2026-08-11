using System;

namespace UnityEngine.Assertions;

internal class AssertionMessageUtil
{
	public static string GetMessage(string failureMessage)
	{
		return UnityString.Format("{0} {1}", new object[2] { "Assertion failure.", failureMessage });
	}

	public static string GetMessage(string failureMessage, string expected)
	{
		return GetMessage(UnityString.Format("{0}{1}{2} {3}", new object[4]
		{
			failureMessage,
			Environment.NewLine,
			"Expected:",
			expected
		}));
	}

	public static string GetEqualityMessage(object actual, object expected, bool expectEqual)
	{
		return GetMessage(UnityString.Format("Values are {0}equal.", new object[1] { expectEqual ? "not " : "" }), UnityString.Format("{0} {2} {1}", new object[3]
		{
			actual,
			expected,
			expectEqual ? "==" : "!="
		}));
	}

	public static string NullFailureMessage(object value, bool expectNull)
	{
		return GetMessage(UnityString.Format("Value was {0}Null", new object[1] { expectNull ? "not " : "" }), UnityString.Format("Value was {0}Null", new object[1] { expectNull ? "" : "not " }));
	}

	public static string BooleanFailureMessage(bool expected)
	{
		return GetMessage("Value was " + !expected, expected.ToString());
	}
}
