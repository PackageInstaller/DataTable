class = var_0_10000

local var_0_0 = "ChargeMenuScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ChargeMenuUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	ShopsProxy = var_1_10004

	local var_2_0 = var_1_10002(var_1_10004)

	if var_2.ShouldRefreshChargeList(var_2_0) then
		pg = var_2

		local var_2_1 = var_2.m02
		local var_2_2 = var_2.sendNotification

		GAME = var_1_10005

		var_2_2(var_2_1, var_1_10005.GET_CHARGE_LIST, {
			callback = arg_2_1
		})
	else
		arg_2_1()
	end

	return
end

function var_0_1.init(arg_3_0)
	arg_3_0:initData()
	arg_3_0:findUI()
	arg_3_0:addListener()
	arg_3_0:initUIText()
	arg_3_0:InitBanner()

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:updatePlayerRes()
	arg_4_0:updatePanel()
	arg_4_0:tryAutoOpenShop()

	return
end

function var_0_1.ResUISettings(arg_5_0)
	return true
end

function var_0_1.onBackPressed(arg_6_0)
	if arg_6_0.chargeTipWindow then
		local var_6_0 = arg_6_0.chargeTipWindow

		if var_1.GetLoaded(var_6_0) then
			local var_6_1 = arg_6_0.chargeTipWindow

			if var_1.isShowing(var_6_1) then
				local var_6_2 = arg_6_0.chargeTipWindow

				var_1.Hide(var_6_2)

				return
			end
		end
	end

	var_0_1.super.onBackPressed(arg_6_0)

	return
end

function var_0_1.willExit(arg_7_0)
	if arg_7_0.bannerRect then
		local var_7_0 = arg_7_0.bannerRect

		var_1.Dispose(var_7_0)

		arg_7_0.bannerRect = nil
	end

	if arg_7_0.chargeOrPurchaseHandler then
		local var_7_1 = arg_7_0.chargeOrPurchaseHandler

		var_1.Dispose(var_7_1)

		arg_7_0.chargeOrPurchaseHandler = nil
	end

	if arg_7_0.chargeTipWindow then
		local var_7_2 = arg_7_0.chargeTipWindow

		var_1.Destroy(var_7_2)

		arg_7_0.chargeTipWindow = nil
	end

	return
end

function var_0_1.initData(arg_8_0)
	return
end

function var_0_1.initUIText(arg_9_0)
	return
end

function var_0_1.findUI(arg_10_0)
	local var_10_0 = arg_10_0._tf

	arg_10_0.blurTF = var_1.Find(var_10_0, "blur_panel")

	local var_10_1 = arg_10_0.blurTF

	arg_10_0.topTF = var_1.Find(var_10_1, "adapt/top")

	local var_10_2 = arg_10_0.topTF

	arg_10_0.resTF = var_1.Find(var_10_2, "res")

	local var_10_3 = arg_10_0.topTF

	arg_10_0.backBtn = var_1.Find(var_10_3, "back_button")

	local var_10_4 = arg_10_0._tf

	arg_10_0.menuTF = var_1.Find(var_10_4, "menu_screen")

	local var_10_5 = arg_10_0.menuTF

	arg_10_0.skinShopBtn = var_1.Find(var_10_5, "skin_shop")

	local var_10_6 = arg_10_0.menuTF

	arg_10_0.skinLockIcon = var_1.Find(var_10_6, "skin_lock")
	LOCK_SKIN_SHOP_ENTER = var_10_8

	local var_10_8

	if var_10_8 then
		getProxy = var_10_8
		PlayerProxy = var_10_6

		local var_10_7 = var_10_8(var_10_6)

		var_10_8 = var_10_8.getData(var_10_7).level
		LOCK_SKIN_SHOP_ENTER_LEVEL = var_1_10002
		var_10_8 = var_10_8 < var_1_10002
	end

	setActive = var_1_10002

	var_1_10002(arg_10_0.skinShopBtn, not var_10_8)

	setActive = var_1_10002

	var_1_10002(arg_10_0.skinLockIcon, var_10_8)

	local var_10_9 = arg_10_0.menuTF

	arg_10_0.diamondShopBtn = var_2.Find(var_10_9, "dimond_shop")

	local var_10_10 = arg_10_0.menuTF

	arg_10_0.itemShopBtn = var_2.Find(var_10_10, "props")

	local var_10_11 = arg_10_0.menuTF

	arg_10_0.giftShopBtn = var_2.Find(var_10_11, "gift_shop")

	local var_10_12 = arg_10_0.menuTF

	arg_10_0.supplyShopBtn = var_2.Find(var_10_12, "supply")

	local var_10_13 = arg_10_0.diamondShopBtn

	arg_10_0.monthCardTag = var_2.Find(var_10_13, "monthcard_tag")

	local var_10_14 = arg_10_0.giftShopBtn

	arg_10_0.giftTag = var_2.Find(var_10_14, "tip")
	BannerScrollRect = var_2

	local var_10_15 = var_2.New
	local var_10_16 = arg_10_0._tf
	local var_10_17 = var_4.Find(var_10_16, "menu_screen/banner/mask/content")
	local var_10_18 = arg_10_0._tf

	arg_10_0.bannerRect = var_10_15(var_10_17, var_5.Find(var_10_18, "menu_screen/banner/dots"))
	ChargeOrPurchaseHandler = var_2
	arg_10_0.chargeOrPurchaseHandler = var_2.New()
	ChargeTipWindow = var_2
	arg_10_0.chargeTipWindow = var_2.New(arg_10_0._tf, arg_10_0.event)

	return
end

local function var_0_2(arg_11_0, arg_11_1, arg_11_2)
	setText = var_1_10003

	var_1_10003(arg_11_1:Find("name"), arg_11_2:GetName())

	setText = var_1_10003

	var_1_10003(arg_11_1:Find("desc"), arg_11_2:GetDesc())

	local var_11_0 = arg_11_2:GetDropList()

	UIItemList = var_1_10004

	local var_11_1 = var_1_10004.New(arg_11_1:Find("items"), arg_11_1:Find("items/award"))

	var_4.make(var_11_1, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = var_11_0[arg_12_1 + 1]

			updateDrop = var_4

			var_4(arg_12_2, var_12_0)

			onButton = var_4

			local var_12_1 = arg_11_0
			local var_12_2 = arg_12_2

			local function var_12_3()
				local var_13_0 = arg_11_0
				local var_13_1 = var_0.emit

				BaseUI = var_3_10003

				var_13_1(var_13_0, var_3_10003.ON_DROP, var_12_0)

				return
			end

			SFX_PANEL = var_2_10009

			var_4(var_12_1, var_12_2, var_12_3, var_2_10009)
		end

		return
	end)
	var_4:align(#var_11_0)

	local var_11_2 = arg_11_2:GetGem()

	setActive = var_6

	var_6(arg_11_1:Find("gem"), var_11_2 > 0)

	setText = var_6

	local var_11_3 = arg_11_1

	var_6(arg_11_1.Find(var_11_3, "gem/Text"), var_11_2)

	local var_11_4, var_11_5, var_11_6 = arg_11_2:GetPrice()

	setText = var_9

	var_9(arg_11_1:Find("price/Text"), var_11_5)

	setActive = var_9

	local var_11_7 = arg_11_1:Find("price/Text/icon")

	RecommendCommodity = var_12

	var_9(var_11_7, var_11_4 ~= var_12.PRICE_TYPE_RMB)

	setText = var_9

	local var_11_8 = arg_11_1:Find("price/Text/label")

	RecommendCommodity = var_12

	if var_11_4 == var_12.PRICE_TYPE_RMB then
		GetMoneySymbol = var_12

		local var_11_9

		if not var_12() then
			var_11_9 = ""
		end

		var_9(var_11_8, var_11_9)

		local var_11_10 = arg_11_1:Find("icon")

		GetSpriteFromAtlasAsync = var_11_3

		var_11_3(arg_11_2:GetIcon(), "", function(arg_14_0)
			setImageSprite = var_2_10001

			var_2_10001(var_11_10, arg_14_0)

			return
		end)

		Vector2 = var_11_3
		var_11_10.sizeDelta = var_11_3(180, 180)

		return
	end
end

function var_0_1.InitBanner(arg_15_0)
	getProxy = var_1_10001
	ShopsProxy = var_1_10003

	local var_15_0 = var_1_10001(var_1_10003)
	local var_15_1 = var_1.GetRecommendCommodities(var_15_0)

	ipairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(var_15_1) do
		local var_15_2 = arg_15_0.bannerRect
		local var_15_3 = var_7.AddChild(var_15_2)

		var_0_2(arg_15_0, var_15_3, iter_15_1)

		onButton = var_8

		local var_15_4 = arg_15_0
		local var_15_5 = var_15_3

		local function var_15_6()
			local var_16_0 = iter_15_1
			local var_16_1, var_16_2 = var_0.IsMonthCardAndCantPurchase(var_16_0)

			if var_16_1 then
				pg = var_16_0

				local var_16_3 = var_16_0.TipsMgr.GetInstance()

				var_2.ShowTips(var_16_3, var_16_2)

				return
			end

			local var_16_4 = arg_15_0.bannerRect

			var_2.Pause(var_16_4)

			local var_16_5 = arg_15_0

			var_16_5.lookUpIndex = iter_15_0
			pg = var_16_5

			local var_16_6 = var_16_5.m02
			local var_16_7 = var_2.sendNotification

			GAME = var_2_10005

			local var_16_8 = var_2_10005.TRACK

			TrackConst = var_2_10006

			local var_16_9 = var_2_10006.GetTrackData

			TrackConst = var_2_10008

			local var_16_10 = var_2_10008.SYSTEM_SHOP

			TrackConst = var_2_10009

			var_16_7(var_16_6, var_16_8, var_16_9(var_16_10, var_2_10009.ACTION_LOOKUP_RECOMMEND, iter_15_0))

			local var_16_11 = arg_15_0.chargeOrPurchaseHandler
			local var_16_12 = var_2.ChargeOrPurchaseAsyn
			local var_16_13 = iter_15_1

			var_16_12(var_16_11, var_5.GetRealCommodity(var_16_13))

			return
		end

		SFX_PANEL = var_1_10013

		var_8(var_15_4, var_15_5, var_15_6, var_1_10013)
	end

	local var_15_7 = arg_15_0.bannerRect

	var_2.SetUp(var_15_7)

	return
end

function var_0_1.FlushBanner(arg_17_0)
	local var_17_0 = arg_17_0.bannerRect

	var_1.Reset(var_17_0)
	arg_17_0:InitBanner()

	return
end

function var_0_1.addListener(arg_18_0)
	onButton = var_1_10001

	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.backBtn

	local function var_18_2()
		local var_19_0 = arg_18_0

		var_0.closeView(var_19_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_18_0, var_18_1, var_18_2, var_1_10006)

	onButton = var_1_10001

	local var_18_3 = arg_18_0
	local var_18_4 = arg_18_0.skinShopBtn

	local function var_18_5()
		local var_20_0 = arg_18_0
		local var_20_1 = var_0.emit

		ChargeMenuMediator = var_2_10003

		var_20_1(var_20_0, var_2_10003.GO_SKIN_SHOP)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_18_3, var_18_4, var_18_5, var_1_10006)

	onButton = var_1_10001

	local var_18_6 = arg_18_0
	local var_18_7 = arg_18_0.diamondShopBtn

	local function var_18_8()
		local var_21_0 = arg_18_0
		local var_21_1 = var_0.emit

		ChargeMenuMediator = var_2_10003

		local var_21_2 = var_2_10003.GO_CHARGE_SHOP

		ChargeScene = var_2_10004

		var_21_1(var_21_0, var_21_2, var_2_10004.TYPE_DIAMOND)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_18_6, var_18_7, var_18_8, var_1_10006)

	onButton = var_1_10001

	local var_18_9 = arg_18_0
	local var_18_10 = arg_18_0.giftShopBtn

	local function var_18_11()
		local var_22_0 = arg_18_0
		local var_22_1 = var_0.emit

		ChargeMenuMediator = var_2_10003

		local var_22_2 = var_2_10003.GO_CHARGE_SHOP

		ChargeScene = var_2_10004

		var_22_1(var_22_0, var_22_2, var_2_10004.TYPE_GIFT)

		isActive = var_22_1

		local var_22_3 = var_22_1(arg_18_0.giftTag)

		pg = var_2_10001

		local var_22_4 = var_2_10001.m02
		local var_22_5 = var_1.sendNotification

		GAME = var_4

		local var_22_6 = var_4.TRACK

		TrackConst = var_2_10005

		local var_22_7 = var_2_10005.GetTrackData

		TrackConst = var_2_10007

		local var_22_8 = var_2_10007.SYSTEM_SHOP

		TrackConst = var_2_10008

		var_22_5(var_22_4, var_22_6, var_22_7(var_22_8, var_2_10008.ACTION_ENTER_GIFT, var_22_3))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_18_9, var_18_10, var_18_11, var_1_10006)

	onButton = var_1_10001

	local var_18_12 = arg_18_0
	local var_18_13 = arg_18_0.itemShopBtn

	local function var_18_14()
		local var_23_0 = arg_18_0
		local var_23_1 = var_0.emit

		ChargeMenuMediator = var_2_10003

		local var_23_2 = var_2_10003.GO_CHARGE_SHOP

		ChargeScene = var_2_10004

		var_23_1(var_23_0, var_23_2, var_2_10004.TYPE_ITEM)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_18_12, var_18_13, var_18_14, var_1_10006)

	onButton = var_1_10001

	local var_18_15 = arg_18_0
	local var_18_16 = arg_18_0.supplyShopBtn

	local function var_18_17()
		local var_24_0 = arg_18_0
		local var_24_1 = var_0.emit

		ChargeMenuMediator = var_2_10003

		local var_24_2 = var_2_10003.GO_SUPPLY_SHOP
		local var_24_3 = {}

		NewShopsScene = var_2_10005
		var_24_3.warp = var_2_10005.TYPE_ACTIVITY

		var_24_1(var_24_0, var_24_2, var_24_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_18_15, var_18_16, var_18_17, var_1_10006)

	return
end

function var_0_1.updatePlayerRes(arg_25_0)
	return
end

function var_0_1.updatePanel(arg_26_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_26_0 = var_1_10001(var_1_10003)
	local var_26_1 = var_1.getActiveBannerByType

	GAMEUI_BANNER_9 = var_1_10005

	if var_26_1(var_26_0, var_1_10005) ~= nil then
		LoadImageSpriteAsync = var_1_10003

		var_1_10003("activitybanner/" .. var_2.pic, arg_26_0.skinShopBtn)
	end

	local var_26_2 = var_1
	local var_26_3 = var_1.getActiveBannerByType

	GAMEUI_BANNER_11 = var_1_10006

	if var_26_3(var_26_2, var_1_10006) ~= nil then
		LoadImageSpriteAsync = var_26_0

		local var_26_4 = "activitybanner/" .. var_3.pic
		local var_26_5 = arg_26_0.giftShopBtn

		var_26_0(var_26_4, var_7.Find(var_26_5, "BG"))
	end

	MonthCardOutDateTipPanel = var_26_0

	local var_26_6 = var_26_0.GetShowMonthCardTag()

	setActive = var_26_2

	var_26_2(arg_26_0.monthCardTag, var_26_6)

	MonthCardOutDateTipPanel = var_26_2

	var_26_2.SetMonthCardTagDate()

	TagTipHelper = var_5

	var_5.SetFuDaiTagMark()

	TagTipHelper = var_5

	var_5.SetSkinTagMark()

	TagTipHelper = var_5

	var_5.FreeGiftTag({
		arg_26_0.giftTag
	})

	return
end

function var_0_1.tryAutoOpenShop(arg_27_0)
	if arg_27_0.contextData.warp ~= nil then
		ChargeScene = var_1_10002

		if var_1 == var_1_10002.TYPE_DIAMOND then
			triggerButton = var_2

			var_2(arg_27_0.diamondShopBtn)
		else
			ChargeScene = var_2

			if var_1 == var_2.TYPE_GIFT then
				triggerButton = var_2

				var_2(arg_27_0.giftShopBtn)
			else
				ChargeScene = var_2

				if var_1 == var_2.TYPE_ITEM then
					triggerButton = var_2

					var_2(arg_27_0.itemShopBtn)
				end
			end
		end
	end

	return
end

function var_0_1.OnRemoveLayer(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1.mediator

	ChargeItemPanelMediator = var_1_10003

	if var_28_0 == var_1_10003 and arg_28_0.bannerRect then
		local var_28_1 = arg_28_0.bannerRect

		var_2.Resume(var_28_1)
	end

	return
end

function var_0_1.OnChargeSuccess(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.chargeTipWindow

	var_2.ExecuteAction(var_29_0, "Show", arg_29_1)

	return
end

return var_0_1
