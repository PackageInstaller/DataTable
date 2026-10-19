using System;
using System.Runtime.Serialization;

namespace UnityEngine;

[Serializable]
public class MissingComponentException : Exception
{
	private const int Result = -2147467261;

	private string unityStackTrace;

	public MissingComponentException()
		: base("A Unity Runtime error occurred!")
	{
		HResult = -2147467261;
	}

	public MissingComponentException(string message)
		: base(message)
	{
		HResult = -2147467261;
	}

	public MissingComponentException(string message, Exception innerException)
		: base(message, innerException)
	{
		HResult = -2147467261;
	}

	protected MissingComponentException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
