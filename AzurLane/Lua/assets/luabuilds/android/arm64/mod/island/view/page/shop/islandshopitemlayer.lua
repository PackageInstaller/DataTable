local var_0_0 = class("IslandShopItemLayer", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandShopItemUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.panel = arg_2_0._tf:Find("panel")
	arg_2_0.closeBtn = arg_2_0.panel:Find("closeBtn")
	arg_2_0.icon = arg_2_0.panel:Find("icon")
	arg_2_0.discount = arg_2_0.panel:Find("discount")
	arg_2_0.remainTimer = arg_2_0.panel:Find("remainTimer")
	arg_2_0.name = arg_2_0.panel:Find("name")
	arg_2_0.desc = arg_2_0.panel:Find("desc")
	arg_2_0.buyDesc = arg_2_0.panel:Find("buyDesc")
	arg_2_0.count = arg_2_0.panel:Find("count/number_panel/value")
	arg_2_0.leftBtn = arg_2_0.panel:Find("count/left")
	arg_2_0.rightBtn = arg_2_0.panel:Find("count/right")
	arg_2_0.minBtn = arg_2_0.panel:Find("count/min")
	arg_2_0.maxBtn = arg_2_0.panel:Find("count/max")
	arg_2_0.bottomItemList = UIItemList.New(arg_2_0.panel:Find("itemList/Viewport/Content"), arg_2_0.panel:Find("itemList/Viewport/Content/IslandItemTpl"))
	arg_2_0.buyBtn = arg_2_0.panel:Find("buyBtn")
	arg_2_0.consumeIcon = arg_2_0.buyBtn:Find("consume/icon")
	arg_2_0.consumeCount = arg_2_0.buyBtn:Find("consume/count")

	setText(arg_2_0._tf:Find("panel/title"), i18n("island_3Dshop_buy_confirm"))
	setText(arg_2_0._tf:Find("panel/buyBtn/text"), i18n("island_3Dshop_buy"))
	setText(arg_2_0._tf:Find("panel/getDesc"), i18n("island_3Dshop_buy_tip0"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("bg"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetUp(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.charaId then
		GetImageSpriteFromAtlasAsync("island/islandshipiconall/" .. arg_6_0.charaId, "", arg_6_0.icon)
	else
		GetImageSpriteFromAtlasAsync(arg_6_2:GetIcon(), "", arg_6_0.icon)
	end

	setText(arg_6_0.name, arg_6_2:GetName())
	setText(arg_6_0.desc, arg_6_2:GetDescription())
	setActive(arg_6_0.discount, arg_6_2:GetDiscount() ~= 0)
	setText(arg_6_0.discount:Find("Text"), "-" .. arg_6_2:GetDiscount() .. "%")

	local var_6_0 = arg_6_2:IsTimeLimitCommodity()

	setActive(arg_6_0.remainTimer, var_6_0)

	if var_6_0 then
		local var_6_1 = arg_6_2:getConfig("time")[2]
		local var_6_2 = pg.TimeMgr.GetInstance():Table2ServerTime({
			year = var_6_1[1][1],
			month = var_6_1[1][2],
			day = var_6_1[1][3],
			hour = var_6_1[2][1],
			min = var_6_1[2][2],
			sec = var_6_1[2][3]
		})
		local var_6_3 = 0

		arg_6_0:StartTimer(function()
			local var_7_0 = var_6_2 - pg.TimeMgr.GetInstance():GetServerTime()

			if var_7_0 < var_6_3 then
				setText(arg_6_0.remainTimer:Find("text"), (pg.TimeMgr.GetInstance():DescCDTime(var_7_0)))
			else
				setText(arg_6_0.remainTimer:Find("text"), i18n("island_3Dshop_goods_time", math.floor(var_7_0 / var_6_3)))
			end

			return
		end)
	end

	local var_6_4 = i18n("island_3Dshop_buy_no")

	if arg_6_2:GetMaxNum() ~= 0 then
		var_6_4 = var_6_4 .. i18n("island_3Dshop_last", arg_6_2:GetMaxNum() - arg_6_2.purchasedNum)
	end

	setText(arg_6_0.buyDesc, var_6_4)

	local var_6_5 = arg_6_2:GetMaxNum() - arg_6_2.purchasedNum

	if arg_6_2:GetMaxNum() == 0 then
		var_6_5 = 999
	end

	local var_6_6 = arg_6_2:GetResourceConsume()
	local var_6_7 = (100 - arg_6_2:GetDiscount()) / 100 * var_6_6[3]
	local var_6_8 = 1

	if var_6_6[1] == DROP_TYPE_RESOURCE then
		local var_6_9 = getProxy(PlayerProxy):getRawData()

		if var_6_6[2] == 1 then
			var_6_8 = math.floor(var_6_9.gold / var_6_7)

			goto label_6_0
		end

		::label_6_0::

		if var_6_6[2] ~= 4 then
			if var_6_6[2] == 14 then
				var_6_8 = math.floor(var_6_9:getTotalGem() / var_6_7)

				goto label_6_0

				if var_6_6[1] == DROP_TYPE_ISLAND_ITEM then
					var_6_8 = math.floor(getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetOwnCount(var_6_6[2]) / var_6_7)
				end
			end

			local var_6_10 = math.clamp(var_6_8, 1, var_6_5)
			local var_6_11 = arg_6_2:GetItemsWithPt()

			local function var_6_12(arg_8_0)
				arg_8_0 = math.clamp(arg_8_0, 1, var_6_10)
				arg_6_0.curCount = arg_8_0

				setText(arg_6_0.count, arg_8_0)

				for iter_8_0 = 1, #arg_6_0.itemsCountTFs do
					setText(arg_6_0.itemsCountTFs[iter_8_0], var_6_11[iter_8_0][3] * arg_6_0.curCount)
				end

				setText(arg_6_0.consumeCount, math.ceil(var_6_7 * arg_6_0.curCount))

				return
			end

			pressPersistTrigger(arg_6_0.leftBtn, 0.5, function(arg_9_0)
				var_6_12(arg_6_0.curCount - 1)

				return
			end, nil, true, true, 0.1, SFX_PANEL)
			pressPersistTrigger(arg_6_0.rightBtn, 0.5, function(arg_10_0)
				var_6_12(arg_6_0.curCount + 1)

				return
			end, nil, true, true, 0.1, SFX_PANEL)
			pressPersistTrigger(arg_6_0.minBtn, 0.5, function(arg_11_0)
				var_6_12(arg_6_0.curCount - 10)

				return
			end, nil, true, true, 0.1, SFX_PANEL)
			pressPersistTrigger(arg_6_0.maxBtn, 0.5, function(arg_12_0)
				var_6_12(arg_6_0.curCount + 10)

				return
			end, nil, true, true, 0.1, SFX_PANEL)

			arg_6_0.itemsCountTFs = {}

			arg_6_0.bottomItemList:make(function(arg_13_0, arg_13_1, arg_13_2)
				if arg_13_0 == UIItemList.EventUpdate then
					updateCustomDrop(arg_13_2, {
						type = var_6_11[arg_13_1 + 1][1],
						id = var_6_11[arg_13_1 + 1][2],
						count = var_6_11[arg_13_1 + 1][3]
					}, {
						style = "island"
					})
					table.insert(arg_6_0.itemsCountTFs, arg_13_2:Find("icon_bg/count_bg/count"))
				end

				return
			end)
			arg_6_0.bottomItemList:align(#arg_6_2:GetItemsWithPt())
			;(function(arg_8_0)
				arg_8_0 = math.clamp(arg_8_0, 1, var_6_10)
				arg_6_0.curCount = arg_8_0

				setText(arg_6_0.count, arg_8_0)

				for iter_8_0 = 1, #arg_6_0.itemsCountTFs do
					setText(arg_6_0.itemsCountTFs[iter_8_0], var_6_11[iter_8_0][3] * arg_6_0.curCount)
				end

				setText(arg_6_0.consumeCount, math.ceil(var_6_7 * arg_6_0.curCount))

				return
			end)(1)

			if var_6_6[1] == DROP_TYPE_RESOURCE then
				GetImageSpriteFromAtlasAsync(Drop.New({
					type = var_6_6[1],
					id = var_6_6[2]
				}):getIcon(), "", arg_6_0.consumeIcon)
			elseif var_6_6[1] == DROP_TYPE_ISLAND_ITEM then
				GetImageSpriteFromAtlasAsync(Drop.New({
					type = var_6_6[1],
					id = var_6_6[2]
				}):getIcon(), "", arg_6_0.consumeIcon)
			end

			onButton(arg_6_0, arg_6_0.buyBtn, function()
				arg_6_0:emit(IslandMediator.BUY_COMMODITY, {
					{
						key = arg_6_1,
						value1 = arg_6_2.id,
						value2 = arg_6_0.curCount
					}
				})

				return
			end, SFX_PANEL)

			return
		end
	end
end

function var_0_0.AddListeners(arg_15_0)
	arg_15_0:AddListener(GAME.ISLAND_SHOP_OP_DONE, arg_15_0.Hide)

	return
end

function var_0_0.RemoveListeners(arg_16_0)
	arg_16_0:RemoveListener(GAME.ISLAND_SHOP_OP_DONE, arg_16_0.Hide)

	return
end

function var_0_0.OnShow(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0:BlurPanel(arg_17_0._tf)

	arg_17_0.shopId = arg_17_1
	arg_17_0.commodity = arg_17_2

	arg_17_0:SetUp(arg_17_1, arg_17_2)

	if arg_17_3 then
		arg_17_0.charaId = arg_17_3
	end

	return
end

function var_0_0.Refresh(arg_18_0)
	arg_18_0:SetUp(arg_18_0.shopId, arg_18_0.commodity)

	return
end

function var_0_0.StartTimer(arg_19_0, arg_19_1)
	arg_19_0.timer = Timer.New(arg_19_1, 1, -1)

	arg_19_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_20_0)
	if arg_20_0.timer then
		arg_20_0.timer:Stop()

		arg_20_0.timer = nil
	end

	return
end

function var_0_0.OnHide(arg_21_0)
	arg_21_0:RemoveTimer()
	arg_21_0:UnOverlayPanel(arg_21_0._tf, arg_21_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_22_0)
	return
end

return var_0_0
