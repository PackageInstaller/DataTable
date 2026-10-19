using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Model.Jump;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using UnityEngine;

namespace ACT.Model;

public class WorldLevelModel : Model<WorldLevelModel>, IJumpable
{
	private const int WorldLevelJumpTabIndex = 0;

	private const int WorldLevelJumpTargetParamIndex = 1;

	private const int WorldLevelReachTipLocalizeId = 2773;

	private const int WorldLevelDisplayMaxLevel = 9;

	public const float WorldLevelBreakTaskHudTipTimeoutSeconds = 15f;

	public List<LevelDisplayItem> displayItems = new List<LevelDisplayItem>();

	public readonly List<int> WorldLevelBreakTaskList = new List<int> { 500105001, 500105002, 500106001, 500106002, 500107001, 500107002, 500108001, 500108002, 500109001, 500109002 };

	private ExpChangesEvt m_expChangesEvt;

	private bool m_isWorldLevel;

	private readonly HashSet<int> _handledWorldLevelBreakTaskMissionIds = new HashSet<int>();

	private bool _hasPendingWorldLevelBreakTaskHudTip;

	private int _guideDefaultSelectFirstWorldLevelItemCount;

	private int _guideWorldLevelTaskGroupIndex = -1;

	private int _guideWorldLevelTaskGroupIndexCount;

	private int _pendingJumpWorldLevel = -1;

	public int CurrentSelectWorldLevel { get; set; }

	public int BeforeBreakWorldLevel { get; set; }

	public bool HasGuideWorldLevelTaskGroupIndex
	{
		get
		{
			if (_guideWorldLevelTaskGroupIndexCount > 0)
			{
				return _guideWorldLevelTaskGroupIndex >= 0;
			}
			return false;
		}
	}

	public int GuideWorldLevelTaskGroupIndex => _guideWorldLevelTaskGroupIndex;

	public int MaxWorldLevel
	{
		get
		{
			if (RuntimeConfigs.data.playerWorldLevelDataNews.Count <= 0)
			{
				return 1;
			}
			return Mathf.Min(9, RuntimeConfigs.data.playerWorldLevelDataNews[RuntimeConfigs.data.playerWorldLevelDataNews.Count].id);
		}
	}

	public LuminModelType JumpSourceType => LuminModelType.WorldLevel;

	protected override void Init()
	{
		GenerateDisplayItems();
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction += NotifyTaskProgressChange;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.HasWorldLevelTaskNotify, OnWorldLevelTaskNotify);
		m_expChangesEvt = null;
	}

	private void GenerateDisplayItems()
	{
		displayItems.Clear();
		displayItems.Add(new LevelDisplayItem(DisplayItemType.Placeholder, 0, placeholder: true));
		displayItems.Add(new LevelDisplayItem(DisplayItemType.Placeholder, 0, placeholder: true));
		for (int i = 2; i <= MaxWorldLevel; i++)
		{
			displayItems.Add(new LevelDisplayItem(DisplayItemType.WorldLevel, i));
		}
		displayItems.Add(new LevelDisplayItem(DisplayItemType.Placeholder, 0, placeholder: true));
		displayItems.Add(new LevelDisplayItem(DisplayItemType.Placeholder, 0, placeholder: true));
	}

	protected override void UnInit()
	{
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction -= NotifyTaskProgressChange;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.HasWorldLevelTaskNotify, OnWorldLevelTaskNotify);
		m_expChangesEvt = null;
		_hasPendingWorldLevelBreakTaskHudTip = false;
		_handledWorldLevelBreakTaskMissionIds.Clear();
	}

	private void NotifyTaskProgressChange(int arg1, TaskInfo arg2, bool arg3)
	{
		RefreshRedDot();
	}

	public void RefreshRedDot()
	{
		bool active = IsShowRedDotInTab();
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.SystemGuide))
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.WorldLevelTab, active: false);
		}
		else
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.WorldLevelTab, active);
		}
	}

	public int GetCurWorldLevel()
	{
		return (int)G.detailUserInfo.Attributes[94];
	}

	public LevelDisplayItem GetDisPlayItemData(int index)
	{
		if (index >= 0 && index < displayItems.Count)
		{
			return displayItems[index];
		}
		return null;
	}

	public int GetRealDataStartIndex()
	{
		return 2;
	}

	public int GetRealDataEndIndex()
	{
		return displayItems.Count - 3;
	}

	public bool IsPlaceholder(int index)
	{
		if (index < 0 || index >= displayItems.Count)
		{
			return false;
		}
		return displayItems[index].isPlaceholder;
	}

	public List<int> GetWorldLevelBreakTaskGroup(int worldLevel)
	{
		if (worldLevel < 2 || worldLevel > MaxWorldLevel)
		{
			return null;
		}
		worldLevel--;
		PlayerWorldLevelDataNew playerWorldLevelDataNew = RuntimeConfigs.data.playerWorldLevelDataNews[worldLevel];
		if (playerWorldLevelDataNew == null)
		{
			Debug.LogError("世界等级{1}的对应配置为空" + worldLevel);
		}
		int missionId = playerWorldLevelDataNew.missionId;
		List<int> list = new List<int>();
		int[] missionId2 = RuntimeConfigs.data.missionGroups[missionId].missionId;
		if (missionId2 == null)
		{
			Debug.LogError("任务组{1}的对应配置为空" + RuntimeConfigs.data.missionGroups[missionId].missionId);
		}
		int[] array = missionId2;
		foreach (int item in array)
		{
			list.Add(item);
		}
		return list;
	}

	public int GetMaximumPlayerLevel(int worldLevel)
	{
		PlayerWorldLevelDataNew playerWorldLevelDataNew = RuntimeConfigs.data.playerWorldLevelDataNews[worldLevel];
		if (playerWorldLevelDataNew == null)
		{
			Debug.LogError("世界等级{1}的对应配置为空" + worldLevel);
			return 0;
		}
		return playerWorldLevelDataNew.maximumPlayerLevel;
	}

	public List<int> GetWorldLevelOpenSystemIdList(int targetWorldLevel)
	{
		if (targetWorldLevel < 2 || targetWorldLevel > MaxWorldLevel)
		{
			return new List<int>();
		}
		int maximumPlayerLevel = GetMaximumPlayerLevel(targetWorldLevel - 1);
		if (!RuntimeConfigs.data.playerLevelDatas.TryGetValue(maximumPlayerLevel, out var value) || value.systemId == null)
		{
			return new List<int>();
		}
		List<int> list = new List<int>();
		int[] systemId = value.systemId;
		foreach (int item in systemId)
		{
			list.Add(item);
		}
		return list;
	}

	public int GetDefaultBreakTargetWorldLevel()
	{
		int num = ConsumePendingJumpWorldLevelTarget();
		if (num >= 2)
		{
			return Mathf.Clamp(num, 2, MaxWorldLevel);
		}
		return Mathf.Clamp(GetCurWorldLevel() + 1, 2, MaxWorldLevel);
	}

	public bool IsWorldLevelBreakCompleted(int targetWorldLevel)
	{
		if (targetWorldLevel >= 2)
		{
			return GetCurWorldLevel() >= targetWorldLevel;
		}
		return false;
	}

	public bool CanBreakWorldLevel(int targetWorldLevel)
	{
		if (targetWorldLevel < 2 || targetWorldLevel > MaxWorldLevel)
		{
			return false;
		}
		if (targetWorldLevel != GetCurWorldLevel() + 1)
		{
			return false;
		}
		int maximumPlayerLevel = GetMaximumPlayerLevel(targetWorldLevel - 1);
		if (SystemUnlockManager.playerLevel < maximumPlayerLevel)
		{
			return false;
		}
		List<int> worldLevelBreakTaskGroup = GetWorldLevelBreakTaskGroup(targetWorldLevel);
		if (worldLevelBreakTaskGroup == null || worldLevelBreakTaskGroup.Count <= 0)
		{
			return false;
		}
		foreach (int item in worldLevelBreakTaskGroup)
		{
			Singleton<PreconditionInfoManager>.instance.taskDic.TryGetValue(item, out var value);
			if (value == null || value.status == 0)
			{
				return false;
			}
		}
		return true;
	}

	public Color32 GetTextColor(WorldLevelColorEnum enumValue)
	{
		return enumValue switch
		{
			WorldLevelColorEnum.Green => new Color32(184, byte.MaxValue, 92, byte.MaxValue), 
			WorldLevelColorEnum.Dark => new Color32(162, 170, 171, byte.MaxValue), 
			WorldLevelColorEnum.BrightChartreuse => new Color32(199, byte.MaxValue, 134, byte.MaxValue), 
			WorldLevelColorEnum.White => new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue), 
			WorldLevelColorEnum.Cyan => new Color32(91, 203, 178, byte.MaxValue), 
			_ => new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue), 
		};
	}

	public string GetTextColorString(WorldLevelColorEnum enumValue)
	{
		return enumValue switch
		{
			WorldLevelColorEnum.Green => "#b8ff5c", 
			WorldLevelColorEnum.Dark => "#a2aaab", 
			WorldLevelColorEnum.BrightChartreuse => "#c7ff86", 
			WorldLevelColorEnum.White => "#ffffff", 
			WorldLevelColorEnum.Cyan => "#5bcbb2", 
			_ => "#ffffff", 
		};
	}

	public bool GetSelectItemCollected(int value, DisplayItemType type)
	{
		if (type == DisplayItemType.WorldLevel)
		{
			return IsWorldLevelBreakCompleted(value);
		}
		return false;
	}

	public bool GetSelectItemCanReceiveAward(int value, DisplayItemType type)
	{
		if (type == DisplayItemType.WorldLevel)
		{
			return CanBreakWorldLevel(value);
		}
		return false;
	}

	public bool CurrItemIsShowRedDot(int value, DisplayItemType type)
	{
		if (type == DisplayItemType.Placeholder)
		{
			return false;
		}
		return GetSelectItemCanReceiveAward(value, type);
	}

	public bool IsShowRedDotInTab()
	{
		for (int i = GetRealDataStartIndex(); i <= GetRealDataEndIndex(); i++)
		{
			LevelDisplayItem levelDisplayItem = displayItems[i];
			if (CurrItemIsShowRedDot(levelDisplayItem.value, levelDisplayItem.type))
			{
				return true;
			}
		}
		return false;
	}

	public int GetFirstWorldLevelItemIndex()
	{
		for (int i = GetRealDataStartIndex(); i <= GetRealDataEndIndex(); i++)
		{
			LevelDisplayItem levelDisplayItem = displayItems[i];
			if (!levelDisplayItem.isPlaceholder && levelDisplayItem.type == DisplayItemType.WorldLevel)
			{
				return i;
			}
		}
		return -1;
	}

	public int GetWorldLevelItemIndexByConfigId(int targetWorldLevel)
	{
		targetWorldLevel = GetJumpTargetWorldLevel(targetWorldLevel);
		if (targetWorldLevel <= 0)
		{
			return -1;
		}
		for (int i = GetRealDataStartIndex(); i <= GetRealDataEndIndex(); i++)
		{
			LevelDisplayItem levelDisplayItem = displayItems[i];
			if (!levelDisplayItem.isPlaceholder && levelDisplayItem.type == DisplayItemType.WorldLevel && levelDisplayItem.value == targetWorldLevel)
			{
				return i;
			}
		}
		return -1;
	}

	public void SetGuideDefaultSelectFirstWorldLevelItem()
	{
		_guideDefaultSelectFirstWorldLevelItemCount++;
	}

	public void ResetGuideDefaultSelectFirstWorldLevelItem()
	{
		_guideDefaultSelectFirstWorldLevelItemCount--;
		if (_guideDefaultSelectFirstWorldLevelItemCount <= 0)
		{
			_guideDefaultSelectFirstWorldLevelItemCount = 0;
		}
	}

	public void SetGuideWorldLevelTaskGroupIndex(int index)
	{
		_guideWorldLevelTaskGroupIndex = Mathf.Max(0, index);
		_guideWorldLevelTaskGroupIndexCount++;
	}

	public void ResetGuideWorldLevelTaskGroupIndex()
	{
		_guideWorldLevelTaskGroupIndexCount--;
		if (_guideWorldLevelTaskGroupIndexCount <= 0)
		{
			_guideWorldLevelTaskGroupIndexCount = 0;
			_guideWorldLevelTaskGroupIndex = -1;
		}
	}

	public int GetDefaultSelectIndex()
	{
		int num = ConsumePendingJumpWorldLevelIndex();
		if (num >= 0)
		{
			return num;
		}
		if (_guideDefaultSelectFirstWorldLevelItemCount > 0)
		{
			int firstWorldLevelItemIndex = GetFirstWorldLevelItemIndex();
			if (firstWorldLevelItemIndex >= 0)
			{
				return firstWorldLevelItemIndex;
			}
		}
		if (IsShowRedDotInTab())
		{
			int num2 = -1;
			for (int num3 = GetRealDataEndIndex(); num3 >= GetRealDataStartIndex(); num3--)
			{
				LevelDisplayItem levelDisplayItem = displayItems[num3];
				if (CurrItemIsShowRedDot(levelDisplayItem.value, levelDisplayItem.type))
				{
					num2 = num3;
					break;
				}
			}
			if (num2 >= 0)
			{
				return num2;
			}
		}
		else
		{
			int defaultBreakTargetWorldLevel = GetDefaultBreakTargetWorldLevel();
			for (int i = GetRealDataStartIndex(); i <= GetRealDataEndIndex(); i++)
			{
				LevelDisplayItem levelDisplayItem2 = displayItems[i];
				if (!levelDisplayItem2.isPlaceholder && levelDisplayItem2.value == defaultBreakTargetWorldLevel)
				{
					return i;
				}
			}
		}
		return GetRealDataStartIndex();
	}

	public int RealIndexToDisplayIndex(int realIndex)
	{
		return realIndex + GetRealDataStartIndex();
	}

	public int DisplayIndexToRealIndex(int displayIndex)
	{
		return displayIndex - GetRealDataStartIndex();
	}

	private void SetPendingJumpWorldLevel(int targetWorldLevel)
	{
		_pendingJumpWorldLevel = ((targetWorldLevel > 0) ? targetWorldLevel : (-1));
	}

	private int ConsumePendingJumpWorldLevelIndex()
	{
		int num = ConsumePendingJumpWorldLevelTarget();
		if (num <= 0)
		{
			return -1;
		}
		for (int i = GetRealDataStartIndex(); i <= GetRealDataEndIndex(); i++)
		{
			LevelDisplayItem levelDisplayItem = displayItems[i];
			if (!levelDisplayItem.isPlaceholder && levelDisplayItem.value == num)
			{
				return i;
			}
		}
		return -1;
	}

	private int ConsumePendingJumpWorldLevelTarget()
	{
		if (_pendingJumpWorldLevel <= 0)
		{
			return 0;
		}
		int pendingJumpWorldLevel = _pendingJumpWorldLevel;
		_pendingJumpWorldLevel = -1;
		return GetJumpTargetWorldLevel(pendingJumpWorldLevel);
	}

	private int GetJumpTargetWorldLevel(RuntimeJumpData jumpData)
	{
		List<int> list = jumpData.Params;
		if (list == null || list.Count <= 1)
		{
			return 0;
		}
		return GetJumpTargetWorldLevel(jumpData.Params[1]);
	}

	private int GetJumpRequiredWorldLevel(RuntimeJumpData jumpData)
	{
		return GetJumpTargetWorldLevel(jumpData);
	}

	private int GetJumpTargetWorldLevel(int targetWorldLevel)
	{
		if (targetWorldLevel <= 0)
		{
			return 0;
		}
		return targetWorldLevel;
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.SystemGuide))
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.Forbidden,
				Message = Singleton<SystemUnlockManager>.instance.GetSystemLockTips(SystemType.SystemGuide)
			};
		}
		int jumpRequiredWorldLevel = GetJumpRequiredWorldLevel(jumpData);
		if (jumpRequiredWorldLevel > 0 && GetCurWorldLevel() < jumpRequiredWorldLevel)
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.Forbidden,
				Message = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2773)
			};
		}
		return new JumpResult
		{
			ShowType = JumpResult.JumpShowType.CanJump
		};
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		SetPendingJumpWorldLevel(GetJumpTargetWorldLevel(jumpData));
		UIState firstUIState = Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_MONOJOURNEYTRACESVIEW);
		if ((firstUIState == UIState.Opening || firstUIState == UIState.Opened) && Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_MONOJOURNEYTRACESVIEW) is MonoJourneyTracesView monoJourneyTracesView)
		{
			if (firstUIState != UIState.Opening)
			{
				if (monoJourneyTracesView.CurTabID == 0)
				{
					monoJourneyTracesView.worldLevelPage?.RefreshJumpSelection(monoJourneyTracesView);
					return;
				}
				monoJourneyTracesView.toggleGroup.SetAllToggleOff();
				monoJourneyTracesView.toggleGroup.SetToggleOn(0);
			}
		}
		else
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_MONOJOURNEYTRACESVIEW, new MonoJourneyTracesViewData
			{
				tabIndex = 0
			});
		}
	}

	private void OnWorldLevelTaskNotify(BaseEventContent obj)
	{
		if (obj is WorldLevelTaskNotifyEvt worldLevelTaskNotifyEvt)
		{
			NotifyMissionAcceptedFromMissionManager(worldLevelTaskNotifyEvt.taskId);
		}
	}

	private void NotifyMissionAcceptedFromMissionManager(int missionId)
	{
		if (IsWorldLevelBreakTaskMission(missionId) && _handledWorldLevelBreakTaskMissionIds.Add(missionId) && !HasWorldLevelBreakTaskHudTipPendingOrShowing())
		{
			_hasPendingWorldLevelBreakTaskHudTip = true;
		}
	}

	private bool IsWorldLevelBreakTaskMission(int missionId)
	{
		if (!WorldLevelBreakTaskList.Contains(missionId))
		{
			return false;
		}
		if (!RuntimeConfigs.data.missionBases.TryGetValue(missionId, out var value))
		{
			return false;
		}
		return !value.isHidden;
	}

	private bool HasWorldLevelBreakTaskHudTipPendingOrShowing()
	{
		if (_hasPendingWorldLevelBreakTaskHudTip)
		{
			return true;
		}
		if (!Model<BattleMainModel>.HasInstance() || Singleton<NewUIManager>.instance == null)
		{
			return false;
		}
		MonoBattleMainBaseView monoBattleMainBaseView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_BATTLEMAIN) as MonoBattleMainBaseView;
		if (monoBattleMainBaseView?.worldLevelBreakTaskTips != null && monoBattleMainBaseView.worldLevelBreakTaskTips.gameObject.activeInHierarchy)
		{
			return true;
		}
		UIQueueDisplayManager hudCpQueueManager = Model<BattleMainModel>.Interface.HudCpQueueManager;
		if (hudCpQueueManager == null)
		{
			return false;
		}
		UIPositionQueue queue = hudCpQueueManager.GetQueue(UIPosition.Top);
		HudCpQueueItem obj = ((queue != null && queue.PendingCount > 0) ? queue.GetQueueHead() : null);
		if (obj == null)
		{
			return false;
		}
		return obj.HudComponentType == HudComponentType.WorldLevelBreakTaskTips;
	}

	public void TryEnqueuePendingWorldLevelBreakTaskHudTip()
	{
		if (_hasPendingWorldLevelBreakTaskHudTip)
		{
			MonoBattleMainBaseView monoBattleMainBaseView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_BATTLEMAIN) as MonoBattleMainBaseView;
			if (monoBattleMainBaseView != null && Model<BattleMainModel>.HasInstance() && Model<BattleMainModel>.Interface.HudCpQueueManager != null && monoBattleMainBaseView.CanShowHudComponentUIFromQueue())
			{
				_hasPendingWorldLevelBreakTaskHudTip = false;
				EnqueueWorldLevelBreakTaskHudTip();
			}
		}
	}

	private void EnqueueWorldLevelBreakTaskHudTip()
	{
		OnHudCpEnqueue evt = Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
		evt.position = UIPosition.Top;
		evt.type = HudComponentType.WorldLevelBreakTaskTips;
		evt.timeOutDuration = 15f;
		evt.priorityInQueue = 2;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
