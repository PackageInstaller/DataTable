local title = {
	id = 0,
	type = 0,
	order = 0,
	rechargeType = 0,
	stage = 0,
	rmb = 0,
	reward = 0,
	firstRecharge = 0,
	nextRecharge = 0,
	itemReward = 0,
	desc = 0,
	itemPicture = "",
	isShow = 0,
	shopBagId = 0,
	payId = 0,
	shopId = 0
}

local value = {
[1001] =
{
 		id=1001,
 		type=1,
 		rechargeType=1,
 		stage=1,
 		rmb=6,
 		reward=60,
 		firstRecharge=60,
 		nextRecharge=20,
 		desc=536,
 		itemPicture="UI/SpritePics/shop/ui_shop_icon_01",
 		payId=1,
 	shopId=201
},
[1002] =
{
 		id=1002,
 		type=1,
 		rechargeType=1,
 		stage=2,
 		rmb=30,
 		reward=300,
 		firstRecharge=300,
 		nextRecharge=110,
 		desc=537,
 		itemPicture="UI/SpritePics/shop/ui_shop_icon_02",
 		payId=2,
 	shopId=201
},
[1003] =
{
 		id=1003,
 		type=1,
 		rechargeType=1,
 		stage=3,
 		rmb=98,
 		reward=980,
 		firstRecharge=980,
 		nextRecharge=400,
 		desc=538,
 		itemPicture="UI/SpritePics/shop/ui_shop_icon_03",
 		payId=3,
 	shopId=201
},
[1004] =
{
 		id=1004,
 		type=1,
 		rechargeType=1,
 		stage=4,
 		rmb=198,
 		reward=1980,
 		firstRecharge=1980,
 		nextRecharge=870,
 		desc=539,
 		itemPicture="UI/SpritePics/shop/ui_shop_icon_04",
 		payId=4,
 	shopId=201
},
[1005] =
{
 		id=1005,
 		type=1,
 		rechargeType=1,
 		stage=5,
 		rmb=328,
 		reward=3280,
 		firstRecharge=3280,
 		nextRecharge=1540,
 		desc=540,
 		itemPicture="UI/SpritePics/shop/ui_shop_icon_05",
 		payId=5,
 	shopId=201
},
[1006] =
{
 		id=1006,
 		type=1,
 		rechargeType=1,
 		stage=6,
 		rmb=648,
 		reward=6480,
 		firstRecharge=6480,
 		nextRecharge=3240,
 		desc=541,
 		itemPicture="UI/SpritePics/shop/ui_shop_icon_06",
 		payId=6,
 	shopId=201
}
}

return {title=title, value=value}