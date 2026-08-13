class = var_0_10000

local var_0_0 = "NewShopMainScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

var_0_1.CLOSE_ALL_LAYER = "NewShopMainScene.CLOSE_ALL_LAYER"
var_0_1.SHOW_OR_HIDE_UI = "NewShopMainScene.SHOW_OR_HIDE_UI"
var_0_1.SHOW_OR_HIDE_UI_2 = "NewShopMainScene.SHOW_OR_HIDE_UI_2"
var_0_1.CLOSE_VIEW = "NewShopMainScene.CLOSE_VIEW"
var_0_1.TYPE_CHARGE = "charge"
var_0_1.TYPE_SKIN = "skin"
var_0_1.ON_CLICK_SKIN_SHOP = "NewShopMainScene::ON_CLICK_SKIN_SHOP"

function var_0_1.getUIName(arg_1_0)
	return "NewShopUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	ShopsProxy = var_1_10003

	local var_2_0 = var_1_10002(var_1_10003)

	local function var_2_1()
		local var_3_0 = var_2_0
		local var_3_1 = var_0.getFirstChargeList(var_3_0)
		local var_3_2 = var_2_0
		local var_3_3 = var_1.getChargedList(var_3_2)
		local var_3_4 = var_2_0
		local var_3_5 = var_2.GetNormalList(var_3_4)
		local var_3_6 = var_2_0
		local var_3_7 = var_3.GetNormalGroupList(var_3_6)

		if var_3_1 then
			local var_3_8 = arg_2_0

			var_4.setFirstChargeIds(var_3_8, var_3_1)
		end

		if var_3_3 then
			local var_3_9 = arg_2_0

			var_4.setChargedList(var_3_9, var_3_3)
		end

		if var_3_5 then
			local var_3_10 = arg_2_0

			var_4.setNormalList(var_3_10, var_3_5)
		end

		if var_3_7 then
			local var_3_11 = arg_2_0

			var_4.setNormalGroupList(var_3_11, var_3_7)
		end

		arg_2_1()

		return
	end

	if var_2_0:ShouldRefreshChargeList() then
		pg = var_4

		local var_2_2 = var_4.m02
		local var_2_3 = var_4.sendNotification

		GAME = var_1_10006

		var_2_3(var_2_2, var_1_10006.GET_CHARGE_LIST, {
			callback = var_2_1
		})
	else
		var_2_1()
	end

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.buttonList = var_1.Find(var_4_0, "buttonList")
	arg_4_0.backBtn = var_1:Find("top/closeBtn")
	arg_4_0.homeBtn = var_1:Find("top/homeBtn")
	arg_4_0.resourcePanel = var_1:Find("top/resources")
	setActive = var_2

	var_2(arg_4_0.resourcePanel, false)

	arg_4_0.goldBtn = var_1:Find("top/resources/gold")

	local var_4_1 = var_1:Find("top/resources/gold/Text")
	local var_4_2 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_4_0.goldText = var_4_2(var_4_1, var_4(var_1_10005))

	local var_4_3 = var_1:Find("top/resources/gold/max")
	local var_4_4 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_4_0.goldMax = var_4_4(var_4_3, var_4(var_1_10005))
	arg_4_0.oilBtn = var_1:Find("top/resources/oil")

	local var_4_5 = var_1:Find("top/resources/oil/Text")
	local var_4_6 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_4_0.oilText = var_4_6(var_4_5, var_4(var_1_10005))

	local var_4_7 = var_1:Find("top/resources/oil/max")
	local var_4_8 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_4_0.oilMax = var_4_8(var_4_7, var_4(var_1_10005))
	arg_4_0.diamondBtn = var_1:Find("top/resources/gem")

	local var_4_9 = var_1:Find("top/resources/gem/Text")
	local var_4_10 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_4_0.diamondText = var_4_10(var_4_9, var_4(var_1_10005))
	setText = var_2

	local var_4_11 = var_1
	local var_4_12 = var_1.Find(var_4_11, "top/title/Text")

	i18n = var_4_11

	var_2(var_4_12, var_4_11("shop_title"))

	setText = var_2

	local var_4_13 = var_1
	local var_4_14 = var_1.Find(var_4_13, "shop1List/recommendation/shop1Tg/name")

	i18n = var_4_13

	var_2(var_4_14, var_4_13("shop_recommend"))

	setText = var_2

	local var_4_15 = var_1
	local var_4_16 = var_1.Find(var_4_15, "shop1List/skinShop/shop1Tg/name")

	i18n = var_4_15

	var_2(var_4_16, var_4_15("shop_skin"))

	setText = var_2

	local var_4_17 = var_1
	local var_4_18 = var_1.Find(var_4_17, "shop1List/diamondShop/shop1Tg/name")

	i18n = var_4_17

	var_2(var_4_18, var_4_17("shop_diamond_title"))

	setText = var_2

	local var_4_19 = var_1
	local var_4_20 = var_1.Find(var_4_19, "shop1List/specialShop/shop1Tg/name")

	i18n = var_4_19

	var_2(var_4_20, var_4_19("shop_akashi_pick_title"))

	setText = var_2

	local var_4_21 = var_1
	local var_4_22 = var_1.Find(var_4_21, "shop1List/giftPackShop/shop1Tg/name")

	i18n = var_4_21

	var_2(var_4_22, var_4_21("shop_gift_title"))

	setText = var_2

	local var_4_23 = var_1
	local var_4_24 = var_1.Find(var_4_23, "shop1List/functionalItemShop/shop1Tg/name")

	i18n = var_4_23

	var_2(var_4_24, var_4_23("shop_item_title"))

	setText = var_2

	local var_4_25 = var_1
	local var_4_26 = var_1.Find(var_4_25, "shop1List/supplyShop/shop1Tg/name")

	i18n = var_4_25

	var_2(var_4_26, var_4_25("shop_supply_prop"))

	setText = var_2

	local var_4_27 = var_1
	local var_4_28 = var_1.Find(var_4_27, "shop1List/recommendation/shop1Tg/name/en")

	i18n = var_4_27

	var_2(var_4_28, var_4_27("shop_recommend_en"))

	setText = var_2

	local var_4_29 = var_1
	local var_4_30 = var_1.Find(var_4_29, "shop1List/skinShop/shop1Tg/name/en")

	i18n = var_4_29

	var_2(var_4_30, var_4_29("shop_skin_en"))

	setText = var_2

	local var_4_31 = var_1
	local var_4_32 = var_1.Find(var_4_31, "shop1List/diamondShop/shop1Tg/name/en")

	i18n = var_4_31

	var_2(var_4_32, var_4_31("shop_diamond_title_en"))

	setText = var_2

	local var_4_33 = var_1
	local var_4_34 = var_1.Find(var_4_33, "shop1List/specialShop/shop1Tg/name/en")

	i18n = var_4_33

	var_2(var_4_34, var_4_33("shop_side_lable_en"))

	setText = var_2

	local var_4_35 = var_1
	local var_4_36 = var_1.Find(var_4_35, "shop1List/giftPackShop/shop1Tg/name/en")

	i18n = var_4_35

	var_2(var_4_36, var_4_35("shop_gift_title_en"))

	setText = var_2

	local var_4_37 = var_1
	local var_4_38 = var_1.Find(var_4_37, "shop1List/functionalItemShop/shop1Tg/name/en")

	i18n = var_4_37

	var_2(var_4_38, var_4_37("shop_item_title_en"))

	setText = var_2

	local var_4_39 = var_1
	local var_4_40 = var_1.Find(var_4_39, "shop1List/supplyShop/shop1Tg/name/en")

	i18n = var_4_39

	var_2(var_4_40, var_4_39("shop_supply_prop_en"))

	setText = var_2

	local var_4_41 = var_1
	local var_4_42 = var_1.Find(var_4_41, "shop1List/supplyShop/shop2List/monthShop/name")

	i18n = var_4_41

	var_2(var_4_42, var_4_41("shop_month"))

	setText = var_2

	local var_4_43 = var_1
	local var_4_44 = var_1.Find(var_4_43, "shop1List/supplyShop/shop2List/monthShop/selected/name")

	i18n = var_4_43

	var_2(var_4_44, var_4_43("shop_month"))

	setText = var_2

	local var_4_45 = var_1
	local var_4_46 = var_1.Find(var_4_45, "shop1List/supplyShop/shop2List/supplyShop/name")

	i18n = var_4_45

	var_2(var_4_46, var_4_45("shop_supply"))

	setText = var_2

	local var_4_47 = var_1
	local var_4_48 = var_1.Find(var_4_47, "shop1List/supplyShop/shop2List/supplyShop/selected/name")

	i18n = var_4_47

	var_2(var_4_48, var_4_47("shop_supply"))

	setText = var_2

	local var_4_49 = var_1
	local var_4_50 = var_1.Find(var_4_49, "shop1List/supplyShop/shop2List/activityShop/name")

	i18n = var_4_49

	var_2(var_4_50, var_4_49("shop_activity"))

	setText = var_2

	local var_4_51 = var_1
	local var_4_52 = var_1.Find(var_4_51, "shop1List/supplyShop/shop2List/activityShop/selected/name")

	i18n = var_4_51

	var_2(var_4_52, var_4_51("shop_activity"))

	local var_4_53 = arg_4_0._tf

	arg_4_0.frame = var_2.Find(var_4_53, "frame")

	local var_4_54 = arg_4_0._tf

	arg_4_0.viewContainer = var_2.Find(var_4_54, "viewContainer")

	local var_4_55 = arg_4_0._tf

	arg_4_0.painting = var_2.Find(var_4_55, "frame/painting")

	local var_4_56 = arg_4_0._tf

	arg_4_0.chat = var_2.Find(var_4_56, "frame/chat")

	local var_4_57 = arg_4_0.chat

	arg_4_0.chatText = var_2.Find(var_4_57, "Text")

	local var_4_58 = arg_4_0._tf

	arg_4_0.stamp = var_2.Find(var_4_58, "frame/stamp")
	arg_4_0.specialTip = var_1:Find("shop1List/specialShop/shop1Tg/tip")
	arg_4_0.giftTip = var_1:Find("shop1List/giftPackShop/shop1Tg/tip")
	pg = var_2

	local var_4_59 = var_2.EasyRedDotMgr.GetInstance()

	var_2.RegisterRedDot(var_4_59, arg_4_0.specialTip, {
		"specialShop",
		"Charge_Page_Exposure"
	}, function(arg_5_0)
		getProxy = var_2_10001
		ShopsProxy = var_2_10002

		local var_5_0 = var_2_10001(var_2_10002)

		var_1.GiftPackageRedDotTip(var_5_0, {
			arg_5_0
		}, true)

		return
	end)

	pg = var_2

	local var_4_60 = var_2.EasyRedDotMgr.GetInstance()

	var_2.RegisterRedDot(var_4_60, arg_4_0.giftTip, {
		"specialShop",
		"Charge_Page_Exposure"
	}, function(arg_6_0)
		getProxy = var_2_10001
		ShopsProxy = var_2_10002

		local var_6_0 = var_2_10001(var_2_10002)

		var_1.GiftPackageRedDotTip(var_6_0, {
			arg_6_0
		}, false)

		return
	end)

	local var_4_61 = {}
	local var_4_62 = {}

	ChargeScene = var_4
	var_4_62.type = var_4.TYPE_DIAMOND
	var_4_62.go = var_1:Find("shop1List/diamondShop/shop1Tg")
	var_4_61[1] = var_4_62

	local var_4_63 = {}

	ChargeScene = var_4
	var_4_63.type = var_4.TYPE_GIFT
	var_4_63.go = var_1:Find("shop1List/giftPackShop/shop1Tg")
	var_4_61[2] = var_4_63

	local var_4_64 = {}

	ChargeScene = var_4
	var_4_64.type = var_4.TYPE_ITEM
	var_4_64.go = var_1:Find("shop1List/functionalItemShop/shop1Tg")
	var_4_61[3] = var_4_64

	local var_4_65 = {}

	ChargeScene = var_4
	var_4_65.type = var_4.TYPE_PICK
	var_4_65.go = var_1:Find("shop1List/specialShop/shop1Tg")
	var_4_61[4] = var_4_65
	arg_4_0.toggleList = var_4_61
	GetComponent = var_4_61

	local var_4_66 = var_1
	local var_4_67 = var_1.Find(var_4_66, "shop1List/supplyShop/shop2List/supplyShop")

	typeof = var_4_66
	Toggle = var_5

	local var_4_68 = var_4_61(var_4_67, var_4_66(var_5))

	var_4_68.isOn = true
	ChargeTipWindow = var_4_68
	arg_4_0.chargeTipWindow = var_4_68.New(arg_4_0._tf, arg_4_0.event)

	arg_4_0:LoadMingshi()
	arg_4_0:jpUIInit()
	arg_4_0:blurView()
	arg_4_0:initSubView()

	AprilFoolBulinSubView = var_2

	local var_4_69 = var_2.ShowAprilFoolBulin
	local var_4_70 = arg_4_0
	local var_4_71 = arg_4_0.pageContainer

	Vector2 = var_5
	arg_4_0.bulinTip = var_4_69(var_4_70, var_4_71, var_5.New(-35, -90))

	if arg_4_0.bulinTip then
		local var_4_72 = arg_4_0.bulinTip

		var_2.RegisterView(var_4_72, arg_4_0)

		local var_4_73 = arg_4_0.bulinTip

		var_2.CallbackInvoke(var_4_73, function()
			local var_7_0 = arg_4_0

			var_0.OverlayPanel(var_7_0, arg_4_0.bulinTip._tf, {
				groupDelta = 1
			})

			return
		end)

		function arg_4_0.bulinTip.destroyCall()
			local var_8_0 = arg_4_0.bulinTip

			if var_0.GetLoaded(var_8_0) then
				local var_8_1 = arg_4_0

				var_0.UnOverlayPanel(var_8_1, arg_4_0.bulinTip._tf)
			end

			return
		end
	end

	return
end

function var_0_1.setPlayer(arg_9_0, arg_9_1)
	arg_9_0.player = arg_9_1

	if arg_9_0.subViewList[arg_9_0.curSubViewNum] then
		local var_9_0 = arg_9_0.subViewList[arg_9_0.curSubViewNum]

		if var_2.IsSupplyShop(var_9_0) then
			local var_9_1 = arg_9_0.subViewList[arg_9_0.curSubViewNum]

			var_2.SetPlayer(var_9_1, arg_9_1)
		end
	end

	if arg_9_0.goldMax then
		PlayerResUI = var_2

		var_2.StaticFlush(arg_9_0.player, arg_9_0.goldMax, arg_9_0.goldText, arg_9_0.oilMax, arg_9_0.oilText, arg_9_0.diamondText)
	end

	return
end

function var_0_1.setFirstChargeIds(arg_10_0, arg_10_1)
	arg_10_0.firstChargeIds = arg_10_1

	return
end

function var_0_1.setChargedList(arg_11_0, arg_11_1)
	arg_11_0.chargedList = arg_11_1

	return
end

function var_0_1.setNormalList(arg_12_0, arg_12_1)
	arg_12_0.normalList = arg_12_1

	return
end

function var_0_1.setNormalGroupList(arg_13_0, arg_13_1)
	arg_13_0.normalGroupList = arg_13_1

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.addRefreshTimer

	GetZeroTime = var_1_10004

	var_13_1(var_13_0, var_1_10004())

	return
end

function var_0_1.SetSupplyShopList(arg_14_0, arg_14_1)
	arg_14_0.supplyShopList = arg_14_1

	arg_14_0:SortActivityShops()

	return
end

function var_0_1.SortActivityShops(arg_15_0)
	pairs = var_1_10001

	for iter_15_0, iter_15_1 in var_1_10001(arg_15_0.supplyShopList) do
		if #iter_15_1 > 1 then
			table = var_6

			var_6.sort(iter_15_1, function(arg_16_0, arg_16_1)
				return arg_16_0:getStartTime() > arg_16_1:getStartTime()
			end)
		end
	end

	return
end

function var_0_1.OnInitItems(arg_17_0, arg_17_1)
	arg_17_0.items = arg_17_1

	local var_17_0 = arg_17_0.subViewList

	ShopConst = var_1_10003

	local var_17_1 = var_17_0[var_1_10003.SHOP_ID.MONTH]

	var_2.OnUpdateItems(var_17_1, arg_17_1)

	local var_17_2 = arg_17_0.subViewList

	ShopConst = var_17_1

	local var_17_3 = var_17_2[var_17_1.SHOP_ID.SUPPLY]

	var_2.OnUpdateItems(var_17_3, arg_17_1)

	local var_17_4 = arg_17_0.subViewList

	ShopConst = var_17_3

	local var_17_5 = var_17_4[var_17_3.SHOP_ID.ACTIVITY]

	var_2.OnUpdateItems(var_17_5, arg_17_1)

	return
end

function var_0_1.OnUpdateItems(arg_18_0, arg_18_1)
	arg_18_0.items = arg_18_1

	if arg_18_0.subViewList[arg_18_0.curSubViewNum] then
		local var_18_0 = arg_18_0.subViewList[arg_18_0.curSubViewNum]

		if var_2.IsSupplyShop(var_18_0) then
			local var_18_1 = arg_18_0.subViewList[arg_18_0.curSubViewNum]

			var_2.OnUpdateItems(var_18_1, arg_18_1)
		end
	end

	return
end

function var_0_1.OnUpdateShop(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0:SetShop(arg_19_1, arg_19_2)

	if arg_19_0.subViewList[arg_19_0.curSubViewNum] then
		local var_19_0 = arg_19_0.subViewList[arg_19_0.curSubViewNum]

		if var_3.IsSupplyShop(var_19_0) then
			local var_19_1 = arg_19_0.subViewList[arg_19_0.curSubViewNum]

			var_3.OnUpdateShop(var_19_1, arg_19_1, arg_19_2)
		end
	end

	return
end

function var_0_1.OnUpdateCommodity(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0:SetShop(arg_20_1, arg_20_2)

	if arg_20_0.subViewList[arg_20_0.curSubViewNum] then
		local var_20_0 = arg_20_0.subViewList[arg_20_0.curSubViewNum]

		if var_4.IsSupplyShop(var_20_0) then
			local var_20_1 = arg_20_0.subViewList[arg_20_0.curSubViewNum]

			var_4.OnUpdateCommodity(var_20_1, arg_20_1, arg_20_2, arg_20_3)
		end
	end

	return
end

function var_0_1.OnFragmentSellUpdate(arg_21_0)
	if arg_21_0.subViewList[arg_21_0.curSubViewNum] then
		local var_21_0 = arg_21_0.subViewList[arg_21_0.curSubViewNum]

		if var_1.IsSupplyShop(var_21_0) then
			local var_21_1 = arg_21_0.subViewList[arg_21_0.curSubViewNum]

			var_1.OnFragmentSellUpdate(var_21_1)
		end
	end

	return
end

function var_0_1.SetShop(arg_22_0, arg_22_1, arg_22_2)
	if not arg_22_0.supplyShopList then
		return
	end

	if arg_22_0.supplyShopList[arg_22_1] then
		ipairs = var_1_10004

		for iter_22_0, iter_22_1 in var_1_10004(var_3) do
			if iter_22_1:IsSameKind(arg_22_2) then
				arg_22_0.supplyShopList[arg_22_1][iter_22_0] = arg_22_2

				break
			end
		end
	end

	return
end

function var_0_1.didEnter(arg_23_0)
	local var_23_0 = {}
	local var_23_1 = arg_23_0
	local var_23_2 = arg_23_0.bind
	local var_23_3 = var_0_1.ON_CLICK_SKIN_SHOP

	handler = var_1_10005
	var_23_0[1] = var_23_2(var_23_1, var_23_3, var_1_10005(arg_23_0, arg_23_0.OnClickSkinShop))
	arg_23_0.eventIDList = var_23_0
	setActive = var_23_0

	var_23_0(arg_23_0.chat, false)

	onButton = var_23_0

	local var_23_4 = arg_23_0
	local var_23_5 = arg_23_0.backBtn

	local function var_23_6()
		local var_24_0 = arg_23_0

		var_0.closeView(var_24_0)

		return
	end

	SFX_CANCEL = var_5

	var_23_0(var_23_4, var_23_5, var_23_6, var_5)

	onButton = var_23_0

	local var_23_7 = arg_23_0
	local var_23_8 = arg_23_0.homeBtn

	local function var_23_9()
		local var_25_0 = arg_23_0

		var_0.emit(var_25_0, var_0_1.ON_HOME)

		return
	end

	SFX_CANCEL = var_5

	var_23_0(var_23_7, var_23_8, var_23_9, var_5)

	onButton = var_23_0

	local var_23_10 = arg_23_0
	local var_23_11 = arg_23_0.goldBtn

	local function var_23_12()
		pg = var_2_10000

		local var_26_0 = var_2_10000.playerResUI

		var_0.ClickGold(var_26_0)

		return
	end

	SFX_PANEL = var_5

	var_23_0(var_23_10, var_23_11, var_23_12, var_5)

	onButton = var_23_0

	local var_23_13 = arg_23_0
	local var_23_14 = arg_23_0.oilBtn

	local function var_23_15()
		pg = var_2_10000

		local var_27_0 = var_2_10000.playerResUI

		var_0.ClickOil(var_27_0)

		return
	end

	SFX_PANEL = var_5

	var_23_0(var_23_13, var_23_14, var_23_15, var_5)

	onButton = var_23_0

	local var_23_16 = arg_23_0
	local var_23_17 = arg_23_0.diamondBtn

	local function var_23_18()
		pg = var_2_10000

		local var_28_0 = var_2_10000.playerResUI

		var_0.ClickGem(var_28_0)

		return
	end

	SFX_PANEL = var_5

	var_23_0(var_23_16, var_23_17, var_23_18, var_5)

	onToggle = var_23_0

	local var_23_19 = arg_23_0
	local var_23_20 = arg_23_0.buttonList
	local var_23_21 = var_3.Find(var_23_20, "shop1List/recommendation/shop1Tg")

	local function var_23_22(arg_29_0)
		if arg_29_0 then
			arg_23_0.contextData.shop1 = nil
			arg_23_0.contextData.shop2 = nil

			if arg_23_0.shop1 == "recommendation" then
				return
			end

			arg_23_0.shop1 = "recommendation"
			arg_23_0.shop2 = nil

			local var_29_0 = arg_23_0

			var_1.ShowChargeWarp(var_29_0, false)

			pg = var_1

			local var_29_1 = var_1.m02

			var_1.sendNotification(var_29_1, var_0_1.CLOSE_ALL_LAYER)

			local var_29_2 = arg_23_0
			local var_29_3 = var_1.emit

			NewShopMainMediator = var_3

			local var_29_4 = var_3.OPEN_LAYER

			NewRecommendationShopLayer = var_2_10004
			NewRecommendationShopMediator = var_2_10005

			var_29_3(var_29_2, var_29_4, var_2_10004, var_2_10005)
		end

		return
	end

	SFX_PANEL = var_5

	var_23_0(var_23_19, var_23_21, var_23_22, var_5)
	arg_23_0:InitSkinToggleList()

	for iter_23_0 = 1, #arg_23_0.toggleList do
		local var_23_23 = arg_23_0.toggleList[iter_23_0]

		onToggle = var_6

		local var_23_24 = arg_23_0
		local var_23_25 = var_23_23.go

		local function var_23_26(arg_30_0)
			if arg_30_0 then
				local var_30_0 = arg_23_0

				var_2_10001.ShowChargeWarp(var_30_0, true)

				pg = var_2_10001

				local var_30_1 = var_2_10001.m02

				var_2_10001.sendNotification(var_30_1, var_0_1.CLOSE_ALL_LAYER)

				var_2_10001 = arg_23_0.contextData
				var_2_10001.shop1 = nil
				var_2_10001 = arg_23_0.contextData
				var_2_10001.shop2 = nil
				var_2_10001 = arg_23_0
				var_2_10001.shop1 = nil
				var_2_10001 = arg_23_0
				var_2_10001.shop2 = nil
				originalPrint = var_2_10001
				string = var_2

				var_2_10001(var_2.format("Begin: toggleType=%s, goName=%s", var_23_23.type, var_23_23.go.parent.name))

				var_2_10001 = arg_23_0.contextData
				ShopConst = var_2
				var_2_10001.type = var_2.SHOP_TYPE.CHARGE
				var_2_10001 = arg_23_0.contextData
				var_2_10001.warp = var_23_23.type
				originalPrint = var_2_10001
				string = var_2

				var_2_10001(var_2.format("End: warp=%s", arg_23_0.contextData.warp))

				local var_30_2 = arg_23_0

				var_2_10001 = var_2_10001.GetShopID
				ShopConst = var_3
				var_2_10001 = var_2_10001(var_30_2, var_3.SHOP_TYPE.CHARGE, var_23_23.type)

				local var_30_3 = arg_23_0

				var_2.switchSubView(var_30_3, var_2_10001)
			end

			switch = var_2_10001

			local var_30_4 = var_23_23.type
			local var_30_5 = {}

			ChargeScene = var_2_10004
			var_30_5[var_2_10004.TYPE_PICK] = function()
				return "payshop_pack_red_dot"
			end
			ChargeScene = var_4
			var_30_5[var_4.TYPE_GIFT] = function()
				return "gemshop_pack_red_dot"
			end

			if var_2_10001(var_30_4, var_30_5) then
				if arg_30_0 then
					local var_30_6 = arg_23_0
					local var_30_7

					if not arg_23_0.toggleMark then
						var_30_7 = {}
					end

					var_30_6.toggleMark = var_30_7

					local var_30_8 = arg_23_0.toggleMark
					local var_30_9 = var_23_23.type

					defaultValue = var_4
					var_30_8[var_30_9] = var_4(arg_23_0.toggleMark[var_23_23.type], 0) + 1
				elseif arg_23_0.toggleMark then
					defaultValue = var_2

					if var_2(arg_23_0.toggleMark[var_23_23.type], 0) > 0 then
						local var_30_10 = arg_23_0.toggleMark

						var_30_10[var_23_23.type] = arg_23_0.toggleMark[var_23_23.type] - 1
						PlayerPrefs = var_30_10

						local var_30_11 = var_30_10.SetInt
						local var_30_12 = var_1

						getGameset = var_4

						var_30_11(var_30_12, var_4(var_1)[1])

						pg = var_30_11

						local var_30_13 = var_30_11.EasyRedDotMgr.GetInstance()

						var_2.TriggerMarks(var_30_13, "Charge_Page_Exposure")
					end
				end
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_6(var_23_24, var_23_25, var_23_26, var_1_10010)
	end

	onToggle = var_1

	local var_23_27 = arg_23_0
	local var_23_28 = arg_23_0.buttonList
	local var_23_29 = var_3.Find(var_23_28, "shop1List/supplyShop/shop1Tg")

	local function var_23_30(arg_33_0)
		setActive = var_2_10001

		local var_33_0 = arg_23_0.buttonList

		var_2_10001(var_2.Find(var_33_0, "shop1List/supplyShop/shop2List"), arg_33_0)

		if arg_33_0 then
			triggerToggle = var_2_10001

			local var_33_1 = arg_23_0.buttonList
			local var_33_2 = var_2.Find
			local var_33_3 = "shop1List/supplyShop/shop2List/"
			local var_33_4 = arg_23_0

			var_2_10001(var_33_2(var_33_1, var_33_3 .. var_5.GetDefaultSupplyShopName(var_33_4)), true)
		end

		return
	end

	SFX_PANEL = var_5

	var_1(var_23_27, var_23_29, var_23_30, var_5)

	local var_23_31 = {}
	local var_23_32 = {}

	ShopConst = var_23_29
	var_23_32.type = var_23_29.CATEGORY_MONTH

	local var_23_33 = arg_23_0.buttonList

	var_23_32.go = var_3.Find(var_23_33, "shop1List/supplyShop/shop2List/monthShop")
	var_23_31[1] = var_23_32

	local var_23_34 = {}

	ShopConst = var_3
	var_23_34.type = var_3.CATEGORY_SUPPLY

	local var_23_35 = arg_23_0.buttonList

	var_23_34.go = var_3.Find(var_23_35, "shop1List/supplyShop/shop2List/supplyShop")
	var_23_31[2] = var_23_34

	local var_23_36 = {}

	ShopConst = var_3
	var_23_36.type = var_3.CATEGORY_ACTIVITY

	local var_23_37 = arg_23_0.buttonList

	var_23_36.go = var_3.Find(var_23_37, "shop1List/supplyShop/shop2List/activityShop")
	var_23_31[3] = var_23_36
	ipairs = var_23_36

	for iter_23_1, iter_23_2 in var_23_36(var_23_31) do
		onToggle = var_23_24

		local var_23_38 = arg_23_0
		local var_23_39 = iter_23_2.go

		local function var_23_40(arg_34_0)
			if arg_34_0 then
				local var_34_0 = arg_23_0

				var_1.ShowChargeWarp(var_34_0, true)

				pg = var_1

				local var_34_1 = var_1.m02

				var_1.sendNotification(var_34_1, var_0_1.CLOSE_ALL_LAYER)

				arg_23_0.contextData.shop1 = nil
				arg_23_0.contextData.shop2 = nil
				arg_23_0.shop1 = nil
				arg_23_0.shop2 = nil

				local var_34_2 = arg_23_0.contextData

				ShopConst = var_2
				var_34_2.type = var_2.SHOP_TYPE.SUPPLY
				arg_23_0.contextData.warp = iter_23_2.type

				local var_34_3 = arg_23_0
				local var_34_4 = var_1.GetShopID

				ShopConst = var_3

				local var_34_5 = var_34_4(var_34_3, var_3.SHOP_TYPE.SUPPLY, iter_23_2.type)
				local var_34_6 = arg_23_0

				var_2.switchSubView(var_34_6, var_34_5)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_23_24(var_23_38, var_23_39, var_23_40, var_1_10011)
	end

	local var_23_41 = "recommendation"
	local var_23_42 = arg_23_0.contextData.type

	ShopConst = var_4

	if var_23_42 == var_4.SHOP_TYPE.CHARGE then
		local var_23_43 = arg_23_0.contextData.warp

		ChargeScene = var_4

		if var_23_43 == var_4.TYPE_DIAMOND then
			var_23_41 = "diamondShop"
		else
			local var_23_44 = arg_23_0.contextData.warp

			ChargeScene = var_4

			if var_23_44 == var_4.TYPE_GIFT then
				var_23_41 = "giftPackShop"
			else
				local var_23_45 = arg_23_0.contextData.warp

				ChargeScene = var_4

				if var_23_45 == var_4.TYPE_ITEM then
					var_23_41 = "functionalItemShop"
				else
					local var_23_46 = arg_23_0.contextData.warp

					ChargeScene = var_4

					if var_23_46 == var_4.TYPE_PICK then
						var_23_41 = "specialShop"
					else
						var_23_41 = "diamondShop"
					end
				end
			end
		end
	else
		local var_23_47 = arg_23_0.contextData.type

		ShopConst = var_4

		if var_23_47 == var_4.SHOP_TYPE.SKIN then
			var_23_41 = "skinShop"
		else
			local var_23_48 = arg_23_0.contextData.type

			ShopConst = var_4

			if var_23_48 == var_4.SHOP_TYPE.SUPPLY then
				var_23_41 = "supplyShop"
			end
		end
	end

	if arg_23_0.contextData.shop1 then
		var_23_41 = arg_23_0.contextData.shop1
	end

	triggerToggle = var_3

	local var_23_49 = arg_23_0.buttonList

	var_3(var_4.Find(var_23_49, "shop1List/" .. var_23_41 .. "/shop1Tg"), true)

	if var_23_41 == "skinShop" then
		-- block empty
	elseif var_23_41 == "supplyShop" then
		triggerToggle = var_3

		local var_23_50 = arg_23_0.buttonList

		var_3(var_4.Find(var_23_50, "shop1List/supplyShop/shop2List/" .. arg_23_0:GetDefaultSupplyShopName()), true)
	end

	onButton = var_3

	local var_23_51 = arg_23_0
	local var_23_52 = arg_23_0.painting

	local function var_23_53()
		local var_35_0 = arg_23_0

		var_0.displayShipWord(var_35_0)

		local var_35_1 = arg_23_0
		local var_35_2 = var_0.emit

		NewShopMainMediator = var_2_10002

		var_35_2(var_35_1, var_2_10002.CLICK_MING_SHI)

		return
	end

	SFX_PANEL = var_7

	var_3(var_23_51, var_23_52, var_23_53, var_7)

	onButton = var_3

	local var_23_54 = arg_23_0
	local var_23_55 = arg_23_0.stamp

	local function var_23_56()
		getProxy = var_2_10000
		TaskProxy = var_2_10001

		local var_36_0 = var_2_10000(var_2_10001)

		var_0.dealMingshiTouchFlag(var_36_0, 4)

		return
	end

	SFX_CONFIRM = var_7

	var_3(var_23_54, var_23_55, var_23_56, var_7)
	arg_23_0:RefreshActivityShop()
	arg_23_0:updateNoRes()
	arg_23_0:jpUIEnter()

	return
end

function var_0_1.GetDefaultSupplyShopName(arg_37_0)
	local var_37_0 = arg_37_0.contextData.type

	ShopConst = var_1_10002

	if var_37_0 ~= var_1_10002.SHOP_TYPE.SUPPLY then
		return "supplyShop"
	end

	local var_37_1 = arg_37_0.contextData.warp

	type = var_2

	local var_37_2

	if var_2(var_37_1) == "string" then
		ShopConst = var_37_2
		var_37_2 = var_37_2.SHOP_NAME_LIST[var_37_1]
		arg_37_0.contextData.warp = var_37_2[1]
		arg_37_0.contextData.shopID = var_37_2[2]
	else
		type = var_37_2

		if var_37_2(var_37_1) == "number" and arg_37_0.contextData.shopID == nil then
			pairs = var_2
			ShopConst = var_3

			for iter_37_0, iter_37_1 in var_2(var_3.SUPPLY_SHOP_LIST) do
				pairs = var_1_10007

				for iter_37_2, iter_37_3 in var_1_10007(iter_37_1) do
					if iter_37_3 == var_37_1 then
						arg_37_0.contextData.warp = iter_37_0
						arg_37_0.contextData.shopID = iter_37_3

						break
					end
				end
			end
		end
	end

	local var_37_3 = ""
	local var_37_4 = arg_37_0.contextData.warp

	ShopConst = var_1_10004

	if var_37_4 == var_1_10004.CATEGORY_MONTH then
		var_37_3 = "monthShop"
	else
		local var_37_5 = arg_37_0.contextData.warp

		ShopConst = var_4

		if var_37_5 == var_4.CATEGORY_SUPPLY then
			var_37_3 = "supplyShop"
		else
			local var_37_6 = arg_37_0.contextData.warp

			ShopConst = var_4
			var_37_3 = var_37_6 == var_4.CATEGORY_ACTIVITY and "activityShop" or "supplyShop"
		end
	end

	return var_37_3
end

function var_0_1.RefreshActivityShop(arg_38_0)
	local var_38_0 = arg_38_0.supplyShopList

	ShopConst = var_1_10002

	local var_38_1

	if not var_38_0[var_1_10002.TYPE_ACTIVITY] then
		var_38_1 = {}
	end

	setActive = var_2

	local var_38_2 = arg_38_0.buttonList

	var_2(var_3.Find(var_38_2, "shop1List/supplyShop/shop2List/activityShop"), #var_38_1 > 0)

	return
end

function var_0_1.ShowOrHideUI(arg_39_0, arg_39_1)
	arg_39_0:setVisible(arg_39_1)

	setActive = var_2

	var_2(arg_39_0.buttonList, arg_39_1)

	return
end

function var_0_1.ShowOrHideUI2(arg_40_0, arg_40_1)
	for iter_40_0 = 0, arg_40_0._tf.childCount - 1 do
		setActive = var_1_10006

		local var_40_0 = arg_40_0._tf

		var_1_10006(var_7.GetChild(var_40_0, iter_40_0), arg_40_1)
	end

	setActive = var_2

	local var_40_1 = arg_40_0.buttonList

	var_2(var_3.Find(var_40_1, "leftBg"), arg_40_1)

	setActive = var_2

	local var_40_2 = arg_40_0.buttonList

	var_2(var_3.Find(var_40_2, "shop1List"), arg_40_1)

	setActive = var_2

	local var_40_3 = arg_40_0.buttonList

	var_2(var_3.Find(var_40_3, "top"), true)

	return
end

function var_0_1.OnChargeSuccess(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.chargeTipWindow

	var_2.ExecuteAction(var_41_0, "Show", arg_41_1)

	return
end

function var_0_1.LoadMingshi(arg_42_0)
	Live2dConst = var_1_10001

	if var_1_10001.GetLive2DArm32MatchAble() then
		Ship = var_1

		local var_42_0 = var_1.New({
			configId = 312011
		})
		local var_42_1 = var_1.getPainting(var_42_0)

		LoadPaintingPrefabAsync = var_42_0

		var_42_0(arg_42_0.painting, var_42_1, var_42_1, "mainNormal", function()
			arg_42_0.loading = false

			return
		end)
	else
		arg_42_0:createLive2D()
	end

	arg_42_0:AddLive2dTimer()

	return
end

function var_0_1.AddLive2dTimer(arg_44_0)
	arg_44_0:StopLive2dTimer()

	Timer = var_1
	arg_44_0.live2dTimer = var_1.New(function()
		pg = var_2_10000

		local var_45_0 = var_2_10000.ChargeShipTalkInfo.Actions

		math = var_2_10001

		local var_45_1 = var_45_0[var_2_10001.random(#var_45_0)]
		local var_45_2 = arg_44_0

		if var_2.checkBuyDone(var_45_2, var_45_1.action) then
			local var_45_3 = arg_44_0

			var_2.displayShipWord(var_45_3, nil, false, var_45_1.dialog_index)
		end

		return
	end, 20, -1)

	local var_44_0 = arg_44_0.live2dTimer

	var_1.Start(var_44_0)

	return
end

function var_0_1.StopLive2dTimer(arg_46_0)
	if arg_46_0.live2dTimer then
		local var_46_0 = arg_46_0.live2dTimer

		var_1.Stop(var_46_0)

		arg_46_0.live2dTimer = nil
	end

	return
end

function var_0_1.ShowChargeWarp(arg_47_0, arg_47_1)
	setActive = var_1_10002

	var_1_10002(arg_47_0.frame, arg_47_1)

	setActive = var_1_10002

	var_1_10002(arg_47_0.viewContainer, arg_47_1)
	arg_47_0:ShowResourceBar(arg_47_1)

	if arg_47_0.subViewList[arg_47_0.curSubViewNum] then
		if arg_47_1 == false then
			var_2:Destroy()

			arg_47_0.curSubViewNum = 0
		else
			var_2:ShowPanel(arg_47_1)
		end
	end

	return
end

function var_0_1.ShowResourceBar(arg_48_0, arg_48_1)
	if arg_48_0.resourceBarFlag == arg_48_1 then
		return
	end

	arg_48_0.resourceBarFlag = arg_48_1
	setActive = var_2

	var_2(arg_48_0.resourcePanel, arg_48_1)

	return
end

function var_0_1.willExit(arg_49_0)
	ipairs = var_1_10001

	for iter_49_0, iter_49_1 in var_1_10001(arg_49_0.eventIDList) do
		arg_49_0:disconnect(iter_49_1)
	end

	arg_49_0.eventIDList = nil

	if arg_49_0.bulinTip then
		local var_49_0 = arg_49_0.bulinTip

		var_1.Destroy(var_49_0)

		arg_49_0.bulinTip = nil
	end

	pg = var_1

	local var_49_1 = var_1.EasyRedDotMgr.GetInstance()

	var_1.UnRegisterRedDot(var_49_1, arg_49_0.specialTip)

	pg = var_1

	local var_49_2 = var_1.EasyRedDotMgr.GetInstance()

	var_1.UnRegisterRedDot(var_49_2, arg_49_0.giftTip)

	if arg_49_0.toggleMark then
		pairs = var_1

		for iter_49_2, iter_49_3 in var_1(arg_49_0.toggleMark) do
			if 0 < iter_49_3 then
				switch = var_6

				local var_49_3 = iter_49_2
				local var_49_4 = {}

				ChargeScene = var_1_10009
				var_49_4[var_1_10009.TYPE_PICK] = function()
					return "payshop_pack_red_dot"
				end
				ChargeScene = var_1_10009
				var_49_4[var_1_10009.TYPE_GIFT] = function()
					return "gemshop_pack_red_dot"
				end

				local var_49_5 = var_6(var_49_3, var_49_4)

				PlayerPrefs = var_49_3

				local var_49_6 = var_49_3.SetInt
				local var_49_7 = var_49_5

				getGameset = var_1_10009

				var_49_6(var_49_7, var_1_10009(var_49_5)[1])
			end
		end

		arg_49_0.toggleMark = nil
	end

	arg_49_0:ShowResourceBar()
	arg_49_0:unBlurView()

	if arg_49_0.chargeTipWindow then
		local var_49_8 = arg_49_0.chargeTipWindow

		var_1.Destroy(var_49_8)

		arg_49_0.chargeTipWindow = nil
	end

	local var_49_9 = arg_49_0.contextData.singleWindow

	var_1.Destroy(var_49_9)

	local var_49_10 = arg_49_0.contextData.multiWindow

	var_1.Destroy(var_49_10)

	local var_49_11 = arg_49_0.contextData.singleWindowForESkin

	var_1.Destroy(var_49_11)

	local var_49_12 = arg_49_0.contextData.paintingView

	var_1.Dispose(var_49_12)

	arg_49_0.contextData.singleWindow = nil
	arg_49_0.contextData.multiWindow = nil
	arg_49_0.contextData.singleWindowForESkin = nil
	arg_49_0.contextData.paintingView = nil
	arg_49_0.bulinTip = nil
	pairs = var_1

	for iter_49_4, iter_49_5 in var_1(arg_49_0.subViewList) do
		iter_49_5:Destroy()
	end

	arg_49_0.subViewList = nil

	if arg_49_0.heartsTimer then
		local var_49_13 = arg_49_0.heartsTimer

		var_1.Stop(var_49_13)

		arg_49_0.heartsTimer = nil
	end

	if arg_49_0.live2dChar then
		local var_49_14 = arg_49_0.live2dChar

		var_1.Dispose(var_49_14)
	end

	arg_49_0:StopLive2dTimer()
	arg_49_0:stopCV()
	arg_49_0:DisposeSkinToggleList()

	if arg_49_0.giftShopView then
		local var_49_15 = arg_49_0.giftShopView

		var_1.OnDestroy(var_49_15)
	end

	return
end

function var_0_1.onBackPressed(arg_52_0)
	local var_52_0 = arg_52_0.contextData.singleWindow

	if var_1.GetLoaded(var_52_0) then
		local var_52_1 = arg_52_0.contextData.singleWindow

		if var_1.isShowing(var_52_1) then
			local var_52_2 = arg_52_0.contextData.singleWindow

			var_1.Close(var_52_2)

			return
		end
	end

	local var_52_3 = arg_52_0.contextData.multiWindow

	if var_1.GetLoaded(var_52_3) then
		local var_52_4 = arg_52_0.contextData.multiWindow

		if var_1.isShowing(var_52_4) then
			local var_52_5 = arg_52_0.contextData.multiWindow

			var_1.Close(var_52_5)

			return
		end
	end

	local var_52_6 = arg_52_0.contextData.singleWindowForESkin

	if var_1.GetLoaded(var_52_6) then
		local var_52_7 = arg_52_0.contextData.singleWindowForESkin

		if var_1.isShowing(var_52_7) then
			local var_52_8 = arg_52_0.contextData.singleWindowForESkin

			var_1.Hide(var_52_8)

			return
		end
	end

	var_0_1.super.onBackPressed(arg_52_0)

	return
end

function var_0_1.initSubView(arg_53_0)
	ChargeDiamondShopView = var_1_10001

	local var_53_0 = var_1_10001.New(arg_53_0.viewContainer, arg_53_0.event, arg_53_0.contextData)

	ChargeGiftShopView = var_2

	local var_53_1 = var_2.New(arg_53_0.viewContainer, arg_53_0.event, arg_53_0.contextData)

	ChargeItemShopView = var_3

	local var_53_2 = var_3.New(arg_53_0.viewContainer, arg_53_0.event, arg_53_0.contextData)

	ChargePickShopView = var_4

	local var_53_3 = var_4.New(arg_53_0.viewContainer, arg_53_0.event, arg_53_0.contextData)

	SupplyShopView = var_5

	local var_53_4 = var_5.New
	local var_53_5 = arg_53_0.viewContainer
	local var_53_6 = arg_53_0.event
	local var_53_7 = arg_53_0.contextData

	ShopConst = var_1_10009

	local var_53_8 = var_53_4(var_53_5, var_53_6, var_53_7, var_1_10009.CATEGORY_MONTH)

	SupplyShopView = var_53_5

	local var_53_9 = var_53_5.New
	local var_53_10 = arg_53_0.viewContainer
	local var_53_11 = arg_53_0.event
	local var_53_12 = arg_53_0.contextData

	ShopConst = var_1_10010

	local var_53_13 = var_53_9(var_53_10, var_53_11, var_53_12, var_1_10010.CATEGORY_SUPPLY)

	SupplyShopView = var_53_10

	local var_53_14 = var_53_10.New
	local var_53_15 = arg_53_0.viewContainer
	local var_53_16 = arg_53_0.event
	local var_53_17 = arg_53_0.contextData

	ShopConst = var_1_10011

	local var_53_18 = var_53_14(var_53_15, var_53_16, var_53_17, var_1_10011.CATEGORY_ACTIVITY)

	arg_53_0.curSubViewNum = 0

	local var_53_19 = {}

	ShopConst = var_53_16
	var_53_19[var_53_16.SHOP_ID.DIAMOND] = var_53_0
	ShopConst = var_9
	var_53_19[var_9.SHOP_ID.GIFT] = var_53_1
	ShopConst = var_9
	var_53_19[var_9.SHOP_ID.ITEM] = var_53_2
	ShopConst = var_9
	var_53_19[var_9.SHOP_ID.PICK] = var_53_3
	ShopConst = var_9
	var_53_19[var_9.SHOP_ID.MONTH] = var_53_8
	ShopConst = var_9
	var_53_19[var_9.SHOP_ID.SUPPLY] = var_53_13
	ShopConst = var_9
	var_53_19[var_9.SHOP_ID.ACTIVITY] = var_53_18
	arg_53_0.subViewList = var_53_19
	pairs = var_53_19

	for iter_53_0, iter_53_1 in var_53_19(arg_53_0.subViewList) do
		iter_53_1:RegisterView(arg_53_0)
	end

	local var_53_20 = arg_53_0.contextData

	ShopSingleWindow = var_9
	var_53_20.singleWindow = var_9.New(arg_53_0._tf, arg_53_0.event)

	local var_53_21 = arg_53_0.contextData

	ShopMultiWindow = var_9
	var_53_21.multiWindow = var_9.New(arg_53_0._tf, arg_53_0.event)

	local var_53_22 = arg_53_0.contextData

	EquipmentSkinInfoUIForShopWindow = var_9
	var_53_22.singleWindowForESkin = var_9.New(arg_53_0._tf, arg_53_0.event)

	local var_53_23 = arg_53_0.contextData

	ShopPaintingView = var_9

	local var_53_24 = var_9.New
	local var_53_25 = arg_53_0._tf
	local var_53_26 = var_10.Find(var_53_25, "frame/supplyPaint")
	local var_53_27 = arg_53_0._tf

	var_53_23.paintingView = var_53_24(var_53_26, var_11.Find(var_53_27, "frame/chat"))

	local var_53_28 = arg_53_0.contextData.paintingView
	local var_53_29 = var_8.setSecretaryPos
	local var_53_30 = arg_53_0._tf

	var_53_29(var_53_28, var_10.Find(var_53_30, "frame/secretaryPos"))

	return
end

function var_0_1.GetShopID(arg_54_0, arg_54_1, arg_54_2)
	ShopConst = var_1_10003

	return var_1_10003.SHOP_LIST[arg_54_1][arg_54_2]
end

function var_0_1.switchSubView(arg_55_0, arg_55_1)
	originalPrint = var_1_10002
	string = var_1_10003

	var_1_10002(var_1_10003.format("End: shopID=%s curShopID=%s", arg_55_1, arg_55_0.curSubViewNum))

	if arg_55_1 == arg_55_0.curSubViewNum then
		return
	end

	local var_55_0 = arg_55_0.subViewList[arg_55_1]

	var_2.setGoodData(var_55_0, arg_55_0.firstChargeIds, arg_55_0.chargedList, arg_55_0.normalList, arg_55_0.normalGroupList)

	local var_55_1 = arg_55_0.subViewList[arg_55_1]

	var_2.Reset(var_55_1)

	local var_55_2 = arg_55_0.subViewList[arg_55_1]

	var_2.Load(var_55_2)

	if arg_55_0.subViewList[arg_55_1].SetAllShopData then
		local var_55_3 = arg_55_0.subViewList[arg_55_1]

		var_2.ActionInvoke(var_55_3, "SetAllShopData", arg_55_0.supplyShopList)
	end

	if arg_55_0.subViewList[arg_55_0.curSubViewNum] then
		var_2:Destroy()
	end

	arg_55_0.curSubViewNum = arg_55_1

	local var_55_4 = arg_55_0
	local var_55_5 = arg_55_0.SwitchPainting
	local var_55_6 = arg_55_0.subViewList[arg_55_1]

	var_55_5(var_55_4, var_5.IsSupplyShop(var_55_6))

	PLATFORM_CODE = var_55_5
	PLATFORM_JP = var_55_4

	if var_55_5 == var_55_4 then
		setActive = var_55_5

		local var_55_7 = arg_55_0.userAgreeBtn3

		ChargeScene = var_5

		var_55_5(var_55_7, arg_55_1 == var_5.TYPE_DIAMOND)

		setActive = var_55_5

		local var_55_8 = arg_55_0.userAgreeBtn4

		ChargeScene = var_5

		var_55_5(var_55_8, arg_55_1 == var_5.TYPE_DIAMOND)
	end

	return
end

function var_0_1.SwitchPainting(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_0.contextData.paintingView

	var_2.Show(var_56_0, arg_56_1)

	setActive = var_2

	var_2(arg_56_0.painting, not arg_56_1)

	if arg_56_1 then
		arg_56_0:StopLive2dTimer()

		arg_56_0.chatFlag = nil

		arg_56_0:stopCV()

		setActive = var_2

		local var_56_1 = arg_56_0.stamp

		getProxy = var_4
		TaskProxy = var_1_10005

		local var_56_2 = var_4(var_1_10005)

		var_2(var_56_1, var_4.mingshiTouchFlagEnabled(var_56_2))

		LOCK_CLICK_MINGSHI = var_2

		if var_2 then
			setActive = var_2

			var_2(arg_56_0.stamp, false)
		end
	else
		setActive = var_2

		var_2(arg_56_0.stamp, false)
		arg_56_0:AddLive2dTimer()
	end

	return
end

function var_0_1.switchSubViewByTogger(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0.toggleList[arg_57_1]

	triggerToggle = var_1_10003

	var_1_10003(var_57_0.go, true)

	return
end

function var_0_1.updateCurSubView(arg_58_0)
	isActive = var_1_10001

	if not var_1_10001(arg_58_0.viewContainer) then
		return
	end

	if arg_58_0.subViewList[arg_58_0.curSubViewNum] == nil then
		return
	end

	var_1:setGoodData(arg_58_0.firstChargeIds, arg_58_0.chargedList, arg_58_0.normalList, arg_58_0.normalGroupList)
	var_1:reUpdateAll()

	return
end

function var_0_1.updateNoRes(arg_59_0, arg_59_1)
	if not arg_59_1 then
		arg_59_1 = arg_59_0.contextData.noRes
	else
		arg_59_0.contextData.noRes = arg_59_1
	end

	if not arg_59_1 or #arg_59_1 <= 0 then
		return
	end

	local var_59_0 = arg_59_0.contextData

	var_59_0.noRes = {}
	getProxy = var_59_0
	BagProxy = var_3

	local var_59_1 = var_59_0(var_3)
	local var_59_2 = var_2.getData(var_59_1)
	local var_59_3 = ""

	ipairs = var_1_10005

	for iter_59_0, iter_59_1 in var_1_10005(arg_59_1) do
		if iter_59_1[2] > 0 then
			if iter_59_1[1] == 59001 then
				var_1_10010 = arg_59_1[iter_59_0]
				var_1_10010[2] = iter_59_1[3] - arg_59_0.player.gold
			else
				var_1_10010 = arg_59_1[iter_59_0]

				local var_59_4 = iter_59_1[3]

				if not var_59_2[iter_59_1[1]] or not var_59_2[iter_59_1[1]].count then
					var_1_10012 = 0
				end

				var_1_10010[2] = var_59_4 - var_1_10012
			end
		end

		if arg_59_1[iter_59_0][2] > 0 then
			table = var_1_10010

			var_1_10010.insert(arg_59_0.contextData.noRes, arg_59_1[iter_59_0])
		end
	end

	ipairs = var_5

	for iter_59_2, iter_59_3 in var_5(arg_59_0.contextData.noRes) do
		Item = var_1_10010
		var_1_10010 = var_1_10010.getConfigData(iter_59_3[1]).name

		local var_59_5 = var_59_3

		i18n = var_1_10012
		var_59_3 = var_59_5 .. var_1_10012(iter_59_3[1] == 59001 and "text_noRes_info_tip" or "text_noRes_info_tip2", var_1_10010, iter_59_3[2])

		if iter_59_2 < #arg_59_0.contextData.noRes then
			local var_59_6 = var_59_3

			i18n = var_1_10012
			var_59_3 = var_59_6 .. var_1_10012("text_noRes_info_tip_link")
		end
	end

	if var_59_3 == "" then
		local var_59_7 = arg_59_0
		local var_59_8 = arg_59_0.displayShipWord

		i18n = var_7

		var_59_8(var_59_7, var_7("text_shop_enoughRes_tip"), false)
	else
		local var_59_9 = arg_59_0
		local var_59_10 = arg_59_0.displayShipWord

		i18n = var_7

		var_59_10(var_59_9, var_7("text_shop_noRes_tip", var_59_3), true)
	end

	return
end

function var_0_1.displayShipWord(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	if not arg_60_0.chatFlag then
		if not arg_60_1 and arg_60_0.contextData.noRes and #arg_60_0.contextData.noRes > 0 then
			setActive = var_4

			var_4(arg_60_0.chat, false)

			local var_60_0 = arg_60_0.chat.transform

			Vector3 = var_5
			var_60_0.localScale = var_5(0, 0, 1)
		end

		arg_60_0.chatFlag = true

		if not arg_60_0.isInitChatPosition then
			arg_60_0.isInitChatPosition = true

			arg_60_0:InitChatPosition()
		end

		setActive = var_4

		var_4(arg_60_0.chat, true)

		local var_60_1 = arg_60_0.player
		local var_60_2 = var_4.getChargeLevel(var_60_1)

		if not arg_60_3 then
			::label_60_0::

			math = var_60_1
			var_60_1 = var_60_1.random(1, var_60_2)
		end

		local var_60_3

		if arg_60_3 then
			pg = var_1_10007
			var_60_3 = var_1_10007.pay_level_award[var_60_1].dialog
		elseif not arg_60_1 then
			::label_60_1::

			pg = var_1_10007
			var_60_3 = var_1_10007.pay_level_award[var_60_1].dialog
		end

		if not arg_60_1 then
			arg_60_0:playCV(var_60_1)
		end

		setText = var_1_10007

		var_1_10007(arg_60_0.chatText, var_60_3)

		local var_60_4 = arg_60_0.chatText
		local var_60_5 = var_7.GetComponent

		typeof = var_9
		Text = var_1_10010

		local var_60_6 = var_60_5(var_60_4, var_9(var_1_10010))

		;(function()
			local var_61_0 = 3
			local var_61_1 = 0.3

			LeanTween = var_2_10002

			local var_61_2 = var_2_10002.scale

			rtf = var_2_10003

			local var_61_3 = var_2_10003(arg_60_0.chat.gameObject)

			Vector3 = var_4

			local var_61_4 = var_61_2(var_61_3, var_4.New(1, 1, 1), var_61_1)
			local var_61_5 = var_2.setFrom

			Vector3 = var_4

			local var_61_6 = var_61_5(var_61_4, var_4.New(0, 0, 0))
			local var_61_7 = var_2.setEase

			LeanTweenType = var_4

			local var_61_8 = var_61_7(var_61_6, var_4.easeOutBack)
			local var_61_9 = var_2.setOnComplete

			System = var_4

			var_61_9(var_61_8, var_4.Action(function()
				if not arg_60_2 then
					LeanTween = var_0

					local var_62_0 = var_0.scale

					rtf = var_3_10001

					local var_62_1 = var_3_10001(arg_60_0.chat.gameObject)

					Vector3 = var_2

					local var_62_2 = var_62_0(var_62_1, var_2.New(0, 0, 1), var_61_1)
					local var_62_3 = var_0.setEase

					LeanTweenType = var_2

					local var_62_4 = var_62_3(var_62_2, var_2.easeInBack)
					local var_62_5 = var_0.setDelay(var_62_4, var_61_1 + var_61_0)
					local var_62_6 = var_0.setOnComplete

					System = var_2

					var_62_6(var_62_5, var_2.Action(function()
						local var_63_0 = arg_60_0

						var_63_0.chatFlag = nil
						setActive = var_63_0

						var_63_0(arg_60_0.chat, false)

						if arg_60_0.contextData.noRes and #arg_60_0.contextData.noRes > 0 then
							local var_63_1 = arg_60_0

							var_0.updateNoRes(var_63_1)
						end

						return
					end))
				else
					arg_60_0.chatFlag = nil
				end

				return
			end))

			return
		end)()
	end

	return
end

function var_0_1.InitChatPosition(arg_64_0)
	return
end

function var_0_1.playHeartEffect(arg_65_0)
	if arg_65_0.heartsTimer then
		local var_65_0 = arg_65_0.heartsTimer

		var_1.Stop(var_65_0)
	end

	local var_65_1 = arg_65_0.painting
	local var_65_2 = var_1.Find(var_65_1, "heartsfly")

	setActive = var_65_1

	var_65_1(var_65_2, true)

	Timer = var_65_1
	arg_65_0.heartsTimer = var_65_1.New(function()
		setActive = var_2_10000

		var_2_10000(var_65_2, false)

		return
	end, 1, 1)

	local var_65_3 = arg_65_0.heartsTimer

	var_2.Start(var_65_3)

	return
end

function var_0_1.createLive2D(arg_67_0)
	Live2DPainting = var_1_10001

	local var_67_0 = var_1_10001.GenerateData
	local var_67_1 = {}

	Ship = var_1_10003
	var_67_1.ship = var_1_10003.New({
		configId = 312011
	})
	var_67_1.offset = {
		0,
		0,
		0,
		75
	}
	Vector3 = var_3
	var_67_1.position = var_3(0, 0, 0)

	local var_67_2 = arg_67_0._tf

	var_67_1.parent = var_3.Find(var_67_2, "frame/painting/live2d")

	local var_67_3 = var_67_0(var_67_1)

	Live2DPainting = var_67_1
	arg_67_0.live2dChar = var_67_1.New(var_67_3, function(arg_68_0)
		local var_68_0 = arg_68_0
		local var_68_1 = arg_68_0.setSortingLayer

		LayerWeightConst = var_2_10003

		var_68_1(var_68_0, var_2_10003.L2D_DEFAULT_LAYER)

		return
	end)

	return
end

function var_0_1.checkBuyDone(arg_69_0, arg_69_1)
	if arg_69_0.live2dChar then
		var_1_10003 = arg_69_0.live2dChar

		if not var_2.IsLoaded(var_1_10003) then
			return
		end

		local var_69_0

		type = var_1_10003

		if var_1_10003(arg_69_1) == "string" then
			if arg_69_1 == "damonds" then
				var_69_0 = "diamond"
			else
				var_69_0 = arg_69_1
			end
		else
			pg = var_3

			if var_3.shop_template[arg_69_1] and var_3.effect_args then
				type = var_4

				if var_4(var_3.effect_args) == "table" then
					ipairs = var_4

					for iter_69_0, iter_69_1 in var_4(var_3.effect_args) do
						if iter_69_1 == 1 then
							var_69_0 = "gold"
						end
					end
				end
			end
		end

		local var_69_1 = arg_69_0.preAniName == "gold" or arg_69_0.preAniName == "diamond"
		local var_69_2 = var_69_0 == "gold" or var_69_0 == "diamond"
		local var_69_3 = var_69_1 and var_69_2 or not var_69_1

		var_69_3 = var_69_0 and arg_69_0.preAniName ~= var_69_0 and var_69_3

		if var_69_3 then
			arg_69_0.preAniName = var_69_0

			local var_69_4 = arg_69_0.live2dChar

			var_6.TriggerAction(var_69_4, var_69_0, nil, true)
		end

		return var_69_3
	end
end

function var_0_1.playCV(arg_70_0, arg_70_1)
	pg = var_1_10002

	local var_70_0 = var_1_10002.pay_level_award[arg_70_1]
	local var_70_1

	if var_70_0 and var_70_0.cv_key ~= "" then
		var_70_1 = "event:/cv/chargeShop/" .. var_70_0.cv_key
	end

	if var_70_1 then
		arg_70_0:stopCV()

		arg_70_0._currentVoice = var_70_1
		pg = var_4

		local var_70_2 = var_4.CriMgr.GetInstance()

		var_4.PlaySoundEffect_V3(var_70_2, var_70_1)
	end

	return
end

function var_0_1.stopCV(arg_71_0)
	if arg_71_0._currentVoice then
		pg = var_1

		local var_71_0 = var_1.CriMgr.GetInstance()

		var_1.UnloadSoundEffect_V3(var_71_0, arg_71_0._currentVoice)
	end

	arg_71_0._currentVoice = nil

	return
end

function var_0_1.blurView(arg_72_0)
	local var_72_0 = arg_72_0
	local var_72_1 = arg_72_0.OverlayPanel
	local var_72_2 = arg_72_0.buttonList
	local var_72_3 = {}
	local var_72_4 = {}
	local var_72_5 = arg_72_0.buttonList

	var_72_4[1] = var_6.Find(var_72_5, "leftBg")
	var_72_3.pbList = var_72_4

	var_72_1(var_72_0, var_72_2, var_72_3)

	return
end

function var_0_1.unBlurView(arg_73_0)
	arg_73_0:UnOverlayPanel(arg_73_0.buttonList, arg_73_0._tf)

	return
end

function var_0_1.jpUIInit(arg_74_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_JP = var_1_10002

	if var_1_10001 ~= var_1_10002 then
		return
	end

	local var_74_0 = arg_74_0._tf

	arg_74_0.userAgreeBtn3 = var_1.Find(var_74_0, "frame/raw1Btn")

	local var_74_1 = arg_74_0._tf

	arg_74_0.userAgreeBtn4 = var_1.Find(var_74_1, "frame/raw2Btn")

	return
end

function var_0_1.jpUIEnter(arg_75_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_JP = var_1_10002

	if var_1_10001 ~= var_1_10002 then
		return
	end

	onButton = var_1_10001

	local var_75_0 = arg_75_0
	local var_75_1 = arg_75_0.userAgreeBtn3

	local function var_75_2()
		require = var_2_10000

		local var_76_0 = var_2_10000("ShareCfg.UserAgreement3")
		local var_76_1 = arg_75_0
		local var_76_2 = var_1.emit

		NewShopMainMediator = var_2_10003

		var_76_2(var_76_1, var_2_10003.OPEN_USER_AGREE, var_76_0 or "")

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_75_0, var_75_1, var_75_2, var_1_10005)

	onButton = var_1_10001

	local var_75_3 = arg_75_0
	local var_75_4 = arg_75_0.userAgreeBtn4

	local function var_75_5()
		require = var_2_10000

		local var_77_0 = var_2_10000("ShareCfg.UserAgreement4")
		local var_77_1 = arg_75_0
		local var_77_2 = var_1.emit

		NewShopMainMediator = var_2_10003

		var_77_2(var_77_1, var_2_10003.OPEN_USER_AGREE, var_77_0 or "")

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_75_3, var_75_4, var_75_5, var_1_10005)

	return
end

function var_0_1.addRefreshTimer(arg_78_0, arg_78_1)
	(function()
		if arg_78_0.refreshTimer then
			local var_79_0 = arg_78_0.refreshTimer

			var_0.Stop(var_79_0)

			arg_78_0.refreshTimer = nil
		end

		return
	end)()

	Timer = var_3
	arg_78_0.refreshTimer = var_3.New(function()
		local var_80_0 = arg_78_1 + 1

		pg = var_2_10001

		local var_80_1 = var_2_10001.TimeMgr.GetInstance()

		if var_80_0 - var_1.GetServerTime(var_80_1) <= 0 then
			var_0()

			local var_80_2 = arg_78_0
			local var_80_3 = var_1.emit

			NewShopMainMediator = var_2_10003

			var_80_3(var_80_2, var_2_10003.GET_CHARGE_LIST)
		end

		return
	end, 1, -1)

	local var_78_0 = arg_78_0.refreshTimer

	var_3.Start(var_78_0)
	arg_78_0.refreshTimer.func()

	return
end

function var_0_1.InitSkinToggleList(arg_81_0)
	local var_81_0 = arg_81_0.buttonList

	arg_81_0.uiSkinToggleParent = var_1.Find(var_81_0, "shop1List/skinShop/shop2List")

	local var_81_1 = arg_81_0.buttonList

	arg_81_0.uiSkinToggleItem = var_1.Find(var_81_1, "shop1List/skinShop/shop2List/skinToggleItem")
	getProxy = var_1
	ShipSkinProxy = var_81_1

	local var_81_2 = var_1(var_81_1)
	local var_81_3 = var_1.GetInTimeSkins(var_81_2)

	setActive = var_81_2

	local var_81_4 = arg_81_0.buttonList

	var_81_2(var_3.Find(var_81_4, "shop1List/skinShop/shop1Tg/timeLimit"), #var_81_3 > 0)

	arg_81_0.skinShopList = arg_81_0:GetSkinShopList()
	arg_81_0.skinShopItemList = {}
	onToggle = var_2

	local var_81_5 = arg_81_0
	local var_81_6 = arg_81_0.buttonList
	local var_81_7 = var_4.Find(var_81_6, "shop1List/skinShop/shop1Tg")

	local function var_81_8(arg_82_0)
		setActive = var_2_10001

		local var_82_0 = arg_81_0.buttonList

		var_2_10001(var_2.Find(var_82_0, "shop1List/skinShop/shop2List"), arg_82_0)

		if arg_82_0 then
			if arg_81_0.shop1 == "skinShop" then
				return
			end

			arg_81_0.shop1 = "skinShop"

			local var_82_1 = arg_81_0.skinShopItemList

			table = var_2

			local var_82_2 = var_2.keyof
			local var_82_3 = arg_81_0.skinShopList
			local var_82_4 = arg_81_0
			local var_82_5 = var_82_1[var_82_2(var_82_3, var_4.GetDefaultSkinShop(var_82_4))]

			if arg_81_0.contextData.shop1 and arg_81_0.contextData.shop2 then
				local var_82_6 = arg_81_0.skinShopItemList

				table = var_82_3
				var_82_5 = var_82_6[var_82_3.keyof(arg_81_0.skinShopList, arg_81_0.contextData.shop2)] or var_82_5
			end

			arg_81_0.contextData.shop1 = "skinShop"

			var_82_5:TriggerToggle()
		end

		return
	end

	SFX_PANEL = var_6

	var_2(var_81_5, var_81_7, var_81_8, var_6)

	ipairs = var_2

	for iter_81_0, iter_81_1 in var_2(arg_81_0.skinShopList) do
		local var_81_9 = arg_81_0.skinShopItemList
		local var_81_10

		if not arg_81_0.skinShopItemList[iter_81_0] then
			NewShopMainSkinToggleItem = var_81_10
			var_81_10 = var_81_10.New
			Object = var_1_10009
			var_81_10 = var_81_10(var_1_10009.Instantiate(arg_81_0.uiSkinToggleItem, arg_81_0.uiSkinToggleParent), arg_81_0)
		end

		var_81_9[iter_81_0] = var_81_10

		local var_81_11 = arg_81_0.skinShopItemList[iter_81_0]

		var_7.didEnter(var_81_11, iter_81_1)
	end

	return
end

function var_0_1.OnClickSkinShop(arg_83_0, arg_83_1, arg_83_2)
	arg_83_0.contextData.shop2 = arg_83_2

	if arg_83_0.shop2 == arg_83_2 then
		return
	end

	arg_83_0.shop2 = arg_83_2

	arg_83_0:ShowChargeWarp(false)

	pg = var_3

	local var_83_0 = var_3.m02

	var_3.sendNotification(var_83_0, var_0_1.CLOSE_ALL_LAYER)

	local var_83_1 = arg_83_0
	local var_83_2 = arg_83_0.emit

	NewShopMainMediator = var_5

	local var_83_3 = var_5.OPEN_LAYER

	LatestSkinShopLayer = var_1_10006
	LatestSkinShopMediator = var_1_10007

	var_83_2(var_83_1, var_83_3, var_1_10006, var_1_10007, {
		type = arg_83_2,
		mode = arg_83_0.contextData.mode
	})

	return
end

function var_0_1.DisposeSkinToggleList(arg_84_0)
	ipairs = var_1_10001

	for iter_84_0, iter_84_1 in var_1_10001(arg_84_0.skinShopItemList) do
		iter_84_1:willExit()
	end

	arg_84_0.skinShopItemList = nil

	return
end

function var_0_1.GetSkinShopList(arg_85_0)
	Clone = var_1_10001
	pg = var_1_10002

	local var_85_0 = var_1_10001(var_1_10002.shop_skin_subsheet.get_id_list_by_type[0])

	getProxy = var_2
	ShipSkinProxy = var_1_10003

	local var_85_1 = var_2(var_1_10003)

	if #var_2.GetInTimeSkins(var_85_1) <= 0 then
		table = var_3

		var_3.remove(var_85_0, 1)
	end

	pg = var_3

	local var_85_2 = var_3.TimeMgr.GetInstance()

	getProxy = var_4
	ShipSkinProxy = var_1_10005

	local var_85_3 = var_4(var_1_10005)
	local var_85_4 = var_4.GetAllSkins(var_85_3)

	ipairs = var_85_3
	pg = var_1_10006

	local var_85_5

	if not var_1_10006.shop_skin_subsheet.get_id_list_by_type[1] then
		var_85_5 = {}
	end

	for iter_85_0, iter_85_1 in var_85_3(var_85_5) do
		pg = var_1_10010
		var_1_10010 = var_1_10010.shop_skin_subsheet[iter_85_1]

		if var_85_2:inTime(var_1_10010.time) then
			ipairs = var_11

			for iter_85_2, iter_85_3 in var_11(var_85_4) do
				table = var_1_10016

				if var_1_10016.keyof(var_1_10010.param, iter_85_3.id) then
					table = var_1_10016

					var_1_10016.insert(var_85_0, iter_85_1)

					break
				end
			end
		end
	end

	table = var_5

	var_5.sort(var_85_0, function(arg_86_0, arg_86_1)
		pg = var_2_10002

		local var_86_0 = var_2_10002.shop_skin_subsheet[arg_86_0]

		pg = var_2_10003

		local var_86_1 = var_2_10003.shop_skin_subsheet[arg_86_1]

		return var_86_0.sort == var_86_0.sort and arg_86_0 < arg_86_1 or var_86_0.sort < var_86_1.sort
	end)

	return var_85_0
end

function var_0_1.GetDefaultSkinShop(arg_87_0)
	Clone = var_1_10001

	local var_87_0 = var_1_10001(arg_87_0.skinShopList)

	table = var_2

	var_2.sort(var_87_0, function(arg_88_0, arg_88_1)
		pg = var_2_10002

		local var_88_0 = var_2_10002.shop_skin_subsheet[arg_88_0]

		pg = var_2_10003

		local var_88_1 = var_2_10003.shop_skin_subsheet[arg_88_1]

		if var_88_0.shop_skin_subsheet == var_88_1.shop_skin_subsheet then
			return var_88_0.sort == var_88_1.sort and arg_88_0 < arg_88_1 or var_88_0.sort < var_88_1.sort
		else
			return var_88_0.shop_skin_subsheet < var_88_1.shop_skin_subsheet
		end

		return
	end)

	return var_87_0[1]
end

return var_0_1
