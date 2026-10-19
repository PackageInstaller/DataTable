using System;
using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Define;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Model;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.UI;

public class RogueSettlementView : BaseUIView<RogueSettlementViewInputController>
{
	private static readonly GamePadTipsAction NavigateGamePadAction = new GamePadTipsAction
	{
		inputAction = "UI/LSLeftRightSelect",
		localizeTable = "Common",
		localizeKey = 2164
	};

	private static readonly GamePadTipsAction SelectRewardGamePadAction = new GamePadTipsAction
	{
		inputAction = "UI/SelectItemCell",
		localizeTable = "Common",
		localizeKey = 893
	};

	private static readonly GamePadTipsAction ShowDetailGamePadAction = new GamePadTipsAction
	{
		inputAction = "UI/Confirm",
		localizeTable = "Common",
		localizeKey = 893
	};

	private static readonly LocalizationCommonData.CommonString[] DurationUnitKeys = new LocalizationCommonData.CommonString[6]
	{
		LocalizationCommonData.CommonString.Year,
		LocalizationCommonData.CommonString.Month,
		LocalizationCommonData.CommonString.Day,
		LocalizationCommonData.CommonString.Hour,
		LocalizationCommonData.CommonString.Minute,
		LocalizationCommonData.CommonString.Second
	};

	private RogueSettlementViewData m_Data;

	private readonly List<GameObject> m_RuntimeItems = new List<GameObject>();

	private readonly List<LiteItemUIComponent> m_RewardItems = new List<LiteItemUIComponent>();

	private RogueSettlementControlType m_ControlType;

	[Header("Result")]
	public TextMeshProUGUI TxtSettlementTitle;

	public GameObject SuccessNode;

	public GameObject FailNode;

	public RogueSettlementTeamItem[] TeamItems;

	[Header("Pass Info")]
	public TextMeshProUGUI TxtStageName;

	public TextMeshProUGUI TxtProgress;

	public TextMeshProUGUI TxtDuration;

	[Header("Summary")]
	public RogueSettlementStatItem[] StatItems;

	[Header("Rewards")]
	public Transform RewardRoot;

	public LiteItemUIComponent RewardItemPrefab;

	public GameObject RewardEmptyState;

	[Header("Build Review")]
	public Transform BuildRoot;

	public RogueSettlementItem BuildItemPrefab;

	public GameObject BuildEmptyState;

	[Header("Actions")]
	public ActButton BtnLeave;

	public ActButton BtnRetry;

	public ViewControlLayer ViewControlLayer;

	public ViewControlLayer RewardViewControlLayer;

	public GameObject GamePadTipsReward;

	[Header("手柄底部按键组")]
	public GamePadTipsComp gamePadTipsComp;

	private RogueMode _modeData;

	public bool HasRewards => m_RewardItems.Count > 0;

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_Data = (uiViewData as RogueSettlementViewData) ?? new RogueSettlementViewData();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		if (m_Data.FinishType == RogueFinishType.Pass)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Challenge_Success");
		}
		else
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Challenge_Fail");
		}
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void Init()
	{
		base.Init();
		m_ControlType = RogueSettlementControlType.Action;
		GetController().ResetControlType();
		BtnLeave.SetBtnClick(OnLeave);
		BtnRetry.SetBtnClick(OnRetry);
		RefreshView();
		FocusControlLayer(RogueSettlementControlType.Action, restoreLastSelection: false);
	}

	protected override void UnInit()
	{
		ClearRuntimeItems();
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public void OnLeave()
	{
		Close();
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (worldManager != null && worldManager.GetCurrentWorld()?.SceneStatus == SceneStatus.Rogue)
		{
			m_Data?.OnLeave?.Invoke();
		}
	}

	public void OnRetry()
	{
		Close();
		m_Data?.OnRetry?.Invoke();
	}

	private void RefreshView()
	{
		bool flag = m_Data.FinishType == RogueFinishType.Pass;
		TxtSettlementTitle.text = LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.RogueSettlementTitle);
		RefreshResultNodes(flag);
		RogueInfo info = Model<RogueNewModel>.Interface.Info;
		_modeData = CoreUtils.GetData(info.GameInfo.ModeId, RuntimeConfigs.data.rogueModes);
		if (_modeData != null)
		{
			TxtStageName.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, _modeData.name);
			TxtProgress.SetText("{0:0}/{1:0}", info.GameInfo.Index + 1, _modeData.mapNodeList.Length);
			TxtDuration.text = FormatDuration(m_Data.ElapsedSeconds);
			RefreshStatistics();
			RefreshTeam();
			RefreshRewards();
			RefreshBuildItems();
			BtnRetry.gameObject.SetActive(!flag);
		}
	}

	private void RefreshResultNodes(bool passed)
	{
		if (SuccessNode != null)
		{
			SuccessNode.SetActive(passed);
		}
		if (FailNode != null)
		{
			FailNode.SetActive(!passed);
		}
	}

	private void RefreshTeam()
	{
		if (TeamItems == null)
		{
			return;
		}
		for (int i = 0; i < TeamItems.Length; i++)
		{
			RogueSettlementTeamItem rogueSettlementTeamItem = TeamItems[i];
			if (!(rogueSettlementTeamItem == null))
			{
				bool flag = i < m_Data.CharacterIds.Count;
				rogueSettlementTeamItem.SetData(flag, flag ? m_Data.CharacterIds[i] : 0, i == 0, Station);
			}
		}
	}

	private void RefreshStatistics()
	{
		SetStatisticItem(0, LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.RogueSettlementMaxDamage), m_Data.MaxDamage.ToString("N0"));
		SetStatisticItem(1, LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.RogueSettlementGainCoin), m_Data.GainCoin.ToString("N0"));
		SetStatisticItem(2, LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.RogueSettlementNormalKill), m_Data.NormalKillCount.ToString());
		SetStatisticItem(3, LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.RogueSettlementEliteKill), m_Data.EliteKillCount.ToString());
	}

	private void SetStatisticItem(int index, string label, string value)
	{
		if (StatItems != null && index < StatItems.Length && !(StatItems[index] == null))
		{
			StatItems[index].SetData(label, value);
		}
	}

	private void RefreshRewards()
	{
		int num = 0;
		if (m_Data.TalentTreePoint > 0)
		{
			CreateRewardItem(87, m_Data.TalentTreePoint);
			num++;
		}
		foreach (RogueSettlementRewardData reward in m_Data.Rewards)
		{
			if (reward != null && reward.ItemId != 0 && reward.Count > 0)
			{
				CreateRewardItem(reward.ItemId, reward.Count);
				num++;
			}
		}
		RewardEmptyState.SetActive(num == 0);
		RefreshRewardDefaultSelect();
	}

	private void CreateRewardItem(int itemId, int count)
	{
		LiteItemUIComponent liteItemUIComponent = UnityEngine.Object.Instantiate(RewardItemPrefab, RewardRoot);
		liteItemUIComponent.gameObject.SetActive(value: true);
		liteItemUIComponent.Station = Station;
		liteItemUIComponent.SetData(ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemId, count), long.MinValue, ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide, autoReleaseData: true);
		liteItemUIComponent.UpdatePerformance();
		m_RewardItems.Add(liteItemUIComponent);
		m_RuntimeItems.Add(liteItemUIComponent.gameObject);
	}

	public void FocusControlLayer(RogueSettlementControlType controlType, bool restoreLastSelection)
	{
		ViewControlLayer viewControlLayer;
		if (controlType == RogueSettlementControlType.Reward)
		{
			if (!RefreshRewardDefaultSelect())
			{
				return;
			}
			viewControlLayer = RewardViewControlLayer;
		}
		else
		{
			viewControlLayer = ViewControlLayer;
		}
		if (!(viewControlLayer == null))
		{
			if (restoreLastSelection)
			{
				viewControlLayer.ReFocus();
			}
			else
			{
				viewControlLayer.Focus();
			}
			m_ControlType = controlType;
			RefreshRewardGamePadTip(MonoECS.instance.InputMode);
			RefreshGamePadTips(controlType);
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		RefreshRewardGamePadTip(type);
	}

	private void RefreshRewardGamePadTip(DeviceInputMode inputMode)
	{
		GamePadTipsReward?.SetActive(inputMode == DeviceInputMode.Gamepad && HasRewards && m_ControlType != RogueSettlementControlType.Reward);
	}

	private bool RefreshRewardDefaultSelect()
	{
		if (RewardViewControlLayer == null)
		{
			return false;
		}
		foreach (LiteItemUIComponent rewardItem in m_RewardItems)
		{
			if (!(rewardItem == null) && rewardItem.gameObject.activeInHierarchy)
			{
				ACT.ViewControl.SelectableEx componentInChildren = rewardItem.GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
				if (!(componentInChildren == null))
				{
					RewardViewControlLayer.SetDefaultSelect(componentInChildren);
					return true;
				}
			}
		}
		RewardViewControlLayer.SetDefaultSelect(null);
		return false;
	}

	private void RefreshGamePadTips(RogueSettlementControlType controlType)
	{
		if (gamePadTipsComp == null)
		{
			return;
		}
		if (controlType == RogueSettlementControlType.Reward)
		{
			gamePadTipsComp.RegisterInputActions(ShowDetailGamePadAction, GamePadTipHelper.BackAction, NavigateGamePadAction);
			return;
		}
		bool flag = BtnRetry != null && BtnRetry.gameObject.activeSelf;
		if (HasRewards)
		{
			if (flag)
			{
				gamePadTipsComp.RegisterInputActions(GamePadTipHelper.ConfirmAction, GamePadTipHelper.BackAction, NavigateGamePadAction, SelectRewardGamePadAction);
			}
			else
			{
				gamePadTipsComp.RegisterInputActions(GamePadTipHelper.ConfirmAction, GamePadTipHelper.BackAction, SelectRewardGamePadAction);
			}
		}
		else if (flag)
		{
			gamePadTipsComp.RegisterInputActions(GamePadTipHelper.ConfirmAction, GamePadTipHelper.BackAction, NavigateGamePadAction);
		}
		else
		{
			gamePadTipsComp.RegisterInputActions(GamePadTipHelper.ConfirmAction, GamePadTipHelper.BackAction);
		}
	}

	private void RefreshBuildItems()
	{
		foreach (RogueBagItemData buildItem in m_Data.BuildItems)
		{
			RogueSettlementItem rogueSettlementItem = UnityEngine.Object.Instantiate(BuildItemPrefab, BuildRoot);
			rogueSettlementItem.gameObject.SetActive(value: true);
			rogueSettlementItem.Init(buildItem.RogueItem.ItemId, RogueItemType.Prop, Station);
			m_RuntimeItems.Add(rogueSettlementItem.gameObject);
		}
		BuildEmptyState.SetActive(m_Data.BuildItems.Count == 0);
	}

	private static string FormatDuration(float seconds)
	{
		float num = Mathf.Max(seconds, 0f);
		System.DateTime dateTime;
		System.DateTime minValue;
		try
		{
			minValue = System.DateTime.MinValue;
			dateTime = minValue.AddSeconds(num);
		}
		catch (ArgumentOutOfRangeException)
		{
			dateTime = System.DateTime.MaxValue;
		}
		int year = dateTime.Year;
		minValue = System.DateTime.MinValue;
		int num2 = year - minValue.Year;
		int month = dateTime.Month;
		minValue = System.DateTime.MinValue;
		int num3 = month - minValue.Month;
		int day = dateTime.Day;
		minValue = System.DateTime.MinValue;
		int num4 = day - minValue.Day;
		int hour = dateTime.Hour;
		minValue = System.DateTime.MinValue;
		int num5 = hour - minValue.Hour;
		int minute = dateTime.Minute;
		minValue = System.DateTime.MinValue;
		int num6 = minute - minValue.Minute;
		int second = dateTime.Second;
		minValue = System.DateTime.MinValue;
		int num7 = second - minValue.Second;
		int num8 = 4;
		if (num2 > 0)
		{
			num8 = 0;
		}
		else if (num3 > 0)
		{
			num8 = 1;
		}
		else if (num4 > 0)
		{
			num8 = 2;
		}
		else if (num5 > 0)
		{
			num8 = 3;
		}
		else if (num6 > 0)
		{
			num8 = 4;
		}
		else if (num7 > 0)
		{
			num8 = 5;
		}
		int num9 = Mathf.Min(num8 + 1, 5);
		int[] array = new int[6] { num2, num3, num4, num5, num6, num7 };
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = num8; i <= num9; i++)
		{
			stringBuilder.Append(array[i]);
			stringBuilder.Append(LocalizationUtility.GetLocalizeString(DurationUnitKeys[i]));
		}
		return stringBuilder.ToString();
	}

	private void ClearRuntimeItems()
	{
		RewardViewControlLayer?.SetDefaultSelect(null);
		m_RewardItems.Clear();
		GamePadTipsReward?.SetActive(value: false);
		foreach (GameObject runtimeItem in m_RuntimeItems)
		{
			if (runtimeItem != null)
			{
				UnityEngine.Object.Destroy(runtimeItem);
			}
		}
		m_RuntimeItems.Clear();
	}

	public void PlayStartShowSound()
	{
		if (m_Data.FinishType == RogueFinishType.Pass)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Challenge_Gold");
		}
	}
}
