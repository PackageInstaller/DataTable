class = var_0_10000

local var_0_0 = "NewShopMainScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

var_0_1.CLOSE_ALL_LAYER = "NewShopMainScene.CLOSE_ALL_LAYER"
var_0_1.SHOW_OR_HIDE_UI = "NewShopMainScene.SHOW_OR_HIDE_UI"
var_0_1.SHOW_OR_HIDE_UI_2 = "NewShopMainScene.SHOW_OR_HIDE_UI_2"
var_0_1.CLOSE_VIEW = "NewShopMainScene.CLOSE_VIEW"
var_0_1.TYPE_CHARGE = "charge"
var_0_1.TYPE_SKIN = "skin"

function var_0_1.getUIName(arg_1_0)
	return "NewShopUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	ShopsProxy = var_1_10004

	local var_2_0 = var_1_10002(var_1_10004)

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

		GAME = var_1_10007

		var_2_3(var_2_2, var_1_10007.GET_CHARGE_LIST, {
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

	typeof = var_5
	Text = var_1_10007
	arg_4_0.goldText = var_4_2(var_4_1, var_5(var_1_10007))

	local var_4_3 = var_1:Find("top/resources/gold/max")
	local var_4_4 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_4_0.goldMax = var_4_4(var_4_3, var_5(var_1_10007))
	arg_4_0.oilBtn = var_1:Find("top/resources/oil")

	local var_4_5 = var_1:Find("top/resources/oil/Text")
	local var_4_6 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_4_0.oilText = var_4_6(var_4_5, var_5(var_1_10007))

	local var_4_7 = var_1:Find("top/resources/oil/max")
	local var_4_8 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_4_0.oilMax = var_4_8(var_4_7, var_5(var_1_10007))
	arg_4_0.diamondBtn = var_1:Find("top/resources/gem")

	local var_4_9 = var_1:Find("top/resources/gem/Text")
	local var_4_10 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_4_0.diamondText = var_4_10(var_4_9, var_5(var_1_10007))
	setText = var_2

	local var_4_11 = var_1:Find("top/title/Text")

	i18n = var_5

	var_2(var_4_11, var_5("shop_title"))

	setText = var_2

	local var_4_12 = var_1:Find("shop1List/recommendation/shop1Tg/name")

	i18n = var_5

	var_2(var_4_12, var_5("shop_recommend"))

	setText = var_2

	local var_4_13 = var_1:Find("shop1List/skinShop/shop1Tg/name")

	i18n = var_5

	var_2(var_4_13, var_5("shop_skin"))

	setText = var_2

	local var_4_14 = var_1:Find("shop1List/diamondShop/shop1Tg/name")

	i18n = var_5

	var_2(var_4_14, var_5("shop_diamond_title"))

	setText = var_2

	local var_4_15 = var_1:Find("shop1List/specialShop/shop1Tg/name")

	i18n = var_5

	var_2(var_4_15, var_5("shop_akashi_pick_title"))

	setText = var_2

	local var_4_16 = var_1:Find("shop1List/giftPackShop/shop1Tg/name")

	i18n = var_5

	var_2(var_4_16, var_5("shop_gift_title"))

	setText = var_2

	local var_4_17 = var_1:Find("shop1List/functionalItemShop/shop1Tg/name")

	i18n = var_5

	var_2(var_4_17, var_5("shop_item_title"))

	setText = var_2

	local var_4_18 = var_1:Find("shop1List/supplyShop/shop1Tg/name")

	i18n = var_5

	var_2(var_4_18, var_5("shop_supply_prop"))

	setText = var_2

	local var_4_19 = var_1:Find("shop1List/recommendation/shop1Tg/name/en")

	i18n = var_5

	var_2(var_4_19, var_5("shop_recommend_en"))

	setText = var_2

	local var_4_20 = var_1:Find("shop1List/skinShop/shop1Tg/name/en")

	i18n = var_5

	var_2(var_4_20, var_5("shop_skin_en"))

	setText = var_2

	local var_4_21 = var_1:Find("shop1List/diamondShop/shop1Tg/name/en")

	i18n = var_5

	var_2(var_4_21, var_5("shop_diamond_title_en"))

	setText = var_2

	local var_4_22 = var_1:Find("shop1List/specialShop/shop1Tg/name/en")

	i18n = var_5

	var_2(var_4_22, var_5("shop_side_lable_en"))

	setText = var_2

	local var_4_23 = var_1:Find("shop1List/giftPackShop/shop1Tg/name/en")

	i18n = var_5

	var_2(var_4_23, var_5("shop_gift_title_en"))

	setText = var_2

	local var_4_24 = var_1:Find("shop1List/functionalItemShop/shop1Tg/name/en")

	i18n = var_5

	var_2(var_4_24, var_5("shop_item_title_en"))

	setText = var_2

	local var_4_25 = var_1:Find("shop1List/supplyShop/shop1Tg/name/en")

	i18n = var_5

	var_2(var_4_25, var_5("shop_supply_prop_en"))

	setText = var_2

	local var_4_26 = var_1:Find("shop1List/skinShop/shop2List/newSkin/name")

	i18n = var_5

	var_2(var_4_26, var_5("shop_skin_new"))

	setText = var_2

	local var_4_27 = var_1:Find("shop1List/skinShop/shop2List/newSkin/selected/name")

	i18n = var_5

	var_2(var_4_27, var_5("shop_skin_new"))

	setText = var_2

	local var_4_28 = var_1:Find("shop1List/skinShop/shop2List/permanentSkin/name")

	i18n = var_5

	var_2(var_4_28, var_5("shop_skin_permanent"))

	setText = var_2

	local var_4_29 = var_1:Find("shop1List/skinShop/shop2List/permanentSkin/selected/name")

	i18n = var_5

	var_2(var_4_29, var_5("shop_skin_permanent"))

	setText = var_2

	local var_4_30 = var_1:Find("shop1List/supplyShop/shop2List/monthShop/name")

	i18n = var_5

	var_2(var_4_30, var_5("shop_month"))

	setText = var_2

	local var_4_31 = var_1:Find("shop1List/supplyShop/shop2List/monthShop/selected/name")

	i18n = var_5

	var_2(var_4_31, var_5("shop_month"))

	setText = var_2

	local var_4_32 = var_1:Find("shop1List/supplyShop/shop2List/supplyShop/name")

	i18n = var_5

	var_2(var_4_32, var_5("shop_supply"))

	setText = var_2

	local var_4_33 = var_1:Find("shop1List/supplyShop/shop2List/supplyShop/selected/name")

	i18n = var_5

	var_2(var_4_33, var_5("shop_supply"))

	setText = var_2

	local var_4_34 = var_1:Find("shop1List/supplyShop/shop2List/activityShop/name")

	i18n = var_5

	var_2(var_4_34, var_5("shop_activity"))

	setText = var_2

	local var_4_35 = var_1:Find("shop1List/supplyShop/shop2List/activityShop/selected/name")

	i18n = var_5

	var_2(var_4_35, var_5("shop_activity"))

	local var_4_36 = arg_4_0._tf

	arg_4_0.frame = var_2.Find(var_4_36, "frame")

	local var_4_37 = arg_4_0._tf

	arg_4_0.viewContainer = var_2.Find(var_4_37, "viewContainer")

	local var_4_38 = arg_4_0._tf

	arg_4_0.painting = var_2.Find(var_4_38, "frame/painting")

	local var_4_39 = arg_4_0._tf

	arg_4_0.chat = var_2.Find(var_4_39, "frame/chat")

	local var_4_40 = arg_4_0.chat

	arg_4_0.chatText = var_2.Find(var_4_40, "Text")

	local var_4_41 = arg_4_0._tf

	arg_4_0.stamp = var_2.Find(var_4_41, "frame/stamp")
	arg_4_0.specialTip = var_1:Find("shop1List/specialShop/shop1Tg/tip")
	arg_4_0.giftTip = var_1:Find("shop1List/giftPackShop/shop1Tg/tip")
	pg = var_2

	local var_4_42 = var_2.EasyRedDotMgr.GetInstance()

	var_2.RegisterRedDot(var_4_42, arg_4_0.specialTip, {
		"specialShop",
		"Charge_Page_Exposure"
	}, function(arg_5_0)
		getProxy = var_2_10001
		ShopsProxy = var_2_10003

		local var_5_0 = var_2_10001(var_2_10003)

		var_1.GiftPackageRedDotTip(var_5_0, {
			arg_5_0
		}, true)

		return
	end)

	pg = var_2

	local var_4_43 = var_2.EasyRedDotMgr.GetInstance()

	var_2.RegisterRedDot(var_4_43, arg_4_0.giftTip, {
		"specialShop",
		"Charge_Page_Exposure"
	}, function(arg_6_0)
		getProxy = var_2_10001
		ShopsProxy = var_2_10003

		local var_6_0 = var_2_10001(var_2_10003)

		var_1.GiftPackageRedDotTip(var_6_0, {
			arg_6_0
		}, false)

		return
	end)

	local var_4_44 = {}
	local var_4_45 = {}

	ChargeScene = var_4_43
	var_4_45.type = var_4_43.TYPE_DIAMOND
	var_4_45.go = var_1:Find("shop1List/diamondShop/shop1Tg")
	var_4_44[1] = var_4_45

	local var_4_46 = {}

	ChargeScene = var_4
	var_4_46.type = var_4.TYPE_GIFT
	var_4_46.go = var_1:Find("shop1List/giftPackShop/shop1Tg")
	var_4_44[2] = var_4_46

	local var_4_47 = {}

	ChargeScene = var_4
	var_4_47.type = var_4.TYPE_ITEM
	var_4_47.go = var_1:Find("shop1List/functionalItemShop/shop1Tg")
	var_4_44[3] = var_4_47

	local var_4_48 = {}

	ChargeScene = var_4
	var_4_48.type = var_4.TYPE_PICK
	var_4_48.go = var_1:Find("shop1List/specialShop/shop1Tg")
	var_4_44[4] = var_4_48
	arg_4_0.toggleList = var_4_44
	GetComponent = var_4_44

	local var_4_49 = var_1
	local var_4_50 = var_1.Find(var_4_49, "shop1List/supplyShop/shop2List/supplyShop")

	typeof = var_5
	Toggle = var_7

	local var_4_51 = var_4_44(var_4_50, var_5(var_7))

	var_4_51.isOn = true
	ChargeTipWindow = var_4_51
	arg_4_0.chargeTipWindow = var_4_51.New(arg_4_0._tf, arg_4_0.event)

	arg_4_0:LoadMingshi()
	arg_4_0:jpUIInit()
	arg_4_0:blurView()
	arg_4_0:initSubView()

	AprilFoolBulinSubView = var_2

	local var_4_52 = var_2.ShowAprilFoolBulin
	local var_4_53 = arg_4_0
	local var_4_54 = arg_4_0.pageContainer

	Vector2 = var_4_49
	arg_4_0.bulinTip = var_4_52(var_4_53, var_4_54, var_4_49.New(-35, -90))

	if arg_4_0.bulinTip then
		local var_4_55 = arg_4_0.bulinTip

		var_2.RegisterView(var_4_55, arg_4_0)

		local var_4_56 = arg_4_0.bulinTip

		var_2.CallbackInvoke(var_4_56, function()
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

	GetZeroTime = var_1_10005

	var_13_1(var_13_0, var_1_10005())

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

	ShopConst = var_3

	local var_17_3 = var_17_2[var_3.SHOP_ID.SUPPLY]

	var_2.OnUpdateItems(var_17_3, arg_17_1)

	local var_17_4 = arg_17_0.subViewList

	ShopConst = var_3

	local var_17_5 = var_17_4[var_3.SHOP_ID.ACTIVITY]

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
	setActive = var_1_10001

	var_1_10001(arg_23_0.chat, false)

	onButton = var_1_10001

	local var_23_0 = arg_23_0
	local var_23_1 = arg_23_0.backBtn

	local function var_23_2()
		local var_24_0 = arg_23_0

		var_0.closeView(var_24_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_23_0, var_23_1, var_23_2, var_1_10006)

	onButton = var_1_10001

	local var_23_3 = arg_23_0
	local var_23_4 = arg_23_0.homeBtn

	local function var_23_5()
		local var_25_0 = arg_23_0

		var_0.emit(var_25_0, var_0_1.ON_HOME)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_23_3, var_23_4, var_23_5, var_1_10006)

	onButton = var_1_10001

	local var_23_6 = arg_23_0
	local var_23_7 = arg_23_0.goldBtn

	local function var_23_8()
		pg = var_2_10000

		local var_26_0 = var_2_10000.playerResUI

		var_0.ClickGold(var_26_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_23_6, var_23_7, var_23_8, var_1_10006)

	onButton = var_1_10001

	local var_23_9 = arg_23_0
	local var_23_10 = arg_23_0.oilBtn

	local function var_23_11()
		pg = var_2_10000

		local var_27_0 = var_2_10000.playerResUI

		var_0.ClickOil(var_27_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_23_9, var_23_10, var_23_11, var_1_10006)

	onButton = var_1_10001

	local var_23_12 = arg_23_0
	local var_23_13 = arg_23_0.diamondBtn

	local function var_23_14()
		pg = var_2_10000

		local var_28_0 = var_2_10000.playerResUI

		var_0.ClickGem(var_28_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_23_12, var_23_13, var_23_14, var_1_10006)

	onToggle = var_1_10001

	local var_23_15 = arg_23_0
	local var_23_16 = arg_23_0.buttonList
	local var_23_17 = var_4.Find(var_23_16, "shop1List/recommendation/shop1Tg")

	local function var_23_18(arg_29_0)
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

			NewShopMainMediator = var_4

			local var_29_4 = var_4.OPEN_LAYER

			NewRecommendationShopLayer = var_2_10005
			NewRecommendationShopMediator = var_2_10006

			var_29_3(var_29_2, var_29_4, var_2_10005, var_2_10006)
		end

		return
	end

	SFX_PANEL = var_23_16

	var_1_10001(var_23_15, var_23_17, var_23_18, var_23_16)

	getProxy = var_1_10001
	ShipSkinProxy = var_23_15

	local var_23_19 = var_1_10001(var_23_15)
	local var_23_20 = var_1.GetInTimeSkins(var_23_19)

	setActive = var_1_10002

	local var_23_21 = arg_23_0.buttonList

	var_1_10002(var_4.Find(var_23_21, "shop1List/skinShop/shop1Tg/timeLimit"), #var_23_20 > 0)

	setActive = var_1_10002

	local var_23_22 = arg_23_0.buttonList

	var_1_10002(var_4.Find(var_23_22, "shop1List/skinShop/shop2List/newSkin"), #var_23_20 > 0)

	onToggle = var_1_10002

	local var_23_23 = arg_23_0
	local var_23_24 = arg_23_0.buttonList
	local var_23_25 = var_5.Find(var_23_24, "shop1List/skinShop/shop2List/newSkin")

	local function var_23_26(arg_30_0)
		if arg_30_0 then
			arg_23_0.contextData.shop2 = "newSkin"

			if arg_23_0.shop2 == "newSkin" then
				return
			end

			arg_23_0.shop2 = "newSkin"

			local var_30_0 = arg_23_0

			var_1.ShowChargeWarp(var_30_0, false)

			pg = var_1

			local var_30_1 = var_1.m02

			var_1.sendNotification(var_30_1, var_0_1.CLOSE_ALL_LAYER)

			local var_30_2 = arg_23_0
			local var_30_3 = var_1.emit

			NewShopMainMediator = var_4

			local var_30_4 = var_4.OPEN_LAYER

			LatestSkinShopLayer = var_2_10005
			LatestSkinShopMediator = var_2_10006

			var_30_3(var_30_2, var_30_4, var_2_10005, var_2_10006, {
				type = "newSkin",
				mode = arg_23_0.contextData.mode
			})
		end

		return
	end

	SFX_PANEL = var_23_24

	var_1_10002(var_23_23, var_23_25, var_23_26, var_23_24)

	onToggle = var_1_10002

	local var_23_27 = arg_23_0
	local var_23_28 = arg_23_0.buttonList
	local var_23_29 = var_5.Find(var_23_28, "shop1List/skinShop/shop2List/permanentSkin")

	local function var_23_30(arg_31_0)
		if arg_31_0 then
			arg_23_0.contextData.shop2 = "permanentSkin"

			if arg_23_0.shop2 == "permanentSkin" then
				return
			end

			arg_23_0.shop2 = "permanentSkin"

			local var_31_0 = arg_23_0

			var_1.ShowChargeWarp(var_31_0, false)

			pg = var_1

			local var_31_1 = var_1.m02

			var_1.sendNotification(var_31_1, var_0_1.CLOSE_ALL_LAYER)

			local var_31_2 = arg_23_0
			local var_31_3 = var_1.emit

			NewShopMainMediator = var_4

			local var_31_4 = var_4.OPEN_LAYER

			LatestSkinShopLayer = var_2_10005
			LatestSkinShopMediator = var_2_10006

			var_31_3(var_31_2, var_31_4, var_2_10005, var_2_10006, {
				type = "permanentSkin",
				mode = arg_23_0.contextData.mode
			})
		end

		return
	end

	SFX_PANEL = var_23_28

	var_1_10002(var_23_27, var_23_29, var_23_30, var_23_28)

	onToggle = var_1_10002

	local var_23_31 = arg_23_0
	local var_23_32 = arg_23_0.buttonList
	local var_23_33 = var_5.Find(var_23_32, "shop1List/skinShop/shop1Tg")

	local function var_23_34(arg_32_0)
		setActive = var_2_10001

		local var_32_0 = arg_23_0.buttonList

		var_2_10001(var_3.Find(var_32_0, "shop1List/skinShop/shop2List"), arg_32_0)

		if arg_32_0 then
			if arg_23_0.shop1 == "skinShop" then
				return
			end

			arg_23_0.shop1 = "skinShop"

			if arg_23_0.contextData.shop1 and arg_23_0.contextData.shop2 then
				triggerToggle = var_1

				local var_32_1 = arg_23_0.buttonList

				var_1(var_3.Find(var_32_1, "shop1List/skinShop/shop2List/" .. arg_23_0.contextData.shop2), true)
			else
				local var_32_2 = arg_23_0.contextData

				var_32_2.shop1 = "skinShop"
				triggerToggle = var_32_2

				local var_32_3 = arg_23_0.buttonList

				var_32_2(var_3.Find(var_32_3, "shop1List/skinShop/shop2List/" .. (#var_23_20 > 0 and "newSkin" or "permanentSkin")), true)
			end
		end

		return
	end

	SFX_PANEL = var_23_32

	var_1_10002(var_23_31, var_23_33, var_23_34, var_23_32)

	for iter_23_0 = 1, #arg_23_0.toggleList do
		local var_23_35 = arg_23_0.toggleList[iter_23_0]

		onToggle = var_23_32

		local var_23_36 = arg_23_0
		local var_23_37 = var_23_35.go

		local function var_23_38(arg_33_0)
			if arg_33_0 then
				local var_33_0 = arg_23_0

				var_2_10001.ShowChargeWarp(var_33_0, true)

				pg = var_2_10001

				local var_33_1 = var_2_10001.m02

				var_2_10001.sendNotification(var_33_1, var_0_1.CLOSE_ALL_LAYER)

				var_2_10001 = arg_23_0.contextData
				var_2_10001.shop1 = nil
				var_2_10001 = arg_23_0.contextData
				var_2_10001.shop2 = nil
				var_2_10001 = arg_23_0
				var_2_10001.shop1 = nil
				var_2_10001 = arg_23_0
				var_2_10001.shop2 = nil
				originalPrint = var_2_10001
				string = var_33_1

				var_2_10001(var_33_1.format("Begin: toggleType=%s, goName=%s", var_23_35.type, var_23_35.go.parent.name))

				var_2_10001 = arg_23_0.contextData
				ShopConst = var_2
				var_2_10001.type = var_2.SHOP_TYPE.CHARGE
				var_2_10001 = arg_23_0.contextData
				var_2_10001.warp = var_23_35.type
				originalPrint = var_2_10001
				string = var_3

				var_2_10001(var_3.format("End: warp=%s", arg_23_0.contextData.warp))

				local var_33_2 = arg_23_0

				var_2_10001 = var_2_10001.GetShopID
				ShopConst = var_4
				var_2_10001 = var_2_10001(var_33_2, var_4.SHOP_TYPE.CHARGE, var_23_35.type)

				local var_33_3 = arg_23_0

				var_2.switchSubView(var_33_3, var_2_10001)
			end

			switch = var_2_10001

			local var_33_4 = var_23_35.type
			local var_33_5 = {}

			ChargeScene = var_2_10005
			var_33_5[var_2_10005.TYPE_PICK] = function()
				return "payshop_pack_red_dot"
			end
			ChargeScene = var_5
			var_33_5[var_5.TYPE_GIFT] = function()
				return "gemshop_pack_red_dot"
			end

			if var_2_10001(var_33_4, var_33_5) then
				if arg_33_0 then
					local var_33_6 = arg_23_0
					local var_33_7

					if not arg_23_0.toggleMark then
						var_33_7 = {}
					end

					var_33_6.toggleMark = var_33_7

					local var_33_8 = arg_23_0.toggleMark
					local var_33_9 = var_23_35.type

					defaultValue = var_33_5
					var_33_8[var_33_9] = var_33_5(arg_23_0.toggleMark[var_23_35.type], 0) + 1
				elseif arg_23_0.toggleMark then
					defaultValue = var_2

					if var_2(arg_23_0.toggleMark[var_23_35.type], 0) > 0 then
						local var_33_10 = arg_23_0.toggleMark

						var_33_10[var_23_35.type] = arg_23_0.toggleMark[var_23_35.type] - 1
						PlayerPrefs = var_33_10

						local var_33_11 = var_33_10.SetInt
						local var_33_12 = var_1

						getGameset = var_5

						var_33_11(var_33_12, var_5(var_1)[1])

						pg = var_33_11

						local var_33_13 = var_33_11.EasyRedDotMgr.GetInstance()

						var_2.TriggerMarks(var_33_13, "Charge_Page_Exposure")
					end
				end
			end

			return
		end

		SFX_PANEL = var_1_10012

		var_23_32(var_23_36, var_23_37, var_23_38, var_1_10012)
	end

	onToggle = var_2

	local var_23_39 = arg_23_0
	local var_23_40 = arg_23_0.buttonList
	local var_23_41 = var_5.Find(var_23_40, "shop1List/supplyShop/shop1Tg")

	local function var_23_42(arg_36_0)
		setActive = var_2_10001

		local var_36_0 = arg_23_0.buttonList

		var_2_10001(var_3.Find(var_36_0, "shop1List/supplyShop/shop2List"), arg_36_0)

		if arg_36_0 then
			triggerToggle = var_2_10001

			local var_36_1 = arg_23_0.buttonList
			local var_36_2 = var_3.Find
			local var_36_3 = "shop1List/supplyShop/shop2List/"
			local var_36_4 = arg_23_0

			var_2_10001(var_36_2(var_36_1, var_36_3 .. var_7.GetDefaultSupplyShopName(var_36_4)), true)
		end

		return
	end

	SFX_PANEL = var_23_40

	var_2(var_23_39, var_23_41, var_23_42, var_23_40)

	local var_23_43 = {}
	local var_23_44 = {}

	ShopConst = var_23_39
	var_23_44.type = var_23_39.CATEGORY_MONTH

	local var_23_45 = arg_23_0.buttonList

	var_23_44.go = var_4.Find(var_23_45, "shop1List/supplyShop/shop2List/monthShop")
	var_23_43[1] = var_23_44

	local var_23_46 = {}

	ShopConst = var_4
	var_23_46.type = var_4.CATEGORY_SUPPLY

	local var_23_47 = arg_23_0.buttonList

	var_23_46.go = var_4.Find(var_23_47, "shop1List/supplyShop/shop2List/supplyShop")
	var_23_43[2] = var_23_46

	local var_23_48 = {}

	ShopConst = var_4
	var_23_48.type = var_4.CATEGORY_ACTIVITY

	local var_23_49 = arg_23_0.buttonList

	var_23_48.go = var_4.Find(var_23_49, "shop1List/supplyShop/shop2List/activityShop")
	var_23_43[3] = var_23_48
	ipairs = var_23_48

	for iter_23_1, iter_23_2 in var_23_48(var_23_43) do
		onToggle = var_8

		local var_23_50 = arg_23_0
		local var_23_51 = iter_23_2.go

		local function var_23_52(arg_37_0)
			if arg_37_0 then
				local var_37_0 = arg_23_0

				var_1.ShowChargeWarp(var_37_0, true)

				pg = var_1

				local var_37_1 = var_1.m02

				var_1.sendNotification(var_37_1, var_0_1.CLOSE_ALL_LAYER)

				arg_23_0.contextData.shop1 = nil
				arg_23_0.contextData.shop2 = nil
				arg_23_0.shop1 = nil
				arg_23_0.shop2 = nil

				local var_37_2 = arg_23_0.contextData

				ShopConst = var_2
				var_37_2.type = var_2.SHOP_TYPE.SUPPLY
				arg_23_0.contextData.warp = iter_23_2.type

				local var_37_3 = arg_23_0
				local var_37_4 = var_1.GetShopID

				ShopConst = var_4

				local var_37_5 = var_37_4(var_37_3, var_4.SHOP_TYPE.SUPPLY, iter_23_2.type)
				local var_37_6 = arg_23_0

				var_2.switchSubView(var_37_6, var_37_5)
			end

			return
		end

		SFX_PANEL = var_1_10013

		var_8(var_23_50, var_23_51, var_23_52, var_1_10013)
	end

	local var_23_53 = "recommendation"
	local var_23_54 = arg_23_0.contextData.type

	ShopConst = var_5

	if var_23_54 == var_5.SHOP_TYPE.CHARGE then
		local var_23_55 = arg_23_0.contextData.warp

		ChargeScene = var_5

		if var_23_55 == var_5.TYPE_DIAMOND then
			var_23_53 = "diamondShop"
		else
			local var_23_56 = arg_23_0.contextData.warp

			ChargeScene = var_5

			if var_23_56 == var_5.TYPE_GIFT then
				var_23_53 = "giftPackShop"
			else
				local var_23_57 = arg_23_0.contextData.warp

				ChargeScene = var_5

				if var_23_57 == var_5.TYPE_ITEM then
					var_23_53 = "functionalItemShop"
				else
					local var_23_58 = arg_23_0.contextData.warp

					ChargeScene = var_5

					if var_23_58 == var_5.TYPE_PICK then
						var_23_53 = "specialShop"
					else
						var_23_53 = "diamondShop"
					end
				end
			end
		end
	else
		local var_23_59 = arg_23_0.contextData.type

		ShopConst = var_5

		if var_23_59 == var_5.SHOP_TYPE.SKIN then
			var_23_53 = "skinShop"
		else
			local var_23_60 = arg_23_0.contextData.type

			ShopConst = var_5

			if var_23_60 == var_5.SHOP_TYPE.SUPPLY then
				var_23_53 = "supplyShop"
			end
		end
	end

	if arg_23_0.contextData.shop1 then
		var_23_53 = arg_23_0.contextData.shop1
	end

	triggerToggle = var_4

	local var_23_61 = arg_23_0.buttonList

	var_4(var_6.Find(var_23_61, "shop1List/" .. var_23_53 .. "/shop1Tg"), true)

	if var_23_53 == "skinShop" then
		-- block empty
	elseif var_23_53 == "supplyShop" then
		triggerToggle = var_4

		local var_23_62 = arg_23_0.buttonList

		var_4(var_6.Find(var_23_62, "shop1List/supplyShop/shop2List/" .. arg_23_0:GetDefaultSupplyShopName()), true)
	end

	onButton = var_4

	local var_23_63 = arg_23_0
	local var_23_64 = arg_23_0.painting

	local function var_23_65()
		local var_38_0 = arg_23_0

		var_0.displayShipWord(var_38_0)

		local var_38_1 = arg_23_0
		local var_38_2 = var_0.emit

		NewShopMainMediator = var_2_10003

		var_38_2(var_38_1, var_2_10003.CLICK_MING_SHI)

		return
	end

	SFX_PANEL = var_9

	var_4(var_23_63, var_23_64, var_23_65, var_9)

	onButton = var_4

	local var_23_66 = arg_23_0
	local var_23_67 = arg_23_0.stamp

	local function var_23_68()
		getProxy = var_2_10000
		TaskProxy = var_2_10002

		local var_39_0 = var_2_10000(var_2_10002)

		var_0.dealMingshiTouchFlag(var_39_0, 4)

		return
	end

	SFX_CONFIRM = var_9

	var_4(var_23_66, var_23_67, var_23_68, var_9)
	arg_23_0:RefreshActivityShop()
	arg_23_0:updateNoRes()
	arg_23_0:jpUIEnter()

	return
end

function var_0_1.GetDefaultSupplyShopName(arg_40_0)
	local var_40_0 = arg_40_0.contextData.type

	ShopConst = var_1_10002

	if var_40_0 ~= var_1_10002.SHOP_TYPE.SUPPLY then
		return "supplyShop"
	end

	local var_40_1 = arg_40_0.contextData.warp

	type = var_2

	local var_40_2

	if var_2(var_40_1) == "string" then
		ShopConst = var_40_2
		var_40_2 = var_40_2.SHOP_NAME_LIST[var_40_1]
		arg_40_0.contextData.warp = var_40_2[1]
		arg_40_0.contextData.shopID = var_40_2[2]
	else
		type = var_40_2

		if var_40_2(var_40_1) == "number" and arg_40_0.contextData.shopID == nil then
			pairs = var_2
			ShopConst = var_4

			for iter_40_0, iter_40_1 in var_2(var_4.SUPPLY_SHOP_LIST) do
				pairs = var_1_10007

				for iter_40_2, iter_40_3 in var_1_10007(iter_40_1) do
					if iter_40_3 == var_40_1 then
						arg_40_0.contextData.warp = iter_40_0
						arg_40_0.contextData.shopID = iter_40_3

						break
					end
				end
			end
		end
	end

	local var_40_3 = ""
	local var_40_4 = arg_40_0.contextData.warp

	ShopConst = var_4

	if var_40_4 == var_4.CATEGORY_MONTH then
		var_40_3 = "monthShop"
	else
		local var_40_5 = arg_40_0.contextData.warp

		ShopConst = var_4

		if var_40_5 == var_4.CATEGORY_SUPPLY then
			var_40_3 = "supplyShop"
		else
			local var_40_6 = arg_40_0.contextData.warp

			ShopConst = var_4
			var_40_3 = var_40_6 == var_4.CATEGORY_ACTIVITY and "activityShop" or "supplyShop"
		end
	end

	return var_40_3
end

function var_0_1.RefreshActivityShop(arg_41_0)
	local var_41_0 = arg_41_0.supplyShopList

	ShopConst = var_1_10002

	local var_41_1

	if not var_41_0[var_1_10002.TYPE_ACTIVITY] then
		var_41_1 = {}
	end

	setActive = var_2

	local var_41_2 = arg_41_0.buttonList

	var_2(var_4.Find(var_41_2, "shop1List/supplyShop/shop2List/activityShop"), #var_41_1 > 0)

	return
end

function var_0_1.ShowOrHideUI(arg_42_0, arg_42_1)
	arg_42_0:setVisible(arg_42_1)

	setActive = var_2

	var_2(arg_42_0.buttonList, arg_42_1)

	return
end

function var_0_1.ShowOrHideUI2(arg_43_0, arg_43_1)
	for iter_43_0 = 0, arg_43_0._tf.childCount - 1 do
		setActive = var_1_10006

		local var_43_0 = arg_43_0._tf

		var_1_10006(var_8.GetChild(var_43_0, iter_43_0), arg_43_1)
	end

	setActive = var_2

	local var_43_1 = arg_43_0.buttonList

	var_2(var_4.Find(var_43_1, "leftBg"), arg_43_1)

	setActive = var_2

	local var_43_2 = arg_43_0.buttonList

	var_2(var_4.Find(var_43_2, "shop1List"), arg_43_1)

	setActive = var_2

	local var_43_3 = arg_43_0.buttonList

	var_2(var_4.Find(var_43_3, "top"), true)

	return
end

function var_0_1.OnChargeSuccess(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0.chargeTipWindow

	var_2.ExecuteAction(var_44_0, "Show", arg_44_1)

	return
end

function var_0_1.LoadMingshi(arg_45_0)
	Live2dConst = var_1_10001

	if var_1_10001.GetLive2DArm32MatchAble() then
		Ship = var_1

		local var_45_0 = var_1.New({
			configId = 312011
		})
		local var_45_1 = var_1.getPainting(var_45_0)

		LoadPaintingPrefabAsync = var_3

		var_3(arg_45_0.painting, var_45_1, var_45_1, "mainNormal", function()
			arg_45_0.loading = false

			return
		end)
	else
		arg_45_0:createLive2D()
	end

	arg_45_0:AddLive2dTimer()

	return
end

function var_0_1.AddLive2dTimer(arg_47_0)
	arg_47_0:StopLive2dTimer()

	Timer = var_1
	arg_47_0.live2dTimer = var_1.New(function()
		pg = var_2_10000

		local var_48_0 = var_2_10000.ChargeShipTalkInfo.Actions

		math = var_2_10001

		local var_48_1 = var_48_0[var_2_10001.random(#var_48_0)]
		local var_48_2 = arg_47_0

		if var_2.checkBuyDone(var_48_2, var_48_1.action) then
			local var_48_3 = arg_47_0

			var_2.displayShipWord(var_48_3, nil, false, var_48_1.dialog_index)
		end

		return
	end, 20, -1)

	local var_47_0 = arg_47_0.live2dTimer

	var_1.Start(var_47_0)

	return
end

function var_0_1.StopLive2dTimer(arg_49_0)
	if arg_49_0.live2dTimer then
		local var_49_0 = arg_49_0.live2dTimer

		var_1.Stop(var_49_0)

		arg_49_0.live2dTimer = nil
	end

	return
end

function var_0_1.ShowChargeWarp(arg_50_0, arg_50_1)
	setActive = var_1_10002

	var_1_10002(arg_50_0.frame, arg_50_1)

	setActive = var_1_10002

	var_1_10002(arg_50_0.viewContainer, arg_50_1)
	arg_50_0:ShowResourceBar(arg_50_1)

	if arg_50_0.subViewList[arg_50_0.curSubViewNum] then
		if arg_50_1 == false then
			var_2:Destroy()

			arg_50_0.curSubViewNum = 0
		else
			var_2:ShowPanel(arg_50_1)
		end
	end

	return
end

function var_0_1.ShowResourceBar(arg_51_0, arg_51_1)
	if arg_51_0.resourceBarFlag == arg_51_1 then
		return
	end

	arg_51_0.resourceBarFlag = arg_51_1
	setActive = var_2

	var_2(arg_51_0.resourcePanel, arg_51_1)

	return
end

function var_0_1.willExit(arg_52_0)
	if arg_52_0.bulinTip then
		local var_52_0 = arg_52_0.bulinTip

		var_1.Destroy(var_52_0)

		arg_52_0.bulinTip = nil
	end

	pg = var_1

	local var_52_1 = var_1.EasyRedDotMgr.GetInstance()

	var_1.UnRegisterRedDot(var_52_1, arg_52_0.specialTip)

	pg = var_1

	local var_52_2 = var_1.EasyRedDotMgr.GetInstance()

	var_1.UnRegisterRedDot(var_52_2, arg_52_0.giftTip)

	if arg_52_0.toggleMark then
		pairs = var_1

		for iter_52_0, iter_52_1 in var_1(arg_52_0.toggleMark) do
			if 0 < iter_52_1 then
				switch = var_6

				local var_52_3 = iter_52_0
				local var_52_4 = {}

				ChargeScene = var_1_10010
				var_52_4[var_1_10010.TYPE_PICK] = function()
					return "payshop_pack_red_dot"
				end
				ChargeScene = var_1_10010
				var_52_4[var_1_10010.TYPE_GIFT] = function()
					return "gemshop_pack_red_dot"
				end

				local var_52_5 = var_6(var_52_3, var_52_4)

				PlayerPrefs = var_1_10007
				var_1_10007 = var_1_10007.SetInt

				local var_52_6 = var_52_5

				getGameset = var_1_10010

				var_1_10007(var_52_6, var_1_10010(var_52_5)[1])
			end
		end

		arg_52_0.toggleMark = nil
	end

	arg_52_0:ShowResourceBar()
	arg_52_0:unBlurView()

	if arg_52_0.chargeTipWindow then
		local var_52_7 = arg_52_0.chargeTipWindow

		var_1.Destroy(var_52_7)

		arg_52_0.chargeTipWindow = nil
	end

	local var_52_8 = arg_52_0.contextData.singleWindow

	var_1.Destroy(var_52_8)

	local var_52_9 = arg_52_0.contextData.multiWindow

	var_1.Destroy(var_52_9)

	local var_52_10 = arg_52_0.contextData.singleWindowForESkin

	var_1.Destroy(var_52_10)

	local var_52_11 = arg_52_0.contextData.paintingView

	var_1.Dispose(var_52_11)

	arg_52_0.contextData.singleWindow = nil
	arg_52_0.contextData.multiWindow = nil
	arg_52_0.contextData.singleWindowForESkin = nil
	arg_52_0.contextData.paintingView = nil
	arg_52_0.bulinTip = nil
	pairs = var_1

	for iter_52_2, iter_52_3 in var_1(arg_52_0.subViewList) do
		iter_52_3:Destroy()
	end

	arg_52_0.subViewList = nil

	if arg_52_0.heartsTimer then
		local var_52_12 = arg_52_0.heartsTimer

		var_1.Stop(var_52_12)

		arg_52_0.heartsTimer = nil
	end

	if arg_52_0.live2dChar then
		local var_52_13 = arg_52_0.live2dChar

		var_1.Dispose(var_52_13)
	end

	arg_52_0:StopLive2dTimer()
	arg_52_0:stopCV()

	if arg_52_0.giftShopView then
		local var_52_14 = arg_52_0.giftShopView

		var_1.OnDestroy(var_52_14)
	end

	return
end

function var_0_1.onBackPressed(arg_55_0)
	local var_55_0 = arg_55_0.contextData.singleWindow

	if var_1.GetLoaded(var_55_0) then
		local var_55_1 = arg_55_0.contextData.singleWindow

		if var_1.isShowing(var_55_1) then
			local var_55_2 = arg_55_0.contextData.singleWindow

			var_1.Close(var_55_2)

			return
		end
	end

	local var_55_3 = arg_55_0.contextData.multiWindow

	if var_1.GetLoaded(var_55_3) then
		local var_55_4 = arg_55_0.contextData.multiWindow

		if var_1.isShowing(var_55_4) then
			local var_55_5 = arg_55_0.contextData.multiWindow

			var_1.Close(var_55_5)

			return
		end
	end

	local var_55_6 = arg_55_0.contextData.singleWindowForESkin

	if var_1.GetLoaded(var_55_6) then
		local var_55_7 = arg_55_0.contextData.singleWindowForESkin

		if var_1.isShowing(var_55_7) then
			local var_55_8 = arg_55_0.contextData.singleWindowForESkin

			var_1.Hide(var_55_8)

			return
		end
	end

	var_0_1.super.onBackPressed(arg_55_0)

	return
end

function var_0_1.initSubView(arg_56_0)
	ChargeDiamondShopView = var_1_10001

	local var_56_0 = var_1_10001.New(arg_56_0.viewContainer, arg_56_0.event, arg_56_0.contextData)

	ChargeGiftShopView = var_1_10002

	local var_56_1 = var_1_10002.New(arg_56_0.viewContainer, arg_56_0.event, arg_56_0.contextData)

	ChargeItemShopView = var_3

	local var_56_2 = var_3.New(arg_56_0.viewContainer, arg_56_0.event, arg_56_0.contextData)

	ChargePickShopView = var_4

	local var_56_3 = var_4.New(arg_56_0.viewContainer, arg_56_0.event, arg_56_0.contextData)

	SupplyShopView = var_5

	local var_56_4 = var_5.New
	local var_56_5 = arg_56_0.viewContainer
	local var_56_6 = arg_56_0.event
	local var_56_7 = arg_56_0.contextData

	ShopConst = var_1_10010

	local var_56_8 = var_56_4(var_56_5, var_56_6, var_56_7, var_1_10010.CATEGORY_MONTH)

	SupplyShopView = var_6

	local var_56_9 = var_6.New
	local var_56_10 = arg_56_0.viewContainer
	local var_56_11 = arg_56_0.event
	local var_56_12 = arg_56_0.contextData

	ShopConst = var_1_10011

	local var_56_13 = var_56_9(var_56_10, var_56_11, var_56_12, var_1_10011.CATEGORY_SUPPLY)

	SupplyShopView = var_56_5

	local var_56_14 = var_56_5.New
	local var_56_15 = arg_56_0.viewContainer
	local var_56_16 = arg_56_0.event
	local var_56_17 = arg_56_0.contextData

	ShopConst = var_1_10012

	local var_56_18 = var_56_14(var_56_15, var_56_16, var_56_17, var_1_10012.CATEGORY_ACTIVITY)

	arg_56_0.curSubViewNum = 0

	local var_56_19 = {}

	ShopConst = var_56_15
	var_56_19[var_56_15.SHOP_ID.DIAMOND] = var_56_0
	ShopConst = var_9
	var_56_19[var_9.SHOP_ID.GIFT] = var_56_1
	ShopConst = var_9
	var_56_19[var_9.SHOP_ID.ITEM] = var_56_2
	ShopConst = var_9
	var_56_19[var_9.SHOP_ID.PICK] = var_56_3
	ShopConst = var_9
	var_56_19[var_9.SHOP_ID.MONTH] = var_56_8
	ShopConst = var_9
	var_56_19[var_9.SHOP_ID.SUPPLY] = var_56_13
	ShopConst = var_9
	var_56_19[var_9.SHOP_ID.ACTIVITY] = var_56_18
	arg_56_0.subViewList = var_56_19
	pairs = var_56_19

	for iter_56_0, iter_56_1 in var_56_19(arg_56_0.subViewList) do
		iter_56_1:RegisterView(arg_56_0)
	end

	local var_56_20 = arg_56_0.contextData

	ShopSingleWindow = var_9
	var_56_20.singleWindow = var_9.New(arg_56_0._tf, arg_56_0.event)

	local var_56_21 = arg_56_0.contextData

	ShopMultiWindow = var_9
	var_56_21.multiWindow = var_9.New(arg_56_0._tf, arg_56_0.event)

	local var_56_22 = arg_56_0.contextData

	EquipmentSkinInfoUIForShopWindow = var_9
	var_56_22.singleWindowForESkin = var_9.New(arg_56_0._tf, arg_56_0.event)

	local var_56_23 = arg_56_0.contextData

	ShopPaintingView = var_9

	local var_56_24 = var_9.New
	local var_56_25 = arg_56_0._tf
	local var_56_26 = var_11.Find(var_56_25, "frame/supplyPaint")
	local var_56_27 = arg_56_0._tf

	var_56_23.paintingView = var_56_24(var_56_26, var_12.Find(var_56_27, "frame/chat"))

	local var_56_28 = arg_56_0.contextData.paintingView
	local var_56_29 = var_8.setSecretaryPos
	local var_56_30 = arg_56_0._tf

	var_56_29(var_56_28, var_11.Find(var_56_30, "frame/secretaryPos"))

	return
end

function var_0_1.GetShopID(arg_57_0, arg_57_1, arg_57_2)
	ShopConst = var_1_10003

	return var_1_10003.SHOP_LIST[arg_57_1][arg_57_2]
end

function var_0_1.switchSubView(arg_58_0, arg_58_1)
	originalPrint = var_1_10002
	string = var_1_10004

	var_1_10002(var_1_10004.format("End: shopID=%s curShopID=%s", arg_58_1, arg_58_0.curSubViewNum))

	if arg_58_1 == arg_58_0.curSubViewNum then
		return
	end

	local var_58_0 = arg_58_0.subViewList[arg_58_1]

	var_2.setGoodData(var_58_0, arg_58_0.firstChargeIds, arg_58_0.chargedList, arg_58_0.normalList, arg_58_0.normalGroupList)

	local var_58_1 = arg_58_0.subViewList[arg_58_1]

	var_2.Reset(var_58_1)

	local var_58_2 = arg_58_0.subViewList[arg_58_1]

	var_2.Load(var_58_2)

	if arg_58_0.subViewList[arg_58_1].SetAllShopData then
		var_58_2 = arg_58_0.subViewList[arg_58_1]

		var_2.ActionInvoke(var_58_2, "SetAllShopData", arg_58_0.supplyShopList)
	end

	if arg_58_0.subViewList[arg_58_0.curSubViewNum] then
		var_2:Destroy()
	end

	arg_58_0.curSubViewNum = arg_58_1

	local var_58_3 = arg_58_0
	local var_58_4 = arg_58_0.SwitchPainting
	local var_58_5 = arg_58_0.subViewList[arg_58_1]

	var_58_4(var_58_3, var_6.IsSupplyShop(var_58_5))

	PLATFORM_CODE = var_58_4
	PLATFORM_JP = var_58_2

	if var_58_4 == var_58_2 then
		setActive = var_58_4

		local var_58_6 = arg_58_0.userAgreeBtn3

		ChargeScene = var_6

		var_58_4(var_58_6, arg_58_1 == var_6.TYPE_DIAMOND)

		setActive = var_58_4

		local var_58_7 = arg_58_0.userAgreeBtn4

		ChargeScene = var_6

		var_58_4(var_58_7, arg_58_1 == var_6.TYPE_DIAMOND)
	end

	return
end

function var_0_1.SwitchPainting(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_0.contextData.paintingView

	var_2.Show(var_59_0, arg_59_1)

	setActive = var_2

	var_2(arg_59_0.painting, not arg_59_1)

	if arg_59_1 then
		arg_59_0:StopLive2dTimer()

		arg_59_0.chatFlag = nil

		arg_59_0:stopCV()

		setActive = var_2

		local var_59_1 = arg_59_0.stamp

		getProxy = var_5
		TaskProxy = var_1_10007

		local var_59_2 = var_5(var_1_10007)

		var_2(var_59_1, var_5.mingshiTouchFlagEnabled(var_59_2))

		LOCK_CLICK_MINGSHI = var_2

		if var_2 then
			setActive = var_2

			var_2(arg_59_0.stamp, false)
		end
	else
		setActive = var_2

		var_2(arg_59_0.stamp, false)
		arg_59_0:AddLive2dTimer()
	end

	return
end

function var_0_1.switchSubViewByTogger(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0.toggleList[arg_60_1]

	triggerToggle = var_1_10003

	var_1_10003(var_60_0.go, true)

	return
end

function var_0_1.updateCurSubView(arg_61_0)
	isActive = var_1_10001

	if not var_1_10001(arg_61_0.viewContainer) then
		return
	end

	if arg_61_0.subViewList[arg_61_0.curSubViewNum] == nil then
		return
	end

	var_1:setGoodData(arg_61_0.firstChargeIds, arg_61_0.chargedList, arg_61_0.normalList, arg_61_0.normalGroupList)
	var_1:reUpdateAll()

	return
end

function var_0_1.updateNoRes(arg_62_0, arg_62_1)
	if not arg_62_1 then
		arg_62_1 = arg_62_0.contextData.noRes
	else
		arg_62_0.contextData.noRes = arg_62_1
	end

	if not arg_62_1 or #arg_62_1 <= 0 then
		return
	end

	local var_62_0 = arg_62_0.contextData

	var_62_0.noRes = {}
	getProxy = var_62_0
	BagProxy = var_1_10004

	local var_62_1 = var_62_0(var_1_10004)
	local var_62_2 = var_2.getData(var_62_1)
	local var_62_3 = ""

	ipairs = var_62_1

	for iter_62_0, iter_62_1 in var_62_1(arg_62_1) do
		if iter_62_1[2] > 0 then
			if iter_62_1[1] == 59001 then
				var_1_10010 = arg_62_1[iter_62_0]
				var_1_10010[2] = iter_62_1[3] - arg_62_0.player.gold
			else
				var_1_10010 = arg_62_1[iter_62_0]

				local var_62_4 = iter_62_1[3]
				local var_62_5

				if not var_62_2[iter_62_1[1]] or not var_62_2[iter_62_1[1]].count then
					var_62_5 = 0
				end

				var_1_10010[2] = var_62_4 - var_62_5
			end
		end

		if arg_62_1[iter_62_0][2] > 0 then
			table = var_1_10010

			var_1_10010.insert(arg_62_0.contextData.noRes, arg_62_1[iter_62_0])
		end
	end

	ipairs = var_5

	for iter_62_2, iter_62_3 in var_5(arg_62_0.contextData.noRes) do
		Item = var_1_10010
		var_1_10010 = var_1_10010.getConfigData(iter_62_3[1]).name

		local var_62_6 = var_62_3

		i18n = var_12
		var_62_3 = var_62_6 .. var_12(iter_62_3[1] == 59001 and "text_noRes_info_tip" or "text_noRes_info_tip2", var_1_10010, iter_62_3[2])

		if iter_62_2 < #arg_62_0.contextData.noRes then
			local var_62_7 = var_62_3

			i18n = var_12
			var_62_3 = var_62_7 .. var_12("text_noRes_info_tip_link")
		end
	end

	if var_62_3 == "" then
		local var_62_8 = arg_62_0
		local var_62_9 = arg_62_0.displayShipWord

		i18n = iter_62_2

		var_62_9(var_62_8, iter_62_2("text_shop_enoughRes_tip"), false)
	else
		local var_62_10 = arg_62_0
		local var_62_11 = arg_62_0.displayShipWord

		i18n = iter_62_2

		var_62_11(var_62_10, iter_62_2("text_shop_noRes_tip", var_62_3), true)
	end

	return
end

function var_0_1.displayShipWord(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	if not arg_63_0.chatFlag then
		if not arg_63_1 and arg_63_0.contextData.noRes then
			local var_63_0 = #arg_63_0.contextData.noRes

			if 0 < var_63_0 then
				setActive = var_63_0

				var_63_0(arg_63_0.chat, false)

				local var_63_1 = arg_63_0.chat.transform

				Vector3 = var_1_10005
				var_63_1.localScale = var_1_10005(0, 0, 1)
			end
		end

		arg_63_0.chatFlag = true

		if not arg_63_0.isInitChatPosition then
			arg_63_0.isInitChatPosition = true

			arg_63_0:InitChatPosition()
		end

		setActive = var_4

		var_4(arg_63_0.chat, true)

		local var_63_2 = arg_63_0.player
		local var_63_3 = var_4.getChargeLevel(var_63_2)

		if not arg_63_3 then
			::label_63_0::

			math = var_1_10005
			var_1_10005 = var_1_10005.random(1, var_63_3)
		end

		local var_63_4

		if arg_63_3 then
			pg = var_7
			var_63_4 = var_7.pay_level_award[var_1_10005].dialog
		elseif not arg_63_1 then
			::label_63_1::

			pg = var_7
			var_63_4 = var_7.pay_level_award[var_1_10005].dialog
		end

		if not arg_63_1 then
			arg_63_0:playCV(var_1_10005)
		end

		setText = var_7

		var_7(arg_63_0.chatText, var_63_4)

		local var_63_5 = arg_63_0.chatText
		local var_63_6 = var_7.GetComponent

		typeof = var_10
		Text = var_1_10012

		local var_63_7 = var_63_6(var_63_5, var_10(var_1_10012))

		;(function()
			local var_64_0 = 3
			local var_64_1 = 0.3

			LeanTween = var_2_10002

			local var_64_2 = var_2_10002.scale

			rtf = var_2_10004

			local var_64_3 = var_2_10004(arg_63_0.chat.gameObject)

			Vector3 = var_2_10005

			local var_64_4 = var_64_2(var_64_3, var_2_10005.New(1, 1, 1), var_64_1)
			local var_64_5 = var_2.setFrom

			Vector3 = var_5

			local var_64_6 = var_64_5(var_64_4, var_5.New(0, 0, 0))
			local var_64_7 = var_2.setEase

			LeanTweenType = var_5

			local var_64_8 = var_64_7(var_64_6, var_5.easeOutBack)
			local var_64_9 = var_2.setOnComplete

			System = var_5

			var_64_9(var_64_8, var_5.Action(function()
				if not arg_63_2 then
					LeanTween = var_0

					local var_65_0 = var_0.scale

					rtf = var_3_10002

					local var_65_1 = var_3_10002(arg_63_0.chat.gameObject)

					Vector3 = var_3_10003

					local var_65_2 = var_65_0(var_65_1, var_3_10003.New(0, 0, 1), var_64_1)
					local var_65_3 = var_0.setEase

					LeanTweenType = var_3

					local var_65_4 = var_65_3(var_65_2, var_3.easeInBack)
					local var_65_5 = var_0.setDelay(var_65_4, var_64_1 + var_64_0)
					local var_65_6 = var_0.setOnComplete

					System = var_3

					var_65_6(var_65_5, var_3.Action(function()
						local var_66_0 = arg_63_0

						var_66_0.chatFlag = nil
						setActive = var_66_0

						var_66_0(arg_63_0.chat, false)

						if arg_63_0.contextData.noRes and #arg_63_0.contextData.noRes > 0 then
							local var_66_1 = arg_63_0

							var_0.updateNoRes(var_66_1)
						end

						return
					end))
				else
					arg_63_0.chatFlag = nil
				end

				return
			end))

			return
		end)()
	end

	return
end

function var_0_1.InitChatPosition(arg_67_0)
	return
end

function var_0_1.playHeartEffect(arg_68_0)
	if arg_68_0.heartsTimer then
		local var_68_0 = arg_68_0.heartsTimer

		var_1.Stop(var_68_0)
	end

	local var_68_1 = arg_68_0.painting
	local var_68_2 = var_1.Find(var_68_1, "heartsfly")

	setActive = var_1_10002

	var_1_10002(var_68_2, true)

	Timer = var_1_10002
	arg_68_0.heartsTimer = var_1_10002.New(function()
		setActive = var_2_10000

		var_2_10000(var_68_2, false)

		return
	end, 1, 1)

	local var_68_3 = arg_68_0.heartsTimer

	var_2.Start(var_68_3)

	return
end

function var_0_1.createLive2D(arg_70_0)
	Live2DPainting = var_1_10001

	local var_70_0 = var_1_10001.GenerateData
	local var_70_1 = {}

	Ship = var_1_10004
	var_70_1.ship = var_1_10004.New({
		configId = 312011
	})
	var_70_1.offset = {
		0,
		0,
		0,
		75
	}
	Vector3 = var_4
	var_70_1.position = var_4(0, 0, 0)

	local var_70_2 = arg_70_0._tf

	var_70_1.parent = var_4.Find(var_70_2, "frame/painting/live2d")

	local var_70_3 = var_70_0(var_70_1)

	Live2DPainting = var_1_10002
	arg_70_0.live2dChar = var_1_10002.New(var_70_3, function(arg_71_0)
		local var_71_0 = arg_71_0
		local var_71_1 = arg_71_0.setSortingLayer

		LayerWeightConst = var_2_10004

		var_71_1(var_71_0, var_2_10004.L2D_DEFAULT_LAYER)

		return
	end)

	return
end

function var_0_1.checkBuyDone(arg_72_0, arg_72_1)
	if arg_72_0.live2dChar then
		local var_72_0 = arg_72_0.live2dChar

		if not var_2.IsLoaded(var_72_0) then
			return
		end

		local var_72_1

		type = var_1_10003

		if var_1_10003(arg_72_1) == "string" then
			if arg_72_1 == "damonds" then
				var_72_1 = "diamond"
			else
				var_72_1 = arg_72_1
			end
		else
			pg = var_3

			if var_3.shop_template[arg_72_1] and var_3.effect_args then
				type = var_4

				if var_4(var_3.effect_args) == "table" then
					ipairs = var_4

					for iter_72_0, iter_72_1 in var_4(var_3.effect_args) do
						if iter_72_1 == 1 then
							var_72_1 = "gold"
						end
					end
				end
			end
		end

		local var_72_2 = arg_72_0.preAniName == "gold" or arg_72_0.preAniName == "diamond"
		local var_72_3 = var_72_1 == "gold" or var_72_1 == "diamond"
		local var_72_4 = var_72_2 and var_72_3 or not var_72_2

		var_72_4 = var_72_1 and arg_72_0.preAniName ~= var_72_1 and var_72_4

		if var_72_4 then
			arg_72_0.preAniName = var_72_1

			local var_72_5 = arg_72_0.live2dChar

			var_6.TriggerAction(var_72_5, var_72_1, nil, true)
		end

		return var_72_4
	end
end

function var_0_1.playCV(arg_73_0, arg_73_1)
	pg = var_1_10002

	local var_73_0 = var_1_10002.pay_level_award[arg_73_1]
	local var_73_1

	if var_73_0 and var_73_0.cv_key ~= "" then
		var_73_1 = "event:/cv/chargeShop/" .. var_73_0.cv_key
	end

	if var_73_1 then
		arg_73_0:stopCV()

		arg_73_0._currentVoice = var_73_1
		pg = var_4

		local var_73_2 = var_4.CriMgr.GetInstance()

		var_4.PlaySoundEffect_V3(var_73_2, var_73_1)
	end

	return
end

function var_0_1.stopCV(arg_74_0)
	if arg_74_0._currentVoice then
		pg = var_1

		local var_74_0 = var_1.CriMgr.GetInstance()

		var_1.UnloadSoundEffect_V3(var_74_0, arg_74_0._currentVoice)
	end

	arg_74_0._currentVoice = nil

	return
end

function var_0_1.blurView(arg_75_0)
	local var_75_0 = arg_75_0
	local var_75_1 = arg_75_0.OverlayPanel
	local var_75_2 = arg_75_0.buttonList
	local var_75_3 = {}
	local var_75_4 = {}
	local var_75_5 = arg_75_0.buttonList

	var_75_4[1] = var_7.Find(var_75_5, "leftBg")
	var_75_3.pbList = var_75_4

	var_75_1(var_75_0, var_75_2, var_75_3)

	return
end

function var_0_1.unBlurView(arg_76_0)
	arg_76_0:UnOverlayPanel(arg_76_0.buttonList, arg_76_0._tf)

	return
end

function var_0_1.jpUIInit(arg_77_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_JP = var_1_10002

	if var_1_10001 ~= var_1_10002 then
		return
	end

	local var_77_0 = arg_77_0._tf

	arg_77_0.userAgreeBtn3 = var_1.Find(var_77_0, "frame/raw1Btn")

	local var_77_1 = arg_77_0._tf

	arg_77_0.userAgreeBtn4 = var_1.Find(var_77_1, "frame/raw2Btn")

	return
end

function var_0_1.jpUIEnter(arg_78_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_JP = var_1_10002

	if var_1_10001 ~= var_1_10002 then
		return
	end

	onButton = var_1_10001

	local var_78_0 = arg_78_0
	local var_78_1 = arg_78_0.userAgreeBtn3

	local function var_78_2()
		require = var_2_10000

		local var_79_0 = var_2_10000("ShareCfg.UserAgreement3")
		local var_79_1 = arg_78_0
		local var_79_2 = var_1.emit

		NewShopMainMediator = var_2_10004

		var_79_2(var_79_1, var_2_10004.OPEN_USER_AGREE, var_79_0 or "")

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_78_0, var_78_1, var_78_2, var_1_10006)

	onButton = var_1_10001

	local var_78_3 = arg_78_0
	local var_78_4 = arg_78_0.userAgreeBtn4

	local function var_78_5()
		require = var_2_10000

		local var_80_0 = var_2_10000("ShareCfg.UserAgreement4")
		local var_80_1 = arg_78_0
		local var_80_2 = var_1.emit

		NewShopMainMediator = var_2_10004

		var_80_2(var_80_1, var_2_10004.OPEN_USER_AGREE, var_80_0 or "")

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_78_3, var_78_4, var_78_5, var_1_10006)

	return
end

function var_0_1.addRefreshTimer(arg_81_0, arg_81_1)
	(function()
		if arg_81_0.refreshTimer then
			local var_82_0 = arg_81_0.refreshTimer

			var_0.Stop(var_82_0)

			arg_81_0.refreshTimer = nil
		end

		return
	end)()

	Timer = var_3
	arg_81_0.refreshTimer = var_3.New(function()
		local var_83_0 = arg_81_1 + 1

		pg = var_2_10001

		local var_83_1 = var_2_10001.TimeMgr.GetInstance()

		if var_83_0 - var_1.GetServerTime(var_83_1) <= 0 then
			var_0()

			local var_83_2 = arg_81_0
			local var_83_3 = var_1.emit

			NewShopMainMediator = var_2_10004

			var_83_3(var_83_2, var_2_10004.GET_CHARGE_LIST)
		end

		return
	end, 1, -1)

	local var_81_0 = arg_81_0.refreshTimer

	var_3.Start(var_81_0)
	arg_81_0.refreshTimer.func()

	return
end

return var_0_1
