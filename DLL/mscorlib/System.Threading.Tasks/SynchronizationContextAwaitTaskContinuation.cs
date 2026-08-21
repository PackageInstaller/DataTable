using System.Runtime.CompilerServices;

namespace System.Threading.Tasks;

internal sealed class SynchronizationContextAwaitTaskContinuation : AwaitTaskContinuation
{
	private static readonly SendOrPostCallback s_postCallback = delegate(object state)
	{
		((Action)state)();
	};

	private static ContextCallback s_postActionCallback;

	private readonly SynchronizationContext m_syncContext;

	internal SynchronizationContextAwaitTaskContinuation(SynchronizationContext context, Action action, bool flowExecutionContext)
		: base(action, flowExecutionContext)
	{
		m_syncContext = context;
	}

	internal sealed override void Run(Task ignored, bool canInlineContinuationTask)
	{
		if (canInlineContinuationTask && m_syncContext == SynchronizationContext.Current)
		{
			RunCallback(AwaitTaskContinuation.GetInvokeActionCallback(), m_action, ref Task.t_currentTask);
		}
		else
		{
			RunCallback(GetPostActionCallback(), this, ref Task.t_currentTask);
		}
	}

	private static void PostAction(object state)
	{
		SynchronizationContextAwaitTaskContinuation synchronizationContextAwaitTaskContinuation = (SynchronizationContextAwaitTaskContinuation)state;
		synchronizationContextAwaitTaskContinuation.m_syncContext.Post(s_postCallback, synchronizationContextAwaitTaskContinuation.m_action);
	}

	[MethodImpl((MethodImplOptions)256)]
	private static ContextCallback GetPostActionCallback()
	{
		return PostAction;
	}
}
