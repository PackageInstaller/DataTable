using UnityEngine;

namespace YooAsset;

public sealed class InstantiateOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		LoadObject,
		CloneSync,
		CloneAsync,
		Done
	}

	private readonly AssetHandle _handle;

	private readonly bool _setPositionAndRotation;

	private readonly Vector3 _position;

	private readonly Quaternion _rotation;

	private readonly Transform _parent;

	private readonly bool _worldPositionStays;

	private readonly bool _actived;

	private ESteps _steps;

	public GameObject Result;

	internal InstantiateOperation(AssetHandle handle, bool setPositionAndRotation, Vector3 position, Quaternion rotation, Transform parent, bool worldPositionStays, bool actived)
	{
		_handle = handle;
		_setPositionAndRotation = setPositionAndRotation;
		_position = position;
		_rotation = rotation;
		_parent = parent;
		_worldPositionStays = worldPositionStays;
		_actived = actived;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.LoadObject;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.LoadObject)
		{
			if (!_handle.IsValidWithWarning)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "AssetHandle is invalid.";
				return;
			}
			if (!_handle.IsDone)
			{
				return;
			}
			if (_handle.AssetObject == null)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = "AssetObject is null.";
				return;
			}
			_steps = ESteps.CloneSync;
		}
		if (_steps == ESteps.CloneSync)
		{
			Result = InstantiateInternal(_handle.AssetObject, _setPositionAndRotation, _position, _rotation, _parent, _worldPositionStays);
			if (!_actived)
			{
				Result.SetActive(value: false);
			}
			_steps = ESteps.Done;
			Status = EOperationStatus.Succeed;
		}
	}

	internal override void InternalWaitForAsyncComplete()
	{
		do
		{
			if (_handle != null)
			{
				_handle.WaitForAsyncComplete();
			}
		}
		while (!ExecuteWhileDone());
		_steps = ESteps.Done;
	}

	internal override string InternalGetDesc()
	{
		AssetInfo assetInfo = _handle.GetAssetInfo();
		return "AssetPath : " + assetInfo.AssetPath;
	}

	public void Cancel()
	{
		AbortOperation();
	}

	internal static GameObject InstantiateInternal(Object assetObject, bool setPositionAndRotation, Vector3 position, Quaternion rotation, Transform parent, bool worldPositionStays)
	{
		if (assetObject == null)
		{
			return null;
		}
		if (setPositionAndRotation)
		{
			if (parent != null)
			{
				return Object.Instantiate(assetObject as GameObject, position, rotation, parent);
			}
			return Object.Instantiate(assetObject as GameObject, position, rotation);
		}
		if (parent != null)
		{
			return Object.Instantiate(assetObject as GameObject, parent, worldPositionStays);
		}
		return Object.Instantiate(assetObject as GameObject);
	}
}
