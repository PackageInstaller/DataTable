using System.Runtime.Serialization;

namespace System.Reflection;

[Serializable]
public sealed class AmbiguousMatchException : SystemException
{
	public AmbiguousMatchException()
		: base("Ambiguous match found.")
	{
		HResult = -2147475171;
	}

	public AmbiguousMatchException(string message)
		: base(message)
	{
		HResult = -2147475171;
	}

	internal AmbiguousMatchException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
