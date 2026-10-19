using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.Local;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using UnityEngine;

namespace ACT.Model;

public class FacePushModel : Model<FacePushModel>
{
	private const int FacePushCycleTypeDaily = 1;

	private const int FacePushCycleTypeWeekly = 2;

	private const int FacePushDailyRefreshHour = 4;

	private const int PlayerLevelPreconditionId = 2;

	private const string FacePushShowDateKeyPrefix = "FacePush.ShowDate.";

	private const string FacePushShowCountKeyPrefix = "FacePush.ShowCount.";

	private const string FacePushShowWeekKeyPrefix = "FacePush.ShowWeek.";

	private const string FacePushShowWeekCountKeyPrefix = "FacePush.ShowWeekCount.";

	private const string FacePushShowWeekDayKeyPrefix = "FacePush.ShowWeekDay.";

	private const string FacePushLoginShowDateKeyPrefix = "FacePush.LoginShowDate.";

	private const string PendingShopMonthCardFacePushKeyPrefix = "FacePush.PendingShopMonthCard.";

	private readonly List<PopUp> _sortedFacePushes = new List<PopUp>();

	private readonly Dictionary<string, UI_TYPE> _uiTypeByPrefabPath = new Dictionary<string, UI_TYPE>(StringComparer.Ordinal);

	private bool _suppressNextMonthlyPassPurchaseReward;

	private bool _pendingMonthlyPassItemFacePush;

	private int _monthlyPassItemFacePushRetryVersion;

	private int _pendingShopMonthlyPassId = -1;

	private const int MonthlyPassItemFacePushRetryCount = 15;

	private const int MonthlyPassItemFacePushRetryMilliseconds = 200;

	private string _configCheckReason;

	private static string s_loginSessionId;

	private static bool s_hasLoginSystemOpenSync;

	private static bool s_hasLoginSystemStatusSync;

	private static bool s_hasActivitySystemUnlockSnapshotForCurrentLogin;

	private static bool s_isFacePushSuppressedForCurrentLogin;

	private static bool s_isSupplementaryFacePushSuppressedForCurrentLogin;

	private static int s_supplementaryFacePushSuppressedRefreshDate;

	private static readonly HashSet<int> s_loggedActivityTimeIds = new HashSet<int>();

	public FacePushScheduler Scheduler { get; private set; }

	public IReadOnlyList<PopUp> SortedFacePushes => _sortedFacePushes;

	internal string ConfigCheckReason => _configCheckReason;

	internal string SceneCheckBlockReason { get; private set; }

	public bool IsSupplementaryFacePushSuppressedForCurrentLogin
	{
		get
		{
			if (s_isSupplementaryFacePushSuppressedForCurrentLogin)
			{
				return s_supplementaryFacePushSuppressedRefreshDate == GetCurrentFacePushRefreshDate();
			}
			return false;
		}
	}

	public void PrepareMonthlyPassItemFacePush(bool openFacePush)
	{
		_suppressNextMonthlyPassPurchaseReward = true;
		_pendingMonthlyPassItemFacePush = openFacePush;
		_monthlyPassItemFacePushRetryVersion++;
	}

	public bool ConsumeMonthlyPassItemFacePush()
	{
		if (!_suppressNextMonthlyPassPurchaseReward)
		{
			return false;
		}
		_suppressNextMonthlyPassPurchaseReward = false;
		return true;
	}

	public void NotifyMonthlyPassItemUseSucceeded()
	{
		TryOpenOrRetryMonthlyPassItemFacePush();
	}

	public void NotifyMonthlyPassItemDataReady()
	{
		TryOpenOrRetryMonthlyPassItemFacePush();
	}

	private void TryOpenOrRetryMonthlyPassItemFacePush()
	{
		if (_pendingMonthlyPassItemFacePush)
		{
			TryOpenPendingMonthlyPassItemFacePush();
			if (_pendingMonthlyPassItemFacePush)
			{
				RetryPendingMonthlyPassItemFacePush(++_monthlyPassItemFacePushRetryVersion).Forget();
			}
		}
	}

	public void ClearMonthlyPassItemFacePush()
	{
		_suppressNextMonthlyPassPurchaseReward = false;
		_pendingMonthlyPassItemFacePush = false;
		_monthlyPassItemFacePushRetryVersion++;
	}

	private void TryOpenPendingMonthlyPassItemFacePush()
	{
		if (_pendingMonthlyPassItemFacePush && Scheduler != null && Scheduler.TryOpenMonthCardRewardDirect())
		{
			_pendingMonthlyPassItemFacePush = false;
			_monthlyPassItemFacePushRetryVersion++;
		}
	}

	private async UniTaskVoid RetryPendingMonthlyPassItemFacePush(int retryVersion)
	{
		for (int i = 0; i < 15; i++)
		{
			await UniTask.Delay(200);
			if (retryVersion != _monthlyPassItemFacePushRetryVersion || !_pendingMonthlyPassItemFacePush)
			{
				return;
			}
			if (Scheduler != null && Scheduler.TryOpenMonthCardRewardDirect())
			{
				_pendingMonthlyPassItemFacePush = false;
				_monthlyPassItemFacePushRetryVersion++;
				FacePushFlowLog.SuccessAlways("背包月卡拍脸", "重试后已打开");
				return;
			}
		}
		if (retryVersion == _monthlyPassItemFacePushRetryVersion && _pendingMonthlyPassItemFacePush)
		{
			FacePushFlowLog.FailAlways("背包月卡拍脸", "月卡数据重试结束后仍未打开");
		}
	}

	public static void MarkShopMonthlyPassFacePushPending(int passId)
	{
		if (passId > 0)
		{
			PlayerPrefs.SetInt(BuildPendingShopMonthCardKey(), passId);
			PlayerPrefs.Save();
			if (Model<FacePushModel>.HasInstance())
			{
				Model<FacePushModel>.Interface._pendingShopMonthlyPassId = passId;
				Model<FacePushModel>.Interface.RequestCheck();
			}
		}
	}

	public bool HasPendingShopMonthlyPassFacePush()
	{
		int passId;
		return TryGetPendingShopMonthlyPassId(out passId);
	}

	public bool TryGetPendingShopMonthlyPassId(out int passId)
	{
		EnsurePendingShopMonthlyPassLoaded();
		passId = _pendingShopMonthlyPassId;
		return passId > 0;
	}

	public void ClearPendingShopMonthlyPassFacePush(int passId)
	{
		if (passId > 0 && TryGetPendingShopMonthlyPassId(out var passId2) && passId2 == passId)
		{
			_pendingShopMonthlyPassId = 0;
			PlayerPrefs.DeleteKey(BuildPendingShopMonthCardKey());
			PlayerPrefs.Save();
		}
	}

	private void EnsurePendingShopMonthlyPassLoaded()
	{
		if (_pendingShopMonthlyPassId < 0)
		{
			_pendingShopMonthlyPassId = PlayerPrefs.GetInt(BuildPendingShopMonthCardKey(), 0);
		}
	}

	private static string BuildPendingShopMonthCardKey()
	{
		return "FacePush.PendingShopMonthCard." + GetLocalRecordOwnerKey();
	}

	protected override void Init()
	{
		RefreshLoginSessionGate();
		Refresh();
		BuildUITypePathCache();
		Scheduler?.UnInit();
		Scheduler = new FacePushScheduler(this);
		Scheduler.OpenRequested += OnOpenRequested;
		Scheduler.Init();
	}

	protected override void UnInit()
	{
		if (Scheduler != null)
		{
			Scheduler.OpenRequested -= OnOpenRequested;
		}
		Scheduler?.UnInit();
		Scheduler = null;
		_sortedFacePushes.Clear();
		_uiTypeByPrefabPath.Clear();
		_suppressNextMonthlyPassPurchaseReward = false;
		_pendingMonthlyPassItemFacePush = false;
		_monthlyPassItemFacePushRetryVersion++;
		_pendingShopMonthlyPassId = -1;
	}

	public void Refresh()
	{
		_sortedFacePushes.Clear();
		Dictionary<int, PopUp> dictionary = RuntimeConfigs.data?.popUps;
		if (dictionary == null)
		{
			return;
		}
		foreach (KeyValuePair<int, PopUp> item in dictionary)
		{
			PopUp value = item.Value;
			if (value != null && value.enabled != 0)
			{
				_sortedFacePushes.Add(value);
			}
		}
		_sortedFacePushes.Sort(ComparePopUp);
	}

	public IReadOnlyList<PopUp> GetSortedFacePushes()
	{
		return _sortedFacePushes;
	}

	public void OnLoadingDone()
	{
		if (HasPendingShopMonthlyPassFacePush())
		{
			Scheduler?.NotifyLoadingDone();
			RequestCheck();
		}
		else if (CanRequestCheckInCurrentScene())
		{
			Scheduler?.NotifyLoadingDone();
			RequestCheck();
		}
	}

	public bool CanRequestCheckInCurrentScene()
	{
		RefreshLoginSessionGate();
		if (s_isFacePushSuppressedForCurrentLogin && !HasPendingShopMonthlyPassFacePush())
		{
			SceneCheckBlockReason = "本次登录活动系统未解锁，且没有待补弹的商店月卡";
			return false;
		}
		if (MonoECS.instance == null || MonoECS.instance.sceneStatus != SceneStatus.Main)
		{
			string text = ((MonoECS.instance == null) ? "无场景" : MonoECS.instance.sceneStatus.ToString());
			SceneCheckBlockReason = "当前不在主世界：" + text;
			return false;
		}
		if (Model<BattleMainModel>.Interface.hudType != HudType.MainWorldType)
		{
			SceneCheckBlockReason = $"主界面不是大世界：{Model<BattleMainModel>.Interface.hudType}";
			return false;
		}
		SceneCheckBlockReason = null;
		return true;
	}

	public void RequestCheck()
	{
		Scheduler?.RequestCheck();
	}

	public bool TryGetFacePush(int id, out PopUp config)
	{
		for (int i = 0; i < _sortedFacePushes.Count; i++)
		{
			PopUp popUp = _sortedFacePushes[i];
			if (popUp.id == id)
			{
				config = popUp;
				return true;
			}
		}
		config = null;
		return false;
	}

	public bool TryGetFacePushUIType(PopUp config, out UI_TYPE uiType)
	{
		return TryGetUITypeByPrefabPath(config, out uiType);
	}

	public bool CanShowConfigFacePush(PopUp config)
	{
		return GetConfigFacePushCheckResult(config) == FacePushConfigCheckResult.CanShow;
	}

	public FacePushConfigCheckResult GetConfigFacePushCheckResult(PopUp config)
	{
		RefreshLoginSessionGate();
		if (config == null)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, "配置为空");
		}
		if (s_isFacePushSuppressedForCurrentLogin)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, "本次登录活动系统未解锁，配置表拍脸被抑制");
		}
		if (IsOffMissionGroupComplete(config))
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, $"关闭任务组 {config.offMissongroup} 已完成");
		}
		if (!CanShowByFrequency(config))
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, _configCheckReason);
		}
		if (!TryGetUITypeByPrefabPath(config, out var uiType))
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, "预制体路径无法对应界面：" + config.prefebPath);
		}
		if (!CanShowBySystemUnlock(uiType))
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, _configCheckReason);
		}
		FacePushConfigCheckResult endTypeCheckResult = GetEndTypeCheckResult(config);
		if (endTypeCheckResult != FacePushConfigCheckResult.CanShow)
		{
			return endTypeCheckResult;
		}
		switch (uiType)
		{
		case UI_TYPE.UI_SLAPTENDAYSIGNIN:
		case UI_TYPE.UI_NEWBIELOGIN:
			return GetActivitySignInFacePushCheckResult(config);
		case UI_TYPE.UI_DEPARTUREPACKAGE:
		{
			FacePushConfigCheckResult bundleFacePushCheckResult = GetBundleFacePushCheckResult(config);
			if (bundleFacePushCheckResult != FacePushConfigCheckResult.CanShow)
			{
				return bundleFacePushCheckResult;
			}
			if (!CanShowDeparturePackageFacePush(config))
			{
				return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, _configCheckReason);
			}
			return FinishConfigCheck(FacePushConfigCheckResult.CanShow, _configCheckReason);
		}
		case UI_TYPE.UI_TENTICKETGIFT:
			return GetBundleFacePushCheckResult(config);
		case UI_TYPE.UI_CHARACTERSKINPACKAGE:
			return GetCharacterSkinPackageFacePushCheckResult(config);
		default:
			return FinishConfigCheck(FacePushConfigCheckResult.CanShow, $"界面 {uiType} 的通用条件已满足");
		}
	}

	private FacePushConfigCheckResult ToCheckResult(bool canShow)
	{
		if (!canShow)
		{
			return FacePushConfigCheckResult.CannotShow;
		}
		return FacePushConfigCheckResult.CanShow;
	}

	private FacePushConfigCheckResult FinishConfigCheck(FacePushConfigCheckResult result, string reason)
	{
		_configCheckReason = reason;
		return result;
	}

	internal void SetConfigCheckReason(string reason)
	{
		_configCheckReason = reason;
	}

	private FacePushConfigCheckResult GetBundleFacePushCheckResult(PopUp config)
	{
		if (config == null || config.targetId <= 0 || RuntimeConfigs.data?.bundles == null || !RuntimeConfigs.data.bundles.ContainsKey(config.targetId))
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, $"礼包配置不存在：{config?.targetId}");
		}
		if (!Model<ShopModel>.HasInstance() || !Model<ShopModel>.Interface.HasBundleDataSync)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.PendingData, $"礼包 {config.targetId} 的商品数据尚未同步");
		}
		if (Model<ShopModel>.Interface.BundleLeftCount(config.targetId) <= 0)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, $"礼包 {config.targetId} 已售罄");
		}
		return FinishConfigCheck(FacePushConfigCheckResult.CanShow, $"礼包 {config.targetId} 仍可购买");
	}

	private bool CanShowBySystemUnlock(UI_TYPE uiType)
	{
		if (!IsActivitySystemHudReady())
		{
			_configCheckReason = "活动系统未解锁";
			return false;
		}
		switch (uiType)
		{
		case UI_TYPE.UI_DEPARTUREPACKAGE:
		case UI_TYPE.UI_CHARACTERSKINPACKAGE:
			if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Shop))
			{
				return true;
			}
			_configCheckReason = "商城系统未解锁";
			return false;
		default:
			return true;
		}
	}

	private bool IsActivitySystemHudReady()
	{
		if (Singleton<SystemUnlockManager>.HasInstance())
		{
			return Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Activity);
		}
		return false;
	}

	public void RecordConfigFacePushShown(PopUp config)
	{
		if (config != null && config.maxShowTimes > 0)
		{
			switch (config.cycleType)
			{
			case 1:
				RecordDailyConfigFacePushShown(config);
				break;
			case 2:
				RecordWeeklyConfigFacePushShown(config);
				break;
			}
		}
	}

	private int ComparePopUp(PopUp left, PopUp right)
	{
		if (left == right)
		{
			return 0;
		}
		if (left == null)
		{
			return 1;
		}
		if (right == null)
		{
			return -1;
		}
		int priority = left.priority;
		int num = priority.CompareTo(right.priority);
		if (num == 0)
		{
			priority = left.id;
			return priority.CompareTo(right.id);
		}
		return num;
	}

	private bool IsOffMissionGroupComplete(PopUp config)
	{
		if (config == null || config.offMissongroup <= 0)
		{
			return false;
		}
		if (Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(config.offMissongroup))
		{
			return true;
		}
		return IsConfigMissionGroupComplete(config.offMissongroup);
	}

	private bool IsConfigMissionGroupComplete(int missionGroupId)
	{
		if (RuntimeConfigs.data?.missionGroups == null || RuntimeConfigs.data.missions == null || !RuntimeConfigs.data.missionGroups.TryGetValue(missionGroupId, out var value) || value.missionId == null || value.missionId.Length == 0)
		{
			return false;
		}
		bool flag = value.conditional == 2;
		for (int i = 0; i < value.missionId.Length; i++)
		{
			if (!RuntimeConfigs.data.missions.TryGetValue(value.missionId[i], out var value2))
			{
				if (!flag)
				{
					return false;
				}
				continue;
			}
			bool flag2 = value2.preconditionId == 2 && Singleton<PreconditionInfoManager>.instance.IsComplete(value2.preconditionId, value2.number);
			if (flag & flag2)
			{
				return true;
			}
			if (!flag && !flag2)
			{
				return false;
			}
		}
		return !flag;
	}

	private bool CanShowByEndType(PopUp config)
	{
		if (config == null)
		{
			return false;
		}
		if (config.timetargetId <= 0 || config.endType <= 0)
		{
			return true;
		}
		return (FacePushEndType)config.endType switch
		{
			FacePushEndType.Shop => CanShowByShopEndTime(config.timetargetId), 
			FacePushEndType.Gacha => CanShowByGachaEndTime(config.timetargetId), 
			FacePushEndType.Activity => CanShowByActivityEndTime(config.timetargetId), 
			_ => true, 
		};
	}

	private FacePushConfigCheckResult GetEndTypeCheckResult(PopUp config)
	{
		if (config == null)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, "配置为空");
		}
		if (config.timetargetId <= 0 || config.endType <= 0)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CanShow, "未配置结束时间");
		}
		return (FacePushEndType)config.endType switch
		{
			FacePushEndType.Shop => GetShopEndTimeCheckResult(config.timetargetId), 
			FacePushEndType.Gacha => GetGachaEndTimeCheckResult(config.timetargetId), 
			FacePushEndType.Activity => GetActivityEndTimeCheckResult(config.timetargetId), 
			_ => FinishConfigCheck(FacePushConfigCheckResult.CanShow, $"未知结束类型 {config.endType}，不拦截"), 
		};
	}

	private FacePushConfigCheckResult GetShopEndTimeCheckResult(int commodityId)
	{
		if (commodityId <= 0)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, "商品id无效");
		}
		if (!Model<ShopModel>.HasInstance())
		{
			return FinishConfigCheck(FacePushConfigCheckResult.PendingData, $"商品 {commodityId} 的商城数据未就绪");
		}
		if (!CanShowByShopEndTime(commodityId))
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, _configCheckReason);
		}
		return FinishConfigCheck(FacePushConfigCheckResult.CanShow, _configCheckReason);
	}

	private FacePushConfigCheckResult GetGachaEndTimeCheckResult(int gachaId)
	{
		if (gachaId <= 0)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, "卡池id无效");
		}
		if (!Model<CardDrawModel>.HasInstance() || Model<CardDrawModel>.Interface.GetGachaEffectiveInfo(gachaId) == null)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.PendingData, $"卡池 {gachaId} 数据未就绪");
		}
		if (!CanShowByGachaEndTime(gachaId))
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, $"卡池 {gachaId} 不在开放时间");
		}
		return FinishConfigCheck(FacePushConfigCheckResult.CanShow, $"卡池 {gachaId} 正在开放");
	}

	private FacePushConfigCheckResult GetActivityEndTimeCheckResult(int activityId)
	{
		if (activityId <= 0)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, "活动id无效");
		}
		if (RuntimeConfigs.data?.activityDatas == null)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.PendingData, "活动表未就绪");
		}
		ActivityData data = CoreUtils.GetData(activityId, RuntimeConfigs.data.activityDatas);
		if (data == null)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, $"活动配置不存在：{activityId}");
		}
		LogStaticActivityTimeOnce(activityId, data);
		if (!Model<ActivityCenterModel>.HasInstance())
		{
			return FinishConfigCheck(FacePushConfigCheckResult.PendingData, $"活动 {activityId} 的活动中心未就绪");
		}
		ActivityCenterData activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(activityId);
		if (activityCenterData?.ServerActivityData == null)
		{
			return GetMissingActivityCheckResult(activityId, "活动");
		}
		return GetServerActivityOpenCheckResult(activityId, activityCenterData.ServerActivityData);
	}

	private bool CanShowByShopEndTime(int commodityId)
	{
		if (commodityId <= 0 || !Model<ShopModel>.HasInstance())
		{
			_configCheckReason = "商城数据未就绪";
			return false;
		}
		if (!Model<ShopModel>.Interface.GoodsData.TryGetValue(commodityId, out var value))
		{
			_configCheckReason = $"商品 {commodityId} 尚未下发，暂不按结束时间拦截";
			return true;
		}
		if (value.EndTime <= 0 || value.EndTime >= TimeManager.ServerTime.NowTimestampSecond)
		{
			_configCheckReason = $"商品 {commodityId} 未过期";
			return true;
		}
		_configCheckReason = $"商品 {commodityId} 已过期";
		return false;
	}

	private bool CanShowByGachaEndTime(int gachaId)
	{
		if (gachaId <= 0 || !Model<CardDrawModel>.HasInstance())
		{
			return false;
		}
		return Model<CardDrawModel>.Interface.CheckGachaPoolInTimeRange(gachaId);
	}

	private bool CanShowByActivityEndTime(int activityId)
	{
		if (activityId <= 0 || !Model<ActivityCenterModel>.HasInstance())
		{
			return false;
		}
		return Model<ActivityCenterModel>.Interface.GetActivityCenterData(activityId)?.IsVaild() ?? false;
	}

	private static void LogStaticActivityTimeOnce(int activityId, ActivityData activityData)
	{
		if (LuminApplication.LogEnabled && s_loggedActivityTimeIds.Add(activityId))
		{
			long nowTimestamp = TimeManager.ServerTime.NowTimestamp;
			string arg;
			if (activityData.startTimeStamp > 0 && nowTimestamp < activityData.startTimeStamp)
			{
				arg = "当前服务器时间早于静态开始时间";
			}
			else
			{
				arg = ((activityData.endTimeStamp <= 0 || nowTimestamp <= activityData.endTimeStamp) ? "当前服务器时间落在静态窗口内" : "当前服务器时间晚于静态结束时间");
			}
			Debug.Log($"[拍脸] 活动 {activityId} 时间：服务器当前 {nowTimestamp} ms（{FormatUtc8(nowTimestamp)}），" + $"静态开始 {activityData.startTimeStamp}（{FormatUtc8(activityData.startTimeStamp)}），" + $"静态结束 {activityData.endTimeStamp}（{FormatUtc8(activityData.endTimeStamp)}）。{arg}");
		}
	}

	private static string FormatUtc8(long timestamp)
	{
		if (timestamp <= 0)
		{
			return "无";
		}
		try
		{
			return DateTimeOffset.FromUnixTimeMilliseconds(timestamp).ToOffset(TimeSpan.FromHours(8.0)).ToString("yyyy-MM-dd HH:mm:ss");
		}
		catch (ArgumentOutOfRangeException)
		{
			return "无法换算";
		}
	}

	private FacePushConfigCheckResult GetMissingActivityCheckResult(int activityId, string activityLabel)
	{
		if (!Model<ActivityCenterModel>.Interface.HasReceivedOperationalActivityList)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.PendingData, $"{activityLabel} {activityId} 数据未下发");
		}
		return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, $"{activityLabel} {activityId} 不在服务器活动列表中，跳过并不阻塞后续拍脸");
	}

	private FacePushConfigCheckResult GetServerActivityOpenCheckResult(int activityId, OperationalActivityData serverActivity)
	{
		if (serverActivity.IsHide)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, $"活动 {activityId} 已隐藏");
		}
		if (!TimeManager.IsInTimeRange(serverActivity.StartTime, serverActivity.EndTime))
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, $"活动 {activityId} 不在服务器开放时间：{serverActivity.StartTime}-{serverActivity.EndTime}");
		}
		if (RuntimeConfigs.data.activityDatas.TryGetValue(activityId, out var value) && value != null && value.activityEntryPosition != 1)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, $"活动 {activityId} 不在活动中心入口");
		}
		return FinishConfigCheck(FacePushConfigCheckResult.CanShow, $"活动 {activityId} 处于服务器开放时间");
	}

	private FacePushConfigCheckResult GetActivitySignInFacePushCheckResult(PopUp config)
	{
		if (config == null || config.targetId <= 0)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, "签到目标无效");
		}
		if (RuntimeConfigs.data?.activityDatas == null)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.PendingData, "活动表未就绪");
		}
		if (!Model<ActivityCenterModel>.HasInstance())
		{
			return FinishConfigCheck(FacePushConfigCheckResult.PendingData, $"签到活动 {config.targetId} 的活动中心未就绪");
		}
		ActivityCenterData activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(config.targetId);
		if (activityCenterData == null)
		{
			return GetMissingActivityCheckResult(config.targetId, "签到活动");
		}
		if (!activityCenterData.IsVaild())
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, $"签到活动 {config.targetId} 已失效");
		}
		if (!RuntimeConfigs.data.activityDatas.TryGetValue(config.targetId, out var value) || value == null || value.activityChallengGroup == null || value.activityChallengGroup.Length == 0)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, $"签到活动 {config.targetId} 没有奖励组");
		}
		if (Model<ActivityCenterModel>.Interface.GetActivitySignInInfo(config.targetId) == null)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.PendingData, $"签到活动 {config.targetId} 的进度未下发");
		}
		if (!HasActivitySignInReceivableReward(config.targetId, value))
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, $"签到活动 {config.targetId} 当前没有可领取奖励");
		}
		return FinishConfigCheck(FacePushConfigCheckResult.CanShow, $"签到活动 {config.targetId} 有可领取奖励");
	}

	private bool HasActivitySignInReceivableReward(int activityId, ActivityData activityData)
	{
		if (activityData?.activityChallengGroup == null || activityData.activityChallengGroup.Length == 0)
		{
			return false;
		}
		for (int i = 0; i < activityData.activityChallengGroup.Length; i++)
		{
			if (RuntimeConfigs.data.activityChallengeGroups.TryGetValue(activityData.activityChallengGroup[i], out var value) && Model<ActivityCenterModel>.Interface.GetSignInGroupRewardState(activityId, value) == ActivityCenterModel.ActivityRewardState.Receive)
			{
				return true;
			}
		}
		return false;
	}

	private bool CanShowDeparturePackageFacePush(PopUp config)
	{
		if (config == null || config.targetId <= 0)
		{
			_configCheckReason = "启程礼包目标无效";
			return false;
		}
		if (!Model<ShopModel>.HasInstance() || RuntimeConfigs.data?.bundles == null || RuntimeConfigs.data.subshopDatas == null || RuntimeConfigs.data.saleLists == null)
		{
			_configCheckReason = $"启程礼包 {config.targetId} 的商城配置未就绪";
			return false;
		}
		int targetId = config.targetId;
		Bundle data = CoreUtils.GetData(targetId, RuntimeConfigs.data.bundles);
		if (data == null)
		{
			_configCheckReason = $"启程礼包配置不存在：{targetId}";
			return false;
		}
		if (data.type == 4)
		{
			_configCheckReason = $"礼包 {targetId} 是自选礼包，不能直接购买";
			return false;
		}
		if (data.type != 2 && data.type != 3 && data.type != 5)
		{
			_configCheckReason = $"礼包 {targetId} 类型 {data.type} 不支持拍脸";
			return false;
		}
		if (data.paytype < 1 || data.paytype > 3)
		{
			_configCheckReason = $"礼包 {targetId} 支付类型无效：{data.paytype}";
			return false;
		}
		if (!RuntimeConfigs.data.saleLists.ContainsKey(targetId))
		{
			_configCheckReason = $"礼包 {targetId} 没有售卖配置";
			return false;
		}
		if (!TryGetSubShopDataByCommodityId(targetId, out var subShopData))
		{
			_configCheckReason = $"礼包 {targetId} 找不到子商店";
			return false;
		}
		if (!Model<ShopModel>.Interface.GoodsData.TryGetValue(targetId, out var value) && subShopData.gmType != 1)
		{
			_configCheckReason = $"礼包 {targetId} 尚未上架";
			return false;
		}
		if (value != null && value.EndTime > 0 && value.EndTime < TimeManager.ServerTime.NowTimestampSecond)
		{
			_configCheckReason = $"礼包 {targetId} 已过期";
			return false;
		}
		if (Model<ShopModel>.Interface.BundleLeftCount(targetId) == 0)
		{
			_configCheckReason = $"礼包 {targetId} 已售罄";
			return false;
		}
		if (data.missionGroupId != 0 && !Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(data.missionGroupId))
		{
			_configCheckReason = $"礼包 {targetId} 的任务组 {data.missionGroupId} 未完成";
			return false;
		}
		if (data.type == 5)
		{
			if (Model<ShopModel>.Interface.BundleData.BundleInfo.ContainsKey(targetId))
			{
				_configCheckReason = $"等级礼包 {targetId} 已购买";
				return false;
			}
			if (data.prebundle != 0 && !Model<ShopModel>.Interface.BundleData.BundleInfo.ContainsKey(data.prebundle))
			{
				_configCheckReason = $"等级礼包 {targetId} 的前置礼包 {data.prebundle} 未购买";
				return false;
			}
		}
		_configCheckReason = $"启程礼包 {targetId} 可以购买";
		return true;
	}

	private FacePushConfigCheckResult GetCharacterSkinPackageFacePushCheckResult(PopUp config)
	{
		if (config == null || config.targetId <= 0)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, "皮肤拍脸目标无效");
		}
		if (!Model<ShopModel>.HasInstance() || RuntimeConfigs.data?.skinShops == null || RuntimeConfigs.data.Skins == null || RuntimeConfigs.data.subshopDatas == null || !Model<ShopModel>.Interface.HasGoodsDataSync)
		{
			return FinishConfigCheck(FacePushConfigCheckResult.PendingData, $"皮肤目标 {config.targetId} 的商品数据尚未同步");
		}
		if (!CanShowCharacterSkinPackageFacePush(config))
		{
			return FinishConfigCheck(FacePushConfigCheckResult.CannotShow, _configCheckReason);
		}
		return FinishConfigCheck(FacePushConfigCheckResult.CanShow, _configCheckReason);
	}

	private bool CanShowCharacterSkinPackageFacePush(PopUp config)
	{
		if (config == null || config.targetId <= 0)
		{
			_configCheckReason = "皮肤拍脸目标无效";
			return false;
		}
		if (!Model<ShopModel>.HasInstance() || RuntimeConfigs.data?.skinShops == null || RuntimeConfigs.data.Skins == null || RuntimeConfigs.data.subshopDatas == null)
		{
			_configCheckReason = $"皮肤目标 {config.targetId} 的配置未就绪";
			return false;
		}
		if (!TryGetCharacterSkinPackageData(config.targetId, out var skinShopData, out var _, out var subShopData))
		{
			_configCheckReason = $"皮肤目标 {config.targetId} 无法解析商品";
			return false;
		}
		if (skinShopData.paytype < 1 || skinShopData.paytype > 3)
		{
			_configCheckReason = $"皮肤商品 {skinShopData.id} 支付类型无效：{skinShopData.paytype}";
			return false;
		}
		if (!Model<ShopModel>.Interface.GoodsData.TryGetValue(skinShopData.id, out var value) && subShopData.gmType != 1)
		{
			_configCheckReason = $"皮肤商品 {skinShopData.id} 尚未上架";
			return false;
		}
		if (value != null && value.EndTime > 0 && value.EndTime < TimeManager.ServerTime.NowTimestampSecond)
		{
			_configCheckReason = $"皮肤商品 {skinShopData.id} 已过期";
			return false;
		}
		if (Model<ShopModel>.Interface.SkinItemLeftCount(skinShopData.id) == 0)
		{
			_configCheckReason = $"皮肤商品 {skinShopData.id} 已售罄";
			return false;
		}
		if (HasOwnedSkin(skinShopData.skinid))
		{
			_configCheckReason = $"皮肤 {skinShopData.skinid} 已拥有";
			return false;
		}
		_configCheckReason = $"皮肤商品 {skinShopData.id} 可以购买";
		return true;
	}

	private static bool HasOwnedSkin(int skinId)
	{
		List<SkinInfo> skinData = Model<ShopModel>.Interface.SkinData;
		if (skinData == null)
		{
			return false;
		}
		for (int i = 0; i < skinData.Count; i++)
		{
			if (skinData[i].SkinId == skinId)
			{
				return true;
			}
		}
		return false;
	}

	private bool CanShowByFrequency(PopUp config)
	{
		if (config == null)
		{
			_configCheckReason = "配置为空";
			return false;
		}
		if (config.maxShowTimes <= 0)
		{
			_configCheckReason = "不限制展示次数";
			return true;
		}
		switch (config.cycleType)
		{
		case 1:
			return CanShowDailyConfigFacePush(config);
		case 2:
			return CanShowWeeklyConfigFacePush(config);
		default:
			_configCheckReason = $"周期类型 {config.cycleType} 未接入，不拦截";
			return true;
		}
	}

	private bool CanShowDailyConfigFacePush(PopUp config)
	{
		int facePushDailyDate = GetFacePushDailyDate();
		string localRecordOwnerKey = GetLocalRecordOwnerKey();
		string key = BuildShowDateKey(localRecordOwnerKey, config.id);
		string key2 = BuildShowCountKey(localRecordOwnerKey, config.id);
		int num = ((PlayerPrefs.GetInt(key, 0) == facePushDailyDate) ? PlayerPrefs.GetInt(key2, 0) : 0);
		if (num < config.maxShowTimes)
		{
			_configCheckReason = $"今日已展示 {num}/{config.maxShowTimes}";
			return true;
		}
		_configCheckReason = $"今日展示次数已达上限 {num}/{config.maxShowTimes}";
		return false;
	}

	private void RecordDailyConfigFacePushShown(PopUp config)
	{
		int facePushDailyDate = GetFacePushDailyDate();
		string localRecordOwnerKey = GetLocalRecordOwnerKey();
		string key = BuildShowDateKey(localRecordOwnerKey, config.id);
		string key2 = BuildShowCountKey(localRecordOwnerKey, config.id);
		int num = ((PlayerPrefs.GetInt(key, 0) == facePushDailyDate) ? PlayerPrefs.GetInt(key2, 0) : 0);
		PlayerPrefs.SetInt(key, facePushDailyDate);
		PlayerPrefs.SetInt(key2, num + 1);
		PlayerPrefs.Save();
	}

	private bool CanShowWeeklyConfigFacePush(PopUp config)
	{
		int facePushDailyDate = GetFacePushDailyDate();
		ReadCurrentWeekShowRecord(config.id, GetFacePushWeekId(), out var showCount, out var showDay);
		if (showDay == facePushDailyDate)
		{
			_configCheckReason = $"本周已展示 {showCount}/{config.maxShowTimes}，今日已展示过";
			return false;
		}
		if (showCount >= config.maxShowTimes)
		{
			_configCheckReason = $"本周展示次数已达上限 {showCount}/{config.maxShowTimes}";
			return false;
		}
		_configCheckReason = $"本周已展示 {showCount}/{config.maxShowTimes}";
		return true;
	}

	private void RecordWeeklyConfigFacePushShown(PopUp config)
	{
		int facePushDailyDate = GetFacePushDailyDate();
		int facePushWeekId = GetFacePushWeekId();
		ReadCurrentWeekShowRecord(config.id, facePushWeekId, out var showCount, out var showDay);
		if (showDay != facePushDailyDate)
		{
			string localRecordOwnerKey = GetLocalRecordOwnerKey();
			PlayerPrefs.SetInt(BuildShowWeekKey(localRecordOwnerKey, config.id), facePushWeekId);
			PlayerPrefs.SetInt(BuildShowWeekCountKey(localRecordOwnerKey, config.id), showCount + 1);
			PlayerPrefs.SetInt(BuildShowWeekDayKey(localRecordOwnerKey, config.id), facePushDailyDate);
			PlayerPrefs.Save();
		}
	}

	private void ReadCurrentWeekShowRecord(int configId, int weekId, out int showCount, out int showDay)
	{
		string localRecordOwnerKey = GetLocalRecordOwnerKey();
		if (PlayerPrefs.GetInt(BuildShowWeekKey(localRecordOwnerKey, configId), 0) != weekId)
		{
			showCount = 0;
			showDay = 0;
		}
		else
		{
			showCount = PlayerPrefs.GetInt(BuildShowWeekCountKey(localRecordOwnerKey, configId), 0);
			showDay = PlayerPrefs.GetInt(BuildShowWeekDayKey(localRecordOwnerKey, configId), 0);
		}
	}

	private int GetFacePushWeekId()
	{
		System.DateTime date = TimeManager.ServerTime.Now.AddHours(-4.0).Date;
		int num = (int)(date.DayOfWeek - 1 + 7) % 7;
		System.DateTime dateTime = date.AddDays(-num);
		return dateTime.Year * 10000 + dateTime.Month * 100 + dateTime.Day;
	}

	private string BuildShowWeekKey(string ownerKey, int configId)
	{
		return "FacePush.ShowWeek." + ownerKey + "." + configId;
	}

	private string BuildShowWeekCountKey(string ownerKey, int configId)
	{
		return "FacePush.ShowWeekCount." + ownerKey + "." + configId;
	}

	private string BuildShowWeekDayKey(string ownerKey, int configId)
	{
		return "FacePush.ShowWeekDay." + ownerKey + "." + configId;
	}

	public void RecordFacePushShownForCurrentDay()
	{
		PlayerPrefs.SetInt(BuildLoginShowDateKey(GetLocalRecordOwnerKey()), GetLoginDate());
		PlayerPrefs.Save();
	}

	public static void NotifyLoginSystemOpenSynced()
	{
		RefreshLoginSessionGate();
		if (LoginUtility.EnterGameAck != null)
		{
			s_hasLoginSystemOpenSync = true;
			TryCaptureActivitySystemUnlockAtLogin();
		}
	}

	public static void NotifyLoginSystemStatusSynced()
	{
		RefreshLoginSessionGate();
		if (LoginUtility.EnterGameAck != null)
		{
			s_hasLoginSystemStatusSync = true;
			TryCaptureActivitySystemUnlockAtLogin();
		}
	}

	public static void NotifyLoginSessionStarted()
	{
		EnterGameAck enterGameAck = LoginUtility.EnterGameAck;
		if (enterGameAck != null)
		{
			ResetLoginSessionGate(enterGameAck.SessionID);
		}
	}

	public static void SuppressFacePushForReconnect()
	{
		RefreshLoginSessionGate();
		s_isFacePushSuppressedForCurrentLogin = true;
	}

	private static void RefreshLoginSessionGate()
	{
		EnterGameAck enterGameAck = LoginUtility.EnterGameAck;
		if (enterGameAck == null)
		{
			s_loginSessionId = null;
			s_hasLoginSystemOpenSync = false;
			s_hasLoginSystemStatusSync = false;
			s_hasActivitySystemUnlockSnapshotForCurrentLogin = false;
			s_isFacePushSuppressedForCurrentLogin = true;
			s_isSupplementaryFacePushSuppressedForCurrentLogin = false;
			s_supplementaryFacePushSuppressedRefreshDate = 0;
		}
		else if (!string.Equals(s_loginSessionId, enterGameAck.SessionID, StringComparison.Ordinal))
		{
			ResetLoginSessionGate(enterGameAck.SessionID);
		}
	}

	private static void ResetLoginSessionGate(string sessionId)
	{
		s_loginSessionId = sessionId;
		s_hasLoginSystemOpenSync = false;
		s_hasLoginSystemStatusSync = false;
		s_hasActivitySystemUnlockSnapshotForCurrentLogin = false;
		s_isFacePushSuppressedForCurrentLogin = true;
		s_isSupplementaryFacePushSuppressedForCurrentLogin = !EventTrackSolver.s_IsFirstLogin && HasFacePushShownToday();
		s_supplementaryFacePushSuppressedRefreshDate = (s_isSupplementaryFacePushSuppressedForCurrentLogin ? GetCurrentFacePushRefreshDate() : 0);
	}

	private static void TryCaptureActivitySystemUnlockAtLogin()
	{
		if (s_hasLoginSystemOpenSync && s_hasLoginSystemStatusSync && !s_hasActivitySystemUnlockSnapshotForCurrentLogin)
		{
			s_hasActivitySystemUnlockSnapshotForCurrentLogin = true;
			s_isFacePushSuppressedForCurrentLogin = !IsActivitySystemUnlockedAtLogin();
		}
	}

	private static bool IsActivitySystemUnlockedAtLogin()
	{
		if (Singleton<SystemUnlockManager>.HasInstance())
		{
			return Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Activity);
		}
		return false;
	}

	private static bool HasFacePushShownToday()
	{
		return PlayerPrefs.GetInt(BuildLoginShowDateKey(GetLocalRecordOwnerKey()), 0) == GetLoginDate();
	}

	private int GetFacePushDailyDate()
	{
		System.DateTime date = TimeManager.ServerTime.Now.AddHours(-4.0).Date;
		return date.Year * 10000 + date.Month * 100 + date.Day;
	}

	private static int GetLoginDate()
	{
		System.DateTime date = TimeManager.ServerTime.Now.Date;
		return date.Year * 10000 + date.Month * 100 + date.Day;
	}

	private static int GetCurrentFacePushRefreshDate()
	{
		System.DateTime date = TimeManager.ServerTime.Now.AddHours(-4.0).Date;
		return date.Year * 10000 + date.Month * 100 + date.Day;
	}

	private string BuildShowDateKey(string ownerKey, int configId)
	{
		return "FacePush.ShowDate." + ownerKey + "." + configId;
	}

	private string BuildShowCountKey(string ownerKey, int configId)
	{
		return "FacePush.ShowCount." + ownerKey + "." + configId;
	}

	private static string BuildLoginShowDateKey(string ownerKey)
	{
		return "FacePush.LoginShowDate." + ownerKey;
	}

	private static string GetLocalRecordOwnerKey()
	{
		if (LoginUtility.AccountId > 0)
		{
			return LoginUtility.AccountId.ToString();
		}
		if (!string.IsNullOrEmpty(LoginUtility.OpenId))
		{
			return LoginUtility.OpenId;
		}
		return "0";
	}

	private void BuildUITypePathCache()
	{
		_uiTypeByPrefabPath.Clear();
		foreach (KeyValuePair<UI_TYPE, UIData> dICT_UI_DATum in CommonUIData.DICT_UI_DATA)
		{
			UIData value = dICT_UI_DATum.Value;
			if (value != null && !string.IsNullOrEmpty(value.mobilePath) && !_uiTypeByPrefabPath.ContainsKey(value.mobilePath))
			{
				_uiTypeByPrefabPath.Add(value.mobilePath, dICT_UI_DATum.Key);
			}
		}
	}

	private void OnOpenRequested(PopUp config)
	{
		FacePushSession facePushSession = Scheduler?.CurrentSession;
		if (facePushSession == null)
		{
			FacePushFlowLog.FailAlways("打开配置拍脸", $"配置 {config?.id} 没有有效会话");
			return;
		}
		RefreshLoginSessionGate();
		if (s_isFacePushSuppressedForCurrentLogin)
		{
			NotifyOpenFailedLater(facePushSession, "本次登录活动系统未解锁，打开前被拦截");
			return;
		}
		if (!TryGetUITypeByPrefabPath(config, out var uiType))
		{
			NotifyOpenFailedLater(facePushSession, "预制体路径无法对应界面：" + config?.prefebPath);
			return;
		}
		object obj = CreateFacePushViewData(uiType, config, facePushSession);
		if (obj == null)
		{
			NotifyOpenFailedLater(facePushSession, DescribeViewDataFailure(uiType, config));
			return;
		}
		try
		{
			if (!Singleton<NewUIManager>.instance.OpenUI(uiType, obj).IsValid)
			{
				NotifyOpenFailedLater(facePushSession, $"OpenUI 返回无效：{uiType}");
			}
			else
			{
				FacePushFlowLog.SuccessAlways("打开配置拍脸", $"配置 {config?.id}，界面 {uiType}");
			}
		}
		catch (Exception ex)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(ex);
			}
			NotifyOpenFailedLater(facePushSession, "OpenUI 异常：" + ex.Message);
		}
	}

	private string DescribeViewDataFailure(UI_TYPE uiType, PopUp config)
	{
		switch (uiType)
		{
		case UI_TYPE.UI_DEPARTUREPACKAGE:
		case UI_TYPE.UI_TENTICKETGIFT:
			return $"界面 {uiType} 的礼包 {config?.targetId} 找不到子商店";
		case UI_TYPE.UI_CHARACTERSKINPACKAGE:
			return $"界面 {uiType} 的皮肤目标 {config?.targetId} 无法解析";
		default:
			return $"界面 {uiType} 未接入拍脸 ViewData";
		}
	}

	public bool TryRefreshCurrentFacePushView(PopUp config, FacePushSession session)
	{
		if (config == null || session == null || !TryGetUITypeByPrefabPath(config, out var uiType))
		{
			FacePushFlowLog.Fail("刷新拍脸界面", (config == null) ? "配置为空" : "预制体路径无法对应界面");
			return false;
		}
		RefreshLoginSessionGate();
		if (s_isFacePushSuppressedForCurrentLogin)
		{
			FacePushFlowLog.Fail("刷新拍脸界面", "本次登录活动系统未解锁");
			return false;
		}
		object obj = CreateFacePushViewData(uiType, config, session);
		if (obj == null)
		{
			FacePushFlowLog.Fail("刷新拍脸界面", DescribeViewDataFailure(uiType, config));
			return false;
		}
		if (!Singleton<NewUIManager>.instance.TryGetFirstUIController(uiType, out var ui) || ui.State != UIState.Opened)
		{
			FacePushFlowLog.Fail("刷新拍脸界面", $"界面 {uiType} 不在打开状态");
			return false;
		}
		if (!(ui.GetUIView() is IFacePushReusableView facePushReusableView))
		{
			FacePushFlowLog.Fail("刷新拍脸界面", $"界面 {uiType} 不支持拍脸内容刷新");
			return false;
		}
		if (!facePushReusableView.TryRefreshFacePush(obj))
		{
			FacePushFlowLog.Fail("刷新拍脸界面", $"界面 {uiType} 拒绝了新的拍脸数据");
			return false;
		}
		FacePushFlowLog.Success("刷新拍脸界面", $"配置 {config.id}，界面 {uiType}");
		return true;
	}

	private void NotifyOpenFailedLater(FacePushSession session, string reason)
	{
		FacePushFlowLog.Fail("打开配置拍脸", reason);
		NotifyOpenFailedLaterAsync(session, reason).Forget();
	}

	private async UniTaskVoid NotifyOpenFailedLaterAsync(FacePushSession session, string reason)
	{
		await UniTask.Yield();
		session?.NotifyOpenFailed(reason);
	}

	private bool TryGetUITypeByPrefabPath(PopUp config, out UI_TYPE uiType)
	{
		uiType = UI_TYPE.UI_NONE;
		if (config == null || string.IsNullOrEmpty(config.prefebPath))
		{
			return false;
		}
		return _uiTypeByPrefabPath.TryGetValue(config.prefebPath.Trim(), out uiType);
	}

	private object CreateFacePushViewData(UI_TYPE uiType, PopUp config, FacePushSession session)
	{
		switch (uiType)
		{
		case UI_TYPE.UI_SLAPTENDAYSIGNIN:
			return new SlapTendaySigninViewData
			{
				activityId = config.targetId,
				FacePushSession = session
			};
		case UI_TYPE.UI_NEWBIELOGIN:
			return new NewbieLoginViewData
			{
				activityId = config.targetId,
				FacePushSession = session
			};
		case UI_TYPE.UI_TENTICKETGIFT:
		{
			if (!TryGetSubShopDataByCommodityId(config.targetId, out var subShopData2))
			{
				return null;
			}
			return new TenTicketGiftViewData
			{
				bundleId = config.targetId,
				subShopId = subShopData2.id,
				FacePushSession = session
			};
		}
		case UI_TYPE.UI_DEPARTUREPACKAGE:
		{
			if (!TryGetSubShopDataByCommodityId(config.targetId, out var subShopData3))
			{
				return null;
			}
			return new DeparturePackageViewData
			{
				bundleId = config.targetId,
				subShopId = subShopData3.id,
				FacePushSession = session
			};
		}
		case UI_TYPE.UI_CHARACTERSKINPACKAGE:
		{
			if (!TryGetCharacterSkinPackageData(config.targetId, out var skinShopData, out var _, out var subShopData))
			{
				return null;
			}
			return new CharacterSkinPackageViewData
			{
				skinShopId = skinShopData.id,
				subShopId = subShopData.id,
				FacePushSession = session
			};
		}
		default:
			return null;
		}
	}

	private bool TryGetSubShopDataByCommodityId(int commodityId, out SubshopData subShopData)
	{
		if (commodityId <= 0 || RuntimeConfigs.data?.subshopDatas == null)
		{
			subShopData = null;
			return false;
		}
		foreach (KeyValuePair<int, SubshopData> subshopData in RuntimeConfigs.data.subshopDatas)
		{
			SubshopData value = subshopData.Value;
			if (value?.commodityIds == null)
			{
				continue;
			}
			for (int i = 0; i < value.commodityIds.Length; i++)
			{
				if (value.commodityIds[i] == commodityId)
				{
					subShopData = value;
					return true;
				}
			}
		}
		subShopData = null;
		return false;
	}

	private bool TryGetCharacterSkinPackageData(int targetId, out SkinShop skinShopData, out Skin skinData, out SubshopData subShopData)
	{
		skinShopData = null;
		skinData = null;
		subShopData = null;
		if (targetId <= 0 || !Model<ShopModel>.HasInstance() || RuntimeConfigs.data?.skinShops == null || RuntimeConfigs.data.Skins == null || RuntimeConfigs.data.subshopDatas == null)
		{
			return false;
		}
		skinShopData = CoreUtils.GetData(targetId, RuntimeConfigs.data.skinShops);
		if (skinShopData != null)
		{
			if (!TryGetSubShopDataByCommodityId(skinShopData.id, out subShopData))
			{
				return false;
			}
		}
		else
		{
			subShopData = CoreUtils.GetData(targetId, RuntimeConfigs.data.subshopDatas);
			if (subShopData == null || !TryGetFirstListedSkinCommodityId(subShopData, out var skinShopId))
			{
				return false;
			}
			skinShopData = CoreUtils.GetData(skinShopId, RuntimeConfigs.data.skinShops);
			if (skinShopData == null)
			{
				return false;
			}
		}
		skinData = CoreUtils.GetData(skinShopData.skinid, RuntimeConfigs.data.Skins);
		return skinData != null;
	}

	private bool TryGetFirstListedSkinCommodityId(SubshopData subShopData, out int skinShopId)
	{
		skinShopId = 0;
		if (subShopData?.commodityIds == null)
		{
			return false;
		}
		for (int i = 0; i < subShopData.commodityIds.Length; i++)
		{
			int num = subShopData.commodityIds[i];
			if (subShopData.gmType == 1 || Model<ShopModel>.Interface.GoodsData.ContainsKey(num))
			{
				skinShopId = num;
				return true;
			}
		}
		return false;
	}
}
