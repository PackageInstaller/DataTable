using System;
using System.Collections.Generic;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.Tables;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization;

internal class PreloadTablesOperation<TTable, TEntry> : WaitForCurrentOperationAsyncOperationBase<LocalizedDatabase<TTable, TEntry>> where TTable : DetailedLocalizationTable<TEntry> where TEntry : TableEntry
{
	private LocalizedDatabase<TTable, TEntry> m_Database;

	private readonly List<AsyncOperationHandle<TTable>> m_LoadTables = new List<AsyncOperationHandle<TTable>>();

	private readonly List<AsyncOperationHandle> m_LoadTablesOperation = new List<AsyncOperationHandle>();

	private readonly List<AsyncOperationHandle> m_PreloadTablesOperations = new List<AsyncOperationHandle>();

	private readonly Action<AsyncOperationHandle> m_LoadTableContentsAction;

	private readonly Action<AsyncOperationHandle> m_FinishPreloadingAction;

	private IList<TableReference> m_TableReferences;

	private Locale m_SelectedLocale;

	public PreloadTablesOperation()
	{
		m_LoadTableContentsAction = (AsyncOperationHandle a) =>
		{
			LoadTableContents();
		};
		m_FinishPreloadingAction = FinishPreloading;
	}

	public void Init(LocalizedDatabase<TTable, TEntry> database, IList<TableReference> tableReference, Locale locale = null)
	{
		m_Database = database;
		m_TableReferences = tableReference;
		m_SelectedLocale = locale;
	}

	protected override void Execute()
	{
		BeginPreloadingTables();
	}

	private void BeginPreloadingTables()
	{
		foreach (TableReference tableReference in m_TableReferences)
		{
			AsyncOperationHandle<TTable> tableAsync = m_Database.GetTableAsync(tableReference, m_SelectedLocale);
			m_LoadTables.Add(tableAsync);
			if (!tableAsync.IsDone)
			{
				m_LoadTablesOperation.Add(tableAsync);
			}
		}
		if (m_LoadTablesOperation.Count > 0)
		{
			AsyncOperationHandle<IList<AsyncOperationHandle>> asyncOperationHandle = AddressablesInterface.ResourceManager.CreateGenericGroupOperation(m_LoadTablesOperation);
			if (!asyncOperationHandle.IsDone)
			{
				CurrentOperation = asyncOperationHandle;
				asyncOperationHandle.CompletedTypeless += m_LoadTableContentsAction;
				return;
			}
		}
		LoadTableContents();
	}

	private void LoadTableContents()
	{
		foreach (AsyncOperationHandle<TTable> loadTable in m_LoadTables)
		{
			if (loadTable.Result == null)
			{
				Complete(null, success: false, "Table is null.");
				return;
			}
			if (loadTable.Result is IPreloadRequired preloadRequired)
			{
				m_PreloadTablesOperations.Add(preloadRequired.PreloadOperation);
			}
		}
		if (m_PreloadTablesOperations.Count == 0)
		{
			Complete(m_Database, true, (string)null);
			return;
		}
		AsyncOperationHandle<IList<AsyncOperationHandle>> asyncOperationHandle = AddressablesInterface.ResourceManager.CreateGenericGroupOperation(m_PreloadTablesOperations);
		if (!asyncOperationHandle.IsDone)
		{
			CurrentOperation = asyncOperationHandle;
			asyncOperationHandle.CompletedTypeless += m_FinishPreloadingAction;
		}
		else
		{
			FinishPreloading(asyncOperationHandle);
		}
	}

	private void FinishPreloading(AsyncOperationHandle op)
	{
		Complete(m_Database, op.Status == AsyncOperationStatus.Succeeded, (string)null);
	}

	protected override void Destroy()
	{
		base.Destroy();
		m_LoadTables.Clear();
		m_LoadTablesOperation.Clear();
		m_PreloadTablesOperations.Clear();
		m_TableReferences = null;
		GenericPool<PreloadTablesOperation<TTable, TEntry>>.Release(this);
	}
}
