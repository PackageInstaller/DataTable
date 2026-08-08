using System.Runtime.ConstrainedExecution;
using System.Runtime.ExceptionServices;

namespace System.Threading;

internal struct ExecutionContextSwitcher
{
	internal ExecutionContext.Reader outerEC;

	internal bool outerECBelongsToScope;

	internal object hecsw;

	internal Thread thread;

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	[HandleProcessCorruptedStateExceptions]
	internal bool UndoNoThrow()
	{
		try
		{
			Undo();
		}
		catch
		{
			return false;
		}
		return true;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	internal void Undo()
	{
		if (thread != null)
		{
			Thread obj = thread;
			ExecutionContext.Reader executionContextReader = obj.GetExecutionContextReader();
			obj.SetExecutionContext(outerEC, outerECBelongsToScope);
			thread = null;
			ExecutionContext.OnAsyncLocalContextChanged(executionContextReader.DangerousGetRawExecutionContext(), outerEC.DangerousGetRawExecutionContext());
		}
	}
}
