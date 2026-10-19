using System.Runtime.Serialization;

namespace System.IO;

[Serializable]
public class DirectoryNotFoundException : IOException
{
	public DirectoryNotFoundException()
		: base("Attempted to access a path that is not on the disk.")
	{
		HResult = -2147024893;
	}

	public DirectoryNotFoundException(string message)
		: base(message)
	{
		HResult = -2147024893;
	}

	protected DirectoryNotFoundException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
