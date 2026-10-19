using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;
using YooAsset;

namespace UnityEngine.Localization;

internal class YooAssetToAsyncOperationAdapter<TObject> : AsyncOperationBase<TObject> where TObject : class
{
	private AssetHandle m_AssetHandle;

	private bool m_IsCompleted;

	public void Init(AssetHandle assetHandle)
	{
		m_AssetHandle = assetHandle;
		m_IsCompleted = false;
	}

	protected override void Execute()
	{
		if (m_AssetHandle == null || !m_AssetHandle.IsValid)
		{
			Complete(null, success: false, "Invalid AssetHandle");
		}
		else if (m_AssetHandle.IsDone)
		{
			OnAssetHandleCompleted(m_AssetHandle);
		}
		else
		{
			m_AssetHandle.Completed += OnAssetHandleCompleted;
		}
	}

	private void OnAssetHandleCompleted(AssetHandle handle)
	{
		if (m_IsCompleted)
		{
			return;
		}
		m_IsCompleted = true;
		if (handle.Status == EOperationStatus.Succeed)
		{
			if (handle.AssetObject is TObject result)
			{
				Complete(result, true, (string)null);
			}
			else
			{
				Complete(null, success: false, "Failed to cast asset to type " + typeof(TObject).Name);
			}
		}
		else
		{
			Complete(null, success: false, handle.LastError);
		}
	}

	protected override void Destroy()
	{
		if (m_AssetHandle != null && m_AssetHandle.IsValid)
		{
			m_AssetHandle.Release();
		}
		m_AssetHandle = null;
		GenericPool<YooAssetToAsyncOperationAdapter<TObject>>.Release(this);
		base.Destroy();
	}

	protected override bool InvokeWaitForCompletion()
	{
		if (m_AssetHandle != null && m_AssetHandle.IsValid)
		{
			m_AssetHandle.WaitForAsyncComplete();
			OnAssetHandleCompleted(m_AssetHandle);
		}
		return true;
	}
}
