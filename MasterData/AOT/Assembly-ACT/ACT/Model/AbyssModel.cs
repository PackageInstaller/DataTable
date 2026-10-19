using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model.Jump;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using Google.Protobuf.Collections;
using Pb;

namespace ACT.Model;

public class AbyssModel : Model<AbyssModel>, IJumpable
{
	private int m_curFixedAbyssId;

	private int m_curCycleAbyssId;

	private int m_starNum;

	private bool m_hasAbyssReward;

	private List<List<int>> teams = new List<List<int>>();

	public Dictionary<int, int> abyssUsedIds;

	public AbyssType CurAbyssType = AbyssType.Fixed;

	public Dictionary<int, Abyss> allAbyssData;

	private List<TeamUsage> _abyssModifyData;

	public int curOperateTeam = -1;

	private int _curLayerTime;

	public List<TeamUsage> lastChangeTeamUsages;

	private Action<bool> _activeTimerAction;

	private Action _updateTimerAction;

	private bool _timerUpdate;

	private RepeatedField<UniversalItem> _cacheQuickStageRewards;

	private StageChallengeTarget _lastChallengeInfo = new StageChallengeTarget();

	private int _lastChallengeGroupId = -1;

	private List<Func<BloodBottleData, BloodBottleData, int>> _compareBottle = new List<Func<BloodBottleData, BloodBottleData, int>>();

	public Abyss CurAbyssData => _curAbyssData;

	private Abyss _curAbyssData
	{
		get
		{
			if (CurAbyssType == AbyssType.Fixed && allAbyssData.TryGetValue(m_curFixedAbyssId, out var value))
			{
				return value;
			}
			if (CurAbyssType == AbyssType.Cycle && allAbyssData.TryGetValue(m_curCycleAbyssId, out var value2))
			{
				return value2;
			}
			return null;
		}
	}

	public int GroupId => _curAbyssData?.Id ?? 0;

	public int CurAbyssStageId
	{
		get
		{
			if (CurAbyssStageIndex < 0)
			{
				return -1;
			}
			return CoreUtils.GetData(GroupId, RuntimeConfigs.data.abyssGroupDatas).abyssInclude[CurAbyssStageIndex];
		}
	}

	public int CurAbyssStageIndex => _curAbyssData?.CurChallengeStage ?? (-1);

	public int CurAbyssSubStageId
	{
		get
		{
			if (CurAbyssSubStageIndex < 0)
			{
				return -1;
			}
			return CoreUtils.GetData(CurAbyssStageId, RuntimeConfigs.data.abyssDatas).subabyss[CurAbyssSubStageIndex];
		}
	}

	public int CurAbyssSubStageIndex
	{
		get
		{
			if (CurAbyssStageIndex < 0)
			{
				return -1;
			}
			return _curAbyssData.Stages[CurAbyssStageIndex].CurChallengeSubStage;
		}
	}

	public AbyssData AbyssData => CoreUtils.GetData(CurAbyssStageId, RuntimeConfigs.data.abyssDatas);

	public int CompletedTargetsNum => _curAbyssData.Stages[CurAbyssStageIndex].CompletedTargetsNum;

	public RepeatedField<int> LatestUseSeconds
	{
		get
		{
			if (_curAbyssData == null)
			{
				return new RepeatedField<int>();
			}
			return _curAbyssData.Stages[CurAbyssStageIndex].LatestUseSeconds;
		}
	}

	public int LastChallengeStageIndex => _curAbyssData?.LastChallengeStage ?? 0;

	public RepeatedField<AbyssStage> AbyssStages
	{
		get
		{
			if (_curAbyssData == null)
			{
				return new RepeatedField<AbyssStage>();
			}
			return _curAbyssData.Stages;
		}
	}

	public MapField<int, bool> AbyssTakenRewards
	{
		get
		{
			if (_curAbyssData == null)
			{
				return new MapField<int, bool>();
			}
			return _curAbyssData.TakenRewards;
		}
	}

	public List<int> AbyssTarget { get; private set; }

	public List<TeamUsage> AbyssModifyData => _abyssModifyData;

	public int CurLayerTime => _curLayerTime;

	public int SettlementTime { get; private set; }

	public int StartNum => m_starNum;

	public System.DateTime StartTime { get; set; }

	public System.DateTime SubStageStartTime { get; set; }

	public float Duration => GetTimer();

	public float SubStageDuration => GetSubStageTimer();

	public bool TimerUpdate => _timerUpdate;

	public LuminModelType JumpSourceType => LuminModelType.AbyssLayers;

	public event Action<bool> ActiveTimerAction
	{
		add
		{
			_activeTimerAction = (Action<bool>)Delegate.Combine(_activeTimerAction, value);
		}
		remove
		{
			_activeTimerAction = (Action<bool>)Delegate.Remove(_activeTimerAction, value);
		}
	}

	public event Action UpdateTimerAction
	{
		add
		{
			_updateTimerAction = (Action)Delegate.Combine(_updateTimerAction, value);
		}
		remove
		{
			_updateTimerAction = (Action)Delegate.Remove(_updateTimerAction, value);
		}
	}

	public void CacheSettlementTime()
	{
		SettlementTime = GetAbyssTotalTime();
	}

	public void ActiveTimer(bool active)
	{
		_timerUpdate = active;
		_activeTimerAction?.Invoke(active);
	}

	public void UpdateTimer()
	{
		_curLayerTime++;
		_updateTimerAction?.Invoke();
	}

	private void ResetTime()
	{
		ActiveTimer(active: false);
		_curLayerTime = 0;
	}

	public void ResetTimer()
	{
		StartTime = System.DateTime.Now;
	}

	public void ResetSubStageTimer()
	{
		SubStageStartTime = System.DateTime.Now;
	}

	public float GetTimer()
	{
		return (float)(System.DateTime.Now - StartTime).TotalSeconds;
	}

	public float GetSubStageTimer()
	{
		return (float)(System.DateTime.Now - SubStageStartTime).TotalSeconds;
	}

	protected override void Init()
	{
		RefreshAbyssID();
		if (abyssUsedIds == null)
		{
			abyssUsedIds = new Dictionary<int, int>();
		}
		if (allAbyssData == null)
		{
			allAbyssData = new Dictionary<int, Abyss>();
		}
		teams.Clear();
		_abyssModifyData = new List<TeamUsage>();
		InitCompareBottle();
		if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Abyss))
		{
			RefreshData();
		}
	}

	protected override void UnInit()
	{
		abyssUsedIds.Clear();
		allAbyssData.Clear();
		_abyssModifyData.Clear();
		curOperateTeam = -1;
		teams.Clear();
	}

	public void RefreshAbyssID()
	{
		m_curFixedAbyssId = -1;
		m_curCycleAbyssId = -1;
		foreach (KeyValuePair<int, AbyssGroupData> abyssGroupData in RuntimeConfigs.data.abyssGroupDatas)
		{
			if (abyssGroupData.Value.abyssType == 1)
			{
				m_curFixedAbyssId = abyssGroupData.Key;
				continue;
			}
			long abyssGroupEndTs = abyssGroupData.Value.abyssGroupEndTs;
			if (TimeManager.ServerTime.NowTimestamp > abyssGroupEndTs)
			{
				continue;
			}
			m_curCycleAbyssId = abyssGroupData.Key;
			break;
		}
	}

	public int GetAbyssLatestUseSeconds()
	{
		int num = 0;
		foreach (int latestUseSecond in LatestUseSeconds)
		{
			num += latestUseSecond;
		}
		return num;
	}

	public int GetAbyssTotalTime()
	{
		int num = _curLayerTime;
		RepeatedField<int> latestUseSeconds = LatestUseSeconds;
		int curAbyssSubStageIndex = CurAbyssSubStageIndex;
		for (int i = 0; i < curAbyssSubStageIndex && i < latestUseSeconds.Count; i++)
		{
			num += latestUseSeconds[i];
		}
		return num;
	}

	public void InitDataByNtf(AbyssNtf abyssNtf)
	{
		allAbyssData.Clear();
		foreach (KeyValuePair<int, Abyss> abyss in abyssNtf.Abysses)
		{
			allAbyssData.Add(abyss.Key, abyss.Value);
		}
		RefreshAbyssID();
		_lastChallengeGroupId = abyssNtf.LastChallengeAbyssID;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_RefreashAbyss, null);
	}

	public void UpdateLastChallengeGroupId(int groupId)
	{
		_lastChallengeGroupId = groupId;
	}

	public void UpdateDynamicAbyss(Abyss abyss)
	{
		if (allAbyssData.TryGetValue(abyss.Id, out var _))
		{
			allAbyssData[abyss.Id] = abyss;
		}
		else
		{
			allAbyssData.Add(abyss.Id, abyss);
		}
		SetAbyssRedDot();
	}

	public void OnCompleteSubStage(bool isCompleteAll)
	{
		ResetTime();
	}

	public void RefreshData()
	{
		if (_curAbyssData == null)
		{
			return;
		}
		m_starNum = 0;
		foreach (AbyssStage stage in _curAbyssData.Stages)
		{
			m_starNum += stage.CompletedTargetsNum;
		}
		SetAbyssRedDot();
	}

	public void UnInitAbyssData()
	{
		SettlementTime = 0;
		ResetTime();
	}

	public void InitAbyssData()
	{
		SettlementTime = 0;
		ResetTime();
		RepeatedField<Team> repeatedField = G.localPlayer.teamInfo.Teams[2].Teams;
		List<TeamUsage> list = new List<TeamUsage>();
		for (int i = 0; i < repeatedField.Count; i++)
		{
			Team team = repeatedField[i];
			if (team.CharacterIds == null || team.CharacterIds.Count <= 0)
			{
				continue;
			}
			if (list.Count <= i)
			{
				list.Add(new TeamUsage());
			}
			for (int j = 0; j < BattleConsts.TEAMCAPITAL; j++)
			{
				TeamCharacterUsage teamCharacterUsage = new TeamCharacterUsage();
				if (team.CharacterIds.Count > j)
				{
					teamCharacterUsage.CharacterId = team.CharacterIds[j];
				}
				list[i].CharacterUsage.Add(teamCharacterUsage);
				list[i].EquipPotionId = team.EquipPotionId;
			}
		}
		lastChangeTeamUsages = list;
	}

	private void SetAbyssRedDot()
	{
		SetAbyssRedDot(m_curFixedAbyssId);
		SetAbyssRedDot(m_curCycleAbyssId);
	}

	private void SetAbyssRedDot(int abyssId)
	{
		if (!RuntimeConfigs.data.abyssGroupDatas.TryGetValue(abyssId, out var value) || !allAbyssData.TryGetValue(abyssId, out var value2))
		{
			return;
		}
		for (int i = 0; i < value.abyssInclude.Length; i++)
		{
			int key = value.abyssInclude[i];
			bool active = false;
			AbyssStage abyssStage = value2.Stages[i];
			int num = RuntimeConfigs.data.abyssDatas[key].abyssGoal.Length + 1;
			for (int j = 0; j < num; j++)
			{
				if (!(abyssStage.EvaluationClaimState.TryGetValue(j + 1, out var value3) & value3) && abyssStage.CompletedTargetsNum >= j + 1)
				{
					active = true;
					break;
				}
			}
			Singleton<RedDotManager>.instance.SetLeafNodeActive(string.Format(RedDotPathDefine.HasAbyssRewardTab, abyssId, i), active);
		}
	}

	public int GetStarNumber(int stageIndex)
	{
		if (stageIndex >= _curAbyssData.Stages.Count)
		{
			return 0;
		}
		int num = 0;
		if (_curAbyssData.Stages[stageIndex].CompletedNum > 0)
		{
			num++;
		}
		return num + _curAbyssData.Stages[stageIndex].CompletedTargetsNum;
	}

	public AbyssStage GetAbyssStage(int stageIndex)
	{
		if (stageIndex >= _curAbyssData.Stages.Count)
		{
			return null;
		}
		return _curAbyssData.Stages[stageIndex];
	}

	public int GetTeamIndex(int characterId)
	{
		for (int i = 0; i < _abyssModifyData.Count; i++)
		{
			for (int j = 0; j < _abyssModifyData[i].CharacterUsage.Count; j++)
			{
				if (characterId == _abyssModifyData[i].CharacterUsage[j].CharacterId)
				{
					return i * 3 + j;
				}
			}
		}
		return -1;
	}

	public bool GetCycleAbyssIsUnLock()
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.CycleAbyss))
		{
			return false;
		}
		if (m_curCycleAbyssId <= 0)
		{
			return false;
		}
		if (!allAbyssData.TryGetValue(m_curCycleAbyssId, out var value) || value == null)
		{
			return false;
		}
		return true;
	}

	public Abyss GetAbyssByAbyssID(int abyssId)
	{
		if (allAbyssData.TryGetValue(abyssId, out var value))
		{
			return value;
		}
		return null;
	}

	public (AbyssType, int, int) GetLastChallengeInfo()
	{
		AbyssType item = AbyssType.Fixed;
		int lastChallengeGroupId = _lastChallengeGroupId;
		if (!allAbyssData.TryGetValue(lastChallengeGroupId, out var value))
		{
			item = AbyssType.Fixed;
		}
		int num = 0;
		if (value != null)
		{
			foreach (AbyssStage stage in value.Stages)
			{
				if (stage.CompletedNum > 0)
				{
					num++;
				}
			}
		}
		int item2 = 0;
		if (RuntimeConfigs.data.abyssGroupDatas.TryGetValue(lastChallengeGroupId, out var value2))
		{
			item = (AbyssType)value2.abyssType;
			item2 = value2.abyssInclude.Length;
		}
		return (item, num, item2);
	}

	public bool GetIsAllComplete()
	{
		if (allAbyssData.TryGetValue(m_curFixedAbyssId, out var value) && value.Stages.Count > 0 && value.Stages[value.Stages.Count - 1].CompletedNum >= 1)
		{
			return true;
		}
		if (allAbyssData.TryGetValue(m_curCycleAbyssId, out var value2) && value2.Stages.Count > 0 && value2.Stages[value2.Stages.Count - 1].CompletedNum >= 1)
		{
			return true;
		}
		return false;
	}

	public void CacheQuickStageRewards(RepeatedField<UniversalItem> rewards)
	{
		_cacheQuickStageRewards = rewards;
	}

	public RepeatedField<UniversalItem> GetCacheQuickStageRewards()
	{
		return _cacheQuickStageRewards;
	}

	public void RecordChallengeInfo(StageChallengeTarget target)
	{
		_lastChallengeInfo = target;
	}

	public StageChallengeTarget GetChallengeInfo()
	{
		return _lastChallengeInfo;
	}

	public bool GetChallengeIsAllComplete()
	{
		if (CurAbyssSubStageIndex + 1 >= AbyssData.subabyss.Length)
		{
			return true;
		}
		return false;
	}

	public List<Abyss> GetHistoryRecords()
	{
		List<Abyss> list = new List<Abyss>();
		foreach (KeyValuePair<int, Abyss> allAbyssDatum in allAbyssData)
		{
			if (RuntimeConfigs.data.abyssGroupDatas.TryGetValue(allAbyssDatum.Key, out var value) && value.abyssType == 2 && value.abyssGroupEndTs < TimeManager.ServerTime.NowTimestamp)
			{
				list.Add(allAbyssDatum.Value);
			}
		}
		return list;
	}

	public bool CheckCurrentAbyssIsExpired()
	{
		if (CurAbyssType == AbyssType.Cycle && RuntimeConfigs.data.abyssGroupDatas.TryGetValue(m_curCycleAbyssId, out var value))
		{
			return value.abyssGroupEndTs < TimeManager.ServerTime.NowTimestamp;
		}
		return false;
	}

	public int GetCurBloodBottleId()
	{
		return _abyssModifyData[curOperateTeam - 1].EquipPotionId;
	}

	private void InitCompareBottle()
	{
		_compareBottle.Add(BottleIsCurAbyssTeamEquip);
		_compareBottle.Add(BloodBottleQuality);
		_compareBottle.Add(BloodBottleLevel);
		_compareBottle.Add(BloodBottleId);
	}

	private int BottleIsCurAbyssTeamEquip(BloodBottleData x, BloodBottleData y)
	{
		int curBloodBottleId = Model<AbyssModel>.Interface.GetCurBloodBottleId();
		if (x.uid == curBloodBottleId)
		{
			return -1;
		}
		if (y.uid == curBloodBottleId)
		{
			return 1;
		}
		return 0;
	}

	private int CurBottleIsBeEquip(BloodBottleData x, BloodBottleData y)
	{
		List<int> list = ListPool<int>.Get();
		if (AbyssModifyData.Count > 1)
		{
			list.Add(AbyssModifyData[0].EquipPotionId);
			list.Add(AbyssModifyData[1].EquipPotionId);
		}
		else
		{
			list.Add(Model<AbyssModel>.Interface.AbyssModifyData[0].EquipPotionId);
		}
		if (list.Count == 0 || (list.Contains(x.uid) && list.Contains(y.uid)))
		{
			ListPool<int>.Release(list);
			return 0;
		}
		if (list.Contains(x.uid))
		{
			ListPool<int>.Release(list);
			return -1;
		}
		if (list.Contains(y.uid))
		{
			ListPool<int>.Release(list);
			return 1;
		}
		ListPool<int>.Release(list);
		return 0;
	}

	private int BloodBottleLevel(BloodBottleData x, BloodBottleData y)
	{
		return y.curLevel - x.curLevel;
	}

	private int BloodBottleQuality(BloodBottleData x, BloodBottleData y)
	{
		Item itemInfo = G.localPlayer.Inventory.GetItemInfo(x.id);
		Item itemInfo2 = G.localPlayer.Inventory.GetItemInfo(y.id);
		if (itemInfo == null || itemInfo2 == null)
		{
			return 0;
		}
		return itemInfo2.GetQuality() - itemInfo.GetQuality();
	}

	private int BloodBottleId(BloodBottleData x, BloodBottleData y)
	{
		return y.uid - x.uid;
	}

	public int SortBloodBottleInAbyss(BloodBottleData x, BloodBottleData y)
	{
		for (int i = 0; i < _compareBottle.Count; i++)
		{
			int num = _compareBottle[i](x, y);
			if (num != 0)
			{
				return num;
			}
		}
		return 0;
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
		JumpResult result = default;
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Abyss))
		{
			result.ShowType = JumpResult.JumpShowType.Forbidden;
			result.Message = Singleton<SystemUnlockManager>.instance.GetSystemLockTips(SystemType.Abyss);
			return result;
		}
		if (jumpData.Params[1] == 2)
		{
			if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.CycleAbyss))
			{
				result.ShowType = JumpResult.JumpShowType.Forbidden;
				result.Message = Singleton<SystemUnlockManager>.instance.GetSystemLockTips(SystemType.CycleAbyss);
				return result;
			}
			if (!GetCycleAbyssIsUnLock())
			{
				result.ShowType = JumpResult.JumpShowType.Forbidden;
				result.Message = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2885);
				return result;
			}
		}
		result.ShowType = JumpResult.JumpShowType.CanJump;
		return result;
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		MonoAbyssListData monoAbyssListData = new MonoAbyssListData();
		monoAbyssListData.AbyssType = (AbyssType)jumpData.Params[1];
		monoAbyssListData.AbyssId = ((jumpData.Params.Count > 2) ? jumpData.Params[2] : 0);
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ABYSSLIST, monoAbyssListData);
	}
}
