local var_0_0 = class("IslandTradeConfirmWindow", import(".IslandBaseMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandTradeConfirmUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.panel = arg_2_0._tf:Find("panel")
	arg_2_0.closeBtn = arg_2_0.panel:Find("closeBtn")
	arg_2_0.icon = arg_2_0.panel:Find("icon")
	arg_2_0.name = arg_2_0.panel:Find("name"):GetComponent(typeof(Text))
	arg_2_0.desc = arg_2_0.panel:Find("desc"):GetComponent(typeof(Text))
	arg_2_0.count = arg_2_0.panel:Find("count/number_panel/value"):GetComponent(typeof(Text))
	arg_2_0.leftBtn = arg_2_0.panel:Find("count/left")
	arg_2_0.rightBtn = arg_2_0.panel:Find("count/right")
	arg_2_0.minBtn = arg_2_0.panel:Find("count/min")
	arg_2_0.maxBtn = arg_2_0.panel:Find("count/max")
	arg_2_0.bottomItemList = UIItemList.New(arg_2_0.panel:Find("itemList/Viewport/Content"), arg_2_0.panel:Find("itemList/Viewport/Content/IslandItemTpl"))
	arg_2_0.buyBtn = arg_2_0.panel:Find("buyBtn")
	arg_2_0.consumeIcon = arg_2_0.buyBtn:Find("consume/icon")
	arg_2_0.consumeCount = arg_2_0.buyBtn:Find("consume/count"):GetComponent(typeof(Text))

	setText(arg_2_0._tf:Find("panel/getDesc"), i18n("island_3Dshop_buy_tip0"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	pressPersistTrigger(arg_3_0.leftBtn, 0.5, function(arg_6_0)
		arg_3_0:UpdateCount(arg_3_0.curCount - 1)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(arg_3_0.rightBtn, 0.5, function(arg_7_0)
		arg_3_0:UpdateCount(arg_3_0.curCount + 1)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(arg_3_0.minBtn, 0.5, function(arg_8_0)
		arg_3_0:UpdateCount(arg_3_0.curCount - 10)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(arg_3_0.maxBtn, 0.5, function(arg_9_0)
		arg_3_0:UpdateCount(arg_3_0.curCount + 10)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	arg_3_0.bottomItemList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_10_2, {
				count = 1,
				type = DROP_TYPE_ISLAND_ITEM,
				id = arg_3_0.awards[arg_10_1 + 1].id
			})

			if arg_3_0.settings.mode == IslandConst.TRADE_PURCHASE then
				setText(arg_10_2:Find("icon_bg/count_bg/count"), arg_3_0.curCount)
			elseif arg_3_0.settings.mode == IslandConst.TRADE_SELL then
				setText(arg_10_2:Find("icon_bg/count_bg/count"), arg_3_0.price * arg_3_0.curCount)
			end
		end

		return
	end)
	onButton(arg_3_0, arg_3_0.buyBtn, function()
		if arg_3_0.curCount <= 0 then
			if arg_3_0.settings.mode == IslandConst.TRADE_PURCHASE then
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_trade_cnt_inadequate"))
			elseif arg_3_0.settings.mode == IslandConst.TRADE_SELL then
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_trade_sell_failed_label"))
			end

			return
		end

		if arg_3_0.curCount > arg_3_0.settings.maxCnt then
			if settings.mode == IslandConst.TRADE_PURCHASE then
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_trade_purchase_failed_label"))
			elseif settings.mode == IslandConst.TRADE_SELL then
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_trade_sell_failed_label2"))
			end

			return
		end

		if arg_3_0.settings.onYes then
			arg_3_0.settings.onYes(arg_3_0.curCount)
		end

		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShow(arg_12_0)
	arg_12_0.curCount = 1
	arg_12_0.price = arg_12_0.settings.price or 0
	arg_12_0.maxCnt = arg_12_0.settings.maxCnt or 0
	arg_12_0.awards = {}

	local var_12_0 = IslandItem.New({
		id = IslandItem.PEARL_ID
	})
	local var_12_1 = IslandItem.New({
		id = IslandItem.GOLD_ID
	})

	if arg_12_0.settings.mode == IslandConst.TRADE_PURCHASE then
		setText(arg_12_0._tf:Find("panel/title"), i18n("island_trade_purchase_sub_label"))
		setText(arg_12_0._tf:Find("panel/buyBtn/text"), i18n("island_trade_purchase_sub_label"))
		GetImageSpriteFromAtlasAsync("island/" .. var_12_1:GetIcon(), "", arg_12_0.consumeIcon)
		table.insert(arg_12_0.awards, var_12_0)
	elseif arg_12_0.settings.mode == IslandConst.TRADE_SELL then
		setText(arg_12_0._tf:Find("panel/title"), i18n("island_trade_sell_sub_label"))
		setText(arg_12_0._tf:Find("panel/buyBtn/text"), i18n("island_trade_sell_sub_label"))
		GetImageSpriteFromAtlasAsync("island/" .. var_12_0:GetIcon(), "", arg_12_0.consumeIcon)
		table.insert(arg_12_0.awards, var_12_1)
	end

	GetImageSpriteFromAtlasAsync("island/" .. var_12_0:GetIcon(), "", arg_12_0.icon)

	arg_12_0.name.text = var_12_0:getConfig("name")
	arg_12_0.desc.text = var_12_0:getConfig("desc")

	arg_12_0:UpdateCount(arg_12_0.curCount)

	return
end

function var_0_0.UpdateCount(arg_13_0, arg_13_1)
	arg_13_0.curCount = math.min(arg_13_0.maxCnt, math.max(0, arg_13_1))
	arg_13_0.count.text = arg_13_0.curCount

	if arg_13_0.settings.mode == IslandConst.TRADE_PURCHASE then
		arg_13_0.consumeCount.text = arg_13_0.curCount * arg_13_0.price
	elseif arg_13_0.settings.mode == IslandConst.TRADE_SELL then
		arg_13_0.consumeCount.text = arg_13_0.curCount
	end

	arg_13_0.bottomItemList:align(#arg_13_0.awards)

	return
end

function var_0_0.OnHide(arg_14_0)
	return
end

return var_0_0
