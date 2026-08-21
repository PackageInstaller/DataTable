using System.Runtime.Serialization;

namespace System.Security.Authentication;

[Serializable]
public class AuthenticationException : SystemException
{
	public AuthenticationException()
		: base(Locale.GetText("Authentication exception."))
	{
	}

	public AuthenticationException(string message)
		: base(message)
	{
	}

	public AuthenticationException(string message, Exception innerException)
		: base(message, innerException)
	{
	}

	protected AuthenticationException(SerializationInfo serializationInfo, StreamingContext streamingContext)
		: base(serializationInfo, streamingContext)
	{
	}
}
