using System.Runtime.Serialization;

namespace System.IO;

[Serializable]
public class IOException : SystemException
{
	public IOException()
		: base("I/O error occurred.")
	{
		HResult = -2146232800;
	}

	public IOException(string message)
		: base(message)
	{
		HResult = -2146232800;
	}

	public IOException(string message, int hresult)
		: base(message)
	{
		HResult = hresult;
	}

	public IOException(string message, Exception innerException)
		: base(message, innerException)
	{
		HResult = -2146232800;
	}

	protected IOException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
