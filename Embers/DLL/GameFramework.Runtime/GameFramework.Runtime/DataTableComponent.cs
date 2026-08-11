#define ENABLE_FATAL_AND_ABOVE_LOG
#define ENABLE_ERROR_AND_ABOVE_LOG
#define ENABLE_ERROR_LOG
using System;
using System.Collections.Generic;
using GameFramework.DataTable;
using GameFramework.Resource;
using UnityEngine;

namespace GameFramework.Runtime;

[DisallowMultipleComponent]
[AddComponentMenu("Game Framework/Data Table")]
public sealed class DataTableComponent : GameFrameworkComponent
{
	private const int DefaultPriority = 0;

	private IDataTableManager m_DataTableManager = null;

	[SerializeField]
	private bool m_EnableLoadDataTableUpdateEvent = false;

	[SerializeField]
	private bool m_EnableLoadDataTableDependencyAssetEvent = false;

	[SerializeField]
	private string m_DataTableHelperTypeName = "UnityGameFramework.Runtime.DefaultDataTableHelper";

	[SerializeField]
	private DataTableHelperBase m_CustomDataTableHelper = null;

	[SerializeField]
	private int m_CachedBytesSize = 0;

	public int Count => m_DataTableManager.Count;

	public int CachedBytesSize => m_DataTableManager.CachedBytesSize;

	protected override void Awake()
	{
		base.Awake();
		m_DataTableManager = GameFrameworkEntry.GetModule<IDataTableManager>();
		if (m_DataTableManager == null)
		{
			Log.Fatal("Data table manager is invalid.");
		}
	}

	public override void Init()
	{
		BaseComponent component = GameEntryRuntime.GetComponent<BaseComponent>();
		if (component == null)
		{
			Log.Fatal("Base component is invalid.");
			return;
		}
		m_DataTableManager.SetResourceManager(GameFrameworkEntry.GetModule<IResourceManager>());
		DataTableHelperBase dataTableHelperBase = Helper.CreateHelper(m_DataTableHelperTypeName, m_CustomDataTableHelper);
		if (dataTableHelperBase == null)
		{
			Log.Error("Can not create data table helper.");
			return;
		}
		dataTableHelperBase.name = "Data Table Helper";
		Transform transform = dataTableHelperBase.transform;
		transform.SetParent(base.transform);
		transform.localScale = Vector3.one;
		m_DataTableManager.SetDataProviderHelper(dataTableHelperBase);
		m_DataTableManager.SetDataTableHelper(dataTableHelperBase);
		if (m_CachedBytesSize > 0)
		{
			EnsureCachedBytesSize(m_CachedBytesSize);
		}
	}

	public void EnsureCachedBytesSize(int ensureSize)
	{
		m_DataTableManager.EnsureCachedBytesSize(ensureSize);
	}

	public void FreeCachedBytes()
	{
		m_DataTableManager.FreeCachedBytes();
	}

	public bool HasDataTable<T>() where T : IDataRow
	{
		return m_DataTableManager.HasDataTable<T>();
	}

	public bool HasDataTable(Type dataRowType)
	{
		return m_DataTableManager.HasDataTable(dataRowType);
	}

	public bool HasDataTable<T>(string name) where T : IDataRow
	{
		return m_DataTableManager.HasDataTable<T>(name);
	}

	public bool HasDataTable(Type dataRowType, string name)
	{
		return m_DataTableManager.HasDataTable(dataRowType, name);
	}

	public IDataTable<T> GetDataTable<T>() where T : IDataRow
	{
		return m_DataTableManager.GetDataTable<T>();
	}

	public DataTableBase GetDataTable(Type dataRowType)
	{
		return m_DataTableManager.GetDataTable(dataRowType);
	}

	public IDataTable<T> GetDataTable<T>(string name) where T : IDataRow
	{
		return m_DataTableManager.GetDataTable<T>(name);
	}

	public DataTableBase GetDataTable(Type dataRowType, string name)
	{
		return m_DataTableManager.GetDataTable(dataRowType, name);
	}

	public DataTableBase[] GetAllDataTables()
	{
		return m_DataTableManager.GetAllDataTables();
	}

	public void GetAllDataTables(List<DataTableBase> results)
	{
		m_DataTableManager.GetAllDataTables(results);
	}

	public T GetDataRow<T>(int id) where T : IDataRow
	{
		IDataTable<T> dataTable = GetDataTable<T>();
		if (dataTable == null)
		{
			Log.Error($"没有找到表[{typeof(T)}的配置.[{id}].]");
			return default(T);
		}
		return dataTable.GetDataRow(id);
	}

	public T[] GetAllDataRow<T>() where T : IDataRow
	{
		IDataTable<T> dataTable = GetDataTable<T>();
		if (dataTable == null)
		{
			Log.Error($"没有找到表[{typeof(T)}的配置.]");
			return null;
		}
		return dataTable.GetAllDataRows();
	}

	public T GetDataRow<T>(Predicate<T> condition) where T : IDataRow
	{
		IDataTable<T> dataTable = GetDataTable<T>();
		if (dataTable == null)
		{
			Debug.Log($"没有找到表[{typeof(T)}的配置..]");
			return default(T);
		}
		return dataTable.GetDataRow(condition);
	}

	public T[] GetDataRows<T>(Predicate<T> condition) where T : IDataRow
	{
		IDataTable<T> dataTable = GetDataTable<T>();
		if (dataTable == null)
		{
			Debug.Log($"没有找到表[{typeof(T)}的配置..]");
			return null;
		}
		return dataTable.GetDataRows(condition);
	}

	public IDataTable<T> CreateDataTable<T>() where T : class, IDataRow, new()
	{
		return CreateDataTable<T>(null);
	}

	public DataTableBase CreateDataTable(Type dataRowType)
	{
		return CreateDataTable(dataRowType, null);
	}

	public IDataTable<T> CreateDataTable<T>(string tableName) where T : class, IDataRow, new()
	{
		IDataTable<T> dataTable = m_DataTableManager.CreateDataTable<T>(tableName);
		DataTableBase dataTableBase = (DataTableBase)dataTable;
		dataTableBase.ReadDataSuccess += OnReadDataSuccess;
		dataTableBase.ReadDataFailure += OnReadDataFailure;
		if (m_EnableLoadDataTableUpdateEvent)
		{
			dataTableBase.ReadDataUpdate += OnReadDataUpdate;
		}
		if (m_EnableLoadDataTableDependencyAssetEvent)
		{
			dataTableBase.ReadDataDependencyAsset += OnReadDataDependencyAsset;
		}
		return dataTable;
	}

	public DataTableBase CreateDataTable(Type dataRowType, string tableName)
	{
		DataTableBase dataTableBase = m_DataTableManager.CreateDataTable(dataRowType, tableName);
		dataTableBase.ReadDataSuccess += OnReadDataSuccess;
		dataTableBase.ReadDataFailure += OnReadDataFailure;
		if (m_EnableLoadDataTableUpdateEvent)
		{
			dataTableBase.ReadDataUpdate += OnReadDataUpdate;
		}
		if (m_EnableLoadDataTableDependencyAssetEvent)
		{
			dataTableBase.ReadDataDependencyAsset += OnReadDataDependencyAsset;
		}
		return dataTableBase;
	}

	public bool DestroyDataTable<T>() where T : IDataRow, new()
	{
		return m_DataTableManager.DestroyDataTable<T>();
	}

	public bool DestroyDataTable(Type dataRowType)
	{
		return m_DataTableManager.DestroyDataTable(dataRowType);
	}

	public bool DestroyDataTable<T>(string name) where T : IDataRow
	{
		return m_DataTableManager.DestroyDataTable<T>(name);
	}

	public bool DestroyDataTable(Type dataRowType, string name)
	{
		return m_DataTableManager.DestroyDataTable(dataRowType, name);
	}

	public bool DestroyDataTable<T>(IDataTable<T> dataTable) where T : IDataRow
	{
		return m_DataTableManager.DestroyDataTable(dataTable);
	}

	public bool DestroyDataTable(DataTableBase dataTable)
	{
		return m_DataTableManager.DestroyDataTable(dataTable);
	}

	private void OnReadDataSuccess(object sender, ReadDataSuccessEventArgs e)
	{
	}

	private void OnReadDataFailure(object sender, ReadDataFailureEventArgs e)
	{
		Log.Error("Load data table failure, asset name '{0}', error message '{1}'.", e.DataAssetName, e.ErrorMessage);
	}

	private void OnReadDataUpdate(object sender, ReadDataUpdateEventArgs e)
	{
	}

	private void OnReadDataDependencyAsset(object sender, ReadDataDependencyAssetEventArgs e)
	{
	}
}
