using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using UnityEngine.ResourceManagement.Exceptions;
using UnityEngine.ResourceManagement.Util;

namespace UnityEngine.ResourceManagement.AsyncOperations;

public abstract class AsyncOperationBase<TObject> : IAsyncOperation
{
	private int m_referenceCount = 1;

	internal AsyncOperationStatus m_Status;

	internal Exception m_Error;

	internal ResourceManager m_RM;

	internal int m_Version;

	private DelegateList<AsyncOperationHandle> m_DestroyedAction;

	private DelegateList<AsyncOperationHandle<TObject>> m_CompletedActionT;

	private Action<IAsyncOperation> m_OnDestroyAction;

	private Action<AsyncOperationHandle> m_dependencyCompleteAction;

	protected internal bool HasExecuted;

	private TaskCompletionSource<TObject> m_taskCompletionSource;

	private TaskCompletionSource<object> m_taskCompletionSourceTypeless;

	private bool m_InDeferredCallbackQueue;

	private DelegateList<float> m_UpdateCallbacks;

	private Action<float> m_UpdateCallback;

	protected virtual float Progress => 0f;

	protected virtual string DebugName => ToString();

	public TObject Result { get; set; }

	internal int Version => m_Version;

	internal bool CompletedEventHasListeners
	{
		get
		{
			if (m_CompletedActionT != null)
			{
				return m_CompletedActionT.Count > 0;
			}
			return false;
		}
	}

	internal bool DestroyedEventHasListeners
	{
		get
		{
			if (m_DestroyedAction != null)
			{
				return m_DestroyedAction.Count > 0;
			}
			return false;
		}
	}

	internal Action<IAsyncOperation> OnDestroy
	{
		set
		{
			m_OnDestroyAction = value;
		}
	}

	protected internal int ReferenceCount => m_referenceCount;

	public bool IsRunning { get; internal set; }

	internal Task<TObject> Task
	{
		get
		{
			if (m_taskCompletionSource == null)
			{
				m_taskCompletionSource = new TaskCompletionSource<TObject>(TaskCreationOptions.RunContinuationsAsynchronously);
				if (IsDone && !CompletedEventHasListeners)
				{
					m_taskCompletionSource.SetResult(Result);
				}
			}
			return m_taskCompletionSource.Task;
		}
	}

	Task<object> IAsyncOperation.Task
	{
		get
		{
			if (m_taskCompletionSourceTypeless == null)
			{
				m_taskCompletionSourceTypeless = new TaskCompletionSource<object>(TaskCreationOptions.RunContinuationsAsynchronously);
				if (IsDone && !CompletedEventHasListeners)
				{
					m_taskCompletionSourceTypeless.SetResult(Result);
				}
			}
			return m_taskCompletionSourceTypeless.Task;
		}
	}

	internal AsyncOperationStatus Status => m_Status;

	internal Exception OperationException
	{
		get
		{
			return m_Error;
		}
		private set
		{
			m_Error = value;
			if (m_Error != null && ResourceManager.ExceptionHandler != null)
			{
				ResourceManager.ExceptionHandler(new AsyncOperationHandle(this), value);
			}
		}
	}

	internal object Current => null;

	internal bool IsDone
	{
		get
		{
			if (Status != AsyncOperationStatus.Failed)
			{
				return Status == AsyncOperationStatus.Succeeded;
			}
			return true;
		}
	}

	internal float PercentComplete
	{
		get
		{
			if (m_Status == AsyncOperationStatus.None)
			{
				try
				{
					return Progress;
				}
				catch
				{
					return 0f;
				}
			}
			return 1f;
		}
	}

	internal AsyncOperationHandle<TObject> Handle => new AsyncOperationHandle<TObject>(this);

	int IAsyncOperation.Version => Version;

	int IAsyncOperation.ReferenceCount => ReferenceCount;

	float IAsyncOperation.PercentComplete => PercentComplete;

	AsyncOperationStatus IAsyncOperation.Status => Status;

	Exception IAsyncOperation.OperationException => OperationException;

	bool IAsyncOperation.IsDone => IsDone;

	AsyncOperationHandle IAsyncOperation.Handle => Handle;

	Action<IAsyncOperation> IAsyncOperation.OnDestroy
	{
		set
		{
			OnDestroy = value;
		}
	}

	string IAsyncOperation.DebugName => DebugName;

	Type IAsyncOperation.ResultType => typeof(TObject);

	internal event Action Executed;

	internal event Action<AsyncOperationHandle<TObject>> Completed
	{
		add
		{
			if (m_CompletedActionT == null)
			{
				m_CompletedActionT = DelegateList<AsyncOperationHandle<TObject>>.CreateWithGlobalCache();
			}
			m_CompletedActionT.Add(value);
			RegisterForDeferredCallbackEvent();
		}
		remove
		{
			m_CompletedActionT?.Remove(value);
		}
	}

	internal event Action<AsyncOperationHandle> Destroyed
	{
		add
		{
			if (m_DestroyedAction == null)
			{
				m_DestroyedAction = DelegateList<AsyncOperationHandle>.CreateWithGlobalCache();
			}
			m_DestroyedAction.Add(value);
		}
		remove
		{
			m_DestroyedAction?.Remove(value);
		}
	}

	internal event Action<AsyncOperationHandle> CompletedTypeless
	{
		add
		{
			Completed += (AsyncOperationHandle<TObject> s) =>
			{
				value(s);
			};
		}
		remove
		{
			Completed -= (AsyncOperationHandle<TObject> s) =>
			{
				value(s);
			};
		}
	}

	event Action<AsyncOperationHandle> IAsyncOperation.CompletedTypeless
	{
		add
		{
			CompletedTypeless += value;
		}
		remove
		{
			CompletedTypeless -= value;
		}
	}

	event Action<AsyncOperationHandle> IAsyncOperation.Destroyed
	{
		add
		{
			Destroyed += value;
		}
		remove
		{
			Destroyed -= value;
		}
	}

	protected abstract void Execute();

	protected virtual void Destroy()
	{
	}

	public virtual void GetDependencies(List<AsyncOperationHandle> dependencies)
	{
	}

	protected AsyncOperationBase()
	{
		m_UpdateCallback = UpdateCallback;
		m_dependencyCompleteAction = (AsyncOperationHandle o) =>
		{
			InvokeExecute();
		};
	}

	internal static string ShortenPath(string p, bool keepExtension)
	{
		int num = p.LastIndexOf('/');
		if (num > 0)
		{
			p = p.Substring(num + 1);
		}
		if (!keepExtension)
		{
			num = p.LastIndexOf('.');
			if (num > 0)
			{
				p = p.Substring(0, num);
			}
		}
		return p;
	}

	public void WaitForCompletion()
	{
		if (PlatformUtilities.PlatformUsesMultiThreading(Application.platform))
		{
			while (!InvokeWaitForCompletion())
			{
			}
			return;
		}
		throw new Exception($"{Application.platform} does not support synchronous Addressable loading.  Please do not use WaitForCompletion on the {Application.platform} platform.");
	}

	protected virtual bool InvokeWaitForCompletion()
	{
		return true;
	}

	protected internal void IncrementReferenceCount()
	{
		if (m_referenceCount == 0)
		{
			throw new Exception($"Cannot increment reference count on operation {this} because it has already been destroyed");
		}
		m_referenceCount++;
		if (m_RM != null && m_RM.postProfilerEvents)
		{
			m_RM.PostDiagnosticEvent(new ResourceManager.DiagnosticEventContext(new AsyncOperationHandle(this), ResourceManager.DiagnosticEventType.AsyncOperationReferenceCount, m_referenceCount));
		}
	}

	protected internal void DecrementReferenceCount()
	{
		if (m_referenceCount <= 0)
		{
			throw new Exception($"Cannot decrement reference count for operation {this} because it is already 0");
		}
		m_referenceCount--;
		if (m_RM != null && m_RM.postProfilerEvents)
		{
			m_RM.PostDiagnosticEvent(new ResourceManager.DiagnosticEventContext(new AsyncOperationHandle(this), ResourceManager.DiagnosticEventType.AsyncOperationReferenceCount, m_referenceCount));
		}
		if (m_referenceCount == 0)
		{
			if (m_RM != null && m_RM.postProfilerEvents)
			{
				m_RM.PostDiagnosticEvent(new ResourceManager.DiagnosticEventContext(new AsyncOperationHandle(this), ResourceManager.DiagnosticEventType.AsyncOperationDestroy));
			}
			if (m_DestroyedAction != null)
			{
				m_DestroyedAction.Invoke(Handle);
				m_DestroyedAction.Clear();
			}
			Destroy();
			Result = default;
			m_referenceCount = 1;
			m_Status = AsyncOperationStatus.None;
			m_taskCompletionSource = null;
			m_taskCompletionSourceTypeless = null;
			m_Error = null;
			m_Version++;
			m_RM = null;
			if (m_OnDestroyAction != null)
			{
				m_OnDestroyAction(this);
				m_OnDestroyAction = null;
			}
		}
	}

	public override string ToString()
	{
		string text = "";
		Object obj = Result as Object;
		if (obj != null)
		{
			text = "(" + obj.GetInstanceID() + ")";
		}
		return $"{base.ToString()}, result='{obj?.ToString() + text}', status='{m_Status}'";
	}

	private void RegisterForDeferredCallbackEvent(bool incrementReferenceCount = true)
	{
		if (IsDone && !m_InDeferredCallbackQueue)
		{
			m_InDeferredCallbackQueue = true;
			m_RM?.RegisterForDeferredCallback(this, incrementReferenceCount);
		}
	}

	internal bool MoveNext()
	{
		return !IsDone;
	}

	internal void Reset()
	{
	}

	internal void InvokeCompletionEvent()
	{
		if (m_CompletedActionT != null)
		{
			m_CompletedActionT.Invoke(Handle);
			m_CompletedActionT.Clear();
		}
		if (m_taskCompletionSource != null)
		{
			m_taskCompletionSource.TrySetResult(Result);
		}
		if (m_taskCompletionSourceTypeless != null)
		{
			m_taskCompletionSourceTypeless.TrySetResult(Result);
		}
		m_InDeferredCallbackQueue = false;
	}

	private void UpdateCallback(float unscaledDeltaTime)
	{
		(this as IUpdateReceiver).Update(unscaledDeltaTime);
	}

	public void Complete(TObject result, bool success, string errorMsg)
	{
		Complete(result, success, errorMsg, releaseDependenciesOnFailure: true);
	}

	public void Complete(TObject result, bool success, string errorMsg, bool releaseDependenciesOnFailure)
	{
		Complete(result, success, (!string.IsNullOrEmpty(errorMsg)) ? new OperationException(errorMsg) : null, releaseDependenciesOnFailure);
	}

	public void Complete(TObject result, bool success, Exception exception, bool releaseDependenciesOnFailure = true)
	{
		if (IsDone)
		{
			return;
		}
		IUpdateReceiver updateReceiver = this as IUpdateReceiver;
		if (m_UpdateCallbacks != null && updateReceiver != null)
		{
			m_UpdateCallbacks.Remove(m_UpdateCallback);
		}
		Result = result;
		m_Status = (success ? AsyncOperationStatus.Succeeded : AsyncOperationStatus.Failed);
		if (m_RM != null && m_RM.postProfilerEvents)
		{
			m_RM.PostDiagnosticEvent(new ResourceManager.DiagnosticEventContext(new AsyncOperationHandle(this), ResourceManager.DiagnosticEventType.AsyncOperationPercentComplete, 1));
			m_RM.PostDiagnosticEvent(new ResourceManager.DiagnosticEventContext(new AsyncOperationHandle(this), ResourceManager.DiagnosticEventType.AsyncOperationComplete));
		}
		if (m_Status == AsyncOperationStatus.Failed || exception != null)
		{
			if (exception == null || string.IsNullOrEmpty(exception.Message))
			{
				OperationException = new OperationException("Unknown error in AsyncOperation : " + DebugName);
			}
			else
			{
				OperationException = exception;
			}
		}
		if (m_Status == AsyncOperationStatus.Failed)
		{
			if (releaseDependenciesOnFailure)
			{
				ReleaseDependencies();
			}
			if (m_RM != null && m_RM.postProfilerEvents)
			{
				m_RM.PostDiagnosticEvent(new ResourceManager.DiagnosticEventContext(new AsyncOperationHandle(this), ResourceManager.DiagnosticEventType.AsyncOperationFail, 0, exception?.ToString()));
			}
			ICachable cachable = this as ICachable;
			if (cachable?.Key != null)
			{
				m_RM?.RemoveOperationFromCache(cachable.Key);
			}
			RegisterForDeferredCallbackEvent(incrementReferenceCount: false);
		}
		else
		{
			InvokeCompletionEvent();
			DecrementReferenceCount();
		}
		IsRunning = false;
	}

	internal void Start(ResourceManager rm, AsyncOperationHandle dependency, DelegateList<float> updateCallbacks)
	{
		m_RM = rm;
		IsRunning = true;
		HasExecuted = false;
		if (m_RM != null && m_RM.postProfilerEvents)
		{
			m_RM.PostDiagnosticEvent(new ResourceManager.DiagnosticEventContext(new AsyncOperationHandle(this), ResourceManager.DiagnosticEventType.AsyncOperationCreate));
			m_RM.PostDiagnosticEvent(new ResourceManager.DiagnosticEventContext(new AsyncOperationHandle(this), ResourceManager.DiagnosticEventType.AsyncOperationPercentComplete));
		}
		IncrementReferenceCount();
		m_UpdateCallbacks = updateCallbacks;
		if (dependency.IsValid() && !dependency.IsDone)
		{
			dependency.Completed += m_dependencyCompleteAction;
		}
		else
		{
			InvokeExecute();
		}
	}

	internal void InvokeExecute()
	{
		Execute();
		HasExecuted = true;
		if (this is IUpdateReceiver && !IsDone)
		{
			m_UpdateCallbacks.Add(m_UpdateCallback);
		}
		Executed?.Invoke();
	}

	object IAsyncOperation.GetResultAsObject()
	{
		return Result;
	}

	void IAsyncOperation.GetDependencies(List<AsyncOperationHandle> deps)
	{
		GetDependencies(deps);
	}

	void IAsyncOperation.DecrementReferenceCount()
	{
		DecrementReferenceCount();
	}

	void IAsyncOperation.IncrementReferenceCount()
	{
		IncrementReferenceCount();
	}

	void IAsyncOperation.InvokeCompletionEvent()
	{
		InvokeCompletionEvent();
	}

	void IAsyncOperation.Start(ResourceManager rm, AsyncOperationHandle dependency, DelegateList<float> updateCallbacks)
	{
		Start(rm, dependency, updateCallbacks);
	}

	internal virtual void ReleaseDependencies()
	{
	}

	DownloadStatus IAsyncOperation.GetDownloadStatus(HashSet<object> visited)
	{
		return GetDownloadStatus(visited);
	}

	internal virtual DownloadStatus GetDownloadStatus(HashSet<object> visited)
	{
		visited.Add(this);
		return new DownloadStatus
		{
			IsDone = IsDone
		};
	}
}
