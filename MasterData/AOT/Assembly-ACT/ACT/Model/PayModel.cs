using System;
using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Error;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Net;
using ACT.UI;
using ACT.Utility;
using Bamboo.Chronos;
using Fundamental;
using Google.Protobuf.Collections;
using Pb;
using UnityEngine;
using UnityEngine.Localization;
using bamboosdk;

namespace ACT.Model;

public class PayModel : Model<PayModel>
{
	private struct OrderData
	{
		public int CommodityId;

		public int SubShopId;
	}

	private enum PriceType
	{
		Price,
		Empty,
		Free
	}

	private struct PriceData
	{
		public PriceType PriceType;

		public int Price;
	}

	private struct PendingOrderShipReward
	{
		public string OrderId;

		public RepeatedField<UniversalItem> GotItems;
	}

	private Dictionary<string, OrderData> _orderQueue;

	private List<PendingOrderShipReward> _pendingOrderShipRewards;

	private readonly StringBuilder _sb = new StringBuilder();

	private Delayer _exchangeDelayer;

	private bool _pendingViewInputPaused;

	private const float SendOrderDebounceDuration = 1f;

	private float _lastSendOrderTime = float.NegativeInfinity;

	public Action<string> OnPaySuccess { get; set; }

	public Action<int> OnExchangeSuccess { get; set; }

	private bool HasGameStarted => Singleton<GameState>.instance.RunningState == GameRunningState.Playing;

	protected override void Init()
	{
		_orderQueue = DictionaryPool<string, OrderData>.Get();
		_pendingOrderShipRewards = ListPool<PendingOrderShipReward>.Get();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Pay, OnPayEvent);
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Pay, OnPayEvent);
		DictionaryPool<string, OrderData>.Release(_orderQueue);
		_orderQueue = null;
		if (_pendingOrderShipRewards != null)
		{
			_pendingOrderShipRewards.Clear();
			ListPool<PendingOrderShipReward>.Release(_pendingOrderShipRewards);
			_pendingOrderShipRewards = null;
		}
		PopPendingViewInputPause();
	}

	private void UpdatePendingView()
	{
		Debug.Log($"当前未支付订单数量: {_orderQueue.Count}");
		if (_exchangeDelayer.IsValid())
		{
			_exchangeDelayer.Cancel();
		}
		_exchangeDelayer = UpdateTimer.Default.DelayMs(30000, PopPendingViewInputPause);
	}

	private void PushPendingViewInputPause()
	{
		if (!_pendingViewInputPaused)
		{
			MonoECS.instance.PushPauseUIInput();
			Singleton<GameInputActionManager>.instance.SetGameInputState(GameInputState.Pay, active: true);
			_pendingViewInputPaused = true;
		}
	}

	private void PopPendingViewInputPause()
	{
		if (_pendingViewInputPaused)
		{
			MonoECS.instance.PopPauseUIInput();
			Singleton<GameInputActionManager>.instance.SetGameInputState(GameInputState.Pay, active: false);
			_pendingViewInputPaused = false;
		}
	}

	public void SendOrder(int commodityId, int subShopId, Action<bool, CreatOrderAck> callback = null)
	{
		float realtimeSinceStartup = Time.realtimeSinceStartup;
		if (realtimeSinceStartup - _lastSendOrderTime < 1f)
		{
			GameUtility.OpenToolTip("操作过于频繁，请稍后再试");
			return;
		}
		_lastSendOrderTime = realtimeSinceStartup;
		ClientPayRequestEvent evt = EventTrackSolver.Instance.GetEvt<ClientPayRequestEvent>();
		evt.goodsId = commodityId;
		evt.productId = GetProductId(commodityId);
		evt.goodsPrice = GetPriceValue(commodityId).Price;
		evt.goodsTier = GetGoodsTier(commodityId);
		evt.subShopId = subShopId;
		EventTrackSolver.Instance.Dispatch(evt);
		if (!LuminBambooBridgeListener.Default.IsLogin)
		{
			GameUtility.OpenToolTip("未登录SDK无法拉起支付");
			return;
		}
		callback = (Action<bool, CreatOrderAck>)Delegate.Combine(callback, (Action<bool, CreatOrderAck>)((bool b, CreatOrderAck ack) =>
		{
			if (b)
			{
				_orderQueue[ack.OrderId] = new OrderData
				{
					SubShopId = subShopId,
					CommodityId = commodityId
				};
				if (LuminApplication.LogEnabled)
				{
					Debug.Log("拉起支付 订单号" + ack.OrderId);
				}
				UpdatePendingView();
			}
		}));
		G.service.SendOrder(commodityId, subShopId, isRetry: false, callback);
	}

	private void OnPayEvent(BaseEventContent baseEventContent)
	{
		if (!(baseEventContent is PayEvent payEvent))
		{
			return;
		}
		if (payEvent.isSuccess)
		{
			_orderQueue.Remove(payEvent.orderID);
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("支付成功 订单号" + payEvent.orderID + "订单信息 " + payEvent.message);
			}
			NotifyPaySuccess(payEvent.orderID);
		}
		else if (payEvent.isCancel)
		{
			_orderQueue.Remove(payEvent.orderID);
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("支付取消 订单号" + payEvent.orderID + "订单信息 " + payEvent.message);
			}
		}
		else if (payEvent.isFail)
		{
			_orderQueue.Remove(payEvent.orderID);
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("支付失败 订单号" + payEvent.orderID + "订单信息 " + payEvent.message);
			}
			if (!string.Equals(payEvent.message?.Trim(), "PaymentDisabled", StringComparison.Ordinal))
			{
				LuminError.Handle(CodeType.CLIENT, CodeModule.PAY, 1);
			}
		}
		else if (payEvent.isRetry)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("支付重试 订单号" + payEvent.orderID + "订单信息 " + payEvent.message);
			}
			if (_orderQueue.Remove(payEvent.orderID, out var orderData))
			{
				G.service.SendOrder(orderData.CommodityId, orderData.SubShopId, isRetry: true, (bool b, CreatOrderAck ack) =>
				{
					if (b)
					{
						_orderQueue[ack.OrderId] = orderData;
						UpdatePendingView();
					}
				});
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError("订单 " + payEvent.orderID + " 重试失败，未找到对应商品ID");
			}
		}
		UpdatePendingView();
	}

	public string GetPrice(int commodityId, int decimalPlaces = 2)
	{
		if (CoreUtils.GetData(commodityId, RuntimeConfigs.data.saleLists) == null)
		{
			return string.Empty;
		}
		_sb.Clear();
		if (LuminApplication.AppRegion.ToUpper() == "CN")
		{
			_sb.Append('￥');
		}
		else
		{
			_sb.Append('￥');
		}
		PriceData priceValue = GetPriceValue(commodityId);
		switch (priceValue.PriceType)
		{
		case PriceType.Price:
			_sb.AppendFormat($"{{0:F{decimalPlaces}}}", (float)priceValue.Price / 100f);
			break;
		case PriceType.Empty:
			return string.Empty;
		case PriceType.Free:
			return LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.Free);
		}
		return _sb.ToString();
	}

	private PriceData GetPriceValue(int commodityId)
	{
		PriceData result = new PriceData
		{
			PriceType = PriceType.Empty
		};
		PriceData result2 = new PriceData
		{
			PriceType = PriceType.Free
		};
		SaleList data = CoreUtils.GetData(commodityId, RuntimeConfigs.data.saleLists);
		if (data == null)
		{
			return result;
		}
		int price = 0;
		switch (data.type)
		{
		case 1:
		{
			GemRecharge data3 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.gemRecharges);
			if (data3 == null)
			{
				LuminError.Handle(CodeType.CLIENT, CodeModule.SHOP, 1);
				return result;
			}
			price = data3.price;
			break;
		}
		case 2:
		{
			Bundle data6 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.bundles);
			if (data6 == null)
			{
				LuminError.Handle(CodeType.CLIENT, CodeModule.SHOP, 1);
				return result;
			}
			switch (data6.paytype)
			{
			case 1:
				return result;
			case 2:
				price = data6.price;
				break;
			case 3:
				return result2;
			}
			break;
		}
		case 3:
		{
			MonthlyPass data4 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.monthlyPasss);
			if (data4 == null)
			{
				LuminError.Handle(CodeType.CLIENT, CodeModule.SHOP, 1);
				return result;
			}
			price = data4.price;
			break;
		}
		case 4:
		{
			SkinShop data5 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.skinShops);
			if (data5 == null)
			{
				LuminError.Handle(CodeType.CLIENT, CodeModule.SHOP, 1);
				return result;
			}
			switch (data5.paytype)
			{
			case 1:
				return result;
			case 2:
				price = data5.price;
				break;
			case 3:
				return result2;
			}
			break;
		}
		case 6:
		{
			BattlepayPass data2 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.battlepayPasss);
			if (data2 == null)
			{
				LuminError.Handle(CodeType.CLIENT, CodeModule.SHOP, 1);
				return result;
			}
			switch (data2.paytype)
			{
			case 1:
				return result;
			case 2:
				price = data2.price;
				break;
			case 3:
				return result2;
			}
			break;
		}
		}
		return new PriceData
		{
			Price = price,
			PriceType = PriceType.Price
		};
	}

	public string GetProductId(int commodityId)
	{
		SaleList data = CoreUtils.GetData(commodityId, RuntimeConfigs.data.saleLists);
		if (data == null)
		{
			return string.Empty;
		}
		switch (data.type)
		{
		case 1:
		{
			GemRecharge data3 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.gemRecharges);
			if (data3 == null)
			{
				return string.Empty;
			}
			return data3.productid;
		}
		case 2:
		{
			Bundle data6 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.bundles);
			if (data6 == null)
			{
				return string.Empty;
			}
			return data6.productid;
		}
		case 3:
		{
			MonthlyPass data4 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.monthlyPasss);
			if (data4 == null)
			{
				return string.Empty;
			}
			return data4.productid;
		}
		case 4:
		{
			SkinShop data5 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.skinShops);
			if (data5 == null)
			{
				return string.Empty;
			}
			return data5.productid;
		}
		case 6:
		{
			BattlepayPass data2 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.battlepayPasss);
			if (data2 == null)
			{
				return string.Empty;
			}
			return data2.productid;
		}
		default:
			throw new NotImplementedException();
		}
	}

	public string GetProductName(int commodityId)
	{
		SaleList data = CoreUtils.GetData(commodityId, RuntimeConfigs.data.saleLists);
		if (data == null)
		{
			return string.Empty;
		}
		switch (data.type)
		{
		case 1:
		{
			GemRecharge data3 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.gemRecharges);
			if (data3 == null)
			{
				return string.Empty;
			}
			return data3.productname;
		}
		case 2:
		{
			Bundle data6 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.bundles);
			if (data6 == null)
			{
				return string.Empty;
			}
			return LocalizationUtility.GetLocalizeString("shortcommon", data6.bundlename);
		}
		case 3:
		{
			MonthlyPass data4 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.monthlyPasss);
			if (data4 == null)
			{
				return string.Empty;
			}
			return LocalizationUtility.GetLocalizeString("shortcommon", data4.bundlename);
		}
		case 4:
		{
			SkinShop data5 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.skinShops);
			if (data5 == null)
			{
				return string.Empty;
			}
			return LocalizationUtility.GetLocalizeString("shortcommon", data5.bundlename);
		}
		case 6:
		{
			BattlepayPass data2 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.battlepayPasss);
			if (data2 == null)
			{
				return string.Empty;
			}
			return LocalizationUtility.GetLocalizeString("shortcommon", data2.bundlename);
		}
		default:
			throw new NotImplementedException();
		}
	}

	public string GetProductDescription(int commodityId)
	{
		SaleList data = CoreUtils.GetData(commodityId, RuntimeConfigs.data.saleLists);
		if (data == null)
		{
			return string.Empty;
		}
		string empty = string.Empty;
		switch (data.type)
		{
		case 1:
		{
			GemRecharge data3 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.gemRecharges);
			if (data3 == null)
			{
				return string.Empty;
			}
			empty = LocalizationUtility.GetLocalizeString("shortcommon", data3.dec);
			break;
		}
		case 2:
		{
			Bundle data6 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.bundles);
			if (data6 == null)
			{
				return string.Empty;
			}
			empty = LocalizationUtility.GetLocalizeString("longcommon", data6.bundledetail);
			break;
		}
		case 3:
		{
			MonthlyPass data4 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.monthlyPasss);
			if (data4 == null)
			{
				return string.Empty;
			}
			empty = LocalizationUtility.GetLocalizeString("longcommon", data4.bundledetail);
			break;
		}
		case 4:
		{
			SkinShop data5 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.skinShops);
			if (data5 == null)
			{
				return string.Empty;
			}
			empty = LocalizationUtility.GetLocalizeString("longcommon", data5.bundledetail);
			break;
		}
		case 6:
		{
			BattlepayPass data2 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.battlepayPasss);
			if (data2 == null)
			{
				return string.Empty;
			}
			empty = LocalizationUtility.GetLocalizeString("shortcommon", data2.bundledetail);
			break;
		}
		default:
			throw new NotImplementedException();
		}
		if (empty.Length > 50)
		{
			return empty.Substring(0, 50) + "...";
		}
		return empty;
	}

	public string GetGoodsTier(int commodityId)
	{
		SaleList data = CoreUtils.GetData(commodityId, RuntimeConfigs.data.saleLists);
		if (data == null)
		{
			return string.Empty;
		}
		switch (data.type)
		{
		case 1:
		{
			GemRecharge data3 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.gemRecharges);
			if (data3 == null)
			{
				return string.Empty;
			}
			return data3.tier;
		}
		case 2:
		{
			Bundle data6 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.bundles);
			if (data6 == null)
			{
				return string.Empty;
			}
			return data6.tier;
		}
		case 3:
		{
			MonthlyPass data4 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.monthlyPasss);
			if (data4 == null)
			{
				return string.Empty;
			}
			return data4.tier;
		}
		case 4:
		{
			SkinShop data5 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.skinShops);
			if (data5 == null)
			{
				return string.Empty;
			}
			return data5.tier;
		}
		case 6:
		{
			BattlepayPass data2 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.battlepayPasss);
			if (data2 == null)
			{
				return string.Empty;
			}
			return data2.tier;
		}
		default:
			return string.Empty;
		}
	}

	public void GameServerCompleteOrder(string orderId)
	{
		_orderQueue.Remove(orderId);
	}

	private static void MarkShopMonthlyPassFacePushIfNeeded(int commodityId)
	{
		SaleList saleList = ((commodityId > 0) ? CoreUtils.GetData(commodityId, RuntimeConfigs.data.saleLists) : null);
		if (commodityId > 0 && saleList != null && saleList.type == 3)
		{
			FacePushModel.MarkShopMonthlyPassFacePushPending(commodityId);
		}
	}

	public void OnOrderShipNtf(OrderShipNtf ntf)
	{
		if (ntf != null)
		{
			int commodityId = 0;
			if (_orderQueue != null && _orderQueue.TryGetValue(ntf.OrderId, out var value))
			{
				commodityId = value.CommodityId;
			}
			GameServerCompleteOrder(ntf.OrderId);
			MarkShopMonthlyPassFacePushIfNeeded(commodityId);
			if (HasGameStarted)
			{
				ShowOrderShipReward(ntf.OrderId, ntf.GotItems);
				NotifyPaySuccess(ntf.OrderId);
				return;
			}
			_pendingOrderShipRewards.Add(new PendingOrderShipReward
			{
				OrderId = ntf.OrderId,
				GotItems = ntf.GotItems
			});
			NotifyPaySuccess(ntf.OrderId);
		}
	}

	private void NotifyPaySuccess(string orderId)
	{
		Action<string> onPaySuccess = OnPaySuccess;
		if (onPaySuccess == null)
		{
			return;
		}
		Delegate[] invocationList = onPaySuccess.GetInvocationList();
		for (int i = 0; i < invocationList.Length; i++)
		{
			try
			{
				((Action<string>)invocationList[i])(orderId);
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}
	}

	public void TryFlushPendingOrderShipRewards()
	{
		if (_pendingOrderShipRewards != null && _pendingOrderShipRewards.Count != 0)
		{
			FlushPendingOrderShipRewards();
		}
	}

	private void FlushPendingOrderShipRewards()
	{
		if (_pendingOrderShipRewards == null || _pendingOrderShipRewards.Count == 0)
		{
			return;
		}
		if (_pendingOrderShipRewards.Count == 1)
		{
			PendingOrderShipReward pendingOrderShipReward = _pendingOrderShipRewards[0];
			ShowOrderShipReward(pendingOrderShipReward.OrderId, pendingOrderShipReward.GotItems);
			_pendingOrderShipRewards.Clear();
			return;
		}
		RepeatedField<UniversalItem> repeatedField = new RepeatedField<UniversalItem>();
		for (int i = 0; i < _pendingOrderShipRewards.Count; i++)
		{
			PendingOrderShipReward pendingOrderShipReward2 = _pendingOrderShipRewards[i];
			if (pendingOrderShipReward2.GotItems != null)
			{
				for (int j = 0; j < pendingOrderShipReward2.GotItems.Count; j++)
				{
					repeatedField.Add(pendingOrderShipReward2.GotItems[j]);
				}
			}
		}
		if (repeatedField.Count > 0)
		{
			GameUtility.OpenPopReward(repeatedField);
		}
		for (int k = 0; k < _pendingOrderShipRewards.Count; k++)
		{
			G.service.OrderShipDisplay(_pendingOrderShipRewards[k].OrderId);
		}
		_pendingOrderShipRewards.Clear();
	}

	private void ShowOrderShipReward(string orderId, RepeatedField<UniversalItem> gotItems)
	{
		GameUtility.OpenPopReward(gotItems);
		G.service.OrderShipDisplay(orderId);
	}

	public void ExchangeCommodity(int subShopId, int commodityId, Action<bool, List<Item>> callback = null, List<int> selectedItems = null)
	{
		SaleList data = CoreUtils.GetData(commodityId, RuntimeConfigs.data.saleLists);
		if (data == null)
		{
			return;
		}
		List<ItemKv> list = new List<ItemKv>();
		switch (data.type)
		{
		case 2:
		{
			Bundle data3 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.bundles);
			if (data3 == null || data3.paytype == 2)
			{
				return;
			}
			list.AddRange(data3.itemNeed);
			break;
		}
		case 4:
		{
			SkinShop data2 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.skinShops);
			if (data2 == null || data2.paytype == 2)
			{
				return;
			}
			list.AddRange(data2.itemNeed);
			break;
		}
		}
		if (list == null || list.Count <= 0)
		{
			callback = (Action<bool, List<Item>>)Delegate.Combine(callback, (Action<bool, List<Item>>)((bool b, List<Item> list2) =>
			{
				OnExchangeSuccess?.Invoke(commodityId);
			}));
			G.service.ExchangeCommodity(subShopId, commodityId, callback, selectedItems);
			return;
		}
		foreach (ItemKv item in list)
		{
			int itemCount = G.localPlayer.Inventory.GetItemCount(item.id);
			if (itemCount < item.count)
			{
				if (item.id == 98)
				{
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_JUMPTOCOSTDIAMOND);
				}
				else if (item.id == 97)
				{
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_JUMPTOFREEDIAMONDVIEW, new JumpToFreeDiamondViewData
					{
						RequireFreeDiamondCount = item.count - itemCount
					});
				}
				callback?.Invoke(arg1: false, null);
				return;
			}
		}
		callback = (Action<bool, List<Item>>)Delegate.Combine(callback, (Action<bool, List<Item>>)((bool _, List<Item> _) =>
		{
			OnExchangeSuccess?.Invoke(commodityId);
		}));
		G.service.ExchangeCommodity(subShopId, commodityId, callback, selectedItems);
	}

	public void JumpToExchangeFreeDiamond(int requireFreeDiamondCount)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_JUMPTOFREEDIAMONDVIEW, new JumpToFreeDiamondViewData
		{
			RequireFreeDiamondCount = requireFreeDiamondCount
		});
	}
}
