using System.Collections.Generic;
using Internal.Runtime.Augments;

namespace System.Threading.Tasks;

public class TaskFactory<TResult>
{
	private sealed class FromAsyncTrimPromise<TInstance> : Task<TResult> where TInstance : class
	{
		internal static readonly AsyncCallback s_completeFromAsyncResult = CompleteFromAsyncResult;

		private TInstance m_thisRef;

		private Func<TInstance, IAsyncResult, TResult> m_endMethod;

		internal FromAsyncTrimPromise(TInstance thisRef, Func<TInstance, IAsyncResult, TResult> endMethod)
		{
			m_thisRef = thisRef;
			m_endMethod = endMethod;
		}

		internal static void CompleteFromAsyncResult(IAsyncResult asyncResult)
		{
			if (asyncResult == null)
			{
				throw new ArgumentNullException("asyncResult");
			}
			if (!(asyncResult.AsyncState is FromAsyncTrimPromise<TInstance> { m_thisRef: var thisRef, m_endMethod: var endMethod } fromAsyncTrimPromise))
			{
				throw new ArgumentException("Either the IAsyncResult object did not come from the corresponding async method on this type, or the End method was called multiple times with the same IAsyncResult.", "asyncResult");
			}
			fromAsyncTrimPromise.m_thisRef = null;
			fromAsyncTrimPromise.m_endMethod = null;
			if (endMethod == null)
			{
				throw new ArgumentException("Either the IAsyncResult object did not come from the corresponding async method on this type, or the End method was called multiple times with the same IAsyncResult.", "asyncResult");
			}
			if (!asyncResult.CompletedSynchronously)
			{
				fromAsyncTrimPromise.Complete(thisRef, endMethod, asyncResult, requiresSynchronization: true);
			}
		}

		internal void Complete(TInstance thisRef, Func<TInstance, IAsyncResult, TResult> endMethod, IAsyncResult asyncResult, bool requiresSynchronization)
		{
			try
			{
				TResult result = endMethod(thisRef, asyncResult);
				if (requiresSynchronization)
				{
					TrySetResult(result);
				}
				else
				{
					DangerousSetResult(result);
				}
			}
			catch (OperationCanceledException ex)
			{
				TrySetCanceled(ex.CancellationToken, ex);
			}
			catch (Exception exceptionObject)
			{
				TrySetException(exceptionObject);
			}
		}
	}

	private CancellationToken m_defaultCancellationToken;

	private TaskScheduler m_defaultScheduler;

	private TaskCreationOptions m_defaultCreationOptions;

	private TaskContinuationOptions m_defaultContinuationOptions;

	public TaskFactory()
		: this(default(CancellationToken), TaskCreationOptions.None, TaskContinuationOptions.None, (TaskScheduler)null)
	{
	}

	public TaskFactory(CancellationToken cancellationToken, TaskCreationOptions creationOptions, TaskContinuationOptions continuationOptions, TaskScheduler scheduler)
	{
		TaskFactory.CheckMultiTaskContinuationOptions(continuationOptions);
		TaskFactory.CheckCreationOptions(creationOptions);
		m_defaultCancellationToken = cancellationToken;
		m_defaultScheduler = scheduler;
		m_defaultCreationOptions = creationOptions;
		m_defaultContinuationOptions = continuationOptions;
	}

	public Task<TResult> StartNew(Func<object, TResult> function, object state, CancellationToken cancellationToken, TaskCreationOptions creationOptions, TaskScheduler scheduler)
	{
		return Task<TResult>.StartNew(Task.InternalCurrentIfAttached(creationOptions), function, state, cancellationToken, creationOptions, InternalTaskOptions.None, scheduler);
	}

	private static void FromAsyncCoreLogic(IAsyncResult iar, Func<IAsyncResult, TResult> endFunction, Action<IAsyncResult> endAction, Task<TResult> promise, bool requiresSynchronization)
	{
		Exception ex = null;
		OperationCanceledException ex2 = null;
		TResult result = default(TResult);
		try
		{
			if (endFunction != null)
			{
				result = endFunction(iar);
			}
			else
			{
				endAction(iar);
			}
		}
		catch (OperationCanceledException ex3)
		{
			ex2 = ex3;
		}
		catch (Exception ex4)
		{
			ex = ex4;
		}
		finally
		{
			if (ex2 != null)
			{
				promise.TrySetCanceled(ex2.CancellationToken, ex2);
			}
			else if (ex != null)
			{
				promise.TrySetException(ex);
			}
			else
			{
				if (DebuggerSupport.LoggingOn)
				{
					DebuggerSupport.TraceOperationCompletion(CausalityTraceLevel.Required, promise, AsyncStatus.Completed);
				}
				DebuggerSupport.RemoveFromActiveTasks(promise);
				if (requiresSynchronization)
				{
					promise.TrySetResult(result);
				}
				else
				{
					promise.DangerousSetResult(result);
				}
			}
		}
	}

	public Task<TResult> FromAsync(Func<AsyncCallback, object, IAsyncResult> beginMethod, Func<IAsyncResult, TResult> endMethod, object state)
	{
		return FromAsyncImpl(beginMethod, endMethod, null, state, m_defaultCreationOptions);
	}

	internal static Task<TResult> FromAsyncImpl(Func<AsyncCallback, object, IAsyncResult> beginMethod, Func<IAsyncResult, TResult> endFunction, Action<IAsyncResult> endAction, object state, TaskCreationOptions creationOptions)
	{
		if (beginMethod == null)
		{
			throw new ArgumentNullException("beginMethod");
		}
		if (endFunction == null && endAction == null)
		{
			throw new ArgumentNullException("endMethod");
		}
		TaskFactory.CheckFromAsyncOptions(creationOptions, hasBeginMethod: true);
		Task<TResult> promise = new Task<TResult>(state, creationOptions);
		if (DebuggerSupport.LoggingOn)
		{
			DebuggerSupport.TraceOperationCreation(CausalityTraceLevel.Required, promise, "TaskFactory.FromAsync: " + beginMethod, 0uL);
		}
		DebuggerSupport.AddToActiveTasks(promise);
		try
		{
			IAsyncResult asyncResult = beginMethod(delegate(IAsyncResult iar)
			{
				if (!iar.CompletedSynchronously)
				{
					FromAsyncCoreLogic(iar, endFunction, endAction, promise, requiresSynchronization: true);
				}
			}, state);
			if (asyncResult.CompletedSynchronously)
			{
				FromAsyncCoreLogic(asyncResult, endFunction, endAction, promise, requiresSynchronization: false);
			}
		}
		catch
		{
			if (DebuggerSupport.LoggingOn)
			{
				DebuggerSupport.TraceOperationCompletion(CausalityTraceLevel.Required, promise, AsyncStatus.Error);
			}
			DebuggerSupport.RemoveFromActiveTasks(promise);
			promise.TrySetResult(default(TResult));
			throw;
		}
		return promise;
	}

	public Task<TResult> FromAsync<TArg1>(Func<TArg1, AsyncCallback, object, IAsyncResult> beginMethod, Func<IAsyncResult, TResult> endMethod, TArg1 arg1, object state)
	{
		return FromAsyncImpl(beginMethod, endMethod, null, arg1, state, m_defaultCreationOptions);
	}

	internal static Task<TResult> FromAsyncImpl<TArg1>(Func<TArg1, AsyncCallback, object, IAsyncResult> beginMethod, Func<IAsyncResult, TResult> endFunction, Action<IAsyncResult> endAction, TArg1 arg1, object state, TaskCreationOptions creationOptions)
	{
		if (beginMethod == null)
		{
			throw new ArgumentNullException("beginMethod");
		}
		if (endFunction == null && endAction == null)
		{
			throw new ArgumentNullException("endFunction");
		}
		TaskFactory.CheckFromAsyncOptions(creationOptions, hasBeginMethod: true);
		Task<TResult> promise = new Task<TResult>(state, creationOptions);
		if (DebuggerSupport.LoggingOn)
		{
			DebuggerSupport.TraceOperationCreation(CausalityTraceLevel.Required, promise, "TaskFactory.FromAsync: " + beginMethod, 0uL);
		}
		DebuggerSupport.AddToActiveTasks(promise);
		try
		{
			IAsyncResult asyncResult = beginMethod(arg1, delegate(IAsyncResult iar)
			{
				if (!iar.CompletedSynchronously)
				{
					FromAsyncCoreLogic(iar, endFunction, endAction, promise, requiresSynchronization: true);
				}
			}, state);
			if (asyncResult.CompletedSynchronously)
			{
				FromAsyncCoreLogic(asyncResult, endFunction, endAction, promise, requiresSynchronization: false);
			}
		}
		catch
		{
			if (DebuggerSupport.LoggingOn)
			{
				DebuggerSupport.TraceOperationCompletion(CausalityTraceLevel.Required, promise, AsyncStatus.Error);
			}
			DebuggerSupport.RemoveFromActiveTasks(promise);
			promise.TrySetResult(default(TResult));
			throw;
		}
		return promise;
	}

	internal static Task<TResult> FromAsyncImpl<TArg1, TArg2>(Func<TArg1, TArg2, AsyncCallback, object, IAsyncResult> beginMethod, Func<IAsyncResult, TResult> endFunction, Action<IAsyncResult> endAction, TArg1 arg1, TArg2 arg2, object state, TaskCreationOptions creationOptions)
	{
		if (beginMethod == null)
		{
			throw new ArgumentNullException("beginMethod");
		}
		if (endFunction == null && endAction == null)
		{
			throw new ArgumentNullException("endMethod");
		}
		TaskFactory.CheckFromAsyncOptions(creationOptions, hasBeginMethod: true);
		Task<TResult> promise = new Task<TResult>(state, creationOptions);
		if (DebuggerSupport.LoggingOn)
		{
			DebuggerSupport.TraceOperationCreation(CausalityTraceLevel.Required, promise, "TaskFactory.FromAsync: " + beginMethod, 0uL);
		}
		DebuggerSupport.AddToActiveTasks(promise);
		try
		{
			IAsyncResult asyncResult = beginMethod(arg1, arg2, delegate(IAsyncResult iar)
			{
				if (!iar.CompletedSynchronously)
				{
					FromAsyncCoreLogic(iar, endFunction, endAction, promise, requiresSynchronization: true);
				}
			}, state);
			if (asyncResult.CompletedSynchronously)
			{
				FromAsyncCoreLogic(asyncResult, endFunction, endAction, promise, requiresSynchronization: false);
			}
		}
		catch
		{
			if (DebuggerSupport.LoggingOn)
			{
				DebuggerSupport.TraceOperationCompletion(CausalityTraceLevel.Required, promise, AsyncStatus.Error);
			}
			DebuggerSupport.RemoveFromActiveTasks(promise);
			promise.TrySetResult(default(TResult));
			throw;
		}
		return promise;
	}

	internal static Task<TResult> FromAsyncTrim<TInstance, TArgs>(TInstance thisRef, TArgs args, Func<TInstance, TArgs, AsyncCallback, object, IAsyncResult> beginMethod, Func<TInstance, IAsyncResult, TResult> endMethod) where TInstance : class
	{
		FromAsyncTrimPromise<TInstance> fromAsyncTrimPromise = new FromAsyncTrimPromise<TInstance>(thisRef, endMethod);
		IAsyncResult asyncResult = beginMethod(thisRef, args, FromAsyncTrimPromise<TInstance>.s_completeFromAsyncResult, fromAsyncTrimPromise);
		if (asyncResult.CompletedSynchronously)
		{
			fromAsyncTrimPromise.Complete(thisRef, endMethod, asyncResult, requiresSynchronization: false);
		}
		return fromAsyncTrimPromise;
	}
}
public class TaskFactory
{
	internal sealed class CompleteOnInvokePromise : Task<Task>, ITaskCompletionAction
	{
		private IList<Task> _tasks;

		public bool InvokeMayRunArbitraryCode => true;

		public CompleteOnInvokePromise(IList<Task> tasks)
		{
			_tasks = tasks;
			if (DebuggerSupport.LoggingOn)
			{
				DebuggerSupport.TraceOperationCreation(CausalityTraceLevel.Required, this, "TaskFactory.ContinueWhenAny", 0uL);
			}
			DebuggerSupport.AddToActiveTasks(this);
		}

		public void Invoke(Task completingTask)
		{
			if (!TrySetResult(completingTask))
			{
				return;
			}
			if (DebuggerSupport.LoggingOn)
			{
				DebuggerSupport.TraceOperationRelation(CausalityTraceLevel.Important, this, CausalityRelation.Choice);
				DebuggerSupport.TraceOperationCompletion(CausalityTraceLevel.Required, this, AsyncStatus.Completed);
			}
			DebuggerSupport.RemoveFromActiveTasks(this);
			IList<Task> tasks = _tasks;
			int count = tasks.Count;
			for (int i = 0; i < count; i++)
			{
				Task task = tasks[i];
				if (task != null && !task.IsCompleted)
				{
					task.RemoveContinuation(this);
				}
			}
			_tasks = null;
		}
	}

	private readonly CancellationToken m_defaultCancellationToken;

	private readonly TaskScheduler m_defaultScheduler;

	private readonly TaskCreationOptions m_defaultCreationOptions;

	private readonly TaskContinuationOptions m_defaultContinuationOptions;

	public TaskFactory()
		: this(default(CancellationToken), TaskCreationOptions.None, TaskContinuationOptions.None, null)
	{
	}

	public TaskFactory(CancellationToken cancellationToken, TaskCreationOptions creationOptions, TaskContinuationOptions continuationOptions, TaskScheduler scheduler)
	{
		CheckMultiTaskContinuationOptions(continuationOptions);
		CheckCreationOptions(creationOptions);
		m_defaultCancellationToken = cancellationToken;
		m_defaultScheduler = scheduler;
		m_defaultCreationOptions = creationOptions;
		m_defaultContinuationOptions = continuationOptions;
	}

	internal static void CheckCreationOptions(TaskCreationOptions creationOptions)
	{
		if ((creationOptions & ~(TaskCreationOptions.PreferFairness | TaskCreationOptions.LongRunning | TaskCreationOptions.AttachedToParent | TaskCreationOptions.DenyChildAttach | TaskCreationOptions.HideScheduler | TaskCreationOptions.RunContinuationsAsynchronously)) != TaskCreationOptions.None)
		{
			throw new ArgumentOutOfRangeException("creationOptions");
		}
	}

	public Task StartNew(Action action, CancellationToken cancellationToken, TaskCreationOptions creationOptions, TaskScheduler scheduler)
	{
		return Task.InternalStartNew(Task.InternalCurrentIfAttached(creationOptions), action, null, cancellationToken, scheduler, creationOptions, InternalTaskOptions.None);
	}

	public Task StartNew(Action<object> action, object state, CancellationToken cancellationToken, TaskCreationOptions creationOptions, TaskScheduler scheduler)
	{
		return Task.InternalStartNew(Task.InternalCurrentIfAttached(creationOptions), action, state, cancellationToken, scheduler, creationOptions, InternalTaskOptions.None);
	}

	public Task<TResult> StartNew<TResult>(Func<TResult> function, CancellationToken cancellationToken, TaskCreationOptions creationOptions, TaskScheduler scheduler)
	{
		return Task<TResult>.StartNew(Task.InternalCurrentIfAttached(creationOptions), function, cancellationToken, creationOptions, InternalTaskOptions.None, scheduler);
	}

	public Task<TResult> StartNew<TResult>(Func<object, TResult> function, object state, CancellationToken cancellationToken, TaskCreationOptions creationOptions, TaskScheduler scheduler)
	{
		return Task<TResult>.StartNew(Task.InternalCurrentIfAttached(creationOptions), function, state, cancellationToken, creationOptions, InternalTaskOptions.None, scheduler);
	}

	public Task FromAsync<TArg1>(Func<TArg1, AsyncCallback, object, IAsyncResult> beginMethod, Action<IAsyncResult> endMethod, TArg1 arg1, object state)
	{
		return FromAsync(beginMethod, endMethod, arg1, state, m_defaultCreationOptions);
	}

	public Task FromAsync<TArg1>(Func<TArg1, AsyncCallback, object, IAsyncResult> beginMethod, Action<IAsyncResult> endMethod, TArg1 arg1, object state, TaskCreationOptions creationOptions)
	{
		return TaskFactory<VoidTaskResult>.FromAsyncImpl(beginMethod, null, endMethod, arg1, state, creationOptions);
	}

	public Task FromAsync<TArg1, TArg2>(Func<TArg1, TArg2, AsyncCallback, object, IAsyncResult> beginMethod, Action<IAsyncResult> endMethod, TArg1 arg1, TArg2 arg2, object state)
	{
		return FromAsync(beginMethod, endMethod, arg1, arg2, state, m_defaultCreationOptions);
	}

	public Task FromAsync<TArg1, TArg2>(Func<TArg1, TArg2, AsyncCallback, object, IAsyncResult> beginMethod, Action<IAsyncResult> endMethod, TArg1 arg1, TArg2 arg2, object state, TaskCreationOptions creationOptions)
	{
		return TaskFactory<VoidTaskResult>.FromAsyncImpl(beginMethod, null, endMethod, arg1, arg2, state, creationOptions);
	}

	internal static void CheckFromAsyncOptions(TaskCreationOptions creationOptions, bool hasBeginMethod)
	{
		if (hasBeginMethod)
		{
			if ((creationOptions & TaskCreationOptions.LongRunning) != TaskCreationOptions.None)
			{
				throw new ArgumentOutOfRangeException("creationOptions", "It is invalid to specify TaskCreationOptions.LongRunning in calls to FromAsync.");
			}
			if ((creationOptions & TaskCreationOptions.PreferFairness) != TaskCreationOptions.None)
			{
				throw new ArgumentOutOfRangeException("creationOptions", "It is invalid to specify TaskCreationOptions.PreferFairness in calls to FromAsync.");
			}
		}
		if ((creationOptions & ~(TaskCreationOptions.PreferFairness | TaskCreationOptions.LongRunning | TaskCreationOptions.AttachedToParent | TaskCreationOptions.DenyChildAttach | TaskCreationOptions.HideScheduler)) != TaskCreationOptions.None)
		{
			throw new ArgumentOutOfRangeException("creationOptions");
		}
	}

	internal static Task<Task> CommonCWAnyLogic(IList<Task> tasks)
	{
		CompleteOnInvokePromise completeOnInvokePromise = new CompleteOnInvokePromise(tasks);
		bool flag = false;
		int count = tasks.Count;
		for (int i = 0; i < count; i++)
		{
			Task task = tasks[i];
			if (task == null)
			{
				throw new ArgumentException("The tasks argument included a null value.", "tasks");
			}
			if (flag)
			{
				continue;
			}
			if (completeOnInvokePromise.IsCompleted)
			{
				flag = true;
				continue;
			}
			if (task.IsCompleted)
			{
				completeOnInvokePromise.Invoke(task);
				flag = true;
				continue;
			}
			task.AddCompletionAction(completeOnInvokePromise);
			if (completeOnInvokePromise.IsCompleted)
			{
				task.RemoveContinuation(completeOnInvokePromise);
			}
		}
		return completeOnInvokePromise;
	}

	internal static void CheckMultiTaskContinuationOptions(TaskContinuationOptions continuationOptions)
	{
		if ((continuationOptions & (TaskContinuationOptions.LongRunning | TaskContinuationOptions.ExecuteSynchronously)) == (TaskContinuationOptions.LongRunning | TaskContinuationOptions.ExecuteSynchronously))
		{
			throw new ArgumentOutOfRangeException("continuationOptions", "The specified TaskContinuationOptions combined LongRunning and ExecuteSynchronously.  Synchronous continuations should not be long running.");
		}
		if ((continuationOptions & ~(TaskContinuationOptions.OnlyOnRanToCompletion | TaskContinuationOptions.PreferFairness | TaskContinuationOptions.LongRunning | TaskContinuationOptions.AttachedToParent | TaskContinuationOptions.DenyChildAttach | TaskContinuationOptions.HideScheduler | TaskContinuationOptions.LazyCancellation | TaskContinuationOptions.NotOnRanToCompletion | TaskContinuationOptions.ExecuteSynchronously)) != TaskContinuationOptions.None)
		{
			throw new ArgumentOutOfRangeException("continuationOptions");
		}
		if ((continuationOptions & (TaskContinuationOptions.OnlyOnRanToCompletion | TaskContinuationOptions.NotOnRanToCompletion)) != TaskContinuationOptions.None)
		{
			throw new ArgumentOutOfRangeException("continuationOptions", "It is invalid to exclude specific continuation kinds for continuations off of multiple tasks.");
		}
	}
}
