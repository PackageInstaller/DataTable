using System;
using System.Runtime.Serialization;

namespace UnityEngine;

[Serializable]
public class MissingReferenceException : Exception
{
	public MissingReferenceException()
		: base("A Unity Runtime error occurred!")
	{
		base.HResult = -2147467261;
	}

	public MissingReferenceException(string message)
		: base(message)
	{
		base.HResult = -2147467261;
	}

	protected MissingReferenceException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
