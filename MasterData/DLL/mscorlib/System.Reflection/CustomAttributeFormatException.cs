using System.Runtime.Serialization;

namespace System.Reflection;

[Serializable]
public class CustomAttributeFormatException : FormatException
{
	public CustomAttributeFormatException()
		: this("Binary format of the specified custom attribute was invalid.")
	{
	}

	public CustomAttributeFormatException(string message)
		: this(message, null)
	{
	}

	public CustomAttributeFormatException(string message, Exception inner)
		: base(message, inner)
	{
		base.HResult = -2146232827;
	}

	protected CustomAttributeFormatException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
