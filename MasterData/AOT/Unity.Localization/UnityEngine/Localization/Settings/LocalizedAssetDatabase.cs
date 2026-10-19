using System;
using UnityEngine.Localization.Tables;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization.Settings;

[Serializable]
public class LocalizedAssetDatabase : LocalizedDatabase<AssetTable, AssetTableEntry>
{
	public AsyncOperationHandle<TObject> GetLocalizedAssetAsync<TObject>(TableEntryReference tableEntryReference, Locale locale = null, FallbackBehavior fallbackBehavior = FallbackBehavior.UseProjectSettings) where TObject : Object
	{
		return GetLocalizedAssetAsync<TObject>(GetDefaultTable(), tableEntryReference, locale, fallbackBehavior);
	}

	public TObject GetLocalizedAsset<TObject>(TableEntryReference tableEntryReference, Locale locale = null) where TObject : Object
	{
		return GetLocalizedAssetAsync<TObject>(GetDefaultTable(), tableEntryReference, locale).WaitForCompletion();
	}

	public virtual AsyncOperationHandle<TObject> GetLocalizedAssetAsync<TObject>(TableReference tableReference, TableEntryReference tableEntryReference, Locale locale = null, FallbackBehavior fallbackBehavior = FallbackBehavior.UseProjectSettings) where TObject : Object
	{
		return GetLocalizedAssetAsyncInternal<TObject>(tableReference, tableEntryReference, locale, fallbackBehavior);
	}

	public virtual TObject GetLocalizedAsset<TObject>(TableReference tableReference, TableEntryReference tableEntryReference, Locale locale = null) where TObject : Object
	{
		return GetLocalizedAssetAsyncInternal<TObject>(tableReference, tableEntryReference, locale).WaitForCompletion();
	}

	protected virtual AsyncOperationHandle<TObject> GetLocalizedAssetAsyncInternal<TObject>(TableReference tableReference, TableEntryReference tableEntryReference, Locale locale, FallbackBehavior fallbackBehavior = FallbackBehavior.UseProjectSettings) where TObject : Object
	{
		AsyncOperationHandle<TableEntryResult> tableEntryAsync = GetTableEntryAsync(tableReference, tableEntryReference, locale, fallbackBehavior);
		LoadAssetOperation<TObject> loadAssetOperation = GenericPool<LoadAssetOperation<TObject>>.Get();
		loadAssetOperation.Init(tableEntryAsync, autoRelease: true);
		loadAssetOperation.Dependency = tableEntryAsync;
		return AddressablesInterface.ResourceManager.StartOperation(loadAssetOperation, tableEntryAsync);
	}

	internal override void ReleaseTableContents(AssetTable table)
	{
		table.ReleaseAssets();
	}
}
