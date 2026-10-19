using System.Runtime.Serialization;

namespace System.IO;

[Serializable]
public class PathTooLongException : IOException
{
	public PathTooLongException()
		: base("The specified file name or path is too long, or a component of the specified path is too long.")
	{
		HResult = -2147024690;
	}

	public PathTooLongException(string message)
		: base(message)
	{
		HResult = -2147024690;
	}

	protected PathTooLongException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
