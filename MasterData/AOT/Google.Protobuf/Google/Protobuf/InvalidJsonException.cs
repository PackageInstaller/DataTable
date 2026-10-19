using System.IO;

namespace Google.Protobuf;

public sealed class InvalidJsonException : IOException
{
	internal InvalidJsonException(string message)
		: base(message)
	{
	}
}
