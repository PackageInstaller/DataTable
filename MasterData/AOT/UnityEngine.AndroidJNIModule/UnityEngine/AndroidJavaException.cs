using System;

namespace UnityEngine;

public sealed class AndroidJavaException : Exception
{
	private string mJavaStackTrace;

	public override string StackTrace => mJavaStackTrace + base.StackTrace;

	internal AndroidJavaException(string message, string javaStackTrace)
		: base(message)
	{
		mJavaStackTrace = javaStackTrace;
	}
}
