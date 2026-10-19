using System;
using System.Collections.Generic;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.Tables;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;
using YooAsset;

namespace UnityEngine.Localization;

internal class PreloadDatabaseOperation<TTable, TEntry> : WaitForCurrentOperationAsyncOperationBase<LocalizedDatabase<TTable, TEntry>> where TTable : DetailedLocalizationTable<TEntry> where TEntry : TableEntry
{
	private readonly Action<AsyncOperationHandle<TTable>> m_LoadTableContentsAction;

	private readonly Action<AsyncOperationHandle> m_FinishPreloadingAction;

	private readonly Action<AsyncOperationHandle<IList<AsyncOperationHandle>>> m_PreloadTablesCompletedAction;

	private LocalizedDatabase<TTable, TEntry> m_Database;

	private readonly List<AsyncOperationHandle> m_LoadTablesOperations = new List<AsyncOperationHandle>();

	private readonly List<AsyncOperationHandle> m_PreloadTableContentsOperations = new List<AsyncOperationHandle>();

	private readonly List<string> m_ResourceLabels = new List<string>();

	private float m_Progress;

	protected override float Progress => m_Progress;

	protected override string DebugName => $"Preload {m_Database.GetType()}";

	public PreloadDatabaseOperation()
	{
		m_LoadTableContentsAction = LoadTableContents;
		m_FinishPreloadingAction = FinishPreloading;
		m_PreloadTablesCompletedAction = PreloadTablesCompleted;
	}

	public void Init(LocalizedDatabase<TTable, TEntry> database)
	{
		m_Database = database;
		m_LoadTablesOperations.Clear();
		m_PreloadTableContentsOperations.Clear();
	}

	protected override void Execute()
	{
		BeginPreloading();
	}

	private void BeginPreloading()
	{
		Locale selectedLocale = LocalizationSettings.SelectedLocale;
		if (selectedLocale == null)
		{
			Complete(m_Database, true, (string)null);
			return;
		}
		m_Progress = 0f;
		string item = AddressHelper.FormatAssetLabel(selectedLocale.Identifier);
		m_ResourceLabels.Clear();
		m_ResourceLabels.Add(item);
		m_ResourceLabels.Add(typeof(TTable).Name);
		IList<AssetInfo> assetInfos = AddressablesInterface.LoadResourceLocationsWithLabelsAsync(m_ResourceLabels, typeof(TTable));
		LoadTables(assetInfos);
	}

	private void LoadTables(IList<AssetInfo> assetInfos)
	{
		if (assetInfos == null)
		{
			Complete(m_Database, success: false, "Failed to locate preload tables.");
			return;
		}
		if (assetInfos.Count == 0)
		{
			m_Progress = 1f;
			Complete(m_Database, true, (string)null);
			return;
		}
		foreach (AssetInfo assetInfo in assetInfos)
		{
			AsyncOperationHandle<TTable> asyncOperationHandle = AddressablesInterface.LoadTableFromLocation<TTable>(assetInfo);
			m_LoadTablesOperations.Add(asyncOperationHandle);
			if (asyncOperationHandle.IsDone)
			{
				LoadTableContents(asyncOperationHandle);
			}
			else
			{
				asyncOperationHandle.Completed += m_LoadTableContentsAction;
			}
		}
		AsyncOperationHandle<IList<AsyncOperationHandle>> asyncOperationHandle2 = AddressablesInterface.ResourceManager.CreateGenericGroupOperation(m_LoadTablesOperations, releasedCachedOpOnComplete: true);
		if (asyncOperationHandle2.IsDone)
		{
			PreloadTablesCompleted(asyncOperationHandle2);
			return;
		}
		CurrentOperation = asyncOperationHandle2;
		asyncOperationHandle2.Completed += m_PreloadTablesCompletedAction;
	}

	private void LoadTableContents(AsyncOperationHandle<TTable> operation)
	{
		m_Progress += 1f / (float)m_LoadTablesOperations.Count;
		if (operation.Result == null)
		{
			return;
		}
		TTable result = operation.Result;
		string tableCollectionName = result.TableCollectionName;
		if (m_Database.TableOperations.TryGetValue((result.LocaleIdentifier, tableCollectionName), out var value))
		{
			AddressablesInterface.Release(operation);
			if (value.IsDone && (object)value.Result != result)
			{
				Debug.LogError($"A table with the same key `{tableCollectionName}` already exists. Something went wrong during preloading. Table {result} does not match {value.Result}.");
				return;
			}
		}
		else
		{
			m_Database.RegisterTableOperation(operation, result.LocaleIdentifier, tableCollectionName);
		}
		if (result is IPreloadRequired { PreloadOperation: { IsDone: false } preloadOperation })
		{
			m_PreloadTableContentsOperations.Add(preloadOperation);
		}
	}

	private void PreloadTablesCompleted(AsyncOperationHandle<IList<AsyncOperationHandle>> obj)
	{
		if (m_PreloadTableContentsOperations.Count == 0)
		{
			Complete(m_Database, true, (string)null);
			return;
		}
		AsyncOperationHandle<IList<AsyncOperationHandle>> asyncOperationHandle = AddressablesInterface.ResourceManager.CreateGenericGroupOperation(m_PreloadTableContentsOperations);
		if (asyncOperationHandle.IsDone)
		{
			FinishPreloading(asyncOperationHandle);
			return;
		}
		CurrentOperation = asyncOperationHandle;
		asyncOperationHandle.CompletedTypeless += m_FinishPreloadingAction;
	}

	private void FinishPreloading(AsyncOperationHandle op)
	{
		m_Progress = 1f;
		Complete(m_Database, op.Status == AsyncOperationStatus.Succeeded, (string)null);
	}

	protected override void Destroy()
	{
		base.Destroy();
		GenericPool<PreloadDatabaseOperation<TTable, TEntry>>.Release(this);
	}
}
