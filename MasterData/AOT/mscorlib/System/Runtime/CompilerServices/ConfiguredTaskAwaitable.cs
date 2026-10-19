using System.Diagnostics;
using System.Threading.Tasks;

namespace System.Runtime.CompilerServices;

public readonly struct ConfiguredTaskAwaitable
{
	public readonly struct ConfiguredTaskAwaiter : ICriticalNotifyCompletion, INotifyCompletion
	{
		internal readonly Task m_task;

		internal readonly bool m_continueOnCapturedContext;

		public bool IsCompleted => m_task.IsCompleted;

		internal ConfiguredTaskAwaiter(Task task, bool continueOnCapturedContext)
		{
			m_task = task;
			m_continueOnCapturedContext = continueOnCapturedContext;
		}

		public void OnCompleted(Action continuation)
		{
			TaskAwaiter.OnCompletedInternal(m_task, continuation, m_continueOnCapturedContext, flowExecutionContext: true);
		}

		public void UnsafeOnCompleted(Action continuation)
		{
			TaskAwaiter.OnCompletedInternal(m_task, continuation, m_continueOnCapturedContext, flowExecutionContext: false);
		}

		[StackTraceHidden]
		public void GetResult()
		{
			TaskAwaiter.ValidateEnd(m_task);
		}
	}

	private readonly ConfiguredTaskAwaiter m_configuredTaskAwaiter;

	internal ConfiguredTaskAwaitable(Task task, bool continueOnCapturedContext)
	{
		m_configuredTaskAwaiter = new ConfiguredTaskAwaiter(task, continueOnCapturedContext);
	}

	public ConfiguredTaskAwaiter GetAwaiter()
	{
		return m_configuredTaskAwaiter;
	}
}
public readonly struct ConfiguredTaskAwaitable<TResult>
{
	public readonly struct ConfiguredTaskAwaiter : ICriticalNotifyCompletion, INotifyCompletion
	{
		private readonly Task<TResult> m_task;

		private readonly bool m_continueOnCapturedContext;

		public bool IsCompleted => m_task.IsCompleted;

		internal ConfiguredTaskAwaiter(Task<TResult> task, bool continueOnCapturedContext)
		{
			m_task = task;
			m_continueOnCapturedContext = continueOnCapturedContext;
		}

		public void OnCompleted(Action continuation)
		{
			TaskAwaiter.OnCompletedInternal(m_task, continuation, m_continueOnCapturedContext, flowExecutionContext: true);
		}

		public void UnsafeOnCompleted(Action continuation)
		{
			TaskAwaiter.OnCompletedInternal(m_task, continuation, m_continueOnCapturedContext, flowExecutionContext: false);
		}

		[StackTraceHidden]
		public TResult GetResult()
		{
			TaskAwaiter.ValidateEnd(m_task);
			return m_task.ResultOnSuccess;
		}
	}

	private readonly ConfiguredTaskAwaiter m_configuredTaskAwaiter;

	internal ConfiguredTaskAwaitable(Task<TResult> task, bool continueOnCapturedContext)
	{
		m_configuredTaskAwaiter = new ConfiguredTaskAwaiter(task, continueOnCapturedContext);
	}

	public ConfiguredTaskAwaiter GetAwaiter()
	{
		return m_configuredTaskAwaiter;
	}
}
