using System.Runtime.Serialization;

namespace System;

[Serializable]
public class AppDomainUnloadedException : SystemException
{
	public AppDomainUnloadedException()
		: base("Attempted to access an unloaded AppDomain.")
	{
		base.HResult = -2146234348;
	}

	protected AppDomainUnloadedException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
