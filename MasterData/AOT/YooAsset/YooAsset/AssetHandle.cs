using System;
using UnityEngine;

namespace YooAsset;

public sealed class AssetHandle : HandleBase
{
	private Action<AssetHandle> _callback;

	public UnityEngine.Object AssetObject
	{
		get
		{
			if (!IsValidWithWarning)
			{
				return null;
			}
			return Provider.AssetObject;
		}
	}

	public event Action<AssetHandle> Completed
	{
		add
		{
			if (!IsValidWithWarning)
			{
				throw new Exception("AssetHandle is invalid");
			}
			if (Provider.IsDone)
			{
				value(this);
			}
			else
			{
				_callback = (Action<AssetHandle>)Delegate.Combine(_callback, value);
			}
		}
		remove
		{
			if (!IsValidWithWarning)
			{
				throw new Exception("AssetHandle is invalid");
			}
			_callback = (Action<AssetHandle>)Delegate.Remove(_callback, value);
		}
	}

	internal AssetHandle(ProviderOperation provider)
		: base(provider)
	{
	}

	internal override void InvokeCallback()
	{
		_callback?.Invoke(this);
	}

	public void WaitForAsyncComplete()
	{
		if (IsValidWithWarning)
		{
			Provider.WaitForAsyncComplete();
		}
	}

	public TAsset GetAssetObject<TAsset>() where TAsset : UnityEngine.Object
	{
		if (!IsValidWithWarning)
		{
			return null;
		}
		return Provider.AssetObject as TAsset;
	}

	public GameObject InstantiateSync()
	{
		return InstantiateSyncInternal(setPositionAndRotation: false, Vector3.zero, Quaternion.identity, null, worldPositionStays: false);
	}

	public GameObject InstantiateSync(Transform parent)
	{
		return InstantiateSyncInternal(setPositionAndRotation: false, Vector3.zero, Quaternion.identity, parent, worldPositionStays: false);
	}

	public GameObject InstantiateSync(Transform parent, bool worldPositionStays)
	{
		return InstantiateSyncInternal(setPositionAndRotation: false, Vector3.zero, Quaternion.identity, parent, worldPositionStays);
	}

	public GameObject InstantiateSync(Vector3 position, Quaternion rotation)
	{
		return InstantiateSyncInternal(setPositionAndRotation: true, position, rotation, null, worldPositionStays: false);
	}

	public GameObject InstantiateSync(Vector3 position, Quaternion rotation, Transform parent)
	{
		return InstantiateSyncInternal(setPositionAndRotation: true, position, rotation, parent, worldPositionStays: false);
	}

	public InstantiateOperation InstantiateAsync(bool actived = true)
	{
		return InstantiateAsyncInternal(setPositionAndRotation: false, Vector3.zero, Quaternion.identity, null, worldPositionStays: false, actived);
	}

	public InstantiateOperation InstantiateAsync(Transform parent, bool actived = true)
	{
		return InstantiateAsyncInternal(setPositionAndRotation: false, Vector3.zero, Quaternion.identity, parent, worldPositionStays: false, actived);
	}

	public InstantiateOperation InstantiateAsync(Transform parent, bool worldPositionStays, bool actived = true)
	{
		return InstantiateAsyncInternal(setPositionAndRotation: false, Vector3.zero, Quaternion.identity, parent, worldPositionStays, actived);
	}

	public InstantiateOperation InstantiateAsync(Vector3 position, Quaternion rotation, bool actived = true)
	{
		return InstantiateAsyncInternal(setPositionAndRotation: true, position, rotation, null, worldPositionStays: false, actived);
	}

	public InstantiateOperation InstantiateAsync(Vector3 position, Quaternion rotation, Transform parent, bool actived = true)
	{
		return InstantiateAsyncInternal(setPositionAndRotation: true, position, rotation, parent, worldPositionStays: false, actived);
	}

	private GameObject InstantiateSyncInternal(bool setPositionAndRotation, Vector3 position, Quaternion rotation, Transform parent, bool worldPositionStays)
	{
		if (!IsValidWithWarning)
		{
			return null;
		}
		if (Provider.AssetObject == null)
		{
			return null;
		}
		return InstantiateOperation.InstantiateInternal(Provider.AssetObject, setPositionAndRotation, position, rotation, parent, worldPositionStays);
	}

	private InstantiateOperation InstantiateAsyncInternal(bool setPositionAndRotation, Vector3 position, Quaternion rotation, Transform parent, bool worldPositionStays, bool actived)
	{
		string packageName = GetAssetInfo().PackageName;
		InstantiateOperation instantiateOperation = new InstantiateOperation(this, setPositionAndRotation, position, rotation, parent, worldPositionStays, actived);
		OperationSystem.StartOperation(packageName, instantiateOperation);
		return instantiateOperation;
	}
}
