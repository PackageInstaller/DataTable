using System;
using ACT.Battle;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractPortal : InteractObject
{
	private static readonly int State = Animator.StringToHash("state");

	private PortalData _data;

	private Vector3 _pathCenter;

	private Vector3 _sitPos;

	private Animator _animator;

	private AssetLoadHandle _modelHandle;

	private bool _isWaitingForAnimationComplete;

	private bool _wasInStartAnimation;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is PortalData data)
		{
			_data = data;
			_pathCenter = _data.initPos;
			_sitPos = _data.SitPos;
			SceneStatus sceneStatus = G.localPlayer.Profile.SceneStatus;
			SceneSpawnInfo spawnInfo = G.localPlayer.Profile.SceneInfos[(int)sceneStatus].SpawnInfo;
			if (spawnInfo != null && spawnInfo.InteractionObjUID == swid)
			{
				Singleton<TeleportMoveManager>.instance.SetData(_pathCenter, _sitPos, swid);
			}
			if (_data.ModelAssetID != null && _data.ModelAssetID.RuntimeKeyIsValid())
			{
				_modelHandle = AssetStationManager.BattleStation.Instantiate(_data.ModelAssetID, transform);
				_animator = _modelHandle.AsGameObject().GetComponent<Animator>();
			}
			base.InitStateObject(stateId);
		}
	}

	protected override void HandleInitState(int stateId)
	{
		base.HandleInitState(stateId);
		if (_animator != null)
		{
			_animator.SetInteger(State, stateId);
		}
		foreach (InteractEntry interactEntry in currentState.interactEntries)
		{
			interactEntry.onInteractAsync = (Func<Entity, UniTask>)Delegate.Combine(interactEntry.onInteractAsync, new Func<Entity, UniTask>(OnInteract));
		}
		if (stateId == 1)
		{
			_isWaitingForAnimationComplete = true;
			_wasInStartAnimation = false;
		}
	}

	private void Update()
	{
		if (_isWaitingForAnimationComplete && currentStateId == 1 && _animator != null)
		{
			bool flag = _animator.GetCurrentAnimatorStateInfo(0).IsName("EffectPillar_start");
			if (_wasInStartAnimation && !flag)
			{
				_isWaitingForAnimationComplete = false;
				_wasInStartAnimation = false;
				NetEnterState(-2).Forget();
			}
			else
			{
				_wasInStartAnimation = flag;
			}
		}
	}

	public override void ReleaseStateObject()
	{
		if (AssetLoadHandleExtensions.IsValid(_modelHandle))
		{
			AssetStationManager.BattleStation.ReleaseInstance(_modelHandle);
		}
		base.ReleaseStateObject();
	}

	private async UniTask OnInteract(Entity entityBehave)
	{
		Singleton<TeleportMoveManager>.instance.SetData(_pathCenter, _sitPos, swid);
		if (currentStateId == -2 && Singleton<GameState>.instance.CanEnterPlayerOperation(MonoECS.PlayerTag.TeleportMove))
		{
			MonoECS.instance.SetPlayerTag(MonoECS.PlayerTag.TeleportMove);
			GameManager.teleportMoveSystem.TryEnterTeleportMove();
		}
		MovementEvent evt = EventTrackSolver.Instance.GetEvt<MovementEvent>();
		evt.pos = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
		evt.eventType = 6;
		evt.swid = swid;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 0 && stateId != -2)
		{
			return stateId == 1;
		}
		return true;
	}

	public override ShowType GetInteractBtnShowType()
	{
		if (!Singleton<ProtagonistManager>.instance.IsProtagonist)
		{
			return ShowType.Show;
		}
		return ShowType.Hide;
	}

	public override bool ShowInteractTip()
	{
		return !Singleton<ProtagonistManager>.instance.IsProtagonist;
	}

	public override bool CanInteract()
	{
		if (!Singleton<ProtagonistManager>.instance.IsProtagonist)
		{
			return base.CanInteract();
		}
		return false;
	}
}
