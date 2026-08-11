#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Text;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Network;
using GameFramework.Runtime;
using UnityEngine.Pool;

namespace Ase;

public class ShopService : IShopService
{
	private IMessenger messenger;

	private ShopViewModel shopViewModel;

	private INetworkChannel channel;

	private ISubscription<SOOpenNotifyMessager> subscription_SONotify;

	private ISubscription<ShopRefreshNotify> shopRefresh_Notify;

	private ISubscription<RoleExpOrLevelUpNotifyMessager> subscription_UpdateLevel;

	private ISubscription<MonthlyCardPopUpNotify> subscription_MonthlyCardPopupNotify;

	private ISubscription<UserPayNotify> userPayNotify;

	private Action<ShopRefreshNotify> shopAction;

	private Action<MonthlyCardPopUpNotify> monthlyCardAction;

	private int monthlyCardLeftDay = -1;

	private bool monthlyCardTodayGot;

	private bool needDailyUpdate;

	public IMessenger GetMessager()
	{
		return messenger;
	}

	public void PublishMessage(ShopMessageEnum messageEnum, object arg = null)
	{
		messenger?.Publish(new ShopMessage(this, messageEnum, arg));
	}

	public ShopService()
	{
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		subscription_SONotify = messenger.Subscribe<SOOpenNotifyMessager>(OnSystemOpen);
		shopRefresh_Notify = Singleton<NetworkSystem>.Instance.Subscribe<ShopRefreshNotify>(OnShopNotify);
		subscription_UpdateLevel = messenger.Subscribe<RoleExpOrLevelUpNotifyMessager>(OnLevelChangeNotify);
		subscription_MonthlyCardPopupNotify = messenger.Subscribe<MonthlyCardPopUpNotify>(OnMonthlyCardNotify);
		userPayNotify = Singleton<NetworkSystem>.Instance.Subscribe<UserPayNotify>(OnUserPayNotify);
		shopViewModel = new ShopViewModel();
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.AddDailyUpdateAction(OnDailyUpdated);
	}

	private async void OnSystemOpen(SOOpenNotifyMessager messager)
	{
		if (messager.state && 70005 == messager.serviceId)
		{
			await RequestData();
		}
	}

	private void OnShopNotify(ShopRefreshNotify shopRefreshNotify)
	{
		List<ShopInfoData> list = new List<ShopInfoData>();
		foreach (PbShopInfo shopInfo in shopRefreshNotify.ShopInfos)
		{
			list.Add(ShopInfoData.Create(shopInfo, refreshNew: true));
		}
		switch (shopRefreshNotify.Type)
		{
		case 1:
		case 2:
			shopViewModel.UpdateShopDatas(list);
			break;
		case 3:
		case 4:
			foreach (ShopInfoData item in list)
			{
				shopViewModel.UpdateShopExcData(item.MainShopId, item.ShopId, item.ShopExcDatas.Values.ToList());
			}
			break;
		}
		shopAction?.Invoke(shopRefreshNotify);
	}

	public void BindShopNotify(Action<ShopRefreshNotify> action)
	{
		shopAction = (Action<ShopRefreshNotify>)Delegate.Combine(shopAction, action);
	}

	public void RemoveBindShopNotify(Action<ShopRefreshNotify> action)
	{
		shopAction = (Action<ShopRefreshNotify>)Delegate.Remove(shopAction, action);
	}

	private async void OnLevelChangeNotify(RoleExpOrLevelUpNotifyMessager msg)
	{
		if (msg.MessageEnum == RoleExpOrLevelUpNotifyMessager.RoleExpLevelMsgEnum.LevelUp)
		{
			await RequestData();
		}
	}

	private async void OnMonthlyCardNotify(MonthlyCardPopUpNotify notify)
	{
		await RequestGetMonthlyCardInfo();
		monthlyCardAction?.Invoke(notify);
	}

	public void BindMonthlyCardNotify(Action<MonthlyCardPopUpNotify> action)
	{
		monthlyCardAction = (Action<MonthlyCardPopUpNotify>)Delegate.Combine(monthlyCardAction, action);
	}

	public void RemoveMonthlyCardNotify(Action<MonthlyCardPopUpNotify> action)
	{
		monthlyCardAction = (Action<MonthlyCardPopUpNotify>)Delegate.Remove(monthlyCardAction, action);
	}

	private async void OnUserPayNotify(UserPayNotify notify)
	{
		if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(notify.Error, "", showToast: false))
		{
			RewardThings rewards = (await PropHelper.AnalyzeRewardFromServer(notify.Things)).ConvertToRewardThings();
			Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.SavePay(notify.FirstCharge, notify.TotalCharge);
			await RequestData();
			PublishMessage(ShopMessageEnum.ReceivedPayRewards, rewards);
		}
	}

	public async UniTask<bool> RequestData()
	{
		await RequestGetMonthlyCardInfo();
		await RequestAllShopData();
		return true;
	}

	public async UniTask<bool> RequestAllShopData()
	{
		C2H_GetShopInfoRequest rst = C2H_GetShopInfoRequest.Create();
		rst.MainShopId = 0;
		rst.ShopId = 0;
		H2C_GetShopInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_GetShopInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取商店信息") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取商店信息失败"))
			{
				Dictionary<int, Dictionary<int, ShopInfoData>> dictionary = new Dictionary<int, Dictionary<int, ShopInfoData>>();
				foreach (PbShopInfo shopInfo in response.ShopInfos)
				{
					if (!dictionary.ContainsKey(shopInfo.MainShopId))
					{
						dictionary.Add(shopInfo.MainShopId, new Dictionary<int, ShopInfoData>());
					}
					dictionary[shopInfo.MainShopId].Add(shopInfo.ShopId, ShopInfoData.Create(shopInfo));
				}
				shopViewModel.InitShopDatas(dictionary);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<List<ShopInfoData>> RequestShopDatas(int mainShopId)
	{
		List<ShopInfoData> shopList = new List<ShopInfoData>();
		C2H_GetShopInfoRequest rst = C2H_GetShopInfoRequest.Create();
		rst.MainShopId = mainShopId;
		rst.ShopId = 0;
		H2C_GetShopInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_GetShopInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"获取主商店:{mainShopId} 信息") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, $"获取主商店:{mainShopId} 信息失败"))
			{
				response.ShopInfos.ForEach(delegate(PbShopInfo p)
				{
					shopList.Add(ShopInfoData.Create(p));
				});
				shopViewModel.UpdateMainShopData(mainShopId, shopList);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return shopList;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return shopList;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return shopList;
	}

	public async UniTask<ShopInfoData> RequestShopData(int mainShopId, int shopId)
	{
		ShopInfoData shopInfo = null;
		C2H_GetShopInfoRequest rst = C2H_GetShopInfoRequest.Create();
		rst.MainShopId = mainShopId;
		rst.ShopId = shopId;
		H2C_GetShopInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_GetShopInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"获取商店:{mainShopId} {shopId} 商品信息") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, $"获取商店:{mainShopId} {shopId} 商品信息失败"))
			{
				shopInfo = ((response.ShopInfos.Count > 0) ? ShopInfoData.Create(response.ShopInfos[0]) : null);
				shopViewModel.UpdateShopData(shopInfo);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return shopInfo;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return shopInfo;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return shopInfo;
	}

	public async UniTask<RewardGetData> RequestShopExchange(int mainShopId, int shopId, int exchangeId, int exchangeCount, int consumeSchemeIndex)
	{
		C2H_ShopExchangeRequest rst = C2H_ShopExchangeRequest.Create();
		rst.MainShopId = mainShopId;
		rst.ShopId = shopId;
		rst.ExchangeId = exchangeId;
		rst.ExchangeCount = exchangeCount;
		rst.ConsumeItemIndex = consumeSchemeIndex;
		H2C_ShopExchangeResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_ShopExchangeResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求兑换商品"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求兑换商品失败"))
				{
					shopViewModel.UpdateExcResult(mainShopId, shopId, exchangeId, exchangeCount);
					RewardGetData rewardData = PropHelper.AnalyzeRewardFromServer(response.ItemChange);
					rewardData.Attach(await PropHelper.AnalyzeRewardFromServer(response.EquipChange));
					PublishMessage(ShopMessageEnum.GoodsBuy, exchangeId);
					return rewardData;
				}
				AddShopBuyFailedTDA(response.Error, mainShopId, shopId, exchangeId, consumeSchemeIndex);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<RewardGetData> RequestActivityPacksChainBuyAll(int activityTypeId, int packsChainId)
	{
		C2H_ActivityShopExchangeRequest rst = C2H_ActivityShopExchangeRequest.Create();
		rst.ActivityId = activityTypeId;
		rst.ChainId = packsChainId;
		H2C_ActivityShopExchangeResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_ActivityShopExchangeResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求购买礼包链"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求购买礼包链失败"))
				{
					RewardGetData rewardData = PropHelper.AnalyzeRewardFromServer(response.ItemChange);
					rewardData.Attach(await PropHelper.AnalyzeRewardFromServer(response.EquipChange));
					return rewardData;
				}
				if (response.Error == 200159)
				{
					return new RewardGetData();
				}
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<RewardGetData> RequestActivityPacksChainBuy(int activityTypeId, int packsShopId)
	{
		C2H_ActivityShopExchangeRequest rst = C2H_ActivityShopExchangeRequest.Create();
		rst.ActivityId = activityTypeId;
		rst.ExchangeId = packsShopId;
		H2C_ActivityShopExchangeResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_ActivityShopExchangeResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求购买礼包链"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求购买礼包链失败"))
				{
					RewardGetData rewardData = PropHelper.AnalyzeRewardFromServer(response.ItemChange);
					rewardData.Attach(await PropHelper.AnalyzeRewardFromServer(response.EquipChange));
					return rewardData;
				}
				if (response.Error == 200159)
				{
					return new RewardGetData();
				}
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	private void AddShopBuyFailedTDA(int errorCode, int mainShopId, int shopId, int exchangeId, int consumeSchemeIndex)
	{
		if (errorCode == 0)
		{
			return;
		}
		ShopInfoData shopData = shopViewModel.GetShopData(mainShopId, shopId);
		if (shopData == null || !shopData.ShopExcDatas.TryGetValue(exchangeId, out var value))
		{
			return;
		}
		string text = GameEntry.DataTable.GetDataRow<DRMainShopList>(mainShopId)?.ShopName ?? "";
		List<PropDataBase> list = ((value.ConsumeSchemes.Count > consumeSchemeIndex) ? value.ConsumeSchemes[consumeSchemeIndex] : null);
		string value2 = "";
		if (value.CashPriceCount > 0)
		{
			value2 = $"人民币：{value.CashPriceCount}";
		}
		else if (list != null)
		{
			if (list.Count > 1)
			{
				value2 = $"{list[0].Name}{list[0].Id}:{list[0].Amount} + {list[1].Name}{list[1].Id}:{list[1].Amount}";
			}
			else if (list.Count > 0)
			{
				value2 = $"{list[0].Name}{list[0].Id}:{list[0].Amount}";
			}
		}
		string value3 = $"未知错误【{errorCode}】";
		DRErrorCode dataRow = GameEntry.DataTable.GetDataTable<DRErrorCode>().GetDataRow(errorCode);
		if (dataRow != null)
		{
			value3 = dataRow.Tips;
		}
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("shop_type", text + "-" + shopData.Name);
		dictionary.Add("goods_id", $"{exchangeId}");
		dictionary.Add("goods_name", value.Prop.Name ?? "");
		dictionary.Add("goods_price", 0);
		dictionary.Add("price_type", value2);
		dictionary.Add("is_success", false);
		dictionary.Add("good_failed_reason", value3);
		TDAHandler.Instance.SendUserEvent("goods_buy", dictionary);
		dictionary.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	public async UniTask<bool> GetShopInfo(int shopId)
	{
		C2H_GetShopInfoRequest rst = C2H_GetShopInfoRequest.Create();
		rst.ShopId = shopId;
		H2C_GetShopInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_GetShopInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取商店信息") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取商店信息失败"))
			{
				for (int i = 0; i < response.ShopInfos.Count; i++)
				{
				}
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public ShopViewModel GetData()
	{
		return shopViewModel;
	}

	public void DebugShopNew()
	{
		Dictionary<int, Dictionary<int, ShopInfoData>> allShopDatas = shopViewModel.GetAllShopDatas();
		StringBuilder stringBuilder = new StringBuilder();
		foreach (Dictionary<int, ShopInfoData> value in allShopDatas.Values)
		{
			foreach (ShopInfoData value2 in value.Values)
			{
				stringBuilder.AppendLine($"{value2.ShopId} RefreshNew:{value2.RefreshNew} FreeNew:{value2.FreeNew} New:{value2.New}");
				foreach (ShopExcData value3 in value2.ShopExcDatas.Values)
				{
					stringBuilder.AppendLine($"   {value3.ExcId} FreeNew:{value3.FreeNew}");
				}
			}
		}
		Log.Error(stringBuilder);
	}

	public async UniTask RequestGetMonthlyCardInfo()
	{
		monthlyCardLeftDay = -1;
		monthlyCardTodayGot = false;
		GetMonthlyCardInfoRequest rst = GetMonthlyCardInfoRequest.Create();
		GetMonthlyCardInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetMonthlyCardInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取月卡信息") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取月卡信息失败"))
			{
				monthlyCardLeftDay = response.LeftDays;
				monthlyCardTodayGot = response.TodayGot != 0;
				needDailyUpdate = monthlyCardLeftDay == 0;
				PublishMessage(ShopMessageEnum.MonthlyCardInfoChanged);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
	}

	public async UniTask<bool> RequestBuyMonthlyCard()
	{
		BuyMonthlyCardRequest rst = BuyMonthlyCardRequest.Create();
		BuyMonthlyCardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<BuyMonthlyCardResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "月卡购买资格校验") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "月卡购买资格校验 失败"))
			{
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<KeyValuePair<bool, List<PropDataBase>>> RequestGetMonthlyCardReward()
	{
		GetMonthlyCardRewardRequest rst = GetMonthlyCardRewardRequest.Create();
		KeyValuePair<bool, List<PropDataBase>> result = new KeyValuePair<bool, List<PropDataBase>>(key: false, null);
		GetMonthlyCardRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetMonthlyCardRewardResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "领取月卡奖励") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "领取月卡奖励失败"))
			{
				result = new KeyValuePair<bool, List<PropDataBase>>(key: true, (await PropHelper.AnalyzeRewardFromServer(response.Rewards)).PropList);
				await RequestGetMonthlyCardInfo();
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return result;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return result;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return result;
	}

	public int GetMonthlyCardLeftDay()
	{
		return monthlyCardLeftDay;
	}

	public bool GetMonthlyCardTodayGot()
	{
		return monthlyCardTodayGot;
	}

	private async void OnDailyUpdated()
	{
		if (needDailyUpdate)
		{
			await RequestGetMonthlyCardInfo();
		}
	}

	public void Dispose()
	{
		Singleton<ServiceSystem>.Instance?.GetService<ITimeService>()?.RemoveDailyUpdateAction(OnDailyUpdated);
	}

	public async UniTask<RewardGetData> SendCurrencyExchange(int usePropId, int targetPropId, int count)
	{
		CurrencyExchangeRequest request = CurrencyExchangeRequest.Create();
		request.SourceId = usePropId;
		request.TargetId = targetPropId;
		request.TargetNum = count;
		CurrencyExchangeResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<CurrencyExchangeResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "兑换", $"道具{usePropId} 兑换 {targetPropId} 数量 {count} 失败"))
			{
				return PropHelper.AnalyzeRewardFromServer(response.ItemChange);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error($"道具{usePropId} 兑换 {targetPropId} 数量 {count} 失败，发生异常！{ex2.Message} / {ex2.StackTrace}");
			return null;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}
}
