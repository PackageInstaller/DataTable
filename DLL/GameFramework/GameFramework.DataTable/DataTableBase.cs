using System;
using GameFramework.Resource;

namespace GameFramework.DataTable;

public abstract class DataTableBase : IDataProvider<DataTableBase>
{
	private readonly string m_Name;

	private readonly DataProvider<DataTableBase> m_DataProvider;

	public string Name => m_Name;

	public string FullName => new TypeNamePair(Type, m_Name).ToString();

	public abstract Type Type { get; }

	public abstract int Count { get; }

	public event EventHandler<ReadDataSuccessEventArgs> ReadDataSuccess
	{
		add
		{
			m_DataProvider.ReadDataSuccess += value;
		}
		remove
		{
			m_DataProvider.ReadDataSuccess -= value;
		}
	}

	public event EventHandler<ReadDataFailureEventArgs> ReadDataFailure
	{
		add
		{
			m_DataProvider.ReadDataFailure += value;
		}
		remove
		{
			m_DataProvider.ReadDataFailure -= value;
		}
	}

	public event EventHandler<ReadDataUpdateEventArgs> ReadDataUpdate
	{
		add
		{
			m_DataProvider.ReadDataUpdate += value;
		}
		remove
		{
			m_DataProvider.ReadDataUpdate -= value;
		}
	}

	public event EventHandler<ReadDataDependencyAssetEventArgs> ReadDataDependencyAsset
	{
		add
		{
			m_DataProvider.ReadDataDependencyAsset += value;
		}
		remove
		{
			m_DataProvider.ReadDataDependencyAsset -= value;
		}
	}

	public DataTableBase()
		: this(null)
	{
	}

	public DataTableBase(string name)
	{
		m_Name = name ?? string.Empty;
		m_DataProvider = new DataProvider<DataTableBase>(this);
	}

	public void ReadData(string dataTableAssetName)
	{
		m_DataProvider.ReadData(dataTableAssetName);
	}

	public void ReadData(string dataTableAssetName, int priority)
	{
		m_DataProvider.ReadData(dataTableAssetName, priority);
	}

	public void ReadData(string dataTableAssetName, object userData)
	{
		m_DataProvider.ReadData(dataTableAssetName, userData);
	}

	public void ReadData(string dataTableAssetName, int priority, object userData, string packageName)
	{
		m_DataProvider.ReadData(dataTableAssetName, priority, userData, packageName);
	}

	public bool ParseData(string dataTableString)
	{
		return m_DataProvider.ParseData(dataTableString);
	}

	public bool ParseData(string dataTableString, object userData)
	{
		return m_DataProvider.ParseData(dataTableString, userData);
	}

	public bool ParseData(byte[] dataTableBytes)
	{
		return m_DataProvider.ParseData(dataTableBytes);
	}

	public bool ParseData(byte[] dataTableBytes, object userData)
	{
		return m_DataProvider.ParseData(dataTableBytes, userData);
	}

	public bool ParseData(byte[] dataTableBytes, int startIndex, int length)
	{
		return m_DataProvider.ParseData(dataTableBytes, startIndex, length);
	}

	public bool ParseData(byte[] dataTableBytes, int startIndex, int length, object userData)
	{
		return m_DataProvider.ParseData(dataTableBytes, startIndex, length, userData);
	}

	public abstract bool HasDataRow(int id);

	public abstract bool AddDataRow(string dataRowString, object userData);

	public abstract bool AddDataRow(byte[] dataRowBytes, int startIndex, int length, object userData);

	public abstract bool RemoveDataRow(int id);

	public abstract void RemoveAllDataRows();

	internal void SetResourceManager(IResourceManager resourceManager)
	{
		m_DataProvider.SetResourceManager(resourceManager);
	}

	internal void SetDataProviderHelper(IDataProviderHelper<DataTableBase> dataProviderHelper)
	{
		m_DataProvider.SetDataProviderHelper(dataProviderHelper);
	}

	internal abstract void Shutdown();
}
