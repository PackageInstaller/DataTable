-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/util/StoreEnum.lua

module("logic.extensions.store.util.StoreEnum", package.seeall)

MallType = {
	Skin = 7,
	RandomOutput = 5,
	MonthyCard = 99,
	CurrencyExchange = 4,
	DirectPurchase = 1,
	GiftBag = 3,
	EchoCardPack = 9,
	Fixed = 6,
	SecondExchange = 2
}
GoodsType = {
	MonthlyCard = 11,
	FirstMoney = 10,
	GiftBag = 14,
	SecondMoney = 12,
	Skin = 15,
	Normal = 13
}
BubbleFactor = {
	Enter = 1,
	Buy = 4,
	NoAction = 2,
	OpenRecommend = 5,
	Click = 3
}
GoodsTag = {
	IsNew = 1
}
BannerType = {
	MonthCard = 1,
	FirstCharge = 3,
	SingleBanner = 2
}
TabId = {
	Skin = 1003,
	HotList = 1002,
	EchoExchange = 1007,
	Exchange = 1006,
	SuperValue = 1001,
	Home = 1004,
	GiftBag = 1005
}
StoreId = {
	MonthCard = 100001,
	SecondExchange = 120001,
	TranscendentalMedium = 110001
}
StoreMapRedId = {
	[StoreEnum.StoreId.TranscendentalMedium] = {
		GameEnum.RedPointEnum.RechargeAccumulate
	}
}
StoreBannerMapRedId = {
	[StoreEnum.BannerType.FirstCharge] = {
		GameEnum.RedPointEnum.RechargeFirst
	}
}
GoodsQualityIcon = {
	"slmmy_list_s_c",
	"slmmy_list_s_c",
	"slmmy_list_s_b",
	"slmmy_list_s_a",
	"slmmy_list_s_s"
}
HotListItemQualityIcon = {
	"store_hotlist_yt_01",
	"store_hotlist_yt_01",
	"store_hotlist_yt_01",
	"slmmy_list_special"
}
HotListItemQualityIcon2 = {
	"store_hotlist_cf_01",
	"store_hotlist_cf_01",
	"store_hotlist_cf_02",
	"store_hotlist_cf_02"
}
SkinItemQualityIcon = {
	"slmmy_list_l_c",
	"slmmy_list_l_c",
	"slmmy_list_l_b",
	"slmmy_list_l_a",
	"slmmy_list_l_s"
}
ExchangeItemQualityIcon = {
	"slmmy_list_s_c",
	"slmmy_list_s_c",
	"slmmy_list_s_b",
	"slmmy_list_s_a",
	"slmmy_list_s_s"
}
GiftBagItemQualityIcon = {
	[0] = "shop_gift_bg0",
	"shop_gift_bg1",
	"shop_gift_bg2",
	"shop_gift_bg3",
	"shop_gift_bg4"
}
StoreLocalStorageKey = "store"
StoreRechargeKey = "storeRecharge"
StoreFirstChargeKey = "FirstCharge"
StoreFirstChargeViewKey = "FirstChargeView"
StoreFirstPopChargeViewKey = "FirstPopChargeView"
StoreFirstChargeViewOpenTimes = "FirstPopChargeViewOpenTimes"
StoreRechargeStatus = {
	hasGet = 3,
	canGet = 2,
	unsatisfied = 1
}
StoreFirstChargeStatus = {
	hasGet = 2,
	canGet = 1,
	unsatisfied = 0
}
CacheKey = {
	FirstRePointKey = "FirstRePointKey"
}
StoreLimitNames = {
	"tip_store_day_limit",
	"tip_store_week_limti",
	"tip_store_month_limit"
}
BuyConfirmTitleNme = {
	[StoreEnum.GoodsType.Skin] = "tip_store_buy_title_skin",
	[StoreEnum.GoodsType.MonthlyCard] = "tip_store_buy_title_monthly_card",
	[StoreEnum.GoodsType.Normal] = "tip_store_buy_title_normal",
	[StoreEnum.GoodsType.GiftBag] = "tip_store_buy_title_gift_bag"
}
