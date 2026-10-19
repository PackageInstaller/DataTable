using System.Runtime.Serialization;

namespace System;

[Serializable]
public class UriFormatException : FormatException, ISerializable
{
	public UriFormatException()
	{
	}

	public UriFormatException(string textString)
		: base(textString)
	{
	}

	public UriFormatException(string textString, Exception e)
		: base(textString, e)
	{
	}

	protected UriFormatException(SerializationInfo serializationInfo, StreamingContext streamingContext)
		: base(serializationInfo, streamingContext)
	{
	}

	void ISerializable.GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		base.GetObjectData(serializationInfo, streamingContext);
	}
}
