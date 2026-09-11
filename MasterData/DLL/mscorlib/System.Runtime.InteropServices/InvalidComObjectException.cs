using System.Runtime.Serialization;

namespace System.Runtime.InteropServices;

[Serializable]
public class InvalidComObjectException : SystemException
{
	public InvalidComObjectException()
		: base("Attempt has been made to use a COM object that does not have a backing class factory.")
	{
		base.HResult = -2146233049;
	}

	protected InvalidComObjectException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
