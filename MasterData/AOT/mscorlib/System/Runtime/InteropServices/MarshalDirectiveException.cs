using System.Runtime.Serialization;

namespace System.Runtime.InteropServices;

[Serializable]
public class MarshalDirectiveException : SystemException
{
	public MarshalDirectiveException()
		: base("Marshaling directives are invalid.")
	{
		HResult = -2146233035;
	}

	public MarshalDirectiveException(string message)
		: base(message)
	{
		HResult = -2146233035;
	}

	protected MarshalDirectiveException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
