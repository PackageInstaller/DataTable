using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI.Interface;
using ACT.Utility;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI.ShopSubView;

public class CrystalShopView : BaseShopFirstSubView<CrystalShopInputController>
{
	public LoopScrollRect loopScrollRect;

	public ActButton connectCustomerServiceBtn;

	private SubshopData _subShopData;

	private List<int> _crystalCommodityIds = new List<int>();

	protected override void Awake()
	{
		base.Awake();
		if (loopScrollRect != null)
		{
			loopScrollRect.OnItemShow.AddListener(OnCrystalItemShow);
		}
		if ((bool)connectCustomerServiceBtn)
		{
			connectCustomerServiceBtn.SetBtnClick(JumpToCustomerServiceView);
		}
	}

	protected override void OnUnityDestroy()
	{
		base.OnUnityDestroy();
		if (loopScrollRect != null)
		{
			loopScrollRect.OnItemShow.RemoveListener(OnCrystalItemShow);
		}
		PayModel payModel = Model<PayModel>.Interface;
		payModel.OnPaySuccess = (Action<string>)Delegate.Remove(payModel.OnPaySuccess, new Action<string>(OnPaySuccess));
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		PayModel payModel = Model<PayModel>.Interface;
		payModel.OnPaySuccess = (Action<string>)Delegate.Remove(payModel.OnPaySuccess, new Action<string>(OnPaySuccess));
		PayModel payModel2 = Model<PayModel>.Interface;
		payModel2.OnPaySuccess = (Action<string>)Delegate.Combine(payModel2.OnPaySuccess, new Action<string>(OnPaySuccess));
		Refresh();
		FocusIn();
		GetController()?.OnTabActive(tabItem);
		ShopView.gamePadTipsComp.RegisterInputActions(GamePadTipHelper.ConfirmAction, CrystalShopInputController.CustomerServiceAction);
		PlayFirstTabAnimation();
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		base.OnTabDeActive(tabItem);
		PayModel payModel = Model<PayModel>.Interface;
		payModel.OnPaySuccess = (Action<string>)Delegate.Remove(payModel.OnPaySuccess, new Action<string>(OnPaySuccess));
		FocusOut();
		GetController()?.OnTabDeActive(tabItem);
	}

	private void Refresh()
	{
		_subShopData = CoreUtils.GetData(GetTargetOrDefaultSubShopId(), RuntimeConfigs.data.subshopDatas);
		_crystalCommodityIds.Clear();
		if (_subShopData?.commodityIds != null)
		{
			int[] commodityIds = _subShopData.commodityIds;
			foreach (int num in commodityIds)
			{
				if (_subShopData.gmType == 1 || Model<ShopModel>.Interface.GoodsData.ContainsKey(num))
				{
					_crystalCommodityIds.Add(num);
				}
			}
		}
		_crystalCommodityIds.Sort();
		if (loopScrollRect == null)
		{
			Debug.LogError("CrystalShopView loopScrollRect is null.");
			return;
		}
		loopScrollRect.totalCount = _crystalCommodityIds.Count;
		loopScrollRect.RefillCells();
		PlayCrystalItemAnimation();
	}

	private void OnCrystalItemShow(ILoopScrollDataSource dataSource)
	{
		if (dataSource is CrystalItem { index: >=0 } crystalItem && crystalItem.index < _crystalCommodityIds.Count)
		{
			crystalItem.CommodityId = _crystalCommodityIds[crystalItem.index];
			crystalItem.SubShopId = _subShopData.id;
		}
	}

	private void OnPaySuccess(string orderId)
	{
		Refresh();
	}

	private void PlayCrystalItemAnimation()
	{
		for (int i = 0; i < loopScrollRect.Children.Count; i++)
		{
			loopScrollRect.Children[i].GetComponent<CrystalItem>()?.betterAnimation?.GetSequence("Show").Goto(0f).SetDelay(0.03f * (float)i)
				.Play();
		}
	}

	private void JumpToCustomerServiceView()
	{
		Application.OpenURL(UrlUtility.FeedbackUrl);
	}
}
