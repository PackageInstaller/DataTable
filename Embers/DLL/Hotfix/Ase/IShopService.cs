using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public interface IShopService
{
	IMessenger GetMessager();

	void PublishMessage(ShopMessageEnum messageEnum, object arg = null);

	UniTask<bool> RequestData();

	UniTask<bool> RequestAllShopData();

	UniTask<List<ShopInfoData>> RequestShopDatas(int mainShopId);

	UniTask<ShopInfoData> RequestShopData(int mainShopId, int shopId);

	UniTask<RewardGetData> RequestShopExchange(int mainShopId, int shopId, int exchangeId, int exchangeCount, int consumeSchemeIndex);

	UniTask<RewardGetData> RequestActivityPacksChainBuyAll(int activityTypeId, int packsChainId);

	UniTask<RewardGetData> RequestActivityPacksChainBuy(int activityTypeId, int packsShopId);

	void BindShopNotify(Action<ShopRefreshNotify> action);

	void RemoveBindShopNotify(Action<ShopRefreshNotify> action);

	void BindMonthlyCardNotify(Action<MonthlyCardPopUpNotify> action);

	void RemoveMonthlyCardNotify(Action<MonthlyCardPopUpNotify> action);

	ShopViewModel GetData();

	UniTask RequestGetMonthlyCardInfo();

	UniTask<bool> RequestBuyMonthlyCard();

	UniTask<KeyValuePair<bool, List<PropDataBase>>> RequestGetMonthlyCardReward();

	UniTask<RewardGetData> SendCurrencyExchange(int usePropId, int targetPropId, int count);

	int GetMonthlyCardLeftDay();

	bool GetMonthlyCardTodayGot();

	void Dispose();
}
