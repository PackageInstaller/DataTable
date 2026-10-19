using System.Runtime.InteropServices;
using System.Threading;

namespace System.Runtime.Remoting.Messaging;

[Serializable]
[ComVisible(true)]
public sealed class CallContext
{
	private CallContext()
	{
	}

	internal static object SetCurrentCallContext(LogicalCallContext ctx)
	{
		return null;
	}

	internal static LogicalCallContext SetLogicalCallContext(LogicalCallContext callCtx)
	{
		ExecutionContext mutableExecutionContext = Thread.CurrentThread.GetMutableExecutionContext();
		LogicalCallContext logicalCallContext = mutableExecutionContext.LogicalCallContext;
		mutableExecutionContext.LogicalCallContext = callCtx;
		return logicalCallContext;
	}
}
