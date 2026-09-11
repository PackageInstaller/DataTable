using System.Runtime.Serialization;

namespace System.Net;

[Serializable]
public class WebException : InvalidOperationException, ISerializable
{
	private WebExceptionStatus m_Status = WebExceptionStatus.UnknownError;

	private WebResponse m_Response;

	[NonSerialized]
	private WebExceptionInternalStatus m_InternalStatus;

	public WebExceptionStatus Status => m_Status;

	public WebResponse Response => m_Response;

	internal WebExceptionInternalStatus InternalStatus => m_InternalStatus;

	public WebException()
	{
	}

	public WebException(string message)
		: this(message, null)
	{
	}

	public WebException(string message, Exception innerException)
		: base(message, innerException)
	{
	}

	public WebException(string message, WebExceptionStatus status)
		: this(message, null, status, null)
	{
	}

	internal WebException(string message, WebExceptionStatus status, WebExceptionInternalStatus internalStatus, Exception innerException)
		: this(message, innerException, status, null, internalStatus)
	{
	}

	public WebException(string message, Exception innerException, WebExceptionStatus status, WebResponse response)
		: this(message, null, innerException, status, response)
	{
	}

	internal WebException(string message, string data, Exception innerException, WebExceptionStatus status, WebResponse response)
		: base(message + ((data != null) ? (": '" + data + "'") : ""), innerException)
	{
		m_Status = status;
		m_Response = response;
	}

	internal WebException(string message, Exception innerException, WebExceptionStatus status, WebResponse response, WebExceptionInternalStatus internalStatus)
		: this(message, null, innerException, status, response, internalStatus)
	{
	}

	internal WebException(string message, string data, Exception innerException, WebExceptionStatus status, WebResponse response, WebExceptionInternalStatus internalStatus)
		: base(message + ((data != null) ? (": '" + data + "'") : ""), innerException)
	{
		m_Status = status;
		m_Response = response;
		m_InternalStatus = internalStatus;
	}

	protected WebException(SerializationInfo serializationInfo, StreamingContext streamingContext)
		: base(serializationInfo, streamingContext)
	{
	}

	void ISerializable.GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		GetObjectData(serializationInfo, streamingContext);
	}

	public override void GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		base.GetObjectData(serializationInfo, streamingContext);
	}
}
