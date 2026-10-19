using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI.Interface;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI.WildBossBattle;

public class WildBossBattleTabView : BaseTabContent, RaidTabViewInterface
{
	[SerializeField]
	private LoopVerticalScrollRect rightBossInfos;

	[SerializeField]
	private LocalizeStringEvent leftRemainReceiveTimesText;

	[SerializeField]
	public ActButton leftAddReceiveTimesBtn;

	[SerializeField]
	public ActButton helpBtn;

	[SerializeField]
	public Transform content;

	private RaidTabView _raidTabView;

	private ActButton _activeButton;

	private List<int> _wildBossUseIds;

	public int DefaultSelectedAreaID { get; set; }

	private void Awake()
	{
		leftAddReceiveTimesBtn.OnClick.AddListener(OnAddReceiveTimesBtnClick);
		helpBtn.gameObject.SetActive(Model<WildBossModel>.Interface.RaidMessageId != 0);
		helpBtn.OnClick.AddListener(OnHelpBtnClick);
	}

	private void OnHelpBtnClick()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
		{
			iconId = 1008,
			titleTextId = Model<WildBossModel>.Interface.RaidTitleId,
			descTextId = Model<WildBossModel>.Interface.RaidMessageId
		});
	}

	private void OnAddReceiveTimesBtnClick()
	{
		if (Model<WildBossModel>.Interface.CanBuyMaxCount <= 0)
		{
			GameUtility.OpenToolTip(LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.WildBossRewardMax));
			return;
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPWILDBOSSBUYREWARD, new PopUpWildBossBuyRewardViewData
		{
			OnBuySuccessAction = () =>
			{
				UpdateRewardText();
				Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_POPUPWILDBOSSBUYREWARD);
			}
		});
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		_wildBossUseIds = ListPool<int>.Get();
		foreach (KeyValuePair<int, WildBossUse> wildBossUse in RuntimeConfigs.data.wildBossUses)
		{
			_wildBossUseIds.Add(wildBossUse.Key);
		}
		_wildBossUseIds.Sort(CompareWildBossUnlockState);
		rightBossInfos.OnItemShow.AddListener(OnBossInfoItemShow);
		UpdateContent();
		HideHandbookPower();
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		base.OnTabDeActive(tabItem);
		rightBossInfos.OnItemShow.RemoveListener(OnBossInfoItemShow);
		if (_wildBossUseIds != null)
		{
			ListPool<int>.Release(_wildBossUseIds);
			_wildBossUseIds = null;
		}
		ShowHandbookPower();
	}

	private void UpdateContent()
	{
		rightBossInfos.totalCount = _wildBossUseIds.Count;
		rightBossInfos.RefillCells();
		ScrollToDefaultSelectedArea();
		PlayBossInfoItemAnimation();
		UpdateRewardText();
	}

	private void ScrollToDefaultSelectedArea()
	{
		if (DefaultSelectedAreaID != 0)
		{
			int num = _wildBossUseIds.IndexOf(DefaultSelectedAreaID);
			DefaultSelectedAreaID = 0;
			if (num >= 0)
			{
				rightBossInfos.ScrollToCell(num, 0f);
			}
		}
	}

	private void OnBossInfoItemShow(ILoopScrollDataSource arg0)
	{
		if (arg0 is WildBossInfoItem wildBossInfoItem)
		{
			wildBossInfoItem.WildBossId = _wildBossUseIds[wildBossInfoItem.index];
			wildBossInfoItem.OnSelectItem = OnSelectItem;
		}
	}

	private int CompareWildBossUnlockState(int left, int right)
	{
		bool flag = IsWildBossUnlocked(left);
		bool flag2 = IsWildBossUnlocked(right);
		if (flag != flag2)
		{
			return flag2.CompareTo(flag);
		}
		return left.CompareTo(right);
	}

	private bool IsWildBossUnlocked(int wildBossUseId)
	{
		WildBossUse data = CoreUtils.GetData(wildBossUseId, RuntimeConfigs.data.wildBossUses);
		if (data != null)
		{
			return Model<MonsterHandModel>.Interface.WildBossUnLock(data.monsterID);
		}
		return false;
	}

	private void PlayBossInfoItemAnimation()
	{
		for (int i = 0; i < rightBossInfos.Children.Count; i++)
		{
			rightBossInfos.Children[i].GetComponent<WildBossInfoItem>().PlayCustomAnimation((float)i * 0.05f);
		}
	}

	private void UpdateRewardText()
	{
		leftRemainReceiveTimesText.SetTable("Common");
		leftRemainReceiveTimesText.GetVariable<int>("0").Value = Model<WildBossModel>.Interface.CanTakeRewardCount;
		leftRemainReceiveTimesText.GetVariable<int>("1").Value = Model<WildBossModel>.Interface.BaseTakeRewardCount;
	}

	private void HideHandbookPower()
	{
		if (Singleton<NewUIManager>.instance.GetTopActivePanel().GetUIView() is MonoHandbookView monoHandbookView)
		{
			monoHandbookView.costPowerBar.gameObject.SetActive(value: false);
		}
	}

	private void ShowHandbookPower()
	{
		if (Singleton<NewUIManager>.instance.GetTopActivePanel().GetUIView() is MonoHandbookView monoHandbookView)
		{
			monoHandbookView.costPowerBar.gameObject.SetActive(value: true);
		}
	}

	public void SetParentView(RaidTabView raidTabView)
	{
		_raidTabView = raidTabView;
	}

	private void OnSelectItem(WildBossInfoItem item)
	{
		if (item._unlockRoot.activeSelf && item._rewardScrollBag.ItemSource != null && item._rewardScrollBag.ItemSource.Any())
		{
			_raidTabView.SetParentRewardContent(item._rewardScrollBag.transform.GetComponent<ViewControlLayer>());
		}
		else
		{
			_raidTabView.SetParentRewardContent(null);
		}
		_activeButton = (item._unlockRoot.activeSelf ? item._confirmButton1 : item._confirmButton2);
	}

	public ActButton GetActiveSelectButton()
	{
		return _activeButton;
	}
}
