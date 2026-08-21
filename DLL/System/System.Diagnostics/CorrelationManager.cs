using System.Collections;
using System.Runtime.Remoting.Messaging;

namespace System.Diagnostics;

public class CorrelationManager
{
	public Guid ActivityId
	{
		get
		{
			object obj = CallContext.LogicalGetData("E2ETrace.ActivityID");
			if (obj != null)
			{
				return (Guid)obj;
			}
			return Guid.Empty;
		}
	}

	public Stack LogicalOperationStack => GetLogicalOperationStack();

	internal CorrelationManager()
	{
	}

	private Stack GetLogicalOperationStack()
	{
		Stack stack = CallContext.LogicalGetData("System.Diagnostics.Trace.CorrelationManagerSlot") as Stack;
		if (stack == null)
		{
			stack = new Stack();
			CallContext.LogicalSetData("System.Diagnostics.Trace.CorrelationManagerSlot", stack);
		}
		return stack;
	}
}
