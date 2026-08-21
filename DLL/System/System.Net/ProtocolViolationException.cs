using System.Runtime.Serialization;

namespace System.Net;

[Serializable]
public class ProtocolViolationException : InvalidOperationException, ISerializable
{
	public ProtocolViolationException()
	{
	}

	public ProtocolViolationException(string message)
		: base(message)
	{
	}

	protected ProtocolViolationException(SerializationInfo serializationInfo, StreamingContext streamingContext)
		: base(serializationInfo, streamingContext)
	{
	}

	void ISerializable.GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		base.GetObjectData(serializationInfo, streamingContext);
	}

	public override void GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		base.GetObjectData(serializationInfo, streamingContext);
	}
}
