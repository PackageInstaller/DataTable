using System;
using System.Collections.Generic;
using UnityEngine.ResourceManagement.ResourceLocations;
using UnityEngine.ResourceManagement.ResourceProviders;
using UnityEngine.ResourceManagement.Util;
using UnityEngine.Scripting;

namespace UnityEngine.ResourceManagement.AsyncOperations;

[Preserve]
internal class ProviderOperation<TObject> : AsyncOperationBase<TObject>, IGenericProviderOperation, ICachable
{
	private bool m_ReleaseDependenciesOnFailure = true;

	private Func<float> m_GetProgressCallback;

	private Func<DownloadStatus> m_GetDownloadProgressCallback;

	private Func<bool> m_WaitForCompletionCallback;

	private bool m_ProviderCompletedCalled;

	private DownloadStatus m_DownloadStatus;

	private IResourceProvider m_Provider;

	internal AsyncOperationHandle<IList<AsyncOperationHandle>> m_DepOp;

	private IResourceLocation m_Location;

	private int m_ProvideHandleVersion;

	private bool m_NeedsRelease;

	private ResourceManager m_ResourceManager;

	private const float k_OperationWaitingToCompletePercentComplete = 0.99f;

	internal const string kInvalidHandleMsg = "The ProvideHandle is invalid. After the handle has been completed, it can no longer be used";

	IOperationCacheKey ICachable.Key { get; set; }

	public int ProvideHandleVersion => m_ProvideHandleVersion;

	public IResourceLocation Location => m_Location;

	protected override string DebugName => string.Format("Resource<{0}>({1})", typeof(TObject).Name, (m_Location == null) ? "Invalid" : AsyncOperationBase<TObject>.ShortenPath(m_Location.InternalId, keepExtension: true));

	public Type RequestedType => typeof(TObject);

	public int DependencyCount
	{
		get
		{
			if (m_DepOp.IsValid() && m_DepOp.Result != null)
			{
				return m_DepOp.Result.Count;
			}
			return 0;
		}
	}

	protected override float Progress
	{
		get
		{
			try
			{
				float num = 1f;
				float num2 = 0f;
				if (m_GetProgressCallback != null)
				{
					num2 += m_GetProgressCallback();
				}
				if (!m_DepOp.IsValid() || m_DepOp.Result == null || m_DepOp.Result.Count == 0)
				{
					num2++;
					num++;
				}
				else
				{
					foreach (AsyncOperationHandle item in m_DepOp.Result)
					{
						num2 += item.PercentComplete;
						num++;
					}
				}
				return Mathf.Min(num2 / num, 0.99f);
			}
			catch
			{
				return 0f;
			}
		}
	}

	public void SetDownloadProgressCallback(Func<DownloadStatus> callback)
	{
		m_GetDownloadProgressCallback = callback;
		if (m_GetDownloadProgressCallback != null)
		{
			m_DownloadStatus = m_GetDownloadProgressCallback();
		}
	}

	public void SetWaitForCompletionCallback(Func<bool> callback)
	{
		m_WaitForCompletionCallback = callback;
	}

	protected override bool InvokeWaitForCompletion()
	{
		if (IsDone || m_ProviderCompletedCalled)
		{
			return true;
		}
		if (m_DepOp.IsValid() && !m_DepOp.IsDone)
		{
			m_DepOp.WaitForCompletion();
		}
		m_RM?.Update(Time.unscaledDeltaTime);
		if (!HasExecuted)
		{
			InvokeExecute();
		}
		if (m_WaitForCompletionCallback == null)
		{
			return false;
		}
		return m_WaitForCompletionCallback();
	}

	internal override DownloadStatus GetDownloadStatus(HashSet<object> visited)
	{
		DownloadStatus downloadStatus = (m_DepOp.IsValid() ? m_DepOp.InternalGetDownloadStatus(visited) : default(DownloadStatus));
		if (m_GetDownloadProgressCallback != null)
		{
			m_DownloadStatus = m_GetDownloadProgressCallback();
		}
		if (Status == AsyncOperationStatus.Succeeded)
		{
			m_DownloadStatus.DownloadedBytes = m_DownloadStatus.TotalBytes;
		}
		return new DownloadStatus
		{
			DownloadedBytes = m_DownloadStatus.DownloadedBytes + downloadStatus.DownloadedBytes,
			TotalBytes = m_DownloadStatus.TotalBytes + downloadStatus.TotalBytes,
			IsDone = IsDone
		};
	}

	public override void GetDependencies(List<AsyncOperationHandle> deps)
	{
		if (m_DepOp.IsValid())
		{
			deps.Add(m_DepOp);
		}
	}

	internal override void ReleaseDependencies()
	{
		if (m_DepOp.IsValid())
		{
			m_DepOp.Release();
		}
	}

	public void GetDependencies(IList<object> dstList)
	{
		dstList.Clear();
		if (m_DepOp.IsValid() && m_DepOp.Result != null)
		{
			for (int i = 0; i < m_DepOp.Result.Count; i++)
			{
				dstList.Add(m_DepOp.Result[i].Result);
			}
		}
	}

	public TDepObject GetDependency<TDepObject>(int index)
	{
		if (!m_DepOp.IsValid() || m_DepOp.Result == null)
		{
			throw new Exception("Cannot get dependency because no dependencies were available");
		}
		return (TDepObject)m_DepOp.Result[index].Result;
	}

	public void SetProgressCallback(Func<float> callback)
	{
		m_GetProgressCallback = callback;
	}

	public void ProviderCompleted<T>(T result, bool status, Exception e)
	{
		m_ProvideHandleVersion++;
		m_GetProgressCallback = null;
		m_GetDownloadProgressCallback = null;
		m_WaitForCompletionCallback = null;
		m_NeedsRelease = status;
		m_ProviderCompletedCalled = true;
		if (this is ProviderOperation<T> providerOperation)
		{
			providerOperation.Result = result;
		}
		else if (result == null && !typeof(TObject).IsValueType)
		{
			Result = (TObject)(object)null;
		}
		else
		{
			if (result == null || !typeof(TObject).IsAssignableFrom(result.GetType()))
			{
				string text = $"Provider of type {m_Provider.GetType().ToString()} with id {m_Provider.ProviderId} has provided a result of type {typeof(T)} which cannot be converted to requested type {typeof(TObject)}. The operation will be marked as failed.";
				Complete(Result, success: false, text);
				throw new Exception(text);
			}
			Result = (TObject)(object)result;
		}
		Complete(Result, status, e, m_ReleaseDependenciesOnFailure);
	}

	protected override void Execute()
	{
		if (m_DepOp.IsValid() && m_DepOp.Status == AsyncOperationStatus.Failed && (m_Provider.BehaviourFlags & ProviderBehaviourFlags.CanProvideWithFailedDependencies) == 0)
		{
			ProviderCompleted<TObject>(default, status: false, new Exception("Dependency Exception", m_DepOp.OperationException));
			return;
		}
		try
		{
			m_Provider.Provide(new ProvideHandle(m_ResourceManager, this));
		}
		catch (Exception e)
		{
			ProviderCompleted<TObject>(default, status: false, e);
		}
	}

	public void Init(ResourceManager rm, IResourceProvider provider, IResourceLocation location, AsyncOperationHandle<IList<AsyncOperationHandle>> depOp)
	{
		m_DownloadStatus = default;
		m_ResourceManager = rm;
		m_DepOp = depOp;
		if (m_DepOp.IsValid())
		{
			m_DepOp.Acquire();
		}
		m_Provider = provider;
		m_Location = location;
		m_ReleaseDependenciesOnFailure = true;
		m_ProviderCompletedCalled = false;
		SetWaitForCompletionCallback(WaitForCompletionHandler);
	}

	public void Init(ResourceManager rm, IResourceProvider provider, IResourceLocation location, AsyncOperationHandle<IList<AsyncOperationHandle>> depOp, bool releaseDependenciesOnFailure)
	{
		m_DownloadStatus = default;
		m_ResourceManager = rm;
		m_DepOp = depOp;
		if (m_DepOp.IsValid())
		{
			m_DepOp.Acquire();
		}
		m_Provider = provider;
		m_Location = location;
		m_ReleaseDependenciesOnFailure = releaseDependenciesOnFailure;
		m_ProviderCompletedCalled = false;
		SetWaitForCompletionCallback(WaitForCompletionHandler);
	}

	private bool WaitForCompletionHandler()
	{
		if (IsDone)
		{
			return true;
		}
		if (!m_DepOp.IsDone)
		{
			m_DepOp.WaitForCompletion();
		}
		if (!HasExecuted)
		{
			InvokeExecute();
		}
		return IsDone;
	}

	protected override void Destroy()
	{
		if (m_NeedsRelease)
		{
			m_Provider.Release(m_Location, Result);
		}
		if (m_DepOp.IsValid())
		{
			m_DepOp.Release();
		}
		Result = default;
		m_Location = null;
	}
}
