using System.Runtime.Serialization;

namespace System.Runtime.InteropServices;

[Serializable]
public class InvalidOleVariantTypeException : SystemException
{
	public InvalidOleVariantTypeException()
		: base("Specified OLE variant was invalid.")
	{
		base.HResult = -2146233039;
	}

	protected InvalidOleVariantTypeException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
