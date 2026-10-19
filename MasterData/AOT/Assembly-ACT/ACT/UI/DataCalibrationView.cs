using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.UI.DataProxy;
using ACT.UI.Interface;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent;
using Runtime.UI.CommonComponent.CommonScrollBag;
using Runtime.UI.CommonComponent.CommonTimer;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class DataCalibrationView : BaseTabContent, RaidTabViewInterface
{
	[SerializeField]
	private BImage _raidBanner;

	[SerializeField]
	private LocalizeStringEvent _mainTitle;

	[SerializeField]
	private CommonNumberComponent _leftRewardCount;

	[SerializeField]
	public ActButton shopButton;

	[SerializeField]
	private ActButton helpButton;

	[SerializeField]
	public CommonScrollBagComponent _rewardBag;

	[SerializeField]
	private CommonCoinComponent _costComponent;

	[SerializeField]
	private CommonTimerComponent _timer;

	[SerializeField]
	public ActButton _confirmButton;

	[SerializeField]
	public Transform content;

	private List<ItemUnifierProxy> _rewards;

	private RaidTypeData _raidTypeData;

	private RaidTabView _raidTabView;

	private void Awake()
	{
		_rewards = ListPool<ItemUnifierProxy>.Get();
		_confirmButton.OnClick.AddListener(OnConfirmClick);
		shopButton.OnClick.AddListener(OnClickShopButton);
		helpButton.OnClick.AddListener(OnClickHelpButton);
	}

	protected override void OnRelease()
	{
		base.OnRelease();
		ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
		ListPool<ItemUnifierProxy>.Release(_rewards);
		_rewards = null;
		_confirmButton.OnClick.RemoveListener(OnConfirmClick);
		shopButton.OnClick.RemoveListener(OnClickShopButton);
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		ITabItem tab = Tab;
		RaidSubTab raidSubTab = tab as RaidSubTab;
		if ((object)raidSubTab != null)
		{
			_raidTypeData = RuntimeConfigs.data.raidTypeDatas.FirstOrDefault((KeyValuePair<int, RaidTypeData> x) => raidSubTab.HbContent.raidNewType.Contains(x.Value.raidType)).Value;
			if (_raidTypeData != null)
			{
				UpdateTitle();
				UpdateBanner();
				UpdateRewardBag();
				UpdateTimer();
				UpdateRewardCount();
				UpdateCoseCell();
				helpButton.gameObject.SetActive(raidSubTab.HbContent.message != 0);
			}
		}
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		base.OnTabDeActive(tabItem);
		_raidTabView.SetLayerStatus(HandBookSubController.raidMain, refocus: true);
		_raidTabView.ResetLayerDefault(HandBookSubController.raidNoFocusContent);
	}

	private void UpdateTitle()
	{
		_mainTitle.SetTable(LocalizeTable.LongCommon);
		_mainTitle.StringReference.TableEntryReference = _raidTypeData.titleText;
	}

	private void UpdateBanner()
	{
		Station.LoadImageAsync(107, _raidTypeData.raidBanner, _raidBanner).Forget();
	}

	private void UpdateRewardBag()
	{
		List<ItemKv> rewardPreview = _raidTypeData.rewardPreview;
		if (rewardPreview == null || rewardPreview.Count <= 0)
		{
			_rewardBag.gameObject.SetActive(value: false);
			return;
		}
		_rewardBag.gameObject.SetActive(value: true);
		ItemUnifierProxy.ItemUnifierPool.Release(_rewards);
		foreach (ItemKv item in rewardPreview)
		{
			_rewards.Add(ItemUnifierProxy.ItemUnifierPool.Get<Item>(item.id, item.count));
		}
		_rewardBag.ItemSource = _rewards;
		_rewardBag.ItemShowType = ItemUIComponentBase.InitType.BagItem;
		_rewardBag.CountShowType = ItemUIComponentBase.ItemCountShowType.Hide;
	}

	private void UpdateTimer()
	{
		_timer.gameObject.SetActive(value: true);
		_timer.Time = GetCurRaidTime(_raidTypeData.cycleType);
		_timer.IsCountDown = true;
	}

	private void UpdateRewardCount()
	{
		_leftRewardCount.gameObject.SetActive(value: true);
		int leftTimesByTypeId = GetLeftTimesByTypeId(_raidTypeData.id);
		_leftRewardCount.UpdateNumber(leftTimesByTypeId, _raidTypeData.cycleParm[1]);
		ColorUtility.TryParseHtmlString((leftTimesByTypeId > 0) ? "#FFFFFF" : "#E42A20", out var color);
		_leftRewardCount.numberText.color = color;
	}

	private void UpdateCoseCell()
	{
		List<ItemKv> cost = _raidTypeData.cost;
		if (cost != null && cost.Count > 0)
		{
			ItemKv itemKv = cost.First();
			_costComponent.customId = itemKv.id;
			_costComponent.Init(itemKv.count);
		}
	}

	private void OnConfirmClick()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_RAID, new MonoRaidViewData
		{
			RaidEntranceId = 501
		});
	}

	private void OnClickShopButton()
	{
		RuntimeJumpData jumpData = new RuntimeJumpData
		{
			ModelType = LuminModelType.Shops,
			JumpType = 2,
			Params = new List<int>
			{
				JumpModel.UITypeToUIJumpIdMap[UI_TYPE.UI_SHOP],
				6
			}
		};
		JumpResult jumpResult = Model<JumpModel>.Interface.CanJump(jumpData);
		if (jumpResult.ShowType == JumpResult.JumpShowType.CanJump)
		{
			jumpData.FromSystem = SystemType.Raid;
			Model<JumpModel>.Interface.JumpTo(jumpData);
		}
		else
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.SystemLock);
		}
		jumpResult.Release();
	}

	private void OnClickHelpButton()
	{
		HbContent data = CoreUtils.GetData(Tab.TabIdentify, RuntimeConfigs.data.hbContents);
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
		{
			iconId = 1028,
			titleTextId = data.contentName,
			descTextId = data.message
		});
	}

	private System.DateTime GetCurRaidTime(int type)
	{
		System.DateTime now = TimeManager.LocalTime.Now;
		int num = 4;
		switch (type)
		{
		case 1:
		{
			System.DateTime dateTime2 = new System.DateTime(now.Year, now.Month, now.Day, num, 0, 0, DateTimeKind.Utc);
			System.DateTime dateTime = ((!(now < dateTime2)) ? dateTime2.AddDays(1.0) : dateTime2);
			System.DateTime minValue = System.DateTime.MinValue;
			return minValue.Add(dateTime - now);
		}
		case 2:
		{
			DayOfWeek dayOfWeek = now.DayOfWeek;
			int num2 = ((dayOfWeek != DayOfWeek.Monday) ? ((int)(1 - dayOfWeek + 7) % 7) : ((now.Hour >= num) ? 7 : 0));
			System.DateTime dateTime = ((num2 != 0) ? now.Date.AddDays(num2).AddHours(num) : new System.DateTime(now.Year, now.Month, now.Day, num, 0, 0, DateTimeKind.Utc));
			if (dateTime <= now)
			{
				dateTime = dateTime.AddDays(7.0);
			}
			System.DateTime minValue = System.DateTime.MinValue;
			return minValue.Add(dateTime - now);
		}
		case 3:
		{
			System.DateTime dateTime = ((now.Day != 1 || now.Hour >= num) ? new System.DateTime(now.Year, now.Month, 1, 0, 0, 0, DateTimeKind.Utc).AddMonths(1).AddHours(num) : new System.DateTime(now.Year, now.Month, 1, num, 0, 0, DateTimeKind.Utc));
			System.DateTime minValue = System.DateTime.MinValue;
			return minValue.Add(dateTime - now);
		}
		default:
			return System.DateTime.MinValue;
		}
	}

	private int GetUsedTimesByEntryId(int entranceId)
	{
		RaidEntranceData raidEntranceData = RuntimeConfigs.data.raidEntranceDatas[entranceId];
		int num = 0;
		int[] raidId = raidEntranceData.raidId;
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

	private int GetLeftTimesByTypeId(int typeId)
	{
		RaidTypeData raidTypeData = RuntimeConfigs.data.raidTypeDatas[typeId];
		int num = 0;
		int[] raidEntranceId = raidTypeData.raidEntranceId;
		foreach (int entranceId in raidEntranceId)
		{
			num += GetUsedTimesByEntryId(entranceId);
		}
		return raidTypeData.cycleParm[1] - num;
	}

	public void SetParentView(RaidTabView raidTabView)
	{
		_raidTabView = raidTabView;
	}

	public ActButton GetActiveSelectButton()
	{
		return _confirmButton;
	}
}
