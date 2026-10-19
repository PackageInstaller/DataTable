using System.Collections.Generic;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;
using YooAsset;

namespace UnityEngine.Localization;

internal class YooAssetAllAssetsToAsyncOperationAdapter<TObject> : AsyncOperationBase<IList<TObject>> where TObject : class
{
	private AllAssetsHandle m_AllAssetsHandle;

	private bool m_IsCompleted;

	public void Init(AllAssetsHandle allAssetsHandle)
	{
		m_AllAssetsHandle = allAssetsHandle;
		m_IsCompleted = false;
	}

	protected override void Execute()
	{
		if (m_AllAssetsHandle == null || !m_AllAssetsHandle.IsValid)
		{
			Complete(null, success: false, "Invalid AllAssetsHandle");
		}
		else if (m_AllAssetsHandle.IsDone)
		{
			OnAllAssetsHandleCompleted(m_AllAssetsHandle);
		}
		else
		{
			m_AllAssetsHandle.Completed += OnAllAssetsHandleCompleted;
		}
	}

	private void OnAllAssetsHandleCompleted(AllAssetsHandle handle)
	{
		if (m_IsCompleted)
		{
			return;
		}
		m_IsCompleted = true;
		if (handle.Status == EOperationStatus.Succeed)
		{
			IReadOnlyList<Object> allAssetObjects = handle.AllAssetObjects;
			if (allAssetObjects != null)
			{
				List<TObject> list = new List<TObject>();
				foreach (Object item2 in allAssetObjects)
				{
					if (item2 is TObject item)
					{
						list.Add(item);
					}
				}
				Complete((IList<TObject>)list, true, (string)null);
			}
			else
			{
				Complete(null, success: false, "AllAssetObjects is null");
			}
		}
		else
		{
			Complete(null, success: false, handle.LastError);
		}
	}

	protected override void Destroy()
	{
		if (m_AllAssetsHandle != null && m_AllAssetsHandle.IsValid)
		{
			m_AllAssetsHandle.Release();
		}
		m_AllAssetsHandle = null;
		GenericPool<YooAssetAllAssetsToAsyncOperationAdapter<TObject>>.Release(this);
		base.Destroy();
	}

	protected override bool InvokeWaitForCompletion()
	{
		if (m_AllAssetsHandle != null && m_AllAssetsHandle.IsValid)
		{
			m_AllAssetsHandle.WaitForAsyncComplete();
			OnAllAssetsHandleCompleted(m_AllAssetsHandle);
		}
		return true;
	}
}
