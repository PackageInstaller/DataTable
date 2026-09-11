using System.Runtime.Serialization;

namespace System.Security;

[Serializable]
public sealed class XmlSyntaxException : SystemException
{
	public XmlSyntaxException()
	{
	}

	public XmlSyntaxException(int lineNumber)
	{
	}

	public XmlSyntaxException(int lineNumber, string message)
	{
	}

	private XmlSyntaxException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
