using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model.Jump;
using ACT.RichText;
using ACT.UI;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;

namespace ACT.Model;

public class RaidModel : Model<RaidModel>, IJumpable
{
	private bool _isParkourRaid;

	private string _collectInfoTarget;

	private string _collectInfoTarget2;

	private int _collectInfoTotal;

	private string[] _extraAbility;

	private ACT.Game.Data.Raid _curChallengeRaidInfo;

	private MapField<int, ACT.Game.Data.Raid> _raidMapFiled;

	private StageChallengeTarget _lastChallengeInfo = new StageChallengeTarget();

	private Action _onRaidInfoChanged;

	public ACT.Game.Data.Raid CurChallengeRaidInfo => _curChallengeRaidInfo;

	public int CurrentRaidId => _curChallengeRaidInfo?.Id ?? 0;

	public bool ShowTrialTips { get; private set; }

	public int ShowTipsCharacterId { get; private set; }

	public int ParkourTrapTimes { get; set; }

	public bool IsParkourRaid => _isParkourRaid;

	public string CollectInfoTarget => _collectInfoTarget;

	public string CollectInfoTarget2 => _collectInfoTarget2;

	public int CollectInfoTotal => _collectInfoTotal;

	public int PowerCost { get; private set; }

	public int CostRate { get; set; }

	public int CollectInfoNum { get; set; }

	public System.DateTime StartTime { get; set; }

	public float Duration => GetTimer();

	public int CollectCount { get; set; }

	public LuminModelType JumpSourceType => LuminModelType.Raids;

	public event Action OnRaidInfoChanged
	{
		add
		{
			_onRaidInfoChanged = (Action)Delegate.Combine(_onRaidInfoChanged, value);
		}
		remove
		{
			_onRaidInfoChanged = (Action)Delegate.Remove(_onRaidInfoChanged, value);
		}
	}

	protected override void Init()
	{
	}

	protected override void UnInit()
	{
		_isParkourRaid = false;
		if (_raidMapFiled != null)
		{
			_raidMapFiled.Clear();
			_raidMapFiled = null;
		}
	}

	public void UpdateRaidInfo(ACT.Game.Data.Raid raidInfo)
	{
		_curChallengeRaidInfo = raidInfo;
	}

	public int GetRaidCleanNum(int raidId)
	{
		if (_raidMapFiled == null)
		{
			return 0;
		}
		if (_raidMapFiled.TryGetValue(raidId, out var value))
		{
			return value.CleanNum;
		}
		return 0;
	}

	public ACT.Game.Data.Raid GetRaidInfo(int raidId)
	{
		return _raidMapFiled?.GetValueOrDefault(raidId);
	}

	public void InitDataByNtf(MapField<int, ACT.Game.Data.Raid> raidMapField, int curChallengeRaidId)
	{
		if (_raidMapFiled == null)
		{
			_raidMapFiled = new MapField<int, ACT.Game.Data.Raid>();
		}
		foreach (KeyValuePair<int, ACT.Game.Data.Raid> item in raidMapField)
		{
			if (_raidMapFiled.ContainsKey(item.Key))
			{
				_raidMapFiled[item.Key] = item.Value;
			}
			else
			{
				_raidMapFiled.Add(item.Key, item.Value);
			}
		}
		_curChallengeRaidInfo = GetRaidInfo(curChallengeRaidId);
		_onRaidInfoChanged?.Invoke();
	}

	public void ResetTimer()
	{
		StartTime = System.DateTime.Now;
	}

	public float GetTimer()
	{
		return (int)Singleton<GameManager>.instance.worldManager.GetCurrentWorldRuntime();
	}

	public void SetRaidInfo(bool isReconnect = false)
	{
		int value = 0;
		int currentRaidId = CurrentRaidId;
		foreach (KeyValuePair<int, RaidEntranceData> raidEntranceData in RuntimeConfigs.data.raidEntranceDatas)
		{
			if (raidEntranceData.Value.raidId.Contains(currentRaidId))
			{
				value = raidEntranceData.Key;
			}
		}
		if (RuntimeConfigs.data.raids.TryGetValue(currentRaidId, out var value2))
		{
			CostRate = ((CostRate <= 0) ? 1 : CostRate);
			PowerCost = ((value2.cost.Count > 0) ? (value2.cost[0].count * CostRate) : 0);
		}
		_isParkourRaid = false;
		foreach (KeyValuePair<int, RaidTypeData> raidTypeData in RuntimeConfigs.data.raidTypeDatas)
		{
			if (raidTypeData.Value.raidEntranceId.Contains(value) && raidTypeData.Value.raidType == 7)
			{
				_isParkourRaid = true;
				Singleton<EventManager>.instance.AddEventListener(ClientEvent.RaidCollectInfoChange, RaidCollectInfoChange);
				if (!isReconnect)
				{
					ParkourTrapTimes = 0;
				}
				else
				{
					ParkourTrapTimes = _curChallengeRaidInfo.PlayerDeathCount;
				}
			}
		}
		string target = string.Empty;
		string target2 = string.Empty;
		int total = -1;
		if (RuntimeConfigs.data.raids.TryGetValue(currentRaidId, out var value3))
		{
			if (value3.mainTarget.Length >= 1 && RuntimeConfigs.data.raidMissionTargets.TryGetValue(value3.mainTarget[0], out var value4))
			{
				target = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value4.mainTarget);
			}
			if (value3.mainTarget.Length >= 2 && RuntimeConfigs.data.raidMissionTargets.TryGetValue(value3.mainTarget[1], out var value5))
			{
				target2 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value5.mainTarget);
				if (RuntimeConfigs.data.raidParkourDatas.TryGetValue(currentRaidId, out var value6))
				{
					total = value6.total;
				}
			}
		}
		SetParkourRaidInfo(target, target2, total);
		ACT.Config.Raid data = CoreUtils.GetData(currentRaidId, RuntimeConfigs.data.raids);
		int raidType = GetRaidType(currentRaidId);
		if (data != null && data.tryRole != null && data.tryRole.Length != 0 && raidType == 6)
		{
			EntityCharacterProbation data2 = CoreUtils.GetData(data.tryRole[0], RuntimeConfigs.data.entityCharacterProbations);
			ShowTrialTips = data2.isShow != 0 && data2.skinId == 0;
			ShowTipsCharacterId = data2.id;
			Model<BattleMainModel>.Interface.isCharacterTutorial = true;
			_extraAbility = data2.extraAbility;
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterEnterWorld, OnTrainingEnterAddAbility);
		}
	}

	private void OnTrainingEnterAddAbility(BaseEventContent baseEvent)
	{
		for (int i = 0; i < BattleConsts.TEAMCAPITAL; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			if (teamCharacter != null && _extraAbility != null && _extraAbility.Length != 0)
			{
				teamCharacter.GetCompAbility().AddAbilities(_extraAbility, AbilitySource.System);
			}
		}
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterEnterWorld, OnTrainingEnterAddAbility);
	}

	public void SetParkourRaidInfo(string target, string target2, int total)
	{
		_collectInfoTarget = target;
		_collectInfoTarget2 = target2;
		_collectInfoTotal = total;
		CollectInfoNum = 0;
	}

	public void LeaveParkourRaid()
	{
		if (_isParkourRaid)
		{
			_isParkourRaid = false;
			Singleton<GameState>.instance.SeMainPlayerState(MainPlayerState.None);
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.RaidCollectInfoHide, null);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RaidCollectInfoChange, RaidCollectInfoChange);
		}
		Model<BattleMainModel>.Interface.isCharacterTutorial = false;
	}

	public void RaidCollectInfoChange(BaseEventContent obj)
	{
		CollectCount = ((RaidCollectInfoChangeEvt)obj).collectCount;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.RaidCollectInfoRefresh, null);
	}

	public bool IsUnlock(ACT.Config.Raid raid)
	{
		if (raid == null)
		{
			return false;
		}
		if (raid.unlockCondition > 0 && !Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(raid.unlockCondition))
		{
			return false;
		}
		if (raid.frontCondition > 0)
		{
			ACT.Game.Data.Raid raidInfo = GetRaidInfo(raid.frontCondition);
			if (_raidMapFiled != null && _raidMapFiled.ContainsKey(raid.frontCondition))
			{
				if (raidInfo != null)
				{
					return raidInfo.CleanNum > 0;
				}
				return false;
			}
			return false;
		}
		return true;
	}

	public TeamUsage GetRaidTrialTeamUsage(int raidId)
	{
		return GetTrialTeamUsage(CoreUtils.GetData(raidId, RuntimeConfigs.data.raids)?.tryRole);
	}

	public TeamUsage GetTeamTeachingTrialTeamUsage(int raidId)
	{
		if (RuntimeConfigs.data?.trainingContentss == null)
		{
			return null;
		}
		foreach (TrainingContents value in RuntimeConfigs.data.trainingContentss.Values)
		{
			if (value != null && value.raidID == raidId)
			{
				int[] teamCharacter = value.teamCharacter;
				if (teamCharacter != null && teamCharacter.Length > 0)
				{
					return GetTrialTeamUsage(value.teamCharacter);
				}
			}
		}
		return null;
	}

	public TeamUsage GetTrialTeamUsage(IReadOnlyList<int> trialCharacterIds)
	{
		if (trialCharacterIds == null)
		{
			return null;
		}
		TeamUsage teamUsage = new TeamUsage();
		teamUsage.BattleCharacterIdx = 0;
		teamUsage.EquipPotionId = 0;
		bool flag = false;
		for (int i = 0; i < BattleConsts.TEAMCAPITAL; i++)
		{
			int num = ((i < trialCharacterIds.Count) ? trialCharacterIds[i] : 0);
			teamUsage.CharacterUsage.Add(new TeamCharacterUsage
			{
				CharacterId = num,
				IsTrial = (num > 0)
			});
			flag |= num > 0;
		}
		if (!flag)
		{
			return null;
		}
		return teamUsage;
	}

	public bool HasLeftTimes()
	{
		int num = 0;
		int currentRaidId = Model<RaidModel>.Interface.CurrentRaidId;
		foreach (KeyValuePair<int, RaidEntranceData> raidEntranceData2 in RuntimeConfigs.data.raidEntranceDatas)
		{
			if (raidEntranceData2.Value.raidId.Contains(currentRaidId))
			{
				num = raidEntranceData2.Key;
			}
		}
		int key = 0;
		foreach (KeyValuePair<int, RaidTypeData> raidTypeData2 in RuntimeConfigs.data.raidTypeDatas)
		{
			if (raidTypeData2.Value.raidEntranceId.Contains(num))
			{
				key = raidTypeData2.Key;
			}
		}
		RaidTypeData raidTypeData = RuntimeConfigs.data.raidTypeDatas[key];
		if (raidTypeData.cycleParm == null || raidTypeData.cycleParm.Length == 0)
		{
			return true;
		}
		bool flag = GetRaidInfo(num)?.FirstRewardDone ?? false;
		if (raidTypeData.cycleParm[0] == 1)
		{
			int num2 = 0;
			int[] raidEntranceId = raidTypeData.raidEntranceId;
			foreach (int entranceId in raidEntranceId)
			{
				num2 += GetUsedTimesByEnteranceId(entranceId);
			}
			if ((raidTypeData.cycleParm[1] - num2 <= 0) & flag)
			{
				return false;
			}
		}
		else if ((raidTypeData.cycleParm[1] - GetUsedTimesByEnteranceId(num) <= 0) & flag)
		{
			return false;
		}
		return true;
		int GetUsedTimesByEnteranceId(int key2)
		{
			RaidEntranceData raidEntranceData = RuntimeConfigs.data.raidEntranceDatas[key2];
			int num3 = 0;
			int[] raidId = raidEntranceData.raidId;
			foreach (int raidId2 in raidId)
			{
				ACT.Game.Data.Raid raidInfo = GetRaidInfo(raidId2);
				if (raidInfo != null)
				{
					num3 += raidInfo.TakeRewardCount;
				}
			}
			return num3;
		}
	}

	public void RaidSettlement()
	{
		if (MonoECS.instance.sceneStatus == SceneStatus.Raid)
		{
			Model<TeamTeachingModel>.Interface.MarkCurrentChallengeCompleted();
			if (Model<ChallengeTargetTrackerModel>.HasInstance())
			{
				Model<ChallengeTargetTrackerModel>.Interface.MarkChallengeCompleted();
			}
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.WorldSuccess, null);
			Settlement().Forget();
		}
	}

	private async UniTask Settlement()
	{
		int raidType = GetRaidType(CurrentRaidId);
		if (raidType != 7)
		{
			await GameUtility.PlaySettlementPreformance(GameLoader.raidPerformanceConfig);
		}
		if (raidType == 8)
		{
			await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_RAIDBOSSEXIT, new RaidBossExitView.RaidBossExitData
			{
				OnCloseHandle = () =>
				{
					OpenRaidSettle();
				}
			});
		}
		else
		{
			OpenRaidSettle();
		}
	}

	private void OpenRaidSettle()
	{
		CostRate = ((CostRate <= 0) ? 1 : CostRate);
		G.service.GetRaidRewardInfo(CostRate, async (bool r, RepeatedField<UniversalItem> ack) =>
		{
			if (r)
			{
				CommonWorldSuccessView.CommonWorldSuccessData uiData = GameUtility.CreateWorldSuccessRewardData(ack);
				await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_COMMONWORLDSUCCESS, uiData);
			}
		});
	}

	public bool GetRaidRateDropdownRedState(int raidId)
	{
		if (G.localPlayer.redPoints.RaidRate.TryGetValue(raidId, out var value))
		{
			foreach (KeyValuePair<int, bool> item in value.RateInfo)
			{
				if (item.Value)
				{
					return true;
				}
			}
		}
		return false;
	}

	public int GetRaidType(int raidId)
	{
		if (!RuntimeConfigs.data.raids.TryGetValue(raidId, out var value))
		{
			return -1;
		}
		foreach (KeyValuePair<int, RaidTypeData> raidTypeData in RuntimeConfigs.data.raidTypeDatas)
		{
			for (int i = 0; i < raidTypeData.Value.raidEntranceId.Length; i++)
			{
				if (raidTypeData.Value.raidEntranceId[i] == value.belongEntranceData)
				{
					return raidTypeData.Value.raidType;
				}
			}
		}
		return -1;
	}

	public RaidTypeData GetRaidTypeConfig(int raidId)
	{
		if (!RuntimeConfigs.data.raids.TryGetValue(raidId, out var value))
		{
			return null;
		}
		foreach (KeyValuePair<int, RaidTypeData> raidTypeData in RuntimeConfigs.data.raidTypeDatas)
		{
			for (int i = 0; i < raidTypeData.Value.raidEntranceId.Length; i++)
			{
				if (raidTypeData.Value.raidEntranceId[i] == value.belongEntranceData)
				{
					return raidTypeData.Value;
				}
			}
		}
		return null;
	}

	public int GetRaidTypeId(int raidEnranceId)
	{
		if (!RuntimeConfigs.data.raidEntranceDatas.TryGetValue(raidEnranceId, out var _))
		{
			return -1;
		}
		foreach (KeyValuePair<int, RaidTypeData> raidTypeData in RuntimeConfigs.data.raidTypeDatas)
		{
			for (int i = 0; i < raidTypeData.Value.raidEntranceId.Length; i++)
			{
				if (raidTypeData.Value.raidEntranceId[i] == raidEnranceId)
				{
					return raidTypeData.Value.id;
				}
			}
		}
		return -1;
	}

	public int GetRaidTypeByEntranceId(int raidEntranceId)
	{
		int raidTypeId = GetRaidTypeId(raidEntranceId);
		if (!RuntimeConfigs.data.raidTypeDatas.TryGetValue(raidTypeId, out var value))
		{
			return -1;
		}
		return value.raidType;
	}

	public bool GetIsCharacterTrial(int raidId)
	{
		if (Model<RaidModel>.Interface.GetRaidType(raidId) == 6)
		{
			ACT.Config.Raid data = CoreUtils.GetData(raidId, RuntimeConfigs.data.raids);
			if (data != null && data.tryRole != null && data.tryRole.Length != 0)
			{
				if (CoreUtils.GetData(data.tryRole[0], RuntimeConfigs.data.entityCharacterProbations).isShow != 0)
				{
					return true;
				}
				return false;
			}
		}
		return false;
	}

	public void RecordChallengeInfo(StageChallengeTarget target)
	{
		_lastChallengeInfo = target;
	}

	public StageChallengeTarget GetChallengeInfo()
	{
		return _lastChallengeInfo;
	}

	public void OpenHandBookView(int raidEntranceId, Action callBack = null)
	{
		HandBookViewParam handBookViewParam = GetHandBookViewParam(raidEntranceId);
		if (handBookViewParam == null || handBookViewParam.H1TabIndex <= 0 || handBookViewParam.H2TabIndex <= 0)
		{
			callBack?.Invoke();
			return;
		}
		handBookViewParam.OnClose = callBack;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_HANDBOOK, handBookViewParam);
	}

	public HandBookViewParam GetHandBookViewParam(int raidEntranceId)
	{
		int raidTypeByEntranceId = GetRaidTypeByEntranceId(raidEntranceId);
		if (raidTypeByEntranceId <= 0)
		{
			return new HandBookViewParam();
		}
		int num = -1;
		foreach (HbContent value in RuntimeConfigs.data.hbContents.Values)
		{
			if (value.raidNewType.Contains(raidTypeByEntranceId))
			{
				num = value.id;
				break;
			}
		}
		int h1TabIndex = -1;
		foreach (HandBookMain value2 in RuntimeConfigs.data.handBookMains.Values)
		{
			if (value2.contentLv2ID.Contains(num))
			{
				h1TabIndex = value2.id;
				break;
			}
		}
		return new HandBookViewParam
		{
			H1TabIndex = h1TabIndex,
			H2TabIndex = num
		};
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		if (JumpModel.IsCurrentWorldChallangeNormal())
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.Hide
			};
		}
		JumpResult jumpResult = default;
		if (!JumpModel.UIJumpIdToUITypeMap.TryGetValue(jumpData.Params[0], out var value))
		{
			jumpResult.ShowType = JumpResult.JumpShowType.Hide;
			return jumpResult;
		}
		if (value.Item1 == 163)
		{
			CanJumpNPCRaid(ref jumpResult);
		}
		else
		{
			CanJumpRaid(jumpData, ref jumpResult);
		}
		return jumpResult;
	}

	private void CanJumpNPCRaid(ref JumpResult jumpResult)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Raid))
		{
			jumpResult.Message = Singleton<SystemUnlockManager>.instance.GetSystemLockTips(SystemType.Raid);
			jumpResult.ShowType = JumpResult.JumpShowType.Forbidden;
		}
		else
		{
			jumpResult.ShowType = JumpResult.JumpShowType.CanJump;
		}
	}

	private void CanJumpRaid(RuntimeJumpData jumpData, ref JumpResult jumpResult)
	{
		List<string> list = ListPool<string>.Get();
		try
		{
			if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Raid))
			{
				list.Add(Singleton<SystemUnlockManager>.instance.GetSystemLockTips(SystemType.Raid));
			}
			else
			{
				list.Add(null);
			}
			int key = jumpData.Params[1];
			if (RuntimeConfigs.data.raidEntranceDatas.TryGetValue(key, out var value))
			{
				if (value.unlockCondition > 0 && !Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(value.unlockCondition))
				{
					ACT.Config.Mission mission = RuntimeConfigs.data.missions[value.unlockCondition];
					list.Add(CustomTagParser.ReplacePreconditionText(mission, mission.number, mission.param));
				}
				else
				{
					list.Add(null);
				}
			}
			else
			{
				list.Add(null);
			}
			int num = ((jumpData.Params.Count > 2) ? jumpData.Params[2] : 0);
			if (num > 0 && RuntimeConfigs.data.raids.TryGetValue(num, out var value2))
			{
				if (value2.unlockCondition > 0 && !Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(value2.unlockCondition))
				{
					ACT.Config.Mission mission2 = RuntimeConfigs.data.missions[value2.unlockCondition];
					list.Add(CustomTagParser.ReplacePreconditionText(mission2, mission2.number, mission2.param));
				}
				else
				{
					list.Add(null);
				}
				if (value2.frontCondition > 0)
				{
					ACT.Game.Data.Raid raidInfo = GetRaidInfo(value2.frontCondition);
					if (raidInfo == null || raidInfo.CleanNum <= 0)
					{
						string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2748);
						if (string.IsNullOrEmpty(list[2]))
						{
							list[2] = localizeString;
						}
						else
						{
							List<string> list2 = list;
							list2[2] = list2[2] + LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2749) + localizeString;
						}
					}
				}
			}
			else
			{
				list.Add(null);
			}
			int raidType = value.raidType;
			bool flag = CheckIsLock(list);
			if (raidType == 8)
			{
				if (!RuntimeConfigs.data.worldBossMonsters.TryGetValue(key, out var value3))
				{
					jumpResult.ShowType = JumpResult.JumpShowType.Hide;
				}
				int enemyType = CoreUtils.GetData(value3.worldBossID, RuntimeConfigs.data.entityEnemyDatas).enemyType;
				if (Model<MonsterHandModel>.Interface.IsUnlockByenemyType(enemyType))
				{
					if (flag)
					{
						if (string.IsNullOrEmpty(list[1]))
						{
							ClearEmptyElement(list);
							jumpResult = new JumpResult(JumpResult.JumpShowType.Forbidden, null);
							jumpResult.SetMessages(list);
						}
						else
						{
							jumpResult.ShowType = JumpResult.JumpShowType.Hide;
						}
					}
					else
					{
						jumpResult.ShowType = JumpResult.JumpShowType.CanJump;
					}
				}
				else
				{
					jumpResult.ShowType = JumpResult.JumpShowType.Hide;
				}
			}
			else if (flag)
			{
				ClearEmptyElement(list);
				jumpResult = new JumpResult(JumpResult.JumpShowType.Forbidden, null);
				jumpResult.SetMessages(list);
			}
			else
			{
				jumpResult.ShowType = JumpResult.JumpShowType.CanJump;
			}
		}
		finally
		{
			ListPool<string>.Release(list);
		}
	}

	private bool CheckIsLock(List<string> messages)
	{
		foreach (string message in messages)
		{
			if (!string.IsNullOrEmpty(message))
			{
				return true;
			}
		}
		return false;
	}

	private void ClearEmptyElement(List<string> messages)
	{
		for (int num = messages.Count - 1; num >= 0; num--)
		{
			if (string.IsNullOrEmpty(messages[num]))
			{
				messages.RemoveAt(num);
			}
		}
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		if (JumpModel.UIJumpIdToUITypeMap.TryGetValue(jumpData.Params[0], out var value))
		{
			if (value.Item1 == 163)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_NPCRAID, jumpData.Params[1]);
				return;
			}
			MonoRaidViewData monoRaidViewData = new MonoRaidViewData();
			monoRaidViewData.RaidEntranceId = jumpData.Params[1];
			monoRaidViewData.RaidId = ((jumpData.Params.Count > 2) ? jumpData.Params[2] : 0);
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_RAID, monoRaidViewData);
		}
	}
}
