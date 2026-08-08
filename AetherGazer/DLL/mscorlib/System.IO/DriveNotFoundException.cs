using System.Runtime.Serialization;

namespace System.IO;

[Serializable]
public class DriveNotFoundException : IOException
{
	public DriveNotFoundException()
		: base("Could not find the drive. The drive might not be ready or might not be mapped.")
	{
		base.HResult = -2147024893;
	}

	public DriveNotFoundException(string message)
		: base(message)
	{
		base.HResult = -2147024893;
	}

	protected DriveNotFoundException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
