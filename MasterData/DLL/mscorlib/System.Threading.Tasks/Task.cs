using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.ExceptionServices;
using Internal.Runtime.Augments;
using Internal.Threading.Tasks.Tracing;

namespace System.Threading.Tasks;

[DebuggerTypeProxy(typeof(SystemThreadingTasks_FutureDebugView<>))]
[DebuggerDisplay("Id = {Id}, Status = {Status}, Method = {DebuggerDisplayMethodDescription}, Result = {DebuggerDisplayResultDescription}")]
public class Task<TResult> : Task
{
	internal static class TaskWhenAnyCast
	{
		internal static readonly Func<Task<Task>, Task<TResult>> Value = (Task<Task> completed) => (Task<TResult>)completed.Result;
	}

	internal TResult m_result;

	private static TaskFactory<TResult> s_defaultFactory;

	private string DebuggerDisplayResultDescription
	{
		get
		{
			if (!base.IsCompletedSuccessfully)
			{
				return "{Not yet computed}";
			}
			TResult result = m_result;
			return result?.ToString() ?? "";
		}
	}

	private string DebuggerDisplayMethodDescription
	{
		get
		{
			Delegate action = m_action;
			if ((object)action == null)
			{
				return "{null}";
			}
			return "0x" + action.GetNativeFunctionPointer().ToString("x");
		}
	}

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	public TResult Result
	{
		get
		{
			if (!base.IsWaitNotificationEnabledOrNotRanToCompletion)
			{
				return m_result;
			}
			return GetResultCore(waitCompletionNotification: true);
		}
	}

	internal TResult ResultOnSuccess => m_result;

	public new static TaskFactory<TResult> Factory
	{
		get
		{
			if (s_defaultFactory == null)
			{
				Interlocked.CompareExchange(ref s_defaultFactory, new TaskFactory<TResult>(), null);
			}
			return s_defaultFactory;
		}
	}

	internal Task()
	{
	}

	internal Task(object state, TaskCreationOptions options)
		: base(state, options, promiseStyle: true)
	{
	}

	internal Task(TResult result)
		: base(canceled: false, TaskCreationOptions.None, default(CancellationToken))
	{
		m_result = result;
	}

	internal Task(bool canceled, TResult result, TaskCreationOptions creationOptions, CancellationToken ct)
		: base(canceled, creationOptions, ct)
	{
		if (!canceled)
		{
			m_result = result;
		}
	}

	public Task(Func<TResult> function)
		: this(function, (Task)null, default(CancellationToken), TaskCreationOptions.None, InternalTaskOptions.None, (TaskScheduler)null)
	{
	}

	public Task(Func<TResult> function, CancellationToken cancellationToken)
		: this(function, (Task)null, cancellationToken, TaskCreationOptions.None, InternalTaskOptions.None, (TaskScheduler)null)
	{
	}

	public Task(Func<TResult> function, TaskCreationOptions creationOptions)
		: this(function, Task.InternalCurrentIfAttached(creationOptions), default(CancellationToken), creationOptions, InternalTaskOptions.None, (TaskScheduler)null)
	{
	}

	public Task(Func<TResult> function, CancellationToken cancellationToken, TaskCreationOptions creationOptions)
		: this(function, Task.InternalCurrentIfAttached(creationOptions), cancellationToken, creationOptions, InternalTaskOptions.None, (TaskScheduler)null)
	{
	}

	public Task(Func<object, TResult> function, object state)
		: this((Delegate)function, state, (Task)null, default(CancellationToken), TaskCreationOptions.None, InternalTaskOptions.None, (TaskScheduler)null)
	{
	}

	public Task(Func<object, TResult> function, object state, CancellationToken cancellationToken)
		: this((Delegate)function, state, (Task)null, cancellationToken, TaskCreationOptions.None, InternalTaskOptions.None, (TaskScheduler)null)
	{
	}

	public Task(Func<object, TResult> function, object state, TaskCreationOptions creationOptions)
		: this((Delegate)function, state, Task.InternalCurrentIfAttached(creationOptions), default(CancellationToken), creationOptions, InternalTaskOptions.None, (TaskScheduler)null)
	{
	}

	public Task(Func<object, TResult> function, object state, CancellationToken cancellationToken, TaskCreationOptions creationOptions)
		: this((Delegate)function, state, Task.InternalCurrentIfAttached(creationOptions), cancellationToken, creationOptions, InternalTaskOptions.None, (TaskScheduler)null)
	{
	}

	internal Task(Func<TResult> valueSelector, Task parent, CancellationToken cancellationToken, TaskCreationOptions creationOptions, InternalTaskOptions internalOptions, TaskScheduler scheduler)
		: base(valueSelector, null, parent, cancellationToken, creationOptions, internalOptions, scheduler)
	{
	}

	internal Task(Delegate valueSelector, object state, Task parent, CancellationToken cancellationToken, TaskCreationOptions creationOptions, InternalTaskOptions internalOptions, TaskScheduler scheduler)
		: base(valueSelector, state, parent, cancellationToken, creationOptions, internalOptions, scheduler)
	{
	}

	internal static Task<TResult> StartNew(Task parent, Func<TResult> function, CancellationToken cancellationToken, TaskCreationOptions creationOptions, InternalTaskOptions internalOptions, TaskScheduler scheduler)
	{
		if (function == null)
		{
			throw new ArgumentNullException("function");
		}
		if (scheduler == null)
		{
			throw new ArgumentNullException("scheduler");
		}
		Task<TResult> task = new Task<TResult>(function, parent, cancellationToken, creationOptions, internalOptions | InternalTaskOptions.QueuedByRuntime, scheduler);
		task.ScheduleAndStart(needsProtection: false);
		return task;
	}

	internal static Task<TResult> StartNew(Task parent, Func<object, TResult> function, object state, CancellationToken cancellationToken, TaskCreationOptions creationOptions, InternalTaskOptions internalOptions, TaskScheduler scheduler)
	{
		if (function == null)
		{
			throw new ArgumentNullException("function");
		}
		if (scheduler == null)
		{
			throw new ArgumentNullException("scheduler");
		}
		Task<TResult> task = new Task<TResult>(function, state, parent, cancellationToken, creationOptions, internalOptions | InternalTaskOptions.QueuedByRuntime, scheduler);
		task.ScheduleAndStart(needsProtection: false);
		return task;
	}

	internal bool TrySetResult(TResult result)
	{
		if (base.IsCompleted)
		{
			return false;
		}
		if (AtomicStateUpdate(67108864, 90177536))
		{
			m_result = result;
			Interlocked.Exchange(ref m_stateFlags, m_stateFlags | 0x1000000);
			m_contingentProperties?.SetCompleted();
			FinishStageThree();
			return true;
		}
		return false;
	}

	internal void DangerousSetResult(TResult result)
	{
		if (m_parent != null)
		{
			TrySetResult(result);
			return;
		}
		m_result = result;
		m_stateFlags |= 16777216;
	}

	internal TResult GetResultCore(bool waitCompletionNotification)
	{
		if (!base.IsCompleted)
		{
			InternalWait(-1, default(CancellationToken));
		}
		if (waitCompletionNotification)
		{
			NotifyDebuggerOfWaitCompletionIfNecessary();
		}
		if (!base.IsCompletedSuccessfully)
		{
			ThrowIfExceptional(includeTaskCanceledExceptions: true);
		}
		return m_result;
	}

	internal override void InnerInvoke()
	{
		if (m_action is Func<TResult> func)
		{
			m_result = func();
		}
		else if (m_action is Func<object, TResult> func2)
		{
			m_result = func2(m_stateObject);
		}
	}

	public new TaskAwaiter<TResult> GetAwaiter()
	{
		return new TaskAwaiter<TResult>(this);
	}

	public new ConfiguredTaskAwaitable<TResult> ConfigureAwait(bool continueOnCapturedContext)
	{
		return new ConfiguredTaskAwaitable<TResult>(this, continueOnCapturedContext);
	}

	public Task ContinueWith(Action<Task<TResult>> continuationAction)
	{
		return ContinueWith(continuationAction, TaskScheduler.Current, default(CancellationToken), TaskContinuationOptions.None);
	}

	public Task ContinueWith(Action<Task<TResult>> continuationAction, CancellationToken cancellationToken)
	{
		return ContinueWith(continuationAction, TaskScheduler.Current, cancellationToken, TaskContinuationOptions.None);
	}

	public Task ContinueWith(Action<Task<TResult>> continuationAction, TaskScheduler scheduler)
	{
		return ContinueWith(continuationAction, scheduler, default(CancellationToken), TaskContinuationOptions.None);
	}

	public Task ContinueWith(Action<Task<TResult>> continuationAction, TaskContinuationOptions continuationOptions)
	{
		return ContinueWith(continuationAction, TaskScheduler.Current, default(CancellationToken), continuationOptions);
	}

	public Task ContinueWith(Action<Task<TResult>> continuationAction, CancellationToken cancellationToken, TaskContinuationOptions continuationOptions, TaskScheduler scheduler)
	{
		return ContinueWith(continuationAction, scheduler, cancellationToken, continuationOptions);
	}

	internal Task ContinueWith(Action<Task<TResult>> continuationAction, TaskScheduler scheduler, CancellationToken cancellationToken, TaskContinuationOptions continuationOptions)
	{
		if (continuationAction == null)
		{
			throw new ArgumentNullException("continuationAction");
		}
		if (scheduler == null)
		{
			throw new ArgumentNullException("scheduler");
		}
		Task.CreationOptionsFromContinuationOptions(continuationOptions, out var creationOptions, out var internalOptions);
		Task task = new ContinuationTaskFromResultTask<TResult>(this, continuationAction, null, creationOptions, internalOptions);
		ContinueWithCore(task, scheduler, cancellationToken, continuationOptions);
		return task;
	}

	public Task ContinueWith(Action<Task<TResult>, object> continuationAction, object state)
	{
		return ContinueWith(continuationAction, state, TaskScheduler.Current, default(CancellationToken), TaskContinuationOptions.None);
	}

	public Task ContinueWith(Action<Task<TResult>, object> continuationAction, object state, CancellationToken cancellationToken)
	{
		return ContinueWith(continuationAction, state, TaskScheduler.Current, cancellationToken, TaskContinuationOptions.None);
	}

	public Task ContinueWith(Action<Task<TResult>, object> continuationAction, object state, TaskScheduler scheduler)
	{
		return ContinueWith(continuationAction, state, scheduler, default(CancellationToken), TaskContinuationOptions.None);
	}

	public Task ContinueWith(Action<Task<TResult>, object> continuationAction, object state, TaskContinuationOptions continuationOptions)
	{
		return ContinueWith(continuationAction, state, TaskScheduler.Current, default(CancellationToken), continuationOptions);
	}

	public Task ContinueWith(Action<Task<TResult>, object> continuationAction, object state, CancellationToken cancellationToken, TaskContinuationOptions continuationOptions, TaskScheduler scheduler)
	{
		return ContinueWith(continuationAction, state, scheduler, cancellationToken, continuationOptions);
	}

	internal Task ContinueWith(Action<Task<TResult>, object> continuationAction, object state, TaskScheduler scheduler, CancellationToken cancellationToken, TaskContinuationOptions continuationOptions)
	{
		if (continuationAction == null)
		{
			throw new ArgumentNullException("continuationAction");
		}
		if (scheduler == null)
		{
			throw new ArgumentNullException("scheduler");
		}
		Task.CreationOptionsFromContinuationOptions(continuationOptions, out var creationOptions, out var internalOptions);
		Task task = new ContinuationTaskFromResultTask<TResult>(this, continuationAction, state, creationOptions, internalOptions);
		ContinueWithCore(task, scheduler, cancellationToken, continuationOptions);
		return task;
	}

	public Task<TNewResult> ContinueWith<TNewResult>(Func<Task<TResult>, TNewResult> continuationFunction)
	{
		return ContinueWith(continuationFunction, TaskScheduler.Current, default(CancellationToken), TaskContinuationOptions.None);
	}

	public Task<TNewResult> ContinueWith<TNewResult>(Func<Task<TResult>, TNewResult> continuationFunction, CancellationToken cancellationToken)
	{
		return ContinueWith(continuationFunction, TaskScheduler.Current, cancellationToken, TaskContinuationOptions.None);
	}

	public Task<TNewResult> ContinueWith<TNewResult>(Func<Task<TResult>, TNewResult> continuationFunction, TaskScheduler scheduler)
	{
		return ContinueWith(continuationFunction, scheduler, default(CancellationToken), TaskContinuationOptions.None);
	}

	public Task<TNewResult> ContinueWith<TNewResult>(Func<Task<TResult>, TNewResult> continuationFunction, TaskContinuationOptions continuationOptions)
	{
		return ContinueWith(continuationFunction, TaskScheduler.Current, default(CancellationToken), continuationOptions);
	}

	public Task<TNewResult> ContinueWith<TNewResult>(Func<Task<TResult>, TNewResult> continuationFunction, CancellationToken cancellationToken, TaskContinuationOptions continuationOptions, TaskScheduler scheduler)
	{
		return ContinueWith(continuationFunction, scheduler, cancellationToken, continuationOptions);
	}

	internal Task<TNewResult> ContinueWith<TNewResult>(Func<Task<TResult>, TNewResult> continuationFunction, TaskScheduler scheduler, CancellationToken cancellationToken, TaskContinuationOptions continuationOptions)
	{
		if (continuationFunction == null)
		{
			throw new ArgumentNullException("continuationFunction");
		}
		if (scheduler == null)
		{
			throw new ArgumentNullException("scheduler");
		}
		Task.CreationOptionsFromContinuationOptions(continuationOptions, out var creationOptions, out var internalOptions);
		Task<TNewResult> task = new ContinuationResultTaskFromResultTask<TResult, TNewResult>(this, continuationFunction, null, creationOptions, internalOptions);
		ContinueWithCore(task, scheduler, cancellationToken, continuationOptions);
		return task;
	}

	public Task<TNewResult> ContinueWith<TNewResult>(Func<Task<TResult>, object, TNewResult> continuationFunction, object state)
	{
		return ContinueWith(continuationFunction, state, TaskScheduler.Current, default(CancellationToken), TaskContinuationOptions.None);
	}

	public Task<TNewResult> ContinueWith<TNewResult>(Func<Task<TResult>, object, TNewResult> continuationFunction, object state, CancellationToken cancellationToken)
	{
		return ContinueWith(continuationFunction, state, TaskScheduler.Current, cancellationToken, TaskContinuationOptions.None);
	}

	public Task<TNewResult> ContinueWith<TNewResult>(Func<Task<TResult>, object, TNewResult> continuationFunction, object state, TaskScheduler scheduler)
	{
		return ContinueWith(continuationFunction, state, scheduler, default(CancellationToken), TaskContinuationOptions.None);
	}

	public Task<TNewResult> ContinueWith<TNewResult>(Func<Task<TResult>, object, TNewResult> continuationFunction, object state, TaskContinuationOptions continuationOptions)
	{
		return ContinueWith(continuationFunction, state, TaskScheduler.Current, default(CancellationToken), continuationOptions);
	}

	public Task<TNewResult> ContinueWith<TNewResult>(Func<Task<TResult>, object, TNewResult> continuationFunction, object state, CancellationToken cancellationToken, TaskContinuationOptions continuationOptions, TaskScheduler scheduler)
	{
		return ContinueWith(continuationFunction, state, scheduler, cancellationToken, continuationOptions);
	}

	internal Task<TNewResult> ContinueWith<TNewResult>(Func<Task<TResult>, object, TNewResult> continuationFunction, object state, TaskScheduler scheduler, CancellationToken cancellationToken, TaskContinuationOptions continuationOptions)
	{
		if (continuationFunction == null)
		{
			throw new ArgumentNullException("continuationFunction");
		}
		if (scheduler == null)
		{
			throw new ArgumentNullException("scheduler");
		}
		Task.CreationOptionsFromContinuationOptions(continuationOptions, out var creationOptions, out var internalOptions);
		Task<TNewResult> task = new ContinuationResultTaskFromResultTask<TResult, TNewResult>(this, continuationFunction, state, creationOptions, internalOptions);
		ContinueWithCore(task, scheduler, cancellationToken, continuationOptions);
		return task;
	}
}
[DebuggerDisplay("Id = {Id}, Status = {Status}, Method = {DebuggerDisplayMethodDescription}")]
[DebuggerTypeProxy(typeof(SystemThreadingTasks_TaskDebugView))]
public class Task : IThreadPoolWorkItem, IAsyncResult, IDisposable
{
	internal class ContingentProperties
	{
		internal ExecutionContext m_capturedContext;

		internal volatile ManualResetEventSlim m_completionEvent;

		internal volatile TaskExceptionHolder m_exceptionsHolder;

		internal CancellationToken m_cancellationToken;

		internal object m_cancellationRegistration;

		internal volatile int m_internalCancellationRequested;

		internal volatile int m_completionCountdown = 1;

		internal volatile LowLevelListWithIList<Task> m_exceptionalChildren;

		internal void SetCompleted()
		{
			m_completionEvent?.Set();
		}

		internal void UnregisterCancellationCallback()
		{
			if (m_cancellationRegistration != null)
			{
				try
				{
					((CancellationTokenRegistration)m_cancellationRegistration).Dispose();
				}
				catch (ObjectDisposedException)
				{
				}
				m_cancellationRegistration = null;
			}
		}
	}

	private sealed class SetOnInvokeMres : ManualResetEventSlim, ITaskCompletionAction
	{
		public bool InvokeMayRunArbitraryCode => false;

		internal SetOnInvokeMres()
			: base(initialState: false, 0)
		{
		}

		public void Invoke(Task completingTask)
		{
			Set();
		}
	}

	private sealed class SetOnCountdownMres : ManualResetEventSlim, ITaskCompletionAction
	{
		private int _count;

		public bool InvokeMayRunArbitraryCode => false;

		internal SetOnCountdownMres(int count)
		{
			_count = count;
		}

		public void Invoke(Task completingTask)
		{
			if (Interlocked.Decrement(ref _count) == 0)
			{
				Set();
			}
		}
	}

	private sealed class DelayPromise : Task<VoidTaskResult>
	{
		internal readonly CancellationToken Token;

		internal CancellationTokenRegistration Registration;

		internal Timer Timer;

		internal DelayPromise(CancellationToken token)
		{
			Token = token;
			if (DebuggerSupport.LoggingOn)
			{
				DebuggerSupport.TraceOperationCreation(CausalityTraceLevel.Required, this, "Task.Delay", 0uL);
			}
			DebuggerSupport.AddToActiveTasks(this);
		}

		internal void Complete()
		{
			bool flag;
			if (Token.IsCancellationRequested)
			{
				flag = TrySetCanceled(Token);
			}
			else
			{
				if (DebuggerSupport.LoggingOn)
				{
					DebuggerSupport.TraceOperationCompletion(CausalityTraceLevel.Required, this, AsyncStatus.Completed);
				}
				DebuggerSupport.RemoveFromActiveTasks(this);
				flag = TrySetResult(default(VoidTaskResult));
			}
			if (flag)
			{
				if (Timer != null)
				{
					Timer.Dispose();
				}
				Registration.Dispose();
			}
		}
	}

	private sealed class WhenAllPromise : Task<VoidTaskResult>, ITaskCompletionAction
	{
		private readonly Task[] m_tasks;

		private int m_count;

		internal override bool ShouldNotifyDebuggerOfWaitCompletion
		{
			get
			{
				if (base.ShouldNotifyDebuggerOfWaitCompletion)
				{
					return AnyTaskRequiresNotifyDebuggerOfWaitCompletion(m_tasks);
				}
				return false;
			}
		}

		public bool InvokeMayRunArbitraryCode => true;

		internal WhenAllPromise(Task[] tasks)
		{
			if (DebuggerSupport.LoggingOn)
			{
				DebuggerSupport.TraceOperationCreation(CausalityTraceLevel.Required, this, "Task.WhenAll", 0uL);
			}
			DebuggerSupport.AddToActiveTasks(this);
			m_tasks = tasks;
			m_count = tasks.Length;
			foreach (Task task in tasks)
			{
				if (task.IsCompleted)
				{
					Invoke(task);
				}
				else
				{
					task.AddCompletionAction(this);
				}
			}
		}

		public void Invoke(Task ignored)
		{
			if (DebuggerSupport.LoggingOn)
			{
				DebuggerSupport.TraceOperationRelation(CausalityTraceLevel.Important, this, CausalityRelation.Join);
			}
			if (Interlocked.Decrement(ref m_count) != 0)
			{
				return;
			}
			LowLevelListWithIList<ExceptionDispatchInfo> lowLevelListWithIList = null;
			Task task = null;
			for (int i = 0; i < m_tasks.Length; i++)
			{
				Task task2 = m_tasks[i];
				if (task2.IsFaulted)
				{
					if (lowLevelListWithIList == null)
					{
						lowLevelListWithIList = new LowLevelListWithIList<ExceptionDispatchInfo>();
					}
					lowLevelListWithIList.AddRange(task2.GetExceptionDispatchInfos());
				}
				else if (task2.IsCanceled && task == null)
				{
					task = task2;
				}
				if (task2.IsWaitNotificationEnabled)
				{
					SetNotificationForWaitCompletion(enabled: true);
				}
				else
				{
					m_tasks[i] = null;
				}
			}
			if (lowLevelListWithIList != null)
			{
				TrySetException(lowLevelListWithIList);
				return;
			}
			if (task != null)
			{
				TrySetCanceled(task.CancellationToken, task.GetCancellationExceptionDispatchInfo());
				return;
			}
			if (DebuggerSupport.LoggingOn)
			{
				DebuggerSupport.TraceOperationCompletion(CausalityTraceLevel.Required, this, AsyncStatus.Completed);
			}
			DebuggerSupport.RemoveFromActiveTasks(this);
			TrySetResult(default(VoidTaskResult));
		}
	}

	private sealed class WhenAllPromise<T> : Task<T[]>, ITaskCompletionAction
	{
		private readonly Task<T>[] m_tasks;

		private int m_count;

		internal override bool ShouldNotifyDebuggerOfWaitCompletion
		{
			get
			{
				if (base.ShouldNotifyDebuggerOfWaitCompletion)
				{
					Task[] tasks = m_tasks;
					return AnyTaskRequiresNotifyDebuggerOfWaitCompletion(tasks);
				}
				return false;
			}
		}

		public bool InvokeMayRunArbitraryCode => true;

		internal WhenAllPromise(Task<T>[] tasks)
		{
			m_tasks = tasks;
			m_count = tasks.Length;
			if (DebuggerSupport.LoggingOn)
			{
				DebuggerSupport.TraceOperationCreation(CausalityTraceLevel.Required, this, "Task.WhenAll", 0uL);
			}
			DebuggerSupport.AddToActiveTasks(this);
			foreach (Task<T> task in tasks)
			{
				if (task.IsCompleted)
				{
					Invoke(task);
				}
				else
				{
					task.AddCompletionAction(this);
				}
			}
		}

		public void Invoke(Task ignored)
		{
			if (DebuggerSupport.LoggingOn)
			{
				DebuggerSupport.TraceOperationRelation(CausalityTraceLevel.Important, this, CausalityRelation.Join);
			}
			if (Interlocked.Decrement(ref m_count) != 0)
			{
				return;
			}
			T[] array = new T[m_tasks.Length];
			LowLevelListWithIList<ExceptionDispatchInfo> lowLevelListWithIList = null;
			Task task = null;
			for (int i = 0; i < m_tasks.Length; i++)
			{
				Task<T> task2 = m_tasks[i];
				if (task2.IsFaulted)
				{
					if (lowLevelListWithIList == null)
					{
						lowLevelListWithIList = new LowLevelListWithIList<ExceptionDispatchInfo>();
					}
					lowLevelListWithIList.AddRange(task2.GetExceptionDispatchInfos());
				}
				else if (task2.IsCanceled)
				{
					if (task == null)
					{
						task = task2;
					}
				}
				else
				{
					array[i] = task2.GetResultCore(waitCompletionNotification: false);
				}
				if (task2.IsWaitNotificationEnabled)
				{
					SetNotificationForWaitCompletion(enabled: true);
				}
				else
				{
					m_tasks[i] = null;
				}
			}
			if (lowLevelListWithIList != null)
			{
				TrySetException(lowLevelListWithIList);
				return;
			}
			if (task != null)
			{
				TrySetCanceled(task.CancellationToken, task.GetCancellationExceptionDispatchInfo());
				return;
			}
			if (DebuggerSupport.LoggingOn)
			{
				DebuggerSupport.TraceOperationCompletion(CausalityTraceLevel.Required, this, AsyncStatus.Completed);
			}
			DebuggerSupport.RemoveFromActiveTasks(this);
			TrySetResult(array);
		}
	}

	internal static int s_taskIdCounter;

	private volatile int m_taskId;

	internal Delegate m_action;

	internal object m_stateObject;

	internal TaskScheduler m_taskScheduler;

	internal readonly Task m_parent;

	internal volatile int m_stateFlags;

	private const int OptionsMask = 65535;

	internal const int TASK_STATE_STARTED = 65536;

	internal const int TASK_STATE_DELEGATE_INVOKED = 131072;

	internal const int TASK_STATE_DISPOSED = 262144;

	internal const int TASK_STATE_EXCEPTIONOBSERVEDBYPARENT = 524288;

	internal const int TASK_STATE_CANCELLATIONACKNOWLEDGED = 1048576;

	internal const int TASK_STATE_FAULTED = 2097152;

	internal const int TASK_STATE_CANCELED = 4194304;

	internal const int TASK_STATE_WAITING_ON_CHILDREN = 8388608;

	internal const int TASK_STATE_RAN_TO_COMPLETION = 16777216;

	internal const int TASK_STATE_WAITINGFORACTIVATION = 33554432;

	internal const int TASK_STATE_COMPLETION_RESERVED = 67108864;

	internal const int TASK_STATE_THREAD_WAS_ABORTED = 134217728;

	internal const int TASK_STATE_WAIT_COMPLETION_NOTIFICATION = 268435456;

	private const int TASK_STATE_COMPLETED_MASK = 23068672;

	private const int CANCELLATION_REQUESTED = 1;

	private volatile object m_continuationObject;

	private static readonly object s_taskCompletionSentinel = new object();

	internal static bool s_asyncDebuggingEnabled;

	internal volatile ContingentProperties m_contingentProperties;

	private static readonly Action<object> s_taskCancelCallback = TaskCancelCallback;

	[ThreadStatic]
	internal static Task t_currentTask;

	[ThreadStatic]
	private static StackGuard t_stackGuard;

	private static readonly Func<ContingentProperties> s_createContingentProperties = () => new ContingentProperties();

	private static readonly Predicate<Task> s_IsExceptionObservedByParentPredicate = (Task t) => t.IsExceptionObservedByParent;

	private static ContextCallback s_ecCallback;

	private static readonly Predicate<object> s_IsTaskContinuationNullPredicate = (object tc) => tc == null;

	private static readonly Dictionary<int, Task> s_currentActiveTasks = new Dictionary<int, Task>();

	private static readonly object s_activeTasksLock = new object();

	private Task ParentForDebugger => m_parent;

	private int StateFlagsForDebugger => m_stateFlags;

	private string DebuggerDisplayMethodDescription
	{
		get
		{
			Delegate action = m_action;
			if ((object)action == null)
			{
				return "{null}";
			}
			return "0x" + action.GetNativeFunctionPointer().ToString("x");
		}
	}

	internal TaskCreationOptions Options => OptionsMethod(m_stateFlags);

	internal bool IsWaitNotificationEnabledOrNotRanToCompletion
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return (m_stateFlags & 0x11000000) != 16777216;
		}
	}

	internal virtual bool ShouldNotifyDebuggerOfWaitCompletion => IsWaitNotificationEnabled;

	internal bool IsWaitNotificationEnabled => (m_stateFlags & 0x10000000) != 0;

	public int Id
	{
		get
		{
			if (m_taskId == 0)
			{
				int num = 0;
				do
				{
					num = Interlocked.Increment(ref s_taskIdCounter);
				}
				while (num == 0);
				Interlocked.CompareExchange(ref m_taskId, num, 0);
			}
			return m_taskId;
		}
	}

	public static int? CurrentId => InternalCurrent?.Id;

	internal static Task InternalCurrent => t_currentTask;

	internal static StackGuard CurrentStackGuard
	{
		get
		{
			StackGuard stackGuard = t_stackGuard;
			if (stackGuard == null)
			{
				stackGuard = (t_stackGuard = new StackGuard());
			}
			return stackGuard;
		}
	}

	public AggregateException Exception
	{
		get
		{
			AggregateException result = null;
			if (IsFaulted)
			{
				result = GetExceptions(includeTaskCanceledExceptions: false);
			}
			return result;
		}
	}

	public TaskStatus Status
	{
		get
		{
			int stateFlags = m_stateFlags;
			if ((stateFlags & 0x200000) != 0)
			{
				return TaskStatus.Faulted;
			}
			if ((stateFlags & 0x400000) != 0)
			{
				return TaskStatus.Canceled;
			}
			if ((stateFlags & 0x1000000) != 0)
			{
				return TaskStatus.RanToCompletion;
			}
			if ((stateFlags & 0x800000) != 0)
			{
				return TaskStatus.WaitingForChildrenToComplete;
			}
			if ((stateFlags & 0x20000) != 0)
			{
				return TaskStatus.Running;
			}
			if ((stateFlags & 0x10000) != 0)
			{
				return TaskStatus.WaitingToRun;
			}
			if ((stateFlags & 0x2000000) != 0)
			{
				return TaskStatus.WaitingForActivation;
			}
			return TaskStatus.Created;
		}
	}

	public bool IsCanceled => (m_stateFlags & 0x600000) == 4194304;

	internal bool IsCancellationRequested
	{
		get
		{
			ContingentProperties contingentProperties = m_contingentProperties;
			if (contingentProperties != null)
			{
				if (contingentProperties.m_internalCancellationRequested != 1)
				{
					return contingentProperties.m_cancellationToken.IsCancellationRequested;
				}
				return true;
			}
			return false;
		}
	}

	internal CancellationToken CancellationToken => m_contingentProperties?.m_cancellationToken ?? default(CancellationToken);

	internal bool IsCancellationAcknowledged => (m_stateFlags & 0x100000) != 0;

	public bool IsCompleted => IsCompletedMethod(m_stateFlags);

	public bool IsCompletedSuccessfully => (m_stateFlags & 0x1600000) == 16777216;

	public TaskCreationOptions CreationOptions => Options & (TaskCreationOptions)(-65281);

	WaitHandle IAsyncResult.AsyncWaitHandle
	{
		get
		{
			if ((m_stateFlags & 0x40000) != 0)
			{
				throw new ObjectDisposedException(null, "The task has been disposed.");
			}
			return CompletedEvent.WaitHandle;
		}
	}

	public object AsyncState => m_stateObject;

	bool IAsyncResult.CompletedSynchronously => false;

	internal TaskScheduler ExecutingTaskScheduler => m_taskScheduler;

	public static TaskFactory Factory { get; } = new TaskFactory();

	public static Task CompletedTask { get; } = new Task(canceled: false, (TaskCreationOptions)16384, default(CancellationToken));

	internal ManualResetEventSlim CompletedEvent
	{
		get
		{
			ContingentProperties contingentProperties = EnsureContingentPropertiesInitialized(needsProtection: true);
			if (contingentProperties.m_completionEvent == null)
			{
				bool isCompleted = IsCompleted;
				ManualResetEventSlim manualResetEventSlim = new ManualResetEventSlim(isCompleted);
				if (Interlocked.CompareExchange(ref contingentProperties.m_completionEvent, manualResetEventSlim, null) != null)
				{
					manualResetEventSlim.Dispose();
				}
				else if (!isCompleted && IsCompleted)
				{
					manualResetEventSlim.Set();
				}
			}
			return contingentProperties.m_completionEvent;
		}
	}

	internal bool ExceptionRecorded
	{
		get
		{
			ContingentProperties contingentProperties = m_contingentProperties;
			if (contingentProperties != null && contingentProperties.m_exceptionsHolder != null)
			{
				return contingentProperties.m_exceptionsHolder.ContainsFaultList;
			}
			return false;
		}
	}

	public bool IsFaulted => (m_stateFlags & 0x200000) != 0;

	internal ExecutionContext CapturedContext
	{
		get
		{
			ContingentProperties contingentProperties = m_contingentProperties;
			if (contingentProperties != null && contingentProperties.m_capturedContext != null)
			{
				return contingentProperties.m_capturedContext;
			}
			return ExecutionContext.Default;
		}
		set
		{
			if (value != ExecutionContext.Default)
			{
				EnsureContingentPropertiesInitialized(needsProtection: false).m_capturedContext = value;
			}
		}
	}

	internal bool IsExceptionObservedByParent => (m_stateFlags & 0x80000) != 0;

	internal bool IsDelegateInvoked => (m_stateFlags & 0x20000) != 0;

	internal Task(bool canceled, TaskCreationOptions creationOptions, CancellationToken ct)
	{
		if (canceled)
		{
			m_stateFlags = (int)((TaskCreationOptions)0x500000 | creationOptions);
			ContingentProperties contingentProperties = (m_contingentProperties = new ContingentProperties());
			contingentProperties.m_cancellationToken = ct;
			contingentProperties.m_internalCancellationRequested = 1;
		}
		else
		{
			m_stateFlags = (int)((TaskCreationOptions)0x1000000 | creationOptions);
		}
	}

	internal Task()
	{
		m_stateFlags = 33555456;
	}

	internal Task(object state, TaskCreationOptions creationOptions, bool promiseStyle)
	{
		if ((creationOptions & ~(TaskCreationOptions.AttachedToParent | TaskCreationOptions.RunContinuationsAsynchronously)) != TaskCreationOptions.None)
		{
			throw new ArgumentOutOfRangeException("creationOptions");
		}
		if ((creationOptions & TaskCreationOptions.AttachedToParent) != TaskCreationOptions.None)
		{
			m_parent = InternalCurrent;
		}
		TaskConstructorCore(null, state, default(CancellationToken), creationOptions, InternalTaskOptions.PromiseTask, null);
	}

	public Task(Action action)
		: this(action, null, null, default(CancellationToken), TaskCreationOptions.None, InternalTaskOptions.None, null)
	{
	}

	public Task(Action action, CancellationToken cancellationToken)
		: this(action, null, null, cancellationToken, TaskCreationOptions.None, InternalTaskOptions.None, null)
	{
	}

	public Task(Action action, TaskCreationOptions creationOptions)
		: this(action, null, InternalCurrentIfAttached(creationOptions), default(CancellationToken), creationOptions, InternalTaskOptions.None, null)
	{
	}

	public Task(Action action, CancellationToken cancellationToken, TaskCreationOptions creationOptions)
		: this(action, null, InternalCurrentIfAttached(creationOptions), cancellationToken, creationOptions, InternalTaskOptions.None, null)
	{
	}

	public Task(Action<object> action, object state)
		: this(action, state, null, default(CancellationToken), TaskCreationOptions.None, InternalTaskOptions.None, null)
	{
	}

	public Task(Action<object> action, object state, CancellationToken cancellationToken)
		: this(action, state, null, cancellationToken, TaskCreationOptions.None, InternalTaskOptions.None, null)
	{
	}

	public Task(Action<object> action, object state, TaskCreationOptions creationOptions)
		: this(action, state, InternalCurrentIfAttached(creationOptions), default(CancellationToken), creationOptions, InternalTaskOptions.None, null)
	{
	}

	public Task(Action<object> action, object state, CancellationToken cancellationToken, TaskCreationOptions creationOptions)
		: this(action, state, InternalCurrentIfAttached(creationOptions), cancellationToken, creationOptions, InternalTaskOptions.None, null)
	{
	}

	internal Task(Delegate action, object state, Task parent, CancellationToken cancellationToken, TaskCreationOptions creationOptions, InternalTaskOptions internalOptions, TaskScheduler scheduler)
	{
		if ((object)action == null)
		{
			throw new ArgumentNullException("action");
		}
		if ((creationOptions & TaskCreationOptions.AttachedToParent) != TaskCreationOptions.None)
		{
			m_parent = parent;
		}
		TaskConstructorCore(action, state, cancellationToken, creationOptions, internalOptions, scheduler);
	}

	internal void TaskConstructorCore(Delegate action, object state, CancellationToken cancellationToken, TaskCreationOptions creationOptions, InternalTaskOptions internalOptions, TaskScheduler scheduler)
	{
		m_action = action;
		m_stateObject = state;
		m_taskScheduler = scheduler;
		if ((creationOptions & ~(TaskCreationOptions.PreferFairness | TaskCreationOptions.LongRunning | TaskCreationOptions.AttachedToParent | TaskCreationOptions.DenyChildAttach | TaskCreationOptions.HideScheduler | TaskCreationOptions.RunContinuationsAsynchronously)) != TaskCreationOptions.None)
		{
			throw new ArgumentOutOfRangeException("creationOptions");
		}
		int num = (int)creationOptions | (int)internalOptions;
		if ((object)m_action == null || (internalOptions & InternalTaskOptions.ContinuationTask) != InternalTaskOptions.None)
		{
			num |= 0x2000000;
		}
		m_stateFlags = num;
		if (m_parent != null && (creationOptions & TaskCreationOptions.AttachedToParent) != TaskCreationOptions.None && (m_parent.CreationOptions & TaskCreationOptions.DenyChildAttach) == 0)
		{
			m_parent.AddNewChild();
		}
		if (cancellationToken.CanBeCanceled)
		{
			AssignCancellationToken(cancellationToken, null, null);
		}
		CapturedContext = ExecutionContext.Capture();
	}

	private void AssignCancellationToken(CancellationToken cancellationToken, Task antecedent, TaskContinuation continuation)
	{
		ContingentProperties contingentProperties = EnsureContingentPropertiesInitialized(needsProtection: false);
		contingentProperties.m_cancellationToken = cancellationToken;
		try
		{
			if ((Options & (TaskCreationOptions)0x3400) == 0)
			{
				if (cancellationToken.IsCancellationRequested)
				{
					InternalCancel(bCancelNonExecutingOnly: false);
					return;
				}
				CancellationTokenRegistration cancellationTokenRegistration = ((antecedent != null) ? cancellationToken.InternalRegisterWithoutEC(s_taskCancelCallback, new Tuple<Task, Task, TaskContinuation>(this, antecedent, continuation)) : cancellationToken.InternalRegisterWithoutEC(s_taskCancelCallback, this));
				contingentProperties.m_cancellationRegistration = cancellationTokenRegistration;
			}
		}
		catch
		{
			if (m_parent != null && (Options & TaskCreationOptions.AttachedToParent) != TaskCreationOptions.None && (m_parent.Options & TaskCreationOptions.DenyChildAttach) == 0)
			{
				m_parent.DisregardChild();
			}
			throw;
		}
	}

	private static void TaskCancelCallback(object o)
	{
		Task task = o as Task;
		if (task == null && o is Tuple<Task, Task, TaskContinuation> tuple)
		{
			task = tuple.Item1;
			Task item = tuple.Item2;
			TaskContinuation item2 = tuple.Item3;
			item.RemoveContinuation(item2);
		}
		task.InternalCancel(bCancelNonExecutingOnly: false);
	}

	internal bool TrySetCanceled(CancellationToken tokenToRecord)
	{
		return TrySetCanceled(tokenToRecord, null);
	}

	internal bool TrySetCanceled(CancellationToken tokenToRecord, object cancellationException)
	{
		bool result = false;
		if (AtomicStateUpdate(67108864, 90177536))
		{
			RecordInternalCancellationRequest(tokenToRecord, cancellationException);
			CancellationCleanupLogic();
			result = true;
		}
		return result;
	}

	internal bool TrySetException(object exceptionObject)
	{
		bool result = false;
		EnsureContingentPropertiesInitialized(needsProtection: true);
		if (AtomicStateUpdate(67108864, 90177536))
		{
			AddException(exceptionObject);
			Finish(bUserDelegateExecuted: false);
			result = true;
		}
		return result;
	}

	internal static TaskCreationOptions OptionsMethod(int flags)
	{
		return (TaskCreationOptions)(flags & 0xFFFF);
	}

	internal bool AtomicStateUpdate(int newBits, int illegalBits)
	{
		SpinWait spinWait = default(SpinWait);
		while (true)
		{
			int stateFlags = m_stateFlags;
			if ((stateFlags & illegalBits) != 0)
			{
				return false;
			}
			if (Interlocked.CompareExchange(ref m_stateFlags, stateFlags | newBits, stateFlags) == stateFlags)
			{
				break;
			}
			spinWait.SpinOnce();
		}
		return true;
	}

	internal bool AtomicStateUpdate(int newBits, int illegalBits, ref int oldFlags)
	{
		SpinWait spinWait = default(SpinWait);
		while (true)
		{
			oldFlags = m_stateFlags;
			if ((oldFlags & illegalBits) != 0)
			{
				return false;
			}
			if (Interlocked.CompareExchange(ref m_stateFlags, oldFlags | newBits, oldFlags) == oldFlags)
			{
				break;
			}
			spinWait.SpinOnce();
		}
		return true;
	}

	internal void SetNotificationForWaitCompletion(bool enabled)
	{
		if (enabled)
		{
			AtomicStateUpdate(268435456, 90177536);
			return;
		}
		SpinWait spinWait = default(SpinWait);
		while (true)
		{
			int stateFlags = m_stateFlags;
			int value = stateFlags & -268435457;
			if (Interlocked.CompareExchange(ref m_stateFlags, value, stateFlags) != stateFlags)
			{
				spinWait.SpinOnce();
				continue;
			}
			break;
		}
	}

	internal bool NotifyDebuggerOfWaitCompletionIfNecessary()
	{
		if (IsWaitNotificationEnabled && ShouldNotifyDebuggerOfWaitCompletion)
		{
			NotifyDebuggerOfWaitCompletion();
			return true;
		}
		return false;
	}

	internal static bool AnyTaskRequiresNotifyDebuggerOfWaitCompletion(Task[] tasks)
	{
		foreach (Task task in tasks)
		{
			if (task != null && task.IsWaitNotificationEnabled && task.ShouldNotifyDebuggerOfWaitCompletion)
			{
				return true;
			}
		}
		return false;
	}

	[MethodImpl((MethodImplOptions)72)]
	private void NotifyDebuggerOfWaitCompletion()
	{
		SetNotificationForWaitCompletion(enabled: false);
	}

	internal bool MarkStarted()
	{
		return AtomicStateUpdate(65536, 4259840);
	}

	internal void AddNewChild()
	{
		ContingentProperties contingentProperties = EnsureContingentPropertiesInitialized(needsProtection: true);
		if (contingentProperties.m_completionCountdown == 1)
		{
			contingentProperties.m_completionCountdown++;
		}
		else
		{
			Interlocked.Increment(ref contingentProperties.m_completionCountdown);
		}
	}

	internal void DisregardChild()
	{
		Interlocked.Decrement(ref EnsureContingentPropertiesInitialized(needsProtection: true).m_completionCountdown);
	}

	public void Start()
	{
		Start(TaskScheduler.Current);
	}

	public void Start(TaskScheduler scheduler)
	{
		int stateFlags = m_stateFlags;
		if (IsCompletedMethod(stateFlags))
		{
			throw new InvalidOperationException("Start may not be called on a task that has completed.");
		}
		if (scheduler == null)
		{
			throw new ArgumentNullException("scheduler");
		}
		TaskCreationOptions num = OptionsMethod(stateFlags);
		if ((num & (TaskCreationOptions)0x400) != TaskCreationOptions.None)
		{
			throw new InvalidOperationException("Start may not be called on a promise-style task.");
		}
		if ((num & (TaskCreationOptions)0x200) != TaskCreationOptions.None)
		{
			throw new InvalidOperationException("Start may not be called on a continuation task.");
		}
		if (Interlocked.CompareExchange(ref m_taskScheduler, scheduler, null) != null)
		{
			throw new InvalidOperationException("Start may not be called on a task that was already started.");
		}
		ScheduleAndStart(needsProtection: true);
	}

	public void RunSynchronously()
	{
		InternalRunSynchronously(TaskScheduler.Current, waitForCompletion: true);
	}

	public void RunSynchronously(TaskScheduler scheduler)
	{
		if (scheduler == null)
		{
			throw new ArgumentNullException("scheduler");
		}
		InternalRunSynchronously(scheduler, waitForCompletion: true);
	}

	internal void InternalRunSynchronously(TaskScheduler scheduler, bool waitForCompletion)
	{
		int stateFlags = m_stateFlags;
		TaskCreationOptions num = OptionsMethod(stateFlags);
		if ((num & (TaskCreationOptions)0x200) != TaskCreationOptions.None)
		{
			throw new InvalidOperationException("RunSynchronously may not be called on a continuation task.");
		}
		if ((num & (TaskCreationOptions)0x400) != TaskCreationOptions.None)
		{
			throw new InvalidOperationException("RunSynchronously may not be called on a task not bound to a delegate, such as the task returned from an asynchronous method.");
		}
		if (IsCompletedMethod(stateFlags))
		{
			throw new InvalidOperationException("RunSynchronously may not be called on a task that has already completed.");
		}
		if (Interlocked.CompareExchange(ref m_taskScheduler, scheduler, null) != null)
		{
			throw new InvalidOperationException("RunSynchronously may not be called on a task that was already started.");
		}
		if (MarkStarted())
		{
			bool flag = false;
			try
			{
				if (!scheduler.TryRunInline(this, taskWasPreviouslyQueued: false))
				{
					scheduler.QueueTask(this);
					flag = true;
				}
				if (waitForCompletion && !IsCompleted)
				{
					SpinThenBlockingWait(-1, default(CancellationToken));
				}
				return;
			}
			catch (Exception innerException)
			{
				if (!flag)
				{
					TaskSchedulerException ex = new TaskSchedulerException(innerException);
					AddException(ex);
					Finish(bUserDelegateExecuted: false);
					m_contingentProperties.m_exceptionsHolder.MarkAsHandled(calledFromFinalizer: false);
					throw ex;
				}
				throw;
			}
		}
		throw new InvalidOperationException("RunSynchronously may not be called on a task that has already completed.");
	}

	internal static Task InternalStartNew(Task creatingTask, Delegate action, object state, CancellationToken cancellationToken, TaskScheduler scheduler, TaskCreationOptions options, InternalTaskOptions internalOptions)
	{
		if (scheduler == null)
		{
			throw new ArgumentNullException("scheduler");
		}
		Task task = new Task(action, state, creatingTask, cancellationToken, options, internalOptions | InternalTaskOptions.QueuedByRuntime, scheduler);
		task.ScheduleAndStart(needsProtection: false);
		return task;
	}

	internal static Task InternalCurrentIfAttached(TaskCreationOptions creationOptions)
	{
		if ((creationOptions & TaskCreationOptions.AttachedToParent) == 0)
		{
			return null;
		}
		return InternalCurrent;
	}

	internal ContingentProperties EnsureContingentPropertiesInitialized(bool needsProtection)
	{
		ContingentProperties contingentProperties = m_contingentProperties;
		if (contingentProperties == null)
		{
			return EnsureContingentPropertiesInitializedCore(needsProtection);
		}
		return contingentProperties;
	}

	private ContingentProperties EnsureContingentPropertiesInitializedCore(bool needsProtection)
	{
		if (needsProtection)
		{
			return LazyInitializer.EnsureInitialized(ref m_contingentProperties, s_createContingentProperties);
		}
		return m_contingentProperties = new ContingentProperties();
	}

	private static bool IsCompletedMethod(int flags)
	{
		return (flags & 0x1600000) != 0;
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
		if (disposing)
		{
			if ((Options & (TaskCreationOptions)0x4000) != TaskCreationOptions.None)
			{
				return;
			}
			if (!IsCompleted)
			{
				throw new InvalidOperationException("A task may only be disposed if it is in a completion state (RanToCompletion, Faulted or Canceled).");
			}
			ContingentProperties contingentProperties = Volatile.Read(ref m_contingentProperties);
			if (contingentProperties != null)
			{
				ManualResetEventSlim completionEvent = contingentProperties.m_completionEvent;
				if (completionEvent != null)
				{
					contingentProperties.m_completionEvent = null;
					if (!completionEvent.IsSet)
					{
						completionEvent.Set();
					}
					completionEvent.Dispose();
				}
			}
		}
		m_stateFlags |= 262144;
	}

	internal void ScheduleAndStart(bool needsProtection)
	{
		if (needsProtection)
		{
			if (!MarkStarted())
			{
				return;
			}
		}
		else
		{
			m_stateFlags |= 65536;
		}
		DebuggerSupport.AddToActiveTasks(this);
		if (DebuggerSupport.LoggingOn && (Options & (TaskCreationOptions)0x200) == 0)
		{
			DebuggerSupport.TraceOperationCreation(CausalityTraceLevel.Required, this, "Task: " + m_action, 0uL);
		}
		try
		{
			m_taskScheduler.QueueTask(this);
		}
		catch (Exception innerException)
		{
			TaskSchedulerException ex = new TaskSchedulerException(innerException);
			AddException(ex);
			Finish(bUserDelegateExecuted: false);
			if ((Options & (TaskCreationOptions)0x200) == 0)
			{
				m_contingentProperties.m_exceptionsHolder.MarkAsHandled(calledFromFinalizer: false);
			}
			throw ex;
		}
	}

	internal void AddException(object exceptionObject)
	{
		AddException(exceptionObject, representsCancellation: false);
	}

	internal void AddException(object exceptionObject, bool representsCancellation)
	{
		ContingentProperties contingentProperties = EnsureContingentPropertiesInitialized(needsProtection: true);
		if (contingentProperties.m_exceptionsHolder == null)
		{
			TaskExceptionHolder taskExceptionHolder = new TaskExceptionHolder(this);
			if (Interlocked.CompareExchange(ref contingentProperties.m_exceptionsHolder, taskExceptionHolder, null) != null)
			{
				taskExceptionHolder.MarkAsHandled(calledFromFinalizer: false);
			}
		}
		lock (contingentProperties)
		{
			contingentProperties.m_exceptionsHolder.Add(exceptionObject, representsCancellation);
		}
	}

	private AggregateException GetExceptions(bool includeTaskCanceledExceptions)
	{
		Exception ex = null;
		if (includeTaskCanceledExceptions && IsCanceled)
		{
			ex = new TaskCanceledException(this);
		}
		if (ExceptionRecorded)
		{
			return m_contingentProperties.m_exceptionsHolder.CreateExceptionObject(calledFromFinalizer: false, ex);
		}
		if (ex != null)
		{
			return new AggregateException(ex);
		}
		return null;
	}

	internal ReadOnlyCollection<ExceptionDispatchInfo> GetExceptionDispatchInfos()
	{
		if (!IsFaulted || !ExceptionRecorded)
		{
			return new ReadOnlyCollection<ExceptionDispatchInfo>(Array.Empty<ExceptionDispatchInfo>());
		}
		return m_contingentProperties.m_exceptionsHolder.GetExceptionDispatchInfos();
	}

	internal ExceptionDispatchInfo GetCancellationExceptionDispatchInfo()
	{
		ContingentProperties contingentProperties = m_contingentProperties;
		if (contingentProperties == null)
		{
			return null;
		}
		return contingentProperties.m_exceptionsHolder?.GetCancellationExceptionDispatchInfo();
	}

	internal void ThrowIfExceptional(bool includeTaskCanceledExceptions)
	{
		Exception exceptions = GetExceptions(includeTaskCanceledExceptions);
		if (exceptions != null)
		{
			UpdateExceptionObservedStatus();
			throw exceptions;
		}
	}

	internal void UpdateExceptionObservedStatus()
	{
		if (m_parent != null && (Options & TaskCreationOptions.AttachedToParent) != TaskCreationOptions.None && (m_parent.CreationOptions & TaskCreationOptions.DenyChildAttach) == 0 && InternalCurrent == m_parent)
		{
			m_stateFlags |= 524288;
		}
	}

	internal void Finish(bool bUserDelegateExecuted)
	{
		if (!bUserDelegateExecuted)
		{
			FinishStageTwo();
			return;
		}
		ContingentProperties contingentProperties = m_contingentProperties;
		if (contingentProperties == null || contingentProperties.m_completionCountdown == 1 || Interlocked.Decrement(ref contingentProperties.m_completionCountdown) == 0)
		{
			FinishStageTwo();
		}
		else
		{
			AtomicStateUpdate(8388608, 23068672);
		}
		LowLevelListWithIList<Task> lowLevelListWithIList = ((contingentProperties != null) ? contingentProperties.m_exceptionalChildren : null);
		if (lowLevelListWithIList == null)
		{
			return;
		}
		lock (lowLevelListWithIList)
		{
			lowLevelListWithIList.RemoveAll(s_IsExceptionObservedByParentPredicate);
		}
	}

	internal void FinishStageTwo()
	{
		AddExceptionsFromChildren();
		int num;
		if (ExceptionRecorded)
		{
			num = 2097152;
			if (DebuggerSupport.LoggingOn)
			{
				DebuggerSupport.TraceOperationCompletion(CausalityTraceLevel.Required, this, AsyncStatus.Error);
			}
			DebuggerSupport.RemoveFromActiveTasks(this);
		}
		else if (IsCancellationRequested && IsCancellationAcknowledged)
		{
			num = 4194304;
			if (DebuggerSupport.LoggingOn)
			{
				DebuggerSupport.TraceOperationCompletion(CausalityTraceLevel.Required, this, AsyncStatus.Canceled);
			}
			DebuggerSupport.RemoveFromActiveTasks(this);
		}
		else
		{
			num = 16777216;
			if (DebuggerSupport.LoggingOn)
			{
				DebuggerSupport.TraceOperationCompletion(CausalityTraceLevel.Required, this, AsyncStatus.Completed);
			}
			DebuggerSupport.RemoveFromActiveTasks(this);
		}
		Interlocked.Exchange(ref m_stateFlags, m_stateFlags | num);
		ContingentProperties contingentProperties = m_contingentProperties;
		if (contingentProperties != null)
		{
			contingentProperties.SetCompleted();
			contingentProperties.UnregisterCancellationCallback();
		}
		FinishStageThree();
	}

	internal void FinishStageThree()
	{
		m_action = null;
		if (m_parent != null && (m_parent.CreationOptions & TaskCreationOptions.DenyChildAttach) == 0 && (m_stateFlags & 0xFFFF & 4) != 0)
		{
			m_parent.ProcessChildCompletion(this);
		}
		FinishContinuations();
	}

	internal void ProcessChildCompletion(Task childTask)
	{
		ContingentProperties contingentProperties = m_contingentProperties;
		if (childTask.IsFaulted && !childTask.IsExceptionObservedByParent)
		{
			if (contingentProperties.m_exceptionalChildren == null)
			{
				Interlocked.CompareExchange(ref contingentProperties.m_exceptionalChildren, new LowLevelListWithIList<Task>(), null);
			}
			LowLevelListWithIList<Task> exceptionalChildren = contingentProperties.m_exceptionalChildren;
			if (exceptionalChildren != null)
			{
				lock (exceptionalChildren)
				{
					exceptionalChildren.Add(childTask);
				}
			}
		}
		if (Interlocked.Decrement(ref contingentProperties.m_completionCountdown) == 0)
		{
			FinishStageTwo();
		}
	}

	internal void AddExceptionsFromChildren()
	{
		ContingentProperties contingentProperties = m_contingentProperties;
		LowLevelListWithIList<Task> lowLevelListWithIList = ((contingentProperties != null) ? contingentProperties.m_exceptionalChildren : null);
		if (lowLevelListWithIList == null)
		{
			return;
		}
		lock (lowLevelListWithIList)
		{
			foreach (Task item in (IEnumerable<Task>)lowLevelListWithIList)
			{
				if (item.IsFaulted && !item.IsExceptionObservedByParent)
				{
					TaskExceptionHolder exceptionsHolder = item.m_contingentProperties.m_exceptionsHolder;
					AddException(exceptionsHolder.CreateExceptionObject(calledFromFinalizer: false, null));
				}
			}
		}
		contingentProperties.m_exceptionalChildren = null;
	}

	private void Execute()
	{
		try
		{
			InnerInvoke();
		}
		catch (Exception unhandledException)
		{
			HandleException(unhandledException);
		}
	}

	void IThreadPoolWorkItem.ExecuteWorkItem()
	{
		ExecuteEntry(bPreventDoubleExecution: false);
	}

	internal bool ExecuteEntry(bool bPreventDoubleExecution)
	{
		if (bPreventDoubleExecution)
		{
			int oldFlags = 0;
			if (!AtomicStateUpdate(131072, 23199744, ref oldFlags) && (oldFlags & 0x400000) == 0)
			{
				return false;
			}
		}
		else
		{
			m_stateFlags |= 131072;
		}
		if (!IsCancellationRequested && !IsCanceled)
		{
			ExecuteWithThreadLocal(ref t_currentTask);
		}
		else if (!IsCanceled && (Interlocked.Exchange(ref m_stateFlags, m_stateFlags | 0x400000) & 0x400000) == 0)
		{
			CancellationCleanupLogic();
		}
		return true;
	}

	private static void ExecutionContextCallback(object obj)
	{
		(obj as Task).Execute();
	}

	internal virtual void InnerInvoke()
	{
		if (m_action is Action action)
		{
			action();
		}
		else if (m_action is Action<object> action2)
		{
			action2(m_stateObject);
		}
	}

	private void HandleException(Exception unhandledException)
	{
		if (unhandledException is OperationCanceledException ex && IsCancellationRequested && m_contingentProperties.m_cancellationToken == ex.CancellationToken)
		{
			SetCancellationAcknowledged();
			AddException(ex, representsCancellation: true);
		}
		else
		{
			AddException(unhandledException);
		}
	}

	public TaskAwaiter GetAwaiter()
	{
		return new TaskAwaiter(this);
	}

	public ConfiguredTaskAwaitable ConfigureAwait(bool continueOnCapturedContext)
	{
		return new ConfiguredTaskAwaitable(this, continueOnCapturedContext);
	}

	internal void SetContinuationForAwait(Action continuationAction, bool continueOnCapturedContext, bool flowExecutionContext)
	{
		TaskContinuation taskContinuation = null;
		if (continueOnCapturedContext)
		{
			SynchronizationContext current = SynchronizationContext.Current;
			if (current != null && current.GetType() != typeof(SynchronizationContext))
			{
				taskContinuation = new SynchronizationContextAwaitTaskContinuation(current, continuationAction, flowExecutionContext);
			}
			else
			{
				TaskScheduler internalCurrent = TaskScheduler.InternalCurrent;
				if (internalCurrent != null && internalCurrent != TaskScheduler.Default)
				{
					taskContinuation = new TaskSchedulerAwaitTaskContinuation(internalCurrent, continuationAction, flowExecutionContext);
				}
			}
		}
		if (taskContinuation != null)
		{
			if (!AddTaskContinuation(taskContinuation, addBeforeOthers: false))
			{
				taskContinuation.Run(this, bCanInlineContinuationTask: false);
			}
		}
		else if (!AddTaskContinuation(continuationAction, addBeforeOthers: false))
		{
			AwaitTaskContinuation.UnsafeScheduleAction(continuationAction);
		}
	}

	public static YieldAwaitable Yield()
	{
		return default(YieldAwaitable);
	}

	public void Wait()
	{
		Wait(-1, default(CancellationToken));
	}

	public bool Wait(TimeSpan timeout)
	{
		long num = (long)timeout.TotalMilliseconds;
		if (num < -1 || num > int.MaxValue)
		{
			throw new ArgumentOutOfRangeException("timeout");
		}
		return Wait((int)num, default(CancellationToken));
	}

	public void Wait(CancellationToken cancellationToken)
	{
		Wait(-1, cancellationToken);
	}

	public bool Wait(int millisecondsTimeout)
	{
		return Wait(millisecondsTimeout, default(CancellationToken));
	}

	public bool Wait(int millisecondsTimeout, CancellationToken cancellationToken)
	{
		if (millisecondsTimeout < -1)
		{
			throw new ArgumentOutOfRangeException("millisecondsTimeout");
		}
		if (!IsWaitNotificationEnabledOrNotRanToCompletion)
		{
			return true;
		}
		if (!InternalWait(millisecondsTimeout, cancellationToken))
		{
			return false;
		}
		if (IsWaitNotificationEnabledOrNotRanToCompletion)
		{
			NotifyDebuggerOfWaitCompletionIfNecessary();
			if (IsCanceled)
			{
				cancellationToken.ThrowIfCancellationRequested();
			}
			ThrowIfExceptional(includeTaskCanceledExceptions: true);
		}
		return true;
	}

	private bool WrappedTryRunInline()
	{
		if (m_taskScheduler == null)
		{
			return false;
		}
		try
		{
			return m_taskScheduler.TryRunInline(this, taskWasPreviouslyQueued: true);
		}
		catch (Exception innerException)
		{
			throw new TaskSchedulerException(innerException);
		}
	}

	[MethodImpl((MethodImplOptions)64)]
	internal bool InternalWait(int millisecondsTimeout, CancellationToken cancellationToken)
	{
		if (TaskTrace.Enabled)
		{
			Task internalCurrent = InternalCurrent;
			TaskTrace.TaskWaitBegin_Synchronous(internalCurrent?.m_taskScheduler.Id ?? TaskScheduler.Default.Id, internalCurrent?.Id ?? 0, Id);
		}
		bool flag = IsCompleted;
		if (!flag)
		{
			flag = (millisecondsTimeout == -1 && !cancellationToken.CanBeCanceled && WrappedTryRunInline() && IsCompleted) || SpinThenBlockingWait(millisecondsTimeout, cancellationToken);
		}
		if (TaskTrace.Enabled)
		{
			Task internalCurrent2 = InternalCurrent;
			if (internalCurrent2 != null)
			{
				TaskTrace.TaskWaitEnd(internalCurrent2.m_taskScheduler.Id, internalCurrent2.Id, Id);
			}
			else
			{
				TaskTrace.TaskWaitEnd(TaskScheduler.Default.Id, 0, Id);
			}
		}
		return flag;
	}

	private bool SpinThenBlockingWait(int millisecondsTimeout, CancellationToken cancellationToken)
	{
		bool flag = millisecondsTimeout == -1;
		uint num = ((!flag) ? ((uint)Environment.TickCount) : 0u);
		bool flag2 = SpinWait(millisecondsTimeout);
		if (!flag2)
		{
			SetOnInvokeMres setOnInvokeMres = new SetOnInvokeMres();
			try
			{
				AddCompletionAction(setOnInvokeMres, addBeforeOthers: true);
				if (flag)
				{
					flag2 = setOnInvokeMres.Wait(-1, cancellationToken);
				}
				else
				{
					uint num2 = (uint)Environment.TickCount - num;
					if (num2 < millisecondsTimeout)
					{
						flag2 = setOnInvokeMres.Wait((int)(millisecondsTimeout - num2), cancellationToken);
					}
				}
			}
			finally
			{
				if (!IsCompleted)
				{
					RemoveContinuation(setOnInvokeMres);
				}
			}
		}
		return flag2;
	}

	private bool SpinWait(int millisecondsTimeout)
	{
		if (IsCompleted)
		{
			return true;
		}
		if (millisecondsTimeout == 0)
		{
			return false;
		}
		int spinCountforSpinBeforeWait = System.Threading.SpinWait.SpinCountforSpinBeforeWait;
		SpinWait spinWait = default(SpinWait);
		while (spinWait.Count < spinCountforSpinBeforeWait)
		{
			spinWait.SpinOnce(-1);
			if (IsCompleted)
			{
				return true;
			}
		}
		return false;
	}

	internal bool InternalCancel(bool bCancelNonExecutingOnly)
	{
		bool flag = false;
		bool flag2 = false;
		TaskSchedulerException ex = null;
		if ((m_stateFlags & 0x10000) != 0)
		{
			TaskScheduler taskScheduler = m_taskScheduler;
			try
			{
				flag = taskScheduler?.TryDequeue(this) ?? false;
			}
			catch (Exception innerException)
			{
				ex = new TaskSchedulerException(innerException);
			}
			bool flag3 = taskScheduler?.RequiresAtomicStartTransition ?? false;
			if (!flag & bCancelNonExecutingOnly & flag3)
			{
				flag2 = AtomicStateUpdate(4194304, 4325376);
			}
		}
		if (!bCancelNonExecutingOnly | flag | flag2)
		{
			RecordInternalCancellationRequest();
			if (flag)
			{
				flag2 = AtomicStateUpdate(4194304, 4325376);
			}
			else if (!flag2 && (m_stateFlags & 0x10000) == 0)
			{
				flag2 = AtomicStateUpdate(4194304, 23265280);
			}
			if (flag2)
			{
				CancellationCleanupLogic();
			}
		}
		if (ex != null)
		{
			throw ex;
		}
		return flag2;
	}

	internal void RecordInternalCancellationRequest()
	{
		EnsureContingentPropertiesInitialized(needsProtection: true).m_internalCancellationRequested = 1;
	}

	internal void RecordInternalCancellationRequest(CancellationToken tokenToRecord)
	{
		RecordInternalCancellationRequest();
		if (tokenToRecord != default(CancellationToken))
		{
			m_contingentProperties.m_cancellationToken = tokenToRecord;
		}
	}

	internal void RecordInternalCancellationRequest(CancellationToken tokenToRecord, object cancellationException)
	{
		RecordInternalCancellationRequest(tokenToRecord);
		if (cancellationException != null)
		{
			AddException(cancellationException, representsCancellation: true);
		}
	}

	internal void CancellationCleanupLogic()
	{
		Interlocked.Exchange(ref m_stateFlags, m_stateFlags | 0x400000);
		ContingentProperties contingentProperties = m_contingentProperties;
		if (contingentProperties != null)
		{
			contingentProperties.SetCompleted();
			contingentProperties.UnregisterCancellationCallback();
		}
		if (DebuggerSupport.LoggingOn)
		{
			DebuggerSupport.TraceOperationCompletion(CausalityTraceLevel.Required, this, AsyncStatus.Canceled);
		}
		DebuggerSupport.RemoveFromActiveTasks(this);
		FinishStageThree();
	}

	private void SetCancellationAcknowledged()
	{
		m_stateFlags |= 1048576;
	}

	internal void FinishContinuations()
	{
		object obj = Interlocked.Exchange(ref m_continuationObject, s_taskCompletionSentinel);
		if (obj == null)
		{
			return;
		}
		if (DebuggerSupport.LoggingOn)
		{
			DebuggerSupport.TraceSynchronousWorkStart(CausalityTraceLevel.Required, this, CausalitySynchronousWork.CompletionNotification);
		}
		bool flag = (m_stateFlags & 0x8000000) == 0 && (m_stateFlags & 0x40) == 0;
		if (obj is Action action)
		{
			AwaitTaskContinuation.RunOrScheduleAction(action, flag, ref t_currentTask);
			LogFinishCompletionNotification();
			return;
		}
		if (obj is ITaskCompletionAction taskCompletionAction)
		{
			if (flag || !taskCompletionAction.InvokeMayRunArbitraryCode)
			{
				taskCompletionAction.Invoke(this);
			}
			else
			{
				ThreadPool.UnsafeQueueCustomWorkItem(new CompletionActionInvoker(taskCompletionAction, this), forceGlobal: false);
			}
			LogFinishCompletionNotification();
			return;
		}
		if (obj is TaskContinuation taskContinuation)
		{
			taskContinuation.Run(this, flag);
			LogFinishCompletionNotification();
			return;
		}
		if (!(obj is LowLevelListWithIList<object> lowLevelListWithIList))
		{
			LogFinishCompletionNotification();
			return;
		}
		lock (lowLevelListWithIList)
		{
		}
		int count = lowLevelListWithIList.Count;
		for (int i = 0; i < count; i++)
		{
			if (lowLevelListWithIList[i] is StandardTaskContinuation standardTaskContinuation && (standardTaskContinuation.m_options & TaskContinuationOptions.ExecuteSynchronously) == 0)
			{
				lowLevelListWithIList[i] = null;
				standardTaskContinuation.Run(this, flag);
			}
		}
		for (int j = 0; j < count; j++)
		{
			object obj2 = lowLevelListWithIList[j];
			if (obj2 == null)
			{
				continue;
			}
			lowLevelListWithIList[j] = null;
			if (obj2 is Action action2)
			{
				AwaitTaskContinuation.RunOrScheduleAction(action2, flag, ref t_currentTask);
				continue;
			}
			if (obj2 is TaskContinuation taskContinuation2)
			{
				taskContinuation2.Run(this, flag);
				continue;
			}
			ITaskCompletionAction taskCompletionAction2 = (ITaskCompletionAction)obj2;
			if (flag || !taskCompletionAction2.InvokeMayRunArbitraryCode)
			{
				taskCompletionAction2.Invoke(this);
			}
			else
			{
				ThreadPool.UnsafeQueueCustomWorkItem(new CompletionActionInvoker(taskCompletionAction2, this), forceGlobal: false);
			}
		}
		LogFinishCompletionNotification();
	}

	[MethodImpl((MethodImplOptions)256)]
	private void LogFinishCompletionNotification()
	{
		if (DebuggerSupport.LoggingOn)
		{
			DebuggerSupport.TraceSynchronousWorkCompletion(CausalityTraceLevel.Required, CausalitySynchronousWork.CompletionNotification);
		}
	}

	public Task ContinueWith(Action<Task> continuationAction)
	{
		return ContinueWith(continuationAction, TaskScheduler.Current, default(CancellationToken), TaskContinuationOptions.None);
	}

	public Task ContinueWith(Action<Task> continuationAction, CancellationToken cancellationToken)
	{
		return ContinueWith(continuationAction, TaskScheduler.Current, cancellationToken, TaskContinuationOptions.None);
	}

	public Task ContinueWith(Action<Task> continuationAction, TaskScheduler scheduler)
	{
		return ContinueWith(continuationAction, scheduler, default(CancellationToken), TaskContinuationOptions.None);
	}

	public Task ContinueWith(Action<Task> continuationAction, TaskContinuationOptions continuationOptions)
	{
		return ContinueWith(continuationAction, TaskScheduler.Current, default(CancellationToken), continuationOptions);
	}

	public Task ContinueWith(Action<Task> continuationAction, CancellationToken cancellationToken, TaskContinuationOptions continuationOptions, TaskScheduler scheduler)
	{
		return ContinueWith(continuationAction, scheduler, cancellationToken, continuationOptions);
	}

	private Task ContinueWith(Action<Task> continuationAction, TaskScheduler scheduler, CancellationToken cancellationToken, TaskContinuationOptions continuationOptions)
	{
		if (continuationAction == null)
		{
			throw new ArgumentNullException("continuationAction");
		}
		if (scheduler == null)
		{
			throw new ArgumentNullException("scheduler");
		}
		CreationOptionsFromContinuationOptions(continuationOptions, out var creationOptions, out var internalOptions);
		Task task = new ContinuationTaskFromTask(this, continuationAction, null, creationOptions, internalOptions);
		ContinueWithCore(task, scheduler, cancellationToken, continuationOptions);
		return task;
	}

	public Task ContinueWith(Action<Task, object> continuationAction, object state)
	{
		return ContinueWith(continuationAction, state, TaskScheduler.Current, default(CancellationToken), TaskContinuationOptions.None);
	}

	public Task ContinueWith(Action<Task, object> continuationAction, object state, CancellationToken cancellationToken)
	{
		return ContinueWith(continuationAction, state, TaskScheduler.Current, cancellationToken, TaskContinuationOptions.None);
	}

	public Task ContinueWith(Action<Task, object> continuationAction, object state, TaskScheduler scheduler)
	{
		return ContinueWith(continuationAction, state, scheduler, default(CancellationToken), TaskContinuationOptions.None);
	}

	public Task ContinueWith(Action<Task, object> continuationAction, object state, TaskContinuationOptions continuationOptions)
	{
		return ContinueWith(continuationAction, state, TaskScheduler.Current, default(CancellationToken), continuationOptions);
	}

	public Task ContinueWith(Action<Task, object> continuationAction, object state, CancellationToken cancellationToken, TaskContinuationOptions continuationOptions, TaskScheduler scheduler)
	{
		return ContinueWith(continuationAction, state, scheduler, cancellationToken, continuationOptions);
	}

	private Task ContinueWith(Action<Task, object> continuationAction, object state, TaskScheduler scheduler, CancellationToken cancellationToken, TaskContinuationOptions continuationOptions)
	{
		if (continuationAction == null)
		{
			throw new ArgumentNullException("continuationAction");
		}
		if (scheduler == null)
		{
			throw new ArgumentNullException("scheduler");
		}
		CreationOptionsFromContinuationOptions(continuationOptions, out var creationOptions, out var internalOptions);
		Task task = new ContinuationTaskFromTask(this, continuationAction, state, creationOptions, internalOptions);
		ContinueWithCore(task, scheduler, cancellationToken, continuationOptions);
		return task;
	}

	public Task<TResult> ContinueWith<TResult>(Func<Task, TResult> continuationFunction)
	{
		return ContinueWith(continuationFunction, TaskScheduler.Current, default(CancellationToken), TaskContinuationOptions.None);
	}

	public Task<TResult> ContinueWith<TResult>(Func<Task, TResult> continuationFunction, CancellationToken cancellationToken)
	{
		return ContinueWith(continuationFunction, TaskScheduler.Current, cancellationToken, TaskContinuationOptions.None);
	}

	public Task<TResult> ContinueWith<TResult>(Func<Task, TResult> continuationFunction, TaskScheduler scheduler)
	{
		return ContinueWith(continuationFunction, scheduler, default(CancellationToken), TaskContinuationOptions.None);
	}

	public Task<TResult> ContinueWith<TResult>(Func<Task, TResult> continuationFunction, TaskContinuationOptions continuationOptions)
	{
		return ContinueWith(continuationFunction, TaskScheduler.Current, default(CancellationToken), continuationOptions);
	}

	public Task<TResult> ContinueWith<TResult>(Func<Task, TResult> continuationFunction, CancellationToken cancellationToken, TaskContinuationOptions continuationOptions, TaskScheduler scheduler)
	{
		return ContinueWith(continuationFunction, scheduler, cancellationToken, continuationOptions);
	}

	private Task<TResult> ContinueWith<TResult>(Func<Task, TResult> continuationFunction, TaskScheduler scheduler, CancellationToken cancellationToken, TaskContinuationOptions continuationOptions)
	{
		if (continuationFunction == null)
		{
			throw new ArgumentNullException("continuationFunction");
		}
		if (scheduler == null)
		{
			throw new ArgumentNullException("scheduler");
		}
		CreationOptionsFromContinuationOptions(continuationOptions, out var creationOptions, out var internalOptions);
		Task<TResult> task = new ContinuationResultTaskFromTask<TResult>(this, continuationFunction, null, creationOptions, internalOptions);
		ContinueWithCore(task, scheduler, cancellationToken, continuationOptions);
		return task;
	}

	public Task<TResult> ContinueWith<TResult>(Func<Task, object, TResult> continuationFunction, object state)
	{
		return ContinueWith(continuationFunction, state, TaskScheduler.Current, default(CancellationToken), TaskContinuationOptions.None);
	}

	public Task<TResult> ContinueWith<TResult>(Func<Task, object, TResult> continuationFunction, object state, CancellationToken cancellationToken)
	{
		return ContinueWith(continuationFunction, state, TaskScheduler.Current, cancellationToken, TaskContinuationOptions.None);
	}

	public Task<TResult> ContinueWith<TResult>(Func<Task, object, TResult> continuationFunction, object state, TaskScheduler scheduler)
	{
		return ContinueWith(continuationFunction, state, scheduler, default(CancellationToken), TaskContinuationOptions.None);
	}

	public Task<TResult> ContinueWith<TResult>(Func<Task, object, TResult> continuationFunction, object state, TaskContinuationOptions continuationOptions)
	{
		return ContinueWith(continuationFunction, state, TaskScheduler.Current, default(CancellationToken), continuationOptions);
	}

	public Task<TResult> ContinueWith<TResult>(Func<Task, object, TResult> continuationFunction, object state, CancellationToken cancellationToken, TaskContinuationOptions continuationOptions, TaskScheduler scheduler)
	{
		return ContinueWith(continuationFunction, state, scheduler, cancellationToken, continuationOptions);
	}

	private Task<TResult> ContinueWith<TResult>(Func<Task, object, TResult> continuationFunction, object state, TaskScheduler scheduler, CancellationToken cancellationToken, TaskContinuationOptions continuationOptions)
	{
		if (continuationFunction == null)
		{
			throw new ArgumentNullException("continuationFunction");
		}
		if (scheduler == null)
		{
			throw new ArgumentNullException("scheduler");
		}
		CreationOptionsFromContinuationOptions(continuationOptions, out var creationOptions, out var internalOptions);
		Task<TResult> task = new ContinuationResultTaskFromTask<TResult>(this, continuationFunction, state, creationOptions, internalOptions);
		ContinueWithCore(task, scheduler, cancellationToken, continuationOptions);
		return task;
	}

	internal static void CreationOptionsFromContinuationOptions(TaskContinuationOptions continuationOptions, out TaskCreationOptions creationOptions, out InternalTaskOptions internalOptions)
	{
		TaskContinuationOptions taskContinuationOptions = TaskContinuationOptions.OnlyOnRanToCompletion | TaskContinuationOptions.NotOnRanToCompletion;
		TaskContinuationOptions taskContinuationOptions2 = TaskContinuationOptions.PreferFairness | TaskContinuationOptions.LongRunning | TaskContinuationOptions.AttachedToParent | TaskContinuationOptions.DenyChildAttach | TaskContinuationOptions.HideScheduler | TaskContinuationOptions.RunContinuationsAsynchronously;
		TaskContinuationOptions taskContinuationOptions3 = TaskContinuationOptions.LongRunning | TaskContinuationOptions.ExecuteSynchronously;
		if ((continuationOptions & taskContinuationOptions3) == taskContinuationOptions3)
		{
			throw new ArgumentOutOfRangeException("continuationOptions", "The specified TaskContinuationOptions combined LongRunning and ExecuteSynchronously.  Synchronous continuations should not be long running.");
		}
		if ((continuationOptions & ~(taskContinuationOptions2 | taskContinuationOptions | TaskContinuationOptions.LazyCancellation | TaskContinuationOptions.ExecuteSynchronously)) != TaskContinuationOptions.None)
		{
			throw new ArgumentOutOfRangeException("continuationOptions");
		}
		if ((continuationOptions & taskContinuationOptions) == taskContinuationOptions)
		{
			throw new ArgumentOutOfRangeException("continuationOptions", "The specified TaskContinuationOptions excluded all continuation kinds.");
		}
		creationOptions = (TaskCreationOptions)(continuationOptions & taskContinuationOptions2);
		internalOptions = InternalTaskOptions.ContinuationTask;
		if ((continuationOptions & TaskContinuationOptions.LazyCancellation) != TaskContinuationOptions.None)
		{
			internalOptions |= InternalTaskOptions.LazyCancellation;
		}
	}

	internal void ContinueWithCore(Task continuationTask, TaskScheduler scheduler, CancellationToken cancellationToken, TaskContinuationOptions options)
	{
		TaskContinuation taskContinuation = new StandardTaskContinuation(continuationTask, options, scheduler);
		if (cancellationToken.CanBeCanceled)
		{
			if (IsCompleted || cancellationToken.IsCancellationRequested)
			{
				continuationTask.AssignCancellationToken(cancellationToken, null, null);
			}
			else
			{
				continuationTask.AssignCancellationToken(cancellationToken, this, taskContinuation);
			}
		}
		if (!continuationTask.IsCompleted && !AddTaskContinuation(taskContinuation, addBeforeOthers: false))
		{
			taskContinuation.Run(this, bCanInlineContinuationTask: true);
		}
	}

	internal void AddCompletionAction(ITaskCompletionAction action)
	{
		AddCompletionAction(action, addBeforeOthers: false);
	}

	private void AddCompletionAction(ITaskCompletionAction action, bool addBeforeOthers)
	{
		if (!AddTaskContinuation(action, addBeforeOthers))
		{
			action.Invoke(this);
		}
	}

	private bool AddTaskContinuationComplex(object tc, bool addBeforeOthers)
	{
		object continuationObject = m_continuationObject;
		if (continuationObject != s_taskCompletionSentinel && !(continuationObject is LowLevelListWithIList<object>))
		{
			LowLevelListWithIList<object> lowLevelListWithIList = new LowLevelListWithIList<object>();
			lowLevelListWithIList.Add(continuationObject);
			Interlocked.CompareExchange(ref m_continuationObject, lowLevelListWithIList, continuationObject);
		}
		if (m_continuationObject is LowLevelListWithIList<object> lowLevelListWithIList2)
		{
			lock (lowLevelListWithIList2)
			{
				if (m_continuationObject != s_taskCompletionSentinel)
				{
					if (lowLevelListWithIList2.Count == lowLevelListWithIList2.Capacity)
					{
						lowLevelListWithIList2.RemoveAll(s_IsTaskContinuationNullPredicate);
					}
					if (addBeforeOthers)
					{
						lowLevelListWithIList2.Insert(0, tc);
					}
					else
					{
						lowLevelListWithIList2.Add(tc);
					}
					return true;
				}
			}
		}
		return false;
	}

	private bool AddTaskContinuation(object tc, bool addBeforeOthers)
	{
		if (IsCompleted)
		{
			return false;
		}
		if (m_continuationObject != null || Interlocked.CompareExchange(ref m_continuationObject, tc, null) != null)
		{
			return AddTaskContinuationComplex(tc, addBeforeOthers);
		}
		return true;
	}

	internal void RemoveContinuation(object continuationObject)
	{
		object continuationObject2 = m_continuationObject;
		if (continuationObject2 == s_taskCompletionSentinel)
		{
			return;
		}
		LowLevelListWithIList<object> lowLevelListWithIList = continuationObject2 as LowLevelListWithIList<object>;
		if (lowLevelListWithIList == null)
		{
			if (Interlocked.CompareExchange(ref m_continuationObject, new LowLevelListWithIList<object>(), continuationObject) == continuationObject)
			{
				return;
			}
			lowLevelListWithIList = m_continuationObject as LowLevelListWithIList<object>;
		}
		if (lowLevelListWithIList == null)
		{
			return;
		}
		lock (lowLevelListWithIList)
		{
			if (m_continuationObject != s_taskCompletionSentinel)
			{
				int num = lowLevelListWithIList.IndexOf(continuationObject);
				if (num != -1)
				{
					lowLevelListWithIList[num] = null;
				}
			}
		}
	}

	[MethodImpl((MethodImplOptions)64)]
	public static void WaitAll(params Task[] tasks)
	{
		WaitAll(tasks, -1);
	}

	[MethodImpl((MethodImplOptions)64)]
	public static bool WaitAll(Task[] tasks, TimeSpan timeout)
	{
		long num = (long)timeout.TotalMilliseconds;
		if (num < -1 || num > int.MaxValue)
		{
			throw new ArgumentOutOfRangeException("timeout");
		}
		return WaitAll(tasks, (int)num);
	}

	[MethodImpl((MethodImplOptions)64)]
	public static bool WaitAll(Task[] tasks, int millisecondsTimeout)
	{
		return WaitAll(tasks, millisecondsTimeout, default(CancellationToken));
	}

	[MethodImpl((MethodImplOptions)64)]
	public static void WaitAll(Task[] tasks, CancellationToken cancellationToken)
	{
		WaitAll(tasks, -1, cancellationToken);
	}

	[MethodImpl((MethodImplOptions)64)]
	public static bool WaitAll(Task[] tasks, int millisecondsTimeout, CancellationToken cancellationToken)
	{
		if (tasks == null)
		{
			throw new ArgumentNullException("tasks");
		}
		if (millisecondsTimeout < -1)
		{
			throw new ArgumentOutOfRangeException("millisecondsTimeout");
		}
		cancellationToken.ThrowIfCancellationRequested();
		LowLevelListWithIList<Exception> exceptions = null;
		LowLevelListWithIList<Task> list = null;
		LowLevelListWithIList<Task> list2 = null;
		bool flag = false;
		bool flag2 = false;
		bool flag3 = true;
		for (int num = tasks.Length - 1; num >= 0; num--)
		{
			Task task = tasks[num];
			if (task == null)
			{
				throw new ArgumentException("The tasks array included at least one null element.", "tasks");
			}
			bool flag4 = task.IsCompleted;
			if (!flag4)
			{
				if (millisecondsTimeout != -1 || cancellationToken.CanBeCanceled)
				{
					AddToList(task, ref list, tasks.Length);
				}
				else
				{
					flag4 = task.WrappedTryRunInline() && task.IsCompleted;
					if (!flag4)
					{
						AddToList(task, ref list, tasks.Length);
					}
				}
			}
			if (flag4)
			{
				if (task.IsFaulted)
				{
					flag = true;
				}
				else if (task.IsCanceled)
				{
					flag2 = true;
				}
				if (task.IsWaitNotificationEnabled)
				{
					AddToList(task, ref list2, 1);
				}
			}
		}
		if (list != null)
		{
			flag3 = WaitAllBlockingCore(list, millisecondsTimeout, cancellationToken);
			if (flag3)
			{
				foreach (Task item in (IEnumerable<Task>)list)
				{
					if (item.IsFaulted)
					{
						flag = true;
					}
					else if (item.IsCanceled)
					{
						flag2 = true;
					}
					if (item.IsWaitNotificationEnabled)
					{
						AddToList(item, ref list2, 1);
					}
				}
			}
			GC.KeepAlive(tasks);
		}
		if (flag3 && list2 != null)
		{
			using IEnumerator<Task> enumerator = ((IEnumerable<Task>)list2).GetEnumerator();
			while (enumerator.MoveNext() && !enumerator.Current.NotifyDebuggerOfWaitCompletionIfNecessary())
			{
			}
		}
		if (flag3 && (flag | flag2))
		{
			if (!flag)
			{
				cancellationToken.ThrowIfCancellationRequested();
			}
			foreach (Task t in tasks)
			{
				AddExceptionsForCompletedTask(ref exceptions, t);
			}
			throw new AggregateException(exceptions);
		}
		return flag3;
	}

	private static void AddToList<T>(T item, ref LowLevelListWithIList<T> list, int initSize)
	{
		if (list == null)
		{
			list = new LowLevelListWithIList<T>(initSize);
		}
		list.Add(item);
	}

	private static bool WaitAllBlockingCore(LowLevelListWithIList<Task> tasks, int millisecondsTimeout, CancellationToken cancellationToken)
	{
		bool flag = false;
		SetOnCountdownMres setOnCountdownMres = new SetOnCountdownMres(tasks.Count);
		try
		{
			foreach (Task item in (IEnumerable<Task>)tasks)
			{
				item.AddCompletionAction(setOnCountdownMres, addBeforeOthers: true);
			}
			flag = setOnCountdownMres.Wait(millisecondsTimeout, cancellationToken);
		}
		finally
		{
			if (!flag)
			{
				foreach (Task item2 in (IEnumerable<Task>)tasks)
				{
					if (!item2.IsCompleted)
					{
						item2.RemoveContinuation(setOnCountdownMres);
					}
				}
			}
		}
		return flag;
	}

	internal static void AddExceptionsForCompletedTask(ref LowLevelListWithIList<Exception> exceptions, Task t)
	{
		AggregateException exceptions2 = t.GetExceptions(includeTaskCanceledExceptions: true);
		if (exceptions2 != null)
		{
			t.UpdateExceptionObservedStatus();
			if (exceptions == null)
			{
				exceptions = new LowLevelListWithIList<Exception>(exceptions2.InnerExceptions.Count);
			}
			exceptions.AddRange(exceptions2.InnerExceptions);
		}
	}

	[MethodImpl((MethodImplOptions)64)]
	public static int WaitAny(params Task[] tasks)
	{
		return WaitAny(tasks, -1);
	}

	[MethodImpl((MethodImplOptions)64)]
	public static int WaitAny(Task[] tasks, TimeSpan timeout)
	{
		long num = (long)timeout.TotalMilliseconds;
		if (num < -1 || num > int.MaxValue)
		{
			throw new ArgumentOutOfRangeException("timeout");
		}
		return WaitAny(tasks, (int)num);
	}

	[MethodImpl((MethodImplOptions)64)]
	public static int WaitAny(Task[] tasks, CancellationToken cancellationToken)
	{
		return WaitAny(tasks, -1, cancellationToken);
	}

	[MethodImpl((MethodImplOptions)64)]
	public static int WaitAny(Task[] tasks, int millisecondsTimeout)
	{
		return WaitAny(tasks, millisecondsTimeout, default(CancellationToken));
	}

	[MethodImpl((MethodImplOptions)64)]
	public static int WaitAny(Task[] tasks, int millisecondsTimeout, CancellationToken cancellationToken)
	{
		if (tasks == null)
		{
			throw new ArgumentNullException("tasks");
		}
		if (millisecondsTimeout < -1)
		{
			throw new ArgumentOutOfRangeException("millisecondsTimeout");
		}
		cancellationToken.ThrowIfCancellationRequested();
		int num = -1;
		for (int i = 0; i < tasks.Length; i++)
		{
			Task task = tasks[i];
			if (task == null)
			{
				throw new ArgumentException("The tasks array included at least one null element.", "tasks");
			}
			if (num == -1 && task.IsCompleted)
			{
				num = i;
			}
		}
		if (num == -1 && tasks.Length != 0)
		{
			Task<Task> task2 = TaskFactory.CommonCWAnyLogic(tasks);
			if (task2.Wait(millisecondsTimeout, cancellationToken))
			{
				num = Array.IndexOf(tasks, task2.Result);
			}
		}
		GC.KeepAlive(tasks);
		return num;
	}

	public static Task<TResult> FromResult<TResult>(TResult result)
	{
		return new Task<TResult>(result);
	}

	public static Task FromException(Exception exception)
	{
		return FromException<VoidTaskResult>(exception);
	}

	public static Task<TResult> FromException<TResult>(Exception exception)
	{
		if (exception == null)
		{
			throw new ArgumentNullException("exception");
		}
		Task<TResult> task = new Task<TResult>();
		task.TrySetException(exception);
		return task;
	}

	internal static Task FromCancellation(CancellationToken cancellationToken)
	{
		if (!cancellationToken.IsCancellationRequested)
		{
			throw new ArgumentOutOfRangeException("cancellationToken");
		}
		return new Task(canceled: true, TaskCreationOptions.None, cancellationToken);
	}

	public static Task FromCanceled(CancellationToken cancellationToken)
	{
		return FromCancellation(cancellationToken);
	}

	internal static Task<TResult> FromCancellation<TResult>(CancellationToken cancellationToken)
	{
		if (!cancellationToken.IsCancellationRequested)
		{
			throw new ArgumentOutOfRangeException("cancellationToken");
		}
		return new Task<TResult>(canceled: true, default(TResult), TaskCreationOptions.None, cancellationToken);
	}

	public static Task<TResult> FromCanceled<TResult>(CancellationToken cancellationToken)
	{
		return FromCancellation<TResult>(cancellationToken);
	}

	internal static Task<TResult> FromCancellation<TResult>(OperationCanceledException exception)
	{
		if (exception == null)
		{
			throw new ArgumentNullException("exception");
		}
		Task<TResult> task = new Task<TResult>();
		task.TrySetCanceled(exception.CancellationToken, exception);
		return task;
	}

	public static Task Run(Action action)
	{
		return InternalStartNew(null, action, null, default(CancellationToken), TaskScheduler.Default, TaskCreationOptions.DenyChildAttach, InternalTaskOptions.None);
	}

	public static Task Run(Action action, CancellationToken cancellationToken)
	{
		return InternalStartNew(null, action, null, cancellationToken, TaskScheduler.Default, TaskCreationOptions.DenyChildAttach, InternalTaskOptions.None);
	}

	public static Task<TResult> Run<TResult>(Func<TResult> function)
	{
		return Task<TResult>.StartNew(null, function, default(CancellationToken), TaskCreationOptions.DenyChildAttach, InternalTaskOptions.None, TaskScheduler.Default);
	}

	public static Task<TResult> Run<TResult>(Func<TResult> function, CancellationToken cancellationToken)
	{
		return Task<TResult>.StartNew(null, function, cancellationToken, TaskCreationOptions.DenyChildAttach, InternalTaskOptions.None, TaskScheduler.Default);
	}

	public static Task Run(Func<Task> function)
	{
		return Run(function, default(CancellationToken));
	}

	public static Task Run(Func<Task> function, CancellationToken cancellationToken)
	{
		if (function == null)
		{
			throw new ArgumentNullException("function");
		}
		if (cancellationToken.IsCancellationRequested)
		{
			return FromCancellation(cancellationToken);
		}
		return new UnwrapPromise<VoidTaskResult>(Factory.StartNew(function, cancellationToken, TaskCreationOptions.DenyChildAttach, TaskScheduler.Default), lookForOce: true);
	}

	public static Task<TResult> Run<TResult>(Func<Task<TResult>> function)
	{
		return Run(function, default(CancellationToken));
	}

	public static Task<TResult> Run<TResult>(Func<Task<TResult>> function, CancellationToken cancellationToken)
	{
		if (function == null)
		{
			throw new ArgumentNullException("function");
		}
		if (cancellationToken.IsCancellationRequested)
		{
			return FromCancellation<TResult>(cancellationToken);
		}
		return new UnwrapPromise<TResult>(Factory.StartNew(function, cancellationToken, TaskCreationOptions.DenyChildAttach, TaskScheduler.Default), lookForOce: true);
	}

	public static Task Delay(TimeSpan delay)
	{
		return Delay(delay, default(CancellationToken));
	}

	public static Task Delay(TimeSpan delay, CancellationToken cancellationToken)
	{
		long num = (long)delay.TotalMilliseconds;
		if (num < -1 || num > int.MaxValue)
		{
			throw new ArgumentOutOfRangeException("delay", "The value needs to translate in milliseconds to -1 (signifying an infinite timeout), 0 or a positive integer less than or equal to Int32.MaxValue.");
		}
		return Delay((int)num, cancellationToken);
	}

	public static Task Delay(int millisecondsDelay)
	{
		return Delay(millisecondsDelay, default(CancellationToken));
	}

	public static Task Delay(int millisecondsDelay, CancellationToken cancellationToken)
	{
		if (millisecondsDelay < -1)
		{
			throw new ArgumentOutOfRangeException("millisecondsDelay", "The value needs to be either -1 (signifying an infinite timeout), 0 or a positive integer.");
		}
		if (cancellationToken.IsCancellationRequested)
		{
			return FromCancellation(cancellationToken);
		}
		if (millisecondsDelay == 0)
		{
			return CompletedTask;
		}
		DelayPromise delayPromise = new DelayPromise(cancellationToken);
		if (cancellationToken.CanBeCanceled)
		{
			delayPromise.Registration = cancellationToken.InternalRegisterWithoutEC(delegate(object state)
			{
				((DelayPromise)state).Complete();
			}, delayPromise);
		}
		if (millisecondsDelay != -1)
		{
			delayPromise.Timer = new Timer(delegate(object state)
			{
				((DelayPromise)state).Complete();
			}, delayPromise, millisecondsDelay, -1);
			delayPromise.Timer.KeepRootedWhileScheduled();
		}
		return delayPromise;
	}

	public static Task WhenAll(IEnumerable<Task> tasks)
	{
		if (tasks is Task[] tasks2)
		{
			return WhenAll(tasks2);
		}
		if (tasks is ICollection<Task> collection)
		{
			int num = 0;
			Task[] array = new Task[collection.Count];
			foreach (Task task in tasks)
			{
				if (task == null)
				{
					throw new ArgumentException("The tasks argument included a null value.", "tasks");
				}
				array[num++] = task;
			}
			return InternalWhenAll(array);
		}
		if (tasks == null)
		{
			throw new ArgumentNullException("tasks");
		}
		LowLevelListWithIList<Task> lowLevelListWithIList = new LowLevelListWithIList<Task>();
		foreach (Task task2 in tasks)
		{
			if (task2 == null)
			{
				throw new ArgumentException("The tasks argument included a null value.", "tasks");
			}
			lowLevelListWithIList.Add(task2);
		}
		return InternalWhenAll(lowLevelListWithIList.ToArray());
	}

	public static Task WhenAll(params Task[] tasks)
	{
		if (tasks == null)
		{
			throw new ArgumentNullException("tasks");
		}
		int num = tasks.Length;
		if (num == 0)
		{
			return InternalWhenAll(tasks);
		}
		Task[] array = new Task[num];
		for (int i = 0; i < num; i++)
		{
			Task task = tasks[i];
			if (task == null)
			{
				throw new ArgumentException("The tasks argument included a null value.", "tasks");
			}
			array[i] = task;
		}
		return InternalWhenAll(array);
	}

	private static Task InternalWhenAll(Task[] tasks)
	{
		if (tasks.Length != 0)
		{
			return new WhenAllPromise(tasks);
		}
		return CompletedTask;
	}

	public static Task<TResult[]> WhenAll<TResult>(IEnumerable<Task<TResult>> tasks)
	{
		if (tasks is Task<TResult>[] tasks2)
		{
			return WhenAll(tasks2);
		}
		if (tasks is ICollection<Task<TResult>> collection)
		{
			int num = 0;
			Task<TResult>[] array = new Task<TResult>[collection.Count];
			foreach (Task<TResult> task in tasks)
			{
				if (task == null)
				{
					throw new ArgumentException("The tasks argument included a null value.", "tasks");
				}
				array[num++] = task;
			}
			return InternalWhenAll(array);
		}
		if (tasks == null)
		{
			throw new ArgumentNullException("tasks");
		}
		LowLevelListWithIList<Task<TResult>> lowLevelListWithIList = new LowLevelListWithIList<Task<TResult>>();
		foreach (Task<TResult> task2 in tasks)
		{
			if (task2 == null)
			{
				throw new ArgumentException("The tasks argument included a null value.", "tasks");
			}
			lowLevelListWithIList.Add(task2);
		}
		return InternalWhenAll(lowLevelListWithIList.ToArray());
	}

	public static Task<TResult[]> WhenAll<TResult>(params Task<TResult>[] tasks)
	{
		if (tasks == null)
		{
			throw new ArgumentNullException("tasks");
		}
		int num = tasks.Length;
		if (num == 0)
		{
			return InternalWhenAll(tasks);
		}
		Task<TResult>[] array = new Task<TResult>[num];
		for (int i = 0; i < num; i++)
		{
			Task<TResult> task = tasks[i];
			if (task == null)
			{
				throw new ArgumentException("The tasks argument included a null value.", "tasks");
			}
			array[i] = task;
		}
		return InternalWhenAll(array);
	}

	private static Task<TResult[]> InternalWhenAll<TResult>(Task<TResult>[] tasks)
	{
		if (tasks.Length != 0)
		{
			return new WhenAllPromise<TResult>(tasks);
		}
		return new Task<TResult[]>(canceled: false, Array.Empty<TResult>(), TaskCreationOptions.None, default(CancellationToken));
	}

	public static Task<Task> WhenAny(params Task[] tasks)
	{
		if (tasks == null)
		{
			throw new ArgumentNullException("tasks");
		}
		if (tasks.Length == 0)
		{
			throw new ArgumentException("The tasks argument contains no tasks.", "tasks");
		}
		int num = tasks.Length;
		Task[] array = new Task[num];
		for (int i = 0; i < num; i++)
		{
			Task task = tasks[i];
			if (task == null)
			{
				throw new ArgumentException("The tasks argument included a null value.", "tasks");
			}
			array[i] = task;
		}
		return TaskFactory.CommonCWAnyLogic(array);
	}

	public static Task<Task> WhenAny(IEnumerable<Task> tasks)
	{
		if (tasks == null)
		{
			throw new ArgumentNullException("tasks");
		}
		LowLevelListWithIList<Task> lowLevelListWithIList = new LowLevelListWithIList<Task>();
		foreach (Task task in tasks)
		{
			if (task == null)
			{
				throw new ArgumentException("The tasks argument included a null value.", "tasks");
			}
			lowLevelListWithIList.Add(task);
		}
		if (lowLevelListWithIList.Count == 0)
		{
			throw new ArgumentException("The tasks argument contains no tasks.", "tasks");
		}
		return TaskFactory.CommonCWAnyLogic(lowLevelListWithIList);
	}

	public static Task<Task<TResult>> WhenAny<TResult>(params Task<TResult>[] tasks)
	{
		return WhenAny((Task[])tasks).ContinueWith(Task<TResult>.TaskWhenAnyCast.Value, default(CancellationToken), TaskContinuationOptions.DenyChildAttach | TaskContinuationOptions.ExecuteSynchronously, TaskScheduler.Default);
	}

	public static Task<Task<TResult>> WhenAny<TResult>(IEnumerable<Task<TResult>> tasks)
	{
		return WhenAny((IEnumerable<Task>)tasks).ContinueWith(Task<TResult>.TaskWhenAnyCast.Value, default(CancellationToken), TaskContinuationOptions.DenyChildAttach | TaskContinuationOptions.ExecuteSynchronously, TaskScheduler.Default);
	}

	public static Task<TResult> CreateUnwrapPromise<TResult>(Task outerTask, bool lookForOce)
	{
		return new UnwrapPromise<TResult>(outerTask, lookForOce);
	}

	internal virtual Delegate[] GetDelegateContinuationsForDebugger()
	{
		return GetDelegatesFromContinuationObject(m_continuationObject);
	}

	private static Delegate[] GetDelegatesFromContinuationObject(object continuationObject)
	{
		if (continuationObject != null)
		{
			if (continuationObject is Action action)
			{
				return new Delegate[1] { AsyncMethodBuilderCore.TryGetStateMachineForDebugger(action) };
			}
			if (continuationObject is TaskContinuation taskContinuation)
			{
				return taskContinuation.GetDelegateContinuationsForDebugger();
			}
			if (continuationObject is Task task)
			{
				return task.GetDelegateContinuationsForDebugger();
			}
			if (continuationObject is ITaskCompletionAction taskCompletionAction)
			{
				return new Delegate[1]
				{
					new Action<Task>(taskCompletionAction.Invoke)
				};
			}
			if (continuationObject is LowLevelListWithIList<object> lowLevelListWithIList)
			{
				LowLevelListWithIList<Delegate> lowLevelListWithIList2 = new LowLevelListWithIList<Delegate>();
				foreach (object item in (IEnumerable<object>)lowLevelListWithIList)
				{
					Delegate[] delegatesFromContinuationObject = GetDelegatesFromContinuationObject(item);
					if (delegatesFromContinuationObject == null)
					{
						continue;
					}
					Delegate[] array = delegatesFromContinuationObject;
					foreach (Delegate obj in array)
					{
						if ((object)obj != null)
						{
							lowLevelListWithIList2.Add(obj);
						}
					}
				}
				return lowLevelListWithIList2.ToArray();
			}
		}
		return null;
	}

	private static Task GetActiveTaskFromId(int taskId)
	{
		return DebuggerSupport.GetActiveTaskFromId(taskId);
	}

	[FriendAccessAllowed]
	internal static bool AddToActiveTasks(Task task)
	{
		lock (s_activeTasksLock)
		{
			s_currentActiveTasks[task.Id] = task;
		}
		return true;
	}

	[FriendAccessAllowed]
	internal static void RemoveFromActiveTasks(int taskId)
	{
		lock (s_activeTasksLock)
		{
			s_currentActiveTasks.Remove(taskId);
		}
	}

	public void MarkAborted(ThreadAbortException e)
	{
	}

	private void ExecuteWithThreadLocal(ref Task currentTaskSlot)
	{
		Task task = currentTaskSlot;
		try
		{
			currentTaskSlot = this;
			ExecutionContext capturedContext = CapturedContext;
			if (capturedContext == null)
			{
				Execute();
			}
			else
			{
				ContextCallback callback = ExecutionContextCallback;
				ExecutionContext.Run(capturedContext, callback, this, preserveSyncCtx: true);
			}
			if (AsyncCausalityTracer.LoggingOn)
			{
				AsyncCausalityTracer.TraceSynchronousWorkCompletion(CausalityTraceLevel.Required, CausalitySynchronousWork.Execution);
			}
			Finish(bUserDelegateExecuted: true);
		}
		finally
		{
			currentTaskSlot = task;
		}
	}
}
