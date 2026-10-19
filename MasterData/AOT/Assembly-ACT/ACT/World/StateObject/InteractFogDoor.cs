using System;
using ACT.Battle;
using ACT.Drama;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractFogDoor : StateObjectBase
{
	[SerializeField]
	private GameObject _modelRoot;

	[SerializeField]
	private Transform _tipIconTransform;

	private GameObject _leaveFieldRoot;

	private FogDoorData _data;

	private Vector3 _checkPoint;

	private Vector3 _teleportPoint;

	private InteractEntry _entry;

	private BoxCollider _triggerField;

	private Vector3 _modelScale;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (compStateObject?.StateWorldAssetData is FogDoorData data)
		{
			_data = data;
			_triggerField = GetComponent<BoxCollider>();
			_checkPoint = _data.CheckPoint;
			_teleportPoint = _data.TeleportPoint;
			_entry = InteractEntry.CreateButtonEntry(_data.name, _data.weight, _data.iconId, _data.TipIcon);
			if (_tipIconTransform != null)
			{
				_tipIconTransform.position = _data.TipIconPos;
				_entry.ResetTipTransform(_tipIconTransform);
			}
			InteractEntry entry = _entry;
			entry.onInteractAsync = (Func<Entity, UniTask>)Delegate.Combine(entry.onInteractAsync, new Func<Entity, UniTask>(PlayTimelineAsync));
			_entry.BindInteractObjectBase(this);
			_entry.BindData(compStateObject.StateWorldAssetData);
			_leaveFieldRoot = new GameObject();
			_leaveFieldRoot.transform.SetParent(transform, worldPositionStays: false);
			_leaveFieldRoot.AddComponent<TemporaryArea>().Init(_data.LeaveFields, OnLeaveFieldEnter, OnLeaveFieldExit);
			if (_modelRoot != null)
			{
				_modelRoot.transform.position = _data.ModelRoot.value;
				_modelRoot.transform.rotation = _data.ModelRoot.rotate;
				_modelRoot.transform.localScale = _data.ModelRoot.localScale;
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"[雾门交互物 -> {compStateObject.StateWorldAssetData.stateWorldAssetUid}] -> Wrap中没有配置ModelRoot，检查下");
			}
			_triggerField.center = _data.TriggerFiled.center;
			_triggerField.size = _data.TriggerFiled.size;
			base.InitStateObject(stateId);
		}
	}

	protected override void HandleInitState(int stateId)
	{
		if (_modelRoot != null)
		{
			_modelRoot.SetActive(stateId == 0);
		}
		_leaveFieldRoot.SetActive(stateId == 0);
		_triggerField.enabled = stateId == 0;
		if (currentStateId == 0)
		{
			_entry.HandleInit();
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		if (currentStateId == 0)
		{
			_entry.HandleUninit();
		}
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
		if (fromStateId == 0 && (toStateId == 1 || toStateId == -1))
		{
			_entry.HandleExit();
		}
		if (fromStateId == 1 && toStateId == 0)
		{
			int chunkIdBySGOID = Singleton<GameManager>.instance.worldManager.GetChunkIdBySGOID(swid);
			SceneTempArchiveInfo tmpArchiveInfo = new SceneTempArchiveInfo
			{
				Pos = _checkPoint.ToPB(),
				ChunkID = chunkIdBySGOID
			};
			Singleton<RespawnManager>.instance.RecordTmpArchivePos(tmpArchiveInfo, "雾门状态开启记录临时 Boss 存档点");
		}
	}

	private void RecoveryHp()
	{
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsLogicAvailable())
			{
				if (teamCharacter.IsAlive())
				{
					CompAbility? compAbility = teamCharacter.GetCompAbility();
					compAbility.ServerSetHP(compAbility.maxHP);
				}
				else
				{
					Singleton<RespawnManager>.instance.LocalEntityReborn(teamCharacter);
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Team_Refresh, null);
				}
			}
		}
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Player_Refresh, null);
	}

	private void OnLeaveFieldEnter()
	{
	}

	private void OnLeaveFieldExit()
	{
		G.service.CleanTmpArchivePos();
	}

	private async UniTask PlayTimelineAsync(Entity entityBehave)
	{
		_ = 3;
		try
		{
			Singleton<GameState>.instance.SetInPreparePosLogic(inPreparePosLogic: true);
			_entry.HandleExit();
			if (_data.timelineAsset.IsValid())
			{
				await Singleton<TimelineConversationManager>.instance.PlayTimeline(_data.timelineAsset, transform.position);
			}
			RecoverHp evt = EventTrackSolver.Instance.GetEvt<RecoverHp>();
			evt.teleportId = swid;
			EventTrackSolver.Instance.Dispatch(evt);
			RecoveryHp();
			await Singleton<NewUIManager>.instance.BlackLoad.Enable();
			int checkPointChunkId = Singleton<GameManager>.instance.worldManager.GetChunkIdBySGOID(swid);
			await ChangeChunkTp(_data.ChunkId, _teleportPoint, entityBehave);
			SceneTempArchiveInfo tmpArchiveInfo = new SceneTempArchiveInfo
			{
				Pos = _checkPoint.ToPB(),
				ChunkID = checkPointChunkId
			};
			Singleton<RespawnManager>.instance.RecordTmpArchivePos(tmpArchiveInfo, "雾门传送完成记录临时 Boss 存档点");
			await Singleton<NewUIManager>.instance.BlackLoad.Disable();
			Singleton<GameState>.instance.SetInPreparePosLogic(inPreparePosLogic: false);
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	private async UniTask ChangeChunkTp(int chunkId, Vector3 pos, Entity entity)
	{
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = _teleportPoint,
			faceLeft = false,
			forceToFloor = true,
			revive = false
		};
		await TeleportUtility.TeleportWithNone(chunkId, teleportParams);
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 0 && stateId != 1)
		{
			return stateId == -1;
		}
		return true;
	}

	protected override void HandleEnterInteract()
	{
		if (currentStateId == 0)
		{
			_entry.HandleEnter();
		}
	}

	protected override void HandleExitInteract()
	{
		if (currentStateId == 0)
		{
			_entry.HandleExit();
		}
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		_entry.HandleInteract(eb, InteractAction.InteractSource.Player);
	}

	protected override bool NeedInteractTip()
	{
		if (_entry == null || _entry.TipIcon == -1)
		{
			return base.NeedInteractTip();
		}
		return true;
	}

	protected override InteractEntry GetInteractEntry()
	{
		return _entry;
	}

	public override bool ShowInteractTip()
	{
		if (currentStateId == 0)
		{
			return Singleton<GameState>.instance.BattleState != BattleState.Boss;
		}
		return false;
	}
}
