using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public static class ShopDefinition
{
	public static void FilterListSort(List<ShopGoodItemData> shopGoodItemDatas)
	{
		if (GameEntry.BuiltinData.OpenTestFlight)
		{
			shopGoodItemDatas.RemoveAll((ShopGoodItemData p) => p.GetSoldOutHide() || Constant.DisabledExchangeShopIds.Contains(p.ExcData.ExcId));
		}
		else
		{
			shopGoodItemDatas.RemoveAll((ShopGoodItemData p) => p.GetSoldOutHide());
		}
		shopGoodItemDatas.Sort(delegate(ShopGoodItemData a, ShopGoodItemData b)
		{
			ShopExcData excData = a.ExcData;
			ShopExcData excData2 = b.ExcData;
			if (excData.IsUnlock != excData2.IsUnlock)
			{
				if (!excData.IsUnlock)
				{
					return 1;
				}
				return -1;
			}
			bool flag = excData.QuotaNum < 0 || excData.LeftExc > 0;
			bool flag2 = excData2.QuotaNum < 0 || excData2.LeftExc > 0;
			return (flag != flag2) ? ((!flag) ? 1 : (-1)) : (100 * excData.Sort.CompareTo(excData2.Sort) - 10 * excData.Prop.GetRarity().CompareTo(excData2.Prop.GetRarity()) + excData.ExcId.CompareTo(excData2.ExcId));
		});
	}

	public static float GetVoucherToDiamondRate()
	{
		return GameEntry.DataTable.GetDataRow<DRConstantConfig>(1003)?.Value ?? 0f;
	}

	public static float GetVoucherToSkinTicketRate()
	{
		return GameEntry.DataTable.GetDataRow<DRConstantConfig>(1031)?.Value ?? 0f;
	}

	public static void OnShopGoodItemClick(ShopExcData excData, PropExchangeViewModel exchangeViewModel, OptionBase windowData, string entrance)
	{
		if (excData == null || windowData == null || exchangeViewModel == null)
		{
			return;
		}
		List<List<PropDataBase>> consumeSchemes = excData.ConsumeSchemes;
		if (consumeSchemes.Count > 0 && consumeSchemes[0].Count > 0)
		{
			int id = excData.ConsumeSchemes[0][0].Id;
			int amount = excData.ConsumeSchemes[0][0].Amount;
			if (!GoodSpecialPriceEnoughCheck(id, amount, out var leftNeedCount))
			{
				OpenSpConsumeExcDialog(id, leftNeedCount, windowData);
				return;
			}
		}
		if (!exchangeViewModel.Initilized)
		{
			exchangeViewModel.SetData(excData);
			windowData.OpenWindowRequest.Raise(new OpenViewArg(typeof(PropExchangeView), exchangeViewModel, entrance, isOpenWindow: false));
			exchangeViewModel.Initilized = true;
		}
		else
		{
			exchangeViewModel.SetData(excData);
			windowData.ShowViewRequest.Raise(new ShowViewArg(exchangeViewModel, isShow: true));
		}
	}

	public static void OnShopGoodItemClick(ShopExcData excData, Func<ShopExcData, PropExchangeViewModel> funcGetExcViewModel, OptionBase windowData, string entrance)
	{
		if (excData == null || windowData == null || funcGetExcViewModel == null)
		{
			return;
		}
		List<List<PropDataBase>> consumeSchemes = excData.ConsumeSchemes;
		if (consumeSchemes.Count > 0 && consumeSchemes[0].Count > 0)
		{
			int id = excData.ConsumeSchemes[0][0].Id;
			int amount = excData.ConsumeSchemes[0][0].Amount;
			if (!GoodSpecialPriceEnoughCheck(id, amount, out var leftNeedCount))
			{
				OpenSpConsumeExcDialog(id, leftNeedCount, windowData);
				return;
			}
		}
		PropExchangeViewModel propExchangeViewModel = funcGetExcViewModel(excData);
		if (propExchangeViewModel != null)
		{
			Type type = null;
			type = excData.Prop.PropTypeEnum switch
			{
				PropTypeEnum.GiftPack => typeof(ShopGiftPackWindow), 
				PropTypeEnum.Weapon => typeof(ShopWeaponWindow), 
				_ => typeof(PropExchangeView), 
			};
			if (!propExchangeViewModel.Initilized)
			{
				propExchangeViewModel.SetData(excData);
				windowData.OpenWindowRequest.Raise(new OpenViewArg(type, propExchangeViewModel, entrance, isOpenWindow: false));
				propExchangeViewModel.Initilized = true;
			}
			else
			{
				propExchangeViewModel.SetData(excData);
				windowData.ShowViewRequest.Raise(new ShowViewArg(propExchangeViewModel, isShow: true));
			}
		}
	}

	public static async UniTask OnExchangeConfirm(OptionBase optionBase, PropExchangeViewModel propExchangeViewModel, ShopViewDataBase shopViewDataBase, Action<int, int, string> sdkPayAction)
	{
		int useCount = 0;
		int schemeIndex = 0;
		if (propExchangeViewModel.CashPrice != 0 && propExchangeViewModel.ExchangeData is ShopExcData shopExcData)
		{
			propExchangeViewModel.UseCount = 1;
			int cashPriceCount = shopExcData.CashPriceCount;
			int excId = shopExcData.ExcId;
			string nameAndCount = propExchangeViewModel.NameAndCount;
			sdkPayAction?.Invoke(cashPriceCount, excId, nameAndCount);
		}
		ShopExcData shopExcData2 = null;
		if (propExchangeViewModel.ExchangeData is ShopExcData)
		{
			shopExcData2 = (ShopExcData)propExchangeViewModel.ExchangeData;
			schemeIndex = ((propExchangeViewModel.ConsumeSchemeType == ExchangeConsumeScheme.Multiple) ? propExchangeViewModel.CurSchemeTabIndex : 0);
			useCount = propExchangeViewModel.UseCount;
		}
		if (shopExcData2 == null)
		{
			return;
		}
		if (propExchangeViewModel.CashPrice != 0 && propExchangeViewModel.ExchangeData is ShopExcData)
		{
			propExchangeViewModel.OnEnable();
			return;
		}
		Loading loading = await Loading.Show();
		RewardGetData rewardGetData = await Singleton<ServiceSystem>.Instance.GetService<IShopService>().RequestShopExchange(shopExcData2.MainShopId, shopExcData2.ShopId, shopExcData2.ExcId, useCount, schemeIndex);
		loading.Dispose();
		if (rewardGetData != null)
		{
			if (rewardGetData.PropList.Count > 0)
			{
				PropGetViewModel userData = new PropGetViewModel(optionBase, rewardGetData.PropList);
				optionBase.OpenWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData));
			}
			shopViewDataBase?.OnExchangeSucceed(shopExcData2.MainShopId, shopExcData2.ShopId, shopExcData2.ExcId, useCount);
			propExchangeViewModel.SetData(shopExcData2);
			optionBase.ShowViewRequest.Raise(new ShowViewArg(propExchangeViewModel, isShow: false));
		}
		propExchangeViewModel.OnEnable();
	}

	public static void OpenSpConsumeExcDialog(int priceId, int leftNeedCount, OptionBase windowData)
	{
		DRProp priceConfig = GameEntry.DataTable.GetDataRow<DRProp>(priceId);
		DRProp cashPropConfig = GameEntry.DataTable.GetDataRow<DRProp>(9006);
		if (priceConfig == null || cashPropConfig == null)
		{
			return;
		}
		float num = 0f;
		switch (priceId)
		{
		case 9002:
			num = GetVoucherToDiamondRate();
			break;
		case 9012:
			num = GetVoucherToSkinTicketRate();
			break;
		}
		if (num <= 0f)
		{
			return;
		}
		int cashCount = (int)Math.Ceiling((double)leftNeedCount / (double)num);
		IAsyncResult<int> result = AlertDialog.Show(priceConfig.Name + "兑换", $"{priceConfig.Name}不足，是否使用{cashCount}个{cashPropConfig.Name}购买{leftNeedCount}个{priceConfig.Name}?", "同意", "拒绝");
		result.Callbackable().OnCallback(async delegate
		{
			if (result.Result == -1)
			{
				TrySendCurrencyExchange(cashPropConfig, priceConfig.Id, cashCount, windowData);
			}
		});
	}

	private static async void TrySendCurrencyExchange(DRProp useConfig, int targetId, int count, OptionBase windowData)
	{
		if (!PropHelper.CheckPropEnough(useConfig.Id, count))
		{
			IAsyncResult<int> result = AlertDialog.Show("提示", useConfig.Name + "不足，是否前往镀金商店购买?", "同意", "拒绝");
			result.Callbackable().OnCallback(async delegate
			{
				if (result.Result == -1)
				{
					ShopWindowViewModel userData2 = new ShopWindowViewModel(windowData, 998);
					windowData.ItemOnClick(new OpenViewArg(typeof(ShopWindow), userData2));
				}
			});
			return;
		}
		RewardGetData rewardGetData = await SendCurrencyExchange(useConfig.Id, targetId, count);
		if (rewardGetData != null)
		{
			List<PropDataBase> propList = rewardGetData.PropList;
			if (propList != null && propList.Count > 0)
			{
				PropGetViewModel userData = new PropGetViewModel(windowData, rewardGetData.PropList);
				windowData.ItemOnClick(new OpenViewArg(typeof(PropGetWindow), userData));
			}
		}
	}

	private static async UniTask<RewardGetData> SendCurrencyExchange(int useId, int targetId, int count)
	{
		Loading loading = await Loading.Show();
		RewardGetData result = await Singleton<ServiceSystem>.Instance.GetService<IShopService>().SendCurrencyExchange(useId, targetId, count);
		loading?.Dispose();
		return result;
	}

	public static bool GoodSpecialPriceEnoughCheck(int priceId, int needCount, out int leftNeedCount)
	{
		leftNeedCount = 0;
		if (priceId == 9002 || priceId == 9012)
		{
			int propOwnedCount = PropHelper.GetPropOwnedCount(priceId);
			if (propOwnedCount >= needCount)
			{
				return true;
			}
			leftNeedCount = needCount - propOwnedCount;
			return false;
		}
		return true;
	}

	public static bool OpenSDKPay(int payAmount, int productId, string productName)
	{
		IRoleService service = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
		if (service == null)
		{
			return false;
		}
		PlayerData playerInfo = service.GetRoleData().PlayerInfo;
		MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.GetMyGuildData();
		PyParams pyParams = new PyParams();
		pyParams.game_Role_Id = playerInfo.Uid.ToString();
		pyParams.amount = payAmount.ToString();
		pyParams.role_name = playerInfo.Name;
		pyParams.product_Id = productId;
		pyParams.sid = Singleton<NetworkSystem>.Instance.IP ?? "";
		pyParams.serverName = Singleton<NetworkSystem>.Instance.ServerName ?? "";
		pyParams.product_name = productName;
		pyParams.vipLevel = playerInfo.Vip.ToString();
		pyParams.roleLevel = playerInfo.Level.ToString();
		pyParams.UnionName = myGuildData?.Name ?? "";
		pyParams.app_Ext1 = MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Voucher).ToString();
		Singleton<ServiceSystem>.Instance.GetService<ISDKService>().Pay(pyParams);
		return true;
	}
}
