using System.Runtime.Serialization;

namespace System.Reflection;

[Serializable]
public sealed class TargetParameterCountException : ApplicationException
{
	public TargetParameterCountException()
		: base("Number of parameters specified does not match the expected number.")
	{
		base.HResult = -2147352562;
	}

	public TargetParameterCountException(string message)
		: base(message)
	{
		base.HResult = -2147352562;
	}

	internal TargetParameterCountException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
