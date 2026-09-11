namespace System.Runtime.Serialization;

[Serializable]
public class SerializationException : SystemException
{
	private static string s_nullMessage = "Serialization error.";

	public SerializationException()
		: base(s_nullMessage)
	{
		base.HResult = -2146233076;
	}

	public SerializationException(string message)
		: base(message)
	{
		base.HResult = -2146233076;
	}

	public SerializationException(string message, Exception innerException)
		: base(message, innerException)
	{
		base.HResult = -2146233076;
	}

	protected SerializationException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
