using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model.Jump;
using ACT.RichText;
using ACT.UI;
using ACT.UI.Interface;
using ACT.Utility;
using Fundamental;
using Google.Protobuf.Collections;
using Pb;
using Runtime.WaitSort;
using UnityEngine;

namespace ACT.Model;

public class BattlePassModel : Model<BattlePassModel>, IJumpable
{
	public const int DayRefreshHourOffset = 4;

	public const int ExplainTitleId = 2400;

	public const int ExplainDesId = 2427;

	private const long LocalTestEndTime = 1850659200000L;

	private const long LocalTestStartTime = 1753804800000L;

	private const int LocalTestMaxLevel = 30;

	private const int LocalTestStage = 10;

	private const int LocalTestStageRewardCount = 1;

	private const int TimePreconditionId = 18;

	private const int SecondsPerMinute = 60;

	public const int PremiumProductId = 8001001;

	public const int PremiumPriceDifferentProductId = 8001002;

	public const int PremiumPlusProductId = 8001003;

	private long _startTime = 1753804800000L;

	private long _endTime = 1850659200000L;

	private int _curLevel;

	private int _curBattlePassId;

	private int _curLevelExp;

	private int _curtWeekCumulativeExp;

	private BattlePassPayLevel _battlePassPayLevel;

	private List<int> _claimedTasks;

	private Dictionary<int, bool> _claimedFreeRewardsDic;

	private Dictionary<int, BattlePassTask> _allTasksDic = new Dictionary<int, BattlePassTask>();

	private List<BattlePassTask> _dailyTaskList = new List<BattlePassTask>();

	private List<BattlePassTask> _roundTaskList = new List<BattlePassTask>();

	private Dictionary<int, bool> _claimedPremiumRewardsDic;

	private Dictionary<int, BattlePassReward> _allFreeRewardsDic = new Dictionary<int, BattlePassReward>();

	private Dictionary<int, BattlePassReward> _allPremiumRewardsDic = new Dictionary<int, BattlePassReward>();

	private Action _playTimeShow;

	private Action _payLevelChangeAction;

	private Action<int> _levelExpChangeAction;

	private Action<int> _weekCumulativeExpChangeAction;

	private Action<int, int> _levelUpdateAction;

	private Action<bool, RepeatedField<UniversalItem>, bool> _getRewardsAction;

	private Action _taskListUpdateAction;

	private Action _timeUpdateAction;

	public int PremiumBundleName => CoreUtils.GetData(8001001, RuntimeConfigs.data.battlepayPasss).bundlename;

	public int PremiumPlusBundleName => CoreUtils.GetData(8001003, RuntimeConfigs.data.battlepayPasss).bundlename;

	public int PremiumBundleDetailName => CoreUtils.GetData(8001001, RuntimeConfigs.data.battlepayPasss).bundledetail;

	public int PremiumPlusBundleDetailName => CoreUtils.GetData(8001003, RuntimeConfigs.data.battlepayPasss).bundledetail;

	public int PremiumBundleOff => CoreUtils.GetData(8001001, RuntimeConfigs.data.battlepayPasss).bundleoff;

	public int PremiumPlusBundleOff => CoreUtils.GetData(8001003, RuntimeConfigs.data.battlepayPasss).bundleoff;

	public int PremiumBundleItem => CoreUtils.GetData(8001001, RuntimeConfigs.data.battlepayPasss).bundleitem[0].count;

	public int PremiumPlusBundleItem => CoreUtils.GetData(8001003, RuntimeConfigs.data.battlepayPasss).bundleitem[0].count;

	public long StartTime => _startTime;

	public long EndTime => _endTime;

	public int BattlePassLevelMax => CoreUtils.GetData(_curBattlePassId, RuntimeConfigs.data.battlePasss)?.battlePassLevelMax ?? 30;

	public int LevelUpExp => RuntimeConfigs.data.game.battlePassExp;

	public int WeekExpLimitation => RuntimeConfigs.data.game.battlePassExplimitation;

	public int ExpBuyCount => RuntimeConfigs.data.game.battlePassExpBuy;

	public int PerStageLevelCount => CoreUtils.GetData(_curBattlePassId, RuntimeConfigs.data.battlePasss)?.stage ?? 10;

	public int StageRewardCount => CoreUtils.GetData(_curBattlePassId, RuntimeConfigs.data.battlePasss)?.stageNum ?? 1;

	public List<ItemKv> PayItems => CoreUtils.GetData(_curBattlePassId, RuntimeConfigs.data.battlePasss).payitem;

	public List<ItemKv> PayUpItems => CoreUtils.GetData(_curBattlePassId, RuntimeConfigs.data.battlePasss).payupitem;

	public int[] GemItems => CoreUtils.GetData(_curBattlePassId, RuntimeConfigs.data.battlePasss)?.gemitem ?? Array.Empty<int>();

	public int CanBuyMaxLevel => BattlePassLevelMax - _curLevel;

	public bool IsMaxLevel => _curLevel == BattlePassLevelMax;

	public bool AvailAble
	{
		get
		{
			if (_curBattlePassId == 0)
			{
				return false;
			}
			long num = new DateTimeOffset(TimeManager.ServerTime.Now).ToUnixTimeSeconds();
			int num2 = 1044;
			if (num > StartTime && num < EndTime && Singleton<SystemUnlockManager>.instance.IsUnlock(num2))
			{
				return !Singleton<SystemBlockManager>.instance.IsBlocked(num2);
			}
			return false;
		}
	}

	public bool EscCanShow
	{
		get
		{
			if (_curBattlePassId == 0)
			{
				return false;
			}
			long num = new DateTimeOffset(TimeManager.ServerTime.Now).ToUnixTimeSeconds();
			if (num > StartTime)
			{
				return num < EndTime;
			}
			return false;
		}
	}

	public int DailyTaskCount => _dailyTaskList.Count;

	public int RoundTaskCount => _roundTaskList.Count;

	public int CurrentLevel => _curLevel;

	public int CurBattlePassId => _curBattlePassId;

	public int CurLevelExp => _curLevelExp;

	public int CurtWeekCumulativeExp => _curtWeekCumulativeExp;

	public BattlePassPayLevel BattlePassPayLevel => _battlePassPayLevel;

	public List<int> ClaimedTasks => _claimedTasks;

	public Dictionary<int, bool> ClaimedFreeRewardsDic => _claimedFreeRewardsDic;

	public Dictionary<int, BattlePassTask> AllTasksDic => _allTasksDic;

	public List<BattlePassTask> DailyTaskList => _dailyTaskList;

	public List<BattlePassTask> RoundTaskList => _roundTaskList;

	public Dictionary<int, bool> ClaimedPremiumRewardsDic => _claimedPremiumRewardsDic;

	public Dictionary<int, BattlePassReward> AllFreeRewardsDic => _allFreeRewardsDic;

	public Dictionary<int, BattlePassReward> AllPremiumRewardsDic => _allPremiumRewardsDic;

	public bool NewRedDotExist
	{
		get
		{
			bool value;
			return G.localPlayer.redPoints.BattlePass.TryGetValue(_curBattlePassId, out value) & value;
		}
	}

	public LuminModelType JumpSourceType => LuminModelType.BattlePass;

	public event Action PlayTimeShow
	{
		add
		{
			_playTimeShow = (Action)Delegate.Combine(_playTimeShow, value);
		}
		remove
		{
			_playTimeShow = (Action)Delegate.Remove(_playTimeShow, value);
		}
	}

	public event Action<ITabItem> RefreshControlLayerAction
	{
		add
		{
			_refreshControlLayerAction += value;
		}
		remove
		{
			_refreshControlLayerAction -= value;
		}
	}

	private event Action<ITabItem> _refreshControlLayerAction;

	public event Action PayLevelChangeAction
	{
		add
		{
			_payLevelChangeAction = (Action)Delegate.Combine(_payLevelChangeAction, value);
		}
		remove
		{
			_payLevelChangeAction = (Action)Delegate.Remove(_payLevelChangeAction, value);
		}
	}

	public event Action<int> LevelExpChangeAction
	{
		add
		{
			_levelExpChangeAction = (Action<int>)Delegate.Combine(_levelExpChangeAction, value);
		}
		remove
		{
			_levelExpChangeAction = (Action<int>)Delegate.Remove(_levelExpChangeAction, value);
		}
	}

	public event Action<int> WeekCumulativeExpChangeAction
	{
		add
		{
			_weekCumulativeExpChangeAction = (Action<int>)Delegate.Combine(_weekCumulativeExpChangeAction, value);
		}
		remove
		{
			_weekCumulativeExpChangeAction = (Action<int>)Delegate.Remove(_weekCumulativeExpChangeAction, value);
		}
	}

	public event Action<int, int> LevelUpdateAction
	{
		add
		{
			_levelUpdateAction = (Action<int, int>)Delegate.Combine(_levelUpdateAction, value);
		}
		remove
		{
			_levelUpdateAction = (Action<int, int>)Delegate.Remove(_levelUpdateAction, value);
		}
	}

	public event Action<bool, RepeatedField<UniversalItem>, bool> GetRewardsAction
	{
		add
		{
			_getRewardsAction = (Action<bool, RepeatedField<UniversalItem>, bool>)Delegate.Combine(_getRewardsAction, value);
		}
		remove
		{
			_getRewardsAction = (Action<bool, RepeatedField<UniversalItem>, bool>)Delegate.Remove(_getRewardsAction, value);
		}
	}

	public event Action TaskListUpdateAction
	{
		add
		{
			_taskListUpdateAction = (Action)Delegate.Combine(_taskListUpdateAction, value);
		}
		remove
		{
			_taskListUpdateAction = (Action)Delegate.Remove(_taskListUpdateAction, value);
		}
	}

	public event Action TimeUpdateAction
	{
		add
		{
			_timeUpdateAction = (Action)Delegate.Combine(_timeUpdateAction, value);
		}
		remove
		{
			_timeUpdateAction = (Action)Delegate.Remove(_timeUpdateAction, value);
		}
	}

	public System.DateTime WeeklyRemainedTime()
	{
		System.DateTime now = TimeManager.ServerTime.Now;
		int num = (int)(1 - now.DayOfWeek + 7) % 7;
		System.DateTime dateTime = now.Date.AddDays(num).AddHours(4.0);
		if (now >= dateTime)
		{
			dateTime = dateTime.AddDays(7.0);
		}
		TimeSpan timeSpan = dateTime - now;
		TimeSpan timeSpan2 = RoundRemainingTime() - System.DateTime.MinValue;
		System.DateTime minValue = System.DateTime.MinValue;
		return minValue.Add((timeSpan <= timeSpan2) ? timeSpan : timeSpan2);
	}

	public System.DateTime RoundRemainingTime()
	{
		System.DateTime minValue = System.DateTime.MinValue;
		return minValue.AddSeconds(Math.Max(0L, EndTime - TimeManager.ServerTime.NowTimestampSecond));
	}

	private void InitAllTasks()
	{
		_allTasksDic.Clear();
		_dailyTaskList.Clear();
		_roundTaskList.Clear();
		BuildTaskList();
		SortTaskList(_dailyTaskList);
		SortTaskList(_roundTaskList);
	}

	private void BuildTaskList()
	{
		int[] quest = CoreUtils.GetData(_curBattlePassId, RuntimeConfigs.data.battlePasss).quest;
		for (int i = 0; i < quest.Length; i++)
		{
			Quest data = CoreUtils.GetData(quest[i], RuntimeConfigs.data.quests);
			BattlePassTaskType taskType = ((data.time != 0) ? BattlePassTaskType.Round : BattlePassTaskType.Daily);
			List<BattlePassTask> list = ((data.time == 0) ? _dailyTaskList : _roundTaskList);
			MissionGroup data2 = CoreUtils.GetData(data.missionid, RuntimeConfigs.data.missionGroups);
			switch (data2.conditional)
			{
			case 0:
			case 1:
			{
				for (int k = 0; k < data2.missionId.Length; k++)
				{
					int num2 = data2.missionId[k];
					BattlePassTask battlePassTask3 = CreateBattlePassTask(num2, taskType, data);
					_allTasksDic[num2] = battlePassTask3;
					list.Add(battlePassTask3);
				}
				break;
			}
			case 2:
			{
				if (data2.missionId.Length == 0)
				{
					break;
				}
				bool flag = false;
				bool flag2 = false;
				for (int l = 0; l < data2.missionId.Length; l++)
				{
					int num3 = data2.missionId[l];
					BattlePassTask battlePassTask4 = CreateBattlePassTask(num3, taskType, data);
					_allTasksDic[num3] = battlePassTask4;
					if (battlePassTask4.Status == BattlePassTaskStatus.Claimed)
					{
						flag = true;
					}
					else if (battlePassTask4.Status == BattlePassTaskStatus.DoneUnClaimed)
					{
						flag2 = true;
					}
				}
				int taskId = data2.missionId[0];
				bool flag3 = flag | flag2;
				BattlePassTask item = new BattlePassTask
				{
					TaskId = taskId,
					TaskGroupId = data.missionid,
					TaskType = taskType,
					RefreshType = ((data.refresh == 0) ? BattlePassTaskRefreshType.RoundRefresh : BattlePassTaskRefreshType.DailyRefresh),
					Description = LocalizationUtility.GetLocalizeString("shortcommon", data2.groupDes),
					Exp = data.exp,
					TargetProgress = 1,
					CurrentProgress = (flag3 ? 1 : 0),
					Status = (flag ? BattlePassTaskStatus.Claimed : (flag2 ? BattlePassTaskStatus.DoneUnClaimed : BattlePassTaskStatus.UnDone)),
					SortWeight = data.priority,
					JumpId = data.jump
				};
				list.Add(item);
				break;
			}
			case 3:
			{
				BattlePassTask battlePassTask = null;
				for (int j = 0; j < data2.missionId.Length; j++)
				{
					int num = data2.missionId[j];
					BattlePassTask battlePassTask2 = CreateBattlePassTask(num, taskType, data);
					_allTasksDic[num] = battlePassTask2;
					if (battlePassTask == null && battlePassTask2.Status != BattlePassTaskStatus.Claimed)
					{
						battlePassTask = battlePassTask2;
					}
				}
				if (battlePassTask == null && data2.missionId.Length != 0)
				{
					int[] missionId = data2.missionId;
					int key = missionId[missionId.Length - 1];
					battlePassTask = _allTasksDic[key];
				}
				if (battlePassTask != null)
				{
					list.Add(battlePassTask);
				}
				break;
			}
			}
		}
	}

	private BattlePassTask CreateBattlePassTask(int taskId, BattlePassTaskType taskType, Quest questData)
	{
		ACT.Config.Mission data = CoreUtils.GetData(taskId, RuntimeConfigs.data.missions);
		int targetProgress = ((data.preconditionId == 18) ? (data.number / 60) : data.number);
		BattlePassTask battlePassTask = new BattlePassTask
		{
			TaskId = taskId,
			TaskGroupId = questData.missionid,
			TaskType = taskType,
			RefreshType = ((questData.refresh == 0) ? BattlePassTaskRefreshType.RoundRefresh : BattlePassTaskRefreshType.DailyRefresh),
			Description = CustomTagParser.ReplacePreconditionText(data, data.number, data.param),
			Exp = questData.exp,
			TargetProgress = targetProgress,
			CurrentProgress = 0,
			Status = BattlePassTaskStatus.UnDone,
			SortWeight = questData.priority,
			JumpId = questData.jump
		};
		UpdateTaskStatus(battlePassTask);
		return battlePassTask;
	}

	public void RefreshAllTaskStatus()
	{
		foreach (BattlePassTask value in _allTasksDic.Values)
		{
			UpdateTaskStatus(value);
		}
		SortTaskList(_dailyTaskList);
		SortTaskList(_roundTaskList);
	}

	private void UpdateTaskStatus(BattlePassTask task)
	{
		ACT.Config.Mission data = CoreUtils.GetData(task.TaskId, RuntimeConfigs.data.missions);
		bool flag = data.preconditionId == 18;
		if (_claimedTasks != null && _claimedTasks.Contains(task.TaskId))
		{
			task.Status = BattlePassTaskStatus.Claimed;
			task.CurrentProgress = (flag ? (data.number / 60) : data.number);
			return;
		}
		if (Singleton<PreconditionInfoManager>.instance.taskDic.TryGetValue(task.TaskId, out var value))
		{
			task.CurrentProgress = (flag ? (value.progress / 60) : value.progress);
			task.Status = ((value.status == 1) ? BattlePassTaskStatus.DoneUnClaimed : BattlePassTaskStatus.UnDone);
			return;
		}
		IBaseUIController topActiveUI = Singleton<NewUIManager>.instance.GetTopActiveUI();
		if (topActiveUI != null && topActiveUI.UIType == UI_TYPE.UI_BATTLEPASS && topActiveUI.State == UIState.Opened && LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"TaskNtf中没有通行证任务->{task.TaskId}？？？");
		}
	}

	private void SortTaskList(List<BattlePassTask> taskList)
	{
		taskList.Sort((BattlePassTask a, BattlePassTask b) =>
		{
			int num = GetStatusSortOrder(a.Status).CompareTo(GetStatusSortOrder(b.Status));
			return (num != 0) ? num : b.SortWeight.CompareTo(a.SortWeight);
		});
	}

	private int GetStatusSortOrder(BattlePassTaskStatus status)
	{
		return status switch
		{
			BattlePassTaskStatus.DoneUnClaimed => 0, 
			BattlePassTaskStatus.UnDone => 1, 
			BattlePassTaskStatus.Claimed => 2, 
			_ => 3, 
		};
	}

	public BattlePassTask GetTask(int taskId)
	{
		return _allTasksDic.GetValueOrDefault(taskId);
	}

	public BattlePassReward GetFreeReward(int level)
	{
		return _allFreeRewardsDic.GetValueOrDefault(level);
	}

	public BattlePassReward GetPremiumReward(int level)
	{
		return _allPremiumRewardsDic.GetValueOrDefault(level);
	}

	public bool HasUnclaimedRewards()
	{
		for (int i = 1; i <= CurrentLevel; i++)
		{
			BattlePassReward freeReward = GetFreeReward(i);
			if (freeReward != null && freeReward.Status == BattlePassRewardStatus.CanClaim)
			{
				return true;
			}
			BattlePassReward premiumReward = GetPremiumReward(i);
			if (premiumReward != null && premiumReward.Status == BattlePassRewardStatus.CanClaim)
			{
				return true;
			}
		}
		return false;
	}

	public bool HasClaimableDailyTask()
	{
		for (int i = 0; i < _dailyTaskList.Count; i++)
		{
			if (_dailyTaskList[i].CanClaim)
			{
				return true;
			}
		}
		return false;
	}

	public bool HasClaimableRoundTask()
	{
		for (int i = 0; i < _roundTaskList.Count; i++)
		{
			if (_roundTaskList[i].CanClaim)
			{
				return true;
			}
		}
		return false;
	}

	public void BuyLevelReq(int buyCount, Action<bool> callback)
	{
		G.service.BattlePassBuyLevelReq(buyCount, (bool success) =>
		{
			callback?.Invoke(success);
		});
	}

	public void ClaimRewards(int level, bool isPremium)
	{
		G.service.BattlePassClaimRewardReq(level, isPremium, (bool success, RepeatedField<UniversalItem> rewardItems) =>
		{
			_getRewardsAction?.Invoke(success, rewardItems, isPremium);
		});
	}

	public void ClaimTasks(int taskGroupId, int taskId, Action<bool> callback)
	{
		G.service.BattlePassClaimTaskReq(taskGroupId, taskId, (bool success) =>
		{
			callback?.Invoke(success);
		});
	}

	public int GetStageLastLevel(int level)
	{
		int num = (level / PerStageLevelCount + 1) * PerStageLevelCount;
		int num2 = Math.Min(StageRewardCount * PerStageLevelCount, BattlePassLevelMax);
		if (num > num2)
		{
			return num2;
		}
		return num;
	}

	public void RefreshControlLayer(ITabItem tabItem)
	{
		_refreshControlLayerAction?.Invoke(tabItem);
	}

	protected override void Init()
	{
		_claimedTasks = new List<int>();
		_claimedFreeRewardsDic = new Dictionary<int, bool>();
		_claimedPremiumRewardsDic = new Dictionary<int, bool>();
		_allFreeRewardsDic = new Dictionary<int, BattlePassReward>();
		_allPremiumRewardsDic = new Dictionary<int, BattlePassReward>();
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction += InstanceOnTaskProgressChangeAction;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, OnSystemOpen);
	}

	private void OnSystemOpen(BaseEventContent obj)
	{
		if (obj is SystemOpenEvt { unLock: not false, systemId: 1044 })
		{
			RegisterRedDot();
		}
	}

	private void RegisterRedDot()
	{
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.BattlePassRewardTab, HasUnclaimedRewards());
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.BattlePassDailyTask, HasClaimableDailyTask());
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.BattlePassRoundTask, HasClaimableRoundTask());
		if (NewRedDotExist)
		{
			string nodeFullPath = RedDotPathDefine.EscBattlePass + "|Refresh";
			if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath))
			{
				Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath, active: true);
			}
		}
	}

	private void InstanceOnTaskProgressChangeAction(int taskId, ACT.Battle.TaskInfo taskInfo, bool isNew)
	{
		RefreshDailyRoundTaskRedDot();
	}

	private void RefreshDailyRoundTaskRedDot()
	{
		RefreshAllTaskStatus();
		if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(1044))
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.BattlePassDailyTask, HasClaimableDailyTask());
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.BattlePassRoundTask, HasClaimableRoundTask());
		}
		else
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.BattlePassDailyTask, active: false);
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.BattlePassRoundTask, active: false);
		}
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, OnSystemOpen);
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction -= InstanceOnTaskProgressChangeAction;
	}

	public void PlayTimeShowAnimation()
	{
		_playTimeShow?.Invoke();
	}

	public void InitDataByNtf(BattlePassNtf ntf)
	{
		BattlePassDbModel battlePassInfo = ntf.BattlePassInfo;
		_curBattlePassId = battlePassInfo?.Id ?? 0;
		if (_curBattlePassId == 0)
		{
			ClearInactiveBattlePassData();
			return;
		}
		int curLevel = _curLevel;
		int curLevelExp = _curLevelExp;
		int curtWeekCumulativeExp = _curtWeekCumulativeExp;
		BattlePassPayLevel battlePassPayLevel = _battlePassPayLevel;
		long startTime = _startTime;
		long endTime = _endTime;
		_curLevel = battlePassInfo.Level;
		_curLevelExp = battlePassInfo.Exp;
		_curtWeekCumulativeExp = battlePassInfo.WeeklyExp;
		_battlePassPayLevel = battlePassInfo.PayLevel;
		_startTime = ntf.BattlePassBeginTime;
		_endTime = ntf.BattlePassEndTime;
		_claimedTasks.Clear();
		foreach (KeyValuePair<int, ClaimedTask> claimedTask in battlePassInfo.ClaimedTasks)
		{
			foreach (int subTaskId in claimedTask.Value.SubTaskIds)
			{
				_claimedTasks.Add(subTaskId);
			}
		}
		_claimedFreeRewardsDic.Clear();
		foreach (KeyValuePair<int, bool> claimedFreeReward in battlePassInfo.ClaimedFreeRewards)
		{
			_claimedFreeRewardsDic[claimedFreeReward.Key] = true;
		}
		_claimedPremiumRewardsDic.Clear();
		foreach (KeyValuePair<int, bool> claimedPremiumReward in battlePassInfo.ClaimedPremiumRewards)
		{
			_claimedPremiumRewardsDic[claimedPremiumReward.Key] = true;
		}
		InitAllTasks();
		InitAllRewards();
		if (curLevel != _curLevel)
		{
			_levelUpdateAction?.Invoke(curLevel, _curLevel);
		}
		if (curLevelExp != _curLevelExp)
		{
			_levelExpChangeAction?.Invoke(_curLevelExp);
		}
		if (curtWeekCumulativeExp != _curtWeekCumulativeExp)
		{
			_weekCumulativeExpChangeAction?.Invoke(_curtWeekCumulativeExp);
		}
		if (battlePassPayLevel != _battlePassPayLevel)
		{
			_payLevelChangeAction?.Invoke();
		}
		if (startTime != _startTime || endTime != _endTime)
		{
			_timeUpdateAction?.Invoke();
		}
		_taskListUpdateAction?.Invoke();
		if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(1044))
		{
			RegisterRedDot();
		}
	}

	private void ClearInactiveBattlePassData()
	{
		_curLevel = 0;
		_curLevelExp = 0;
		_curtWeekCumulativeExp = 0;
		_battlePassPayLevel = BattlePassPayLevel.BattlePassPayNull;
		_startTime = 0L;
		_endTime = 0L;
		_claimedTasks.Clear();
		_claimedFreeRewardsDic.Clear();
		_claimedPremiumRewardsDic.Clear();
		_allTasksDic.Clear();
		_dailyTaskList.Clear();
		_roundTaskList.Clear();
		_allFreeRewardsDic.Clear();
		_allPremiumRewardsDic.Clear();
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.BattlePassRewardTab, active: false);
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.BattlePassDailyTask, active: false);
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.BattlePassRoundTask, active: false);
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.EscBattlePass + "|Refresh", active: false);
		_timeUpdateAction?.Invoke();
		_taskListUpdateAction?.Invoke();
	}

	public void RefreshNewRedDot()
	{
		if (!NewRedDotExist)
		{
			return;
		}
		RedPoints redPoints = new RedPoints();
		int curBattlePassId = _curBattlePassId;
		redPoints.BattlePass[curBattlePassId] = false;
		RedPoints redPoints2 = redPoints;
		G.service.RefreshRedDot(redPoints2, (bool b) =>
		{
			if (b)
			{
				string nodeFullPath = RedDotPathDefine.EscBattlePass + "|Refresh";
				Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, active: false);
				G.localPlayer.redPoints.BattlePass[_curBattlePassId] = false;
			}
		});
	}

	private void InitAllRewards()
	{
		_allFreeRewardsDic.Clear();
		_allPremiumRewardsDic.Clear();
		if (CoreUtils.GetData(_curBattlePassId, RuntimeConfigs.data.battlePasss) == null)
		{
			Debug.LogWarning($"找不到通行证配置数据，ID: {_curBattlePassId}");
			return;
		}
		for (int i = 1; i <= BattlePassLevelMax; i++)
		{
			BattlePassReward value = CreateReward(i, BattlePassRewardType.Free);
			_allFreeRewardsDic[i] = value;
			BattlePassReward value2 = CreateReward(i, BattlePassRewardType.Premium);
			_allPremiumRewardsDic[i] = value2;
		}
	}

	private BattlePassReward CreateReward(int level, BattlePassRewardType rewardType)
	{
		BattlePassReward battlePassReward = new BattlePassReward
		{
			Level = level,
			RewardType = rewardType,
			Status = GetRewardStatus(level, rewardType),
			RewardItems = new List<(int, int)>()
		};
		LevelReward data = CoreUtils.GetData(_curBattlePassId * 100 + level, RuntimeConfigs.data.levelRewards);
		switch (rewardType)
		{
		case BattlePassRewardType.Free:
			foreach (ItemKv item in data.item)
			{
				int id2 = item.id;
				int count2 = item.count;
				battlePassReward.RewardItems.Add((id2, count2));
			}
			break;
		case BattlePassRewardType.Premium:
			foreach (ItemKv item2 in data.itempro)
			{
				int id = item2.id;
				int count = item2.count;
				battlePassReward.RewardItems.Add((id, count));
			}
			break;
		}
		return battlePassReward;
	}

	private BattlePassRewardStatus GetRewardStatus(int level, BattlePassRewardType rewardType)
	{
		if (level > _curLevel)
		{
			return BattlePassRewardStatus.Locked;
		}
		if (rewardType == BattlePassRewardType.Free)
		{
			if (_claimedFreeRewardsDic.ContainsKey(level))
			{
				return BattlePassRewardStatus.Claimed;
			}
			return BattlePassRewardStatus.CanClaim;
		}
		if (_battlePassPayLevel == BattlePassPayLevel.BattlePassPayNull)
		{
			return BattlePassRewardStatus.Locked;
		}
		if (_claimedPremiumRewardsDic.ContainsKey(level))
		{
			return BattlePassRewardStatus.Claimed;
		}
		return BattlePassRewardStatus.CanClaim;
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		int num = 1044;
		bool flag = Singleton<SystemUnlockManager>.instance.IsSystemUnlock(num);
		ACT.Config.Mission data = CoreUtils.GetData(CoreUtils.GetData(CoreUtils.GetData(num, RuntimeConfigs.data.systemOpens).missionId, RuntimeConfigs.data.missionGroups).missionId[0], RuntimeConfigs.data.missions);
		return new JumpResult
		{
			ShowType = ((!flag) ? JumpResult.JumpShowType.Forbidden : (AvailAble ? JumpResult.JumpShowType.CanJump : JumpResult.JumpShowType.Hide)),
			Message = CustomTagParser.ReplacePreconditionText(data, data.number, data.param)
		};
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEPASS);
	}
}
