local var_0_0 = class("ChargeGiftShopView", import("...base.BaseSubView"))

var_0_0.ShowPickUp = false

function var_0_0.getUIName(arg_1_0)
	return "ChargeGiftShopUI"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:Show()

	return
end

function var_0_0.OnDestroy(arg_3_0)
	local var_3_0 = arg_3_0.chargeCardTable or {}

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		iter_3_1:Dispose()
	end

	arg_3_0:removeUpdateTimer()

	return
end

function var_0_0.initData(arg_4_0)
	arg_4_0.giftGoodsVOListForShow = {}
	arg_4_0.packageSortList = {
		0
	}
	arg_4_0.prevBtn = nil
	arg_4_0.selectedPackageType = nil
	arg_4_0.updateTime = nil
	arg_4_0.updateTimer = nil
	arg_4_0.player = getProxy(PlayerProxy):getData()

	arg_4_0:updateData()

	return
end

function var_0_0.initUI(arg_5_0)
	arg_5_0.emptyGo = arg_5_0._tf:Find("emptyText")

	setText(arg_5_0.emptyGo, i18n("shop_pack_empty"))

	arg_5_0.lScrollRect = GetComponent(arg_5_0._tf:Find("lScrollRect"), "LScrollRect")
	arg_5_0.chargeCardTable = {}

	arg_5_0:initScrollRect()
	arg_5_0:initToggleList()
	arg_5_0:updateToggleList()
	arg_5_0:updateScrollRect()
	triggerButton(arg_5_0._tf:Find("toggleGroup"):GetChild(0))

	return
end

function var_0_0.GetViewSkinWrap(arg_6_0)
	return ChargeScene.TYPE_GIFT
end

function var_0_0.initScrollRect(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.chargeCardTable = {}

	function arg_7_0.lScrollRect.onInitItem(arg_8_0)
		local var_8_0 = ChargeCard.New(arg_8_0)

		onButton(arg_7_0, var_8_0.tr, function()
			if var_8_0.goods:isChargeType() then
				switch(var_8_0.goods:getShowType(), {
					[Goods.SHOW_TYPE_TECH] = function()
						arg_7_0:emit(NewShopMainMediator.OPEN_TEC_SHIP_GIFT_SELL_LAYER, var_8_0.goods, arg_7_0.chargedList)

						return
					end,
					[Goods.SHOW_TYPE_BATTLE_UI] = function()
						arg_7_0:emit(NewShopMainMediator.OPEN_BATTLE_UI_SELL_LAYER, var_8_0.goods, arg_7_0.chargedList)

						return
					end
				}, function()
					arg_7_0:confirm(var_8_0.goods)

					return
				end)
			else
				arg_7_0:confirm(var_8_0.goods)
			end

			return
		end, SFX_PANEL)
		onButton(arg_7_0, var_8_0.viewBtn, function()
			if not var_8_0.goods:isChargeType() then
				return
			end

			local var_13_0 = var_8_0.goods:GetSkinProbability()

			if #var_13_0 > 0 then
				if #var_13_0 ~= #getProxy(ShipSkinProxy):GetProbabilitySkins(var_13_0) then
					arg_7_0:emit(BaseUI.ON_DROP, (var_8_0.goods:GetSkinProbabilityItem()))
				else
					arg_7_0:emit(NewShopMainMediator.VIEW_SKIN_PROBABILITY, var_8_0.goods.id, arg_7_0:GetViewSkinWrap())
				end

				return
			end
		end, SFX_PANEL)

		arg_7_0.chargeCardTable[arg_8_0] = var_8_0

		return
	end

	function arg_7_0.lScrollRect.onUpdateItem(arg_14_0, arg_14_1)
		local var_14_0 = arg_7_0.chargeCardTable[arg_14_1]

		if not arg_7_0.chargeCardTable[arg_14_1] then
			var_0(arg_14_1)

			var_14_0 = arg_7_0.chargeCardTable[arg_14_1]
		end

		local var_14_1 = arg_7_0.filterList[arg_14_0 + 1]

		if arg_7_0.filterList[arg_14_0 + 1] then
			var_14_0:update(var_14_1, arg_7_0.player, arg_7_0.firstChargeIds)
		end

		return
	end

	return
end

function var_0_0.updateToggleList(arg_15_0)
	arg_15_0.uiToggleList:align(#arg_15_0.packageSortList)

	return
end

function var_0_0.updateScrollRect(arg_16_0)
	arg_16_0.filterList = arg_16_0:getFilterList()
	arg_16_0.lScrollRect.enabled = true

	arg_16_0.lScrollRect:SetTotalCount(#arg_16_0.filterList, arg_16_0.lScrollRect.value)
	setActive(arg_16_0.emptyGo, #arg_16_0.filterList <= 0)

	return
end

function var_0_0.confirm(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return
	end

	arg_17_1 = Clone(arg_17_1)

	if arg_17_1:isChargeType() then
		local var_17_0 = not table.contains(arg_17_0.firstChargeIds, arg_17_1.id) and arg_17_1:firstPayDouble()
		local var_17_1 = var_17_0 and 4 or arg_17_1:getConfig("tag")

		if arg_17_1:isMonthCard() or arg_17_1:isGiftBox() or arg_17_1:isItemBox() or arg_17_1:isPassItem() then
			local var_17_2 = arg_17_1:GetExtraServiceItem()
			local var_17_3 = arg_17_1:GetExtraDrop()
			local var_17_4 = arg_17_1:GetBonusItem()
			local var_17_5
			local var_17_6

			if arg_17_1:isPassItem() then
				var_17_5 = i18n("battlepass_pay_tip")
			elseif arg_17_1:isMonthCard() then
				var_17_5 = i18n("charge_title_getitem_month")
				var_17_6 = i18n("charge_title_getitem_soon")
			else
				var_17_5 = i18n("charge_title_getitem")
			end

			arg_17_0:emit(NewShopMainMediator.OPEN_CHARGE_ITEM_PANEL, {
				isChargeType = true,
				commodity = arg_17_1,
				infoTip = arg_17_1:GetInfoTip(),
				icon = "chargeicon/" .. arg_17_1:getConfig("picture"),
				name = arg_17_1:getConfig("name_display"),
				tipExtra = var_17_5,
				extraItems = var_17_2,
				price = arg_17_1:getConfig("money"),
				isLocalPrice = arg_17_1:IsLocalPrice(),
				tagType = var_17_1,
				isMonthCard = arg_17_1:isMonthCard(),
				tipBonus = var_17_6,
				bonusItem = var_17_4,
				extraDrop = var_17_3,
				descExtra = arg_17_1:getConfig("descrip_extra"),
				limitArgs = arg_17_1:getConfig("limit_args"),
				onYes = function()
					if ChargeConst.isNeedSetBirth() then
						arg_17_0:emit(NewShopMainMediator.OPEN_CHARGE_BIRTHDAY)
					else
						arg_17_0:emit(NewShopMainMediator.CHARGE, arg_17_1.id)
					end

					return
				end
			})
		elseif arg_17_1:isGem() then
			local var_17_7 = arg_17_1:getConfig("money")
			local var_17_8 = arg_17_1:getConfig("gem")

			var_17_8 = var_17_0 and var_17_8 + arg_17_1:getConfig("gem") or var_17_8 + arg_17_1:getConfig("extra_gem")

			arg_17_0:emit(NewShopMainMediator.OPEN_CHARGE_ITEM_BOX, {
				isChargeType = true,
				commodity = arg_17_1,
				icon = "chargeicon/" .. arg_17_1:getConfig("picture"),
				name = arg_17_1:getConfig("name_display"),
				price = arg_17_1:getConfig("money"),
				isLocalPrice = arg_17_1:IsLocalPrice(),
				tagType = var_17_1,
				normalTip = i18n("charge_start_tip", var_17_7, var_17_8),
				onYes = function()
					if ChargeConst.isNeedSetBirth() then
						arg_17_0:emit(NewShopMainMediator.OPEN_CHARGE_BIRTHDAY)
					else
						arg_17_0:emit(NewShopMainMediator.CHARGE, arg_17_1.id)
					end

					return
				end
			})
		end
	elseif arg_17_1:isActGiftPackage() then
		arg_17_0:emit(NewShopMainMediator.OPEN_GIFT_ACT_LAYER, arg_17_1:getBindActivity().id)
	else
		local var_17_9 = {}
		local var_17_10 = Item.getConfigData(arg_17_1:getConfig("effect_args")[1])

		if type(var_17_10.display_icon) == "table" then
			for iter_17_0, iter_17_1 in ipairs(var_17_10.display_icon) do
				table.insert(var_17_9, Drop.New({
					type = iter_17_1[1],
					id = iter_17_1[2],
					count = iter_17_1[3]
				}))
			end
		end

		arg_17_0:emit(NewShopMainMediator.OPEN_CHARGE_ITEM_PANEL, {
			isLocalPrice = false,
			isChargeType = false,
			isMonthCard = false,
			commodity = arg_17_1,
			icon = var_17_10.icon,
			name = var_17_10.name,
			tipExtra = i18n("charge_title_getitem"),
			extraItems = var_17_9,
			price = arg_17_1:getConfig("resource_num"),
			tagType = arg_17_1:getConfig("tag"),
			onYes = function()
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("charge_scene_buy_confirm", arg_17_1:getConfig("resource_num"), var_17_10.name),
					onYes = function()
						arg_17_0:emit(NewShopMainMediator.BUY_ITEM, arg_17_1.id, 1)

						return
					end
				})

				return
			end
		})
	end

	return
end

function var_0_0.initToggleList(arg_22_0)
	arg_22_0.uiToggleList = UIItemList.New(arg_22_0._tf:Find("toggleGroup"), arg_22_0._tf:Find("toggleGroup/Toggle"))

	arg_22_0.uiToggleList:make(function(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == UIItemList.EventInit then
			setText(arg_23_2:Find("selected/Label"), i18n(string.format("shop_package_sort_%s", arg_22_0.packageSortList[arg_23_1 + 1])))
			setText(arg_23_2:Find("selected/enText"), i18n(string.format("shop_package_sort_en_%s", arg_22_0.packageSortList[arg_23_1 + 1])))
			setText(arg_23_2:Find("unselected/Label"), i18n(string.format("shop_package_sort_%s", arg_22_0.packageSortList[arg_23_1 + 1])))
			setActive(arg_23_2:Find("unselected"), true)
			setActive(arg_23_2:Find("selected"), false)
		elseif arg_23_0 == UIItemList.EventUpdate then
			onButton(arg_22_0, arg_23_2, function()
				if arg_22_0.selectedPackageType == arg_22_0.packageSortList[arg_23_1 + 1] then
					return
				end

				setActive(arg_23_2:Find("unselected"), false)
				setActive(arg_23_2:Find("selected"), true)

				if arg_22_0.prevBtn then
					setActive(arg_22_0.prevBtn:Find("unselected"), true)
					setActive(arg_22_0.prevBtn:Find("selected"), false)
				end

				arg_22_0.prevBtn = arg_23_2
				arg_22_0.selectedPackageType = arg_22_0.packageSortList[arg_23_1 + 1]

				arg_22_0:updateScrollRect()

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function var_0_0.sortGiftGoodsVOList(arg_25_0)
	local var_25_1

	arg_25_0.giftGoodsVOListForShow, var_25_1 = getProxy(ShopsProxy):GetAllShowGiftPackages(arg_25_0.ShowPickUp)
	arg_25_0.packageSortList = {
		0
	}

	for iter_25_0, iter_25_1 in ipairs(var_25_1) do
		local var_25_2, var_25_3 = pg.TimeMgr.GetInstance():inTime(iter_25_1:getConfig("time"))

		if var_25_3 then
			arg_25_0:addUpdateTimer(var_25_3)
		end
	end

	for iter_25_2, iter_25_3 in ipairs(arg_25_0.giftGoodsVOListForShow) do
		if not iter_25_3:isChargeType() then
			local var_25_4, var_25_5 = pg.TimeMgr.GetInstance():inTime(iter_25_3:getConfig("time"))

			if var_25_5 then
				arg_25_0:addUpdateTimer(var_25_5)
			end
		end

		local var_25_6 = iter_25_3:getConfig("package_sort_id")

		if not ({
			[0] = true
		})[var_25_6] then
			({
				[0] = true
			})[var_25_6] = true

			table.insert(arg_25_0.packageSortList, var_25_6)
		end
	end

	table.sort(arg_25_0.packageSortList)

	local function var_25_7(arg_26_0)
		local var_26_0 = arg_26_0:getConfig("time")
		local var_26_1 = 0

		if type(var_26_0) == "string" then
			var_26_1 = var_26_1 + 999999999999
		elseif type(var_26_0) == "table" then
			var_26_1 = pg.TimeMgr.GetInstance():parseTimeFromConfig(var_26_0[2]) - pg.TimeMgr.GetInstance():GetServerTime()
			var_26_1 = var_26_1 > 0 and var_26_1 or 999999999999
		else
			var_26_1 = var_26_1 + 999999999999
		end

		return var_26_1
	end

	local var_25_8 = {}
	local var_25_9 = getProxy(ActivityProxy)

	for iter_25_4, iter_25_5 in ipairs(var_25_9:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_GIFT_UP)) do
		if var_25_9:IsActivityNotEnd(iter_25_5.id) then
			underscore(iter_25_5:getConfig("config_client").gifts):chain():flatten():map(function(arg_27_0)
				var_25_8[arg_27_0] = true

				return
			end)
		end
	end

	table.sort(arg_25_0.giftGoodsVOListForShow, CompareFuncs({
		function(arg_28_0)
			return var_25_8[arg_28_0.id] and 0 or 1
		end,
		function(arg_29_0)
			return (arg_29_0:getConfig("type_order") - 1) % 1000
		end,
		function(arg_30_0)
			return var_25_7(arg_30_0)
		end,
		function(arg_31_0)
			return -arg_31_0:getConfig("tag")
		end,
		function(arg_32_0)
			return arg_32_0:getConfig("order") or 999
		end,
		function(arg_33_0)
			return arg_33_0.id
		end
	}))

	return
end

function var_0_0.getFilterList(arg_34_0)
	if arg_34_0.selectedPackageType == nil or arg_34_0.selectedPackageType == 0 then
		return arg_34_0.giftGoodsVOListForShow
	end

	return arg_34_0:getFilterListByType(arg_34_0.selectedPackageType)
end

function var_0_0.getFilterListByType(arg_35_0, arg_35_1)
	for iter_35_0, iter_35_1 in ipairs(arg_35_0.giftGoodsVOListForShow) do
		if iter_35_1:getConfig("package_sort_id") == arg_35_1 then
			table.insert({}, iter_35_1)
		end
	end

	return {}
end

function var_0_0.updateGoodsData(arg_36_0)
	arg_36_0.firstChargeIds = arg_36_0.contextData.firstChargeIds
	arg_36_0.chargedList = arg_36_0.contextData.chargedList

	return
end

function var_0_0.setGoodData(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	arg_37_0.firstChargeIds = arg_37_1
	arg_37_0.chargedList = arg_37_2

	return
end

function var_0_0.updateData(arg_38_0)
	arg_38_0.player = getProxy(PlayerProxy):getData()

	arg_38_0:sortGiftGoodsVOList()

	return
end

function var_0_0.addUpdateTimer(arg_39_0, arg_39_1)
	local var_39_0 = pg.TimeMgr.GetInstance()
	local var_39_1 = var_39_0:Table2ServerTime(arg_39_1)

	if arg_39_0.updateTime and var_39_0:Table2ServerTime(arg_39_1) > var_39_0:Table2ServerTime(arg_39_0.updateTime) then
		return
	end

	arg_39_0.updateTime = arg_39_1

	arg_39_0:removeUpdateTimer()

	arg_39_0.updateTimer = Timer.New(function()
		if var_39_0:GetServerTime() > var_39_1 then
			arg_39_0:removeUpdateTimer()
			arg_39_0:reUpdateAll()
		end

		return
	end, 1, -1)

	arg_39_0.updateTimer:Start()
	arg_39_0.updateTimer.func()

	return
end

function var_0_0.removeUpdateTimer(arg_41_0)
	if arg_41_0.updateTimer then
		arg_41_0.updateTimer:Stop()

		arg_41_0.updateTimer = nil
	end

	return
end

function var_0_0.IsSupplyShop(arg_42_0)
	return false
end

function var_0_0.reUpdateAll(arg_43_0)
	arg_43_0:updateData()
	arg_43_0:updateToggleList()
	arg_43_0:updateScrollRect()

	if not table.contains(arg_43_0.packageSortList, arg_43_0.selectedPackageType) then
		triggerButton(arg_43_0._tf:Find("toggleGroup"):GetChild(0))
	end

	return
end

function var_0_0.ShowPanel(arg_44_0, arg_44_1)
	setActive(arg_44_0._go, arg_44_1)

	return
end

return var_0_0
