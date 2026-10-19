using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.LocalizationExtension;
using ACT.Model;
using ACT.RichText;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Model.PowerModel;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoRaidView : BaseUIView<RaidViewInputController>
{
	[SerializeField]
	private Image _bg;

	[SerializeField]
	private LocalizeStringEvent _backName;

	[Header("左侧列表")]
	[SerializeField]
	private LoopScrollRect _loopScrollRect;

	[Header("右侧顶部")]
	[SerializeField]
	private PowerBar _powerBar;

	[SerializeField]
	private TextMeshProUGUI doubleRewardText;

	[Header("右侧中间")]
	[SerializeField]
	private CommonSubWorldEntranceTitle _title;

	[SerializeField]
	private CommonSubWorldEntranceDescription _descrption;

	[SerializeField]
	private CommonSubWorldEntranceTarget _target;

	[SerializeField]
	private CommonSubWorldEntranceRewards _rewards;

	[Header("右侧底部")]
	public ActButton ConfirmButton;

	[Header("体力消耗相关")]
	public GameObject PowerCost;

	public TextMeshProUGUI PowerCostText;

	[Header("解锁条件相关")]
	public GameObject DisableObj;

	public GameObject LevelActiveLock;

	public GameObject LevelUnActiveLock;

	public LocalizeStringEvent LevelActiveLockTip;

	public LocalizeStringEvent LevelUnActiveLockTip;

	public GameObject PreActiveLock;

	public GameObject PreUnActiveLock;

	public TextMeshProUGUI PreActiveLockTip;

	public TextMeshProUGUI PreUnActiveLockTip;

	[Header("领奖次数相关")]
	public GameObject ReceiveTimes;

	public TextMeshProUGUI LeftTimes;

	public TextMeshProUGUI RightTimes;

	[Header("倍率相关")]
	public LocalizeTMP_Dropdown RateDropdown;

	public GameObject RateDropdownNew;

	[Header("体力颜色")]
	public Color extraEnoughNormal;

	public Color extraNotEnoughNormal;

	[Header("免费相关")]
	[SerializeField]
	private GameObject _freeTips;

	public GameObject GamepadTipsRoot;

	public Dictionary<RaidViewControlType, List<GameObject>> ControlDownPromts;

	public Dictionary<RaidViewControlType, List<GameObject>> ControlPromts;

	public ViewControlRoot ViewControlRoot;

	public Dictionary<RaidViewControlType, ViewControlLayer> ControlLayerDic;

	public int curSelectRaidId = -1;

	private int m_raidEntranceId;

	private RaidEntranceData m_enterInfo;

	private List<ACT.Config.Raid> m_raidInfos;

	private int m_initIndex = -1;

	private int currIndex = -1;

	private int allPowerCost;

	private List<GameObject> m_rewardItems;

	private bool DropDownIsShow;

	private int m_multiple;

	private bool m_isEnteringTrialRaid;

	public CommonSubWorldEntranceItem lastSelectRaidItem;

	private int currentSelectDropdownIndex = -1;

	private StringBuilder _sb;

	private List<ItemKv> enemyData = new List<ItemKv>();

	private int _recommendLevel = -1;

	private RaidViewControlType ControlType
	{
		get
		{
			return GetController().ControlType;
		}
		set
		{
			GetController().ControlType = value;
		}
	}

	public ItemKv GetEnemyInfo(int index)
	{
		return enemyData[index];
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Power_Refresh, OnPowerRefresh);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Power_Refresh, OnPowerRefresh);
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
		if (m_initIndex >= 0 && m_raidInfos != null && m_initIndex < m_raidInfos.Count)
		{
			_loopScrollRect.ScrollToCellWithinTime(m_initIndex, 0.5f);
		}
	}

	protected override void Init()
	{
		base.Init();
		m_multiple = G.localPlayer.RaidMultiple;
		m_raidInfos = ListPool<ACT.Config.Raid>.Get();
		m_rewardItems = ListPool<GameObject>.Get();
		m_raidEntranceId = ((uiViewData != null && uiViewData is MonoRaidViewData monoRaidViewData) ? monoRaidViewData.RaidEntranceId : 0);
		Model<RaidModel>.Interface.CostRate = 1;
		RefreshUI();
	}

	protected override void ReInit()
	{
		base.ReInit();
		m_raidEntranceId = ((uiViewData != null && uiViewData is MonoRaidViewData monoRaidViewData) ? monoRaidViewData.RaidEntranceId : 0);
		Model<RaidModel>.Interface.CostRate = 1;
		RefreshUI();
		PlayItemAnimation();
	}

	protected override void UnInit()
	{
		base.UnInit();
		for (int num = m_rewardItems.Count - 1; num >= 0; num--)
		{
			UnityEngine.Object.Destroy(m_rewardItems[num]);
		}
		lastSelectRaidItem = null;
		curSelectRaidId = -1;
		currIndex = -1;
		ListPool<ACT.Config.Raid>.Release(m_raidInfos);
		ListPool<GameObject>.Release(m_rewardItems);
	}

	private void OnPowerRefresh(BaseEventContent baseEventContent)
	{
		SetPowerCostColor();
	}

	public void OnClose()
	{
		if (uiViewData is MonoRaidViewData { OnClose: { } action })
		{
			action();
		}
		Close();
	}

	public void OnClickConfirmBtn()
	{
		if (!TryOpenRaidDoublePopup())
		{
			ConfirmEnterRaid();
		}
	}

	private bool TryOpenRaidDoublePopup()
	{
		int doubleDungeonActivityId = Model<ActivityCenterModel>.Interface.GetDoubleDungeonActivityId();
		if (!IsCurrentRaidDoubleRewardType(doubleDungeonActivityId))
		{
			return false;
		}
		(int, int) todayLeftDoubleRewardCount = Model<ActivityCenterModel>.Interface.GetTodayLeftDoubleRewardCount(doubleDungeonActivityId);
		if (todayLeftDoubleRewardCount.Item1 <= 0)
		{
			return false;
		}
		RaidTypeData raidTypeData = GameUtility.GetRaidTypeData(curSelectRaidId);
		bool flag = IsCurrentRaidFirstFree();
		int num = Mathf.Max(1, Model<RaidModel>.Interface.CostRate);
		int powerCost = 0;
		List<ItemKv> list = raidTypeData?.cost;
		if (list != null && list.Count > 0)
		{
			powerCost = raidTypeData.cost[0].count * num;
		}
		int num2 = Mathf.Min(num, todayLeftDoubleRewardCount.Item1);
		if (flag)
		{
			OpenRaidDoublePopup(todayLeftDoubleRewardCount.Item1, todayLeftDoubleRewardCount.Item2, 0, num + num2, num2);
			return true;
		}
		if (m_enterInfo != null && m_enterInfo.cost.Count > 0 && Model<PowerModel>.Interface.PowerCount >= m_enterInfo.cost[0].count * Model<RaidModel>.Interface.CostRate)
		{
			OpenRaidDoublePopup(todayLeftDoubleRewardCount.Item1, todayLeftDoubleRewardCount.Item2, powerCost, num + num2, num2);
			return true;
		}
		return false;
	}

	private void OpenRaidDoublePopup(int leftCount, int totalCount, int powerCost, int rewardCount, int doubleRewardCost)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPRAIDDOUBLE, new PopupRaidDoubleViewData
		{
			LeftDoubleRewardCount = leftCount,
			TotalDoubleRewardCount = totalCount,
			PowerCost = powerCost,
			RewardCount = rewardCount,
			DoubleRewardCost = doubleRewardCost,
			OnConfirm = ConfirmEnterRaid
		});
	}

	private void ConfirmEnterRaid()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Instance/Enter");
		if (m_enterInfo.raidType == 8)
		{
			OnRaidBossClickBtn();
		}
		else
		{
			RaidBtn();
		}
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.HandBookEnterRaid);
	}

	private void RaidBtn()
	{
		RaidTypeData raidTypeData = GameUtility.GetRaidTypeData(curSelectRaidId);
		ACT.Config.Raid raid = RuntimeConfigs.data.raids[curSelectRaidId];
		RaidEntranceData raidEntranceData = RuntimeConfigs.data.raidEntranceDatas[raid.belongEntranceData];
		ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(curSelectRaidId);
		if (raidTypeData.cycleType != 0)
		{
			if (GetLeftTimesByTypeId(GetTypeId()) > 0 || (raidEntranceData.isFirstFree && (raidInfo == null || !raidInfo.FirstRewardDone)))
			{
				OpenTeamView();
				return;
			}
			if (raidEntranceData.isExperience)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANELRAID, new TextPanelRaidView.TextPanelRaidParam
				{
					titleId = 63,
					commonId = 740,
					OnConfirm = OpenTeamView,
					CancelCommonId = 14,
					ConfirmCommonId = 13
				});
				return;
			}
		}
		if (raidEntranceData.cost.Count > 0)
		{
			if (Model<PowerModel>.Interface.PowerCount >= raidEntranceData.cost[0].count * Model<RaidModel>.Interface.CostRate)
			{
				OpenTeamView();
			}
			else if (raidEntranceData.isExperience)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANELRAID, new TextPanelRaidView.TextPanelRaidParam
				{
					titleId = 483,
					commonId = 1609,
					OnConfirm = OpenTeamView,
					CancelCommonId = 14,
					ConfirmCommonId = 13
				});
			}
			else
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ADDPOWER, new TextPanel.Param());
			}
		}
		else
		{
			OpenTeamView();
		}
	}

	private void OpenTeamView()
	{
		if (RuntimeConfigs.data.raids.TryGetValue(curSelectRaidId, out var value))
		{
			int[] tryRole = value.tryRole;
			if (tryRole != null && tryRole.Length > 0)
			{
				EnterTrialRaid();
				return;
			}
		}
		TeamViewData uiData = new TeamViewData
		{
			isRaidTeam = true,
			enterId = m_raidEntranceId,
			raidId = curSelectRaidId,
			multiple = m_multiple,
			source = TeamProfileSource.Raid,
			subWorldCharacters = G.localPlayer.teamInfo.PresetTeams[G.localPlayer.teamInfo.MainTeamIdx].CharacterIds.ToArray(),
			RecommendLevel = _recommendLevel
		};
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEAM, uiData);
	}

	private void EnterTrialRaid()
	{
		if (m_isEnteringTrialRaid)
		{
			return;
		}
		m_isEnteringTrialRaid = true;
		MonoECS.instance.SyncGameInfos();
		TeamUsage raidTrialTeamUsage = Model<RaidModel>.Interface.GetRaidTrialTeamUsage(curSelectRaidId);
		G.service.RaidEnterInfo(curSelectRaidId, raidTrialTeamUsage, async (bool success) =>
		{
			try
			{
				if (success)
				{
					await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Raid);
				}
			}
			finally
			{
				m_isEnteringTrialRaid = false;
			}
		});
	}

	public void OnRaidBossClickBtn()
	{
		if (UIController.State == UIState.Opened)
		{
			TeamViewData viewParam = new TeamViewData
			{
				isRaidTeam = true,
				enterId = m_raidEntranceId,
				raidId = curSelectRaidId,
				source = TeamProfileSource.Raid,
				subWorldCharacters = G.localPlayer.teamInfo.PresetTeams[G.localPlayer.teamInfo.MainTeamIdx].CharacterIds.ToArray(),
				RecommendLevel = _recommendLevel
			};
			OpenBossChallenge(GameUtility.GetRaidBossChallengePoint(curSelectRaidId), viewParam);
		}
	}

	private void OpenBossChallenge(int id, TeamViewData viewParam)
	{
		int num = ((m_enterInfo.cost.Count > 0) ? (m_enterInfo.cost[0].count * Model<RaidModel>.Interface.CostRate) : 0);
		if (Model<PowerModel>.Interface.PowerCount >= num || IsCurrentRaidFirstFree())
		{
			OpenBossChallengeTeamView();
			return;
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANELRAID, new TextPanelRaidView.TextPanelRaidParam
		{
			texts = new string[1] { num.ToString() },
			OnConfirm = OpenBossChallengeTeamView,
			OnCancel = () =>
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ADDPOWER, new TextPanel.Param());
			},
			titleId = 63,
			commonId = 695,
			CancelCommonId = 2204,
			ConfirmCommonId = 2205
		});
		void OpenBossChallengeTeamView()
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEAM, viewParam);
		}
	}

	public int GetEntranceID()
	{
		return m_raidEntranceId;
	}

	public void OnRaidClick(CommonSubWorldEntranceItem raidItem, int raidIndex)
	{
		if (!(raidItem == null) && raidIndex >= 0 && raidIndex < m_raidInfos.Count && curSelectRaidId != m_raidInfos[raidIndex].id)
		{
			if (lastSelectRaidItem != null)
			{
				lastSelectRaidItem.SetSelect(value: false);
			}
			currIndex = raidIndex;
			lastSelectRaidItem = raidItem;
			raidItem.SetSelect(value: true);
			curSelectRaidId = m_raidInfos[raidIndex].id;
			betterAnimation.StopAnimation();
			betterAnimation.GetSequence("SwitchHide").OnComplete((AnimationBuilder _) =>
			{
				RefreshRight(m_raidInfos[raidIndex]);
				betterAnimation.GetSequence("SwitchShow").Play();
			}).Play();
		}
	}

	private void RefreshUI()
	{
		if (RefreshLeft())
		{
			RefreshRight(m_raidInfos[m_initIndex]);
			RefreshDoubleRewardText();
		}
	}

	private void RefreshDoubleRewardText()
	{
		int doubleDungeonActivityId = Model<ActivityCenterModel>.Interface.GetDoubleDungeonActivityId();
		if (!IsCurrentRaidDoubleRewardType(doubleDungeonActivityId))
		{
			doubleRewardText.gameObject.SetActive(value: false);
			return;
		}
		(int, int) todayLeftDoubleRewardCount = Model<ActivityCenterModel>.Interface.GetTodayLeftDoubleRewardCount(doubleDungeonActivityId);
		if (todayLeftDoubleRewardCount.Item1 <= 0)
		{
			doubleRewardText.gameObject.SetActive(value: false);
			return;
		}
		doubleRewardText.gameObject.SetActive(value: true);
		_sb = new StringBuilder();
		_sb.Clear();
		_sb.Append(LocalizationUtility.GetLocalizeString("Common", 2688));
		_sb.Append(": ");
		_sb.Append(todayLeftDoubleRewardCount.Item1);
		_sb.Append("/");
		_sb.Append(todayLeftDoubleRewardCount.Item2);
		doubleRewardText.gameObject.GetComponent<TextMeshProUGUI>().text = _sb.ToString();
	}

	private bool RefreshLeft()
	{
		m_initIndex = 0;
		m_raidInfos.Clear();
		lastSelectRaidItem = null;
		int num = ((uiViewData != null && uiViewData is MonoRaidViewData monoRaidViewData) ? monoRaidViewData.RaidId : 0);
		if (!RuntimeConfigs.data.raidEntranceDatas.TryGetValue(m_raidEntranceId, out m_enterInfo))
		{
			_loopScrollRect.totalCount = 0;
			_loopScrollRect.RefillCells();
			curSelectRaidId = -1;
			currIndex = -1;
			return false;
		}
		for (int i = 0; i < m_enterInfo.raidId.Length; i++)
		{
			int num2 = m_enterInfo.raidId[i];
			if (!RuntimeConfigs.data.raids.TryGetValue(num2, out var value))
			{
				continue;
			}
			m_raidInfos.Add(value);
			if (num > 0)
			{
				if (num == num2)
				{
					m_initIndex = i;
				}
			}
			else if (Model<RaidModel>.Interface.IsUnlock(value))
			{
				m_initIndex = i;
			}
		}
		if (m_raidInfos.Count <= 0)
		{
			_loopScrollRect.totalCount = 0;
			_loopScrollRect.RefillCells();
			curSelectRaidId = -1;
			currIndex = -1;
			return false;
		}
		m_initIndex = Mathf.Clamp(m_initIndex, 0, m_raidInfos.Count - 1);
		currIndex = m_initIndex;
		curSelectRaidId = m_raidInfos[m_initIndex].id;
		_loopScrollRect.ClearCells();
		_loopScrollRect.OnItemLoad.RemoveAllListeners();
		_loopScrollRect.OnItemLoad.AddListener(OnItemLoad);
		_loopScrollRect.totalCount = m_raidInfos.Count;
		_loopScrollRect.RefillCells();
		if (RuntimeConfigs.data.raidTypeDess.TryGetValue(m_enterInfo.raidType, out var value2))
		{
			_backName.StringReference.TableReference = LocalizationUtility.localizeTableName_shortcommon;
			_backName.StringReference.TableEntryReference = value2.typeDes;
		}
		RefreshDefaultSelectAfterFrame();
		return true;
	}

	private void OnItemLoad(ILoopScrollDataSource iSource)
	{
		CommonSubWorldEntranceItem entranceItem = iSource as CommonSubWorldEntranceItem;
		if (!(entranceItem == null))
		{
			int index = iSource.GetIndex();
			ACT.Config.Raid raid = m_raidInfos[index];
			ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(raid.id);
			List<int> list = new List<int>();
			for (int i = 0; i < raid.firstReward.Count; i++)
			{
				list.Add(raid.firstReward[i].id);
			}
			entranceItem.RefreshUI(index, raid.raidName, list, raidInfo?.Target, Model<RaidModel>.Interface.IsUnlock(raid), (int idx) =>
			{
				OnRaidClick(entranceItem, idx);
			});
			entranceItem.SetSelect(curSelectRaidId == raid.id);
			if (curSelectRaidId == raid.id)
			{
				lastSelectRaidItem = entranceItem;
			}
			entranceItem.SetFirsetFreeTag(IsRaidFirstFree(raid));
		}
	}

	private async void RefreshDefaultSelectAfterFrame()
	{
		await UniTask.DelayFrame(1);
		if (m_raidInfos != null && m_initIndex >= 0 && m_initIndex < m_raidInfos.Count)
		{
			curSelectRaidId = m_raidInfos[m_initIndex].id;
			CommonSubWorldEntranceItem commonSubWorldEntranceItem = _loopScrollRect.GetItem(m_initIndex) as CommonSubWorldEntranceItem;
			if (commonSubWorldEntranceItem != null && ControlLayerDic != null && ControlLayerDic.TryGetValue(RaidViewControlType.Main, out var value))
			{
				value.DefaultSelect = commonSubWorldEntranceItem.SelectableEx;
			}
		}
	}

	private void RefreshRight(ACT.Config.Raid raidConfig)
	{
		ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(raidConfig.id);
		List<int> list = new List<int>();
		List<ItemUnifierProxy> list2 = new List<ItemUnifierProxy>();
		List<ItemUnifierProxy> unCompleteRewards = new List<ItemUnifierProxy>();
		bool value = default;
		for (int i = 0; i < raidConfig.firstReward.Count; i++)
		{
			int id = raidConfig.firstReward[i].id;
			int count = raidConfig.firstReward[i].count;
			bool flag = (raidInfo != null && raidInfo.Target != null && raidInfo.Target.TargetReward.TryGetValue(id, out value)) & value;
			list.Add(id);
			Collection data = CoreUtils.GetData(count, RuntimeConfigs.data.collections);
			if (data == null)
			{
				continue;
			}
			foreach (ItemKv item3 in data.certain)
			{
				ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(new Item
				{
					Id = item3.id,
					Count = item3.count
				});
				itemUnifierProxy.RewardTag = (UniversalItemTag)(i + 2);
				if (flag)
				{
					list2.Add(itemUnifierProxy);
				}
				else
				{
					unCompleteRewards.Add(itemUnifierProxy);
				}
			}
		}
		for (int j = 0; j < raidConfig.certain.Count; j++)
		{
			ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get(new Item
			{
				Id = raidConfig.certain[j].id,
				Count = raidConfig.certain[j].count
			});
			unCompleteRewards.Add(item);
		}
		for (int k = 0; k < raidConfig.randomReward.Count; k++)
		{
			ItemUnifierProxy item2 = ItemUnifierProxy.ItemUnifierPool.Get(new Item
			{
				Id = raidConfig.randomReward[k].id,
				Count = raidConfig.randomReward[k].weight,
				haveRandom = true
			});
			unCompleteRewards.Add(item2);
		}
		list2.Sort(SortUtility.SortItemUnifierProxyPopReward);
		unCompleteRewards.Sort(SortUtility.SortItemUnifierProxyPopReward);
		List<ItemUnifierProxy> list3 = new List<ItemUnifierProxy>(unCompleteRewards.Count + list2.Count);
		list3.AddRange(unCompleteRewards);
		list3.AddRange(list2);
		bool isPerfect = raidInfo != null && raidInfo.Target != null && raidInfo.Target.IsPerfect;
		int raidType = Model<RaidModel>.Interface.GetRaidType(raidConfig.id);
		int recommendLevel = raidConfig.recommendTeamLevel;
		if (RuntimeConfigs.data.raidTypeDess.TryGetValue(raidType, out var value2) && value2.showRecommendLevel)
		{
			recommendLevel = -1;
		}
		_recommendLevel = recommendLevel;
		_title.RefreshUI(raidConfig.raidName, raidInfo != null, _recommendLevel, raidInfo?.FastestClearTime ?? (-1), isPerfect);
		_descrption.RefreshUI(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, raidConfig.ruleDescId));
		_target.RefreshUI(list, raidInfo?.Target);
		_rewards.gameObject.SetActive(list3.Count > 0);
		_rewards.RefreshUI(list3, Station);
		int doubleDungeonActivityId = Model<ActivityCenterModel>.Interface.GetDoubleDungeonActivityId();
		bool flag2 = IsCurrentRaidDoubleRewardType(doubleDungeonActivityId);
		if (flag2)
		{
			flag2 = Model<ActivityCenterModel>.Interface.GetTodayLeftDoubleRewardCount(doubleDungeonActivityId).Item1 > 0;
		}
		_rewards.UpdateDoubleTagVisible(flag2);
		_rewards.OnItemShowAction = null;
		_rewards.OnItemShowAction = (ItemUIComponentBase itemUIComponentBase) =>
		{
			Maybe maybe = raidConfig.randomReward.Find((Maybe x) => x.id == itemUIComponentBase.ItemUnifier.Id);
			if (maybe != null)
			{
				itemUIComponentBase.SetData(itemUIComponentBase.ItemUnifier, maybe.count, ItemUIComponentBase.InitType.WorldSettlementRewardItem, ItemUIComponentBase.ItemCountShowType.ShowWithRandom);
				itemUIComponentBase.UpdatePerformance();
			}
			itemUIComponentBase.IsComplete = itemUIComponentBase.Index >= unCompleteRewards.Count;
		};
		RefreshRightBottom(raidConfig);
		int belongEntranceData = raidConfig.belongEntranceData;
		RaidTypeData raidTypeConfig = Model<RaidModel>.Interface.GetRaidTypeConfig(raidConfig.id);
		if (belongEntranceData <= 0)
		{
			return;
		}
		try
		{
			string empty = string.Empty;
			empty = ((raidTypeConfig.raidType != 5) ? ("Sprite/" + belongEntranceData) : ("Sprite/" + raidTypeConfig.raidEntranceId[0]));
			AssetLoadHandle handle = AssetStationManager.BattleStation.Load<Sprite>(empty);
			if (handle.Result == null)
			{
				Station.Release(handle);
				return;
			}
			Sprite sprite = handle.Result as Sprite;
			_bg.sprite = sprite;
		}
		catch (Exception message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError(message);
			}
		}
	}

	private void RefreshRightBottom(ACT.Config.Raid raidConfig)
	{
		RaidTypeData raidTypeData = GameUtility.GetRaidTypeData(raidConfig.id);
		bool flag = Model<RaidModel>.Interface.IsUnlock(raidConfig);
		ConfirmButton.gameObject.SetActive(flag);
		RefreshRateDropdown(raidConfig);
		bool flag2 = IsRaidFirstFree(raidConfig);
		RefreshFreeTips(raidTypeData);
		_freeTips.SetActive(flag2);
		if (raidTypeData.cost != null && raidTypeData.cost.Count > 0 && !flag2)
		{
			PowerCost.gameObject.SetActive(flag);
			_powerBar.gameObject.SetActive(flag);
			allPowerCost = raidTypeData.cost[0].count * Model<RaidModel>.Interface.CostRate;
			PowerCostText.SetText("{0:0}", allPowerCost);
			SetPowerCostColor();
		}
		else
		{
			PowerCost.gameObject.SetActive(value: false);
			_powerBar.gameObject.SetActive(value: false);
		}
		DisableObj.SetActive(!flag);
		if (!flag)
		{
			SetLockState(raidConfig);
		}
		if (((raidTypeData.cycleType != 0) & flag) && raidTypeData.cycleParm.Length >= 2 && !flag2)
		{
			int leftTimesByTypeId = GetLeftTimesByTypeId(GetTypeId());
			LeftTimes.color = ((leftTimesByTypeId > 0) ? extraEnoughNormal : extraNotEnoughNormal);
			LeftTimes.SetText("{0:0}", leftTimesByTypeId);
			RightTimes.SetText("{0:0}", raidTypeData.cycleParm[1]);
			ReceiveTimes.SetActive(value: true);
		}
		else
		{
			ReceiveTimes.SetActive(value: false);
		}
	}

	private void SetPowerCostColor()
	{
		PowerCostText.color = ((allPowerCost <= Model<PowerModel>.Interface.PowerCount) ? extraEnoughNormal : extraNotEnoughNormal);
	}

	private void SetLockState(ACT.Config.Raid raidConfig)
	{
		int unlockCondition = raidConfig.unlockCondition;
		bool flag = unlockCondition <= 0 || Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(unlockCondition);
		LevelActiveLock.SetActive(flag);
		LevelUnActiveLock.SetActive(!flag);
		if (unlockCondition > 0)
		{
			MissionGroup missionGroup = RuntimeConfigs.data.missionGroups[unlockCondition];
			ACT.Config.Mission mission = RuntimeConfigs.data.missions[missionGroup.missionId[0]];
			if (flag)
			{
				LevelActiveLockTip.GetComponent<TextMeshProUGUI>().text = CustomTagParser.ReplacePreconditionText(mission, mission.number, mission.param);
			}
			else
			{
				LevelUnActiveLockTip.GetComponent<TextMeshProUGUI>().text = CustomTagParser.ReplacePreconditionText(mission, mission.number, mission.param);
			}
		}
		ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(raidConfig.frontCondition);
		bool flag2 = raidConfig.frontCondition <= 0 || (raidInfo != null && raidInfo.CleanNum > 0);
		PreActiveLock.SetActive(flag2);
		PreUnActiveLock.SetActive(!flag2);
		if (flag2)
		{
			int key = ((raidConfig.frontCondition <= 0) ? raidConfig.id : raidConfig.frontCondition);
			PreActiveLockTip.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, RuntimeConfigs.data.raids[key].raidName);
		}
		else
		{
			PreUnActiveLockTip.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, RuntimeConfigs.data.raids[raidConfig.frontCondition].raidName);
		}
	}

	private int GetTypeId()
	{
		foreach (KeyValuePair<int, RaidTypeData> raidTypeData in RuntimeConfigs.data.raidTypeDatas)
		{
			if (raidTypeData.Value.raidEntranceId.Contains(m_raidEntranceId))
			{
				return raidTypeData.Key;
			}
		}
		return 0;
	}

	private int GetLeftTimesByTypeId(int typeId)
	{
		if (!RuntimeConfigs.data.raidTypeDatas.TryGetValue(typeId, out var value) || value.cycleParm.Length < 2)
		{
			return 0;
		}
		int num = 0;
		int[] raidEntranceId = value.raidEntranceId;
		foreach (int entranceId in raidEntranceId)
		{
			num += GetUsedTimesByEnteranceId(entranceId);
		}
		int b = value.cycleParm[1] - num;
		return Mathf.Max(0, b);
	}

	private int GetUsedTimesByEnteranceId(int entranceId)
	{
		if (!RuntimeConfigs.data.raidEntranceDatas.TryGetValue(entranceId, out var value))
		{
			return 0;
		}
		int num = 0;
		int[] raidId = value.raidId;
		foreach (int raidId2 in raidId)
		{
			ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(raidId2);
			if (raidInfo != null)
			{
				num += raidInfo.TakeRewardCount;
			}
		}
		return num;
	}

	private void RefreshRateDropdown(ACT.Config.Raid raidInfo)
	{
		if (!Model<RaidModel>.Interface.IsUnlock(raidInfo) || m_enterInfo.defaultZoomType.Length == 0)
		{
			RateDropdown.ClearOptions();
			RateDropdown.gameObject.SetActive(value: false);
			RateDropdownNew.SetActive(value: false);
			currentSelectDropdownIndex = -1;
			Model<RaidModel>.Interface.CostRate = 1;
			m_multiple = Model<RaidModel>.Interface.CostRate;
			return;
		}
		List<LocalizeTMP_Dropdown.OptionData> list = new List<LocalizeTMP_Dropdown.OptionData>();
		for (int num = m_enterInfo.defaultZoomType.Length - 1; num >= 0; num--)
		{
			list.Add(new LocalizeTMP_Dropdown.OptionData(m_enterInfo.defaultZoomType[num].ToString()));
		}
		RateDropdown.gameObject.SetActive(value: true);
		RateDropdown.onValueChanged.RemoveAllListeners();
		RateDropdown.onValueChanged.AddListener(OnRateDropdownChanged);
		RateDropdown.onAddItem -= OnRateDropdownAddItem;
		RateDropdown.onAddItem += OnRateDropdownAddItem;
		RateDropdown.onShow.RemoveAllListeners();
		RateDropdown.onShow.AddListener(OnRateDropdownShow);
		RateDropdown.onHide.RemoveAllListeners();
		RateDropdown.onHide.AddListener(OnRateDropdownHide);
		RateDropdown.ClearOptions();
		RateDropdown.AddOptions(list);
		RateDropdown.SetValueWithoutNotify(list.Count - 1);
		currentSelectDropdownIndex = m_enterInfo.defaultZoomType.Length - RateDropdown.value - 1;
		RateDropdownNew.SetActive(Model<RaidModel>.Interface.GetRaidRateDropdownRedState(curSelectRaidId));
		Model<RaidModel>.Interface.CostRate = m_enterInfo.defaultZoomType[currentSelectDropdownIndex];
		m_multiple = Model<RaidModel>.Interface.CostRate;
	}

	private void OnRateDropdownChanged(int value)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Instance/Click");
		int num = m_enterInfo.defaultZoomType.Length - value - 1;
		if (num < 0 || num >= m_enterInfo.defaultZoomType.Length || currentSelectDropdownIndex == num)
		{
			return;
		}
		int key = m_enterInfo.defaultZoomType[num];
		if (!RuntimeConfigs.data.rewardTimess.TryGetValue(key, out var value2))
		{
			RateDropdown.SetValueWithoutNotify(GetDropdownValueByRateIndex(currentSelectDropdownIndex));
			return;
		}
		int num2 = 0;
		int condition = value2.condition;
		ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(curSelectRaidId);
		if (raidInfo != null && raidInfo.Target != null && raidInfo.Target.TargetReward != null)
		{
			foreach (KeyValuePair<int, bool> item in raidInfo.Target.TargetReward)
			{
				if (item.Value)
				{
					num2++;
				}
			}
		}
		if (num2 < condition)
		{
			RateDropdown.SetValueWithoutNotify(GetDropdownValueByRateIndex(currentSelectDropdownIndex));
			IList<object> list = new List<object>();
			list.Add(condition);
			GameUtility.OpenToolTip(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2834, list));
			return;
		}
		currentSelectDropdownIndex = num;
		Model<RaidModel>.Interface.CostRate = m_enterInfo.defaultZoomType[currentSelectDropdownIndex];
		m_multiple = Model<RaidModel>.Interface.CostRate;
		RaidTypeData raidTypeData = GameUtility.GetRaidTypeData(curSelectRaidId);
		if (raidTypeData.cost != null && raidTypeData.cost.Count > 0)
		{
			allPowerCost = raidTypeData.cost[0].count * Model<RaidModel>.Interface.CostRate;
			PowerCostText.SetText("{0:0}", allPowerCost);
			SetPowerCostColor();
		}
	}

	private void OnRateDropdownAddItem(LocalizeTMP_Dropdown.OptionData optionData, LocalizeTMP_Dropdown.DropdownItem dropdownItem)
	{
		if (!int.TryParse(optionData.CommonText, out var result))
		{
			return;
		}
		int rateIndex = GetRateIndex(result);
		if (rateIndex < 0 || !RuntimeConfigs.data.rewardTimess.TryGetValue(result, out var value))
		{
			return;
		}
		bool isNew = false;
		if (G.localPlayer.redPoints.RaidRate.TryGetValue(curSelectRaidId, out var value2) && (value2.RateInfo.TryGetValue(result, out var value3) & value3))
		{
			isNew = true;
		}
		int num = 0;
		int condition = value.condition;
		ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(curSelectRaidId);
		if (raidInfo != null && raidInfo.Target != null && raidInfo.Target.TargetReward != null)
		{
			foreach (KeyValuePair<int, bool> item in raidInfo.Target.TargetReward)
			{
				if (item.Value)
				{
					num++;
				}
			}
		}
		RaidRateItem component = dropdownItem.GetComponent<RaidRateItem>();
		bool flag = num >= condition;
		component.RefreshUI(totalStarCount: RuntimeConfigs.data.raids[curSelectRaidId].firstReward.Count, showDoubleRewardTag: flag && ShouldShowRaidRateDoubleTag(result), isUnlock: flag, isSelect: RateDropdown.value == GetDropdownValueByRateIndex(rateIndex), isNew: isNew, requiredStarCount: condition);
	}

	private int GetRateIndex(int rateMultiplier)
	{
		if (m_enterInfo?.defaultZoomType == null)
		{
			return -1;
		}
		for (int i = 0; i < m_enterInfo.defaultZoomType.Length; i++)
		{
			if (m_enterInfo.defaultZoomType[i] == rateMultiplier)
			{
				return i;
			}
		}
		return -1;
	}

	private int GetDropdownValueByRateIndex(int rateIndex)
	{
		if (m_enterInfo?.defaultZoomType == null || rateIndex < 0)
		{
			return 0;
		}
		return m_enterInfo.defaultZoomType.Length - rateIndex - 1;
	}

	private bool ShouldShowRaidRateDoubleTag(int rateMultiplier)
	{
		int doubleDungeonActivityId = Model<ActivityCenterModel>.Interface.GetDoubleDungeonActivityId();
		if (!IsCurrentRaidDoubleRewardType(doubleDungeonActivityId))
		{
			return false;
		}
		(int, int) todayLeftDoubleRewardCount = Model<ActivityCenterModel>.Interface.GetTodayLeftDoubleRewardCount(doubleDungeonActivityId);
		if (todayLeftDoubleRewardCount.Item1 > 0)
		{
			return rateMultiplier <= todayLeftDoubleRewardCount.Item1;
		}
		return false;
	}

	private bool IsCurrentRaidFirstFree()
	{
		if (!RuntimeConfigs.data.raids.TryGetValue(curSelectRaidId, out var value))
		{
			return false;
		}
		return IsRaidFirstFree(value);
	}

	private void RefreshFreeTips(RaidTypeData raidTypeData)
	{
		LocalizeStringEvent component = _freeTips.GetComponent<LocalizeStringEvent>();
		if (!(component == null))
		{
			LocalizationCommonData.CommonString commonString = ((raidTypeData.raidType == 3) ? LocalizationCommonData.CommonString.WeeklyFirstFreeTips : LocalizationCommonData.CommonString.BossFirstFreeTips);
			component.StringReference.TableReference = "Common";
			component.StringReference.TableEntryReference = commonString;
			component.RefreshString();
		}
	}

	private bool IsRaidFirstFree(ACT.Config.Raid raidConfig)
	{
		if (raidConfig == null)
		{
			return false;
		}
		RaidEntranceData data = CoreUtils.GetData(raidConfig.belongEntranceData, RuntimeConfigs.data.raidEntranceDatas);
		bool flag = Model<RaidModel>.Interface.IsUnlock(raidConfig);
		ACT.Game.Data.Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(raidConfig.id);
		if ((data?.isFirstFree ?? false) & flag)
		{
			return !(raidInfo?.FirstRewardDone ?? false);
		}
		return false;
	}

	private bool IsCurrentRaidDoubleRewardType(int activityId)
	{
		if (!Model<ActivityCenterModel>.Interface.GetActivityIsOpening(activityId))
		{
			return false;
		}
		List<int> raidTypeList = Model<ActivityCenterModel>.Interface.GetRaidTypeList(activityId);
		int raidTypeByEntranceId = Model<RaidModel>.Interface.GetRaidTypeByEntranceId(m_raidEntranceId);
		return raidTypeList?.Contains(raidTypeByEntranceId) ?? false;
	}

	private void OnRateDropdownShow()
	{
		DropDownIsShow = true;
		RateDropdownNew.SetActive(value: false);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Instance/Expand");
	}

	private void OnRateDropdownHide()
	{
		DropDownIsShow = false;
		if (!G.localPlayer.redPoints.RaidRate.TryGetValue(curSelectRaidId, out var value))
		{
			return;
		}
		RaidRateRedPoint raidRateRedPoint = new RaidRateRedPoint();
		foreach (KeyValuePair<int, bool> item in value.RateInfo)
		{
			if (item.Value)
			{
				G.localPlayer.redPoints.RaidRate[curSelectRaidId].RateInfo[item.Key] = false;
				raidRateRedPoint.RateInfo[item.Key] = false;
			}
		}
		if (raidRateRedPoint.RateInfo != null && raidRateRedPoint.RateInfo.Count > 0)
		{
			RedPoints redPoints = new RedPoints();
			redPoints.RaidRate[curSelectRaidId] = raidRateRedPoint;
			G.service.RefreshRedDot(redPoints, (bool flag) =>
			{
			});
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Instance/Collapse");
	}

	public ACT.Config.Raid GetRaidInfo(int index)
	{
		if (m_raidInfos == null || index < 0 || index >= m_raidInfos.Count)
		{
			return null;
		}
		return m_raidInfos[index];
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Instance/Open_2");
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
		PlayItemAnimation();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	private async void PlayItemAnimation()
	{
		for (int i = 0; i < _loopScrollRect.Children.Count; i++)
		{
			CommonSubWorldEntranceItem component = _loopScrollRect.Children[i].GetComponent<CommonSubWorldEntranceItem>();
			if (!(component == null))
			{
				component.CanvasGroup.alpha = 0f;
			}
		}
		if (_loopScrollRect == null || _loopScrollRect.content == null)
		{
			return;
		}
		for (int j = 0; j < _loopScrollRect.Children.Count; j++)
		{
			CommonSubWorldEntranceItem component2 = _loopScrollRect.Children[j].GetComponent<CommonSubWorldEntranceItem>();
			if (component2 != null)
			{
				component2.CanvasGroup.alpha = 1f;
				component2.PlayAnimation();
			}
			await UniTask.Delay(30);
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		GamepadTipsRoot.SetActive(type == DeviceInputMode.Gamepad);
		if (type != DeviceInputMode.Gamepad)
		{
			if (EventSystemHelper.CurrentSelected != null)
			{
				ItemUIComponentBase component = EventSystemHelper.CurrentSelected.GetComponent<ItemUIComponentBase>();
				if ((bool)component)
				{
					component.SetIsOn(val: false);
				}
			}
		}
		else if (DropDownIsShow)
		{
			ChangeControlType(RaidViewControlType.Multiple);
		}
		else
		{
			if (ControlType == RaidViewControlType.Multiple)
			{
				ControlType = RaidViewControlType.Main;
			}
			ChangeControlType(ControlType);
		}
	}

	public void OnControllerActivate()
	{
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	public async void ChangeControlType(RaidViewControlType controlType)
	{
		await UniTask.DelayFrame(1);
		RaidViewControlType controlType2 = ControlType;
		if (ControlLayerDic == null || !ControlLayerDic.TryGetValue(controlType, out var value))
		{
			return;
		}
		ControlType = controlType;
		value.ReFocus();
		for (int i = 0; i < GamepadTipsRoot.transform.GetChild(0).childCount; i++)
		{
			GamepadTipsRoot.transform.GetChild(0).GetChild(i).gameObject.SetActive(value: false);
		}
		if (ControlDownPromts != null && ControlDownPromts.TryGetValue(controlType, out var value2))
		{
			foreach (GameObject item in value2)
			{
				item.SetActive(value: true);
				LayoutRebuilder.ForceRebuildLayoutImmediate(item.GetComponent<RectTransform>());
			}
		}
		LayoutRebuilder.ForceRebuildLayoutImmediate(GamepadTipsRoot.transform.GetChild(0).GetComponent<RectTransform>());
		if (ControlPromts != null && ControlPromts.TryGetValue(controlType2, out var value3))
		{
			for (int j = 0; j < value3.Count; j++)
			{
				value3[j].SetActive(value: false);
			}
		}
		if (ControlPromts != null && ControlPromts.TryGetValue(controlType, out var value4))
		{
			for (int k = 0; k < value4.Count; k++)
			{
				value4[k].SetActive(value: true);
			}
		}
		if (controlType == RaidViewControlType.Main && EventSystemHelper.CurrentSelected != null)
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			ViewControlRoot.SelectDown();
			break;
		case MoveDirection.Left:
			ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot.SelectRight();
			break;
		}
		if (ControlType == RaidViewControlType.Main && EventSystemHelper.CurrentSelected != null)
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
		}
		else if (ControlType == RaidViewControlType.Reward)
		{
			ItemUIComponentBase itemUIComponentBase = EventSystemHelper.CurrentSelected?.GetComponent<ItemUIComponentBase>();
			if (itemUIComponentBase != null)
			{
				itemUIComponentBase.SetIsOn(val: true);
			}
		}
	}

	public void OnConfirm()
	{
		if (ControlType == RaidViewControlType.Main && ConfirmButton.gameObject.activeSelf && ConfirmButton.IsInteractable())
		{
			OnClickConfirmBtn();
		}
		else if (EventSystemHelper.CurrentSelected != null)
		{
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler.OnSubmit(data);
			});
			if (ControlType == RaidViewControlType.Multiple)
			{
				ChangeControlType(RaidViewControlType.Main);
			}
		}
	}

	public void OnButtonWest()
	{
		_ = ControlType;
	}

	public void OnRightStickPress()
	{
		if (ControlType == RaidViewControlType.Main && _powerBar != null && _powerBar.addPowerBtn != null && _powerBar.addPowerBtn.gameObject.activeSelf && _powerBar.addPowerBtn.IsInteractable())
		{
			_powerBar.addPowerBtn.OnSubmit(null);
		}
	}

	public void OnStart()
	{
		if (ControlType == RaidViewControlType.Main && RateDropdown.gameObject.activeSelf && RateDropdown.IsInteractable())
		{
			RateDropdown.OnSubmit(null);
			ChangeControlType(RaidViewControlType.Multiple);
		}
	}
}
