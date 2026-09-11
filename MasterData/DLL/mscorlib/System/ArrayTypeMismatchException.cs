using System.Runtime.Serialization;

namespace System;

[Serializable]
public class ArrayTypeMismatchException : SystemException
{
	public ArrayTypeMismatchException()
		: base("Attempted to access an element as a type incompatible with the array.")
	{
		base.HResult = -2146233085;
	}

	protected ArrayTypeMismatchException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
