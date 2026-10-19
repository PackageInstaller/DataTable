using System;
using UnityEngine.Localization.Settings;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization;

internal class LoadAssetOperation<TObject> : WaitForCurrentOperationAsyncOperationBase<TObject> where TObject : Object
{
	private readonly Action<AsyncOperationHandle<TObject>> m_AssetLoadedAction;

	private AsyncOperationHandle<LocalizedDatabase<UnityEngine.Localization.Tables.AssetTable, UnityEngine.Localization.Tables.AssetTableEntry>.TableEntryResult> m_TableEntryOperation;

	private bool m_AutoRelease;

	public LoadAssetOperation()
	{
		m_AssetLoadedAction = AssetLoaded;
	}

	public void Init(AsyncOperationHandle<LocalizedDatabase<UnityEngine.Localization.Tables.AssetTable, UnityEngine.Localization.Tables.AssetTableEntry>.TableEntryResult> loadTableEntryOperation, bool autoRelease)
	{
		m_TableEntryOperation = loadTableEntryOperation;
		AddressablesInterface.Acquire(m_TableEntryOperation);
		m_AutoRelease = autoRelease;
	}

	protected override void Execute()
	{
		if (m_TableEntryOperation.Status != AsyncOperationStatus.Succeeded)
		{
			Complete(null, success: false, "Load Table Entry Operation Failed");
			AddressablesInterface.Release(m_TableEntryOperation);
			return;
		}
		if (m_TableEntryOperation.Result.Table == null || m_TableEntryOperation.Result.Entry == null)
		{
			CompleteAndRelease(null, success: true, null);
			return;
		}
		AsyncOperationHandle<TObject> assetAsync = m_TableEntryOperation.Result.Table.GetAssetAsync<TObject>(m_TableEntryOperation.Result.Entry);
		if (assetAsync.IsDone)
		{
			AssetLoaded(assetAsync);
			return;
		}
		CurrentOperation = assetAsync;
		assetAsync.Completed += m_AssetLoadedAction;
	}

	private void AssetLoaded(AsyncOperationHandle<TObject> handle)
	{
		if (handle.Status != AsyncOperationStatus.Succeeded)
		{
			CompleteAndRelease(null, success: false, "GetAssetAsync failed to load the asset.");
		}
		else
		{
			CompleteAndRelease(handle.Result, success: true, null);
		}
	}

	public void CompleteAndRelease(TObject result, bool success, string errorMsg)
	{
		Complete(result, success, errorMsg);
		AddressablesInterface.Release(m_TableEntryOperation);
		if (m_AutoRelease && LocalizationSettings.Instance.IsPlaying)
		{
			LocalizationBehaviour.ReleaseNextFrame(Handle);
		}
	}

	protected override void Destroy()
	{
		base.Destroy();
		GenericPool<LoadAssetOperation<TObject>>.Release(this);
	}
}
