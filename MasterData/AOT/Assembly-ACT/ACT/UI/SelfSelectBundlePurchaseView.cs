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
using ACT.UI.InputController.SelfSelectBundlePurchaseInputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Fundamental;
using Pb;
using Runtime.UI.CommonComponent;
using Runtime.UI.CommonComponent.CommonScrollBag;
using Runtime.UI.CommonComponent.CommonTimer;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class SelfSelectBundlePurchaseView : BaseUIView<SelfSelectBundlePurchaseViewInputController>
{
	public CommonCoinComponent coinComponent;

	public GameObject[] qualityBackgrounds;

	public GameObject bestValueTag;

	[Header("返利相关")]
	public GameObject rebateTag;

	public TMP_Text rebateText;

	[Space(10f)]
	public CommonTimerComponent timerComponent;

	public LocalizeStringEvent purchaseLimitText;

	public BImage bundleIcon;

	public LocalizeStringEvent bundleNameText;

	public CommonPriceComponent priceComponent;

	public CommonScrollBagComponent selfSelectBag;

	public CommonScrollBagComponent selectedBag;

	public LocalizeStringEvent selectedCountText;

	public ActButton buyBtn;

	[Header("超限提示")]
	public GameObject limitTextTipRoot;

	public LocalizeStringEvent limitTextTip;

	[Header("输入相关")]
	public ViewControlLayer rewardLayer;

	public ViewControlLayer btnGroupLayer;

	public GamePadTipsComp gamePadTipsComp;

	private Bundle _bundleData;

	private ItemUnifierProxy[] _selectedItemArray;

	private bool _shopEventFinished;

	private string _pendingOrderId;

	private SelfSelectBundlePurchaseViewData m_data => uiViewData as SelfSelectBundlePurchaseViewData;

	private void Awake()
	{
		buyBtn.SetBtnClick(OnBuy);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation?.GetSequence("Show")?.Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation?.GetSequence("Hide")?.Play();
	}

	protected override void Init()
	{
		base.Init();
		_bundleData = CoreUtils.GetData(m_data.BundleId, RuntimeConfigs.data.bundles);
		if (_bundleData == null)
		{
			Debug.LogError($"SelfSelectBundlePurchaseView RefreshView Fail, bundleData is null, bundleId: {m_data.BundleId}");
			return;
		}
		_shopEventFinished = false;
		_pendingOrderId = null;
		_selectedItemArray = new ItemUnifierProxy[_bundleData.selectnum];
		for (int i = 0; i < _selectedItemArray.Length; i++)
		{
			_selectedItemArray[i] = ItemUnifierProxy.Empty;
		}
		UpdateCoinComponent();
		UpdatePrice();
		UpdateTag();
		UpdateTimer();
		UpdateSelectableRewardBag();
		UpdateSelectedRewardBag();
		UpdateIcon();
		UpdateBundleName();
		UpdateQualityBackGround();
		UpdateLimitText();
		UpdateButton();
		UpdateSelectCountText();
		HideHoldingLimitTip();
	}

	protected override void UnInit()
	{
		if (_pendingOrderId != null)
		{
			PayModel payModel = Model<PayModel>.Interface;
			payModel.OnPaySuccess = (Action<string>)Delegate.Remove(payModel.OnPaySuccess, new Action<string>(OnPaySuccess));
			_pendingOrderId = null;
		}
		if (!_shopEventFinished && _bundleData != null)
		{
			DispatchShopBuyEvent(5);
		}
		base.UnInit();
	}

	private void UpdateCoinComponent()
	{
		bool active = _bundleData.paytype == 1;
		coinComponent.gameObject.SetActive(active);
	}

	private void UpdatePrice()
	{
		int preprice = _bundleData.preprice;
		if (_bundleData.paytype == 1)
		{
			ItemKv itemKv = _bundleData.itemNeed.FirstOrDefault();
			if (itemKv != null)
			{
				priceComponent.Init(itemKv.id, itemKv.count, (preprice > 0) ? preprice : (-1));
			}
		}
		else
		{
			priceComponent.Init(Model<PayModel>.Interface.GetPrice(_bundleData.id), (preprice > 0) ? preprice.FastToString() : null);
		}
	}

	private void UpdateTag()
	{
		bestValueTag.SetActive(value: false);
		rebateTag.SetActive(value: false);
		if (_bundleData.bundletag.Contains(1))
		{
			bestValueTag.SetActive(value: true);
		}
		if (_bundleData.bundletag.Contains(2))
		{
			rebateTag.SetActive(value: true);
			rebateText.text = _bundleData.bundleoff.FastToString() + "%";
		}
	}

	private void UpdateTimer()
	{
		long num = Model<ShopModel>.Interface.CommodityLeftTime(_bundleData.id);
		if (num < 0 || TimeSpan.FromSeconds(num).Ticks >= 3153600000000000L)
		{
			timerComponent.gameObject.SetActive(value: false);
			return;
		}
		timerComponent.gameObject.SetActive(value: true);
		timerComponent.IsCountDown = true;
		CommonTimerComponent commonTimerComponent = timerComponent;
		System.DateTime minValue = System.DateTime.MinValue;
		commonTimerComponent.Time = minValue.Add(TimeSpan.FromSeconds(num));
	}

	private void UpdateSelectableRewardBag()
	{
		int selectnum = _bundleData.selectnum;
		List<ItemKv> selectitem = _bundleData.selectitem;
		if (selectnum <= 0 || selectitem == null || selectitem.Count <= 0 || selfSelectBag == null)
		{
			return;
		}
		CommonScrollBagComponent commonScrollBagComponent = selfSelectBag;
		if (commonScrollBagComponent.ItemSource == null)
		{
			IEnumerable<ItemUnifierProxy> enumerable = (commonScrollBagComponent.ItemSource = new List<ItemUnifierProxy>());
		}
		if (selfSelectBag.ItemSource is List<ItemUnifierProxy> list)
		{
			list.Clear();
			foreach (ItemKv item2 in selectitem)
			{
				ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(item2.id, item2.count);
				list.Add(item);
			}
			selfSelectBag.ItemSource = list;
			selfSelectBag.SelectedModels.Clear();
		}
		selfSelectBag.SelectMode = CommonScrollBagComponent.SelectModeType.MultipleRepeat;
		selfSelectBag.ItemShowType = ItemUIComponentBase.InitType.BagItem;
		selfSelectBag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		selfSelectBag.OnItemShow = (ItemUIComponentBase x) =>
		{
			if (x is SelfSelectItemUIComponent itemUIComponent)
			{
				RefreshSelfSelectItemState(itemUIComponent);
			}
		};
		selfSelectBag.OnItemSelect = (ItemUIComponentBase x) =>
		{
			if (x is SelfSelectItemUIComponent selfSelectItemUIComponent)
			{
				if (selfSelectItemUIComponent.limitMask != null && selfSelectItemUIComponent.limitMask.activeSelf)
				{
					selfSelectBag.SelectedModels.Remove(x.ItemUnifier);
					ShowItemLimitReachedToolTip(selfSelectItemUIComponent.ItemUnifier.Id);
					RefreshSelfSelectItemState(selfSelectItemUIComponent);
					HideHoldingLimitTip();
				}
				else
				{
					int num = -1;
					for (int i = 0; i < _selectedItemArray.Length; i++)
					{
						if (_selectedItemArray[i].Equals(ItemUnifierProxy.Empty))
						{
							num = i;
							break;
						}
					}
					if (num == -1)
					{
						selfSelectBag.SelectedModels.Remove(x.ItemUnifier);
						HideHoldingLimitTip();
					}
					else
					{
						_selectedItemArray[num] = selfSelectItemUIComponent.ItemUnifier;
						UpdateSelectedRewardBag();
						UpdateHoldingLimitTip(selfSelectItemUIComponent.ItemUnifier);
					}
					RefreshSelfSelectItemState(selfSelectItemUIComponent);
				}
			}
		};
		selfSelectBag.OnItemUnSelect = (ItemUIComponentBase x) =>
		{
			if (x is SelfSelectItemUIComponent selfSelectItemUIComponent)
			{
				int num = -1;
				for (int num2 = _selectedItemArray.Length - 1; num2 >= 0; num2--)
				{
					if (_selectedItemArray[num2].Equals(selfSelectItemUIComponent.ItemUnifier))
					{
						num = num2;
						break;
					}
				}
				if (num != -1)
				{
					_selectedItemArray[num] = ItemUnifierProxy.Empty;
					UpdateSelectedRewardBag();
				}
				RefreshSelfSelectItemState(selfSelectItemUIComponent);
				UpdateHoldingLimitTip(selfSelectItemUIComponent.ItemUnifier);
			}
		};
	}

	private void RefreshSelfSelectItemState(SelfSelectItemUIComponent itemUIComponent)
	{
		int selectedCount = selfSelectBag.GetSelectedCount(itemUIComponent.ItemUnifier);
		itemUIComponent.SetSelectCount(selectedCount);
		itemUIComponent.RefreshItemLimitMask(selectedCount);
	}

	private void ShowItemLimitReachedToolTip(int itemId)
	{
		ItemData data = CoreUtils.GetData(itemId, RuntimeConfigs.data.itemDatas);
		string item = ((data == null) ? string.Empty : LocalizationUtility.GetLocalizeString("shortcommon", data.nameLocal));
		GameUtility.OpenToolTip(2843, "Common", new List<string> { item });
	}

	private void HideHoldingLimitTip()
	{
		if (limitTextTipRoot != null)
		{
			limitTextTipRoot.SetActive(value: false);
		}
	}

	private void UpdateHoldingLimitTip(ItemUnifierProxy itemUnifier)
	{
		if (limitTextTipRoot == null || limitTextTip == null)
		{
			return;
		}
		if (itemUnifier == null || itemUnifier.Equals(ItemUnifierProxy.Empty) || !_selectedItemArray.Contains(itemUnifier))
		{
			HideHoldingLimitTip();
			return;
		}
		int num = 0;
		for (int i = 0; i < _selectedItemArray.Length; i++)
		{
			if (_selectedItemArray[i].Equals(ItemUnifierProxy.Empty))
			{
				num++;
			}
		}
		if (num <= 0)
		{
			HideHoldingLimitTip();
			return;
		}
		if (!TryGetRemainingSelectableTimes(itemUnifier, out var remainingSelectableTimes))
		{
			HideHoldingLimitTip();
			return;
		}
		if (num <= remainingSelectableTimes)
		{
			HideHoldingLimitTip();
			return;
		}
		ItemData data = CoreUtils.GetData(itemUnifier.Id, RuntimeConfigs.data.itemDatas);
		string value = ((data == null) ? string.Empty : LocalizationUtility.GetLocalizeString("shortcommon", data.nameLocal));
		ItemType itemType = ((data == null) ? null : CoreUtils.GetData(data.type, RuntimeConfigs.data.itemTypes));
		int num2 = Math.Max(selfSelectBag.GetSelectedCount(itemUnifier), 0);
		long num3 = Math.Max(itemUnifier.Count, 1L) * (num2 + num);
		int gainCount = (int)((num3 > int.MaxValue) ? int.MaxValue : num3);
		GameUtility.CheckItemQuantityOwnedIsValid(itemUnifier.Id, gainCount, out var _);
		limitTextTip.SetTable("Common");
		limitTextTip.StringReference.TableEntryReference = ((itemType != null && itemType.CanOverflowConvert) ? LocalizationCommonData.CommonString.HoldingLimitReachedWillConvertNoPunctuation : LocalizationCommonData.CommonString.HoldingLimitReachedCanSelect);
		limitTextTip.GetVariable<string>("0").Value = value;
		limitTextTip.GetVariable<int>("1").Value = remainingSelectableTimes;
		limitTextTipRoot.SetActive(value: true);
	}

	private bool TryGetRemainingSelectableTimes(ItemUnifierProxy itemUnifier, out int remainingSelectableTimes)
	{
		remainingSelectableTimes = 0;
		ItemData data = CoreUtils.GetData(itemUnifier.Id, RuntimeConfigs.data.itemDatas);
		if (data == null)
		{
			return false;
		}
		ItemType data2 = CoreUtils.GetData(data.type, RuntimeConfigs.data.itemTypes);
		if (data2 == null)
		{
			return false;
		}
		GameUtility.CheckItemQuantityOwnedIsValid(itemUnifier.Id, 0, out var result);
		if (result.maxNum <= 0 || result.leftCount < 0)
		{
			return false;
		}
		long num = Math.Max(itemUnifier.Count, 1L);
		int num2 = Math.Max(selfSelectBag.GetSelectedCount(itemUnifier), 0);
		if (data2.CanOverflowConvert)
		{
			long num3 = result.leftCount - num * num2;
			remainingSelectableTimes = (int)((num3 > 0) ? ((num3 - 1) / num) : 0);
		}
		else
		{
			remainingSelectableTimes = (int)(result.leftCount / num) - num2;
		}
		remainingSelectableTimes = Math.Max(remainingSelectableTimes, 0);
		return true;
	}

	private void UpdateSelectedRewardBag()
	{
		if (!(selectedBag == null))
		{
			selectedBag.ItemSource = _selectedItemArray;
			selectedBag.SelectMode = CommonScrollBagComponent.SelectModeType.Single;
			selectedBag.ItemShowType = ItemUIComponentBase.InitType.BagItem;
			selectedBag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
			UpdateSelectCountText();
			UpdateButton();
		}
	}

	private void UpdateIcon()
	{
		Station.LoadImage(213, _bundleData.icon, bundleIcon);
	}

	private void UpdateBundleName()
	{
		bundleNameText.SetTable(LocalizeTable.ShortCommon);
		bundleNameText.StringReference.TableEntryReference = _bundleData.bundlename;
	}

	private void UpdateQualityBackGround()
	{
		for (int i = 0; i < qualityBackgrounds.Length; i++)
		{
			qualityBackgrounds[i].SetActive(i == _bundleData.quality - 1);
		}
	}

	private void UpdateLimitText()
	{
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
		int num = Model<ShopModel>.Interface.BundleLeftCount(_bundleData.id);
		purchaseLimitText.GetVariable<int>("0").Value = ((num >= 0) ? Math.Max(num, 0) : _bundleData.limitCount);
	}

	private void UpdateButton()
	{
		if (_selectedItemArray.Any((ItemUnifierProxy x) => x.Equals(ItemUnifierProxy.Empty)))
		{
			buyBtn.Interactable(active: false);
			return;
		}
		int missionGroupId = _bundleData.missionGroupId;
		if (missionGroupId == 0)
		{
			buyBtn.Interactable(active: true);
			return;
		}
		bool taskGroupIsComplete = Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(missionGroupId);
		buyBtn.Interactable(taskGroupIsComplete);
	}

	private void UpdateSelectCountText()
	{
		selectedCountText.SetTable("Common");
		selectedCountText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.SelectedCount;
		int value = _selectedItemArray.Count((ItemUnifierProxy x) => !x.Equals(ItemUnifierProxy.Empty));
		selectedCountText.GetVariable<int>("0").Value = value;
		selectedCountText.GetVariable<int>("1").Value = _bundleData.selectnum;
	}

	private void OnBuy()
	{
		if (TryGetOverflowItems(out var overflowItems))
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ITEMCONVERTOVERFLOW, new ItemConvertOverflowViewData
			{
				Items = overflowItems,
				ConfirmAction = StartPurchase
			});
		}
		else
		{
			StartPurchase();
		}
	}

	private void StartPurchase()
	{
		ShopEventTrackHelper.Dispatch(m_data.SubShopId, 4, _bundleData.id, 1);
		if (_bundleData.paytype == 1)
		{
			List<ItemKv> itemNeed = _bundleData.itemNeed;
			if (itemNeed == null)
			{
				return;
			}
			if (!GameUtility.ItemsIsEnough(itemNeed))
			{
				DispatchShopBuyEvent(5);
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_JUMPTOCOSTDIAMOND);
				Close();
				return;
			}
			List<int> list = new List<int>();
			ItemUnifierProxy[] selectedItemArray = _selectedItemArray;
			foreach (ItemUnifierProxy item in selectedItemArray)
			{
				list.Add(_bundleData.selectitem.FindIndex((ItemKv x) => x.id == item.Id));
			}
			Model<PayModel>.Interface.ExchangeCommodity(m_data.SubShopId, _bundleData.id, (bool ok, List<Item> ack) =>
			{
				if (ok)
				{
					DispatchShopBuyEvent(6);
					Close();
					GameUtility.OpenPopReward(GameUtility.ToUniversalItems(ack));
				}
				else
				{
					DispatchShopBuyEvent(5);
					Close();
				}
			}, list);
			return;
		}
		Model<PayModel>.Interface.SendOrder(_bundleData.id, m_data.SubShopId, (bool ok, CreatOrderAck ack) =>
		{
			if (ok)
			{
				_pendingOrderId = ack?.OrderId;
				PayModel payModel = Model<PayModel>.Interface;
				payModel.OnPaySuccess = (Action<string>)Delegate.Remove(payModel.OnPaySuccess, new Action<string>(OnPaySuccess));
				PayModel payModel2 = Model<PayModel>.Interface;
				payModel2.OnPaySuccess = (Action<string>)Delegate.Combine(payModel2.OnPaySuccess, new Action<string>(OnPaySuccess));
			}
			else
			{
				DispatchShopBuyEvent(5);
			}
		});
	}

	private bool TryGetOverflowItems(out List<ItemKv> overflowItems)
	{
		if (_selectedItemArray == null || _selectedItemArray.Length == 0)
		{
			overflowItems = null;
			return false;
		}
		Dictionary<int, long> dictionary = new Dictionary<int, long>();
		ItemUnifierProxy[] selectedItemArray = _selectedItemArray;
		foreach (ItemUnifierProxy itemUnifierProxy in selectedItemArray)
		{
			if (itemUnifierProxy != null && !itemUnifierProxy.Equals(ItemUnifierProxy.Empty) && itemUnifierProxy.Id > 0 && itemUnifierProxy.Count > 0)
			{
				dictionary.TryGetValue(itemUnifierProxy.Id, out var value);
				dictionary[itemUnifierProxy.Id] = value + itemUnifierProxy.Count;
			}
		}
		return BundleOverflowHelper.TryGetOverflowItems(dictionary, out overflowItems);
	}

	private void OnPaySuccess(string orderId)
	{
		if (_pendingOrderId == null || !(orderId != _pendingOrderId))
		{
			PayModel payModel = Model<PayModel>.Interface;
			payModel.OnPaySuccess = (Action<string>)Delegate.Remove(payModel.OnPaySuccess, new Action<string>(OnPaySuccess));
			_pendingOrderId = null;
			DispatchShopBuyEvent(6);
			Close();
		}
	}

	private void DispatchShopBuyEvent(int status)
	{
		_shopEventFinished = true;
		ShopEventTrackHelper.Dispatch(m_data.SubShopId, status, _bundleData.id, 1);
	}
}
