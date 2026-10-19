using System;
using ACT.World.Actions;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Battle;

public class CompStateObject : EcsComponent
{
	private int _stateId;

	private int _behaveId;

	public StateObjectBase StateObjectBase;

	public StateWorldAssetData StateWorldAssetData;

	private AssetLoadHandle _stateObjectHandle;

	public int StateId
	{
		get
		{
			return _stateId;
		}
		set
		{
			if (value != _stateId)
			{
				int stateId = _stateId;
				_stateId = value;
				StateIdChangeEvent?.Invoke(stateId, value);
			}
		}
	}

	public int BehaveId
	{
		get
		{
			return _behaveId;
		}
		set
		{
			if (value != _behaveId)
			{
				int behaveId = _behaveId;
				_behaveId = value;
				BehaveIdChangeEvent?.Invoke(behaveId, value);
			}
		}
	}

	public event Action<int, int> StateIdChangeEvent;

	public event Action<int, int> BehaveIdChangeEvent;

	protected override void OnGet()
	{
		_stateId = int.MinValue;
		_behaveId = int.MinValue;
	}

	protected override void OnRelease()
	{
		StateWorldAssetData = null;
		StateObjectBase = null;
		StateIdChangeEvent = null;
		BehaveIdChangeEvent = null;
		if (AssetLoadHandleExtensions.IsValid(_stateObjectHandle))
		{
			AssetStationManager.BattleStation.ReleaseInstance(_stateObjectHandle);
			_stateObjectHandle = default;
		}
	}

	public void EntityChangeState(int stateId)
	{
		StateId = stateId;
		StateObjectBase.EnterState(stateId);
	}

	public bool Interact(int stateId, int entryIndex, Entity eb)
	{
		StateObjectBase stateObjectBase = StateObjectBase;
		if (stateObjectBase.currentStateId != stateId)
		{
			return false;
		}
		stateObjectBase.Interact(entryIndex, eb, InteractAction.InteractSource.Player);
		return true;
	}

	public async UniTask<AssetLoadHandle> LoadAsync(YooAssetReference address, Vector3 initPos, Quaternion rotate)
	{
		if (_stateObjectHandle.IsValid)
		{
			return default;
		}
		_stateObjectHandle = AssetStationManager.BattleStation.InstantiateAsync(address, initPos, rotate);
		await _stateObjectHandle;
		return _stateObjectHandle;
	}
}
