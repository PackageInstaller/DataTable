using System;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.Tables;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;
using YooAsset;

namespace UnityEngine.Localization;

internal class LoadTableOperation<TTable, TEntry> : WaitForCurrentOperationAsyncOperationBase<TTable> where TTable : DetailedLocalizationTable<TEntry> where TEntry : TableEntry
{
	private readonly Action<AsyncOperationHandle<SharedTableData>> m_LoadTableByGuidAction;

	private readonly Action<AsyncOperationHandle<TTable>> m_TableLoadedAction;

	private LocalizedDatabase<TTable, TEntry> m_Database;

	private TableReference m_TableReference;

	private AsyncOperationHandle<TTable> m_LoadTableOperation;

	private Locale m_SelectedLocale;

	private string m_CollectionName;

	public Action<AsyncOperationHandle<TTable>> RegisterTableOperation { get; private set; }

	public LoadTableOperation()
	{
		RegisterTableOperation = RegisterTableOperationInternal;
		m_LoadTableByGuidAction = LoadTableByGuid;
		m_TableLoadedAction = TableLoaded;
	}

	public void Init(LocalizedDatabase<TTable, TEntry> database, TableReference tableReference, Locale locale)
	{
		m_Database = database;
		m_TableReference = tableReference;
		m_SelectedLocale = locale;
	}

	protected override void Execute()
	{
		if (m_SelectedLocale == null)
		{
			m_SelectedLocale = LocalizationSettings.SelectedLocale;
			if (m_SelectedLocale == null)
			{
				Complete(null, success: false, "SelectedLocale is null. Could not load table.");
				return;
			}
		}
		if (m_TableReference.ReferenceType == TableReference.Type.Guid)
		{
			AsyncOperationHandle<SharedTableData> sharedTableData = m_Database.GetSharedTableData(m_TableReference.TableCollectionNameGuid);
			if (sharedTableData.IsDone)
			{
				LoadTableByGuid(sharedTableData);
				return;
			}
			CurrentOperation = sharedTableData;
			sharedTableData.Completed += m_LoadTableByGuidAction;
		}
		else
		{
			FindTableByName(m_TableReference.TableCollectionName);
		}
	}

	private void LoadTableByGuid(AsyncOperationHandle<SharedTableData> operationHandle)
	{
		if (operationHandle.Status == AsyncOperationStatus.Succeeded)
		{
			FindTableByName(operationHandle.Result.TableCollectionName);
		}
		else
		{
			Complete(null, success: false, $"Failed to extract table name from shared table data {m_TableReference}. Load Shared Table data operation failed.");
		}
	}

	private void FindTableByName(string collectionName)
	{
		m_CollectionName = collectionName;
		AssetInfo assetInfo = AddressablesInterface.LoadTableLocationsAsync(m_CollectionName, m_SelectedLocale.Identifier, typeof(TTable));
		LoadTableResource(assetInfo);
	}

	private void LoadTableResource(AssetInfo assetInfo)
	{
		if (assetInfo == null || assetInfo.IsInvalid)
		{
			Complete(null, success: true, $"Could not find a {m_SelectedLocale} table with the name '{m_CollectionName}`");
			return;
		}
		m_LoadTableOperation = AddressablesInterface.LoadTableFromLocation<TTable>(assetInfo);
		if (m_LoadTableOperation.IsDone)
		{
			TableLoaded(m_LoadTableOperation);
			return;
		}
		CurrentOperation = m_LoadTableOperation;
		m_LoadTableOperation.Completed += m_TableLoadedAction;
	}

	private void TableLoaded(AsyncOperationHandle<TTable> operationHandle)
	{
		Complete(operationHandle.Result, operationHandle.Status == AsyncOperationStatus.Succeeded, (string)null);
	}

	private void RegisterTableOperationInternal(AsyncOperationHandle<TTable> handle)
	{
		if (handle.Status == AsyncOperationStatus.Succeeded)
		{
			m_Database.RegisterTableOperation(handle, m_SelectedLocale.Identifier, m_CollectionName);
		}
	}

	protected override void Destroy()
	{
		base.Destroy();
		AddressablesInterface.SafeRelease(m_LoadTableOperation);
		m_LoadTableOperation = default;
		GenericPool<LoadTableOperation<TTable, TEntry>>.Release(this);
	}
}
