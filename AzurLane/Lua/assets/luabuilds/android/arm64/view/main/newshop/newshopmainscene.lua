local var_0_0 = class("NewShopMainScene", import("...base.BaseUI"))

var_0_0.CLOSE_ALL_LAYER = "NewShopMainScene.CLOSE_ALL_LAYER"
var_0_0.SHOW_OR_HIDE_UI = "NewShopMainScene.SHOW_OR_HIDE_UI"
var_0_0.SHOW_OR_HIDE_UI_2 = "NewShopMainScene.SHOW_OR_HIDE_UI_2"
var_0_0.CLOSE_VIEW = "NewShopMainScene.CLOSE_VIEW"
var_0_0.TYPE_CHARGE = "charge"
var_0_0.TYPE_SKIN = "skin"
var_0_0.ON_CLICK_SKIN_SHOP = "NewShopMainScene::ON_CLICK_SKIN_SHOP"

function var_0_0.getUIName(arg_1_0)
	return "NewShopUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	local var_2_0 = getProxy(ShopsProxy)

	if getProxy(ShopsProxy):ShouldRefreshChargeList() then
		pg.m02:sendNotification(GAME.GET_CHARGE_LIST, {
			callback = function()
				local var_3_0 = var_2_0:getFirstChargeList()
				local var_3_1 = var_2_0:getChargedList()
				local var_3_2 = var_2_0:GetNormalList()
				local var_3_3 = var_2_0:GetNormalGroupList()

				if var_3_0 then
					arg_2_0:setFirstChargeIds(var_3_0)
				end

				if var_3_1 then
					arg_2_0:setChargedList(var_3_1)
				end

				if var_3_2 then
					arg_2_0:setNormalList(var_3_2)
				end

				if var_3_3 then
					arg_2_0:setNormalGroupList(var_3_3)
				end

				arg_2_1()

				return
			end
		})
	else
		(function()
			local var_3_0 = var_2_0:getFirstChargeList()
			local var_3_1 = var_2_0:getChargedList()
			local var_3_2 = var_2_0:GetNormalList()
			local var_3_3 = var_2_0:GetNormalGroupList()

			if var_3_0 then
				arg_2_0:setFirstChargeIds(var_3_0)
			end

			if var_3_1 then
				arg_2_0:setChargedList(var_3_1)
			end

			if var_3_2 then
				arg_2_0:setNormalList(var_3_2)
			end

			if var_3_3 then
				arg_2_0:setNormalGroupList(var_3_3)
			end

			arg_2_1()

			return
		end)()
	end

	return
end

function var_0_0.init(arg_4_0)
	local var_4_0 = arg_4_0._tf:Find("buttonList")

	arg_4_0.buttonList = var_4_0
	arg_4_0.backBtn = var_4_0:Find("top/closeBtn")
	arg_4_0.homeBtn = var_4_0:Find("top/homeBtn")
	arg_4_0.resourcePanel = var_4_0:Find("top/resources")

	setActive(arg_4_0.resourcePanel, false)

	arg_4_0.goldBtn = var_4_0:Find("top/resources/gold")
	arg_4_0.goldText = var_4_0:Find("top/resources/gold/Text"):GetComponent(typeof(Text))
	arg_4_0.goldMax = var_4_0:Find("top/resources/gold/max"):GetComponent(typeof(Text))
	arg_4_0.oilBtn = var_4_0:Find("top/resources/oil")
	arg_4_0.oilText = var_4_0:Find("top/resources/oil/Text"):GetComponent(typeof(Text))
	arg_4_0.oilMax = var_4_0:Find("top/resources/oil/max"):GetComponent(typeof(Text))
	arg_4_0.diamondBtn = var_4_0:Find("top/resources/gem")
	arg_4_0.diamondText = var_4_0:Find("top/resources/gem/Text"):GetComponent(typeof(Text))

	setText(var_4_0:Find("top/title/Text"), i18n("shop_title"))
	setText(var_4_0:Find("shop1List/recommendation/shop1Tg/name"), i18n("shop_recommend"))
	setText(var_4_0:Find("shop1List/skinShop/shop1Tg/name"), i18n("shop_skin"))
	setText(var_4_0:Find("shop1List/diamondShop/shop1Tg/name"), i18n("shop_diamond_title"))
	setText(var_4_0:Find("shop1List/specialShop/shop1Tg/name"), i18n("shop_akashi_pick_title"))
	setText(var_4_0:Find("shop1List/giftPackShop/shop1Tg/name"), i18n("shop_gift_title"))
	setText(var_4_0:Find("shop1List/functionalItemShop/shop1Tg/name"), i18n("shop_item_title"))
	setText(var_4_0:Find("shop1List/supplyShop/shop1Tg/name"), i18n("shop_supply_prop"))
	setText(var_4_0:Find("shop1List/recommendation/shop1Tg/name/en"), i18n("shop_recommend_en"))
	setText(var_4_0:Find("shop1List/skinShop/shop1Tg/name/en"), i18n("shop_skin_en"))
	setText(var_4_0:Find("shop1List/diamondShop/shop1Tg/name/en"), i18n("shop_diamond_title_en"))
	setText(var_4_0:Find("shop1List/specialShop/shop1Tg/name/en"), i18n("shop_side_lable_en"))
	setText(var_4_0:Find("shop1List/giftPackShop/shop1Tg/name/en"), i18n("shop_gift_title_en"))
	setText(var_4_0:Find("shop1List/functionalItemShop/shop1Tg/name/en"), i18n("shop_item_title_en"))
	setText(var_4_0:Find("shop1List/supplyShop/shop1Tg/name/en"), i18n("shop_supply_prop_en"))
	setText(var_4_0:Find("shop1List/supplyShop/shop2List/monthShop/name"), i18n("shop_month"))
	setText(var_4_0:Find("shop1List/supplyShop/shop2List/monthShop/selected/name"), i18n("shop_month"))
	setText(var_4_0:Find("shop1List/supplyShop/shop2List/supplyShop/name"), i18n("shop_supply"))
	setText(var_4_0:Find("shop1List/supplyShop/shop2List/supplyShop/selected/name"), i18n("shop_supply"))
	setText(var_4_0:Find("shop1List/supplyShop/shop2List/activityShop/name"), i18n("shop_activity"))
	setText(var_4_0:Find("shop1List/supplyShop/shop2List/activityShop/selected/name"), i18n("shop_activity"))

	arg_4_0.frame = arg_4_0._tf:Find("frame")
	arg_4_0.viewContainer = arg_4_0._tf:Find("viewContainer")
	arg_4_0.painting = arg_4_0._tf:Find("frame/painting")
	arg_4_0.chat = arg_4_0._tf:Find("frame/chat")
	arg_4_0.chatText = arg_4_0.chat:Find("Text")
	arg_4_0.stamp = arg_4_0._tf:Find("frame/stamp")
	arg_4_0.specialTip = var_4_0:Find("shop1List/specialShop/shop1Tg/tip")
	arg_4_0.giftTip = var_4_0:Find("shop1List/giftPackShop/shop1Tg/tip")

	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(arg_4_0.specialTip, {
		"specialShop",
		"Charge_Page_Exposure"
	}, function(arg_5_0)
		getProxy(ShopsProxy):GiftPackageRedDotTip({
			arg_5_0
		}, true)

		return
	end)
	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(arg_4_0.giftTip, {
		"specialShop",
		"Charge_Page_Exposure"
	}, function(arg_6_0)
		getProxy(ShopsProxy):GiftPackageRedDotTip({
			arg_6_0
		}, false)

		return
	end)

	arg_4_0.toggleList = {
		{
			type = ChargeScene.TYPE_DIAMOND,
			go = var_4_0:Find("shop1List/diamondShop/shop1Tg")
		},
		{
			type = ChargeScene.TYPE_GIFT,
			go = var_4_0:Find("shop1List/giftPackShop/shop1Tg")
		},
		{
			type = ChargeScene.TYPE_ITEM,
			go = var_4_0:Find("shop1List/functionalItemShop/shop1Tg")
		},
		{
			type = ChargeScene.TYPE_PICK,
			go = var_4_0:Find("shop1List/specialShop/shop1Tg")
		}
	}
	GetComponent(var_4_0:Find("shop1List/supplyShop/shop2List/supplyShop"), typeof(Toggle)).isOn = true
	arg_4_0.chargeTipWindow = ChargeTipWindow.New(arg_4_0._tf, arg_4_0.event)

	arg_4_0:LoadMingshi()
	arg_4_0:jpUIInit()
	arg_4_0:blurView()
	arg_4_0:initSubView()

	arg_4_0.bulinTip = AprilFoolBulinSubView.ShowAprilFoolBulin(arg_4_0, arg_4_0.pageContainer, Vector2.New(-35, -90))

	if arg_4_0.bulinTip then
		arg_4_0.bulinTip:RegisterView(arg_4_0)
		arg_4_0.bulinTip:CallbackInvoke(function()
			arg_4_0:OverlayPanel(arg_4_0.bulinTip._tf, {
				groupDelta = 1
			})

			return
		end)

		function arg_4_0.bulinTip.destroyCall()
			if arg_4_0.bulinTip:GetLoaded() then
				arg_4_0:UnOverlayPanel(arg_4_0.bulinTip._tf)
			end

			return
		end
	end

	return
end

function var_0_0.setPlayer(arg_9_0, arg_9_1)
	arg_9_0.player = arg_9_1

	if arg_9_0.subViewList[arg_9_0.curSubViewNum] and arg_9_0.subViewList[arg_9_0.curSubViewNum]:IsSupplyShop() then
		arg_9_0.subViewList[arg_9_0.curSubViewNum]:SetPlayer(arg_9_1)
	end

	if arg_9_0.goldMax then
		PlayerResUI.StaticFlush(arg_9_0.player, arg_9_0.goldMax, arg_9_0.goldText, arg_9_0.oilMax, arg_9_0.oilText, arg_9_0.diamondText)
	end

	return
end

function var_0_0.setFirstChargeIds(arg_10_0, arg_10_1)
	arg_10_0.firstChargeIds = arg_10_1

	return
end

function var_0_0.setChargedList(arg_11_0, arg_11_1)
	arg_11_0.chargedList = arg_11_1

	return
end

function var_0_0.setNormalList(arg_12_0, arg_12_1)
	arg_12_0.normalList = arg_12_1

	return
end

function var_0_0.setNormalGroupList(arg_13_0, arg_13_1)
	arg_13_0.normalGroupList = arg_13_1

	arg_13_0:addRefreshTimer(GetZeroTime())

	return
end

function var_0_0.SetSupplyShopList(arg_14_0, arg_14_1)
	arg_14_0.supplyShopList = arg_14_1

	arg_14_0:SortActivityShops()

	return
end

function var_0_0.SortActivityShops(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.supplyShopList) do
		if #iter_15_1 > 1 then
			table.sort(iter_15_1, function(arg_16_0, arg_16_1)
				return arg_16_0:getStartTime() > arg_16_1:getStartTime()
			end)
		end
	end

	return
end

function var_0_0.OnInitItems(arg_17_0, arg_17_1)
	arg_17_0.items = arg_17_1

	arg_17_0.subViewList[ShopConst.SHOP_ID.MONTH]:OnUpdateItems(arg_17_1)
	arg_17_0.subViewList[ShopConst.SHOP_ID.SUPPLY]:OnUpdateItems(arg_17_1)
	arg_17_0.subViewList[ShopConst.SHOP_ID.ACTIVITY]:OnUpdateItems(arg_17_1)

	return
end

function var_0_0.OnUpdateItems(arg_18_0, arg_18_1)
	arg_18_0.items = arg_18_1

	if arg_18_0.subViewList[arg_18_0.curSubViewNum] and arg_18_0.subViewList[arg_18_0.curSubViewNum]:IsSupplyShop() then
		arg_18_0.subViewList[arg_18_0.curSubViewNum]:OnUpdateItems(arg_18_1)
	end

	return
end

function var_0_0.OnUpdateShop(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0:SetShop(arg_19_1, arg_19_2)

	if arg_19_0.subViewList[arg_19_0.curSubViewNum] and arg_19_0.subViewList[arg_19_0.curSubViewNum]:IsSupplyShop() then
		arg_19_0.subViewList[arg_19_0.curSubViewNum]:OnUpdateShop(arg_19_1, arg_19_2)
	end

	return
end

function var_0_0.OnUpdateCommodity(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0:SetShop(arg_20_1, arg_20_2)

	if arg_20_0.subViewList[arg_20_0.curSubViewNum] and arg_20_0.subViewList[arg_20_0.curSubViewNum]:IsSupplyShop() then
		arg_20_0.subViewList[arg_20_0.curSubViewNum]:OnUpdateCommodity(arg_20_1, arg_20_2, arg_20_3)
	end

	return
end

function var_0_0.OnFragmentSellUpdate(arg_21_0)
	if arg_21_0.subViewList[arg_21_0.curSubViewNum] and arg_21_0.subViewList[arg_21_0.curSubViewNum]:IsSupplyShop() then
		arg_21_0.subViewList[arg_21_0.curSubViewNum]:OnFragmentSellUpdate()
	end

	return
end

function var_0_0.SetShop(arg_22_0, arg_22_1, arg_22_2)
	if not arg_22_0.supplyShopList then
		return
	end

	local var_22_0 = arg_22_0.supplyShopList[arg_22_1]

	if arg_22_0.supplyShopList[arg_22_1] then
		for iter_22_0, iter_22_1 in ipairs(var_22_0) do
			if iter_22_1:IsSameKind(arg_22_2) then
				arg_22_0.supplyShopList[arg_22_1][iter_22_0] = arg_22_2

				break
			end
		end
	end

	return
end

function var_0_0.didEnter(arg_23_0)
	arg_23_0.eventIDList = {
		arg_23_0:bind(var_0_0.ON_CLICK_SKIN_SHOP, handler(arg_23_0, arg_23_0.OnClickSkinShop))
	}

	setActive(arg_23_0.chat, false)
	onButton(arg_23_0, arg_23_0.backBtn, function()
		arg_23_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_23_0, arg_23_0.homeBtn, function()
		arg_23_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_CANCEL)
	onButton(arg_23_0, arg_23_0.goldBtn, function()
		pg.playerResUI:ClickGold()

		return
	end, SFX_PANEL)
	onButton(arg_23_0, arg_23_0.oilBtn, function()
		pg.playerResUI:ClickOil()

		return
	end, SFX_PANEL)
	onButton(arg_23_0, arg_23_0.diamondBtn, function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)
	onToggle(arg_23_0, arg_23_0.buttonList:Find("shop1List/recommendation/shop1Tg"), function(arg_29_0)
		if arg_29_0 then
			arg_23_0.contextData.shop1 = nil
			arg_23_0.contextData.shop2 = nil

			if arg_23_0.shop1 == "recommendation" then
				return
			end

			arg_23_0.shop1 = "recommendation"
			arg_23_0.shop2 = nil

			arg_23_0:ShowChargeWarp(false)
			pg.m02:sendNotification(var_0_0.CLOSE_ALL_LAYER)
			arg_23_0:emit(NewShopMainMediator.OPEN_LAYER, NewRecommendationShopLayer, NewRecommendationShopMediator)
		end

		return
	end, SFX_PANEL)
	arg_23_0:InitSkinToggleList()

	for iter_23_0 = 1, #arg_23_0.toggleList do
		onToggle(arg_23_0, arg_23_0.toggleList[iter_23_0].go, function(arg_30_0)
			if arg_30_0 then
				arg_23_0:ShowChargeWarp(true)
				pg.m02:sendNotification(var_0_0.CLOSE_ALL_LAYER)

				arg_23_0.contextData.shop1 = nil
				arg_23_0.contextData.shop2 = nil
				arg_23_0.shop1 = nil
				arg_23_0.shop2 = nil

				originalPrint(string.format("Begin: toggleType=%s, goName=%s", var_0.type, var_0.go.parent.name))

				arg_23_0.contextData.type = ShopConst.SHOP_TYPE.CHARGE
				arg_23_0.contextData.warp = var_0.type

				originalPrint(string.format("End: warp=%s", arg_23_0.contextData.warp))
				arg_23_0:switchSubView((arg_23_0:GetShopID(ShopConst.SHOP_TYPE.CHARGE, var_0.type)))
			end

			local var_30_0 = switch(var_0.type, {
				[ChargeScene.TYPE_PICK] = function()
					return "payshop_pack_red_dot"
				end,
				[ChargeScene.TYPE_GIFT] = function()
					return "gemshop_pack_red_dot"
				end
			})

			if var_30_0 then
				if arg_30_0 then
					arg_23_0.toggleMark = arg_23_0.toggleMark or {}
					arg_23_0.toggleMark[var_0.type] = defaultValue(arg_23_0.toggleMark[var_0.type], 0) + 1
				elseif arg_23_0.toggleMark and defaultValue(arg_23_0.toggleMark[var_0.type], 0) > 0 then
					arg_23_0.toggleMark[var_0.type] = arg_23_0.toggleMark[var_0.type] - 1

					PlayerPrefs.SetInt(var_30_0, getGameset(var_30_0)[1])
					pg.EasyRedDotMgr.GetInstance():TriggerMarks("Charge_Page_Exposure")
				end
			end

			return
		end, SFX_PANEL)
	end

	onToggle(arg_23_0, arg_23_0.buttonList:Find("shop1List/supplyShop/shop1Tg"), function(arg_33_0)
		setActive(arg_23_0.buttonList:Find("shop1List/supplyShop/shop2List"), arg_33_0)

		if arg_33_0 then
			triggerToggle(arg_23_0.buttonList:Find("shop1List/supplyShop/shop2List/" .. arg_23_0:GetDefaultSupplyShopName()), true)
		end

		return
	end, SFX_PANEL)

	for iter_23_1, iter_23_2 in ipairs({
		{
			type = ShopConst.CATEGORY_MONTH,
			go = arg_23_0.buttonList:Find("shop1List/supplyShop/shop2List/monthShop")
		},
		{
			type = ShopConst.CATEGORY_SUPPLY,
			go = arg_23_0.buttonList:Find("shop1List/supplyShop/shop2List/supplyShop")
		},
		{
			type = ShopConst.CATEGORY_ACTIVITY,
			go = arg_23_0.buttonList:Find("shop1List/supplyShop/shop2List/activityShop")
		}
	}) do
		onToggle(arg_23_0, iter_23_2.go, function(arg_34_0)
			if arg_34_0 then
				arg_23_0:ShowChargeWarp(true)
				pg.m02:sendNotification(var_0_0.CLOSE_ALL_LAYER)

				arg_23_0.contextData.shop1 = nil
				arg_23_0.contextData.shop2 = nil
				arg_23_0.shop1 = nil
				arg_23_0.shop2 = nil
				arg_23_0.contextData.type = ShopConst.SHOP_TYPE.SUPPLY
				arg_23_0.contextData.warp = iter_23_2.type

				arg_23_0:switchSubView((arg_23_0:GetShopID(ShopConst.SHOP_TYPE.SUPPLY, iter_23_2.type)))
			end

			return
		end, SFX_PANEL)
	end

	local var_23_0 = "recommendation"

	if arg_23_0.contextData.type == ShopConst.SHOP_TYPE.CHARGE then
		var_23_0 = arg_23_0.contextData.warp == ChargeScene.TYPE_DIAMOND and "diamondShop" or arg_23_0.contextData.warp == ChargeScene.TYPE_GIFT and "giftPackShop" or arg_23_0.contextData.warp == ChargeScene.TYPE_ITEM and "functionalItemShop" or arg_23_0.contextData.warp == ChargeScene.TYPE_PICK and "specialShop" or "diamondShop"
	elseif arg_23_0.contextData.type == ShopConst.SHOP_TYPE.SKIN then
		var_23_0 = "skinShop"
	elseif arg_23_0.contextData.type == ShopConst.SHOP_TYPE.SUPPLY then
		var_23_0 = "supplyShop"
	end

	if arg_23_0.contextData.shop1 then
		var_23_0 = arg_23_0.contextData.shop1
	end

	triggerToggle(arg_23_0.buttonList:Find("shop1List/" .. var_23_0 .. "/shop1Tg"), true)

	if var_23_0 == "skinShop" then
		-- block empty
	elseif var_23_0 == "supplyShop" then
		triggerToggle(arg_23_0.buttonList:Find("shop1List/supplyShop/shop2List/" .. arg_23_0:GetDefaultSupplyShopName()), true)
	end

	onButton(arg_23_0, arg_23_0.painting, function()
		arg_23_0:displayShipWord()
		arg_23_0:emit(NewShopMainMediator.CLICK_MING_SHI)

		return
	end, SFX_PANEL)
	onButton(arg_23_0, arg_23_0.stamp, function()
		getProxy(TaskProxy):dealMingshiTouchFlag(4)

		return
	end, SFX_CONFIRM)
	arg_23_0:RefreshActivityShop()
	arg_23_0:updateNoRes()
	arg_23_0:jpUIEnter()

	return
end

function var_0_0.GetDefaultSupplyShopName(arg_37_0)
	if arg_37_0.contextData.type ~= ShopConst.SHOP_TYPE.SUPPLY then
		return "supplyShop"
	end

	local var_37_0 = arg_37_0.contextData.warp

	if type(arg_37_0.contextData.warp) == "string" then
		arg_37_0.contextData.warp = ShopConst.SHOP_NAME_LIST[var_37_0][1]
		arg_37_0.contextData.shopID = ShopConst.SHOP_NAME_LIST[var_37_0][2]
	elseif type(var_37_0) == "number" and arg_37_0.contextData.shopID == nil then
		for iter_37_0, iter_37_1 in pairs(ShopConst.SUPPLY_SHOP_LIST) do
			for iter_37_2, iter_37_3 in pairs(iter_37_1) do
				if iter_37_3 == var_37_0 then
					arg_37_0.contextData.warp = iter_37_0
					arg_37_0.contextData.shopID = iter_37_3

					break
				end
			end
		end
	end

	return arg_37_0.contextData.warp == ShopConst.CATEGORY_MONTH and "monthShop" or arg_37_0.contextData.warp == ShopConst.CATEGORY_SUPPLY and "supplyShop" or arg_37_0.contextData.warp == ShopConst.CATEGORY_ACTIVITY and "activityShop" or "supplyShop"
end

function var_0_0.RefreshActivityShop(arg_38_0)
	local var_38_0 = arg_38_0.supplyShopList[ShopConst.TYPE_ACTIVITY] or {}

	setActive(arg_38_0.buttonList:Find("shop1List/supplyShop/shop2List/activityShop"), #var_38_0 > 0)

	return
end

function var_0_0.ShowOrHideUI(arg_39_0, arg_39_1)
	arg_39_0:setVisible(arg_39_1)
	setActive(arg_39_0.buttonList, arg_39_1)

	return
end

function var_0_0.ShowOrHideUI2(arg_40_0, arg_40_1)
	for iter_40_0 = 0, arg_40_0._tf.childCount - 1 do
		setActive(arg_40_0._tf:GetChild(iter_40_0), arg_40_1)
	end

	setActive(arg_40_0.buttonList:Find("leftBg"), arg_40_1)
	setActive(arg_40_0.buttonList:Find("shop1List"), arg_40_1)
	setActive(arg_40_0.buttonList:Find("top"), true)

	return
end

function var_0_0.OnChargeSuccess(arg_41_0, arg_41_1)
	arg_41_0.chargeTipWindow:ExecuteAction("Show", arg_41_1)

	return
end

function var_0_0.LoadMingshi(arg_42_0)
	if Live2dConst.GetLive2DArm32MatchAble() then
		local var_42_0 = Ship.New({
			configId = 312011
		}):getPainting()

		LoadPaintingPrefabAsync(arg_42_0.painting, var_42_0, var_42_0, "mainNormal", function()
			arg_42_0.loading = false

			return
		end)
	else
		arg_42_0:createLive2D()
	end

	arg_42_0:AddLive2dTimer()

	return
end

function var_0_0.AddLive2dTimer(arg_44_0)
	arg_44_0:StopLive2dTimer()

	arg_44_0.live2dTimer = Timer.New(function()
		local var_45_0 = pg.ChargeShipTalkInfo.Actions[math.random(#pg.ChargeShipTalkInfo.Actions)]

		if arg_44_0:checkBuyDone(var_45_0.action) then
			arg_44_0:displayShipWord(nil, false, var_45_0.dialog_index)
		end

		return
	end, 20, -1)

	arg_44_0.live2dTimer:Start()

	return
end

function var_0_0.StopLive2dTimer(arg_46_0)
	if arg_46_0.live2dTimer then
		arg_46_0.live2dTimer:Stop()

		arg_46_0.live2dTimer = nil
	end

	return
end

function var_0_0.ShowChargeWarp(arg_47_0, arg_47_1)
	setActive(arg_47_0.frame, arg_47_1)
	setActive(arg_47_0.viewContainer, arg_47_1)
	arg_47_0:ShowResourceBar(arg_47_1)

	if arg_47_0.subViewList[arg_47_0.curSubViewNum] then
		if arg_47_1 == false then
			arg_47_0.subViewList[arg_47_0.curSubViewNum]:Destroy()

			arg_47_0.curSubViewNum = 0
		else
			arg_47_0.subViewList[arg_47_0.curSubViewNum]:ShowPanel(arg_47_1)
		end
	end

	return
end

function var_0_0.ShowResourceBar(arg_48_0, arg_48_1)
	if arg_48_0.resourceBarFlag == arg_48_1 then
		return
	end

	arg_48_0.resourceBarFlag = arg_48_1

	setActive(arg_48_0.resourcePanel, arg_48_1)

	return
end

function var_0_0.willExit(arg_49_0)
	for iter_49_0, iter_49_1 in ipairs(arg_49_0.eventIDList) do
		arg_49_0:disconnect(iter_49_1)
	end

	arg_49_0.eventIDList = nil

	if arg_49_0.bulinTip then
		arg_49_0.bulinTip:Destroy()

		arg_49_0.bulinTip = nil
	end

	pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(arg_49_0.specialTip)
	pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(arg_49_0.giftTip)

	if arg_49_0.toggleMark then
		for iter_49_2, iter_49_3 in pairs(arg_49_0.toggleMark) do
			if iter_49_3 > 0 then
				local var_49_0 = switch(iter_49_2, {
					[ChargeScene.TYPE_PICK] = function()
						return "payshop_pack_red_dot"
					end,
					[ChargeScene.TYPE_GIFT] = function()
						return "gemshop_pack_red_dot"
					end
				})

				PlayerPrefs.SetInt(var_49_0, getGameset(var_49_0)[1])
			end
		end

		arg_49_0.toggleMark = nil
	end

	arg_49_0:ShowResourceBar()
	arg_49_0:unBlurView()

	if arg_49_0.chargeTipWindow then
		arg_49_0.chargeTipWindow:Destroy()

		arg_49_0.chargeTipWindow = nil
	end

	arg_49_0.contextData.singleWindow:Destroy()
	arg_49_0.contextData.multiWindow:Destroy()
	arg_49_0.contextData.singleWindowForESkin:Destroy()
	arg_49_0.contextData.paintingView:Dispose()

	arg_49_0.contextData.singleWindow = nil
	arg_49_0.contextData.multiWindow = nil
	arg_49_0.contextData.singleWindowForESkin = nil
	arg_49_0.contextData.paintingView = nil
	arg_49_0.bulinTip = nil

	for iter_49_4, iter_49_5 in pairs(arg_49_0.subViewList) do
		iter_49_5:Destroy()
	end

	arg_49_0.subViewList = nil

	if arg_49_0.heartsTimer then
		arg_49_0.heartsTimer:Stop()

		arg_49_0.heartsTimer = nil
	end

	if arg_49_0.live2dChar then
		arg_49_0.live2dChar:Dispose()
	end

	arg_49_0:StopLive2dTimer()
	arg_49_0:stopCV()
	arg_49_0:DisposeSkinToggleList()

	if arg_49_0.giftShopView then
		arg_49_0.giftShopView:OnDestroy()
	end

	return
end

function var_0_0.onBackPressed(arg_52_0)
	if arg_52_0.contextData.singleWindow:GetLoaded() and arg_52_0.contextData.singleWindow:isShowing() then
		arg_52_0.contextData.singleWindow:Close()

		return
	end

	if arg_52_0.contextData.multiWindow:GetLoaded() and arg_52_0.contextData.multiWindow:isShowing() then
		arg_52_0.contextData.multiWindow:Close()

		return
	end

	if arg_52_0.contextData.singleWindowForESkin:GetLoaded() and arg_52_0.contextData.singleWindowForESkin:isShowing() then
		arg_52_0.contextData.singleWindowForESkin:Hide()

		return
	end

	var_0_0.super.onBackPressed(arg_52_0)

	return
end

function var_0_0.initSubView(arg_53_0)
	arg_53_0.curSubViewNum = 0
	arg_53_0.subViewList = {
		[ShopConst.SHOP_ID.DIAMOND] = ChargeDiamondShopView.New(arg_53_0.viewContainer, arg_53_0.event, arg_53_0.contextData),
		[ShopConst.SHOP_ID.GIFT] = ChargeGiftShopView.New(arg_53_0.viewContainer, arg_53_0.event, arg_53_0.contextData),
		[ShopConst.SHOP_ID.ITEM] = ChargeItemShopView.New(arg_53_0.viewContainer, arg_53_0.event, arg_53_0.contextData),
		[ShopConst.SHOP_ID.PICK] = ChargePickShopView.New(arg_53_0.viewContainer, arg_53_0.event, arg_53_0.contextData),
		[ShopConst.SHOP_ID.MONTH] = SupplyShopView.New(arg_53_0.viewContainer, arg_53_0.event, arg_53_0.contextData, ShopConst.CATEGORY_MONTH),
		[ShopConst.SHOP_ID.SUPPLY] = SupplyShopView.New(arg_53_0.viewContainer, arg_53_0.event, arg_53_0.contextData, ShopConst.CATEGORY_SUPPLY),
		[ShopConst.SHOP_ID.ACTIVITY] = SupplyShopView.New(arg_53_0.viewContainer, arg_53_0.event, arg_53_0.contextData, ShopConst.CATEGORY_ACTIVITY)
	}

	for iter_53_0, iter_53_1 in pairs(arg_53_0.subViewList) do
		iter_53_1:RegisterView(arg_53_0)
	end

	arg_53_0.contextData.singleWindow = ShopSingleWindow.New(arg_53_0._tf, arg_53_0.event)
	arg_53_0.contextData.multiWindow = ShopMultiWindow.New(arg_53_0._tf, arg_53_0.event)
	arg_53_0.contextData.singleWindowForESkin = EquipmentSkinInfoUIForShopWindow.New(arg_53_0._tf, arg_53_0.event)
	arg_53_0.contextData.paintingView = ShopPaintingView.New(arg_53_0._tf:Find("frame/supplyPaint"), arg_53_0._tf:Find("frame/chat"))

	arg_53_0.contextData.paintingView:setSecretaryPos(arg_53_0._tf:Find("frame/secretaryPos"))

	return
end

function var_0_0.GetShopID(arg_54_0, arg_54_1, arg_54_2)
	return ShopConst.SHOP_LIST[arg_54_1][arg_54_2]
end

function var_0_0.switchSubView(arg_55_0, arg_55_1)
	originalPrint(string.format("End: shopID=%s curShopID=%s", arg_55_1, arg_55_0.curSubViewNum))

	if arg_55_1 == arg_55_0.curSubViewNum then
		return
	end

	arg_55_0.subViewList[arg_55_1]:setGoodData(arg_55_0.firstChargeIds, arg_55_0.chargedList, arg_55_0.normalList, arg_55_0.normalGroupList)
	arg_55_0.subViewList[arg_55_1]:Reset()
	arg_55_0.subViewList[arg_55_1]:Load()

	if arg_55_0.subViewList[arg_55_1].SetAllShopData then
		arg_55_0.subViewList[arg_55_1]:ActionInvoke("SetAllShopData", arg_55_0.supplyShopList)
	end

	if arg_55_0.subViewList[arg_55_0.curSubViewNum] then
		var_55_0:Destroy()
	end

	arg_55_0.curSubViewNum = arg_55_1

	arg_55_0:SwitchPainting(arg_55_0.subViewList[arg_55_1]:IsSupplyShop())

	if PLATFORM_CODE == PLATFORM_JP then
		setActive(arg_55_0.userAgreeBtn3, arg_55_1 == ChargeScene.TYPE_DIAMOND)
		setActive(arg_55_0.userAgreeBtn4, arg_55_1 == ChargeScene.TYPE_DIAMOND)
	end

	return
end

function var_0_0.SwitchPainting(arg_56_0, arg_56_1)
	arg_56_0.contextData.paintingView:Show(arg_56_1)
	setActive(arg_56_0.painting, not arg_56_1)

	if arg_56_1 then
		arg_56_0:StopLive2dTimer()

		arg_56_0.chatFlag = nil

		arg_56_0:stopCV()
		setActive(arg_56_0.stamp, getProxy(TaskProxy):mingshiTouchFlagEnabled())

		if LOCK_CLICK_MINGSHI then
			setActive(arg_56_0.stamp, false)
		end
	else
		setActive(arg_56_0.stamp, false)
		arg_56_0:AddLive2dTimer()
	end

	return
end

function var_0_0.switchSubViewByTogger(arg_57_0, arg_57_1)
	triggerToggle(arg_57_0.toggleList[arg_57_1].go, true)

	return
end

function var_0_0.updateCurSubView(arg_58_0)
	if not isActive(arg_58_0.viewContainer) then
		return
	end

	if arg_58_0.subViewList[arg_58_0.curSubViewNum] == nil then
		return
	end

	var_58_0:setGoodData(arg_58_0.firstChargeIds, arg_58_0.chargedList, arg_58_0.normalList, arg_58_0.normalGroupList)
	var_58_0:reUpdateAll()

	return
end

function var_0_0.updateNoRes(arg_59_0, arg_59_1)
	if not arg_59_1 then
		arg_59_1 = arg_59_0.contextData.noRes
	else
		arg_59_0.contextData.noRes = arg_59_1
	end

	if not arg_59_1 or #arg_59_1 <= 0 then
		return
	end

	arg_59_0.contextData.noRes = {}

	local var_59_0 = getProxy(BagProxy):getData()
	local var_59_1 = ""

	for iter_59_0, iter_59_1 in ipairs(arg_59_1) do
		if iter_59_1[2] > 0 then
			local var_59_2 = arg_59_1[iter_59_0]
			local var_59_3 = iter_59_1[3]

			if iter_59_1[1] == 59001 then
				arg_59_1[iter_59_0][2] = iter_59_1[3] - arg_59_0.player.gold

				goto label_59_0
			end

			::label_59_0::

			if var_59_0[iter_59_1[1]] then
				do
					local var_59_4 = var_59_0[iter_59_1[1]].count or 0

					var_59_2[2] = var_59_3 - var_59_4
				end

				if arg_59_1[iter_59_0][2] > 0 then
					table.insert(arg_59_0.contextData.noRes, arg_59_1[iter_59_0])
				end
			end
		end
	end

	for iter_59_2, iter_59_3 in ipairs(arg_59_0.contextData.noRes) do
		var_59_1 = var_59_1 .. i18n(iter_59_3[1] == 59001 and "text_noRes_info_tip" or "text_noRes_info_tip2", Item.getConfigData(iter_59_3[1]).name, iter_59_3[2])

		if iter_59_2 < #arg_59_0.contextData.noRes then
			var_59_1 = var_59_1 .. i18n("text_noRes_info_tip_link")
		end
	end

	if var_59_1 == "" then
		arg_59_0:displayShipWord(i18n("text_shop_enoughRes_tip"), false)
	else
		arg_59_0:displayShipWord(i18n("text_shop_noRes_tip", var_59_1), true)
	end

	return
end

function var_0_0.displayShipWord(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	if not arg_60_0.chatFlag then
		if not arg_60_1 and arg_60_0.contextData.noRes and #arg_60_0.contextData.noRes > 0 then
			setActive(arg_60_0.chat, false)

			arg_60_0.chat.transform.localScale = Vector3(0, 0, 1)
		end

		arg_60_0.chatFlag = true

		if not arg_60_0.isInitChatPosition then
			arg_60_0.isInitChatPosition = true

			arg_60_0:InitChatPosition()
		end

		setActive(arg_60_0.chat, true)

		local var_60_0 = arg_60_3 or math.random(1, (arg_60_0.player:getChargeLevel()))
		local var_60_1 = arg_60_3 and pg.pay_level_award[var_60_0].dialog or arg_60_1 or pg.pay_level_award[var_60_0].dialog

		if not arg_60_1 then
			arg_60_0:playCV(var_60_0)
		end

		setText(arg_60_0.chatText, var_60_1)

		local var_60_2 = arg_60_0.chatText:GetComponent(typeof(Text))

		;(function()
			local var_61_0 = 3

			LeanTween.scale(rtf(arg_60_0.chat.gameObject), Vector3.New(1, 1, 1), 0.3):setFrom(Vector3.New(0, 0, 0)):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
				if not arg_60_2 then
					LeanTween.scale(rtf(arg_60_0.chat.gameObject), Vector3.New(0, 0, 1), var_0):setEase(LeanTweenType.easeInBack):setDelay(var_0 + var_61_0):setOnComplete(System.Action(function()
						arg_60_0.chatFlag = nil

						setActive(arg_60_0.chat, false)

						if arg_60_0.contextData.noRes and #arg_60_0.contextData.noRes > 0 then
							arg_60_0:updateNoRes()
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

function var_0_0.InitChatPosition(arg_64_0)
	return
end

function var_0_0.playHeartEffect(arg_65_0)
	if arg_65_0.heartsTimer then
		arg_65_0.heartsTimer:Stop()
	end

	setActive(arg_65_0.painting:Find("heartsfly"), true)

	arg_65_0.heartsTimer = Timer.New(function()
		setActive(var_0, false)

		return
	end, 1, 1)

	arg_65_0.heartsTimer:Start()

	return
end

function var_0_0.createLive2D(arg_67_0)
	arg_67_0.live2dChar = Live2DPainting.New(Live2DPainting.GenerateData({
		ship = Ship.New({
			configId = 312011
		}),
		offset = {
			0,
			0,
			0,
			75
		},
		position = Vector3(0, 0, 0),
		parent = arg_67_0._tf:Find("frame/painting/live2d")
	}), function(arg_68_0)
		arg_68_0:setSortingLayer(LayerWeightConst.L2D_DEFAULT_LAYER)

		return
	end)

	return
end

function var_0_0.checkBuyDone(arg_69_0, arg_69_1)
	if not arg_69_0.live2dChar or not arg_69_0.live2dChar:IsLoaded() then
		return
	end

	local var_69_0

	if type(arg_69_1) == "string" then
		var_69_0 = arg_69_1 == "damonds" and "diamond" or arg_69_1
	else
		local var_69_1 = pg.shop_template[arg_69_1]

		if pg.shop_template[arg_69_1] and var_69_1.effect_args and type(var_69_1.effect_args) == "table" then
			for iter_69_0, iter_69_1 in ipairs(var_69_1.effect_args) do
				if iter_69_1 == 1 then
					var_69_0 = "gold"
				end
			end
		end
	end

	local var_69_2 = arg_69_0.preAniName == "gold" or arg_69_0.preAniName == "diamond"
	local var_69_3 = var_69_0 == "gold" or var_69_0 == "diamond"
	local var_69_4 = (arg_69_0.preAniName == "gold" or arg_69_0.preAniName == "diamond") and var_69_3 or not var_69_2

	var_69_4 = var_69_0 and arg_69_0.preAniName ~= var_69_0 and var_69_4

	if var_69_4 then
		arg_69_0.preAniName = var_69_0

		arg_69_0.live2dChar:TriggerAction(var_69_0, nil, true)
	end

	return var_69_4
end

function var_0_0.playCV(arg_70_0, arg_70_1)
	local var_70_0

	if pg.pay_level_award[arg_70_1] and pg.pay_level_award[arg_70_1].cv_key ~= "" then
		var_70_0 = "event:/cv/chargeShop/" .. pg.pay_level_award[arg_70_1].cv_key
	end

	if var_70_0 then
		arg_70_0:stopCV()

		arg_70_0._currentVoice = var_70_0

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_70_0)
	end

	return
end

function var_0_0.stopCV(arg_71_0)
	if arg_71_0._currentVoice then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(arg_71_0._currentVoice)
	end

	arg_71_0._currentVoice = nil

	return
end

function var_0_0.blurView(arg_72_0)
	arg_72_0:OverlayPanel(arg_72_0.buttonList, {
		pbList = {
			arg_72_0.buttonList:Find("leftBg")
		}
	})

	return
end

function var_0_0.unBlurView(arg_73_0)
	arg_73_0:UnOverlayPanel(arg_73_0.buttonList, arg_73_0._tf)

	return
end

function var_0_0.jpUIInit(arg_74_0)
	if PLATFORM_CODE ~= PLATFORM_JP then
		return
	end

	arg_74_0.userAgreeBtn3 = arg_74_0._tf:Find("frame/raw1Btn")
	arg_74_0.userAgreeBtn4 = arg_74_0._tf:Find("frame/raw2Btn")

	return
end

function var_0_0.jpUIEnter(arg_75_0)
	if PLATFORM_CODE ~= PLATFORM_JP then
		return
	end

	onButton(arg_75_0, arg_75_0.userAgreeBtn3, function()
		arg_75_0:emit(NewShopMainMediator.OPEN_USER_AGREE, require("ShareCfg.UserAgreement3") or "")

		return
	end, SFX_PANEL)
	onButton(arg_75_0, arg_75_0.userAgreeBtn4, function()
		arg_75_0:emit(NewShopMainMediator.OPEN_USER_AGREE, require("ShareCfg.UserAgreement4") or "")

		return
	end, SFX_PANEL)

	return
end

function var_0_0.addRefreshTimer(arg_78_0, arg_78_1)
	(function()
		if arg_78_0.refreshTimer then
			arg_78_0.refreshTimer:Stop()

			arg_78_0.refreshTimer = nil
		end

		return
	end)()

	arg_78_0.refreshTimer = Timer.New(function()
		if arg_78_1 + 1 - pg.TimeMgr.GetInstance():GetServerTime() <= 0 then
			var_0()
			arg_78_0:emit(NewShopMainMediator.GET_CHARGE_LIST)
		end

		return
	end, 1, -1)

	arg_78_0.refreshTimer:Start()
	arg_78_0.refreshTimer.func()

	return
end

function var_0_0.InitSkinToggleList(arg_81_0)
	arg_81_0.uiSkinToggleParent = arg_81_0.buttonList:Find("shop1List/skinShop/shop2List")
	arg_81_0.uiSkinToggleItem = arg_81_0.buttonList:Find("shop1List/skinShop/shop2List/skinToggleItem")

	local var_81_0 = getProxy(ShipSkinProxy)

	setActive(arg_81_0.buttonList:Find("shop1List/skinShop/shop1Tg/timeLimit"), #var_81_0:GetInTimeSkins() > 0)

	arg_81_0.skinShopList = arg_81_0:GetSkinShopList()
	arg_81_0.skinShopItemList = {}

	onToggle(arg_81_0, arg_81_0.buttonList:Find("shop1List/skinShop/shop1Tg"), function(arg_82_0)
		setActive(arg_81_0.buttonList:Find("shop1List/skinShop/shop2List"), arg_82_0)

		if arg_82_0 then
			if arg_81_0.shop1 == "skinShop" then
				return
			end

			arg_81_0.shop1 = "skinShop"

			local var_82_0 = arg_81_0.skinShopItemList[table.keyof(arg_81_0.skinShopList, arg_81_0:GetDefaultSkinShop())]

			var_82_0 = arg_81_0.contextData.shop1 and arg_81_0.contextData.shop2 and arg_81_0.skinShopItemList[table.keyof(arg_81_0.skinShopList, arg_81_0.contextData.shop2)] or var_82_0
			arg_81_0.contextData.shop1 = "skinShop"

			var_82_0:TriggerToggle()
		end

		return
	end, SFX_PANEL)

	for iter_81_0, iter_81_1 in ipairs(arg_81_0.skinShopList) do
		arg_81_0.skinShopItemList[iter_81_0] = arg_81_0.skinShopItemList[iter_81_0] or NewShopMainSkinToggleItem.New(Object.Instantiate(arg_81_0.uiSkinToggleItem, arg_81_0.uiSkinToggleParent), arg_81_0)

		arg_81_0.skinShopItemList[iter_81_0]:didEnter(iter_81_1)
	end

	return
end

function var_0_0.OnClickSkinShop(arg_83_0, arg_83_1, arg_83_2)
	arg_83_0.contextData.shop2 = arg_83_2

	if arg_83_0.shop2 == arg_83_2 then
		return
	end

	arg_83_0.shop2 = arg_83_2

	arg_83_0:ShowChargeWarp(false)
	pg.m02:sendNotification(var_0_0.CLOSE_ALL_LAYER)
	arg_83_0:emit(NewShopMainMediator.OPEN_LAYER, LatestSkinShopLayer, LatestSkinShopMediator, {
		type = arg_83_2,
		mode = arg_83_0.contextData.mode
	})

	return
end

function var_0_0.DisposeSkinToggleList(arg_84_0)
	for iter_84_0, iter_84_1 in ipairs(arg_84_0.skinShopItemList) do
		iter_84_1:willExit()
	end

	arg_84_0.skinShopItemList = nil

	return
end

function var_0_0.GetSkinShopList(arg_85_0)
	local var_85_0 = Clone(pg.shop_skin_subsheet.get_id_list_by_type[0])

	if #getProxy(ShipSkinProxy):GetInTimeSkins() <= 0 then
		table.remove(var_85_0, 1)
	end

	local var_85_1 = pg.TimeMgr.GetInstance()
	local var_85_2 = getProxy(ShipSkinProxy):GetAllSkins()
	local var_85_3 = pg.shop_skin_subsheet.get_id_list_by_type[1] or {}

	for iter_85_0, iter_85_1 in ipairs(var_85_3) do
		if var_85_1:inTime(pg.shop_skin_subsheet[iter_85_1].time) then
			for iter_85_2, iter_85_3 in ipairs(var_85_2) do
				if table.keyof(pg.shop_skin_subsheet[iter_85_1].param, iter_85_3.id) then
					table.insert(var_85_0, iter_85_1)

					break
				end
			end
		end
	end

	table.sort(var_85_0, function(arg_86_0, arg_86_1)
		local var_86_0 = pg.shop_skin_subsheet[arg_86_0]
		local var_86_1 = pg.shop_skin_subsheet[arg_86_1]

		return pg.shop_skin_subsheet[arg_86_0].sort == pg.shop_skin_subsheet[arg_86_0].sort and arg_86_0 < arg_86_1 or var_86_0.sort < var_86_1.sort
	end)

	return var_85_0
end

function var_0_0.GetDefaultSkinShop(arg_87_0)
	local var_87_0 = Clone(arg_87_0.skinShopList)

	table.sort(var_87_0, function(arg_88_0, arg_88_1)
		local var_88_0 = pg.shop_skin_subsheet[arg_88_0]
		local var_88_1 = pg.shop_skin_subsheet[arg_88_1]

		if pg.shop_skin_subsheet[arg_88_0].shop_skin_subsheet == pg.shop_skin_subsheet[arg_88_1].shop_skin_subsheet then
			return var_88_0.sort == var_88_1.sort and arg_88_0 < arg_88_1 or var_88_0.sort < var_88_1.sort
		else
			return var_88_0.shop_skin_subsheet < var_88_1.shop_skin_subsheet
		end

		return
	end)

	return var_87_0[1]
end

return var_0_0
