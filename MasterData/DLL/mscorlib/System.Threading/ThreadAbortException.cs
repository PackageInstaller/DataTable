using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.Threading;

[Serializable]
[ComVisible(true)]
public sealed class ThreadAbortException : SystemException
{
	private ThreadAbortException()
		: base(Exception.GetMessageFromNativeResources(ExceptionMessageKind.ThreadAbort))
	{
		SetErrorCode(-2146233040);
	}

	internal ThreadAbortException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
