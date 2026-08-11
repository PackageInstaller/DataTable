using System;
using System.Collections;
using System.Collections.Generic;
using GameFramework.Resource;

namespace GameFramework.DataTable;

internal sealed class DataTableManager : GameFrameworkModule, IDataTableManager
{
	private sealed class DataTable<T> : DataTableBase, IDataTable<T>, IEnumerable<T>, IEnumerable where T : class, IDataRow, new()
	{
		private readonly Dictionary<int, T> m_DataSet;

		private T m_MinIdDataRow;

		private T m_MaxIdDataRow;

		public override Type Type => typeof(T);

		public override int Count => m_DataSet.Count;

		public T this[int id] => GetDataRow(id);

		public T MinIdDataRow => m_MinIdDataRow;

		public T MaxIdDataRow => m_MaxIdDataRow;

		public DataTable(string name)
			: base(name)
		{
			m_DataSet = new Dictionary<int, T>();
			m_MinIdDataRow = null;
			m_MaxIdDataRow = null;
		}

		public override bool HasDataRow(int id)
		{
			return m_DataSet.ContainsKey(id);
		}

		public bool HasDataRow(Predicate<T> condition)
		{
			if (condition == null)
			{
				throw new GameFrameworkException("Condition is invalid.");
			}
			foreach (KeyValuePair<int, T> item in m_DataSet)
			{
				if (condition(item.Value))
				{
					return true;
				}
			}
			return false;
		}

		public T GetDataRow(int id)
		{
			T value = null;
			if (m_DataSet.TryGetValue(id, out value))
			{
				return value;
			}
			return null;
		}

		public T GetDataRow(Predicate<T> condition)
		{
			if (condition == null)
			{
				throw new GameFrameworkException("Condition is invalid.");
			}
			foreach (KeyValuePair<int, T> item in m_DataSet)
			{
				if (condition(item.Value))
				{
					return item.Value;
				}
			}
			return null;
		}

		public T[] GetDataRows(Predicate<T> condition)
		{
			if (condition == null)
			{
				throw new GameFrameworkException("Condition is invalid.");
			}
			List<T> list = new List<T>();
			foreach (KeyValuePair<int, T> item in m_DataSet)
			{
				if (condition(item.Value))
				{
					list.Add(item.Value);
				}
			}
			return list.ToArray();
		}

		public void GetDataRows(Predicate<T> condition, List<T> results)
		{
			if (condition == null)
			{
				throw new GameFrameworkException("Condition is invalid.");
			}
			if (results == null)
			{
				throw new GameFrameworkException("Results is invalid.");
			}
			results.Clear();
			foreach (KeyValuePair<int, T> item in m_DataSet)
			{
				if (condition(item.Value))
				{
					results.Add(item.Value);
				}
			}
		}

		public T[] GetDataRows(Comparison<T> comparison)
		{
			if (comparison == null)
			{
				throw new GameFrameworkException("Comparison is invalid.");
			}
			List<T> list = new List<T>();
			foreach (KeyValuePair<int, T> item in m_DataSet)
			{
				list.Add(item.Value);
			}
			list.Sort(comparison);
			return list.ToArray();
		}

		public void GetDataRows(Comparison<T> comparison, List<T> results)
		{
			if (comparison == null)
			{
				throw new GameFrameworkException("Comparison is invalid.");
			}
			if (results == null)
			{
				throw new GameFrameworkException("Results is invalid.");
			}
			results.Clear();
			foreach (KeyValuePair<int, T> item in m_DataSet)
			{
				results.Add(item.Value);
			}
			results.Sort(comparison);
		}

		public T[] GetDataRows(Predicate<T> condition, Comparison<T> comparison)
		{
			if (condition == null)
			{
				throw new GameFrameworkException("Condition is invalid.");
			}
			if (comparison == null)
			{
				throw new GameFrameworkException("Comparison is invalid.");
			}
			List<T> list = new List<T>();
			foreach (KeyValuePair<int, T> item in m_DataSet)
			{
				if (condition(item.Value))
				{
					list.Add(item.Value);
				}
			}
			list.Sort(comparison);
			return list.ToArray();
		}

		public void GetDataRows(Predicate<T> condition, Comparison<T> comparison, List<T> results)
		{
			if (condition == null)
			{
				throw new GameFrameworkException("Condition is invalid.");
			}
			if (comparison == null)
			{
				throw new GameFrameworkException("Comparison is invalid.");
			}
			if (results == null)
			{
				throw new GameFrameworkException("Results is invalid.");
			}
			results.Clear();
			foreach (KeyValuePair<int, T> item in m_DataSet)
			{
				if (condition(item.Value))
				{
					results.Add(item.Value);
				}
			}
			results.Sort(comparison);
		}

		public T[] GetAllDataRows()
		{
			int num = 0;
			T[] array = new T[m_DataSet.Count];
			foreach (KeyValuePair<int, T> item in m_DataSet)
			{
				array[num++] = item.Value;
			}
			return array;
		}

		public void GetAllDataRows(List<T> results)
		{
			if (results == null)
			{
				throw new GameFrameworkException("Results is invalid.");
			}
			results.Clear();
			foreach (KeyValuePair<int, T> item in m_DataSet)
			{
				results.Add(item.Value);
			}
		}

		public override bool AddDataRow(string dataRowString, object userData)
		{
			try
			{
				T val = new T();
				if (!val.ParseDataRow(dataRowString, userData))
				{
					return false;
				}
				InternalAddDataRow(val);
				return true;
			}
			catch (Exception ex)
			{
				if (ex is GameFrameworkException)
				{
					throw;
				}
				throw new GameFrameworkException(Utility.Text.Format("Can not parse data row string for data table '{0}' with exception '{1}'.", new TypeNamePair(typeof(T), base.Name), ex), ex);
			}
		}

		public override bool AddDataRow(byte[] dataRowBytes, int startIndex, int length, object userData)
		{
			try
			{
				T val = new T();
				if (!val.ParseDataRow(dataRowBytes, startIndex, length, userData))
				{
					return false;
				}
				InternalAddDataRow(val);
				return true;
			}
			catch (Exception ex)
			{
				if (ex is GameFrameworkException)
				{
					throw;
				}
				throw new GameFrameworkException(Utility.Text.Format("Can not parse data row bytes for data table '{0}' with exception '{1}'.", new TypeNamePair(typeof(T), base.Name), ex), ex);
			}
		}

		public override bool RemoveDataRow(int id)
		{
			if (!HasDataRow(id))
			{
				return false;
			}
			if (!m_DataSet.Remove(id))
			{
				return false;
			}
			if ((m_MinIdDataRow != null && m_MinIdDataRow.Id == id) || (m_MaxIdDataRow != null && m_MaxIdDataRow.Id == id))
			{
				m_MinIdDataRow = null;
				m_MaxIdDataRow = null;
				foreach (KeyValuePair<int, T> item in m_DataSet)
				{
					if (m_MinIdDataRow == null || m_MinIdDataRow.Id > item.Key)
					{
						m_MinIdDataRow = item.Value;
					}
					if (m_MaxIdDataRow == null || m_MaxIdDataRow.Id < item.Key)
					{
						m_MaxIdDataRow = item.Value;
					}
				}
			}
			return true;
		}

		public override void RemoveAllDataRows()
		{
			m_DataSet.Clear();
			m_MinIdDataRow = null;
			m_MaxIdDataRow = null;
		}

		public IEnumerator<T> GetEnumerator()
		{
			return m_DataSet.Values.GetEnumerator();
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return m_DataSet.Values.GetEnumerator();
		}

		internal override void Shutdown()
		{
			m_DataSet.Clear();
		}

		private void InternalAddDataRow(T dataRow)
		{
			if (m_DataSet.ContainsKey(dataRow.Id))
			{
				throw new GameFrameworkException(Utility.Text.Format("Already exist '{0}' in data table '{1}'.", dataRow.Id, new TypeNamePair(typeof(T), base.Name)));
			}
			m_DataSet.Add(dataRow.Id, dataRow);
			if (m_MinIdDataRow == null || m_MinIdDataRow.Id > dataRow.Id)
			{
				m_MinIdDataRow = dataRow;
			}
			if (m_MaxIdDataRow == null || m_MaxIdDataRow.Id < dataRow.Id)
			{
				m_MaxIdDataRow = dataRow;
			}
		}
	}

	private readonly Dictionary<TypeNamePair, DataTableBase> m_DataTables;

	private IResourceManager m_ResourceManager;

	private IDataProviderHelper<DataTableBase> m_DataProviderHelper;

	private IDataTableHelper m_DataTableHelper;

	public int Count => m_DataTables.Count;

	public int CachedBytesSize => DataProvider<DataTableBase>.CachedBytesSize;

	public DataTableManager()
	{
		m_DataTables = new Dictionary<TypeNamePair, DataTableBase>();
		m_ResourceManager = null;
		m_DataProviderHelper = null;
		m_DataTableHelper = null;
	}

	internal override void Update(float elapseSeconds, float realElapseSeconds)
	{
	}

	internal override void Shutdown()
	{
		foreach (KeyValuePair<TypeNamePair, DataTableBase> dataTable in m_DataTables)
		{
			dataTable.Value.Shutdown();
		}
		m_DataTables.Clear();
	}

	public void SetResourceManager(IResourceManager resourceManager)
	{
		if (resourceManager == null)
		{
			throw new GameFrameworkException("Resource manager is invalid.");
		}
		m_ResourceManager = resourceManager;
	}

	public void SetDataProviderHelper(IDataProviderHelper<DataTableBase> dataProviderHelper)
	{
		if (dataProviderHelper == null)
		{
			throw new GameFrameworkException("Data provider helper is invalid.");
		}
		m_DataProviderHelper = dataProviderHelper;
	}

	public void SetDataTableHelper(IDataTableHelper dataTableHelper)
	{
		if (dataTableHelper == null)
		{
			throw new GameFrameworkException("Data table helper is invalid.");
		}
		m_DataTableHelper = dataTableHelper;
	}

	public void EnsureCachedBytesSize(int ensureSize)
	{
		DataProvider<DataTableBase>.EnsureCachedBytesSize(ensureSize);
	}

	public void FreeCachedBytes()
	{
		DataProvider<DataTableBase>.FreeCachedBytes();
	}

	public bool HasDataTable<T>() where T : IDataRow
	{
		return InternalHasDataTable(new TypeNamePair(typeof(T)));
	}

	public bool HasDataTable(Type dataRowType)
	{
		if (dataRowType == null)
		{
			throw new GameFrameworkException("Data row type is invalid.");
		}
		if (!typeof(IDataRow).IsAssignableFrom(dataRowType))
		{
			throw new GameFrameworkException(Utility.Text.Format("Data row type '{0}' is invalid.", dataRowType.FullName));
		}
		return InternalHasDataTable(new TypeNamePair(dataRowType));
	}

	public bool HasDataTable<T>(string name) where T : IDataRow
	{
		return InternalHasDataTable(new TypeNamePair(typeof(T), name));
	}

	public bool HasDataTable(Type dataRowType, string name)
	{
		if (dataRowType == null)
		{
			throw new GameFrameworkException("Data row type is invalid.");
		}
		if (!typeof(IDataRow).IsAssignableFrom(dataRowType))
		{
			throw new GameFrameworkException(Utility.Text.Format("Data row type '{0}' is invalid.", dataRowType.FullName));
		}
		return InternalHasDataTable(new TypeNamePair(dataRowType, name));
	}

	public IDataTable<T> GetDataTable<T>() where T : IDataRow
	{
		return (IDataTable<T>)InternalGetDataTable(new TypeNamePair(typeof(T)));
	}

	public DataTableBase GetDataTable(Type dataRowType)
	{
		if (dataRowType == null)
		{
			throw new GameFrameworkException("Data row type is invalid.");
		}
		if (!typeof(IDataRow).IsAssignableFrom(dataRowType))
		{
			throw new GameFrameworkException(Utility.Text.Format("Data row type '{0}' is invalid.", dataRowType.FullName));
		}
		return InternalGetDataTable(new TypeNamePair(dataRowType));
	}

	public IDataTable<T> GetDataTable<T>(string name) where T : IDataRow
	{
		return (IDataTable<T>)InternalGetDataTable(new TypeNamePair(typeof(T), name));
	}

	public DataTableBase GetDataTable(Type dataRowType, string name)
	{
		if (dataRowType == null)
		{
			throw new GameFrameworkException("Data row type is invalid.");
		}
		if (!typeof(IDataRow).IsAssignableFrom(dataRowType))
		{
			throw new GameFrameworkException(Utility.Text.Format("Data row type '{0}' is invalid.", dataRowType.FullName));
		}
		return InternalGetDataTable(new TypeNamePair(dataRowType, name));
	}

	public DataTableBase[] GetAllDataTables()
	{
		int num = 0;
		DataTableBase[] array = new DataTableBase[m_DataTables.Count];
		foreach (KeyValuePair<TypeNamePair, DataTableBase> dataTable in m_DataTables)
		{
			array[num++] = dataTable.Value;
		}
		return array;
	}

	public void GetAllDataTables(List<DataTableBase> results)
	{
		if (results == null)
		{
			throw new GameFrameworkException("Results is invalid.");
		}
		results.Clear();
		foreach (KeyValuePair<TypeNamePair, DataTableBase> dataTable in m_DataTables)
		{
			results.Add(dataTable.Value);
		}
	}

	public IDataTable<T> CreateDataTable<T>() where T : class, IDataRow, new()
	{
		return CreateDataTable<T>(string.Empty);
	}

	public DataTableBase CreateDataTable(Type dataRowType)
	{
		return CreateDataTable(dataRowType, string.Empty);
	}

	public IDataTable<T> CreateDataTable<T>(string name) where T : class, IDataRow, new()
	{
		if (m_ResourceManager == null)
		{
			throw new GameFrameworkException("You must set resource manager first.");
		}
		if (m_DataProviderHelper == null)
		{
			throw new GameFrameworkException("You must set data provider helper first.");
		}
		TypeNamePair typeNamePair = new TypeNamePair(typeof(T), name);
		if (HasDataTable<T>(name))
		{
			throw new GameFrameworkException(Utility.Text.Format("Already exist data table '{0}'.", typeNamePair));
		}
		DataTable<T> dataTable = new DataTable<T>(name);
		dataTable.SetResourceManager(m_ResourceManager);
		dataTable.SetDataProviderHelper(m_DataProviderHelper);
		m_DataTables.Add(typeNamePair, dataTable);
		return dataTable;
	}

	public DataTableBase CreateDataTable(Type dataRowType, string name)
	{
		if (m_ResourceManager == null)
		{
			throw new GameFrameworkException("You must set resource manager first.");
		}
		if (m_DataProviderHelper == null)
		{
			throw new GameFrameworkException("You must set data provider helper first.");
		}
		if (dataRowType == null)
		{
			throw new GameFrameworkException("Data row type is invalid.");
		}
		if (!typeof(IDataRow).IsAssignableFrom(dataRowType))
		{
			throw new GameFrameworkException(Utility.Text.Format("Data row type '{0}' is invalid.", dataRowType.FullName));
		}
		TypeNamePair typeNamePair = new TypeNamePair(dataRowType, name);
		if (HasDataTable(dataRowType, name))
		{
			throw new GameFrameworkException(Utility.Text.Format("Already exist data table '{0}'.", typeNamePair));
		}
		Type type = typeof(DataTable<>).MakeGenericType(dataRowType);
		DataTableBase dataTableBase = (DataTableBase)Activator.CreateInstance(type, name);
		dataTableBase.SetResourceManager(m_ResourceManager);
		dataTableBase.SetDataProviderHelper(m_DataProviderHelper);
		m_DataTables.Add(typeNamePair, dataTableBase);
		return dataTableBase;
	}

	public bool DestroyDataTable<T>() where T : IDataRow
	{
		return InternalDestroyDataTable(new TypeNamePair(typeof(T)));
	}

	public bool DestroyDataTable(Type dataRowType)
	{
		if (dataRowType == null)
		{
			throw new GameFrameworkException("Data row type is invalid.");
		}
		if (!typeof(IDataRow).IsAssignableFrom(dataRowType))
		{
			throw new GameFrameworkException(Utility.Text.Format("Data row type '{0}' is invalid.", dataRowType.FullName));
		}
		return InternalDestroyDataTable(new TypeNamePair(dataRowType));
	}

	public bool DestroyDataTable<T>(string name) where T : IDataRow
	{
		return InternalDestroyDataTable(new TypeNamePair(typeof(T), name));
	}

	public bool DestroyDataTable(Type dataRowType, string name)
	{
		if (dataRowType == null)
		{
			throw new GameFrameworkException("Data row type is invalid.");
		}
		if (!typeof(IDataRow).IsAssignableFrom(dataRowType))
		{
			throw new GameFrameworkException(Utility.Text.Format("Data row type '{0}' is invalid.", dataRowType.FullName));
		}
		return InternalDestroyDataTable(new TypeNamePair(dataRowType, name));
	}

	public bool DestroyDataTable<T>(IDataTable<T> dataTable) where T : IDataRow
	{
		if (dataTable == null)
		{
			throw new GameFrameworkException("Data table is invalid.");
		}
		return InternalDestroyDataTable(new TypeNamePair(typeof(T), dataTable.Name));
	}

	public bool DestroyDataTable(DataTableBase dataTable)
	{
		if (dataTable == null)
		{
			throw new GameFrameworkException("Data table is invalid.");
		}
		return InternalDestroyDataTable(new TypeNamePair(dataTable.Type, dataTable.Name));
	}

	private bool InternalHasDataTable(TypeNamePair typeNamePair)
	{
		return m_DataTables.ContainsKey(typeNamePair);
	}

	private DataTableBase InternalGetDataTable(TypeNamePair typeNamePair)
	{
		DataTableBase value = null;
		if (m_DataTables.TryGetValue(typeNamePair, out value))
		{
			return value;
		}
		return null;
	}

	private bool InternalDestroyDataTable(TypeNamePair typeNamePair)
	{
		DataTableBase value = null;
		if (m_DataTables.TryGetValue(typeNamePair, out value))
		{
			value.Shutdown();
			return m_DataTables.Remove(typeNamePair);
		}
		return false;
	}
}
