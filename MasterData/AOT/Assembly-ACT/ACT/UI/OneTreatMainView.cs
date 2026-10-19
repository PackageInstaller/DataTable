using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Net;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using Pb;
using Runtime.UI.CommonComponent;
using Sirenix.Serialization;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class OneTreatMainView : BaseUIView<OneTreatMainInputController>
{
	private enum OneTreatMainSelection
	{
		None,
		Prize,
		TaskButton,
		DrawButton,
		InfoButton
	}

	private readonly struct OneTreatTierDefinition(string tier, int count)
	{
		public readonly string Tier = tier;

		public readonly int Count = count;
	}

	private const int TodayTicketMaxCount = 5;

	private static readonly OneTreatTierDefinition[] TierDefinitions = new OneTreatTierDefinition[6]
	{
		new OneTreatTierDefinition("S", 4),
		new OneTreatTierDefinition("A", 3),
		new OneTreatTierDefinition("B", 5),
		new OneTreatTierDefinition("C", 8),
		new OneTreatTierDefinition("D", 8),
		new OneTreatTierDefinition("E", 12)
	};

	[SerializeField]
	private ActButton backButton;

	[SerializeField]
	private ActButton infoButton;

	[SerializeField]
	private ActButton taskButton;

	[SerializeField]
	private ActButton drawButton;

	[SerializeField]
	private TMP_Text progressText;

	[SerializeField]
	private TMP_Text ticketCountText;

	[SerializeField]
	private CommonCoinComponent ticketCurrency;

	[SerializeField]
	private CommonNumberComponent ticketCurrencyNumber;

	[SerializeField]
	private TMP_Text taskCountLeftText;

	[SerializeField]
	private TMP_Text taskCountRightText;

	[SerializeField]
	private TMP_Text drawButtonText;

	[SerializeField]
	private GameObject allClaimedRoot;

	[SerializeField]
	private GameObject drawRoot;

	[SerializeField]
	private RedDotItem redDotItem;

	private readonly List<OneTreatPrizeInfo> _prizes = new List<OneTreatPrizeInfo>();

	private readonly List<Lottery> _normalLotteries = new List<Lottery>();

	[SerializeField]
	private List<OneTreatPrizeSlotBinding> _prizeSlots = new List<OneTreatPrizeSlotBinding>();

	[SerializeField]
	private List<OneTreatTierRowBinding> _tierRows = new List<OneTreatTierRowBinding>();

	private OneTreatMainViewData m_data;

	private ActivityCenterData _activityCenterData;

	private ActivityData _activityData;

	private OneTreatPrizeInfo _finalPrize;

	[SerializeField]
	private OneTreatPrizeSlotBinding _finalPrizeSlot;

	private int _localTicketCount;

	private int _todayTicketCount;

	private bool _drawRequesting;

	private bool _waitingForDrawResultDisplay;

	private OneTreatMainSelection _selection;

	private int _selectedPrizeIndex = -1;

	private int _topControlIndex = -1;

	public Dictionary<OneTreatMainControllerType, ViewControlLayer> ViewControlLayers;

	[OdinSerialize]
	public Dictionary<OneTreatMainControllerType, List<GameObject>> ViewControlPrompt;

	private OneTreatMainControllerType CurrentControllerType
	{
		get
		{
			if (GetController() != null)
			{
				return GetController().ControllerType;
			}
			return OneTreatMainControllerType.OneTreatMain;
		}
		set
		{
			GetController()?.SetControllerType(value);
		}
	}

	private int ActivityId
	{
		get
		{
			if (m_data != null && m_data.ActivityId > 0)
			{
				return m_data.ActivityId;
			}
			return Model<ActivityCenterModel>.Interface.SelectActivityId;
		}
	}

	private int TotalPrizeCount => GetTotalPrizeCount();

	private int ClaimedPrizeCount => GetClaimedPrizeCount();

	private bool HasClaimedAllPrizes
	{
		get
		{
			if (TotalPrizeCount > 0)
			{
				return ClaimedPrizeCount >= TotalPrizeCount;
			}
			return false;
		}
	}

	protected override void Init()
	{
		base.Init();
		m_data = (uiViewData as OneTreatMainViewData) ?? new OneTreatMainViewData();
		CacheComponents();
		BindButtons();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_UpdateActivity, OnActivityUpdate);
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction += OnTaskProgressChange;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BagItemChange, OnTicketCountChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnTicketCountChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SyncGameInfo, OnTicketCountChanged);
		RefreshActivityData();
		BuildPrizePool();
		RefreshAll();
		RefreshRedDots();
		ChangeToGamePadInputState(OneTreatMainControllerType.OneTreatMain, needReFocusLayer: true);
		Model<ActivityCenterModel>.Interface.MarkOneTreatMainRedDotRead();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/IchibanKuji/Open");
	}

	protected override void UnInit()
	{
		base.UnInit();
		_prizes.Clear();
		_normalLotteries.Clear();
		_activityCenterData = null;
		_activityData = null;
		_finalPrize = null;
		_drawRequesting = false;
		_waitingForDrawResultDisplay = false;
		HideAllViewControlPrompts();
		ClearInputSelection();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_UpdateActivity, OnActivityUpdate);
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction -= OnTaskProgressChange;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BagItemChange, OnTicketCountChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnTicketCountChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SyncGameInfo, OnTicketCountChanged);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
	}

	private void OnActivityUpdate(BaseEventContent content)
	{
		if (content is ActivityCenterInfo activityCenterInfo && activityCenterInfo.activityId == ActivityId)
		{
			RefreshActivityData();
			RefreshRedDots();
			if (!_drawRequesting && !_waitingForDrawResultDisplay)
			{
				RefreshAll();
			}
		}
	}

	private void OnTaskProgressChange(int taskId, ACT.Battle.TaskInfo taskInfo, bool isNew)
	{
		RefreshRedDots();
	}

	private void OnTicketCountChanged(BaseEventContent content)
	{
		int ticketItemId = GetTicketItemId();
		if (ticketItemId > 0 && IsTicketCountChange(content, ticketItemId))
		{
			int localTicketCount = _localTicketCount;
			RefreshTicketCountState();
			if (localTicketCount != _localTicketCount)
			{
				Model<ActivityCenterModel>.Interface.RefreshOneTreatRedDotState();
			}
		}
	}

	private static bool IsTicketCountChange(BaseEventContent content, int ticketId)
	{
		if (content == null)
		{
			return true;
		}
		if (content is PlayerAttributeChangeEvt playerAttributeChangeEvt)
		{
			return playerAttributeChangeEvt.id == ticketId;
		}
		if (content is ItemChangeEvt itemChangeEvt)
		{
			if (itemChangeEvt.ItemProxies != null)
			{
				return itemChangeEvt.ItemProxies.Exists((ItemUnifierProxy item) => item != null && item.Id == ticketId);
			}
			return false;
		}
		return true;
	}

	private void CacheComponents()
	{
		CachePrizeSlots();
	}

	private void CachePrizeSlots()
	{
		if (_prizeSlots == null)
		{
			_prizeSlots = new List<OneTreatPrizeSlotBinding>();
		}
		if (_tierRows == null)
		{
			_tierRows = new List<OneTreatTierRowBinding>();
		}
		for (int num = _prizeSlots.Count - 1; num >= 0; num--)
		{
			OneTreatPrizeSlotBinding oneTreatPrizeSlotBinding = _prizeSlots[num];
			if (oneTreatPrizeSlotBinding == null)
			{
				_prizeSlots.RemoveAt(num);
			}
			else
			{
				oneTreatPrizeSlotBinding.Bind(OpenPrizeDetail);
			}
		}
		_finalPrizeSlot?.Bind(OpenPrizeDetail);
		for (int num2 = _tierRows.Count - 1; num2 >= 0; num2--)
		{
			OneTreatTierRowBinding oneTreatTierRowBinding = _tierRows[num2];
			if (oneTreatTierRowBinding == null)
			{
				_tierRows.RemoveAt(num2);
			}
			else
			{
				oneTreatTierRowBinding.Bind(OpenPrizeDetail);
			}
		}
		_prizeSlots.Sort((OneTreatPrizeSlotBinding left, OneTreatPrizeSlotBinding right) =>
		{
			int num3 = GetTierOrder(left.Tier).CompareTo(GetTierOrder(right.Tier));
			return (num3 == 0) ? left.SlotIndex.CompareTo(right.SlotIndex) : num3;
		});
		_tierRows.Sort((OneTreatTierRowBinding left, OneTreatTierRowBinding right) => GetTierOrder(left.Tier).CompareTo(GetTierOrder(right.Tier)));
	}

	private void BindButtons()
	{
		backButton?.SetBtnClick(Close);
		infoButton?.SetBtnClick(OpenActivityDesc);
		taskButton?.SetBtnClick(OpenTaskView);
		drawButton?.SetBtnClick(OnDrawButtonClick);
	}

	private void RefreshActivityData()
	{
		_activityCenterData = Model<ActivityCenterModel>.Interface.GetActivityCenterData(ActivityId);
		_activityData = _activityCenterData?.StaticActivityData;
		if (_activityData == null && ActivityId > 0)
		{
			_activityData = CoreUtils.GetData(ActivityId, RuntimeConfigs.data.activityDatas);
		}
	}

	private void BuildPrizePool()
	{
		_prizes.Clear();
		_normalLotteries.Clear();
		_finalPrize = null;
		TryBuildPrizePoolFromLotteryConfigs();
	}

	private bool TryBuildPrizePoolFromLotteryConfigs()
	{
		OneTreatConfigUtility.CollectLotteryConfigs(_activityData, _normalLotteries, out var finalLottery);
		if (_normalLotteries.Count == 0 && finalLottery == null)
		{
			return false;
		}
		int num = 0;
		int num2 = 0;
		for (int i = 0; i < TierDefinitions.Length; i++)
		{
			OneTreatTierDefinition oneTreatTierDefinition = TierDefinitions[i];
			if (oneTreatTierDefinition.Tier == "S")
			{
				for (int j = 0; j < oneTreatTierDefinition.Count; j++)
				{
					Lottery normalLottery = GetNormalLottery(num2++);
					_prizes.Add(CreatePrizeInfo(oneTreatTierDefinition.Tier, j, num, normalLottery, finalReward: false));
					num++;
				}
			}
			else
			{
				Lottery normalLottery2 = GetNormalLottery(num2++);
				for (int k = 0; k < oneTreatTierDefinition.Count; k++)
				{
					_prizes.Add(CreatePrizeInfo(oneTreatTierDefinition.Tier, k, num, normalLottery2, finalReward: false));
					num++;
				}
			}
		}
		_finalPrize = ((finalLottery == null) ? null : CreatePrizeInfo("Final", 0, -1, finalLottery, finalReward: true));
		return _prizes.Count > 0;
	}

	private Lottery GetNormalLottery(int index)
	{
		if (index < 0 || index >= _normalLotteries.Count)
		{
			return null;
		}
		return _normalLotteries[index];
	}

	private OneTreatPrizeInfo CreatePrizeInfo(string tier, int tierIndex, int globalIndex, Lottery lottery, bool finalReward)
	{
		ItemKv firstLotteryReward = OneTreatConfigUtility.GetFirstLotteryReward(lottery);
		int num = firstLotteryReward?.id ?? 0;
		int num2 = Mathf.Max(1, firstLotteryReward?.count ?? 1);
		return new OneTreatPrizeInfo
		{
			Tier = tier,
			TierIndex = tierIndex,
			GlobalIndex = globalIndex,
			RewardId = num,
			RewardCount = num2,
			RewardName = GetRewardDisplayName(num, num2),
			IsFinalReward = finalReward,
			LotteryConfigId = (lottery?.id ?? 0)
		};
	}

	private void InitLocalState()
	{
		_localTicketCount = GetInitialTicketCount();
		_todayTicketCount = Model<ActivityCenterModel>.Interface.GetOneTreatReceivedTaskRewardCount();
	}

	private void RefreshTicketCountState()
	{
		_localTicketCount = GetInitialTicketCount();
		RefreshTicketCurrency();
		RefreshTopInfo();
		RefreshDrawState();
	}

	private void RefreshTaskEntry()
	{
		bool flag = !HasClaimedAllPrizes;
		bool flag2 = _selection == OneTreatMainSelection.TaskButton;
		SetActiveIfChanged(taskButton?.gameObject, flag);
		if (!flag & flag2)
		{
			SelectFallbackMainButton(OneTreatMainSelection.TaskButton);
		}
	}

	private int GetInitialTicketCount()
	{
		int ticketItemId = GetTicketItemId();
		if (ticketItemId <= 0)
		{
			return 0;
		}
		return GetPlayerItemCount(ticketItemId);
	}

	private int GetTicketItemId()
	{
		return OneTreatConfigUtility.GetTicketItemId(_activityData);
	}

	public void OpenTicketCurrencyDetail()
	{
		if (!(ticketCurrency == null))
		{
			ticketCurrency.InputClick();
		}
	}

	private int GetPlayerItemCount(int itemId)
	{
		try
		{
			return (G.localPlayer != null) ? G.localPlayer.GetCountById(itemId) : 0;
		}
		catch (Exception)
		{
			return 0;
		}
	}

	private static bool IsBagItem(int itemId)
	{
		foreach (PlayerAttribute value in Enum.GetValues(typeof(PlayerAttribute)))
		{
			if (value == (PlayerAttribute)itemId)
			{
				return false;
			}
		}
		return true;
	}

	private void RefreshAll()
	{
		InitLocalState();
		RefreshPrizeSlots();
		RefreshTicketCurrency();
		RefreshTopInfo();
		RefreshDrawState();
		RefreshTaskEntry();
	}

	private void RefreshRedDots()
	{
		Model<ActivityCenterModel>.Interface.RefreshOneTreatRedDotState();
		BindRedDot(redDotItem, RedDotPathDefine.Activity_OneTreatTask);
	}

	private static void BindRedDot(RedDotItem target, string path)
	{
		if (!(target == null) && !string.IsNullOrEmpty(path))
		{
			target.redDotType = RedDotType.Dot;
			target.displayAction = new SelfNodeActive();
			target.fullPath = path.Split("|").ToList();
			target.BindTrieNode();
			target.UpdateDisplay();
		}
	}

	private int GetClaimedPrizeCount()
	{
		ActivityKujiInfo oneTreatInfo = Model<ActivityCenterModel>.Interface.GetOneTreatInfo();
		return OneTreatConfigUtility.GetNormalLotteryClaimedCount(_activityData, oneTreatInfo);
	}

	private bool TryGetNormalLotteryConfig(int lotteryConfigId, out Lottery lottery)
	{
		lottery = null;
		if (lotteryConfigId <= 0 || RuntimeConfigs.data?.lotterys == null)
		{
			return false;
		}
		if (!RuntimeConfigs.data.lotterys.TryGetValue(lotteryConfigId, out lottery) || lottery == null)
		{
			return false;
		}
		if (lottery.lotteryid == GetActivityLotteryId())
		{
			return lottery.finalReward != 1;
		}
		return false;
	}

	private int GetTotalPrizeCount()
	{
		if (_normalLotteries.Count <= 0)
		{
			return _prizes.Count;
		}
		int num = 0;
		for (int i = 0; i < _normalLotteries.Count; i++)
		{
			num += GetLotteryPrizeCount(_normalLotteries[i]);
		}
		return Mathf.Max(0, num);
	}

	private static int GetLotteryPrizeCount(Lottery lottery)
	{
		if (lottery != null)
		{
			return Mathf.Max(1, lottery.max);
		}
		return 0;
	}

	private int GetActivityLotteryId()
	{
		if (_activityData?.lotteryId == null || _activityData.lotteryId.Count == 0)
		{
			return 0;
		}
		for (int i = 0; i < _activityData.lotteryId.Count; i++)
		{
			ItemKv itemKv = _activityData.lotteryId[i];
			if (itemKv != null && itemKv.id > 0)
			{
				return itemKv.id;
			}
		}
		return 0;
	}

	private bool IsPrizeClaimed(OneTreatPrizeInfo prize)
	{
		if (prize == null || prize.LotteryConfigId <= 0)
		{
			return false;
		}
		int prizeIndexInSameLottery = GetPrizeIndexInSameLottery(prize);
		return Model<ActivityCenterModel>.Interface.GetOneTreatPrizeDrawnCount(prize.LotteryConfigId) > prizeIndexInSameLottery;
	}

	private bool IsPrizeClaimed(OneTreatPrizeInfo prize, Dictionary<int, int> prizeDrawnSnapshot)
	{
		if (prize == null || prize.LotteryConfigId <= 0)
		{
			return false;
		}
		int value = 0;
		prizeDrawnSnapshot?.TryGetValue(prize.LotteryConfigId, out value);
		return Mathf.Max(0, value) > GetPrizeIndexInSameLottery(prize);
	}

	private int GetPrizeIndexInSameLottery(OneTreatPrizeInfo targetPrize)
	{
		if (targetPrize == null || targetPrize.LotteryConfigId <= 0)
		{
			return 0;
		}
		int num = 0;
		for (int i = 0; i < _prizes.Count; i++)
		{
			OneTreatPrizeInfo oneTreatPrizeInfo = _prizes[i];
			if (oneTreatPrizeInfo != null && oneTreatPrizeInfo.LotteryConfigId == targetPrize.LotteryConfigId)
			{
				if (oneTreatPrizeInfo == targetPrize || oneTreatPrizeInfo.GlobalIndex == targetPrize.GlobalIndex)
				{
					return num;
				}
				num++;
			}
		}
		return Mathf.Max(0, targetPrize.TierIndex);
	}

	private bool IsFinalPrizeClaimed()
	{
		if (_finalPrize != null)
		{
			return Model<ActivityCenterModel>.Interface.GetOneTreatPrizeDrawnCount(_finalPrize.LotteryConfigId) > 0;
		}
		return false;
	}

	private void RefreshPrizeSlots()
	{
		int num = Mathf.Min(_prizeSlots.Count, _prizes.Count);
		for (int i = 0; i < _prizeSlots.Count; i++)
		{
			if (i >= num)
			{
				_prizeSlots[i].SetActive(active: false);
			}
			else
			{
				_prizeSlots[i].Refresh(_prizes[i], IsPrizeClaimed(_prizes[i]), Station);
			}
		}
		_finalPrizeSlot?.Refresh(_finalPrize, IsFinalPrizeClaimed(), Station);
		RefreshTierRows();
	}

	private void RefreshTicketCurrency()
	{
		int ticketItemId = GetTicketItemId();
		if (ticketCurrency != null && ticketItemId > 0)
		{
			ticketCurrency.InitData(ticketItemId, IsBagItem(ticketItemId));
			ticketCurrency.Initialize();
		}
		if (ticketCurrencyNumber != null)
		{
			ticketCurrencyNumber.UpdateNumber(Mathf.Max(0, _localTicketCount));
		}
	}

	private void RefreshTierRows()
	{
		foreach (OneTreatTierRowBinding tierRow in _tierRows)
		{
			tierRow?.Refresh(GetTierPrizeInfo(tierRow.Tier), GetTierSlotCount(tierRow.Tier), Station);
		}
	}

	private OneTreatPrizeInfo GetTierPrizeInfo(string tier)
	{
		if (string.IsNullOrEmpty(tier))
		{
			return null;
		}
		for (int i = 0; i < _prizes.Count; i++)
		{
			OneTreatPrizeInfo oneTreatPrizeInfo = _prizes[i];
			if (oneTreatPrizeInfo != null && string.Equals(oneTreatPrizeInfo.Tier, tier, StringComparison.Ordinal))
			{
				return oneTreatPrizeInfo;
			}
		}
		return null;
	}

	private static int GetTierSlotCount(string tier)
	{
		for (int i = 0; i < TierDefinitions.Length; i++)
		{
			if (string.Equals(TierDefinitions[i].Tier, tier, StringComparison.Ordinal))
			{
				return TierDefinitions[i].Count;
			}
		}
		return 0;
	}

	private void RefreshTopInfo()
	{
		if (progressText != null)
		{
			progressText.SetText("{0:0}/{1:0}", ClaimedPrizeCount, TotalPrizeCount);
		}
		if (ticketCountText != null)
		{
			ticketCountText.SetText("{0:0}", Mathf.Max(0, _localTicketCount));
		}
		if (taskCountLeftText != null && taskCountRightText != null)
		{
			taskCountLeftText.SetText("{0:0}", _todayTicketCount);
			taskCountRightText.SetText("{0:0}", 5f);
		}
	}

	private void RefreshDrawState()
	{
		bool hasClaimedAllPrizes = HasClaimedAllPrizes;
		SetActiveIfChanged(allClaimedRoot, hasClaimedAllPrizes);
		SetActiveIfChanged(drawRoot, !hasClaimedAllPrizes);
		if (drawButtonText != null)
		{
			drawButtonText.text = (hasClaimedAllPrizes ? "已获取所有奖励" : "试试手气");
		}
		if (drawButton != null)
		{
			drawButton.Interactable(!hasClaimedAllPrizes && _localTicketCount > 0);
		}
	}

	public void EnterTopControlByInput()
	{
		ChangeToGamePadInputState(OneTreatMainControllerType.OneTreatTop, needReFocusLayer: true);
	}

	public void ChangeToGamePadInputState(OneTreatMainControllerType type, bool needReFocusLayer = false)
	{
		OneTreatMainControllerType currentControllerType = CurrentControllerType;
		CurrentControllerType = type;
		if (currentControllerType != type && ViewControlLayers != null && ViewControlLayers.TryGetValue(currentControllerType, out var value))
		{
			value?.UnFocus();
		}
		if (type == OneTreatMainControllerType.OneTreatTop)
		{
			ClearInputSelection();
			FocusViewControlLayer(type, needReFocusLayer);
			SelectTopControlByInput(GetTopControlIndexFromCurrentSelection());
		}
		else
		{
			ClearTopControlSelection();
		}
		RefreshViewControlPrompts(type);
	}

	private void FocusViewControlLayer(OneTreatMainControllerType type, bool needReFocusLayer)
	{
		if (ViewControlLayers != null && ViewControlLayers.TryGetValue(type, out var value) && !(value == null))
		{
			if (needReFocusLayer)
			{
				value.ReFocus();
			}
			else
			{
				value.Focus();
			}
		}
	}

	private void RefreshViewControlPrompts(OneTreatMainControllerType type)
	{
		HideAllViewControlPrompts();
		if (ViewControlPrompt == null || MonoECS.instance.InputMode != DeviceInputMode.Gamepad || !ViewControlPrompt.TryGetValue(type, out var value) || value == null)
		{
			return;
		}
		foreach (GameObject item in value)
		{
			SetActiveIfChanged(item, active: true);
		}
	}

	private void HideAllViewControlPrompts()
	{
		if (ViewControlPrompt == null)
		{
			return;
		}
		foreach (KeyValuePair<OneTreatMainControllerType, List<GameObject>> item in ViewControlPrompt)
		{
			if (item.Value == null)
			{
				continue;
			}
			foreach (GameObject item2 in item.Value)
			{
				SetActiveIfChanged(item2, active: false);
			}
		}
	}

	public void ExecuteTopControlNavigate(MoveDirection dir)
	{
		if (dir == MoveDirection.Left || dir == MoveDirection.Right)
		{
			int topControlIndexFromCurrentSelection = GetTopControlIndexFromCurrentSelection();
			if (topControlIndexFromCurrentSelection < 0)
			{
				SelectTopControlByInput(GetFirstValidTopControlIndex());
			}
			else
			{
				SelectTopControlByInput((topControlIndexFromCurrentSelection == 0) ? 1 : 0);
			}
		}
	}

	public void SubmitTopControlSelection()
	{
		int num = GetTopControlIndexFromCurrentSelection();
		if (num < 0)
		{
			num = GetFirstValidTopControlIndex();
		}
		ActButton topControlButton = GetTopControlButton(num);
		if (IsValidTopControl(topControlButton))
		{
			SelectTopControlByInput(num);
			topControlButton.OnSubmit(new BaseEventData(EventSystemHelper.Shared));
		}
	}

	private void SelectTopControlByInput(int index)
	{
		ActButton topControlButton = GetTopControlButton(index);
		if (!IsValidTopControl(topControlButton))
		{
			index = GetFirstValidTopControlIndex();
			topControlButton = GetTopControlButton(index);
		}
		if (!IsValidTopControl(topControlButton))
		{
			_topControlIndex = -1;
			return;
		}
		_topControlIndex = index;
		EventSystemHelper.SetSelectedGameObject(topControlButton.gameObject);
	}

	private void ClearTopControlSelection()
	{
		bool flag = IsTopControlGameObject(EventSystemHelper.CurrentSelected);
		_topControlIndex = -1;
		if (flag)
		{
			EventSystemHelper.SetSelectedGameObject(null);
		}
	}

	private int GetTopControlIndexFromCurrentSelection()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected != null)
		{
			for (int i = 0; i < 2; i++)
			{
				ActButton topControlButton = GetTopControlButton(i);
				if (!(topControlButton == null) && (currentSelected == topControlButton.gameObject || currentSelected.transform.IsChildOf(topControlButton.transform)))
				{
					return i;
				}
			}
		}
		if (!IsValidTopControl(GetTopControlButton(_topControlIndex)))
		{
			return GetFirstValidTopControlIndex();
		}
		return _topControlIndex;
	}

	private int GetFirstValidTopControlIndex()
	{
		for (int i = 0; i < 2; i++)
		{
			if (IsValidTopControl(GetTopControlButton(i)))
			{
				return i;
			}
		}
		return -1;
	}

	private ActButton GetTopControlButton(int index)
	{
		return index switch
		{
			0 => ticketCurrency, 
			1 => infoButton, 
			_ => null, 
		};
	}

	private static bool IsValidTopControl(ActButton button)
	{
		if (button != null && button.gameObject.activeInHierarchy)
		{
			return button.interactable;
		}
		return false;
	}

	private bool IsTopControlGameObject(GameObject selected)
	{
		if (selected == null)
		{
			return false;
		}
		for (int i = 0; i < 2; i++)
		{
			ActButton topControlButton = GetTopControlButton(i);
			if (topControlButton != null && (selected == topControlButton.gameObject || selected.transform.IsChildOf(topControlButton.transform)))
			{
				return true;
			}
		}
		return false;
	}

	public void OnControllerActivate()
	{
		ClearInputSelection();
		ChangeToGamePadInputState(CurrentControllerType, needReFocusLayer: true);
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type == DeviceInputMode.Gamepad)
		{
			RefreshViewControlPrompts(CurrentControllerType);
		}
		else
		{
			HideAllViewControlPrompts();
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		if (dir == MoveDirection.None)
		{
			return;
		}
		if (_selection == OneTreatMainSelection.None)
		{
			SelectDefaultByInput(dir);
			return;
		}
		switch (_selection)
		{
		case OneTreatMainSelection.Prize:
			ClearInputSelection();
			SelectDefaultByInput(dir);
			break;
		case OneTreatMainSelection.TaskButton:
			NavigateTaskButton(dir);
			break;
		case OneTreatMainSelection.DrawButton:
			NavigateDrawButton(dir);
			break;
		case OneTreatMainSelection.InfoButton:
			NavigateInfoButton(dir);
			break;
		}
	}

	public void HandleConfirm()
	{
		switch (_selection)
		{
		case OneTreatMainSelection.Prize:
			ClearInputSelection();
			SelectDefaultByInput(MoveDirection.Down);
			break;
		case OneTreatMainSelection.TaskButton:
			OpenTaskView();
			break;
		case OneTreatMainSelection.DrawButton:
			OnDrawButtonClick();
			break;
		case OneTreatMainSelection.InfoButton:
			OpenActivityDesc();
			break;
		default:
			SelectDefaultByInput(MoveDirection.Down);
			break;
		}
	}

	public void HandleBack()
	{
		if (_selection != OneTreatMainSelection.None)
		{
			ClearInputSelection();
		}
		else
		{
			Close();
		}
	}

	public void OpenTaskByInput()
	{
		OpenTaskView();
	}

	public void DrawByInput()
	{
		OnDrawButtonClick();
	}

	public void OpenActivityDescByInput()
	{
		OpenActivityDesc();
	}

	private void SelectDefaultByInput(MoveDirection dir)
	{
		if (drawButton != null && drawButton.gameObject.activeInHierarchy)
		{
			SelectButtonByInput(OneTreatMainSelection.DrawButton, drawButton);
		}
		else
		{
			ClearInputSelection();
		}
	}

	private void NavigatePrize(MoveDirection dir)
	{
		int selectablePrizeCount = GetSelectablePrizeCount();
		if (selectablePrizeCount <= 0)
		{
			ClearInputSelection();
			return;
		}
		if (_selectedPrizeIndex >= _prizeSlots.Count)
		{
			switch (dir)
			{
			case MoveDirection.Left:
				SelectPrizeByInput(Mathf.Max(0, _prizeSlots.Count - 1));
				break;
			case MoveDirection.Down:
				SelectButtonByInput(OneTreatMainSelection.DrawButton, drawButton);
				break;
			default:
				_ = 1;
				break;
			}
			return;
		}
		switch (dir)
		{
		case MoveDirection.Left:
		case MoveDirection.Right:
		{
			int num = ((dir != MoveDirection.Left) ? 1 : (-1));
			SelectPrizeByInput(Mathf.Clamp(_selectedPrizeIndex + num, 0, selectablePrizeCount - 1));
			break;
		}
		case MoveDirection.Up:
		case MoveDirection.Down:
		{
			int verticalPrizeIndex = GetVerticalPrizeIndex(dir);
			if (verticalPrizeIndex >= 0)
			{
				SelectPrizeByInput(verticalPrizeIndex);
			}
			else if (dir == MoveDirection.Down)
			{
				SelectButtonByInput(OneTreatMainSelection.DrawButton, drawButton);
			}
			break;
		}
		}
	}

	private void NavigateTaskButton(MoveDirection dir)
	{
		if (drawButton != null && drawButton.gameObject.activeInHierarchy)
		{
			SelectButtonByInput(OneTreatMainSelection.DrawButton, drawButton);
		}
		else
		{
			ClearInputSelection();
		}
	}

	private void NavigateDrawButton(MoveDirection dir)
	{
	}

	private void NavigateInfoButton(MoveDirection dir)
	{
		if (dir == MoveDirection.Down && drawButton != null && drawButton.gameObject.activeInHierarchy)
		{
			SelectButtonByInput(OneTreatMainSelection.DrawButton, drawButton);
		}
	}

	private int GetVerticalPrizeIndex(MoveDirection dir)
	{
		if (_selectedPrizeIndex < 0 || _selectedPrizeIndex >= _prizeSlots.Count)
		{
			return -1;
		}
		OneTreatPrizeSlotBinding oneTreatPrizeSlotBinding = _prizeSlots[_selectedPrizeIndex];
		int tierOrder = GetTierOrder(oneTreatPrizeSlotBinding.Tier);
		if (tierOrder == int.MaxValue)
		{
			return -1;
		}
		int num = ((dir == MoveDirection.Up) ? (tierOrder - 1) : (tierOrder + 1));
		if (num < 0 || num >= TierDefinitions.Length)
		{
			return -1;
		}
		OneTreatTierDefinition oneTreatTierDefinition = TierDefinitions[num];
		int slotIndex = Mathf.Clamp(oneTreatPrizeSlotBinding.SlotIndex, 0, Mathf.Max(0, oneTreatTierDefinition.Count - 1));
		return FindPrizeSlotIndex(oneTreatTierDefinition.Tier, slotIndex);
	}

	private int FindPrizeSlotIndex(string tier, int slotIndex)
	{
		for (int i = 0; i < _prizeSlots.Count; i++)
		{
			OneTreatPrizeSlotBinding oneTreatPrizeSlotBinding = _prizeSlots[i];
			if (oneTreatPrizeSlotBinding.Tier == tier && oneTreatPrizeSlotBinding.SlotIndex == slotIndex)
			{
				return i;
			}
		}
		return -1;
	}

	private int GetSelectablePrizeCount()
	{
		return _prizeSlots.Count + ((_finalPrizeSlot != null && _finalPrize != null) ? 1 : 0);
	}

	private int GetFirstUnclaimedSelectablePrizeIndex()
	{
		for (int i = 0; i < _prizes.Count; i++)
		{
			if (!IsPrizeClaimed(_prizes[i]))
			{
				return Mathf.Clamp(i, 0, Mathf.Max(0, GetSelectablePrizeCount() - 1));
			}
		}
		return 0;
	}

	private void SelectPrizeByInput(int index)
	{
		int selectablePrizeCount = GetSelectablePrizeCount();
		if (selectablePrizeCount > 0)
		{
			ClearInputSelection();
			_selection = OneTreatMainSelection.Prize;
			_selectedPrizeIndex = Mathf.Clamp(index, 0, selectablePrizeCount - 1);
			SetPrizeSelected(_selectedPrizeIndex, selected: true);
		}
	}

	private void SelectButtonByInput(OneTreatMainSelection selection, ActButton button)
	{
		if (button == null || !button.gameObject.activeInHierarchy)
		{
			SelectFallbackMainButton(selection);
			return;
		}
		ClearInputSelection();
		_selection = selection;
		EventSystemHelper.SetSelectedGameObject(button.gameObject);
	}

	private void SelectFallbackMainButton(OneTreatMainSelection excludeSelection)
	{
		if (excludeSelection != OneTreatMainSelection.DrawButton && drawButton != null && drawButton.gameObject.activeInHierarchy)
		{
			SelectButtonByInput(OneTreatMainSelection.DrawButton, drawButton);
		}
		else
		{
			ClearInputSelection();
		}
	}

	private void ClearInputSelection()
	{
		SetPrizeSelected(_selectedPrizeIndex, selected: false);
		_selection = OneTreatMainSelection.None;
		_selectedPrizeIndex = -1;
		if (EventSystemHelper.CurrentSelected != null)
		{
			EventSystemHelper.SetSelectedGameObject(null);
		}
		UnfocusTopLayer();
	}

	private void UnfocusTopLayer()
	{
		if (CurrentControllerType != OneTreatMainControllerType.OneTreatTop && ViewControlLayers != null && ViewControlLayers.TryGetValue(OneTreatMainControllerType.OneTreatTop, out var value))
		{
			value?.UnFocus();
		}
	}

	private void SetPrizeSelected(int index, bool selected)
	{
		if (index >= 0)
		{
			if (index < _prizeSlots.Count)
			{
				_prizeSlots[index].SetSelected(selected);
			}
			else
			{
				_finalPrizeSlot?.SetSelected(selected);
			}
		}
	}

	private void OpenSelectedPrizeDetail()
	{
		OneTreatPrizeInfo selectedPrizeInfo = GetSelectedPrizeInfo();
		if (selectedPrizeInfo == null || selectedPrizeInfo.RewardId <= 0)
		{
			GameUtility.OpenToolTip("暂无可查看奖励");
			return;
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
		{
			Id = selectedPrizeInfo.RewardId,
			Count = Mathf.Max(1, selectedPrizeInfo.RewardCount)
		});
	}

	private OneTreatPrizeInfo GetSelectedPrizeInfo()
	{
		if (_selectedPrizeIndex < 0)
		{
			return null;
		}
		if (_selectedPrizeIndex < _prizes.Count)
		{
			return _prizes[_selectedPrizeIndex];
		}
		if (_selectedPrizeIndex != _prizeSlots.Count)
		{
			return null;
		}
		return _finalPrize;
	}

	private void OpenPrizeDetail(OneTreatPrizeInfo prize)
	{
		if (prize == null || prize.RewardId <= 0)
		{
			GameUtility.OpenToolTip("暂无可查看奖励");
			return;
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
		{
			Id = prize.RewardId,
			Count = Mathf.Max(1, prize.RewardCount)
		});
	}

	private void OnDrawButtonClick()
	{
		RequestDrawPrize((OneTreatScrapingPrizeViewData prizeViewData) =>
		{
			if (prizeViewData != null)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ONETREATSCRAPINGPRIZE, prizeViewData);
			}
		});
	}

	private bool RequestDrawPrize(Action<OneTreatScrapingPrizeViewData> callback)
	{
		if (_drawRequesting)
		{
			return false;
		}
		if (HasClaimedAllPrizes)
		{
			GameUtility.OpenToolTip("已获取所有奖励");
			callback?.Invoke(null);
			return false;
		}
		if (_localTicketCount <= 0)
		{
			GameUtility.OpenToolTip("奖券不足");
			callback?.Invoke(null);
			return false;
		}
		int ticketCountAfterDraw = Mathf.Max(0, _localTicketCount - 1);
		Dictionary<int, int> prizeDrawnSnapshot = CreatePrizeDrawnCountSnapshot();
		bool isFinalDraw = TotalPrizeCount > 0 && ClaimedPrizeCount + 1 >= TotalPrizeCount;
		_drawRequesting = true;
		G.service.SendActivityKujiDrawReq(ActivityId, (ActivityKujiDrawAck ack) =>
		{
			_drawRequesting = false;
			if (ack == null)
			{
				RefreshAll();
				callback?.Invoke(null);
			}
			else
			{
				OneTreatScrapingPrizeViewData oneTreatScrapingPrizeViewData = CreateScrapingPrizeViewData(ack, ticketCountAfterDraw, prizeDrawnSnapshot, isFinalDraw);
				if (oneTreatScrapingPrizeViewData == null)
				{
					RefreshAll();
					callback?.Invoke(null);
				}
				else
				{
					_waitingForDrawResultDisplay = true;
					callback?.Invoke(oneTreatScrapingPrizeViewData);
				}
			}
		});
		return true;
	}

	private Dictionary<int, int> CreatePrizeDrawnCountSnapshot()
	{
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		for (int i = 0; i < _prizes.Count; i++)
		{
			OneTreatPrizeInfo oneTreatPrizeInfo = _prizes[i];
			if (oneTreatPrizeInfo != null && oneTreatPrizeInfo.LotteryConfigId > 0 && !dictionary.ContainsKey(oneTreatPrizeInfo.LotteryConfigId))
			{
				dictionary.Add(oneTreatPrizeInfo.LotteryConfigId, Mathf.Max(0, Model<ActivityCenterModel>.Interface.GetOneTreatPrizeDrawnCount(oneTreatPrizeInfo.LotteryConfigId)));
			}
		}
		return dictionary;
	}

	private OneTreatScrapingPrizeViewData CreateScrapingPrizeViewData(ActivityKujiDrawAck ack, int ticketCountAfterDraw, Dictionary<int, int> prizeDrawnSnapshot, bool isFinalDraw)
	{
		if (TryCreateMergedFinalDrawPrizeViewData(ack, ticketCountAfterDraw, prizeDrawnSnapshot, isFinalDraw, out var prizeViewData))
		{
			return prizeViewData;
		}
		OneTreatPrizeInfo prizeInfoFromDrawAck = GetPrizeInfoFromDrawAck(ack, prizeDrawnSnapshot, out var matchedItemIndex);
		OneTreatPrizeInfo finalPrizeInfoFromDrawAck = GetFinalPrizeInfoFromDrawAck(ack, matchedItemIndex);
		if (prizeInfoFromDrawAck == null && finalPrizeInfoFromDrawAck == null)
		{
			return null;
		}
		return CreateScrapingPrizeViewData(prizeInfoFromDrawAck, finalPrizeInfoFromDrawAck, ticketCountAfterDraw);
	}

	private bool TryCreateMergedFinalDrawPrizeViewData(ActivityKujiDrawAck ack, int ticketCountAfterDraw, Dictionary<int, int> prizeDrawnSnapshot, bool isFinalDraw, out OneTreatScrapingPrizeViewData prizeViewData)
	{
		prizeViewData = null;
		if (!isFinalDraw || ack == null || ack.Items.Count != 1 || _finalPrize == null)
		{
			return false;
		}
		UniversalItem universalItem = ack.Items[0];
		if (universalItem == null || universalItem.Index != _finalPrize.RewardId)
		{
			return false;
		}
		int num = Mathf.Max(1, universalItem.Count);
		int num2 = Mathf.Max(1, _finalPrize.RewardCount);
		if (num <= num2)
		{
			return false;
		}
		int rewardCount = num - num2;
		OneTreatPrizeInfo oneTreatPrizeInfo = FindMergedNormalPrizeInfo(universalItem.Index, rewardCount, prizeDrawnSnapshot);
		if (oneTreatPrizeInfo == null)
		{
			return false;
		}
		OneTreatPrizeInfo prize = ClonePrizeInfoWithCount(oneTreatPrizeInfo, rewardCount);
		prizeViewData = CreateScrapingPrizeViewData(prize, _finalPrize, ticketCountAfterDraw);
		return true;
	}

	private OneTreatPrizeInfo FindMergedNormalPrizeInfo(int rewardId, int rewardCount, Dictionary<int, int> prizeDrawnSnapshot)
	{
		OneTreatPrizeInfo oneTreatPrizeInfo = null;
		OneTreatPrizeInfo oneTreatPrizeInfo2 = null;
		OneTreatPrizeInfo oneTreatPrizeInfo3 = null;
		for (int i = 0; i < _prizes.Count; i++)
		{
			OneTreatPrizeInfo oneTreatPrizeInfo4 = _prizes[i];
			if (oneTreatPrizeInfo4 != null && oneTreatPrizeInfo4.RewardId == rewardId)
			{
				bool flag = IsPrizeClaimed(oneTreatPrizeInfo4, prizeDrawnSnapshot);
				if (!flag && oneTreatPrizeInfo4.RewardCount == rewardCount)
				{
					return oneTreatPrizeInfo4;
				}
				if (oneTreatPrizeInfo4.RewardCount == rewardCount && oneTreatPrizeInfo == null)
				{
					oneTreatPrizeInfo = oneTreatPrizeInfo4;
				}
				if (!flag && oneTreatPrizeInfo2 == null)
				{
					oneTreatPrizeInfo2 = oneTreatPrizeInfo4;
				}
				if (oneTreatPrizeInfo3 == null)
				{
					oneTreatPrizeInfo3 = oneTreatPrizeInfo4;
				}
			}
		}
		return oneTreatPrizeInfo ?? oneTreatPrizeInfo2 ?? oneTreatPrizeInfo3;
	}

	private OneTreatPrizeInfo ClonePrizeInfoWithCount(OneTreatPrizeInfo prize, int rewardCount)
	{
		if (prize == null)
		{
			return null;
		}
		int num = Mathf.Max(1, rewardCount);
		return new OneTreatPrizeInfo
		{
			Tier = prize.Tier,
			TierIndex = prize.TierIndex,
			GlobalIndex = prize.GlobalIndex,
			RewardId = prize.RewardId,
			RewardCount = num,
			RewardName = GetRewardDisplayName(prize.RewardId, num),
			IsFinalReward = prize.IsFinalReward,
			LotteryConfigId = prize.LotteryConfigId
		};
	}

	private OneTreatPrizeInfo GetPrizeInfoFromDrawAck(ActivityKujiDrawAck ack, Dictionary<int, int> prizeDrawnSnapshot, out int matchedItemIndex)
	{
		matchedItemIndex = -1;
		if (ack == null || ack.Items.Count == 0)
		{
			return null;
		}
		OneTreatPrizeInfo oneTreatPrizeInfo = FindPrizeInfoByAckItems(ack, matchCount: true, preferUnclaimed: true, prizeDrawnSnapshot, out matchedItemIndex);
		if (oneTreatPrizeInfo != null)
		{
			return oneTreatPrizeInfo;
		}
		oneTreatPrizeInfo = FindPrizeInfoByAckItems(ack, matchCount: false, preferUnclaimed: true, prizeDrawnSnapshot, out matchedItemIndex);
		if (oneTreatPrizeInfo != null)
		{
			return oneTreatPrizeInfo;
		}
		return null;
	}

	private OneTreatPrizeInfo GetFinalPrizeInfoFromDrawAck(ActivityKujiDrawAck ack, int normalMatchedItemIndex)
	{
		if (ack == null || _finalPrize == null)
		{
			return null;
		}
		for (int i = 0; i < ack.Items.Count; i++)
		{
			if (i != normalMatchedItemIndex && IsAckItemMatchPrize(ack.Items[i], _finalPrize, matchCount: true))
			{
				return _finalPrize;
			}
		}
		for (int j = 0; j < ack.Items.Count; j++)
		{
			if (j != normalMatchedItemIndex && IsAckItemMatchPrize(ack.Items[j], _finalPrize, matchCount: false))
			{
				return _finalPrize;
			}
		}
		return null;
	}

	private OneTreatPrizeInfo FindPrizeInfoByAckItems(ActivityKujiDrawAck ack, bool matchCount, bool preferUnclaimed, Dictionary<int, int> prizeDrawnSnapshot, out int matchedItemIndex)
	{
		matchedItemIndex = -1;
		if (ack == null)
		{
			return null;
		}
		for (int i = 0; i < ack.Items.Count; i++)
		{
			for (int j = 0; j < _prizes.Count; j++)
			{
				OneTreatPrizeInfo oneTreatPrizeInfo = _prizes[j];
				if (IsAckItemMatchPrize(ack.Items[i], oneTreatPrizeInfo, matchCount) && (!preferUnclaimed || !IsPrizeClaimed(oneTreatPrizeInfo, prizeDrawnSnapshot)))
				{
					matchedItemIndex = i;
					return oneTreatPrizeInfo;
				}
			}
		}
		return null;
	}

	private static bool IsAckItemMatchPrize(UniversalItem item, OneTreatPrizeInfo prize, bool matchCount)
	{
		if (item == null || prize == null || prize.RewardId <= 0)
		{
			return false;
		}
		if (item.Index == prize.RewardId)
		{
			if (matchCount)
			{
				return Mathf.Max(1, item.Count) == Mathf.Max(1, prize.RewardCount);
			}
			return true;
		}
		return false;
	}

	private OneTreatScrapingPrizeViewData CreateScrapingPrizeViewData(OneTreatPrizeInfo prize, OneTreatPrizeInfo finalPrize, int ticketCount)
	{
		int num = Mathf.Max(0, ticketCount);
		bool flag = prize != null && finalPrize != null;
		return new OneTreatScrapingPrizeViewData
		{
			ActivityId = ActivityId,
			TicketItemId = GetTicketItemId(),
			TicketCount = num,
			Tier = (prize?.Tier ?? "E"),
			RewardId = (prize?.RewardId ?? 0),
			RewardCount = Mathf.Max(1, prize?.RewardCount ?? 1),
			RewardName = prize?.RewardName,
			HasFinalReward = flag,
			FinalRewardId = (flag ? (finalPrize?.RewardId ?? 0) : 0),
			FinalRewardCount = Mathf.Max(1, (!flag) ? 1 : (finalPrize?.RewardCount ?? 1)),
			FinalRewardName = ((!flag) ? null : finalPrize?.RewardName),
			CanDrawAgain = (!flag && !HasClaimedAllPrizes && num > 0),
			DrawAgain = RequestDrawPrize,
			OnResultDisplayed = OnDrawResultDisplayed
		};
	}

	private void OnDrawResultDisplayed()
	{
		_waitingForDrawResultDisplay = false;
		RefreshActivityData();
		RefreshAll();
	}

	private void OpenTaskView()
	{
		if (!HasClaimedAllPrizes)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ONETREATTASK, new OneTreatTaskViewData
			{
				ActivityId = ActivityId
			});
		}
	}

	private void OpenActivityDesc()
	{
		if (_activityData == null)
		{
			GameUtility.OpenToolTip("暂无活动说明");
			return;
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
		{
			descTextId = _activityData.activityDesc,
			iconId = 3001,
			titleTextId = _activityData.activityName
		});
	}

	private string GetRewardDisplayName(int itemId, int count)
	{
		if (itemId <= 0)
		{
			return string.Empty;
		}
		string arg = $"道具{itemId}";
		ItemData data = CoreUtils.GetData(itemId, RuntimeConfigs.data.itemDatas);
		if (data != null && data.nameLocal > 0)
		{
			string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data.nameLocal);
			if (!string.IsNullOrEmpty(localizeString))
			{
				arg = localizeString;
			}
		}
		return $"{arg}x{Mathf.Max(1, count)}";
	}

	private static int GetTierOrder(string tier)
	{
		for (int i = 0; i < TierDefinitions.Length; i++)
		{
			if (TierDefinitions[i].Tier == tier)
			{
				return i;
			}
		}
		return int.MaxValue;
	}

	private static void SetActiveIfChanged(GameObject target, bool active)
	{
		if (target != null && target.activeSelf != active)
		{
			target.SetActive(active);
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Hide")?.OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
	}
}
