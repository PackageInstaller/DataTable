using System.Collections.ObjectModel;
using System.Runtime.ExceptionServices;
using Internal.Runtime.Augments;

namespace System.Threading.Tasks;

internal sealed class UnwrapPromise<TResult> : Task<TResult>, ITaskCompletionAction
{
	private byte _state;

	private readonly bool _lookForOce;

	public bool InvokeMayRunArbitraryCode => true;

	public UnwrapPromise(Task outerTask, bool lookForOce)
		: base((object)null, outerTask.CreationOptions & TaskCreationOptions.AttachedToParent)
	{
		_lookForOce = lookForOce;
		_state = 0;
		if (DebuggerSupport.LoggingOn)
		{
			DebuggerSupport.TraceOperationCreation(CausalityTraceLevel.Required, this, "Task.Unwrap", 0uL);
		}
		DebuggerSupport.AddToActiveTasks(this);
		if (outerTask.IsCompleted)
		{
			ProcessCompletedOuterTask(outerTask);
		}
		else
		{
			outerTask.AddCompletionAction(this);
		}
	}

	public void Invoke(Task completingTask)
	{
		StackGuard currentStackGuard = Task.CurrentStackGuard;
		if (currentStackGuard.TryBeginInliningScope())
		{
			try
			{
				InvokeCore(completingTask);
				return;
			}
			finally
			{
				currentStackGuard.EndInliningScope();
			}
		}
		InvokeCoreAsync(completingTask);
	}

	private void InvokeCore(Task completingTask)
	{
		switch (_state)
		{
		case 0:
			ProcessCompletedOuterTask(completingTask);
			break;
		case 1:
			TrySetFromTask(completingTask, lookForOce: false);
			_state = 2;
			break;
		}
	}

	private void InvokeCoreAsync(Task completingTask)
	{
		ThreadPool.UnsafeQueueUserWorkItem(delegate(object state)
		{
			Tuple<UnwrapPromise<TResult>, Task> tuple = (Tuple<UnwrapPromise<TResult>, Task>)state;
			tuple.Item1.InvokeCore(tuple.Item2);
		}, Tuple.Create(this, completingTask));
	}

	private void ProcessCompletedOuterTask(Task task)
	{
		_state = 1;
		switch (task.Status)
		{
		case TaskStatus.Canceled:
		case TaskStatus.Faulted:
			TrySetFromTask(task, _lookForOce);
			break;
		case TaskStatus.RanToCompletion:
		{
			Task<Task<TResult>> task2 = task as Task<Task<TResult>>;
			ProcessInnerTask((task2 != null) ? task2.Result : ((Task<Task>)task).Result);
			break;
		}
		}
	}

	private bool TrySetFromTask(Task task, bool lookForOce)
	{
		if (DebuggerSupport.LoggingOn)
		{
			DebuggerSupport.TraceOperationRelation(CausalityTraceLevel.Important, this, CausalityRelation.Join);
		}
		bool result = false;
		switch (task.Status)
		{
		case TaskStatus.Canceled:
			result = TrySetCanceled(task.CancellationToken, task.GetCancellationExceptionDispatchInfo());
			break;
		case TaskStatus.Faulted:
		{
			ReadOnlyCollection<ExceptionDispatchInfo> exceptionDispatchInfos = task.GetExceptionDispatchInfos();
			ExceptionDispatchInfo exceptionDispatchInfo;
			result = ((!lookForOce || exceptionDispatchInfos.Count <= 0 || (exceptionDispatchInfo = exceptionDispatchInfos[0]) == null || !(exceptionDispatchInfo.SourceException is OperationCanceledException ex)) ? TrySetException(exceptionDispatchInfos) : TrySetCanceled(ex.CancellationToken, exceptionDispatchInfo));
			break;
		}
		case TaskStatus.RanToCompletion:
		{
			Task<TResult> task2 = task as Task<TResult>;
			if (DebuggerSupport.LoggingOn)
			{
				DebuggerSupport.TraceOperationCompletion(CausalityTraceLevel.Required, this, AsyncStatus.Completed);
			}
			DebuggerSupport.RemoveFromActiveTasks(this);
			result = TrySetResult((task2 != null) ? task2.Result : default(TResult));
			break;
		}
		}
		return result;
	}

	private void ProcessInnerTask(Task task)
	{
		if (task == null)
		{
			TrySetCanceled(default(CancellationToken));
			_state = 2;
		}
		else if (task.IsCompleted)
		{
			TrySetFromTask(task, lookForOce: false);
			_state = 2;
		}
		else
		{
			task.AddCompletionAction(this);
		}
	}
}
