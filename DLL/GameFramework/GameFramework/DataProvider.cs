using System;
using GameFramework.Resource;

namespace GameFramework;

internal sealed class DataProvider<T> : IDataProvider<T>
{
	private const int BlockSize = 4096;

	private static byte[] s_CachedBytes;

	private readonly T m_Owner;

	private readonly LoadAssetCallbacks m_LoadAssetCallbacks;

	private IResourceManager m_ResourceManager;

	private IDataProviderHelper<T> m_DataProviderHelper;

	private EventHandler<ReadDataSuccessEventArgs> m_ReadDataSuccessEventHandler;

	private EventHandler<ReadDataFailureEventArgs> m_ReadDataFailureEventHandler;

	private EventHandler<ReadDataUpdateEventArgs> m_ReadDataUpdateEventHandler;

	private EventHandler<ReadDataDependencyAssetEventArgs> m_ReadDataDependencyAssetEventHandler;

	public static int CachedBytesSize => (s_CachedBytes != null) ? s_CachedBytes.Length : 0;

	public event EventHandler<ReadDataSuccessEventArgs> ReadDataSuccess
	{
		add
		{
			m_ReadDataSuccessEventHandler = (EventHandler<ReadDataSuccessEventArgs>)Delegate.Combine(m_ReadDataSuccessEventHandler, value);
		}
		remove
		{
			m_ReadDataSuccessEventHandler = (EventHandler<ReadDataSuccessEventArgs>)Delegate.Remove(m_ReadDataSuccessEventHandler, value);
		}
	}

	public event EventHandler<ReadDataFailureEventArgs> ReadDataFailure
	{
		add
		{
			m_ReadDataFailureEventHandler = (EventHandler<ReadDataFailureEventArgs>)Delegate.Combine(m_ReadDataFailureEventHandler, value);
		}
		remove
		{
			m_ReadDataFailureEventHandler = (EventHandler<ReadDataFailureEventArgs>)Delegate.Remove(m_ReadDataFailureEventHandler, value);
		}
	}

	public event EventHandler<ReadDataUpdateEventArgs> ReadDataUpdate
	{
		add
		{
			m_ReadDataUpdateEventHandler = (EventHandler<ReadDataUpdateEventArgs>)Delegate.Combine(m_ReadDataUpdateEventHandler, value);
		}
		remove
		{
			m_ReadDataUpdateEventHandler = (EventHandler<ReadDataUpdateEventArgs>)Delegate.Remove(m_ReadDataUpdateEventHandler, value);
		}
	}

	public event EventHandler<ReadDataDependencyAssetEventArgs> ReadDataDependencyAsset
	{
		add
		{
			m_ReadDataDependencyAssetEventHandler = (EventHandler<ReadDataDependencyAssetEventArgs>)Delegate.Combine(m_ReadDataDependencyAssetEventHandler, value);
		}
		remove
		{
			m_ReadDataDependencyAssetEventHandler = (EventHandler<ReadDataDependencyAssetEventArgs>)Delegate.Remove(m_ReadDataDependencyAssetEventHandler, value);
		}
	}

	public DataProvider(T owner)
	{
		m_Owner = owner;
		m_LoadAssetCallbacks = new LoadAssetCallbacks(LoadAssetSuccessCallback, LoadAssetOrBinaryFailureCallback, LoadAssetUpdateCallback, LoadAssetDependencyAssetCallback);
		m_ResourceManager = null;
		m_DataProviderHelper = null;
		m_ReadDataSuccessEventHandler = null;
		m_ReadDataFailureEventHandler = null;
		m_ReadDataUpdateEventHandler = null;
		m_ReadDataDependencyAssetEventHandler = null;
	}

	public static void EnsureCachedBytesSize(int ensureSize)
	{
		if (ensureSize < 0)
		{
			throw new GameFrameworkException("Ensure size is invalid.");
		}
		if (s_CachedBytes == null || s_CachedBytes.Length < ensureSize)
		{
			FreeCachedBytes();
			int num = (ensureSize - 1 + 4096) / 4096 * 4096;
			s_CachedBytes = new byte[num];
		}
	}

	public static void FreeCachedBytes()
	{
		s_CachedBytes = null;
	}

	public void ReadData(string dataAssetName)
	{
		ReadData(dataAssetName, 0, null);
	}

	public void ReadData(string dataAssetName, int priority)
	{
		ReadData(dataAssetName, priority, null);
	}

	public void ReadData(string dataAssetName, object userData)
	{
		ReadData(dataAssetName, 0, userData);
	}

	public void ReadData(string dataAssetName, int priority, object userData, string packageName = "DataTables")
	{
		if (m_ResourceManager == null)
		{
			throw new GameFrameworkException("You must set resource manager first.");
		}
		if (m_DataProviderHelper == null)
		{
			throw new GameFrameworkException("You must set data provider helper first.");
		}
		HasAssetResult hasAssetResult = m_ResourceManager.HasAsset(dataAssetName, packageName);
		switch (hasAssetResult)
		{
		case HasAssetResult.AssetOnDisk:
		case HasAssetResult.AssetOnFileSystem:
			m_ResourceManager.LoadAssetAsync(dataAssetName, m_LoadAssetCallbacks, userData, packageName);
			break;
		case HasAssetResult.BinaryOnDisk:
			throw new GameFrameworkException(Utility.Text.Format("Could Not Load Data asset '{0}' is '{1}'in package '{2}'!", dataAssetName, hasAssetResult, packageName));
		case HasAssetResult.BinaryOnFileSystem:
			throw new GameFrameworkException(Utility.Text.Format("Could Not Load Data asset '{0}' is '{1} in package '{2}''!", dataAssetName, hasAssetResult, packageName));
		default:
			throw new GameFrameworkException(Utility.Text.Format("Could Not Load Data asset '{0}' is '{1} in package '{2}''!", dataAssetName, hasAssetResult, packageName));
		}
	}

	public bool ParseData(string dataString)
	{
		return ParseData(dataString, null);
	}

	public bool ParseData(string dataString, object userData)
	{
		if (m_DataProviderHelper == null)
		{
			throw new GameFrameworkException("You must set data helper first.");
		}
		if (dataString == null)
		{
			throw new GameFrameworkException("Data string is invalid.");
		}
		try
		{
			return m_DataProviderHelper.ParseData(m_Owner, dataString, userData);
		}
		catch (Exception ex)
		{
			if (ex is GameFrameworkException)
			{
				throw;
			}
			throw new GameFrameworkException(Utility.Text.Format("Can not parse data string with exception '{0}'.", ex), ex);
		}
	}

	public bool ParseData(byte[] dataBytes)
	{
		if (dataBytes == null)
		{
			throw new GameFrameworkException("Data bytes is invalid.");
		}
		return ParseData(dataBytes, 0, dataBytes.Length, null);
	}

	public bool ParseData(byte[] dataBytes, object userData)
	{
		if (dataBytes == null)
		{
			throw new GameFrameworkException("Data bytes is invalid.");
		}
		return ParseData(dataBytes, 0, dataBytes.Length, userData);
	}

	public bool ParseData(byte[] dataBytes, int startIndex, int length)
	{
		return ParseData(dataBytes, startIndex, length, null);
	}

	public bool ParseData(byte[] dataBytes, int startIndex, int length, object userData)
	{
		if (m_DataProviderHelper == null)
		{
			throw new GameFrameworkException("You must set data helper first.");
		}
		if (dataBytes == null)
		{
			throw new GameFrameworkException("Data bytes is invalid.");
		}
		if (startIndex < 0 || length < 0 || startIndex + length > dataBytes.Length)
		{
			throw new GameFrameworkException("Start index or length is invalid.");
		}
		try
		{
			return m_DataProviderHelper.ParseData(m_Owner, dataBytes, startIndex, length, userData);
		}
		catch (Exception ex)
		{
			if (ex is GameFrameworkException)
			{
				throw;
			}
			throw new GameFrameworkException(Utility.Text.Format("Can not parse data bytes with exception '{0}'.", ex), ex);
		}
	}

	internal void SetResourceManager(IResourceManager resourceManager)
	{
		if (resourceManager == null)
		{
			throw new GameFrameworkException("Resource manager is invalid.");
		}
		m_ResourceManager = resourceManager;
	}

	internal void SetDataProviderHelper(IDataProviderHelper<T> dataProviderHelper)
	{
		if (dataProviderHelper == null)
		{
			throw new GameFrameworkException("Data provider helper is invalid.");
		}
		m_DataProviderHelper = dataProviderHelper;
	}

	private void LoadAssetSuccessCallback(string dataAssetName, string packageName, object dataAsset, float duration, object userData)
	{
		try
		{
			if (!m_DataProviderHelper.ReadData(m_Owner, dataAssetName, dataAsset, userData))
			{
				throw new GameFrameworkException(Utility.Text.Format("Load data failure in data provider helper, data asset name '{0}'.", dataAssetName));
			}
			if (m_ReadDataSuccessEventHandler != null)
			{
				ReadDataSuccessEventArgs e = ReadDataSuccessEventArgs.Create(dataAssetName, duration, userData);
				m_ReadDataSuccessEventHandler(this, e);
				ReferencePool.Release(e);
			}
		}
		catch (Exception ex)
		{
			if (m_ReadDataFailureEventHandler != null)
			{
				ReadDataFailureEventArgs e2 = ReadDataFailureEventArgs.Create(dataAssetName, ex.ToString(), userData);
				m_ReadDataFailureEventHandler(this, e2);
				ReferencePool.Release(e2);
				return;
			}
			throw;
		}
		finally
		{
			m_DataProviderHelper.ReleaseDataAsset(m_Owner, dataAssetName, packageName);
		}
	}

	private void LoadAssetOrBinaryFailureCallback(string dataAssetName, LoadResourceStatus status, string errorMessage, object userData)
	{
		string text = Utility.Text.Format("Load data failure, data asset name '{0}', status '{1}', error message '{2}'.", dataAssetName, status, errorMessage);
		if (m_ReadDataFailureEventHandler != null)
		{
			ReadDataFailureEventArgs e = ReadDataFailureEventArgs.Create(dataAssetName, text, userData);
			m_ReadDataFailureEventHandler(this, e);
			ReferencePool.Release(e);
			return;
		}
		throw new GameFrameworkException(text);
	}

	private void LoadAssetUpdateCallback(string dataAssetName, float progress, object userData)
	{
		if (m_ReadDataUpdateEventHandler != null)
		{
			ReadDataUpdateEventArgs e = ReadDataUpdateEventArgs.Create(dataAssetName, progress, userData);
			m_ReadDataUpdateEventHandler(this, e);
			ReferencePool.Release(e);
		}
	}

	private void LoadAssetDependencyAssetCallback(string dataAssetName, string dependencyAssetName, int loadedCount, int totalCount, object userData)
	{
		if (m_ReadDataDependencyAssetEventHandler != null)
		{
			ReadDataDependencyAssetEventArgs e = ReadDataDependencyAssetEventArgs.Create(dataAssetName, dependencyAssetName, loadedCount, totalCount, userData);
			m_ReadDataDependencyAssetEventHandler(this, e);
			ReferencePool.Release(e);
		}
	}

	private void LoadBinarySuccessCallback(string dataAssetName, byte[] dataBytes, float duration, object userData)
	{
		try
		{
			if (!m_DataProviderHelper.ReadData(m_Owner, dataAssetName, dataBytes, 0, dataBytes.Length, userData))
			{
				throw new GameFrameworkException(Utility.Text.Format("Load data failure in data provider helper, data asset name '{0}'.", dataAssetName));
			}
			if (m_ReadDataSuccessEventHandler != null)
			{
				ReadDataSuccessEventArgs e = ReadDataSuccessEventArgs.Create(dataAssetName, duration, userData);
				m_ReadDataSuccessEventHandler(this, e);
				ReferencePool.Release(e);
			}
		}
		catch (Exception ex)
		{
			if (m_ReadDataFailureEventHandler != null)
			{
				ReadDataFailureEventArgs e2 = ReadDataFailureEventArgs.Create(dataAssetName, ex.ToString(), userData);
				m_ReadDataFailureEventHandler(this, e2);
				ReferencePool.Release(e2);
				return;
			}
			throw;
		}
	}
}
