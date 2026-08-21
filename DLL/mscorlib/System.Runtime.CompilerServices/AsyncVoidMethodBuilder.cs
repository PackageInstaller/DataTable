using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;

namespace System.Runtime.CompilerServices;

public struct AsyncVoidMethodBuilder
{
	private SynchronizationContext m_synchronizationContext;

	private AsyncMethodBuilderCore m_coreState;

	private Task m_task;

	internal Task Task
	{
		get
		{
			if (m_task == null)
			{
				m_task = new Task();
			}
			return m_task;
		}
	}

	private object ObjectIdForDebugger => Task;

	public static AsyncVoidMethodBuilder Create()
	{
		SynchronizationContext currentNoFlow = SynchronizationContext.CurrentNoFlow;
		currentNoFlow?.OperationStarted();
		return new AsyncVoidMethodBuilder
		{
			m_synchronizationContext = currentNoFlow
		};
	}

	[DebuggerStepThrough]
	public void Start<TStateMachine>(ref TStateMachine stateMachine) where TStateMachine : IAsyncStateMachine
	{
		if (stateMachine == null)
		{
			throw new ArgumentNullException("stateMachine");
		}
		ExecutionContextSwitcher ecsw = default(ExecutionContextSwitcher);
		RuntimeHelpers.PrepareConstrainedRegions();
		try
		{
			ExecutionContext.EstablishCopyOnWriteScope(ref ecsw);
			stateMachine.MoveNext();
		}
		finally
		{
			ecsw.Undo();
		}
	}

	public void SetStateMachine(IAsyncStateMachine stateMachine)
	{
		m_coreState.SetStateMachine(stateMachine);
	}

	public void AwaitOnCompleted<TAwaiter, TStateMachine>(ref TAwaiter awaiter, ref TStateMachine stateMachine) where TAwaiter : INotifyCompletion where TStateMachine : IAsyncStateMachine
	{
		try
		{
			AsyncMethodBuilderCore.MoveNextRunner runnerToInitialize = null;
			Action completionAction = m_coreState.GetCompletionAction(AsyncCausalityTracer.LoggingOn ? Task : null, ref runnerToInitialize);
			if (m_coreState.m_stateMachine == null)
			{
				if (AsyncCausalityTracer.LoggingOn)
				{
					AsyncCausalityTracer.TraceOperationCreation(CausalityTraceLevel.Required, Task.Id, "Async: " + stateMachine.GetType().Name, 0uL);
				}
				m_coreState.PostBoxInitialization(stateMachine, runnerToInitialize, null);
			}
			awaiter.OnCompleted(completionAction);
		}
		catch (Exception exception)
		{
			AsyncMethodBuilderCore.ThrowAsync(exception, null);
		}
	}

	public void AwaitUnsafeOnCompleted<TAwaiter, TStateMachine>(ref TAwaiter awaiter, ref TStateMachine stateMachine) where TAwaiter : ICriticalNotifyCompletion where TStateMachine : IAsyncStateMachine
	{
		try
		{
			AsyncMethodBuilderCore.MoveNextRunner runnerToInitialize = null;
			Action completionAction = m_coreState.GetCompletionAction(AsyncCausalityTracer.LoggingOn ? Task : null, ref runnerToInitialize);
			if (m_coreState.m_stateMachine == null)
			{
				if (AsyncCausalityTracer.LoggingOn)
				{
					AsyncCausalityTracer.TraceOperationCreation(CausalityTraceLevel.Required, Task.Id, "Async: " + stateMachine.GetType().Name, 0uL);
				}
				m_coreState.PostBoxInitialization(stateMachine, runnerToInitialize, null);
			}
			awaiter.UnsafeOnCompleted(completionAction);
		}
		catch (Exception exception)
		{
			AsyncMethodBuilderCore.ThrowAsync(exception, null);
		}
	}

	public void SetResult()
	{
		if (AsyncCausalityTracer.LoggingOn)
		{
			AsyncCausalityTracer.TraceOperationCompletion(CausalityTraceLevel.Required, Task.Id, AsyncCausalityStatus.Completed);
		}
		if (m_synchronizationContext != null)
		{
			NotifySynchronizationContextOfCompletion();
		}
	}

	public void SetException(Exception exception)
	{
		if (exception == null)
		{
			throw new ArgumentNullException("exception");
		}
		if (AsyncCausalityTracer.LoggingOn)
		{
			AsyncCausalityTracer.TraceOperationCompletion(CausalityTraceLevel.Required, Task.Id, AsyncCausalityStatus.Error);
		}
		if (m_synchronizationContext != null)
		{
			try
			{
				AsyncMethodBuilderCore.ThrowAsync(exception, m_synchronizationContext);
				return;
			}
			finally
			{
				NotifySynchronizationContextOfCompletion();
			}
		}
		AsyncMethodBuilderCore.ThrowAsync(exception, null);
	}

	private void NotifySynchronizationContextOfCompletion()
	{
		try
		{
			m_synchronizationContext.OperationCompleted();
		}
		catch (Exception exception)
		{
			AsyncMethodBuilderCore.ThrowAsync(exception, null);
		}
	}
}
