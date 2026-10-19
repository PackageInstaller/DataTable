using System.Collections.Generic;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;
using YooAsset;

namespace UnityEngine.Localization;

internal class YooAssetSubAssetsToAsyncOperationAdapter<TObject> : AsyncOperationBase<IList<TObject>> where TObject : class
{
	private SubAssetsHandle m_SubAssetsHandle;

	private bool m_IsCompleted;

	public void Init(SubAssetsHandle subAssetsHandle)
	{
		m_SubAssetsHandle = subAssetsHandle;
		m_IsCompleted = false;
	}

	protected override void Execute()
	{
		if (m_SubAssetsHandle == null || !m_SubAssetsHandle.IsValid)
		{
			Complete(null, success: false, "Invalid SubAssetsHandle");
		}
		else if (m_SubAssetsHandle.IsDone)
		{
			OnSubAssetsHandleCompleted(m_SubAssetsHandle);
		}
		else
		{
			m_SubAssetsHandle.Completed += OnSubAssetsHandleCompleted;
		}
	}

	private void OnSubAssetsHandleCompleted(SubAssetsHandle handle)
	{
		if (m_IsCompleted)
		{
			return;
		}
		m_IsCompleted = true;
		if (handle.Status == EOperationStatus.Succeed)
		{
			IReadOnlyList<Object> subAssetObjects = handle.SubAssetObjects;
			if (subAssetObjects != null)
			{
				List<TObject> list = new List<TObject>();
				foreach (Object item2 in subAssetObjects)
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
				Complete(null, success: false, "SubAssetObjects is null");
			}
		}
		else
		{
			Complete(null, success: false, handle.LastError);
		}
	}

	protected override void Destroy()
	{
		if (m_SubAssetsHandle != null && m_SubAssetsHandle.IsValid)
		{
			m_SubAssetsHandle.Release();
		}
		m_SubAssetsHandle = null;
		GenericPool<YooAssetSubAssetsToAsyncOperationAdapter<TObject>>.Release(this);
		base.Destroy();
	}

	protected override bool InvokeWaitForCompletion()
	{
		if (m_SubAssetsHandle != null && m_SubAssetsHandle.IsValid)
		{
			m_SubAssetsHandle.WaitForAsyncComplete();
			OnSubAssetsHandleCompleted(m_SubAssetsHandle);
		}
		return true;
	}
}
