using System.Runtime.Serialization;

namespace System.IO;

[Serializable]
public class IOException : SystemException
{
	public IOException()
		: base("I/O error occurred.")
	{
		base.HResult = -2146232800;
	}

	public IOException(string message)
		: base(message)
	{
		base.HResult = -2146232800;
	}

	public IOException(string message, int hresult)
		: base(message)
	{
		base.HResult = hresult;
	}

	public IOException(string message, Exception innerException)
		: base(message, innerException)
	{
		base.HResult = -2146232800;
	}

	protected IOException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
