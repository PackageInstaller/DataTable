using System;
using System.Runtime.Serialization;
using UnityEngine.Scripting;

namespace UnityEngine;

[Serializable]
[RequiredByNativeCode]
public class UnityException : Exception
{
	public UnityException()
		: base("A Unity Runtime error occurred!")
	{
		base.HResult = -2147467261;
	}

	public UnityException(string message)
		: base(message)
	{
		base.HResult = -2147467261;
	}

	protected UnityException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
