using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI.Interface;
using ACT.Utility;
using Bamboo.NumberString;
using Fundamental;
using Pb;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI.ShopSubView;

public class VipSubShopView : BaseShopSecondSubView<VipSubViewInputController>
{
	[Header("标题")]
	public LocalizeStringEvent titleText;

	[Header("剩余天数")]
	public GameObject remainDayRoot;

	public LocalizeStringEvent remainDayText;

	public GameObject hasObtainedRoot;

	[Header("帮助按钮")]
	public ActButton helpBtn;

	[Header("价格")]
	public TMP_Text priceText;

	[Header("购买按钮")]
	public ActButton buyBtn;

	public LocalizeStringEvent buyBtnText;

	[Header("累计充值币赠送标签")]
	public PresentTotalRechargeTag presentTotalRechargeTag;

	private MonthlyPass _monthlyPass;

	private void Awake()
	{
		if ((bool)helpBtn)
		{
			helpBtn.SetBtnClick(OpenHelp);
		}
		if ((bool)buyBtn)
		{
			buyBtn.SetBtnClick(OnBuy);
		}
		PayModel payModel = Model<PayModel>.Interface;
		payModel.OnPaySuccess = (Action<string>)Delegate.Combine(payModel.OnPaySuccess, new Action<string>(OnPaySuccess));
		ShopModel shopModel = Model<ShopModel>.Interface;
		shopModel.OnShopDataUpdate = (Action)Delegate.Combine(shopModel.OnShopDataUpdate, new Action(Refresh));
	}

	protected override void OnUnityDestroy()
	{
		base.OnUnityDestroy();
		PayModel payModel = Model<PayModel>.Interface;
		payModel.OnPaySuccess = (Action<string>)Delegate.Remove(payModel.OnPaySuccess, new Action<string>(OnPaySuccess));
		ShopModel shopModel = Model<ShopModel>.Interface;
		shopModel.OnShopDataUpdate = (Action)Delegate.Remove(shopModel.OnShopDataUpdate, new Action(Refresh));
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		int firstListedCommodityId = GetFirstListedCommodityId();
		if (firstListedCommodityId == 0)
		{
			_monthlyPass = null;
			presentTotalRechargeTag?.SetAmount(0);
			if ((bool)buyBtn)
			{
				buyBtn.Interactable(active: false);
			}
			return;
		}
		_monthlyPass = CoreUtils.GetData(firstListedCommodityId, RuntimeConfigs.data.monthlyPasss);
		if (_monthlyPass == null)
		{
			presentTotalRechargeTag?.SetAmount(0);
			return;
		}
		if ((bool)buyBtn)
		{
			buyBtn.Interactable(active: true);
		}
		Refresh();
	}

	private int GetFirstListedCommodityId()
	{
		SubshopData subshopData = ShopSecondTab?.SubShopData;
		int[] array = subshopData?.commodityIds;
		if (array == null)
		{
			return 0;
		}
		int[] array2 = array;
		foreach (int num in array2)
		{
			if (subshopData.gmType == 1 || Model<ShopModel>.Interface.GoodsData.ContainsKey(num))
			{
				return num;
			}
		}
		return 0;
	}

	protected override void OnFocusIn()
	{
		base.OnFocusIn();
		SetButtonPromptVisible(visible: true);
	}

	protected override void OnFocusOut()
	{
		base.OnFocusOut();
		SetButtonPromptVisible(visible: false);
	}

	private void SetButtonPromptVisible(bool visible)
	{
		if ((bool)buyBtn)
		{
			OperateBtnPrompt componentInChildren = buyBtn.GetComponentInChildren<OperateBtnPrompt>();
			if ((bool)componentInChildren)
			{
				componentInChildren.SetVisible(visible);
			}
		}
	}

	private void Refresh()
	{
		if (_monthlyPass != null)
		{
			UpdateTitleInfo();
			UpdatePrice();
			UpdateBuyText();
			UpdateLeftTime();
			UpdatePresentTotalRechargeTag();
		}
	}

	private void UpdatePresentTotalRechargeTag()
	{
		SaleList data = CoreUtils.GetData(_monthlyPass.id, RuntimeConfigs.data.saleLists);
		presentTotalRechargeTag?.SetAmount(data?.eventPoint ?? 0);
	}

	private void UpdateTitleInfo()
	{
		titleText.SetTable("shortcommon");
		titleText.StringReference.TableEntryReference = _monthlyPass.bundlename;
	}

	private void UpdatePrice()
	{
		priceText.text = Model<PayModel>.Interface.GetPrice(_monthlyPass.id);
	}

	private void UpdateBuyText()
	{
		buyBtnText.SetTable("Common");
		buyBtnText.StringReference.TableEntryReference = (Model<ShopModel>.Interface.MonthlyPassValid(_monthlyPass.id) ? LocalizationCommonData.CommonString.Renew : LocalizationCommonData.CommonString.Buy);
	}

	private void UpdateLeftTime()
	{
		if (Model<ShopModel>.Interface.MonthlyPassValid(_monthlyPass.id))
		{
			int value = Model<ShopModel>.Interface.MonthlyPassLeftCount(_monthlyPass.id);
			remainDayRoot.SetActive(value: true);
			remainDayText.SetTable("Common");
			remainDayText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.RemainDay;
			remainDayText.GetVariable<int>("0").Value = value;
		}
		else
		{
			remainDayRoot.SetActive(value: false);
		}
		hasObtainedRoot.SetActive(!Model<ShopModel>.Interface.IsHaveMonthlyPassValid(out var _));
	}

	private void OpenHelp()
	{
		if (_monthlyPass != null)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
			{
				iconId = 1027,
				titleTextId = _monthlyPass.bundlename,
				descTextId = _monthlyPass.bundledetail
			});
		}
	}

	private void OnBuy()
	{
		if (_monthlyPass == null)
		{
			return;
		}
		int subShopId = ShopSecondTab.SubShopData.id;
		ShopEventTrackHelper.Dispatch(subShopId, 3, _monthlyPass.id, 1);
		int num = Model<ShopModel>.Interface.MonthlyPassLeftCount(_monthlyPass.id);
		if (_monthlyPass.limitday < num)
		{
			ShopEventTrackHelper.Dispatch(subShopId, 5, _monthlyPass.id, 1);
			GameUtility.OpenToolTip(2641, "Common", new List<string> { _monthlyPass.limitday.FastToString() });
			return;
		}
		ShopEventTrackHelper.Dispatch(subShopId, 4, _monthlyPass.id, 1);
		Model<PayModel>.Interface.SendOrder(_monthlyPass.id, subShopId, (bool ok, CreatOrderAck ack) =>
		{
			if (!ok)
			{
				ShopEventTrackHelper.Dispatch(subShopId, 5, _monthlyPass.id, 1);
			}
			else
			{
				PayModel payModel = Model<PayModel>.Interface;
				payModel.OnPaySuccess = (Action<string>)Delegate.Combine(payModel.OnPaySuccess, new Action<string>(OnPaySuccess));
			}
			void OnPaySuccess(string orderId)
			{
				if (ack == null || !(orderId != ack.OrderId))
				{
					PayModel payModel2 = Model<PayModel>.Interface;
					payModel2.OnPaySuccess = (Action<string>)Delegate.Remove(payModel2.OnPaySuccess, new Action<string>(OnPaySuccess));
					ShopEventTrackHelper.Dispatch(subShopId, 6, _monthlyPass.id, 1);
				}
			}
		});
	}

	private void OnPaySuccess(string obj)
	{
		if (IsActive)
		{
			Refresh();
		}
	}
}
