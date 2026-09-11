using System.Runtime.Serialization;

namespace System;

[Serializable]
public class CannotUnloadAppDomainException : SystemException
{
	public CannotUnloadAppDomainException()
		: base("Attempt to unload the AppDomain failed.")
	{
		base.HResult = -2146234347;
	}

	public CannotUnloadAppDomainException(string message)
		: base(message)
	{
		base.HResult = -2146234347;
	}

	protected CannotUnloadAppDomainException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
