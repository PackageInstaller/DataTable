using System.Diagnostics;
using System.Runtime.ExceptionServices;
using System.Threading;
using System.Threading.Tasks;

namespace System.Runtime.CompilerServices;

internal struct AsyncMethodBuilderCore
{
	internal sealed class MoveNextRunner
	{
		private readonly ExecutionContext m_context;

		internal IAsyncStateMachine m_stateMachine;

		private static ContextCallback s_invokeMoveNext;

		internal MoveNextRunner(ExecutionContext context, IAsyncStateMachine stateMachine)
		{
			m_context = context;
			m_stateMachine = stateMachine;
		}

		internal void Run()
		{
			if (m_context != null)
			{
				try
				{
					ContextCallback callback = InvokeMoveNext;
					ExecutionContext.Run(m_context, callback, m_stateMachine, preserveSyncCtx: true);
					return;
				}
				finally
				{
					m_context.Dispose();
				}
			}
			m_stateMachine.MoveNext();
		}

		private static void InvokeMoveNext(object stateMachine)
		{
			((IAsyncStateMachine)stateMachine).MoveNext();
		}
	}

	private class ContinuationWrapper
	{
		internal readonly Action m_continuation;

		private readonly Action m_invokeAction;

		internal readonly Task m_innerTask;

		internal ContinuationWrapper(Action continuation, Action invokeAction, Task innerTask)
		{
			if (innerTask == null)
			{
				innerTask = TryGetContinuationTask(continuation);
			}
			m_continuation = continuation;
			m_innerTask = innerTask;
			m_invokeAction = invokeAction;
		}

		internal void Invoke()
		{
			m_invokeAction();
		}
	}

	internal IAsyncStateMachine m_stateMachine;

	internal Action m_defaultContextAction;

	public void SetStateMachine(IAsyncStateMachine stateMachine)
	{
		if (stateMachine == null)
		{
			throw new ArgumentNullException("stateMachine");
		}
		if (m_stateMachine != null)
		{
			throw new InvalidOperationException(Environment.GetResourceString("The builder was not properly initialized."));
		}
		m_stateMachine = stateMachine;
	}

	internal Action GetCompletionAction(Task taskForTracing, ref MoveNextRunner runnerToInitialize)
	{
		Debugger.NotifyOfCrossThreadDependency();
		ExecutionContext executionContext = ExecutionContext.FastCapture();
		MoveNextRunner moveNextRunner;
		Action defaultContextAction;
		if (executionContext != null && executionContext.IsPreAllocatedDefault)
		{
			defaultContextAction = m_defaultContextAction;
			if (defaultContextAction != null)
			{
				return defaultContextAction;
			}
			moveNextRunner = new MoveNextRunner(executionContext, m_stateMachine);
			defaultContextAction = moveNextRunner.Run;
			if (taskForTracing != null)
			{
				defaultContextAction = (m_defaultContextAction = OutputAsyncCausalityEvents(taskForTracing, defaultContextAction));
			}
			else
			{
				m_defaultContextAction = defaultContextAction;
			}
		}
		else
		{
			moveNextRunner = new MoveNextRunner(executionContext, m_stateMachine);
			defaultContextAction = moveNextRunner.Run;
			if (taskForTracing != null)
			{
				defaultContextAction = OutputAsyncCausalityEvents(taskForTracing, defaultContextAction);
			}
		}
		if (m_stateMachine == null)
		{
			runnerToInitialize = moveNextRunner;
		}
		return defaultContextAction;
	}

	private Action OutputAsyncCausalityEvents(Task innerTask, Action continuation)
	{
		return CreateContinuationWrapper(continuation, delegate
		{
			AsyncCausalityTracer.TraceSynchronousWorkStart(CausalityTraceLevel.Required, innerTask.Id, CausalitySynchronousWork.Execution);
			continuation();
			AsyncCausalityTracer.TraceSynchronousWorkCompletion(CausalityTraceLevel.Required, CausalitySynchronousWork.Execution);
		}, innerTask);
	}

	internal void PostBoxInitialization(IAsyncStateMachine stateMachine, MoveNextRunner runner, Task builtTask)
	{
		if (builtTask != null)
		{
			if (AsyncCausalityTracer.LoggingOn)
			{
				AsyncCausalityTracer.TraceOperationCreation(CausalityTraceLevel.Required, builtTask.Id, "Async: " + stateMachine.GetType().Name, 0uL);
			}
			if (Task.s_asyncDebuggingEnabled)
			{
				Task.AddToActiveTasks(builtTask);
			}
		}
		m_stateMachine = stateMachine;
		m_stateMachine.SetStateMachine(m_stateMachine);
		runner.m_stateMachine = m_stateMachine;
	}

	internal static void ThrowAsync(Exception exception, SynchronizationContext targetContext)
	{
		ExceptionDispatchInfo state = ExceptionDispatchInfo.Capture(exception);
		if (targetContext != null)
		{
			try
			{
				targetContext.Post(delegate(object obj)
				{
					((ExceptionDispatchInfo)obj).Throw();
				}, state);
				return;
			}
			catch (Exception ex)
			{
				state = ExceptionDispatchInfo.Capture(new AggregateException(exception, ex));
			}
		}
		ThreadPool.QueueUserWorkItem(delegate(object obj)
		{
			((ExceptionDispatchInfo)obj).Throw();
		}, state);
	}

	internal static Action CreateContinuationWrapper(Action continuation, Action invokeAction, Task innerTask = null)
	{
		return new ContinuationWrapper(continuation, invokeAction, innerTask).Invoke;
	}

	internal static Action TryGetStateMachineForDebugger(Action action)
	{
		object target = action.Target;
		if (target is MoveNextRunner moveNextRunner)
		{
			return moveNextRunner.m_stateMachine.MoveNext;
		}
		if (target is ContinuationWrapper continuationWrapper)
		{
			return TryGetStateMachineForDebugger(continuationWrapper.m_continuation);
		}
		return action;
	}

	internal static Task TryGetContinuationTask(Action action)
	{
		if (action != null && action.Target is ContinuationWrapper continuationWrapper)
		{
			return continuationWrapper.m_innerTask;
		}
		return null;
	}
}
