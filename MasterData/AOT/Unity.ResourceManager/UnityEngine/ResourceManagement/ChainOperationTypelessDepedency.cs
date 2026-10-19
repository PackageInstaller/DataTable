using System;
using System.Collections.Generic;
using UnityEngine.ResourceManagement.AsyncOperations;
using UnityEngine.ResourceManagement.Exceptions;

namespace UnityEngine.ResourceManagement;

internal class ChainOperationTypelessDepedency<TObject> : AsyncOperationBase<TObject>
{
	private AsyncOperationHandle m_DepOp;

	private AsyncOperationHandle<TObject> m_WrappedOp;

	private DownloadStatus m_depStatus;

	private DownloadStatus m_wrapStatus;

	private Func<AsyncOperationHandle, AsyncOperationHandle<TObject>> m_Callback;

	private Action<AsyncOperationHandle<TObject>> m_CachedOnWrappedCompleted;

	private bool m_ReleaseDependenciesOnFailure = true;

	internal AsyncOperationHandle<TObject> WrappedOp => m_WrappedOp;

	protected override string DebugName => "ChainOperation<" + typeof(TObject).Name + "> - " + m_DepOp.DebugName;

	protected override float Progress
	{
		get
		{
			DownloadStatus downloadStatus = GetDownloadStatus(new HashSet<object>());
			if (!downloadStatus.IsDone && downloadStatus.DownloadedBytes == 0L)
			{
				return 0f;
			}
			float num = 0f;
			int num2 = 2;
			num = ((!m_DepOp.IsValid()) ? (num + 1f) : (num + m_DepOp.PercentComplete));
			num = ((!m_WrappedOp.IsValid()) ? (num + 1f) : (num + m_WrappedOp.PercentComplete));
			return num / (float)num2;
		}
	}

	public ChainOperationTypelessDepedency()
	{
		m_CachedOnWrappedCompleted = OnWrappedCompleted;
	}

	public override void GetDependencies(List<AsyncOperationHandle> deps)
	{
		if (m_DepOp.IsValid())
		{
			deps.Add(m_DepOp);
		}
	}

	public void Init(AsyncOperationHandle dependentOp, Func<AsyncOperationHandle, AsyncOperationHandle<TObject>> callback, bool releaseDependenciesOnFailure)
	{
		m_DepOp = dependentOp;
		m_DepOp.Acquire();
		m_Callback = callback;
		m_ReleaseDependenciesOnFailure = releaseDependenciesOnFailure;
		RefreshDownloadStatus();
	}

	protected override bool InvokeWaitForCompletion()
	{
		if (IsDone)
		{
			return true;
		}
		if (!m_DepOp.IsDone)
		{
			m_DepOp.WaitForCompletion();
		}
		m_RM?.Update(Time.unscaledDeltaTime);
		if (!HasExecuted)
		{
			InvokeExecute();
		}
		if (!m_WrappedOp.IsValid())
		{
			return m_WrappedOp.IsDone;
		}
		Result = m_WrappedOp.WaitForCompletion();
		return true;
	}

	protected override void Execute()
	{
		m_WrappedOp = m_Callback(m_DepOp);
		m_WrappedOp.Completed += m_CachedOnWrappedCompleted;
		m_Callback = null;
	}

	private void OnWrappedCompleted(AsyncOperationHandle<TObject> x)
	{
		OperationException exception = null;
		if (x.Status == AsyncOperationStatus.Failed)
		{
			exception = new OperationException("ChainOperation failed because dependent operation failed", x.OperationException);
		}
		Complete(m_WrappedOp.Result, x.Status == AsyncOperationStatus.Succeeded, exception, m_ReleaseDependenciesOnFailure);
	}

	protected override void Destroy()
	{
		if (m_WrappedOp.IsValid())
		{
			m_WrappedOp.Release();
		}
		if (m_DepOp.IsValid())
		{
			m_DepOp.Release();
		}
	}

	internal override void ReleaseDependencies()
	{
		if (m_DepOp.IsValid())
		{
			m_DepOp.Release();
		}
	}

	internal override DownloadStatus GetDownloadStatus(HashSet<object> visited)
	{
		RefreshDownloadStatus(visited);
		return new DownloadStatus
		{
			DownloadedBytes = m_depStatus.DownloadedBytes + m_wrapStatus.DownloadedBytes,
			TotalBytes = m_depStatus.TotalBytes + m_wrapStatus.TotalBytes,
			IsDone = IsDone
		};
	}

	private void RefreshDownloadStatus(HashSet<object> visited = null)
	{
		m_depStatus = (m_DepOp.IsValid() ? m_DepOp.InternalGetDownloadStatus(visited) : m_depStatus);
		m_wrapStatus = (m_WrappedOp.IsValid() ? m_WrappedOp.InternalGetDownloadStatus(visited) : m_wrapStatus);
	}
}
