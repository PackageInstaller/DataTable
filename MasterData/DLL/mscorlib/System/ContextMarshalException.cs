using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System;

[Serializable]
[ComVisible(true)]
public class ContextMarshalException : SystemException
{
	public ContextMarshalException()
		: base(Environment.GetResourceString("Attempted to marshal an object across a context boundary."))
	{
		SetErrorCode(-2146233084);
	}

	protected ContextMarshalException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
