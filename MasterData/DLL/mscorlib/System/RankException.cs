using System.Runtime.Serialization;

namespace System;

[Serializable]
public class RankException : SystemException
{
	public RankException()
		: base("Attempted to operate on an array with the incorrect number of dimensions.")
	{
		base.HResult = -2146233065;
	}

	public RankException(string message)
		: base(message)
	{
		base.HResult = -2146233065;
	}

	protected RankException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
