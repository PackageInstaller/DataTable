using System;
using ACT.Battle;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractSlimeMould : StateObjectBase
{
	private static readonly int State = Animator.StringToHash("state");

	private const int STATE_SHOW = 0;

	private const int STATE_HIDDEN = -1;

	private const int STATE_ANIMATE = 1;

	private SlimeMouldData _data;

	private AssetLoadHandle[][] _groupHandles;

	private InteractEntry _interactEntry;

	private const int NeutralId = 2;

	[SerializeField]
	private string[] abilities;

	[SerializeField]
	private Vector3 _size = new Vector3(1f, 1f, 1f);

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		_data = (SlimeMouldData)entity.GetCompStateObject().StateWorldAssetData;
		SlimeMouldGroupData[] slimeMouldGroups = _data.SlimeMouldGroups;
		_groupHandles = new AssetLoadHandle[slimeMouldGroups.Length][];
		Vector3 posOffset = slimeMouldGroups[0].ModelPos[0].value - transform.position;
		_interactEntry = InteractEntry.CreateAttackEntry(2, in abilities, Alliance.Enemy, in _size, in posOffset);
		_interactEntry.BindInteractObjectBase(this);
		_interactEntry.BindData(_data);
		_interactEntry.BindInteractState(0, 0);
		InteractEntry interactEntry = _interactEntry;
		interactEntry.onHPChangeInteract = (Action<int, int>)Delegate.Combine(interactEntry.onHPChangeInteract, new Action<int, int>(OnHpChangeInteract));
		for (int i = 0; i < slimeMouldGroups.Length; i++)
		{
			Pos[] modelPos = slimeMouldGroups[i].ModelPos;
			_groupHandles[i] = new AssetLoadHandle[modelPos.Length];
			YooAssetReference assetID = ((i == 0) ? _data.headPrefabAssetID : _data.bodyPrefabAssetID);
			for (int j = 0; j < modelPos.Length; j++)
			{
				AssetLoadHandle assetLoadHandle = AssetStationManager.BattleStation.Instantiate(assetID, transform);
				_groupHandles[i][j] = assetLoadHandle;
				GameObject gameObject = assetLoadHandle.AsGameObject();
				Pos pos = modelPos[j];
				gameObject.transform.position = pos.value;
				gameObject.transform.rotation = pos.rotate;
				gameObject.transform.localScale = pos.localScale;
			}
		}
		base.InitStateObject(stateId);
		if (stateId == 1)
		{
			NetEnterState(-1).Forget();
		}
	}

	private void OnHpChangeInteract(int from, int to)
	{
		if (to == 0)
		{
			NetEnterState(1).Forget();
		}
	}

	protected override void HandleInitState(int stateId)
	{
		switch (stateId)
		{
		case -1:
			SetAllColliderEnabled(enabled: false);
			PlayHideStateSequence();
			break;
		case 0:
			SetAllColliderEnabled(enabled: true);
			PlayShowSequence();
			_interactEntry.HandleInit();
			break;
		case 1:
			PlayAnimateThenHide().Forget();
			break;
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		if (stateId == 0)
		{
			_interactEntry.HandleUninit();
		}
	}

	private async UniTask PlayAnimateThenHide()
	{
		await PlayHidingSequence();
		NetEnterState(-1).Forget();
	}

	private async UniTask PlayHidingSequence()
	{
		for (int g = 0; g < _groupHandles.Length; g++)
		{
			AssetLoadHandle[] groupHandles = _groupHandles[g];
			for (int i = 0; i < groupHandles.Length; i++)
			{
				GameObject gameObject = groupHandles[i].AsGameObject();
				Animator componentInChildren = gameObject.GetComponentInChildren<Animator>();
				if (componentInChildren != null)
				{
					componentInChildren.SetInteger(State, 1);
				}
				SetColliderEnabled(gameObject, enabled: false);
				if (i < groupHandles.Length)
				{
					await UniTask.Delay(TimeSpan.FromSeconds(_data.itemDelay));
				}
			}
			if (g < _groupHandles.Length)
			{
				await UniTask.Delay(TimeSpan.FromSeconds(_data.groupDelay));
			}
		}
	}

	private void PlayHideStateSequence()
	{
		for (int i = 0; i < _groupHandles.Length; i++)
		{
			AssetLoadHandle[] array = _groupHandles[i];
			for (int j = 0; j < array.Length; j++)
			{
				Animator componentInChildren = array[j].AsGameObject().GetComponentInChildren<Animator>();
				if (componentInChildren != null)
				{
					componentInChildren.SetInteger(State, -1);
				}
			}
		}
	}

	private void PlayShowSequence()
	{
		for (int num = _groupHandles.Length - 1; num >= 0; num--)
		{
			AssetLoadHandle[] array = _groupHandles[num];
			for (int num2 = array.Length - 1; num2 >= 0; num2--)
			{
				Animator componentInChildren = array[num2].AsGameObject().GetComponentInChildren<Animator>();
				if (componentInChildren != null)
				{
					componentInChildren.SetInteger(State, 0);
				}
			}
		}
	}

	private void SetAllColliderEnabled(bool enabled)
	{
		for (int i = 0; i < _groupHandles.Length; i++)
		{
			AssetLoadHandle[] array = _groupHandles[i];
			for (int j = 0; j < array.Length; j++)
			{
				GameObject gameObject = array[j].AsGameObject();
				if (gameObject != null)
				{
					SetColliderEnabled(gameObject, enabled);
				}
			}
		}
	}

	private static void SetColliderEnabled(GameObject go, bool enabled)
	{
		BoxCollider componentInChildren = go.GetComponentInChildren<BoxCollider>();
		if (componentInChildren != null)
		{
			componentInChildren.enabled = enabled;
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 0 && stateId != -1)
		{
			return stateId == 1;
		}
		return true;
	}

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		_interactEntry = null;
		if (_groupHandles == null)
		{
			return;
		}
		for (int i = 0; i < _groupHandles.Length; i++)
		{
			for (int j = 0; j < _groupHandles[i].Length; j++)
			{
				if (_groupHandles[i][j].IsValid)
				{
					AssetStationManager.BattleStation.ReleaseInstance(_groupHandles[i][j]);
				}
			}
		}
	}
}
