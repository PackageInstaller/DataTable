using System.Collections.Generic;
using System.Linq;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;
using YooAsset;

namespace UnityEngine.Localization;

internal class YooAssetListToAsyncOperationListAdapter<TObject> : AsyncOperationBase<IList<TObject>> where TObject : class
{
	private List<AssetHandle> m_AssetHandles;

	private List<TObject> m_Results;

	private int m_CompletedCount;

	private bool m_IsCompleted;

	private readonly object m_Lock = new object();

	public void Init(List<AssetHandle> assetHandles)
	{
		m_AssetHandles = new List<AssetHandle>(assetHandles);
		m_Results = new List<TObject>(new TObject[assetHandles.Count]);
		m_CompletedCount = 0;
		m_IsCompleted = false;
	}

	protected override void Execute()
	{
		if (m_AssetHandles == null || m_AssetHandles.Count == 0)
		{
			Complete((IList<TObject>)new List<TObject>(), true, (string)null);
			return;
		}
		for (int i = 0; i < m_AssetHandles.Count; i++)
		{
			AssetHandle assetHandle = m_AssetHandles[i];
			if (assetHandle == null || !assetHandle.IsValid)
			{
				Complete(null, success: false, $"Invalid AssetHandle at index {i}");
				break;
			}
			int index = i;
			if (assetHandle.IsDone)
			{
				OnAssetHandleCompleted(assetHandle, index);
				continue;
			}
			assetHandle.Completed += (AssetHandle h) =>
			{
				OnAssetHandleCompleted(h, index);
			};
		}
	}

	private void OnAssetHandleCompleted(AssetHandle handle, int index)
	{
		if (m_IsCompleted)
		{
			return;
		}
		lock (m_Lock)
		{
			if (!m_IsCompleted)
			{
				if (handle.Status == EOperationStatus.Succeed)
				{
					TObject value = handle.AssetObject as TObject;
					m_Results[index] = value;
				}
				else
				{
					m_Results[index] = null;
				}
				m_CompletedCount++;
				if (m_CompletedCount >= m_AssetHandles.Count)
				{
					CheckAndCompleteOperation();
				}
			}
		}
	}

	private void CheckAndCompleteOperation()
	{
		if (!m_IsCompleted)
		{
			m_IsCompleted = true;
			List<TObject> result = m_Results.Where((TObject r) => r != null).ToList();
			Complete((IList<TObject>)result, true, (string)null);
		}
	}

	protected override void Destroy()
	{
		if (m_AssetHandles != null)
		{
			foreach (AssetHandle assetHandle in m_AssetHandles)
			{
				if (assetHandle != null && assetHandle.IsValid)
				{
					assetHandle.Release();
				}
			}
			m_AssetHandles.Clear();
		}
		m_AssetHandles = null;
		m_Results = null;
		GenericPool<YooAssetListToAsyncOperationListAdapter<TObject>>.Release(this);
		base.Destroy();
	}

	protected override bool InvokeWaitForCompletion()
	{
		if (m_AssetHandles != null)
		{
			foreach (AssetHandle assetHandle in m_AssetHandles)
			{
				if (assetHandle != null && assetHandle.IsValid)
				{
					assetHandle.WaitForAsyncComplete();
				}
			}
			CheckAndCompleteOperation();
		}
		return true;
	}
}
