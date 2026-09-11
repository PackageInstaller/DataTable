using System.Runtime.Serialization;

namespace System.Reflection;

[Serializable]
public sealed class AmbiguousMatchException : SystemException
{
	public AmbiguousMatchException()
		: base("Ambiguous match found.")
	{
		base.HResult = -2147475171;
	}

	public AmbiguousMatchException(string message)
		: base(message)
	{
		base.HResult = -2147475171;
	}

	public AmbiguousMatchException(string message, Exception inner)
		: base(message, inner)
	{
		base.HResult = -2147475171;
	}

	internal AmbiguousMatchException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
