using System.Runtime.Serialization;

namespace System.Threading;

[Serializable]
public class WaitHandleCannotBeOpenedException : ApplicationException
{
	public WaitHandleCannotBeOpenedException()
		: base("No handle of the given name exists.")
	{
		HResult = -2146233044;
	}

	public WaitHandleCannotBeOpenedException(string message)
		: base(message)
	{
		HResult = -2146233044;
	}

	protected WaitHandleCannotBeOpenedException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
