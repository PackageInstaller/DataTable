using System.Runtime.Serialization;

namespace System.Runtime;

[Serializable]
public sealed class AmbiguousImplementationException : Exception
{
	public AmbiguousImplementationException()
		: base("Ambiguous implementation found.")
	{
		HResult = -2146234262;
	}

	public AmbiguousImplementationException(string message)
		: base(message)
	{
		HResult = -2146234262;
	}

	private AmbiguousImplementationException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
