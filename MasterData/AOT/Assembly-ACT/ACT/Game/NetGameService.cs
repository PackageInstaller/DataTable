using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Error;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.Local;
using ACT.MissionSystem;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.Net;
using ACT.UI;
using ACT.Utility;
using ACT.World;
using ACT.World.Asset;
using ACT.World.SceneChunks;
using Bamboo.Collections;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Pb;
using Runtime.Model.PowerModel;
using UnityEngine;
using bamboosdk;

namespace ACT.Game;

public class NetGameService : IGameService
{
	protected PlayerModule m_PlayerModule;

	protected IGameService.NetState _netState;

	private IGameService _gameServiceImplementation;

	public void SetNetState(IGameService.NetState state)
	{
		_netState = state;
	}

	public NetGameService()
	{
		m_PlayerModule = new PlayerModule();
	}

	private void SetTransNo(SceneStatus status, string transNo)
	{
		if (G.localPlayer.Profile.SceneInfos.ContainsKey((int)status))
		{
			G.localPlayer.Profile.SceneInfos[(int)status].TransNo = transNo;
			G.localPlayer.Profile.SceneInfos[(int)status].CheckPosUid = 0;
		}
		else
		{
			G.localPlayer.Profile.SceneInfos.Add((int)status, new SceneInfo
			{
				TransNo = transNo
			});
		}
	}

	public void CharacterBreakThrou(int characterID, int BreakThou, Action<bool> callback)
	{
		CharacterStageReq characterStageReq = new CharacterStageReq();
		characterStageReq.Id = characterID;
		characterStageReq.ToStage = BreakThou;
		Singleton<NetManager>.instance.Request(characterStageReq, (IMessage msg) =>
		{
			if (msg is CharacterStageAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void CharacterChangeWeapon(int characterId, int weaponUid, Action<bool> callback)
	{
		WeaponWearReq weaponWearReq = new WeaponWearReq();
		weaponWearReq.Uid = weaponUid;
		weaponWearReq.CharacterId = characterId;
		Character character = G.localPlayer.GetCharacter(characterId);
		_ = character.WeaponUid;
		Weapon weapon = G.localPlayer.Inventory.GetWeapon(weaponUid);
		ItemWeaponData data = CoreUtils.GetData(weapon.WeaponId, RuntimeConfigs.data.itemWeaponDatas);
		if (RuntimeConfigs.data.entityCharacterDatas[characterId].wp1Type == data.weaponType)
		{
			character.WeaponUid = weapon.Uid;
		}
		Singleton<NetManager>.instance.Request(weaponWearReq, (IMessage msg) =>
		{
			if (msg is WeaponWearAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void PickDropPack(uint id, Action<DropItemPickPackageAck> callback)
	{
		DropItemPickPackageReq dropItemPickPackageReq = new DropItemPickPackageReq();
		dropItemPickPackageReq.Id = id;
		Singleton<NetManager>.instance.Request(dropItemPickPackageReq, (IMessage msg) =>
		{
			if (msg is DropItemPickPackageAck obj)
			{
				callback?.Invoke(obj);
			}
		});
	}

	public void CharacterLevelUp(int characterID, List<Item> items, Action<bool> callback)
	{
		CharacterLevelUpReq characterLevelUpReq = new CharacterLevelUpReq();
		characterLevelUpReq.Id = characterID;
		characterLevelUpReq.Spends.Capacity = items.Count;
		foreach (Item item in items)
		{
			characterLevelUpReq.Spends.Add(item);
		}
		Singleton<NetManager>.instance.Request(characterLevelUpReq, (IMessage msg) =>
		{
			if (msg is CharacterLevelUpAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void CharacterRefine(int characterID, Action<bool> callback)
	{
		throw new NotImplementedException();
	}

	public void ChipDecompose(BSet<int> chips, Action<RepeatedField<Item>, bool> callback)
	{
		ChipDecomposeReq chipDecomposeReq = new ChipDecomposeReq();
		foreach (int chip in chips)
		{
			chipDecomposeReq.Uids.Add(chip);
		}
		Singleton<NetManager>.instance.Request(chipDecomposeReq, (IMessage msg) =>
		{
			if (msg is ChipDecomposeAck chipDecomposeAck)
			{
				callback?.Invoke(chipDecomposeAck.Items, arg2: true);
			}
			else
			{
				callback?.Invoke(null, arg2: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void CharacterChangeChip(int characterId, int chipUid, Action<bool> callback)
	{
		ChipWearReq chipWearReq = new ChipWearReq();
		chipWearReq.CharacterId = characterId;
		Singleton<NetManager>.instance.Request(chipWearReq, (IMessage msg) =>
		{
			if (msg is ChipWearAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void ChipCancelNewFlag(BSet<int> chipId, Action<bool> callback)
	{
		ChipCancelNewFlagReq chipCancelNewFlagReq = new ChipCancelNewFlagReq();
		foreach (int item in chipId)
		{
			chipCancelNewFlagReq.Uids.Add(item);
		}
		Singleton<NetManager>.instance.Request(chipCancelNewFlagReq, (IMessage msg) =>
		{
			if (msg is ChipCancelNewFlagAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void CharacterWearEquip(int uid, int characterId, Action<bool> callback)
	{
		EquipWearReq equipWearReq = new EquipWearReq();
		equipWearReq.CharacterId = characterId;
		equipWearReq.Uid = uid;
		Singleton<NetManager>.instance.Request(equipWearReq, (IMessage msg) =>
		{
			if (msg is EquipWearAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void EquipWearGem(int equipUid, int gemSlotId, bool operate, int gemUid, Action<bool> callback)
	{
		EquipGemOperateReq equipGemOperateReq = new EquipGemOperateReq();
		equipGemOperateReq.EquipUid = equipUid;
		equipGemOperateReq.GemSlotId = gemSlotId;
		equipGemOperateReq.Operate = operate;
		equipGemOperateReq.GemUid = gemUid;
		Singleton<NetManager>.instance.Request(equipGemOperateReq, (IMessage msg) =>
		{
			if (msg is EquipGemOperateAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void EquipLock(int equipUid, bool isLock, Action<bool> callback)
	{
		EquipLockReq equipLockReq = new EquipLockReq();
		equipLockReq.Uid = equipUid;
		equipLockReq.IsLock = isLock;
		Singleton<NetManager>.instance.Request(equipLockReq, (IMessage msg) =>
		{
			if (msg is EquipLockAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void GemLock(int gemUid, bool isLock, Action<bool> callback)
	{
		GemLockReq gemLockReq = new GemLockReq();
		gemLockReq.Uid = gemUid;
		gemLockReq.IsLock = isLock;
		Singleton<NetManager>.instance.Request(gemLockReq, (IMessage msg) =>
		{
			if (msg is GemLockAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void GemFusion(List<int> gemUids, Action<bool, RepeatedField<UniversalItem>> callback)
	{
		GemFusionReq gemFusionReq = new GemFusionReq();
		gemFusionReq.Uids.AddRange(gemUids);
		Singleton<NetManager>.instance.Request(gemFusionReq, (IMessage msg) =>
		{
			if (msg is GemFusionAck gemFusionAck)
			{
				callback?.Invoke(arg1: true, gemFusionAck.GotItems);
			}
			else
			{
				callback?.Invoke(arg1: false, null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void EquipDismantle(List<int> uids, Action<bool, RepeatedField<Item>> callback)
	{
		EquipDismantleReq equipDismantleReq = new EquipDismantleReq();
		equipDismantleReq.Uids.AddRange(uids);
		Singleton<NetManager>.instance.Request(equipDismantleReq, (IMessage msg) =>
		{
			if (msg is EquipDismantleAck equipDismantleAck)
			{
				callback?.Invoke(arg1: true, equipDismantleAck.Items);
			}
			else
			{
				callback?.Invoke(arg1: false, null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void EquipEnhance(int uid, int level, Action<bool> callback)
	{
		EquipEnhanceReq data = new EquipEnhanceReq
		{
			Uid = uid,
			Level = level
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is EquipEnhanceAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void EquipCreate(int id, Action<bool, RepeatedField<UniversalItem>> callback)
	{
		EquipCreateReq data = new EquipCreateReq
		{
			Id = id
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is EquipCreateAck equipCreateAck)
			{
				callback?.Invoke(arg1: true, equipCreateAck.GotItems);
			}
			else
			{
				callback?.Invoke(arg1: false, null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void LockGem(int gemUid, bool isLock, Action<bool> callback)
	{
		GemLockReq data = new GemLockReq
		{
			Uid = gemUid,
			IsLock = isLock
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is GemLockAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void LockEquip(int equipUid, bool isLock, Action<bool> callback)
	{
		EquipLockReq data = new EquipLockReq
		{
			Uid = equipUid,
			IsLock = isLock
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is EquipLockAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void CharacterUnloadChip(int characterId, int chipId, Action<bool> callback)
	{
		ChipUnloadReq chipUnloadReq = new ChipUnloadReq();
		chipUnloadReq.CharacterId = characterId;
		chipUnloadReq.ChipUid = chipId;
		Singleton<NetManager>.instance.Request(chipUnloadReq, (IMessage msg) =>
		{
			if (msg is ChipUnloadAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void ChipLevelUp(int chipUid, Action<bool> callback)
	{
		ChipLevelUpReq chipLevelUpReq = new ChipLevelUpReq();
		chipLevelUpReq.Uid = chipUid;
		Singleton<NetManager>.instance.Request(chipLevelUpReq, (IMessage msg) =>
		{
			if (msg is ChipLevelUpAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void LockChip(int chipUid, bool isLock, Action<bool> callback)
	{
		ChipLockReq chipLockReq = new ChipLockReq();
		chipLockReq.Uid = chipUid;
		chipLockReq.Lock = isLock;
		Singleton<NetManager>.instance.Request(chipLockReq, (IMessage msg) =>
		{
			if (msg is ChipLockAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void CollectionPointDrop(int collectionPointUID, Action<RepeatedField<DropItem>> callback)
	{
	}

	public void AcceptMission(int missionId, Action<bool> callback)
	{
		AcceptMissionReq acceptMissionReq = new AcceptMissionReq();
		acceptMissionReq.Id = missionId;
		Singleton<NetManager>.instance.Request(acceptMissionReq, (IMessage msg) =>
		{
			if (msg is AcceptMissionAck acceptMissionAck)
			{
				callback?.Invoke(acceptMissionAck.Ok);
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError(msg);
			}
		});
	}

	public void CompleteMissionBluePrint(ACT.Game.Data.MissionState mission, int id, Action<bool> callback)
	{
		if (mission.BluePrintIds.Contains(id))
		{
			return;
		}
		MissionUpdateBluePrintReq missionUpdateBluePrintReq = new MissionUpdateBluePrintReq();
		missionUpdateBluePrintReq.Mission = new ACT.Game.Data.MissionState();
		missionUpdateBluePrintReq.Mission.CopyFrom(mission);
		missionUpdateBluePrintReq.Mission.BluePrintIds.Add(id);
		Singleton<NetManager>.instance.Request(missionUpdateBluePrintReq, (IMessage msg) =>
		{
			if (msg is MissionUpdateBluePrintAck)
			{
				mission.BluePrintIds.Add(id);
				SubMissionBluePrintCompleteEvt evt = Singleton<EventManager>.instance.GetEvt<SubMissionBluePrintCompleteEvt>();
				evt.subMissionId = mission.SubMissionId;
				evt.bluePrintId = id;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.SubMission_BluePrintComplete, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
				callback?.Invoke(obj: true);
			}
			else
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
				callback?.Invoke(obj: false);
			}
		});
	}

	public void AcceptMission(int missionId)
	{
		MissionRAcceptReq missionRAcceptReq = new MissionRAcceptReq();
		missionRAcceptReq.MissionID = missionId;
		Singleton<NetManager>.instance.Request(missionRAcceptReq, (IMessage msg) =>
		{
		});
	}

	public void FailureMission(int missionId)
	{
		MissionRUpdateStateReq missionRUpdateStateReq = new MissionRUpdateStateReq();
		missionRUpdateStateReq.MissionID = missionId;
		missionRUpdateStateReq.State = ACT.Game.Data.MissionStateEnum.MissionStateFailed;
		Singleton<NetManager>.instance.Request(missionRUpdateStateReq, (IMessage msg) =>
		{
		});
	}

	public void GiveUpMission(int missionId)
	{
		MissionRUpdateStateReq missionRUpdateStateReq = new MissionRUpdateStateReq();
		missionRUpdateStateReq.MissionID = missionId;
		missionRUpdateStateReq.State = ACT.Game.Data.MissionStateEnum.MissionStateGiveup;
		Singleton<NetManager>.instance.Request(missionRUpdateStateReq, (IMessage msg) =>
		{
		});
	}

	public void SuccessMission(int missionId)
	{
		MissionRUpdateStateReq missionRUpdateStateReq = new MissionRUpdateStateReq();
		missionRUpdateStateReq.MissionID = missionId;
		missionRUpdateStateReq.State = ACT.Game.Data.MissionStateEnum.MissionStateSuccess;
		Singleton<NetManager>.instance.Request(missionRUpdateStateReq, (IMessage msg) =>
		{
		});
	}

	public void UpdateTracingMission(int missionId)
	{
		ReplacMissionTrackingReq replacMissionTrackingReq = new ReplacMissionTrackingReq();
		replacMissionTrackingReq.MissionID = missionId;
		Singleton<NetManager>.instance.Request(replacMissionTrackingReq, (IMessage msg) =>
		{
		});
	}

	public void UpdateMissionCondition(int missionId, MissionFlowType stageType, int stageIndex, int conditionId, int progress, bool success, Action<bool> callback = null)
	{
		MissionRConditionUpdateReq missionRConditionUpdateReq = new MissionRConditionUpdateReq();
		missionRConditionUpdateReq.MissionID = missionId;
		missionRConditionUpdateReq.FlowType = stageType;
		missionRConditionUpdateReq.FlowIndex = stageIndex;
		missionRConditionUpdateReq.Condition = new ACT.Game.Data.TriggerCondition();
		missionRConditionUpdateReq.Condition.Id = conditionId;
		missionRConditionUpdateReq.Condition.Progress = progress;
		missionRConditionUpdateReq.Condition.Done = success;
		if (!Singleton<NetManager>.instance.Request(missionRConditionUpdateReq, (IMessage msg) =>
		{
			callback?.Invoke(msg is MissionRConditionUpdateAck);
		}))
		{
			callback?.Invoke(obj: false);
		}
	}

	public void UpdateMissionAction(int missionId, MissionFlowType stageType, int stageIndex, int conditionGroupIndex, int actionId, int actionType, bool success, Action<bool> callback = null)
	{
		MissionRActionUpdateReq missionRActionUpdateReq = new MissionRActionUpdateReq();
		missionRActionUpdateReq.MissionID = missionId;
		missionRActionUpdateReq.FlowType = stageType;
		missionRActionUpdateReq.FlowIndex = stageIndex;
		missionRActionUpdateReq.PairIdx = conditionGroupIndex;
		missionRActionUpdateReq.Action = new TriggerAction();
		missionRActionUpdateReq.Action.Id = actionId;
		missionRActionUpdateReq.Action.Type = actionType;
		missionRActionUpdateReq.Action.Done = true;
		Singleton<NetManager>.instance.Request(missionRActionUpdateReq, (IMessage msg) =>
		{
			if (msg is MissionRActionUpdateAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
				callback?.Invoke(obj: false);
			}
		});
	}

	public void UpdateMissionStage(int missionId, MissionFlowType stageType, int newMissionStage, Action<IMessage> callback = null)
	{
		ACT.MissionSystem.MissionData missionData = Singleton<MissionManager>.instance.GetMissionData(missionId);
		MissionStageData missionStageData = null;
		switch (stageType)
		{
		case MissionFlowType.Normal:
			missionStageData = missionData.Stages[newMissionStage];
			break;
		case MissionFlowType.Fail:
			missionStageData = missionData.Failure;
			break;
		case MissionFlowType.Extra:
			missionStageData = missionData.Extra;
			break;
		}
		MissionRUpdateFlowReq missionRUpdateFlowReq = new MissionRUpdateFlowReq();
		missionRUpdateFlowReq.MissionID = missionId;
		missionRUpdateFlowReq.FlowType = stageType;
		missionRUpdateFlowReq.Flow = new ACT.Game.Data.MissionFlow();
		MissionConditionGroupData[] conditionGroups = missionStageData.conditionGroups;
		foreach (MissionConditionGroupData missionConditionGroupData in conditionGroups)
		{
			TriggerConditionActionPair triggerConditionActionPair = new TriggerConditionActionPair();
			missionRUpdateFlowReq.Flow.ConditionActionPairs.Add(triggerConditionActionPair);
			missionRUpdateFlowReq.Flow.DoneCount = 0;
			missionRUpdateFlowReq.Flow.CurConditionGroupIdx = 0;
			MissionConditionData[] conditions = missionConditionGroupData.conditions;
			foreach (MissionConditionData missionConditionData in conditions)
			{
				ACT.Game.Data.TriggerCondition triggerCondition = new ACT.Game.Data.TriggerCondition();
				triggerConditionActionPair.Conditions.Add(triggerCondition);
				triggerCondition.Done = false;
				triggerCondition.Progress = 0;
				triggerCondition.Id = missionConditionData.Id;
				triggerCondition.Type = missionConditionData.Type;
			}
			MissionActionData[] actions = missionConditionGroupData.actions;
			foreach (MissionActionData missionActionData in actions)
			{
				TriggerAction triggerAction = new TriggerAction();
				triggerConditionActionPair.Actions.Add(triggerAction);
				triggerAction.Done = false;
				triggerAction.Id = missionActionData.Id;
				triggerAction.Type = missionActionData.Type;
			}
		}
		Singleton<NetManager>.instance.Request(missionRUpdateFlowReq, (IMessage msg) =>
		{
			callback?.Invoke(msg);
		});
	}

	public void SendGetTempleRewards(int areaId, int rewardStarLevel, Action<bool, TempleTakeStarRewardAck> callback)
	{
		TempleTakeStarRewardReq templeTakeStarRewardReq = new TempleTakeStarRewardReq();
		templeTakeStarRewardReq.AreaId = areaId;
		templeTakeStarRewardReq.StarNum = rewardStarLevel;
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("=============req.AreaId: " + templeTakeStarRewardReq.AreaId + ", req.StarNum:" + templeTakeStarRewardReq.StarNum);
		}
		Singleton<NetManager>.instance.Request(templeTakeStarRewardReq, (IMessage msg) =>
		{
			TempleTakeStarRewardAck arg = msg as TempleTakeStarRewardAck;
			callback?.Invoke(msg is TempleTakeStarRewardAck, arg);
		});
	}

	public void UnlockTemple(int templeId, Action<bool> callback)
	{
		TempleUnlockReq templeUnlockReq = new TempleUnlockReq();
		templeUnlockReq.TempleId = templeId;
		Singleton<NetManager>.instance.Request(templeUnlockReq, (IMessage msg) =>
		{
			callback?.Invoke(msg is TempleUnlockAck);
		});
	}

	public void EnterTempleChallenge(int templeId, TeamUsage teamUsage, Action<bool> callback)
	{
		TempleChallengeReq templeChallengeReq = new TempleChallengeReq();
		templeChallengeReq.TempleId = templeId;
		templeChallengeReq.Team = teamUsage;
		Singleton<NetManager>.instance.Request(templeChallengeReq, (IMessage msg) =>
		{
			if (msg is TempleChallengeAck templeChallengeAck)
			{
				Model<TempleModel>.Interface.UpdateTemple(templeChallengeAck.TempleInfo);
				Model<CharacterRepositoryModel>.Interface.RemoveCharacterRepository(5);
				Model<CharacterRepositoryModel>.Interface.AddCharacterRepository(5, templeChallengeAck.CharacterRepository);
				TeamInfoExtension.SetTeamInfo(5, teamUsage);
				SetTransNo(SceneStatus.Temple, templeChallengeAck.TransNo);
				callback?.Invoke(obj: true);
			}
			else
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
				callback?.Invoke(obj: false);
			}
		});
	}

	public void TempleRechallenge(Action<bool> callback)
	{
		TempleRechallengeReq templeRechallengeReq = new TempleRechallengeReq();
		templeRechallengeReq.SettleInfo = GetSettleInfo();
		Singleton<NetManager>.instance.Request(templeRechallengeReq, (IMessage msg) =>
		{
			if (msg is TempleRechallengeAck templeRechallengeAck)
			{
				Model<ChallengeTargetTrackerModel>.Interface.StopTracking();
				Model<TempleModel>.Interface.ClearBattleTempleBuffData();
				Model<TempleModel>.Interface.UpdateTemple(templeRechallengeAck.TempleInfo);
				SetTransNo(SceneStatus.Temple, templeRechallengeAck.TransNo);
				G.localPlayer.Profile.SceneInfos[5].LastPos = null;
				Model<CharacterRepositoryModel>.Interface.RemoveCharacterRepository(5);
				Model<CharacterRepositoryModel>.Interface.AddCharacterRepository(5, templeRechallengeAck.CharacterRepository);
			}
			callback?.Invoke(msg is TempleRechallengeAck);
		});
	}

	public void LeaveTemple(Action<bool> callback, bool resetData)
	{
		TempleLeaveReq templeLeaveReq = new TempleLeaveReq();
		templeLeaveReq.SettleInfo = GetSettleInfo();
		Singleton<NetManager>.instance.Request(templeLeaveReq, (IMessage msg) =>
		{
			if (msg is TempleLeaveAck)
			{
				Model<ChallengeTargetTrackerModel>.Interface.StopTracking();
				Model<TempleModel>.Interface.ClearBattleTempleBuffData();
				Model<TempleModel>.Interface.UpdateTemple(null, resetData);
				G.localPlayer.teamInfo.Teams.Remove(5);
				Model<CharacterRepositoryModel>.Interface.RemoveCharacterRepository(5);
			}
			callback?.Invoke(msg is TempleLeaveAck);
		});
	}

	public void CompleteTempleStage(Action<RepeatedField<UniversalItem>> callback)
	{
		if (Model<ChallengeTargetTrackerModel>.HasInstance())
		{
			Model<ChallengeTargetTrackerModel>.Interface.MarkChallengeCompleted();
		}
		TempleCompleteStageReq templeCompleteStageReq = new TempleCompleteStageReq();
		templeCompleteStageReq.SettleInfo = GetSettleInfo();
		Singleton<NetManager>.instance.Request(templeCompleteStageReq, (IMessage msg) =>
		{
			if (msg is TempleCompleteStageAck templeCompleteStageAck)
			{
				Model<ChallengeTargetTrackerModel>.Interface.StopTracking();
				Model<TempleModel>.Interface.UpdateTemple(templeCompleteStageAck.NewInfo);
				if (Model<BattleMainModel>.HasInstance())
				{
					Model<BattleMainModel>.Interface.NeedReDisplayPlayerExp();
				}
				RepeatedField<UniversalItem> obj = Model<InventoryModel>.Interface.NewInventoryOverflowHandle(templeCompleteStageAck.GotRewards);
				callback?.Invoke(obj);
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError(msg);
			}
		});
	}

	public void SyncBattleTempleBuffSelection(int roomIndex, int buffId, Action<bool> callback)
	{
		TempleSelectBuffReq templeSelectBuffReq = new TempleSelectBuffReq();
		templeSelectBuffReq.RoomId = roomIndex;
		templeSelectBuffReq.BuffId = buffId;
		Singleton<NetManager>.instance.Request(templeSelectBuffReq, (IMessage msg) =>
		{
			if (msg is TempleSelectBuffAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
				callback?.Invoke(obj: false);
			}
		});
	}

	public void TempleFailure(Action callback)
	{
		TempleFailureReq templeFailureReq = new TempleFailureReq();
		templeFailureReq.SettleInfo = GetSettleInfo();
		Singleton<NetManager>.instance.Request(templeFailureReq, (IMessage message) =>
		{
			callback?.Invoke();
		});
	}

	public void RaidFailure(Action callback)
	{
		RaidFailureReq raidFailureReq = new RaidFailureReq();
		raidFailureReq.SettleInfo = GetSettleInfo();
		Singleton<NetManager>.instance.Request(raidFailureReq, (IMessage message) =>
		{
			callback?.Invoke();
		});
	}

	public void AbyssFailure(Action callback)
	{
		AbyssFailureReq abyssFailureReq = new AbyssFailureReq();
		abyssFailureReq.SettleInfo = GetSettleInfo();
		Singleton<NetManager>.instance.Request(abyssFailureReq, (IMessage message) =>
		{
			callback?.Invoke();
		});
	}

	public void EnterTrainingGround(Action<bool> callback)
	{
		EnterTrainingGroundAsync(callback).Forget();
	}

	private async UniTask EnterTrainingGroundAsync(Action<bool> callback)
	{
		int worldId = Model<TrainingGroundModel>.Interface.enemyConfig.worldId;
		if (!RuntimeConfigs.data.gameWorlds.TryGetValue(worldId, out var gameWorld))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"找不到训练场[{worldId}]的GameWorld配置");
			}
			callback?.Invoke(obj: false);
			return;
		}
		WorldPartitionSettingData data = WorldPartitionSetting.Data;
		if (data == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("无法加载WorldPartition配置清单");
			}
			callback?.Invoke(obj: false);
			return;
		}
		ILoadPartitionResult<ConfigWorldPartition_v2> loadPartitionResult = await data.TryLoadPartition(gameWorld.config, isMainWorld: false);
		ConfigWorldPartition_v2 data2 = loadPartitionResult.Data;
		SceneChunk sceneChunk = data2?.SceneChunks?.FirstOrDefault();
		if (!loadPartitionResult.Success || data2 == null || sceneChunk == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"无法从训练场[{worldId}]的WorldPartition[{gameWorld.config}]读取默认Chunk和出生点");
			}
			callback?.Invoke(obj: false);
			return;
		}
		TrainingGroundEnterReq data3 = new TrainingGroundEnterReq
		{
			SceneParam = new ScenePosParam
			{
				GameworldID = worldId,
				ChunkID = sceneChunk.ChunkId,
				Pos = data2.SpawnPosition.ToPB()
			}
		};
		Singleton<NetManager>.instance.Request(data3, (IMessage message) =>
		{
			if (message is TrainingGroundEnterAck trainingGroundEnterAck)
			{
				Model<CharacterRepositoryModel>.Interface.RemoveCharacterRepository(4);
				Model<CharacterRepositoryModel>.Interface.AddCharacterRepository(4, trainingGroundEnterAck.CharacterRepository);
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void LeaveTrainingGround(Action<bool> callback)
	{
		TrainingGroundLeaveReq data = new TrainingGroundLeaveReq();
		Singleton<NetManager>.instance.Request(data, (IMessage message) =>
		{
			if (message is TrainingGroundLeaveAck)
			{
				Model<CharacterRepositoryModel>.Interface.RemoveCharacterRepository(4);
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void SendActivityGainReward(int activityId, int activitySubGroupId, int subActivityId, Action<ActivityGetLevelRewardAck> callback)
	{
		ActivityGetLevelRewardReq activityGetLevelRewardReq = new ActivityGetLevelRewardReq();
		activityGetLevelRewardReq.ActivityId = activityId;
		activityGetLevelRewardReq.ActivityGroup = activitySubGroupId;
		activityGetLevelRewardReq.ActivityChallenge = subActivityId;
		Singleton<NetManager>.instance.Request(activityGetLevelRewardReq, (IMessage msg) =>
		{
			callback?.Invoke(msg as ActivityGetLevelRewardAck);
		});
	}

	public void SendDoubleDungeonReward(int activityId, int rewardBoxId, Action<bool> callback)
	{
		ActivityDoubleDungeonRewardReq activityDoubleDungeonRewardReq = new ActivityDoubleDungeonRewardReq();
		activityDoubleDungeonRewardReq.ActivityId = activityId;
		activityDoubleDungeonRewardReq.RewardId = rewardBoxId;
		Singleton<NetManager>.instance.Request(activityDoubleDungeonRewardReq, (IMessage msg) =>
		{
			callback?.Invoke(msg is ActivityDoubleDungeonRewardAck);
		});
	}

	public void SendActivityCombinationReward(int activityId, int activitySubGroupId, Action<bool, ActivityCombinationRewardAck> callback)
	{
		ActivityCombinationRewardReq activityCombinationRewardReq = new ActivityCombinationRewardReq();
		activityCombinationRewardReq.ActivityId = activityId;
		activityCombinationRewardReq.ActivityGroup = activitySubGroupId;
		Singleton<NetManager>.instance.Request(activityCombinationRewardReq, (IMessage msg) =>
		{
			ActivityCombinationRewardAck arg = msg as ActivityCombinationRewardAck;
			callback?.Invoke(msg is ActivityCombinationRewardAck, arg);
		});
	}

	public void SendActivityMainStoryReward(int activityId, int activityGroup, Action<ActivityMainStoryRewardAck> callback)
	{
		ActivityMainStoryRewardReq data = new ActivityMainStoryRewardReq
		{
			ActivityId = activityId,
			ActivityGroup = activityGroup
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			callback?.Invoke(msg as ActivityMainStoryRewardAck);
		});
	}

	public void SendActivityMapExploreReward(int activityId, int activityGroup, Action<ActivityMapExploreRewardAck> callback)
	{
		ActivityMapExploreRewardReq data = new ActivityMapExploreRewardReq
		{
			ActivityId = activityId,
			ActivityGroup = activityGroup
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			callback?.Invoke(msg as ActivityMapExploreRewardAck);
		});
	}

	public void SendActivityMultiDeviceReward(int activityId, int activityGroup, int activityChallenge, Action<ActivityMultiDeviceRewardAck> callback)
	{
		ActivityMultiDeviceRewardReq data = new ActivityMultiDeviceRewardReq
		{
			ActivityId = activityId,
			ActivityGroup = activityGroup,
			ActivityChallenge = activityChallenge
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			callback?.Invoke(msg as ActivityMultiDeviceRewardAck);
		});
	}

	public void GetDropItem(List<int> dropItemUIDs, Action<DropItemPickItemAck> callback)
	{
		DropItemPickItemReq dropItemPickItemReq = new DropItemPickItemReq();
		for (int i = 0; i < dropItemUIDs.Count; i++)
		{
			dropItemPickItemReq.Uids.Add(dropItemUIDs[i]);
		}
		Singleton<NetManager>.instance.Request(dropItemPickItemReq, (IMessage msg) =>
		{
			if (msg is DropItemPickItemAck dropItemPickItemAck)
			{
				for (int num = dropItemPickItemAck.DropRes.Count - 1; num >= 0; num--)
				{
					DropItemPickInfo dropItemPickInfo = dropItemPickItemAck.DropRes[num];
					if (dropItemPickInfo.Err != PickErr.PickBagFullErr)
					{
						if (G.localPlayer.Maps.TryGetValue(dropItemPickItemAck.Wid, out var value))
						{
							value.DropItems.Remove(dropItemPickInfo.Uid);
						}
					}
					else if (LuminApplication.LogEnabled)
					{
						Debug.LogWarning("背包满了？？？");
					}
				}
				callback?.Invoke(dropItemPickItemAck);
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError(msg);
			}
		});
	}

	public void RecordTmpArchivePos(SceneTempArchiveInfo info)
	{
		G.localPlayer.Profile.SceneInfos[(int)G.localPlayer.Profile.SceneStatus].TmpArchiveInfo = info;
		RecordTmpArchivePosReq data = new RecordTmpArchivePosReq
		{
			Info = info
		};
		Singleton<NetManager>.instance.Post(data);
	}

	public void CleanTmpArchivePos()
	{
		RecordTmpArchivePosReq data = new RecordTmpArchivePosReq
		{
			Info = null
		};
		G.localPlayer.Profile.SceneInfos[(int)G.localPlayer.Profile.SceneStatus].TmpArchiveInfo = null;
		Singleton<NetManager>.instance.Post(data);
	}

	public void RecordCheckPos(int uid)
	{
		PlayerProfile profile = G.localPlayer.Profile;
		profile.SceneInfos[(int)profile.SceneStatus].CheckPosUid = uid;
		RecordCheckPosReq data = new RecordCheckPosReq
		{
			Uid = uid
		};
		Singleton<NetManager>.instance.Post(data);
	}

	public void RecordSpawnPos(SceneSpawnInfo spawnInfo)
	{
		PlayerProfile profile = G.localPlayer.Profile;
		profile.SceneInfos[(int)profile.SceneStatus].SpawnInfo = spawnInfo;
		RecordSpawnPosReq recordSpawnPosReq = new RecordSpawnPosReq();
		recordSpawnPosReq.Info = spawnInfo;
		Singleton<NetManager>.instance.Post(recordSpawnPosReq);
	}

	public void SyncCharacterCharacteristic(Dictionary<int, CharacterStatus> characterStatus, int battleCharacterId)
	{
		CharacterStatusSyncReq characterStatusSyncReq = new CharacterStatusSyncReq();
		foreach (KeyValuePair<int, CharacterStatus> item in characterStatus)
		{
			characterStatusSyncReq.Cs.Add(item.Key, item.Value);
		}
		characterStatusSyncReq.BattleCharacterId = battleCharacterId;
		Singleton<NetManager>.instance.Post(characterStatusSyncReq);
	}

	public void SyncGameInfoReq(SyncGameInfoReq req, Action<bool> callback)
	{
		Singleton<NetManager>.instance.Request(req, (IMessage msg) =>
		{
			if (msg is SyncGameInfoAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void CreateBloodstain(BloodstainCreateRequest request, Action<bool, BloodstainData> callback)
	{
		PlayerDeadReq data = new PlayerDeadReq
		{
			Position = request.Position.ToPB(),
			ChunkId = request.ChunkId,
			CreateBloodstain = true
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is PlayerDeadAck { BloodstainInfo: not null } playerDeadAck && BloodstainModel.TryCreateBloodstainData(playerDeadAck.BloodstainInfo.SelfBloodstain, out var data2))
			{
				callback?.Invoke(arg1: true, data2);
			}
			else
			{
				callback?.Invoke(arg1: false, null);
			}
		});
	}

	public void ClaimBloodstain(string bloodstainId, Action<bool, IList<UniversalItem>> callback)
	{
		if (string.IsNullOrEmpty(bloodstainId))
		{
			callback?.Invoke(arg1: false, null);
			return;
		}
		BloodStainInteractReq data = new BloodStainInteractReq
		{
			BloodstainId = bloodstainId
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is BloodStainInteractAck bloodStainInteractAck)
			{
				callback?.Invoke(arg1: true, bloodStainInteractAck.Rewards);
			}
			else
			{
				callback?.Invoke(arg1: false, null);
			}
		});
	}

	public void SetBloodStainEnable(bool isEnable, Action<bool> callback)
	{
		SetBloodStainEnableReq data = new SetBloodStainEnableReq
		{
			Enable = isEnable
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is SetBloodStainEnableAck setBloodStainEnableAck)
			{
				Model<BloodstainModel>.Interface.OtherBloodstainDisabled = setBloodStainEnableAck.BloodstainInfo.OtherBloodstainDisabled;
				callback?.Invoke(setBloodStainEnableAck.BloodstainInfo.OtherBloodstainDisabled);
			}
		});
	}

	public void SceneSwitch(Vector3 pos, int chunkId, int worldId, SceneStatus sceneStatus, int areaId, Action<bool> callback = null)
	{
		IMessage data = new SceneSwitchReq
		{
			Wid = worldId,
			Cid = chunkId,
			Position = pos.ToPB(),
			AreaId = areaId
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is SceneSwitchAck)
			{
				int key = (int)sceneStatus;
				G.localPlayer.Profile.SceneInfos[key].WorldID = worldId;
				G.localPlayer.Profile.SceneInfos[key].ChunkID = chunkId;
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void WeaponBreak(int weaponUid, Action<bool> callback)
	{
		WeaponStageReq weaponStageReq = new WeaponStageReq();
		weaponStageReq.Uid = weaponUid;
		Singleton<NetManager>.instance.Request(weaponStageReq, (IMessage msg) =>
		{
			if (msg is WeaponStageAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void WeaponLock(int weaponUid, bool locked, Action<bool> callback)
	{
		WeaponLockReq weaponLockReq = new WeaponLockReq();
		weaponLockReq.Uid = weaponUid;
		weaponLockReq.Lock = locked;
		Singleton<NetManager>.instance.Request(weaponLockReq, (IMessage msg) =>
		{
			if (msg is WeaponLockAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void WeaponLevelUp(int weaponUid, List<Item> items, List<Weapon> weapons, Action<bool> callback)
	{
		WeaponLevelUpReq weaponLevelUpReq = new WeaponLevelUpReq();
		weaponLevelUpReq.Uid = weaponUid;
		weaponLevelUpReq.SpendItems.Capacity = items.Count;
		foreach (Item item in items)
		{
			weaponLevelUpReq.SpendItems.Add(item);
		}
		weaponLevelUpReq.SpendWeaponUids.Capacity = weapons.Count;
		foreach (Weapon weapon in weapons)
		{
			weaponLevelUpReq.SpendWeaponUids.Add(weapon.Uid);
		}
		Singleton<NetManager>.instance.Request(weaponLevelUpReq, (IMessage msg) =>
		{
			if (msg is WeaponLevelUpAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void WeaponRefine(int weaponUid, int consumeWeaponUid, Action<bool> callback)
	{
		WeaponRefineReq weaponRefineReq = new WeaponRefineReq();
		weaponRefineReq.Uid = weaponUid;
		weaponRefineReq.SpendUid = consumeWeaponUid;
		Singleton<NetManager>.instance.Request(weaponRefineReq, (IMessage msg) =>
		{
			if (msg is WeaponRefineAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void SetFishBait(int fishBit, Action<bool> callBack)
	{
		FishSetupReq fishSetupReq = new FishSetupReq();
		fishSetupReq.FishBait = fishBit;
		Singleton<NetManager>.instance.Request(fishSetupReq, (IMessage msg) =>
		{
			if (msg is FishSetupAck)
			{
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
			}
		});
	}

	public void FishStart(Action<FishStartAck> callBack)
	{
		FishStartReq data = new FishStartReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is FishStartAck obj)
			{
				callBack(obj);
			}
		});
	}

	public void FishIsSuccess(long nowTime, Action<FishAck> callBack)
	{
		FishReq fishReq = new FishReq();
		fishReq.Ts = nowTime;
		Singleton<NetManager>.instance.Request(fishReq, (IMessage msg) =>
		{
			if (msg is FishAck obj)
			{
				callBack(obj);
			}
			else
			{
				callBack(null);
			}
		});
	}

	public void MakingProducts(int productId, int productCount, Action callback)
	{
		RecipeMakeReq recipeMakeReq = new RecipeMakeReq();
		recipeMakeReq.Id = productId;
		recipeMakeReq.Count = productCount;
		Singleton<NetManager>.instance.Request(recipeMakeReq, (IMessage msg) =>
		{
			if (msg is RecipeMakeAck)
			{
				callback?.Invoke();
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError(msg);
			}
		});
	}

	public void PingMessage()
	{
		PingReq data = new PingReq();
		long sendTime = TimeManager.ServerTime.NowTimestamp;
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			MonoECS.instance.ResetPingMessage(TimeManager.ServerTime.NowTimestamp - sendTime);
			if (msg is PingAck pingAck)
			{
				TimeManager.ServerTime.SetTimestamp(pingAck.Ts);
			}
		});
	}

	public void UnLockAssistSkinColor(int assistId, int skinId, int colorId, Action callback)
	{
		AssistDyeingReq assistDyeingReq = new AssistDyeingReq();
		assistDyeingReq.Assist = assistId;
		assistDyeingReq.Skin = skinId;
		assistDyeingReq.Color = colorId;
		Singleton<NetManager>.instance.Request(assistDyeingReq, (IMessage msg) =>
		{
			if (msg is AssistDyeingAck)
			{
				callback?.Invoke();
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError(msg);
			}
		});
	}

	public void PlayerAddCustomMapIcon(int mapArea, int iconType, Vector3 worldPos, Action<int, int, int, Vector3> callback)
	{
		MapSetupCustomFlagReq mapSetupCustomFlagReq = new MapSetupCustomFlagReq();
		mapSetupCustomFlagReq.Cf = new MapCustomFlag();
		mapSetupCustomFlagReq.Cf.AreaID = mapArea;
		mapSetupCustomFlagReq.Cf.Id = 0;
		mapSetupCustomFlagReq.Cf.Tid = iconType;
		PBVector3 pBVector = new PBVector3();
		pBVector.X = worldPos.x;
		pBVector.Y = worldPos.y;
		pBVector.Z = worldPos.z;
		mapSetupCustomFlagReq.Cf.Pos = pBVector;
		Singleton<NetManager>.instance.Request(mapSetupCustomFlagReq, (IMessage msg) =>
		{
			if (msg is MapSetupCustomFlagAck mapSetupCustomFlagAck)
			{
				Model<MapSelfNodeModel>.Interface.UpdateModelAreaFlags(mapSetupCustomFlagAck.Cf);
				callback?.Invoke(mapSetupCustomFlagAck.Cf.AreaID, mapSetupCustomFlagAck.Cf.Id, mapSetupCustomFlagAck.Cf.Tid, worldPos);
			}
		});
	}

	public void DeleteCustomMapIcon(int id, Action callback)
	{
		MapDelCustomFlagReq mapDelCustomFlagReq = new MapDelCustomFlagReq();
		SelfNodeData selfNode = Model<MapSelfNodeModel>.Interface.GetSelfNode(id);
		if (selfNode == null)
		{
			return;
		}
		mapDelCustomFlagReq.FlagID = selfNode.id;
		mapDelCustomFlagReq.AreaID = (int)selfNode.mapArea;
		Singleton<NetManager>.instance.Request(mapDelCustomFlagReq, (IMessage msg) =>
		{
			if (msg is MapDelCustomFlagAck)
			{
				Model<MapSelfNodeModel>.Interface.RemoveSelfNode(id);
				callback?.Invoke();
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError(msg);
			}
		});
	}

	public void ModifyCustomMapFlagType(int mapArea, int id, int iconType, Action callback)
	{
		MapModifyCustomFlagTypeReq mapModifyCustomFlagTypeReq = new MapModifyCustomFlagTypeReq();
		SelfNodeData selfNode = Model<MapSelfNodeModel>.Interface.GetSelfNode(id);
		if (selfNode == null)
		{
			return;
		}
		mapModifyCustomFlagTypeReq.FlagID = selfNode.id;
		mapModifyCustomFlagTypeReq.AreaID = (int)selfNode.mapArea;
		mapModifyCustomFlagTypeReq.NewTyp = iconType;
		Singleton<NetManager>.instance.Request(mapModifyCustomFlagTypeReq, (IMessage msg) =>
		{
			if (msg is MapModifyCustomFlagTypeAck mapModifyCustomFlagTypeAck)
			{
				Model<MapSelfNodeModel>.Interface.UpdateModelAreaFlags(mapModifyCustomFlagTypeAck.LatestCustomFlag);
				callback?.Invoke();
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError(msg);
			}
		});
	}

	public void MapSetupTracePoint(int mapArea, int id, int iconType, bool isCancel, Action callback = null)
	{
		MapSetupTracePointReq mapSetupTracePointReq = new MapSetupTracePointReq();
		MapTrancePoint mapTrancePoint = new MapTrancePoint();
		mapTrancePoint.AreaID = mapArea;
		mapTrancePoint.PointType = (MapTracePointEnum)iconType;
		mapTrancePoint.PointID = id;
		mapSetupTracePointReq.Cancel = isCancel;
		mapSetupTracePointReq.Point = mapTrancePoint;
		Singleton<NetManager>.instance.Request(mapSetupTracePointReq, (IMessage msg) =>
		{
			if (isCancel)
			{
				Model<MapModel>.Interface.SetMapPointTraceInfo(0, 0, 0);
			}
			else
			{
				Model<MapModel>.Interface.SetMapPointTraceInfo(mapArea, iconType, id);
			}
			callback?.Invoke();
		});
	}

	public void MapAreaExploreQuery(Action callback = null)
	{
		MapAreaExploreQueryReq data = new MapAreaExploreQueryReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is MapAreaExploreQueryAck mapAreaExploreQueryAck)
			{
				Model<MapModel>.Interface.InitMapExploreData(mapAreaExploreQueryAck.AreaExplore.ToDictionary((KeyValuePair<int, MapAreaExplore> explore) => explore.Value.Id, (KeyValuePair<int, MapAreaExplore> explore) => explore.Value));
				if (callback != null)
				{
					callback();
				}
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError(msg);
			}
		});
	}

	public void MapAreaExploreReward(int areaId, int type, Action callback = null)
	{
		MapExploreClaimRewardReq mapExploreClaimRewardReq = new MapExploreClaimRewardReq();
		mapExploreClaimRewardReq.AreaId = areaId;
		mapExploreClaimRewardReq.AreaType = type;
		Singleton<NetManager>.instance.Request(mapExploreClaimRewardReq, (IMessage msg) =>
		{
			if (msg is MapExploreClaimRewardAck mapExploreClaimRewardAck)
			{
				List<Item> list = new List<Item>();
				foreach (UniversalItem gotItem in mapExploreClaimRewardAck.GotItems)
				{
					Item item = new Item
					{
						Id = gotItem.Index,
						Count = gotItem.Count
					};
					list.Add(item);
				}
				GameUtility.OpenPopReward(GameUtility.ToUniversalItems(list));
				Model<MapModel>.Interface.UpdateMapExploreData(mapExploreClaimRewardAck.AreaExplore);
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_MapExploreRewardReceiveEvt, null);
				if (callback != null)
				{
					callback();
				}
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError(msg);
			}
		});
	}

	public void BattleTeamChange(int index, Action callback)
	{
		RecordBattleTeamReq recordBattleTeamReq = new RecordBattleTeamReq();
		recordBattleTeamReq.Idx = index;
		Singleton<NetManager>.instance.Request(recordBattleTeamReq, (IMessage msg) =>
		{
			if (msg is RecordBattleTeamAck)
			{
				G.localPlayer.teamInfo.MainTeamIdx = index;
				callback?.Invoke();
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError(msg);
			}
		});
	}

	public void SaveTeamProfile(List<PresetTeam> teams, int mainTeamIndex, Action<bool> callback)
	{
		SavePresetTeamsReq savePresetTeamsReq = new SavePresetTeamsReq();
		savePresetTeamsReq.Teams.AddRange(teams);
		savePresetTeamsReq.MainTeamIdx = mainTeamIndex;
		Singleton<NetManager>.instance.Request(savePresetTeamsReq, (IMessage msg) =>
		{
			if (msg is SavePresetTeamsAck)
			{
				G.localPlayer.teamInfo.MainTeamIdx = mainTeamIndex;
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void TeamCharacterChange(PresetTeam teamProfile, int index, Action<bool> callback)
	{
		ReplacePresetTeamReq replacePresetTeamReq = new ReplacePresetTeamReq();
		replacePresetTeamReq.Idx = index;
		replacePresetTeamReq.PresetTeam = teamProfile;
		Singleton<NetManager>.instance.Request(replacePresetTeamReq, (IMessage msg) =>
		{
			if (msg is ReplacePresetTeamAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void DyeingAssist(int assistId, int skinId, int colorId, Action callback)
	{
		AssistSetupReq assistSetupReq = new AssistSetupReq();
		assistSetupReq.Assist = assistId;
		assistSetupReq.Skin = skinId;
		assistSetupReq.Color = colorId;
		Singleton<NetManager>.instance.Request(assistSetupReq, (IMessage msg) =>
		{
			if (msg is AssistSetupAck)
			{
				callback?.Invoke();
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError(msg);
			}
		});
	}

	public void AssistEquip(int assistId, Action callback)
	{
		AssistEquipReq assistEquipReq = new AssistEquipReq();
		assistEquipReq.Assist = assistId;
		Singleton<NetManager>.instance.Request(assistEquipReq, (IMessage msg) =>
		{
			if (msg is AssistEquipAck)
			{
				callback?.Invoke();
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError(msg);
			}
		});
	}

	public async void ChangeServiceSaveState(int wid, int swid, int stateId, bool sync, MapViewRecordParam mapViewRecordParam, Action callback, ItemCheck itemCheck = default(ItemCheck))
	{
		TriggerInteractEventReq triggerInteractEventReq = new TriggerInteractEventReq();
		triggerInteractEventReq.Wid = wid;
		triggerInteractEventReq.ChunkID = Singleton<GameManager>.instance.worldManager.ActiveChunkId;
		triggerInteractEventReq.States.Add(new Pb.StateChangeInfo
		{
			Uid = swid,
			StateId = stateId
		});
		if ((Singleton<EnvironmentInfoManager>.instance.environmentState & EnvironmentState.ForbideSyncGameInfo) == 0 && sync && MonoECS.instance.running)
		{
			triggerInteractEventReq.Position = MonoECS.instance.localPlayer.battleEntity.GetCompTransform().physicsPosition.ToPB();
			triggerInteractEventReq.CharacterInfo = GetCharacterSyncInfo();
		}
		itemCheck.ApplyOn(triggerInteractEventReq);
		bool callBack = false;
		if (mapViewRecordParam != null && mapViewRecordParam.Areas.Count > 0)
		{
			triggerInteractEventReq.MapViewRecordParam = mapViewRecordParam.Clone();
		}
		Singleton<NetManager>.instance.Request(triggerInteractEventReq, (IMessage msg) =>
		{
			callBack = true;
			if (msg is TriggerInteractEventAck triggerInteractEventAck)
			{
				PropPickingUtility.OnInteractRewards(triggerInteractEventAck.Items);
				callback?.Invoke();
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError(msg);
			}
		});
		await UniTask.WaitUntil(() => callBack);
	}

	public void ChangeServiceSaveStates(int wid, List<Pb.StateChangeInfo> stateChangeInfos, bool sync, MapViewRecordParam mapViewRecordParam, Action<bool> callback, ItemCheck itemCheck = default(ItemCheck))
	{
		TriggerInteractEventReq triggerInteractEventReq = new TriggerInteractEventReq();
		triggerInteractEventReq.Wid = wid;
		triggerInteractEventReq.States.AddRange(stateChangeInfos);
		triggerInteractEventReq.ChunkID = Singleton<GameManager>.instance.worldManager.ActiveChunkId;
		if ((Singleton<EnvironmentInfoManager>.instance.environmentState & EnvironmentState.ForbideSyncGameInfo) == 0 && sync && MonoECS.instance.localPlayer.battleEntity.IsValid && MonoECS.instance.localPlayer.battleEntity.GetCompTransform() != null)
		{
			triggerInteractEventReq.Position = MonoECS.instance.localPlayer.battleEntity.GetCompTransform().physicsPosition.ToPB();
			triggerInteractEventReq.CharacterInfo = GetCharacterSyncInfo();
		}
		if (mapViewRecordParam != null && mapViewRecordParam.Areas.Count > 0)
		{
			triggerInteractEventReq.MapViewRecordParam = mapViewRecordParam.Clone();
		}
		itemCheck.ApplyOn(triggerInteractEventReq);
		Singleton<NetManager>.instance.Request(triggerInteractEventReq, (IMessage msg) =>
		{
			if (msg is TriggerInteractEventAck triggerInteractEventAck)
			{
				PropPickingUtility.OnInteractRewards(triggerInteractEventAck.Items);
				callback?.Invoke(obj: true);
			}
			else
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
				callback?.Invoke(obj: false);
			}
		});
	}

	public void MapExploreCompleteRequest(int area, int chunkId = 0, Action callback = null)
	{
		MapViewCompleteLayerReq mapViewCompleteLayerReq = new MapViewCompleteLayerReq();
		mapViewCompleteLayerReq.AreaID = area;
		if (chunkId != 0)
		{
			mapViewCompleteLayerReq.ChunkID = chunkId;
		}
		Singleton<NetManager>.instance.Request(mapViewCompleteLayerReq, (IMessage msg) =>
		{
			if (msg is MapViewCompleteLayerAck)
			{
				callback?.Invoke();
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError(msg);
			}
		});
	}

	public void TriggerCustomInteractEvent(int swid, string eventName, Action<InteractRuleResult> callback, ItemCheck itemCheck = default(ItemCheck))
	{
		RuleManager ruleManager = MonoECS.instance.ruleManager;
		LocalStateWorldEvent evt = Singleton<EventManager>.instance.GetEvt<LocalStateWorldEvent>();
		evt.eventType = ClientEvent.Local_CustomInteractEvent;
		evt.sourceSwid = swid;
		evt.eventName = eventName;
		InteractRuleResult obj = ruleManager.LocalEventDispatch(ClientEvent.Local_CustomInteractEvent, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		if (obj.isVerified)
		{
			TriggerInteractEventReq triggerInteractEventReq = new TriggerInteractEventReq();
			triggerInteractEventReq.Wid = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			triggerInteractEventReq.ChunkID = Singleton<GameManager>.instance.worldManager.ActiveChunkId;
			triggerInteractEventReq.States.Add(new Pb.StateChangeInfo
			{
				Uid = swid,
				EventName = eventName
			});
			if (MonoECS.instance.isStartWorld && (Singleton<EnvironmentInfoManager>.instance.environmentState & EnvironmentState.ForbideSyncGameInfo) == 0)
			{
				triggerInteractEventReq.Position = MonoECS.instance.localPlayer.battleEntity.GetCompTransform().physicsPosition.ToPB();
				triggerInteractEventReq.CharacterInfo = GetCharacterSyncInfo();
			}
			itemCheck.ApplyOn(triggerInteractEventReq);
			Singleton<NetManager>.instance.Request(triggerInteractEventReq, (IMessage msg) =>
			{
				if (msg is TriggerInteractEventAck triggerInteractEventAck)
				{
					PropPickingUtility.OnInteractRewards(triggerInteractEventAck.Items);
					callback?.Invoke(new InteractRuleResult
					{
						isVerified = true
					});
				}
			});
		}
		else
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"TriggerCustomInteractEvent({swid},{eventName})本地验证不通过,已跳过消息发送");
			}
			callback?.Invoke(obj);
		}
	}

	public void AchievePlayeLevelAward(int level, Action<RepeatedField<Item>> callback, bool isAll = false)
	{
		SystemTakeLevelRewardReq systemTakeLevelRewardReq = new SystemTakeLevelRewardReq();
		systemTakeLevelRewardReq.Level = level;
		systemTakeLevelRewardReq.All = isAll;
		Singleton<NetManager>.instance.Request(systemTakeLevelRewardReq, (IMessage msg) =>
		{
			if (msg is SystemTakeLevelRewardAck systemTakeLevelRewardAck)
			{
				callback?.Invoke(systemTakeLevelRewardAck.Items);
			}
		});
	}

	public void SystemGuideChapterReward(int chapter, Action<RepeatedField<UniversalItem>> callback)
	{
		SystemGuideTakeChapterRewardReq systemGuideTakeChapterRewardReq = new SystemGuideTakeChapterRewardReq();
		systemGuideTakeChapterRewardReq.ChapterId = chapter;
		Singleton<NetManager>.instance.Request(systemGuideTakeChapterRewardReq, (IMessage msg) =>
		{
			if (msg is SystemGuideTakeChapterRewardAck systemGuideTakeChapterRewardAck)
			{
				callback?.Invoke(systemGuideTakeChapterRewardAck.GotItems);
			}
		});
	}

	public void CheckSystemOpen(int systemId, Action<bool> callback)
	{
		SystemOpenReq systemOpenReq = new SystemOpenReq();
		systemOpenReq.Id = systemId;
		Singleton<NetManager>.instance.Request(systemOpenReq, (IMessage msg) =>
		{
			callback?.Invoke(msg is SystemOpenAck);
		});
	}

	public void DeleteItems(int itemType, List<OperationItem> items, Action<bool> callBack)
	{
		DelItemsReq delItemsReq = new DelItemsReq();
		delItemsReq.Items.AddRange(items);
		delItemsReq.ItemType = itemType;
		Singleton<NetManager>.instance.Request(delItemsReq, (IMessage msg) =>
		{
			if (msg is DelItemsAck delItemsAck)
			{
				callBack?.Invoke(delItemsAck.Ok);
			}
		});
	}

	public void ComposeItem(Item composeItem, Action<bool> callBack)
	{
		ComposeItemReq data = new ComposeItemReq
		{
			TargetItem = composeItem
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is ComposeItemAck)
			{
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
			}
		});
	}

	public void ChangeWorldLevel(int level, Action<bool, long> callBack)
	{
		ChangeWorldLevelReq changeWorldLevelReq = new ChangeWorldLevelReq();
		changeWorldLevelReq.ToLevel = level;
		Singleton<NetManager>.instance.Request(changeWorldLevelReq, (IMessage msg) =>
		{
			if (msg is ChangeWorldLevelAck changeWorldLevelAck)
			{
				callBack?.Invoke(changeWorldLevelAck.Ok, changeWorldLevelAck.ChangeTS);
			}
			else
			{
				callBack?.Invoke(arg1: false, -1L);
			}
		});
	}

	public void UseItem(int itemId, int uid, int count, int chooseItemIndex, Action<bool, RepeatedField<Item>, RepeatedField<UniversalItem>> callBack)
	{
		UseItemsReq useItemsReq = new UseItemsReq();
		useItemsReq.Item = new OperationItem
		{
			Index = itemId,
			ChooseIndex = chooseItemIndex,
			Count = count
		};
		Singleton<NetManager>.instance.Request(useItemsReq, (IMessage msg) =>
		{
			if (msg is UseItemsAck useItemsAck)
			{
				callBack?.Invoke(useItemsAck.Ok, useItemsAck.ObtainItems, useItemsAck.GotItems);
			}
			else
			{
				if (msg is ErrorAck errorAck)
				{
					LuminError.Handle(errorAck);
				}
				callBack?.Invoke(arg1: false, null, null);
			}
		});
	}

	public void LightMapBlock(int worldId, int Roomindex, Action callback)
	{
		LightMapBlockReq data = new LightMapBlockReq
		{
			Wid = worldId,
			Id = Roomindex
		};
		G.localPlayer.Maps[worldId].LightedMapBlocks.TryAdd(Roomindex, value: true);
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is LightMapBlockAck)
			{
				callback?.Invoke();
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError(msg);
			}
		});
	}

	public void SkillLevelUp(int characterId, int skillGroupId, Action<bool, RepeatedField<UniversalItem>> callBack)
	{
		CharacterUpgradeSkillGroupReq data = new CharacterUpgradeSkillGroupReq
		{
			CharacterId = characterId,
			SkillGroupId = skillGroupId
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is CharacterUpgradeSkillGroupAck characterUpgradeSkillGroupAck)
			{
				callBack?.Invoke(arg1: true, characterUpgradeSkillGroupAck.GotItems);
			}
			else
			{
				callBack?.Invoke(arg1: false, null);
			}
		});
	}

	public void PowerBuyFreeDiamond(Action<int> callBack)
	{
		PowerBuyReq data = new PowerBuyReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is PowerBuyAck powerBuyAck)
			{
				callBack?.Invoke(powerBuyAck.CanBuyNum);
			}
			else
			{
				callBack?.Invoke(-1);
			}
		});
	}

	public void RequestPowerCount(Action<PowerInfoQueryAck> callBack)
	{
		PowerInfoQueryReq data = new PowerInfoQueryReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is PowerInfoQueryAck obj)
			{
				callBack?.Invoke(obj);
			}
			else
			{
				callBack?.Invoke(null);
			}
		});
	}

	public void PowerExchangeItem(int itemId, int powerCost, Action<bool, RepeatedField<UniversalItem>> callBack)
	{
		PowerExchangeReq data = new PowerExchangeReq
		{
			ItemId = itemId,
			PowerNum = powerCost
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is PowerExchangeAck powerExchangeAck)
			{
				callBack?.Invoke(arg1: true, powerExchangeAck.Rewards);
			}
			else
			{
				callBack?.Invoke(arg1: false, null);
			}
		});
	}

	public void CharacterBreakReward(int characterId, int stage, Action<bool> callBack)
	{
		CharacterTakeStageRewardReq data = new CharacterTakeStageRewardReq
		{
			Id = characterId,
			Stage = stage
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is CharacterTakeStageRewardAck)
			{
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
			}
		});
	}

	public void ConstellationLevelUp(int characterId, Action<bool> callBack)
	{
	}

	public void ConstellationSwitch(int characterId, int stage, Action<bool> callBack)
	{
	}

	public void CharacterUpgradeConstellation(int characterId, int constellationId, Action<bool> callBack)
	{
		CharacterUpgradeConstellationReq data = new CharacterUpgradeConstellationReq
		{
			CharacterId = characterId,
			ConstellationId = constellationId
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is CharacterUpgradeConstellationAck)
			{
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
			}
		});
	}

	public void CharacterReturnConstellation(int characterId, int constellationId, Action<bool> callBack)
	{
		CharacterReturnConstellationReq data = new CharacterReturnConstellationReq
		{
			CharacterId = characterId,
			ConstellationId = constellationId
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is CharacterReturnConstellationAck)
			{
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
			}
		});
	}

	public void CharacterUpdateConstellation(int characterId, RepeatedField<int> constellationIds, Action<bool, int> callBack)
	{
		CharacterUpdateConstellationReq characterUpdateConstellationReq = new CharacterUpdateConstellationReq();
		characterUpdateConstellationReq.CharacterId = characterId;
		foreach (int constellationId in constellationIds)
		{
			characterUpdateConstellationReq.ConstellationIds.Add(constellationId);
		}
		Singleton<NetManager>.instance.Request(characterUpdateConstellationReq, (IMessage msg) =>
		{
			if (msg is CharacterUpdateConstellationAck characterUpdateConstellationAck)
			{
				callBack?.Invoke(arg1: true, characterUpdateConstellationAck.ConstellationNum);
			}
			else
			{
				callBack?.Invoke(arg1: false, 0);
			}
		});
	}

	public void CharacterEliteLevelUp(int characterId, int pointId, int toLevel, Action<bool> callBack)
	{
		CharacterEliteLevelUpReq characterEliteLevelUpReq = new CharacterEliteLevelUpReq();
		characterEliteLevelUpReq.CharacterId = characterId;
		characterEliteLevelUpReq.PointId = pointId;
		characterEliteLevelUpReq.ToLevel = toLevel;
		Singleton<NetManager>.instance.Request(characterEliteLevelUpReq, (IMessage msg) =>
		{
			if (msg is CharacterEliteLevelUpAck)
			{
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
			}
		});
	}

	public void CharacterEliteReset(int characterId, int pointId, int pointNode, Action<bool> callBack)
	{
		CharacterEliteResetReq characterEliteResetReq = new CharacterEliteResetReq();
		characterEliteResetReq.CharacterId = characterId;
		characterEliteResetReq.PointId = pointId;
		characterEliteResetReq.PointNode = pointNode;
		Singleton<NetManager>.instance.Request(characterEliteResetReq, (IMessage msg) =>
		{
			if (msg is CharacterEliteResetAck)
			{
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
			}
		});
	}

	public void CharacterEliteReset(int characterId, int pointId, Action<bool> callBack)
	{
		CharacterEliteResetReq characterEliteResetReq = new CharacterEliteResetReq();
		characterEliteResetReq.CharacterId = characterId;
		characterEliteResetReq.PointId = pointId;
		Singleton<NetManager>.instance.Request(characterEliteResetReq, (IMessage msg) =>
		{
			if (msg is CharacterEliteResetAck)
			{
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
			}
		});
	}

	public void DrawCard(int id, int count, Action<bool, RepeatedField<Item>> callBack)
	{
		DrawCardReq data = new DrawCardReq
		{
			PoolId = id,
			Count = count
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is DrawCardAck drawCardAck)
			{
				callBack?.Invoke(arg1: true, drawCardAck.Items);
			}
			else
			{
				callBack?.Invoke(arg1: false, null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void GetExtraReward(int count, Action<bool, RepeatedField<Item>> callBack)
	{
	}

	public void GetDailyReward(Action<bool, RepeatedField<Item>> callBack)
	{
	}

	public void SceneBossChallenge(int difficultyLevel, Action<bool> callBack)
	{
		SceneChallengeBossReq sceneChallengeBossReq = new SceneChallengeBossReq();
		sceneChallengeBossReq.DifficultyLevel = difficultyLevel;
		Singleton<NetManager>.instance.Request(sceneChallengeBossReq, (IMessage msg) =>
		{
			if (msg is SceneChallengeBossAck)
			{
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SceneTakeBossChallengeRewards(Action<bool, RepeatedField<Item>> callBack)
	{
		SceneTakeChallengeBossRewardReq data = new SceneTakeChallengeBossRewardReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is SceneTakeChallengeBossRewardAck sceneTakeChallengeBossRewardAck)
			{
				callBack?.Invoke(arg1: true, sceneTakeChallengeBossRewardAck.Rewards);
			}
			else
			{
				callBack?.Invoke(arg1: false, null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SceneResetChallengeBoss(Action<bool> callBack)
	{
		SceneResetChallengeBossReq data = new SceneResetChallengeBossReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is SceneResetChallengeBossAck)
			{
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void ShopBuy(int id, int subShopIDx, int commodityIdx, int buyNum, Action<ShopBuyCommodityAck> callback)
	{
		ShopBuyCommodityReq data = new ShopBuyCommodityReq
		{
			ShopId = id,
			SubShopIdx = subShopIDx,
			CommodityIdx = commodityIdx,
			BuyNum = buyNum
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is ShopBuyCommodityAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void RaidEnterInfo(int raidId, TeamUsage teamUsage, Action<bool> callBack, bool enterByGM = false)
	{
		RaidEnterReq raidEnterReq = new RaidEnterReq();
		raidEnterReq.Id = raidId;
		raidEnterReq.Team = teamUsage;
		raidEnterReq.Rate = Model<RaidModel>.Interface.CostRate;
		raidEnterReq.ByGM = enterByGM;
		Singleton<NetManager>.instance.Request(raidEnterReq, (IMessage msg) =>
		{
			if (msg is RaidEnterAck raidEnterAck)
			{
				Model<RaidModel>.Interface.UpdateRaidInfo(raidEnterAck.RaidInfo);
				Model<CharacterRepositoryModel>.Interface.RemoveCharacterRepository(1);
				Model<CharacterRepositoryModel>.Interface.AddCharacterRepository(1, raidEnterAck.CharacterRepository);
				TeamInfoExtension.SetTeamInfo(1, teamUsage);
				SetTransNo(SceneStatus.Raid, raidEnterAck.TransNo);
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	private StageSettleInfo GetSettleInfo()
	{
		if (!Model<ChallengeTargetTrackerModel>.HasInstance())
		{
			return new StageSettleInfo();
		}
		return Model<ChallengeTargetTrackerModel>.Interface.CreateStageSettleInfo();
	}

	private static void LogChallengeTargetSettlement(string requestName, StageSettleInfo settleInfo)
	{
		if (LuminApplication.LogEnabled && Model<ChallengeTargetTrackerModel>.HasInstance() && Model<ChallengeTargetTrackerModel>.Interface.IsPrepared)
		{
			RepeatedField<int> repeatedField = settleInfo?.CompletedChallengeTarget;
			string arg = ((repeatedField == null) ? string.Empty : string.Join(",", repeatedField));
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"[TeamTeaching][ChallengeTarget] 发送{requestName} raidId={Model<RaidModel>.Interface.CurrentRaidId}, " + $"duration={settleInfo.Duration:0.##}, completedTargetIds=[{arg}]");
			}
		}
	}

	public void GetRaidRewardInfo(int rewardRate, Action<bool, RepeatedField<UniversalItem>> callBack)
	{
		RaidTakeRewardsReq raidTakeRewardsReq = new RaidTakeRewardsReq();
		raidTakeRewardsReq.RewardRate = rewardRate;
		raidTakeRewardsReq.SettleInfo = GetSettleInfo();
		LogChallengeTargetSettlement("副本领奖协议", raidTakeRewardsReq.SettleInfo);
		int currentPower = Model<PowerModel>.Interface.PowerCount;
		Singleton<NetManager>.instance.Request(raidTakeRewardsReq, (IMessage msg) =>
		{
			if (msg is RaidTakeRewardsAck raidTakeRewardsAck)
			{
				Model<ChallengeTargetTrackerModel>.Interface.StopTracking();
				Model<RaidModel>.Interface.UpdateRaidInfo(raidTakeRewardsAck.RaidInfo);
				if (currentPower >= RuntimeConfigs.data.game.powerLimit)
				{
					G.localPlayer.Profile.PowerRecoverTs = TimeManager.ServerTime.NowTimestamp;
				}
				if (Model<BattleMainModel>.HasInstance())
				{
					Model<BattleMainModel>.Interface.NeedReDisplayPlayerExp();
				}
				RepeatedField<UniversalItem> arg = Model<InventoryModel>.Interface.InventoryOverflowGetDisplayItems(raidTakeRewardsAck.GotItems);
				callBack?.Invoke(arg1: true, arg);
			}
			else
			{
				callBack?.Invoke(arg1: false, null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void RaidSweep(int raidId, int sweepCount, Action<bool, RepeatedField<UniversalItem>> callBack)
	{
		RaidSweepReq raidSweepReq = new RaidSweepReq();
		raidSweepReq.Id = raidId;
		raidSweepReq.Num = sweepCount;
		Singleton<NetManager>.instance.Request(raidSweepReq, (IMessage msg) =>
		{
			if (msg is RaidSweepAck raidSweepAck)
			{
				Model<RaidModel>.Interface.UpdateRaidInfo(raidSweepAck.RaidInfo);
				callBack?.Invoke(arg1: true, raidSweepAck.GotItems);
			}
			else
			{
				callBack?.Invoke(arg1: false, null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void LeaveRaid(Action<bool> callBack)
	{
		RaidLeaveReq raidLeaveReq = new RaidLeaveReq();
		raidLeaveReq.SettleInfo = GetSettleInfo();
		LogChallengeTargetSettlement("副本离开协议", raidLeaveReq.SettleInfo);
		Singleton<NetManager>.instance.Request(raidLeaveReq, (IMessage msg) =>
		{
			if (msg is RaidLeaveAck)
			{
				Model<ChallengeTargetTrackerModel>.Interface.StopTracking();
				Model<RaidModel>.Interface.UpdateRaidInfo(null);
				Model<CharacterRepositoryModel>.Interface.RemoveCharacterRepository(1);
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void ReopenRaid(Action<bool> callBack)
	{
		RaidRechallengeReq raidRechallengeReq = new RaidRechallengeReq();
		raidRechallengeReq.SettleInfo = GetSettleInfo();
		Singleton<NetManager>.instance.Request(raidRechallengeReq, (IMessage msg) =>
		{
			if (msg is RaidRechallengeAck raidRechallengeAck)
			{
				Model<ChallengeTargetTrackerModel>.Interface.StopTracking();
				Model<RaidModel>.Interface.UpdateRaidInfo(raidRechallengeAck.RaidInfo);
				SetTransNo(SceneStatus.Raid, raidRechallengeAck.TransNo);
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void ParkourRaidDead(Action<bool> callBack)
	{
		RaidPlayerDeadReq data = new RaidPlayerDeadReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is RaidPlayerDeadAck raidPlayerDeadAck)
			{
				Model<RaidModel>.Interface.UpdateRaidInfo(raidPlayerDeadAck.RaidInfo);
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void AbyssEnter(int abyssIndex, int abyssGroupId, List<TeamUsage> abyssTeamInfos, Action<bool> callBack, bool enterByGM = false)
	{
		AbyssChallengeStageReq abyssChallengeStageReq = new AbyssChallengeStageReq();
		abyssChallengeStageReq.SelectedStageIdx = abyssIndex;
		abyssChallengeStageReq.Teams.AddRange(abyssTeamInfos);
		abyssChallengeStageReq.ByGM = enterByGM;
		abyssChallengeStageReq.AbyssId = abyssGroupId;
		Singleton<NetManager>.instance.Request(abyssChallengeStageReq, (IMessage msg) =>
		{
			if (msg is AbyssChallengeStageAck abyssChallengeStageAck)
			{
				Model<AbyssModel>.Interface.UpdateDynamicAbyss(abyssChallengeStageAck.AbyssData);
				SetTransNo(SceneStatus.Abyss, abyssChallengeStageAck.TransNo);
				Model<CharacterRepositoryModel>.Interface.RemoveCharacterRepository(2);
				Model<CharacterRepositoryModel>.Interface.AddCharacterRepository(2, abyssChallengeStageAck.CharacterRepository);
				TeamInfoExtension.SetTeamInfos(2, abyssTeamInfos);
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void AbyssCompleteSubStage(int second, Action<bool, bool, bool, AbyssStage, RepeatedField<UniversalItem>> callBack)
	{
		if (Model<AbyssModel>.Interface.GetChallengeIsAllComplete())
		{
			Model<ChallengeTargetTrackerModel>.Interface.MarkChallengeCompleted();
		}
		AbyssCompleteSubStageReq abyssCompleteSubStageReq = new AbyssCompleteSubStageReq();
		abyssCompleteSubStageReq.SettleInfo = GetSettleInfo();
		abyssCompleteSubStageReq.UseSeconds = second;
		Singleton<NetManager>.instance.Request(abyssCompleteSubStageReq, (IMessage msg) =>
		{
			if (msg is AbyssCompleteSubStageAck abyssCompleteSubStageAck)
			{
				if (!abyssCompleteSubStageAck.CompletedAll)
				{
					SetTransNo(SceneStatus.Abyss, abyssCompleteSubStageAck.TransNo);
				}
				Model<AbyssModel>.Interface.UpdateDynamicAbyss(abyssCompleteSubStageAck.AbyssData);
				Model<AbyssModel>.Interface.CacheQuickStageRewards(abyssCompleteSubStageAck.QuickStageRewards);
				Model<AbyssModel>.Interface.UpdateLastChallengeGroupId(Model<AbyssModel>.Interface.GroupId);
				Model<AbyssModel>.Interface.OnCompleteSubStage(abyssCompleteSubStageAck.CompletedAll);
				callBack?.Invoke(arg1: true, abyssCompleteSubStageAck.CompletedAll, abyssCompleteSubStageAck.UnlockNewStage, abyssCompleteSubStageAck.CompletedStageInfo, abyssCompleteSubStageAck.StageRewards);
			}
			else
			{
				callBack?.Invoke(arg1: false, arg2: false, arg3: false, null, null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void RechallengeAbyss(bool onlyCurrentLayer, Action<bool> callBack)
	{
		Model<ChallengeTargetTrackerModel>.Interface.MarkChallengeCompleted();
		Model<ChallengeTargetTrackerModel>.Interface.StopTracking();
		AbyssRechallengeReq abyssRechallengeReq = new AbyssRechallengeReq();
		abyssRechallengeReq.OnlyCurrentLayer = onlyCurrentLayer;
		abyssRechallengeReq.SettleInfo = GetSettleInfo();
		Singleton<NetManager>.instance.Request(abyssRechallengeReq, (IMessage msg) =>
		{
			if (msg is AbyssRechallengeAck abyssRechallengeAck)
			{
				Model<AbyssModel>.Interface.UpdateDynamicAbyss(abyssRechallengeAck.AbyssData);
				SetTransNo(SceneStatus.Abyss, abyssRechallengeAck.TransNo);
				Model<CharacterRepositoryModel>.Interface.RemoveCharacterRepository(2);
				Model<CharacterRepositoryModel>.Interface.AddCharacterRepository(2, abyssRechallengeAck.CharacterRepository);
				G.localPlayer.Profile.SceneInfos[2].LastPos = null;
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void ComeBackAbyss(Action<bool> callBack)
	{
		AbyssComebackReq data = new AbyssComebackReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is AbyssComebackAck abyssComebackAck)
			{
				Model<AbyssModel>.Interface.UpdateDynamicAbyss(abyssComebackAck.AbyssData);
				Model<CharacterRepositoryModel>.Interface.RemoveCharacterRepository(2);
				Model<CharacterRepositoryModel>.Interface.AddCharacterRepository(2, abyssComebackAck.CharacterRepository);
				G.localPlayer.Profile.SceneInfos[2].LastPos = null;
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void LeaveAbyss(Action<bool> callBack)
	{
		AbyssLeaveReq abyssLeaveReq = new AbyssLeaveReq();
		abyssLeaveReq.SettleInfo = GetSettleInfo();
		Singleton<NetManager>.instance.Request(abyssLeaveReq, (IMessage msg) =>
		{
			if (msg is AbyssLeaveAck abyssLeaveAck)
			{
				Model<ChallengeTargetTrackerModel>.Interface.StopTracking();
				Model<AbyssModel>.Interface.UpdateDynamicAbyss(abyssLeaveAck.AbyssData);
				G.localPlayer.teamInfo.Teams.Remove(2);
				Model<CharacterRepositoryModel>.Interface.RemoveCharacterRepository(2);
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void AbyssTaskReward(int startNum, int abyssId, int stageIndex, bool claimAll, Action<bool, RepeatedField<UniversalItem>> callBack)
	{
		AbyssTakeRewardReq abyssTakeRewardReq = new AbyssTakeRewardReq();
		abyssTakeRewardReq.TargetStar = startNum;
		abyssTakeRewardReq.AbyssId = abyssId;
		abyssTakeRewardReq.StageIdx = stageIndex;
		abyssTakeRewardReq.ClaimAll = claimAll;
		Singleton<NetManager>.instance.Request(abyssTakeRewardReq, (IMessage msg) =>
		{
			if (msg is AbyssTakeRewardAck abyssTakeRewardAck)
			{
				Model<AbyssModel>.Interface.UpdateDynamicAbyss(abyssTakeRewardAck.AbyssData);
				callBack?.Invoke(arg1: true, abyssTakeRewardAck.Items);
			}
			else
			{
				callBack?.Invoke(arg1: false, null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void ChangeAvatar(int avatarId, Action<bool> callBack)
	{
		EscModifyAvatarReq data = new EscModifyAvatarReq
		{
			AvatarId = avatarId
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is EscModifyAvatarAck)
			{
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void ChangeAvatarFrame(int avatarFrameId, Action<bool> callBack)
	{
		EscModifyAvatarFrameReq data = new EscModifyAvatarFrameReq
		{
			AvatarFrameId = avatarFrameId
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is EscModifyAvatarFrameAck)
			{
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void ChangeTitle(int titleId, Action<bool> callBack)
	{
		EscModifyTitleReq data = new EscModifyTitleReq
		{
			TitleId = titleId
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is EscModifyTitleAck)
			{
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void ChangeShowCharacter(List<int> showCharacterIds, Action<bool> callBack)
	{
		EscModifyShowCharacterReq escModifyShowCharacterReq = new EscModifyShowCharacterReq();
		if (showCharacterIds != null)
		{
			escModifyShowCharacterReq.ShowCharacterIds.AddRange(showCharacterIds);
		}
		Singleton<NetManager>.instance.Request(escModifyShowCharacterReq, (IMessage msg) =>
		{
			if (msg is EscModifyShowCharacterAck)
			{
				callBack?.Invoke(obj: true);
			}
			else
			{
				callBack?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void ChangeNickname(string nickname, Action<bool, string, IMessage> callBack)
	{
		ChangeNickNameReq data = new ChangeNickNameReq
		{
			NickName = nickname
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is ChangeNickNameAck changeNickNameAck)
			{
				callBack?.Invoke(changeNickNameAck.Ok, changeNickNameAck.NickName, changeNickNameAck);
			}
			else
			{
				callBack?.Invoke(arg1: false, null, msg);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void ChangeSignature(string signature, Action<bool, IMessage> callBack)
	{
		EscModifySignatureReq data = new EscModifySignatureReq
		{
			Signature = signature
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is EscModifySignatureAck)
			{
				callBack?.Invoke(arg1: true, msg);
			}
			else
			{
				callBack?.Invoke(arg1: false, msg);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SaveMusic(int id)
	{
		SavePlayingMusicReq savePlayingMusicReq = new SavePlayingMusicReq();
		savePlayingMusicReq.Music = id;
		Singleton<NetManager>.instance.Post(savePlayingMusicReq);
	}

	public void AchievementSyncInfoReq(AchievementSyncInfo achievementSyncInfo, Action<bool> callback)
	{
		AchievementSyncInfoReq achievementSyncInfoReq = new AchievementSyncInfoReq();
		achievementSyncInfoReq.AchievementInfo = achievementSyncInfo;
		Singleton<NetManager>.instance.Request(achievementSyncInfoReq, (IMessage msg) =>
		{
			if (msg is AchievementSyncInfoAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void ReceiveAchievementReward(int id, Action<bool, RepeatedField<Item>> callback)
	{
		AchievementTakeRewardReq achievementTakeRewardReq = new AchievementTakeRewardReq();
		achievementTakeRewardReq.Id = id;
		Singleton<NetManager>.instance.Request(achievementTakeRewardReq, (IMessage msg) =>
		{
			if (msg is AchievementTakeRewardAck achievementTakeRewardAck)
			{
				callback?.Invoke(arg1: true, achievementTakeRewardAck.Items);
			}
			else
			{
				callback?.Invoke(arg1: false, null);
			}
		});
	}

	public void ReceiveAchievementGroupReward(int id, Action<bool, RepeatedField<Item>> callback)
	{
		AchievementTakeGroupRewardReq achievementTakeGroupRewardReq = new AchievementTakeGroupRewardReq();
		achievementTakeGroupRewardReq.Gid = id;
		Singleton<NetManager>.instance.Request(achievementTakeGroupRewardReq, (IMessage msg) =>
		{
			if (msg is AchievementTakeGroupRewardAck achievementTakeGroupRewardAck)
			{
				G.localPlayer.Achievements.ProgressData.TookAchievementGroupRewards.Add(id, value: true);
				callback?.Invoke(arg1: true, achievementTakeGroupRewardAck.Items);
			}
			else
			{
				callback?.Invoke(arg1: false, null);
			}
		});
	}

	public void AchievementComplete(int id, Action<bool, int> callback)
	{
		AchievementCompleteReq achievementCompleteReq = new AchievementCompleteReq();
		achievementCompleteReq.Id = id;
		Singleton<NetManager>.instance.Request(achievementCompleteReq, (IMessage msg) =>
		{
			if (msg is AchievementCompleteAck achievementCompleteAck)
			{
				callback?.Invoke(arg1: true, achievementCompleteAck.CompleteTS);
			}
			else
			{
				callback?.Invoke(arg1: false, 0);
			}
		});
	}

	public void AchievementChange(int id, AchievementTag tag, Action<bool> callback)
	{
		AchievementChangeTagReq achievementChangeTagReq = new AchievementChangeTagReq();
		achievementChangeTagReq.Id = id;
		achievementChangeTagReq.Tag = tag;
		Singleton<NetManager>.instance.Request(achievementChangeTagReq, (IMessage msg) =>
		{
			if (msg is AchievementChangeTagAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	private CharacterSyncInfo GetCharacterSyncInfo()
	{
		Dictionary<int, CharacterStatus> dictionary = DictionaryPool<int, CharacterStatus>.Get();
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = MPPlayer.local.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				CompAbility compAbility = teamCharacter.GetCompAbility();
				CharacterStatus characterStatus = new CharacterStatus
				{
					ExPower = compAbility.CurrentUltimateSkillValue,
					AssistPower = compAbility.AssistValue,
					EnergyPower = compAbility.EnergyValue
				};
				int hpSync = RuntimeConfigs.data.game.hpSync;
				characterStatus.Hp = Mathf.CeilToInt((float)compAbility.hp * 1f / (float)compAbility.maxHP * (float)hpSync);
				dictionary.Add(teamCharacter.GetCompCharacter().characterSource.Id(), characterStatus);
			}
		}
		CharacterSyncInfo characterSyncInfo = new CharacterSyncInfo();
		foreach (KeyValuePair<int, CharacterStatus> item in dictionary)
		{
			characterSyncInfo.Cs.Add(item.Key, item.Value);
		}
		characterSyncInfo.BattleCharacterId = MonoECS.instance.localPlayer.TeamBattleEntity.GetCompCharacter().characterSource.Id();
		DictionaryPool<int, CharacterStatus>.Release(dictionary);
		return characterSyncInfo;
	}

	public void SendConversationKeyPoint(List<int> ids, Action<bool> callback)
	{
		AchievementRecordConversationReq req = new AchievementRecordConversationReq();
		req.Op = RecordConversationOP.RecordConversationAdd;
		MapField<int, int> conversationKeyPoints = G.localPlayer.Achievements.Info.ConversationKeyPoints;
		foreach (int id in ids)
		{
			req.Keys.Add(id);
			if (conversationKeyPoints.ContainsKey(id))
			{
				conversationKeyPoints[id]++;
			}
			else
			{
				conversationKeyPoints[id] = 1;
			}
		}
		Singleton<NetManager>.instance.Request(req, (IMessage msg) =>
		{
			if (msg is AchievementRecordConversationAck)
			{
				callback?.Invoke(obj: true);
				KeyPointChange evt = Singleton<EventManager>.instance.GetEvt<KeyPointChange>();
				evt.keys = BSetPool<int>.Default.Get();
				foreach (int key in req.Keys)
				{
					evt.keys.Add(key);
				}
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.SendKeyPoint, evt);
				BSetPool<int>.Default.Recycle(evt.keys);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void ClearConversationKeyPoints(List<int> ids, Action<bool> callback)
	{
		AchievementRecordConversationReq req = new AchievementRecordConversationReq();
		req.Op = RecordConversationOP.RecordConversationReset;
		MapField<int, int> conversationKeyPoints = G.localPlayer.Achievements.Info.ConversationKeyPoints;
		foreach (int id in ids)
		{
			req.Keys.Add(id);
			if (conversationKeyPoints.ContainsKey(id))
			{
				conversationKeyPoints[id] = 0;
			}
		}
		Singleton<NetManager>.instance.Request(req, (IMessage msg) =>
		{
			if (msg is AchievementRecordConversationAck)
			{
				callback?.Invoke(obj: true);
				KeyPointChange evt = Singleton<EventManager>.instance.GetEvt<KeyPointChange>();
				evt.keys = BSetPool<int>.Default.Get();
				foreach (int key in req.Keys)
				{
					evt.keys.Add(key);
				}
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.SendKeyPoint, evt);
				BSetPool<int>.Default.Recycle(evt.keys);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void DestroyAccount(Action<bool> callback)
	{
		Singleton<NetManager>.instance.Request(new DestroyReq(), (IMessage msg) =>
		{
			if (msg is DestroyAck)
			{
				callback(obj: true);
			}
			else
			{
				callback(obj: false);
			}
		});
	}

	public void GuideFinish(int guideListId, int step, Action<bool> callback)
	{
		GuideLogsInterfaceReq data = new GuideLogsInterfaceReq
		{
			Group = guideListId,
			Step = step
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is GuideLogsInterfaceAck)
			{
				G.localPlayer.InterfaceGuide[guideListId] = step;
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void SendGuideUnlock(int guideId, Action<GuideUnlockAck> callback)
	{
		GuideUnlockReq guideUnlockReq = new GuideUnlockReq();
		guideUnlockReq.Id = guideId;
		Singleton<NetManager>.instance.Request(guideUnlockReq, (IMessage msg) =>
		{
			if (msg is GuideUnlockAck obj)
			{
				callback?.Invoke(obj);
			}
		});
	}

	public void SendGuideComplete(int guideId, Action<GuideCompleteAck> callback)
	{
		GuideCompleteReq guideCompleteReq = new GuideCompleteReq();
		guideCompleteReq.Id = guideId;
		Singleton<NetManager>.instance.Request(guideCompleteReq, (IMessage msg) =>
		{
			if (msg is GuideCompleteAck obj)
			{
				callback?.Invoke(obj);
			}
		});
	}

	public void TriggerTutorial(int tutorialId, Action<bool> callback)
	{
		if (!Model<TutorialModel>.HasInstance() || !Model<TutorialModel>.Interface.CanTriggerTutorial(tutorialId) || CoreUtils.GetData(tutorialId, RuntimeConfigs.data.guideTutorials) == null)
		{
			return;
		}
		Singleton<NetManager>.instance.Request(new GuideTriggerReq
		{
			Id = tutorialId
		}, (IMessage msg) =>
		{
			if (msg is GuideTriggerAck)
			{
				if (Model<TutorialModel>.HasInstance())
				{
					Model<TutorialModel>.Interface.TriggerTutorial(tutorialId);
				}
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void ReadTutorial(List<int> tutorialIds, Action<bool> callback)
	{
		GuideReadReq guideReadReq = new GuideReadReq();
		foreach (int tutorialId in tutorialIds)
		{
			guideReadReq.Ids.Add(tutorialId);
		}
		Singleton<NetManager>.instance.Request(guideReadReq, (IMessage msg) =>
		{
			if (msg is GuideReadAck guideReadAck)
			{
				callback?.Invoke(obj: true);
				PropPickingUtility.DispatchPropPickingEvt(guideReadAck.Rewards.ToList(), PropPickingWay.Normal);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void SendConversationRecordOptions(Dictionary<int, int> keyValues, Action<bool> callback)
	{
		AchievementRecordConversationOptionReq achievementRecordConversationOptionReq = new AchievementRecordConversationOptionReq();
		foreach (KeyValuePair<int, int> keyValue in keyValues)
		{
			achievementRecordConversationOptionReq.Data[keyValue.Key] = keyValue.Value;
		}
		Singleton<NetManager>.instance.Request(achievementRecordConversationOptionReq, (IMessage msg) =>
		{
			if (msg is AchievementRecordConversationOptionAck)
			{
				MapField<int, int> conversationOptionInfo = G.localPlayer.Achievements.Info.ConversationOptionInfo;
				foreach (KeyValuePair<int, int> keyValue2 in keyValues)
				{
					conversationOptionInfo[keyValue2.Key] = keyValue2.Value;
				}
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void SendUnLockMonster(int type, Action<bool> callback)
	{
		HandbookUpdateReq handbookUpdateReq = new HandbookUpdateReq();
		handbookUpdateReq.UnlockMonsters.Add(type);
		Singleton<NetManager>.instance.Request(handbookUpdateReq, (IMessage msg) =>
		{
			if (msg is HandbookUpdateAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void SendKillMonsterNum(int monsterid, Action<HandbookUpdateAck> callback)
	{
		HandbookUpdateReq handbookUpdateReq = new HandbookUpdateReq();
		handbookUpdateReq.KilledMonsters.Add(monsterid);
		Singleton<NetManager>.instance.Request(handbookUpdateReq, (IMessage msg) =>
		{
			if (msg is HandbookUpdateAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
			}
		});
	}

	public void SendUnLockWildBoss(int monsterPointId, Action<bool> callback)
	{
		HandbookUpdateReq handbookUpdateReq = new HandbookUpdateReq();
		handbookUpdateReq.UnlockWildBoss.Add(monsterPointId);
		Singleton<NetManager>.instance.Request(handbookUpdateReq, (IMessage msg) =>
		{
			if (msg is HandbookUpdateAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void SendUseLittleItem(int itemId, Action<bool> callback)
	{
		UseLittleItemReq useLittleItemReq = new UseLittleItemReq();
		useLittleItemReq.Id = itemId;
		Singleton<NetManager>.instance.Request(useLittleItemReq, (IMessage msg) =>
		{
			callback?.Invoke(msg is UseLittleItemAck);
		});
	}

	public void TriggerTeleportPoint(Action<bool> callback)
	{
		TriggerTeleportPointReq data = new TriggerTeleportPointReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			callback?.Invoke(msg is TriggerTeleportPointAck);
		});
	}

	public void RefreshRedDot(RedPoints redPoints, Action<bool> callback)
	{
		RedPointSetReq data = new RedPointSetReq
		{
			Info = redPoints
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is RedPointSetAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SyncLittleItems(LittleItemsShortcutInfo info, Action<bool> callback)
	{
		SyncLittleItemsReq syncLittleItemsReq = new SyncLittleItemsReq();
		syncLittleItemsReq.Info = info;
		Singleton<NetManager>.instance.Request(syncLittleItemsReq, (IMessage msg) =>
		{
			callback?.Invoke(msg is SyncLittleItemsAck);
		});
	}

	public void SyncBloodBottleLevelUp(int bottleId, int toLevel, Action<bool> callback)
	{
		PotionLevelUpReq potionLevelUpReq = new PotionLevelUpReq();
		potionLevelUpReq.Id = bottleId;
		potionLevelUpReq.ToLevel = toLevel;
		Singleton<NetManager>.instance.Request(potionLevelUpReq, (IMessage msg) =>
		{
			callback?.Invoke(msg is PotionLevelUpAck);
		});
	}

	public void UpdateBottleMaterials(int bottleId, List<int> matIds, Action<bool> callback)
	{
		PotionUpdateAdditiveReq potionUpdateAdditiveReq = new PotionUpdateAdditiveReq();
		potionUpdateAdditiveReq.PotionId = bottleId;
		potionUpdateAdditiveReq.Additives.AddRange(matIds);
		Singleton<NetManager>.instance.Request(potionUpdateAdditiveReq, (IMessage msg) =>
		{
			callback?.Invoke(msg is PotionUpdateAdditiveAck);
		});
	}

	public void SendUseBloodBottle(Action<bool> callback)
	{
		PotionUseReq data = new PotionUseReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			callback?.Invoke(msg is PotionUseAck);
		});
	}

	public void RecoverBottleUseCount(int targetCount, Action<int> callback)
	{
		PotionRecoverUseCountReq potionRecoverUseCountReq = new PotionRecoverUseCountReq();
		potionRecoverUseCountReq.Count = targetCount;
		Singleton<NetManager>.instance.Request(potionRecoverUseCountReq, (IMessage msg) =>
		{
			if (msg is PotionRecoverUseCountAck potionRecoverUseCountAck)
			{
				callback?.Invoke(potionRecoverUseCountAck.UsedCount);
			}
			else
			{
				callback?.Invoke(-1);
			}
		});
	}

	public void SendCreateCharacter(string Name, int gender, Action<CreateUserAck> callback)
	{
		CreateUserReq createUserReq = new CreateUserReq();
		createUserReq.NickName = Name;
		createUserReq.Gender = gender;
		Singleton<NetManager>.instance.Request(createUserReq, (IMessage msg) =>
		{
			if (msg is CreateUserAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
			}
		});
	}

	public void SaveSettingOptions(string json, Action<bool> callback)
	{
		SyncSettingOptionsReq syncSettingOptionsReq = new SyncSettingOptionsReq();
		syncSettingOptionsReq.Content = json;
		Singleton<NetManager>.instance.Request(syncSettingOptionsReq, (IMessage msg) =>
		{
			if (msg is SyncSettingOptionAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				if (msg is ErrorAck errorAck)
				{
					LuminError.Handle(errorAck);
				}
				callback?.Invoke(obj: false);
			}
		});
	}

	public void LogPlayerExplorePos(string area, string layer, Vector2 playerWorldPos, Action<bool, string, string, Vector2> callback)
	{
		MapViewLogReq data = new MapViewLogReq
		{
			Layer = area + "_" + layer,
			Position = playerWorldPos
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("------收到 MapViewLogAck");
			}
			if (msg is MapViewLogAck)
			{
				callback?.Invoke(arg1: true, area, layer, playerWorldPos);
			}
			else
			{
				callback?.Invoke(arg1: false, area, layer, playerWorldPos);
			}
		});
	}

	public void LayerExploreComplete(string area, string layer, Action<bool> callback)
	{
		throw new NotImplementedException();
	}

	public void SendRogueChallenge(int modeId, int coreId, TeamUsage battleCharacter, long seed, Action<RogueChallengeAck> callback)
	{
		RogueChallengeReq rogueChallengeReq = new RogueChallengeReq();
		rogueChallengeReq.ModeId = modeId;
		rogueChallengeReq.CoreId = coreId;
		rogueChallengeReq.BattleCharacter = battleCharacter;
		rogueChallengeReq.Seed = seed;
		Singleton<NetManager>.instance.Request(rogueChallengeReq, (IMessage msg) =>
		{
			if (msg is RogueChallengeAck rogueChallengeAck)
			{
				EntityCharacterProbation data = CoreUtils.GetData(battleCharacter.CharacterUsage[0].CharacterId, RuntimeConfigs.data.entityCharacterProbations);
				TeamInfoExtension.SetTeamInfo(3, new TeamUsage
				{
					CharacterUsage = 
					{
						new TeamCharacterUsage
						{
							CharacterId = data.characterId,
							IsTrial = false
						}
					}
				});
				Model<CharacterRepositoryModel>.Interface.RemoveCharacterRepository(3);
				Model<CharacterRepositoryModel>.Interface.AddCharacterRepository(3, rogueChallengeAck.GameInfo.BattleCharacter);
				callback?.Invoke(rogueChallengeAck);
			}
		});
	}

	public void SendRogueEnterRoom(int gameworldId, Action<RogueEnterRoomAck> callback)
	{
		RogueEnterRoomReq rogueEnterRoomReq = new RogueEnterRoomReq();
		rogueEnterRoomReq.GameWorldId = gameworldId;
		Singleton<NetManager>.instance.Request(rogueEnterRoomReq, (IMessage msg) =>
		{
			if (msg is RogueEnterRoomAck rogueEnterRoomAck)
			{
				TeamInfoExtension.SetTeamInfo(3, new TeamUsage
				{
					CharacterUsage = 
					{
						new TeamCharacterUsage
						{
							CharacterId = MonoECS.instance.MainEntityCharacterId
						}
					}
				});
				Model<CharacterRepositoryModel>.Interface.RemoveCharacterRepository(3);
				Model<CharacterRepositoryModel>.Interface.AddCharacterRepository(3, rogueEnterRoomAck.GameInfo.BattleCharacter);
				callback?.Invoke(rogueEnterRoomAck);
			}
		});
	}

	public void SendRogueEnterNextRoom(RogueRoomType type, Dictionary<int, ACT.Game.Data.RogueItem> roguebag, Dictionary<int, int> battleInfo, Dictionary<int, int> abilityUsage, Action<RogueEnterNextRoomAck> callback)
	{
		RogueEnterNextRoomReq rogueEnterNextRoomReq = new RogueEnterNextRoomReq();
		rogueEnterNextRoomReq.RoomType = type;
		rogueEnterNextRoomReq.Item.AddRange(roguebag);
		rogueEnterNextRoomReq.BattleInfo.AddRange(battleInfo);
		rogueEnterNextRoomReq.EffectInfo.AddRange(abilityUsage);
		Singleton<NetManager>.instance.Request(rogueEnterNextRoomReq, (IMessage msg) =>
		{
			if (msg is RogueEnterNextRoomAck obj)
			{
				callback?.Invoke(obj);
			}
		});
	}

	public void SendRogueGmNextRoom(RogueRoomType type, Action<RogueGmNextRoomAck> callback)
	{
		RogueGmNextRoomReq data = new RogueGmNextRoomReq
		{
			RoomType = type
		};
		bool hasInvokedCallback = false;
		if (!Singleton<NetManager>.instance.Request(data, (IMessage message) =>
		{
			hasInvokedCallback = true;
			callback?.Invoke(message as RogueGmNextRoomAck);
		}) && !hasInvokedCallback)
		{
			callback?.Invoke(null);
		}
	}

	public void SendRogueBuyItem(bool isbuy, int itemid, Action<RogueBuyItemAck> callback, bool isReplace = false, int ReplacePosition = 0)
	{
		RogueBuyItemReq rogueBuyItemReq = new RogueBuyItemReq();
		rogueBuyItemReq.ItemId = itemid;
		rogueBuyItemReq.IsBuy = isbuy;
		rogueBuyItemReq.IsReplace = isReplace;
		rogueBuyItemReq.ReplacePosition = ReplacePosition;
		Singleton<NetManager>.instance.Request(rogueBuyItemReq, (IMessage msg) =>
		{
			if (msg is RogueBuyItemAck obj)
			{
				callback?.Invoke(obj);
			}
		});
	}

	public void SendRogueBuyGmItem(int itemid, Action<RogueGmAddItemAck> callback)
	{
		RogueGmAddItemReq rogueGmAddItemReq = new RogueGmAddItemReq();
		rogueGmAddItemReq.ItemId = itemid;
		Singleton<NetManager>.instance.Request(rogueGmAddItemReq, (IMessage msg) =>
		{
			if (msg is RogueGmAddItemAck obj)
			{
				callback?.Invoke(obj);
			}
		});
	}

	public void SendRogueCoinReward(Action<RogueCoinRewardAck> callback)
	{
		RogueCoinRewardReq data = new RogueCoinRewardReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is RogueCoinRewardAck obj)
			{
				callback?.Invoke(obj);
			}
		});
	}

	public void SendRecycleItem(int itemId, Action<RogueRecycleItemAck> callback)
	{
		RogueRecycleItemReq rogueRecycleItemReq = new RogueRecycleItemReq();
		rogueRecycleItemReq.ItemId = itemId;
		Singleton<NetManager>.instance.Request(rogueRecycleItemReq, (IMessage msg) =>
		{
			if (msg is RogueRecycleItemAck obj)
			{
				callback?.Invoke(obj);
			}
		});
	}

	public void SendRoguePickUpItem(int itemId, bool isReplace, int replacePosition, Action<RoguePickUpItemAck> callback)
	{
		RoguePickUpItemReq roguePickUpItemReq = new RoguePickUpItemReq();
		roguePickUpItemReq.ItemId = itemId;
		roguePickUpItemReq.IsReplace = isReplace;
		roguePickUpItemReq.ReplacePosition = replacePosition;
		Singleton<NetManager>.instance.Request(roguePickUpItemReq, (IMessage msg) =>
		{
			if (msg is RoguePickUpItemAck obj && !isReplace)
			{
				callback?.Invoke(obj);
			}
		});
	}

	public void SendRogueSetRoomFinished(Action<RogueSetRoomFinishedAck> callback)
	{
		RogueSetRoomFinishedReq data = new RogueSetRoomFinishedReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is RogueSetRoomFinishedAck obj)
			{
				callback?.Invoke(obj);
			}
		});
	}

	public void SendRogueHangGame(Action<RogueHangGameAck> callback)
	{
		RogueHangGameReq data = new RogueHangGameReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is RogueHangGameAck obj)
			{
				Model<CharacterRepositoryModel>.Interface.RemoveCharacterRepository(3);
				callback?.Invoke(obj);
			}
		});
	}

	public void SendRogueContinueGame(Action<RogueContinueGameAck> callback)
	{
		RogueContinueGameReq data = new RogueContinueGameReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is RogueContinueGameAck rogueContinueGameAck)
			{
				G.localPlayer.teamInfo.Teams[3].Teams[0] = rogueContinueGameAck.RougeTeam;
				Model<CharacterRepositoryModel>.Interface.AddCharacterRepository(3, rogueContinueGameAck.BattleCharacter);
				callback?.Invoke(rogueContinueGameAck);
			}
		});
	}

	public void SendRogueFinishGame(RogueFinishType finishType, Action<RogueFinishGameAck> callback)
	{
		RogueFinishGameReq rogueFinishGameReq = new RogueFinishGameReq();
		rogueFinishGameReq.FinishType = finishType;
		Singleton<NetManager>.instance.Request(rogueFinishGameReq, (IMessage msg) =>
		{
			Model<CharacterRepositoryModel>.Interface.RemoveCharacterRepository(3);
			if (msg is RogueFinishGameAck obj)
			{
				callback?.Invoke(obj);
			}
		});
	}

	public void SendUpgradeTalentNode(int nodeId, Action<RogueUpdateTalentTreeNodeAck> callback)
	{
		RogueUpdateTalentTreeNodeReq rogueUpdateTalentTreeNodeReq = new RogueUpdateTalentTreeNodeReq();
		rogueUpdateTalentTreeNodeReq.NodeId = nodeId;
		Singleton<NetManager>.instance.Request(rogueUpdateTalentTreeNodeReq, (IMessage msg) =>
		{
			if (msg is RogueUpdateTalentTreeNodeAck obj)
			{
				callback?.Invoke(obj);
			}
		});
	}

	public void SendAssistNpcHelp(int npcId, int wid, Action<bool> callback)
	{
		AssistantNpcHelpReq assistantNpcHelpReq = new AssistantNpcHelpReq();
		assistantNpcHelpReq.Npc = new AssistantNpc
		{
			Id = npcId,
			EffectiveWorldId = wid
		};
		Singleton<NetManager>.instance.Request(assistantNpcHelpReq, (IMessage msg) =>
		{
			callback?.Invoke(msg is AssistantNpcHelpAck);
		});
	}

	public void SendAssistNpcFinish(int npcId, Action<bool> callback)
	{
		AssistantNpcFinishReq assistantNpcFinishReq = new AssistantNpcFinishReq();
		assistantNpcFinishReq.NpcIds.Add(npcId);
		Singleton<NetManager>.instance.Request(assistantNpcFinishReq, (IMessage msg) =>
		{
			callback?.Invoke(msg is AssistantNpcFinishAck);
		});
	}

	public void ContactChooseOption(int sessionId, int chooseIdx, Action<bool> callback)
	{
		ContactChooseOptionReq contactChooseOptionReq = new ContactChooseOptionReq();
		contactChooseOptionReq.SessionId = sessionId;
		contactChooseOptionReq.ChooseIdx = chooseIdx;
		Singleton<NetManager>.instance.Request(contactChooseOptionReq, (IMessage msg) =>
		{
			if (msg is ContactChooseOptionAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void SendGachaCardDraw(int gachaid, int count, Action<GachaCardDrawAck> callback, bool Beginner = false)
	{
		GachaCardDrawReq gachaCardDrawReq = new GachaCardDrawReq();
		gachaCardDrawReq.PooId = gachaid;
		gachaCardDrawReq.Count = count;
		Singleton<NetManager>.instance.Request(gachaCardDrawReq, (IMessage msg) =>
		{
			if (msg is GachaCardDrawAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				Model<CardDrawModel>.Interface.InCommunication = false;
				if (msg is ErrorAck errorAck)
				{
					LuminError.Handle(errorAck);
				}
			}
		});
	}

	public void SendGachaQueryHistory(GachaPoolType poolType, int page, Action<GachaQueryHistoryAck> callback)
	{
		GachaQueryHistoryReq gachaQueryHistoryReq = new GachaQueryHistoryReq();
		gachaQueryHistoryReq.PoolType = poolType;
		gachaQueryHistoryReq.Page = page;
		Singleton<NetManager>.instance.Request(gachaQueryHistoryReq, (IMessage msg) =>
		{
			if (msg is GachaQueryHistoryAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
			}
		});
	}

	public void SendGachaExchangeFinalGuaranteed(int poolid, int gachaitemid, Action<GachaExchangeFinalGuaranteedAck> callback)
	{
		GachaExchangeFinalGuaranteedReq gachaExchangeFinalGuaranteedReq = new GachaExchangeFinalGuaranteedReq();
		gachaExchangeFinalGuaranteedReq.PoolId = poolid;
		gachaExchangeFinalGuaranteedReq.GachaItemId = gachaitemid;
		Singleton<NetManager>.instance.Request(gachaExchangeFinalGuaranteedReq, (IMessage msg) =>
		{
			if (msg is GachaExchangeFinalGuaranteedAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
			}
		});
	}

	public void SendGachaTargetSelect(int gachaId, int targetGachaItemId, Action<GachaTargetSelectAck> callback)
	{
		GachaTargetSelectReq data = new GachaTargetSelectReq
		{
			GachaId = gachaId,
			TargetGachaItemId = targetGachaItemId
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is ErrorAck { CodeType: >0 } errorAck)
			{
				LuminError.Handle(errorAck);
				callback?.Invoke(null);
			}
			else
			{
				callback?.Invoke(msg as GachaTargetSelectAck);
			}
		});
	}

	public void SendGachaTargetCancel(int gachaId, Action<GachaTargetCancelAck> callback)
	{
		GachaTargetCancelReq data = new GachaTargetCancelReq
		{
			GachaId = gachaId
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is ErrorAck { CodeType: >0 } errorAck)
			{
				LuminError.Handle(errorAck);
				callback?.Invoke(null);
			}
			else
			{
				callback?.Invoke(msg as GachaTargetCancelAck);
			}
		});
	}

	public void SendGaChaExchangeMilestoneReward(int poolId, Action<GachaExchangeMilestoneRewardAck> callback)
	{
		GachaExchangeMilestoneRewardReq gachaExchangeMilestoneRewardReq = new GachaExchangeMilestoneRewardReq();
		gachaExchangeMilestoneRewardReq.PoolId = poolId;
		Singleton<NetManager>.instance.Request(gachaExchangeMilestoneRewardReq, (IMessage msg) =>
		{
			if (msg is GachaExchangeMilestoneRewardAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
			}
		});
	}

	public void SendGachaExchangeTicket(int poolid, int num, Action<GachaExchangeTicketAck> callback)
	{
		GachaExchangeTicketReq gachaExchangeTicketReq = new GachaExchangeTicketReq();
		gachaExchangeTicketReq.PoolId = poolid;
		gachaExchangeTicketReq.Num = num;
		Singleton<NetManager>.instance.Request(gachaExchangeTicketReq, (IMessage msg) =>
		{
			if (msg is GachaExchangeTicketAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
			}
		});
	}

	public void RequestActivitySignInChooseReward(int activityId, int groupId, int challengeId, int rewardId, Action<ActivitySignInChooseRewardAck> callBack)
	{
		ActivitySignInChooseRewardReq activitySignInChooseRewardReq = new ActivitySignInChooseRewardReq();
		activitySignInChooseRewardReq.ActivityId = activityId;
		activitySignInChooseRewardReq.GroupId = groupId;
		activitySignInChooseRewardReq.ChallengeId = challengeId;
		activitySignInChooseRewardReq.Rewards.Add(rewardId);
		Singleton<NetManager>.instance.Request(activitySignInChooseRewardReq, (IMessage msg) =>
		{
			if (msg is ActivitySignInChooseRewardAck obj)
			{
				callBack?.Invoke(obj);
			}
			else
			{
				callBack?.Invoke(null);
			}
		});
	}

	public void RequestActivitySignInReward(int activityId, int groupId, int challengeId, Action<ActivitySignInRewardAck> callBack)
	{
		ActivitySignInRewardReq activitySignInRewardReq = new ActivitySignInRewardReq();
		activitySignInRewardReq.ActivityId = activityId;
		activitySignInRewardReq.GroupId = groupId;
		activitySignInRewardReq.ChallengeId = challengeId;
		Singleton<NetManager>.instance.Request(activitySignInRewardReq, (IMessage msg) =>
		{
			if (msg is ActivitySignInRewardAck obj)
			{
				callBack?.Invoke(obj);
			}
			else
			{
				callBack?.Invoke(null);
			}
		});
	}

	public void RequestActivityAbyssReward(int activityId, int activityGroup, int activityChallenge, Action<ActivityAbyssRewardAck> callBack)
	{
		ActivityAbyssRewardReq activityAbyssRewardReq = new ActivityAbyssRewardReq();
		activityAbyssRewardReq.ActivityId = activityId;
		activityAbyssRewardReq.ActivityGroup = activityGroup;
		activityAbyssRewardReq.ActivityChallenge = activityChallenge;
		Singleton<NetManager>.instance.Request(activityAbyssRewardReq, (IMessage msg) =>
		{
			if (msg is ActivityAbyssRewardAck obj)
			{
				callBack?.Invoke(obj);
			}
			else
			{
				callBack?.Invoke(null);
			}
		});
	}

	public void RequestActivityRefresh(Action<ActivityRefreshAck> callBack)
	{
		ActivityRefreshReq data = new ActivityRefreshReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is ActivityRefreshAck obj)
			{
				callBack?.Invoke(obj);
			}
			else
			{
				callBack?.Invoke(null);
			}
		});
	}

	public void SubmitDivineEye(int exploreAreaId, int submitCount, Action<bool, List<UniversalItem>> callback)
	{
		MapSubmitDivinePupilReq mapSubmitDivinePupilReq = new MapSubmitDivinePupilReq();
		mapSubmitDivinePupilReq.AreaID = exploreAreaId;
		mapSubmitDivinePupilReq.Count = submitCount;
		Singleton<NetManager>.instance.Request(mapSubmitDivinePupilReq, (IMessage msg) =>
		{
			if (msg is MapSubmitDivinePupilAck mapSubmitDivinePupilAck)
			{
				G.localPlayer.pupils[exploreAreaId] = mapSubmitDivinePupilAck.LatestDivinePupilInfo;
				callback?.Invoke(arg1: true, mapSubmitDivinePupilAck.GotItems.ToList());
			}
			else
			{
				callback?.Invoke(arg1: false, null);
			}
		});
	}

	public void RewardDivineEye(int exploreAreaId, Action<bool> callback)
	{
		MapClaimDivinePupilRewardReq mapClaimDivinePupilRewardReq = new MapClaimDivinePupilRewardReq();
		mapClaimDivinePupilRewardReq.AreaID = exploreAreaId;
		Singleton<NetManager>.instance.Request(mapClaimDivinePupilRewardReq, (IMessage msg) =>
		{
			if (msg is MapClaimDivinePupilRewardAck mapClaimDivinePupilRewardAck)
			{
				G.localPlayer.pupils[exploreAreaId] = mapClaimDivinePupilRewardAck.LatestDivinePupilInfo;
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void QuestionnaireRead(int id)
	{
		QuestionnaireReadReq questionnaireReadReq = new QuestionnaireReadReq();
		questionnaireReadReq.Ids.Add(id);
		Singleton<NetManager>.instance.Request(questionnaireReadReq, (IMessage message) =>
		{
			if (message is QuestionnaireReadAck)
			{
				Model<QuestionnaireModel>.Interface.Read(id);
			}
		});
	}

	public void SwitchTempArchiveUpdateReq(TempArchiveOperation operation, SyncGameInfoReq syncData, Action<bool> callback)
	{
		TempArchiveUpdateReq tempArchiveUpdateReq = new TempArchiveUpdateReq();
		tempArchiveUpdateReq.Operation = operation;
		tempArchiveUpdateReq.SyncData = syncData;
		Singleton<NetManager>.instance.Request(tempArchiveUpdateReq, (IMessage ack) =>
		{
			if (ack is TempArchiveUpdateAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
			}
		});
	}

	public void SendOrder(int goodsId, int subShopId = 0, bool isRetry = false, Action<bool, CreatOrderAck> callback = null)
	{
		CreatOrderReq creatOrderReq = new CreatOrderReq();
		creatOrderReq.Currency = "CNY";
		creatOrderReq.GoodsId = goodsId;
		creatOrderReq.SubShopId = subShopId;
		Singleton<NetManager>.instance.Request(creatOrderReq, (IMessage ack) =>
		{
			if (ack is CreatOrderAck creatOrderAck)
			{
				callback?.Invoke(arg1: true, creatOrderAck);
				if (!LuminBambooBridgeListener.Default.IsLogin)
				{
					Debug.LogError("未登录SDK无法拉起支付");
				}
				else
				{
					OrderInfo orderInfo = new OrderInfo
					{
						itemId = Model<PayModel>.Interface.GetProductId(goodsId),
						itemName = Model<PayModel>.Interface.GetProductName(goodsId),
						itemDesc = Model<PayModel>.Interface.GetProductDescription(goodsId),
						extra = creatOrderAck.Extra,
						coin = 1,
						money = creatOrderAck.Money,
						num = 1,
						isTest = 1,
						currency = "CNY",
						cpOrderId = creatOrderAck.OrderId,
						callbackUrl = creatOrderAck.CallbackUrl,
						sign = creatOrderAck.Sign
					};
					if (isRetry)
					{
						BamBooSdk.getInstance().payAgain(orderInfo, LoginUtility.RoleInfo);
					}
					else
					{
						BamBooSdk.getInstance().pay(orderInfo, LoginUtility.RoleInfo);
					}
				}
			}
			else
			{
				if (ack is ErrorAck errorAck)
				{
					LuminError.Handle(errorAck);
				}
				callback?.Invoke(arg1: false, null);
			}
		});
	}

	public void ExchangeFreeDiamond(int num, Action<bool> callback = null)
	{
		ExchangeFreeDiamondReq exchangeFreeDiamondReq = new ExchangeFreeDiamondReq();
		exchangeFreeDiamondReq.Num = num;
		Singleton<NetManager>.instance.Request(exchangeFreeDiamondReq, (IMessage ack) =>
		{
			if (ack is ExchangeFreeDiamondAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(ack);
				}
			}
		});
	}

	public void ExchangeCommodity(int subShopId, int commodityId, Action<bool, List<Item>> callback = null, List<int> selectedIndex = null)
	{
		ExchangeCommodityReq exchangeCommodityReq = new ExchangeCommodityReq();
		exchangeCommodityReq.CommodityId = commodityId;
		exchangeCommodityReq.SubShopId = subShopId;
		if (selectedIndex != null)
		{
			exchangeCommodityReq.Indexs.AddRange(selectedIndex);
		}
		Singleton<NetManager>.instance.Request(exchangeCommodityReq, (IMessage ack) =>
		{
			if (ack is ExchangeCommodityAck exchangeCommodityAck)
			{
				callback?.Invoke(arg1: true, exchangeCommodityAck.GotItems.ToItems());
			}
			else
			{
				if (ack is ErrorAck errorAck)
				{
					LuminError.Handle(errorAck);
				}
				callback?.Invoke(arg1: false, null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(ack);
				}
			}
		});
	}

	public void OrderShipDisplay(string orderId, Action<bool> isSuccess = null)
	{
		OrderShipDisplayedReq orderShipDisplayedReq = new OrderShipDisplayedReq();
		orderShipDisplayedReq.OrderId = orderId;
		Singleton<NetManager>.instance.Request(orderShipDisplayedReq, (IMessage ack) =>
		{
			if (ack is OrderShipDisplayedAck)
			{
				isSuccess?.Invoke(obj: true);
			}
			else
			{
				if (ack is ErrorAck errorAck)
				{
					LuminError.Handle(errorAck);
				}
				isSuccess?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(ack);
				}
			}
		});
	}

	public void SendWorldLevelBreakReq(Action<bool, IList<UniversalItem>> callBack)
	{
		ChangeWorldLevelReq data = new ChangeWorldLevelReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is ChangeWorldLevelAck changeWorldLevelAck)
			{
				callBack?.Invoke(changeWorldLevelAck.Ok, changeWorldLevelAck.GotItems);
			}
			else
			{
				callBack?.Invoke(arg1: false, null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SendHandbookDailyMissionClaimReward(int rowID, Action<bool, List<Item>> callback)
	{
		HandbookDailyMissionClaimRewardReq handbookDailyMissionClaimRewardReq = new HandbookDailyMissionClaimRewardReq();
		handbookDailyMissionClaimRewardReq.RowId = rowID;
		Singleton<NetManager>.instance.Request(handbookDailyMissionClaimRewardReq, (IMessage msg) =>
		{
			if (msg is HandbookDailyMissionClaimRewardAck handbookDailyMissionClaimRewardAck)
			{
				G.localPlayer.DailyData.HandbookRewardStatus = handbookDailyMissionClaimRewardAck.RewardStatus;
				callback?.Invoke(arg1: true, handbookDailyMissionClaimRewardAck.Items.ToItems());
			}
			else
			{
				callback?.Invoke(arg1: false, null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SendHandbookDailyActivePtClaimReward(Action<bool, List<Item>> callback = null)
	{
		HandbookDailyActivePtClaimRewardReq data = new HandbookDailyActivePtClaimRewardReq();
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is HandbookDailyActivePtClaimRewardAck handbookDailyActivePtClaimRewardAck)
			{
				G.localPlayer.DailyData.HandbookRewardStatus = handbookDailyActivePtClaimRewardAck.RewardStatus;
				callback?.Invoke(arg1: true, handbookDailyActivePtClaimRewardAck.Items.ToItems());
			}
			else
			{
				callback?.Invoke(arg1: false, null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void UpdateUsageTeam(int scene, TeamUsage usage, Action<bool> callback)
	{
		UpdateUsageTeamReq updateUsageTeamReq = new UpdateUsageTeamReq();
		updateUsageTeamReq.SceneEnum = scene;
		updateUsageTeamReq.NewUsage = usage;
		Singleton<NetManager>.instance.Request(updateUsageTeamReq, (IMessage msg) =>
		{
			if (msg is UpdateUsageTeamAck updateUsageTeamAck)
			{
				if (scene == 0)
				{
					CharacterDataHelper.MergeCharacterRepository(updateUsageTeamAck.SceneEnum, updateUsageTeamAck.CharacterRepository, removeExcess: false);
					CharacterDependHelper.MergeCharacterDependChange(updateUsageTeamAck.SceneEnum, updateUsageTeamAck.CharacterRepository, removeExcess: false);
				}
				else
				{
					CharacterDataHelper.MergeCharacterRepository(updateUsageTeamAck.SceneEnum, updateUsageTeamAck.CharacterRepository, removeExcess: true);
					CharacterDependHelper.MergeCharacterDependChange(updateUsageTeamAck.SceneEnum, updateUsageTeamAck.CharacterRepository, removeExcess: true);
				}
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void BattlePassBuyLevelReq(int buyCount, Action<bool> callback)
	{
		BattlePassBuyLevelReq data = new BattlePassBuyLevelReq
		{
			BuyCount = buyCount
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is BattlePassBuyLevelAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				if (msg is ErrorAck errorAck)
				{
					LuminError.Handle(errorAck);
				}
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void BattlePassClaimTaskReq(int taskGroupId, int taskId, Action<bool> callback)
	{
		BattlePassClaimTaskReq data = new BattlePassClaimTaskReq
		{
			TaskId = taskGroupId,
			SubTaskId = taskId
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is BattlePassClaimTaskAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				if (msg is ErrorAck errorAck)
				{
					LuminError.Handle(errorAck);
				}
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void BattlePassClaimRewardReq(int level, bool isPremium, Action<bool, RepeatedField<UniversalItem>> callback)
	{
		BattlePassClaimRewardReq data = new BattlePassClaimRewardReq
		{
			Level = level,
			Premium = isPremium
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is BattlePassClaimRewardAck battlePassClaimRewardAck)
			{
				callback?.Invoke(arg1: true, battlePassClaimRewardAck.Items);
			}
			else
			{
				if (msg is ErrorAck errorAck)
				{
					LuminError.Handle(errorAck);
				}
				callback?.Invoke(arg1: false, null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SendUnlockTextLibraryReq(List<int> unlockIds, Action<VocabularyUnlockContentAck, bool> callBack)
	{
		VocabularyUnlockContentReq vocabularyUnlockContentReq = new VocabularyUnlockContentReq();
		vocabularyUnlockContentReq.IdList.AddRange(unlockIds);
		Singleton<NetManager>.instance.Request(vocabularyUnlockContentReq, (IMessage msg) =>
		{
			if (msg is VocabularyUnlockContentAck arg)
			{
				callBack?.Invoke(arg, arg2: true);
			}
			else
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("文本库词条解锁协议同步失败");
				}
				callBack?.Invoke(null, arg2: false);
			}
		});
	}

	public void SendTextLibraryReadReq(List<int> textLibraryIds, Action<bool> callBack)
	{
		VocabularyReadContentReq vocabularyReadContentReq = new VocabularyReadContentReq();
		vocabularyReadContentReq.IdList.AddRange(textLibraryIds);
		Singleton<NetManager>.instance.Request(vocabularyReadContentReq, (IMessage msg) =>
		{
			if (msg is VocabularyReadContentAck)
			{
				callBack?.Invoke(obj: true);
			}
			else
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("文本库词条阅读协议同步失败");
				}
				callBack?.Invoke(obj: false);
			}
		});
	}

	public void SendTextLibraryGroupState(Dictionary<int, bool> syncGoup, Action<bool> callBack)
	{
		VocabularyRememberGroupStateReq vocabularyRememberGroupStateReq = new VocabularyRememberGroupStateReq();
		foreach (KeyValuePair<int, bool> item in syncGoup)
		{
			vocabularyRememberGroupStateReq.GroupState[item.Key] = item.Value;
		}
		Singleton<NetManager>.instance.Request(vocabularyRememberGroupStateReq, (IMessage msg) =>
		{
			if (msg is VocabularyRememberGroupStateAck)
			{
				callBack?.Invoke(obj: true);
			}
			else
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("文本库词条组展开状态协议同步失败");
				}
				callBack?.Invoke(obj: false);
			}
		});
	}

	public void SendOpenPackageGift(int packageGiftId, int openCount, Action<List<UniversalItem>, bool> callback, int selfSelectItemIndex = 0)
	{
		OpenBagChestReq openBagChestReq = new OpenBagChestReq();
		openBagChestReq.ItemId = packageGiftId;
		openBagChestReq.Count = openCount;
		openBagChestReq.ChooseIndex = selfSelectItemIndex;
		Singleton<NetManager>.instance.Request(openBagChestReq, (IMessage msg) =>
		{
			if (msg is OpenBagChestAck openBagChestAck)
			{
				callback?.Invoke(openBagChestAck.Items.ToList(), arg2: true);
			}
			else
			{
				callback?.Invoke(null, arg2: false);
			}
		});
	}

	public void RecycleItemsReq(RepeatedField<UniversalItem> universalItems, Action<RecycleItemsAck> callback)
	{
		RecycleItemsReq recycleItemsReq = new RecycleItemsReq();
		recycleItemsReq.Items.AddRange(universalItems);
		Singleton<NetManager>.instance.Request(recycleItemsReq, (IMessage msg) =>
		{
			if (msg is RecycleItemsAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void ActivityRoleTrialRewardReq(int activityId, int activityGroup, int activityChallenge, Action<ActivityRoleTrialRewardAck> callback)
	{
		ActivityRoleTrialRewardReq activityRoleTrialRewardReq = new ActivityRoleTrialRewardReq();
		activityRoleTrialRewardReq.ActivityId = activityId;
		activityRoleTrialRewardReq.ActivityGroup = activityGroup;
		activityRoleTrialRewardReq.ActivityChallenge = activityChallenge;
		Singleton<NetManager>.instance.Request(activityRoleTrialRewardReq, (IMessage msg) =>
		{
			if (msg is ActivityRoleTrialRewardAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SendActivityDailyLotteryGachaReq(int activityID, int lotteryPoolID, Action<ActivityDailyLotteryGachaAck> callback)
	{
		Model<ActivityCenterModel>.Interface.GetLotteryInfo().LotteryInfos.TryGetValue(lotteryPoolID, out var value);
		ActivityDailyLotteryGachaReq activityDailyLotteryGachaReq = new ActivityDailyLotteryGachaReq();
		activityDailyLotteryGachaReq.ActivityId = activityID;
		activityDailyLotteryGachaReq.GachaConut = value?.LeftGachaConut ?? 0;
		activityDailyLotteryGachaReq.LotteryPoolId = lotteryPoolID;
		Singleton<NetManager>.instance.Request(activityDailyLotteryGachaReq, (IMessage msg) =>
		{
			if (msg is ActivityDailyLotteryGachaAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SendAwardChapterReward(int chapterId, Action<HandbookGrowthGuideChapterClaimRewardAck, bool> callback)
	{
		HandbookGrowthGuideChapterClaimRewardReq handbookGrowthGuideChapterClaimRewardReq = new HandbookGrowthGuideChapterClaimRewardReq();
		handbookGrowthGuideChapterClaimRewardReq.Id = chapterId;
		Singleton<NetManager>.instance.Request(handbookGrowthGuideChapterClaimRewardReq, (IMessage msg) =>
		{
			if (msg is HandbookGrowthGuideChapterClaimRewardAck arg)
			{
				callback?.Invoke(arg, arg2: true);
			}
			else
			{
				callback?.Invoke(null, arg2: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SendAwardTargetGuideMissionReward(int missionGroupId, int chapterId, Action<HandbookGrowthGuideMissionClaimRewardAck, bool> callback)
	{
		HandbookGrowthGuideMissionClaimRewardReq handbookGrowthGuideMissionClaimRewardReq = new HandbookGrowthGuideMissionClaimRewardReq();
		handbookGrowthGuideMissionClaimRewardReq.Id = missionGroupId;
		handbookGrowthGuideMissionClaimRewardReq.ChapterID = chapterId;
		Singleton<NetManager>.instance.Request(handbookGrowthGuideMissionClaimRewardReq, (IMessage msg) =>
		{
			if (msg is HandbookGrowthGuideMissionClaimRewardAck arg)
			{
				callback?.Invoke(arg, arg2: true);
			}
			else
			{
				callback?.Invoke(null, arg2: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SendRedeemCodeUseReq(string code, Action<RedeemCodeUseAck, bool, IMessage> callback)
	{
		RedeemCodeUseReq redeemCodeUseReq = new RedeemCodeUseReq();
		redeemCodeUseReq.Code = code;
		Singleton<NetManager>.instance.Request(redeemCodeUseReq, (IMessage msg) =>
		{
			int num = 0;
			int type = 0;
			if (msg is RedeemCodeUseAck arg)
			{
				num = 1;
				type = 1;
				callback?.Invoke(arg, arg2: true, msg);
			}
			else
			{
				num = 2;
				if (msg is ErrorAck { CodeModule: 36 } errorAck)
				{
					if (errorAck.SubCode == 1)
					{
						type = 3;
					}
					else if (errorAck.SubCode == 2)
					{
						type = 4;
					}
					else if (errorAck.SubCode == 3)
					{
						type = 5;
					}
				}
				callback?.Invoke(null, arg2: false, msg);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
			CdkeyEvent evt = EventTrackSolver.Instance.GetEvt<CdkeyEvent>();
			evt.cdkey = code;
			evt.result = num;
			evt.type = type;
			EventTrackSolver.Instance.Dispatch(evt);
		});
	}

	public void RequestEnterLounge(Action<IMessage> callback)
	{
		Singleton<NetManager>.instance.Request(new LoungeEnterReq(), callback);
	}

	public void SendChangeGender(int gender, Action<ChangeGenderAck> callback)
	{
		ChangeGenderReq changeGenderReq = new ChangeGenderReq();
		changeGenderReq.Gender = gender;
		Singleton<NetManager>.instance.Request(changeGenderReq, (IMessage msg) =>
		{
			if (msg is ChangeGenderAck obj)
			{
				callback?.Invoke(obj);
			}
		});
	}

	public void WildBossTakeRewardReq(int wildBossCollectionUid, Action<bool, RepeatedField<UniversalItem>> callback)
	{
		WildBossTakeRewardReq data = new WildBossTakeRewardReq
		{
			InteractionObjUID = wildBossCollectionUid
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is WildBossTakeRewardAck wildBossTakeRewardAck)
			{
				callback?.Invoke(arg1: true, wildBossTakeRewardAck.GotRewards);
			}
			else
			{
				callback?.Invoke(arg1: false, null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void WildBossRewardBoughtReq(int buyCont, Action<bool> callback)
	{
		WildBossRewardBoughtReq data = new WildBossRewardBoughtReq
		{
			Count = buyCont
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is WildBossRewardBoughtAck)
			{
				callback?.Invoke(obj: true);
			}
			else
			{
				callback?.Invoke(obj: false);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SendAchievementRewardReq(int groupId, Action<AchievementRewardAck> callback)
	{
		AchievementRewardReq achievementRewardReq = new AchievementRewardReq();
		achievementRewardReq.GroupId = groupId;
		Singleton<NetManager>.instance.Request(achievementRewardReq, (IMessage msg) =>
		{
			if (msg is AchievementRewardAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SendAchievementGroupRewardReq(int groupId, Action<AchievementGroupRewardAck> callback)
	{
		AchievementGroupRewardReq achievementGroupRewardReq = new AchievementGroupRewardReq();
		achievementGroupRewardReq.GroupId = groupId;
		Singleton<NetManager>.instance.Request(achievementGroupRewardReq, (IMessage msg) =>
		{
			if (msg is AchievementGroupRewardAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SendChangeSkinReq(int roleId, int skinId, Action<ChangeSkinAck> callback)
	{
		ChangeSkinReq changeSkinReq = new ChangeSkinReq();
		changeSkinReq.CharacterId = roleId;
		changeSkinReq.SkinId = skinId;
		Singleton<NetManager>.instance.Request(changeSkinReq, (IMessage msg) =>
		{
			if (msg is ChangeSkinAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SendChangeEffectDressReq(int roleId, int effectDressId, bool wear, Action<ChangeEffectDressAck> callback)
	{
		ChangeEffectDressReq changeEffectDressReq = new ChangeEffectDressReq();
		changeEffectDressReq.CharacterId = roleId;
		changeEffectDressReq.EffectDressId = effectDressId;
		changeEffectDressReq.Wear = wear;
		Singleton<NetManager>.instance.Request(changeEffectDressReq, (IMessage msg) =>
		{
			if (msg is ChangeEffectDressAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SendMonthlyPassRecordPopReq(int passId, long PopTimeUnix, Action<MonthlyPassRecordPopAck> callback)
	{
		MonthlyPassRecordPopReq monthlyPassRecordPopReq = new MonthlyPassRecordPopReq();
		monthlyPassRecordPopReq.PassId = passId;
		monthlyPassRecordPopReq.LastPopTimeUnix = PopTimeUnix;
		Singleton<NetManager>.instance.Request(monthlyPassRecordPopReq, (IMessage msg) =>
		{
			if (msg is MonthlyPassRecordPopAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SendActivitySkinTrialRewardReq(int activityId, int activityChallengeGroupId, int activityChallengeId, Action<ActivitySkinTrialRewardAck> callback)
	{
		ActivitySkinTrialRewardReq activitySkinTrialRewardReq = new ActivitySkinTrialRewardReq();
		activitySkinTrialRewardReq.ActivityId = activityId;
		activitySkinTrialRewardReq.ActivityGroup = activityChallengeGroupId;
		activitySkinTrialRewardReq.ActivityChallenge = activityChallengeId;
		Singleton<NetManager>.instance.Request(activitySkinTrialRewardReq, (IMessage msg) =>
		{
			if (msg is ActivitySkinTrialRewardAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SendActivityTotalRechargeRewardReq(int activityId, int activityGroup, Action<ActivityTotalRechargeRewardAck> callback)
	{
		ActivityTotalRechargeRewardReq data = new ActivityTotalRechargeRewardReq
		{
			ActivityId = activityId,
			ActivityGroup = activityGroup
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is ActivityTotalRechargeRewardAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SendActivityKujiRewardReq(int activityId, int activityGroup, Action<ActivityKujiRewardAck> callback)
	{
		ActivityKujiRewardReq data = new ActivityKujiRewardReq
		{
			ActivityId = activityId,
			ActivityGroup = activityGroup
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is ActivityKujiRewardAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}

	public void SendActivityKujiDrawReq(int activityId, Action<ActivityKujiDrawAck> callback)
	{
		ActivityKujiDrawReq data = new ActivityKujiDrawReq
		{
			ActivityId = activityId
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is ActivityKujiDrawAck obj)
			{
				callback?.Invoke(obj);
			}
			else
			{
				callback?.Invoke(null);
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(msg);
				}
			}
		});
	}
}
