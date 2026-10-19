using System;
using System.Collections.Generic;
using UnityEngine.Localization.Metadata;
using UnityEngine.Pool;
using UnityEngine.ResourceManagement;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization.Tables;

public class AssetTable : DetailedLocalizationTable<AssetTableEntry>, IPreloadRequired
{
	private AsyncOperationHandle? m_PreloadOperationHandle;

	private ResourceManager ResourceManager => AddressablesInterface.ResourceManager;

	public virtual AsyncOperationHandle PreloadOperation
	{
		get
		{
			if (!m_PreloadOperationHandle.HasValue)
			{
				m_PreloadOperationHandle = PreloadAssets();
			}
			return m_PreloadOperationHandle.Value;
		}
	}

	private AsyncOperationHandle PreloadAssets()
	{
		PreloadAssetTableMetadata preloadAssetTableMetadata = GetMetadata<PreloadAssetTableMetadata>() ?? SharedData.Metadata.GetMetadata<PreloadAssetTableMetadata>();
		if (preloadAssetTableMetadata == null || preloadAssetTableMetadata.Behaviour != PreloadAssetTableMetadata.PreloadBehaviour.NoPreload)
		{
			List<AsyncOperationHandle> list = CollectionPool<List<AsyncOperationHandle>, AsyncOperationHandle>.Get();
			foreach (AssetTableEntry value in Values)
			{
				if (!value.IsEmpty && !value.AsyncOperation.HasValue)
				{
					value.AsyncOperation = AddressablesInterface.LoadAssetFromGUID<Object[]>(value.Guid);
					ResourceManager.Acquire(value.AsyncOperation.Value);
					list.Add(value.AsyncOperation.Value);
				}
			}
			if (list.Count > 0)
			{
				return ResourceManager.CreateGenericGroupOperation(list);
			}
			CollectionPool<List<AsyncOperationHandle>, AsyncOperationHandle>.Release(list);
		}
		return ResourceManager.CreateCompletedOperation(this, null);
	}

	public AsyncOperationHandle<TObject> GetAssetAsync<TObject>(TableEntryReference entryReference) where TObject : Object
	{
		AssetTableEntry entryFromReference = GetEntryFromReference(entryReference);
		if (entryFromReference == null)
		{
			string text = entryReference.ResolveKeyName(SharedData);
			return ResourceManager.CreateCompletedOperation<TObject>(null, "Could not find asset with key \"" + text + "\"");
		}
		return GetAssetAsync<TObject>(entryFromReference);
	}

	internal AsyncOperationHandle<TObject> GetAssetAsync<TObject>(AssetTableEntry entry) where TObject : Object
	{
		if (!entry.AsyncOperation.HasValue)
		{
			if (string.IsNullOrEmpty(entry.Guid))
			{
				entry.AsyncOperation = ResourceManager.CreateCompletedOperation<TObject>(null, null);
			}
			else
			{
				entry.AsyncOperation = AddressablesInterface.LoadAssetFromGUID<TObject>(entry.Guid);
			}
		}
		AsyncOperationHandle value = entry.AsyncOperation.Value;
		try
		{
			return value.Convert<TObject>();
		}
		catch (InvalidCastException)
		{
			if (value.IsDone)
			{
				if (value.Status != AsyncOperationStatus.Succeeded)
				{
					return ResourceManager.CreateCompletedOperation<TObject>(null, value.OperationException.Message);
				}
				if (value.Result is Object[] array)
				{
					Object[] array2 = array;
					for (int i = 0; i < array2.Length; i++)
					{
						if (array2[i] is TObject result)
						{
							AsyncOperationHandle<TObject> asyncOperationHandle = ResourceManager.CreateCompletedOperation(result, null);
							entry.AsyncOperation = asyncOperationHandle;
							AddressablesInterface.Release(value);
							return asyncOperationHandle;
						}
					}
				}
				throw new InvalidCastException("Could not convert asset of type " + value.Result.GetType().Name + " to " + typeof(TObject).Name + ".");
			}
			AsyncOperationHandle<TObject> asyncOperationHandle2 = ResourceManager.CreateChainOperation(value, (AsyncOperationHandle op) => GetAssetAsync<TObject>(entry));
			entry.AsyncOperation = asyncOperationHandle2;
			AddressablesInterface.Release(value);
			return asyncOperationHandle2;
		}
	}

	public void ReleaseAssets()
	{
		if (m_PreloadOperationHandle.HasValue)
		{
			AddressablesInterface.SafeRelease(m_PreloadOperationHandle.Value);
			m_PreloadOperationHandle = null;
		}
		foreach (AssetTableEntry value in Values)
		{
			if (value.AsyncOperation.HasValue)
			{
				AddressablesInterface.SafeRelease(value.AsyncOperation.Value);
				value.AsyncOperation = null;
			}
		}
	}

	public void ReleaseAsset(AssetTableEntry entry)
	{
		if (entry != null)
		{
			if (m_PreloadOperationHandle.HasValue)
			{
				AddressablesInterface.SafeRelease(m_PreloadOperationHandle.Value);
				m_PreloadOperationHandle = null;
			}
			if (entry.AsyncOperation.HasValue)
			{
				AddressablesInterface.SafeRelease(entry.AsyncOperation.Value);
				entry.AsyncOperation = null;
			}
		}
	}

	public void ReleaseAsset(TableEntryReference entry)
	{
		ReleaseAsset(GetEntryFromReference(entry));
	}

	public override AssetTableEntry CreateTableEntry()
	{
		return new AssetTableEntry
		{
			Table = this,
			Data = new TableEntryData()
		};
	}
}
