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
using ACT.UI.InputController.BundlePurchaseInputController;
using ACT.UI.ShopSubView;
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
using UnityEngine.UI;

namespace ACT.UI;

public class BundlePurchaseView : BaseUIView<BundlePurchaseViewInputController>
{
	public CommonCoinComponent coinComponent;

	public GameObject[] qualityBackgrounds;

	public GameObject bestValueTag;

	[Header("返利相关")]
	public GameObject rebateTag;

	public TMP_Text rebateText;

	public PresentTotalRechargeTag presentTotalRechargeTag;

	[Space(10f)]
	public CommonTimerComponent timerComponent;

	public LocalizeStringEvent purchaseLimitText;

	public BImage bundleIcon;

	public LocalizeStringEvent bundleNameText;

	public CommonPriceComponent priceComponent;

	[Header("外部滚动列表")]
	public ScrollRect scrollRect;

	[Header("立即获得奖励")]
	public GameObject rewardImmediateRoot;

	public CommonScrollBagComponent rewardImmediateBag;

	[Header("后续获得奖励")]
	public GameObject rewardAfterRoot;

	public CommonScrollBagComponent rewardAfterBag;

	public LocalizeStringEvent rewardAfterDesc;

	public ActButton buyBtn;

	[Header("前置条件提示")]
	public GameObject preConditionTipRoot;

	public LocalizeStringEvent preConditionTip;

	[Header("输入相关")]
	public ViewControlLayer rewardLayer;

	public ViewControlLayer btnGroupLayer;

	public GamePadTipsComp gamePadTipsComp;

	private Bundle _bundleData;

	private bool _shopEventFinished;

	private string _pendingOrderId;

	private BundlePurchaseViewData m_data => uiViewData as BundlePurchaseViewData;

	private void Awake()
	{
		buyBtn.SetBtnClick(OnBuy);
	}

	protected override void Init()
	{
		base.Init();
		_bundleData = CoreUtils.GetData(m_data.BundleId, RuntimeConfigs.data.bundles);
		if (_bundleData == null)
		{
			Debug.LogError($"BundlePurchaseView RefreshView Fail, bundleData is null, bundleId: {m_data.BundleId}");
			return;
		}
		_shopEventFinished = false;
		_pendingOrderId = null;
		UpdateCoinComponent();
		UpdatePrice();
		UpdateTag();
		UpdateTimer();
		UpdateReward();
		UpdateIcon();
		UpdateBundleName();
		UpdateQualityBackGround();
		UpdateLimitText();
		UpdatePreConditionTip();
		UpdateButton();
		ResetScrollToTop();
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

	private void ResetScrollToTop()
	{
		if (scrollRect != null)
		{
			scrollRect.verticalNormalizedPosition = 1f;
		}
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
		SaleList data = CoreUtils.GetData(_bundleData.id, RuntimeConfigs.data.saleLists);
		presentTotalRechargeTag?.SetAmount(data?.eventPoint ?? 0);
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

	private void UpdateReward()
	{
		CommonScrollBagComponent commonScrollBagComponent = rewardImmediateBag;
		if (commonScrollBagComponent.ItemSource == null)
		{
			IEnumerable<ItemUnifierProxy> enumerable = (commonScrollBagComponent.ItemSource = new List<ItemUnifierProxy>());
		}
		commonScrollBagComponent = rewardAfterBag;
		if (commonScrollBagComponent.ItemSource == null)
		{
			IEnumerable<ItemUnifierProxy> enumerable = (commonScrollBagComponent.ItemSource = new List<ItemUnifierProxy>());
		}
		List<ItemKv> bundleitem = _bundleData.bundleitem;
		if (bundleitem == null || bundleitem.Count <= 0)
		{
			rewardImmediateRoot.SetActive(value: false);
		}
		else
		{
			rewardImmediateRoot.SetActive(value: true);
			if (rewardImmediateBag.ItemSource is List<ItemUnifierProxy> list)
			{
				list.Clear();
				foreach (ItemKv item3 in bundleitem)
				{
					ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(item3.id, item3.count);
					list.Add(item);
				}
				rewardImmediateBag.ItemSource = list;
			}
			rewardImmediateBag.ItemShowType = ItemUIComponentBase.InitType.BagItem;
			rewardImmediateBag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		}
		List<ItemKv> multiitem = _bundleData.multiitem;
		if (multiitem == null || multiitem.Count <= 0)
		{
			rewardAfterRoot.SetActive(value: false);
			return;
		}
		rewardAfterRoot.SetActive(value: true);
		rewardAfterDesc.SetTable("Common");
		rewardAfterDesc.StringReference.TableEntryReference = LocalizationCommonData.CommonString.XDayMailGet;
		rewardAfterDesc.GetVariable<int>("0").Value = _bundleData.offerday;
		if (rewardAfterBag.ItemSource is List<ItemUnifierProxy> list2)
		{
			list2.Clear();
			foreach (ItemKv item4 in multiitem)
			{
				ItemUnifierProxy item2 = ItemUnifierProxy.ItemUnifierPool.Get<Item>(item4.id, item4.count);
				list2.Add(item2);
			}
			rewardAfterBag.ItemSource = list2;
		}
		rewardAfterBag.ItemShowType = ItemUIComponentBase.InitType.BagItem;
		rewardAfterBag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
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
		switch (_bundleData.paytype)
		{
		case 1:
		case 3:
			Model<PayModel>.Interface.ExchangeCommodity(m_data.SubShopId, _bundleData.id, (bool v, List<Item> items) =>
			{
				if (v)
				{
					DispatchShopBuyEvent(6);
					GameUtility.OpenPopReward(GameUtility.ToUniversalItems(items));
				}
				else
				{
					DispatchShopBuyEvent(5);
				}
				Close();
			});
			break;
		case 2:
			Model<PayModel>.Interface.SendOrder(_bundleData.id, m_data.SubShopId, (bool ok, CreatOrderAck ack) =>
			{
				if (!ok)
				{
					DispatchShopBuyEvent(5);
					Debug.LogError($"BundlePurchaseView SendOrder failed, bundleId: {_bundleData.id}");
				}
				else
				{
					_pendingOrderId = ack?.OrderId;
					PayModel payModel = Model<PayModel>.Interface;
					payModel.OnPaySuccess = (Action<string>)Delegate.Remove(payModel.OnPaySuccess, new Action<string>(OnPaySuccess));
					PayModel payModel2 = Model<PayModel>.Interface;
					payModel2.OnPaySuccess = (Action<string>)Delegate.Combine(payModel2.OnPaySuccess, new Action<string>(OnPaySuccess));
				}
			});
			break;
		}
	}

	private bool TryGetOverflowItems(out List<ItemKv> overflowItems)
	{
		List<ItemKv> list = _bundleData?.bundleitem;
		if (list == null || list.Count <= 0)
		{
			overflowItems = null;
			return false;
		}
		Dictionary<int, long> dictionary = new Dictionary<int, long>();
		foreach (ItemKv item in _bundleData.bundleitem)
		{
			if (item != null && item.id > 0 && item.count > 0)
			{
				dictionary.TryGetValue(item.id, out var value);
				dictionary[item.id] = value + item.count;
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

	private void UpdatePreConditionTip()
	{
		int missionGroupId = _bundleData.missionGroupId;
		if (missionGroupId == 0)
		{
			preConditionTipRoot.gameObject.SetActive(value: false);
			return;
		}
		if (Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(missionGroupId))
		{
			preConditionTipRoot.gameObject.SetActive(value: false);
			return;
		}
		preConditionTipRoot.gameObject.SetActive(value: true);
		MissionGroup data = CoreUtils.GetData(missionGroupId, RuntimeConfigs.data.missionGroups);
		if (data == null)
		{
			Debug.LogError($"BundlePurchaseView RefreshView Fail, missionGroupData is null, missionGroupId: {missionGroupId}");
			return;
		}
		preConditionTip.SetTable("shortcommon");
		preConditionTip.StringReference.TableEntryReference = data.groupDes;
	}

	private void UpdateButton()
	{
		int missionGroupId = _bundleData.missionGroupId;
		if (missionGroupId == 0)
		{
			buyBtn.Interactable(active: true);
		}
		else if (Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(missionGroupId))
		{
			buyBtn.Interactable(active: true);
		}
		else
		{
			buyBtn.Interactable(active: false);
		}
	}
}
