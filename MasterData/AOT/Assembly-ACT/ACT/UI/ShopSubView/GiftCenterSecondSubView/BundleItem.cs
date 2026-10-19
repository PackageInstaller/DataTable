using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.CommonComponent;
using ACT.UI.DataProxy;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using Runtime.UI.CommonComponent.CommonTimer;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI.ShopSubView.GiftCenterSecondSubView;

public class BundleItem : LoopScrollBaseItem
{
	public GameObject[] qualityBackgrounds;

	public GameObject monthCardQualityBackground;

	public BImage bundleIcon;

	public GameObject bestValueTag;

	[Header("返利相关")]
	public GameObject rebateTag;

	public TMP_Text rebateText;

	public PresentTotalRechargeTag presentTotalRechargeTag;

	[Space(10f)]
	public CommonTimerComponent rebateTimer;

	public GameObject remainDayRoot;

	public LocalizeStringEvent remainDayText;

	[Header("奖励列表相关")]
	public GameObject noExtraRewardRoot;

	public ItemUIComponentBase[] noExtraRewardItems;

	public GameObject extraRewardRoot;

	public LocalizeStringEvent extraRewardText;

	public ItemUIComponentBase[] extraRewardItems;

	public ItemUIComponentBase[] afterExtraRewardItems;

	public CommonPriceComponent priceComponent;

	public LocalizeStringEvent bundleName;

	public GameObject limitRoot;

	public LocalizeStringEvent purchaseLimitText;

	[Space(10f)]
	public GameObject soldOutMask;

	[Header("不满足前置条件提示")]
	public GameObject conditionTipRoot;

	public LocalizeStringEvent conditionTipText;

	public ActButton helpButton;

	public ActButton clickArea;

	[Space(10f)]
	[Header("红点")]
	public RedDotItem redDotItem;

	[Header("按键提示")]
	public OperateBtnPrompt helpBtnPrompt;

	private RectTransform _helpButtonRectTransform;

	private Vector2 _helpButtonOriginAnchoredPosition;

	private bool _helpButtonOriginCached;

	private bool _helpButtonVisible;

	private static readonly Vector2 HiddenHelpButtonAnchoredPosition = new Vector2(100000f, 100000f);

	private Bundle _bundleData;

	private MonthlyPass _monthlyPassData;

	private int _bundleId;

	public bool IsBundleMode => _bundleData != null;

	public int BundleID
	{
		get
		{
			return _bundleId;
		}
		set
		{
			_bundleId = value;
			_bundleData = CoreUtils.GetData(_bundleId, RuntimeConfigs.data.bundles);
			_monthlyPassData = null;
			if (_bundleData == null)
			{
				_monthlyPassData = CoreUtils.GetData(_bundleId, RuntimeConfigs.data.monthlyPasss);
				if (_monthlyPassData == null)
				{
					Debug.LogError($"未找到ID为{_bundleId}的礼包数据");
					return;
				}
			}
			RefreshView();
		}
	}

	public int SubShopId { get; set; }

	public int ShopId { get; set; }

	private void Awake()
	{
		helpButton.OnClick.AddListener(OnHelpButtonClick);
		clickArea.OnClick.AddListener(OnBuyButtonClick);
		MonoECS.instance.onInputModeChange.AddListener(OnDeviceChange);
		EnsureHelpButtonInitialized();
	}

	protected override void OnUnityDestroy()
	{
		base.OnUnityDestroy();
		MonoECS.instance.onInputModeChange.RemoveListener(OnDeviceChange);
		rebateTimer.OnTimeOut = null;
	}

	private void RefreshView()
	{
		UpdateQualityBackground();
		UpdateIcon();
		UpdateBundleName();
		UpdateLimitText();
		UpdateTag();
		UpdateTimer();
		UpdatePrice();
		UpdateReward();
		UpdateSoldOut();
		UpdateConditionTip();
		UpdateHelpButton();
		UpdateRedDot();
	}

	private void UpdateIcon()
	{
		if (bundleIcon != null)
		{
			int id = (IsBundleMode ? _bundleData.icon : _monthlyPassData.icon);
			Station.LoadImageAsync(213, id, bundleIcon).Forget();
		}
	}

	private void UpdateQualityBackground()
	{
		if (IsBundleMode)
		{
			if (qualityBackgrounds != null)
			{
				for (int i = 0; i < qualityBackgrounds.Length; i++)
				{
					if (qualityBackgrounds[i] != null)
					{
						qualityBackgrounds[i].SetActive(i == _bundleData.quality - 1);
					}
				}
			}
			monthCardQualityBackground.SetActive(value: false);
			return;
		}
		if (qualityBackgrounds != null)
		{
			GameObject[] array = qualityBackgrounds;
			for (int j = 0; j < array.Length; j++)
			{
				array[j].SetActive(value: false);
			}
		}
		monthCardQualityBackground.SetActive(value: true);
	}

	private void UpdateBundleName()
	{
		if (!(bundleName == null))
		{
			int num = (IsBundleMode ? _bundleData.bundlename : _monthlyPassData.bundlename);
			bundleName.SetTable(LocalizeTable.ShortCommon);
			bundleName.StringReference.TableEntryReference = num;
		}
	}

	private void UpdateLimitText()
	{
		if (purchaseLimitText == null)
		{
			return;
		}
		if (IsBundleMode)
		{
			limitRoot.SetActive(value: true);
			purchaseLimitText.SetTable("Common");
			switch (_bundleData.limitRefreshType)
			{
			case 0:
				purchaseLimitText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.PermanentLimit;
				break;
			case 1:
				purchaseLimitText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.DailyLimit;
				break;
			case 2:
				purchaseLimitText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.WeeklyLimit;
				break;
			case 3:
				purchaseLimitText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.MonthlyLimit;
				break;
			case 4:
				purchaseLimitText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.Limit;
				break;
			}
			int num = Model<ShopModel>.Interface.BundleLeftCount(_bundleId);
			purchaseLimitText.GetVariable<int>("0").Value = ((num >= 0) ? Math.Max(num, 0) : _bundleData.limitCount);
		}
		else
		{
			limitRoot.SetActive(value: false);
		}
	}

	private void UpdateTag()
	{
		if (bestValueTag != null)
		{
			bestValueTag.SetActive(value: false);
		}
		if (rebateTag != null)
		{
			rebateTag.SetActive(value: false);
		}
		SaleList data = CoreUtils.GetData(_bundleId, RuntimeConfigs.data.saleLists);
		presentTotalRechargeTag?.SetAmount(data?.eventPoint ?? 0);
		int[] array = (IsBundleMode ? _bundleData.bundletag : _monthlyPassData.mptag);
		if (array == null)
		{
			return;
		}
		if (array.Contains(1) && bestValueTag != null)
		{
			bestValueTag.SetActive(value: true);
		}
		if (array.Contains(2))
		{
			if (rebateTag != null)
			{
				rebateTag.SetActive(value: true);
			}
			if (rebateText != null)
			{
				int value = (IsBundleMode ? _bundleData.bundleoff : 0);
				rebateText.text = value.FastToString() + "%";
			}
		}
	}

	private void UpdateTimer()
	{
		remainDayRoot.SetActive(!IsBundleMode);
		rebateTimer.gameObject.SetActive(IsBundleMode);
		if (IsBundleMode)
		{
			long num = Model<ShopModel>.Interface.CommodityLeftTime(_bundleId);
			if (num < 0 || TimeSpan.FromSeconds(num).Ticks >= 3153600000000000L)
			{
				rebateTimer.gameObject.SetActive(value: false);
				return;
			}
			rebateTimer.gameObject.SetActive(value: true);
			rebateTimer.IsCountDown = true;
			CommonTimerComponent commonTimerComponent = rebateTimer;
			System.DateTime minValue = System.DateTime.MinValue;
			commonTimerComponent.Time = minValue.Add(TimeSpan.FromSeconds(num));
		}
		else if (!Model<ShopModel>.Interface.MonthlyPassValid(_monthlyPassData.id))
		{
			remainDayRoot.SetActive(value: false);
		}
		else
		{
			int num2 = Model<ShopModel>.Interface.MonthlyPassLeftCount(_monthlyPassData.id);
			if (num2 >= 0)
			{
				remainDayRoot.SetActive(value: true);
				remainDayText.SetTable("Common");
				remainDayText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.RemainDay;
				remainDayText.GetVariable<int>("0").Value = num2;
			}
			else
			{
				remainDayRoot.SetActive(value: false);
			}
		}
	}

	private void UpdatePrice()
	{
		if (priceComponent == null)
		{
			return;
		}
		int num = (IsBundleMode ? _bundleData.paytype : _monthlyPassData.paytype);
		int num2 = (IsBundleMode ? _bundleData.preprice : 0);
		int commodityId = (IsBundleMode ? _bundleData.id : _monthlyPassData.id);
		switch (num)
		{
		case 1:
		{
			ItemKv itemKv = (IsBundleMode ? _bundleData.itemNeed : _monthlyPassData.itemNeed)?.FirstOrDefault();
			if (itemKv != null)
			{
				priceComponent.Init(itemKv.id, itemKv.count, (num2 > 0) ? num2 : (-1));
			}
			break;
		}
		case 2:
			priceComponent.Init(Model<PayModel>.Interface.GetPrice(commodityId), (num2 > 0) ? num2.FastToString() : null);
			break;
		case 3:
			priceComponent.Init();
			break;
		}
	}

	private void UpdateReward()
	{
		if (!IsBundleMode)
		{
			if (extraRewardRoot != null)
			{
				extraRewardRoot.SetActive(value: false);
			}
			if (noExtraRewardRoot != null)
			{
				noExtraRewardRoot.SetActive(value: false);
			}
			HideAllItems(extraRewardItems);
			HideAllItems(noExtraRewardItems);
			HideAllItems(afterExtraRewardItems);
			return;
		}
		List<ItemKv> list = (IsBundleMode ? _bundleData.bundleitem : _monthlyPassData.item);
		List<ItemKv> list2 = (IsBundleMode ? _bundleData.multiitem : _monthlyPassData.itemdaily);
		bool flag = list2 != null && list2.Count > 0;
		if (list == null || list.Count <= 0)
		{
			if (extraRewardRoot != null)
			{
				extraRewardRoot.SetActive(value: false);
			}
			if (noExtraRewardRoot != null)
			{
				noExtraRewardRoot.SetActive(value: false);
			}
			HideAllItems(extraRewardItems);
			HideAllItems(noExtraRewardItems);
			HideAllItems(afterExtraRewardItems);
			return;
		}
		if (flag)
		{
			if (noExtraRewardRoot != null)
			{
				noExtraRewardRoot.SetActive(value: false);
			}
			if (extraRewardRoot != null)
			{
				extraRewardRoot.SetActive(value: true);
			}
			if (extraRewardText != null)
			{
				int value = (IsBundleMode ? _bundleData.offerday : _monthlyPassData.offerday);
				extraRewardText.SetTable("Common");
				extraRewardText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.XDayMailGet;
				extraRewardText.GetVariable<int>("0").Value = value;
			}
			if (extraRewardItems != null)
			{
				for (int i = 0; i < extraRewardItems.Length; i++)
				{
					if (!(extraRewardItems[i] == null))
					{
						if (i < list.Count)
						{
							extraRewardItems[i].gameObject.SetActive(value: true);
							ItemKv itemKv = list[i];
							ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemKv.id, itemKv.count);
							extraRewardItems[i].SetData(item, long.MinValue, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
							extraRewardItems[i].UpdatePerformance();
						}
						else
						{
							extraRewardItems[i].gameObject.SetActive(value: false);
						}
					}
				}
			}
			if (afterExtraRewardItems == null)
			{
				return;
			}
			for (int j = 0; j < afterExtraRewardItems.Length; j++)
			{
				if (!(afterExtraRewardItems[j] == null))
				{
					if (j < list2.Count)
					{
						afterExtraRewardItems[j].gameObject.SetActive(value: true);
						ItemKv itemKv2 = list2[j];
						ItemUnifierProxy item2 = ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemKv2.id, itemKv2.count);
						afterExtraRewardItems[j].SetData(item2, long.MinValue, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
						afterExtraRewardItems[j].UpdatePerformance();
					}
					else
					{
						afterExtraRewardItems[j].gameObject.SetActive(value: false);
					}
				}
			}
			return;
		}
		if (extraRewardRoot != null)
		{
			extraRewardRoot.SetActive(value: false);
		}
		if (noExtraRewardRoot != null)
		{
			noExtraRewardRoot.SetActive(value: true);
		}
		if (noExtraRewardItems == null)
		{
			return;
		}
		for (int k = 0; k < noExtraRewardItems.Length; k++)
		{
			if (!(noExtraRewardItems[k] == null))
			{
				if (k < list.Count)
				{
					noExtraRewardItems[k].gameObject.SetActive(value: true);
					ItemKv itemKv3 = list[k];
					ItemUnifierProxy item3 = ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemKv3.id, itemKv3.count);
					noExtraRewardItems[k].SetData(item3, long.MinValue, ItemUIComponentBase.InitType.BagItem, ItemUIComponentBase.ItemCountShowType.OneSide);
					noExtraRewardItems[k].UpdatePerformance();
				}
				else
				{
					noExtraRewardItems[k].gameObject.SetActive(value: false);
				}
			}
		}
	}

	private void HideAllItems(ItemUIComponentBase[] items)
	{
		if (items == null)
		{
			return;
		}
		for (int i = 0; i < items.Length; i++)
		{
			if (items[i] != null)
			{
				items[i].gameObject.SetActive(value: false);
			}
		}
	}

	private void UpdateSoldOut()
	{
		if (soldOutMask != null)
		{
			soldOutMask.SetActive(Model<ShopModel>.Interface.BundleLeftCount(_bundleId) == 0);
		}
	}

	private void UpdateConditionTip()
	{
		if (!IsBundleMode)
		{
			conditionTipRoot.SetActive(value: false);
			return;
		}
		int missionGroupId = _bundleData.missionGroupId;
		if (missionGroupId == 0)
		{
			conditionTipRoot.SetActive(value: false);
			return;
		}
		if (Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(missionGroupId))
		{
			conditionTipRoot.SetActive(value: false);
			return;
		}
		MissionGroup data = CoreUtils.GetData(missionGroupId, RuntimeConfigs.data.missionGroups);
		if (data != null)
		{
			conditionTipRoot.SetActive(value: true);
			conditionTipText.SetTable("shortcommon");
			conditionTipText.StringReference.TableEntryReference = data.groupDes;
		}
	}

	private void OnDeviceChange(DeviceInputMode arg0)
	{
		UpdateHelpButton();
	}

	private void UpdateHelpButton()
	{
		EnsureHelpButtonInitialized();
		bool visible = (_helpButtonVisible = MonoECS.instance.InputMode != DeviceInputMode.Gamepad && !IsBundleMode && !helpBtnPrompt.CouldDisplay);
		if ((bool)helpButton)
		{
			UpdateHelpButtonVisibleState(visible);
		}
		if ((bool)helpBtnPrompt)
		{
			helpBtnPrompt.SetVisible(!IsBundleMode);
		}
	}

	private void EnsureHelpButtonInitialized()
	{
		if (!(helpButton == null))
		{
			if ((object)_helpButtonRectTransform == null)
			{
				_helpButtonRectTransform = helpButton.transform as RectTransform;
			}
			if (!_helpButtonOriginCached && _helpButtonRectTransform != null)
			{
				_helpButtonOriginAnchoredPosition = _helpButtonRectTransform.anchoredPosition;
				_helpButtonOriginCached = true;
			}
			if (!helpButton.gameObject.activeSelf)
			{
				helpButton.gameObject.SetActive(value: true);
			}
		}
	}

	private void UpdateHelpButtonVisibleState(bool visible)
	{
		if (!(helpButton == null) && !(_helpButtonRectTransform == null) && _helpButtonOriginCached)
		{
			_helpButtonRectTransform.anchoredPosition = (visible ? _helpButtonOriginAnchoredPosition : HiddenHelpButtonAnchoredPosition);
		}
	}

	private void UpdateRedDot()
	{
		if (redDotItem == null)
		{
			return;
		}
		if (!IsBundleMode)
		{
			redDotItem.gameObject.SetActive(value: false);
			return;
		}
		int shopId = GetShopId();
		if (shopId == 0 || SubShopId == 0)
		{
			redDotItem.gameObject.SetActive(value: false);
			return;
		}
		string text = $"{RedDotPathDefine.Shop}|{shopId}|{SubShopId}|{_bundleData.id}";
		if (!Singleton<RedDotManager>.instance.IsPathRegistered(text))
		{
			Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(text, active: false, 1027);
		}
		redDotItem.InitRedDot(text);
	}

	private int GetShopId()
	{
		if (ShopId != 0)
		{
			return ShopId;
		}
		foreach (KeyValuePair<int, ShopData> shopData in RuntimeConfigs.data.shopDatas)
		{
			ShopData value = shopData.Value;
			if (value?.subshopIds != null && value.subshopIds.Contains(SubShopId))
			{
				return value.id;
			}
		}
		return 0;
	}

	private void OnBuyButtonClick()
	{
		if ((bool)soldOutMask && soldOutMask.activeSelf)
		{
			return;
		}
		if (!IsBundleMode)
		{
			ShopEventTrackHelper.Dispatch(SubShopId, 3, _monthlyPassData.id, 1);
			int num = Model<ShopModel>.Interface.MonthlyPassLeftCount(_monthlyPassData.id);
			if (_monthlyPassData.limitday < num)
			{
				ShopEventTrackHelper.Dispatch(SubShopId, 5, _monthlyPassData.id, 1);
				GameUtility.OpenToolTip(2641, "Common", new List<string> { _monthlyPassData.limitday.FastToString() });
				return;
			}
			ShopEventTrackHelper.Dispatch(SubShopId, 4, _monthlyPassData.id, 1);
			Model<PayModel>.Interface.SendOrder(_monthlyPassData.id, SubShopId, (bool isSuccess, CreatOrderAck result) =>
			{
				if (isSuccess)
				{
					Debug.Log("订单创建成功，订单号：" + result);
					PayModel payModel = Model<PayModel>.Interface;
					payModel.OnPaySuccess = (Action<string>)Delegate.Combine(payModel.OnPaySuccess, new Action<string>(OnPaySuccess));
				}
				else
				{
					ShopEventTrackHelper.Dispatch(SubShopId, 5, _monthlyPassData.id, 1);
					Debug.LogError("订单创建失败");
				}
				void OnPaySuccess(string orderId)
				{
					if (result == null || !(orderId != result.OrderId))
					{
						PayModel payModel2 = Model<PayModel>.Interface;
						payModel2.OnPaySuccess = (Action<string>)Delegate.Remove(payModel2.OnPaySuccess, new Action<string>(OnPaySuccess));
						ShopEventTrackHelper.Dispatch(SubShopId, 6, _monthlyPassData.id, 1);
					}
				}
			});
		}
		else
		{
			switch (_bundleData.type)
			{
			case 2:
			case 3:
			case 5:
				ShopEventTrackHelper.Dispatch(SubShopId, 3, _bundleData.id, 1);
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BUNDLEPURCHASE, new BundlePurchaseViewData
				{
					SubShopId = SubShopId,
					BundleId = _bundleData.id
				});
				break;
			case 4:
				ShopEventTrackHelper.Dispatch(SubShopId, 3, _bundleData.id, 1);
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SELFSELECTBUNDLEPURCHASE, new SelfSelectBundlePurchaseViewData
				{
					SubShopId = SubShopId,
					BundleId = _bundleData.id
				});
				break;
			}
		}
	}

	private void OnHelpButtonClick()
	{
		if (helpBtnPrompt.CouldDisplay || _helpButtonVisible)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
			{
				iconId = 1027,
				titleTextId = _monthlyPassData.bundlename,
				descTextId = _monthlyPassData.bundledetail
			});
		}
	}
}
