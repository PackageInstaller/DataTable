using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.Threading;

[Serializable]
[ComVisible(true)]
public class ThreadInterruptedException : SystemException
{
	public ThreadInterruptedException()
		: base(Exception.GetMessageFromNativeResources(ExceptionMessageKind.ThreadInterrupted))
	{
		SetErrorCode(-2146233063);
	}

	public ThreadInterruptedException(string message)
		: base(message)
	{
		SetErrorCode(-2146233063);
	}

	public ThreadInterruptedException(string message, Exception innerException)
		: base(message, innerException)
	{
		SetErrorCode(-2146233063);
	}

	protected ThreadInterruptedException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
