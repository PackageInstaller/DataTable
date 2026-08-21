local var_0_0 = class("ZumaPTShopWindowLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "ZumaPTShopWindowUI"
end

function var_0_0.init(arg_2_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:updateGoodInfoPanel()
	arg_3_0:updateBuyPanelWithNum(1)

	return
end

function var_0_0.willExit(arg_4_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_4_0._tf)
	arg_4_0.pageUtil:Dispose()

	return
end

function var_0_0.onBackPressed(arg_5_0)
	arg_5_0:closeView()

	return
end

function var_0_0.initData(arg_6_0)
	arg_6_0.actShopVO = arg_6_0.contextData.actShopVO
	arg_6_0.goodVO = arg_6_0.contextData.goodVO
	arg_6_0.perCost = arg_6_0.goodVO:getConfig("resource_num")
	arg_6_0.maxBuyCount = math.floor(Drop.New({
		type = arg_6_0.goodVO:getConfig("resource_category"),
		id = arg_6_0.goodVO:getConfig("resource_type")
	}):getOwnedCount() / arg_6_0.perCost)

	if arg_6_0.goodVO:getConfig("num_limit") ~= 0 then
		arg_6_0.maxBuyCount = math.min(arg_6_0.maxBuyCount, math.max(arg_6_0.goodVO:GetPurchasableCnt(), 0))
	end

	arg_6_0.curBuyCount = 1
	arg_6_0.costItemInfo = Drop.New({
		type = arg_6_0.goodVO:getConfig("resource_category"),
		id = arg_6_0.goodVO:getConfig("resource_type")
	})

	return
end

function var_0_0.findUI(arg_7_0)
	arg_7_0.bg = arg_7_0._tf:Find("BG")

	local var_7_0 = arg_7_0._tf:Find("Panel")
	local var_7_1 = var_7_0:Find("Info")

	arg_7_0.nameText = var_7_1:Find("Name/Text")
	arg_7_0.descText = var_7_1:Find("Desc")
	arg_7_0.itemTF = var_7_1:Find("CommonItemTemplate")
	arg_7_0.countTF = var_7_1:Find("Count")
	arg_7_0.countText = var_7_1:Find("Count/Num")

	setText(var_7_1:Find("Count/Tip"), i18n("word_own1"))

	arg_7_0.titleTF = var_7_0:Find("Title")

	local var_7_2 = var_7_0:Find("Buy")

	arg_7_0.minusBtn = var_7_2:Find("Minus")
	arg_7_0.addBtn = var_7_2:Find("Add")
	arg_7_0.maxBtn = var_7_2:Find("Max")
	arg_7_0.buyNumText = var_7_2:Find("Num")
	arg_7_0.butCountText = var_7_0:Find("BuyCount/Num")
	arg_7_0.costNumText = var_7_0:Find("Cost/Num")
	arg_7_0.confirmBtn = var_7_0:Find("ConfirmBtn")
	arg_7_0.cancelBtn = var_7_0:Find("CancelBtn")

	return
end

function var_0_0.addListener(arg_8_0)
	onButton(arg_8_0, arg_8_0.bg, function()
		arg_8_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0.cancelBtn, function()
		arg_8_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_8_0, arg_8_0.confirmBtn, function()
		if arg_8_0.curBuyCount > arg_8_0.maxBuyCount then
			pg.TipsMgr.GetInstance():ShowTips(i18n("islandshop_tips4", arg_8_0.costItemInfo:getName()))

			return
		end

		pg.m02:sendNotification(GAME.ISLAND_SHOPPING, {
			shop = arg_8_0.actShopVO,
			arg1 = arg_8_0.goodVO.id,
			arg2 = arg_8_0.curBuyCount
		})

		return
	end, SFX_CANCEL)

	arg_8_0.pageUtil = PageUtil.New(arg_8_0.minusBtn, arg_8_0.addBtn, arg_8_0.maxBtn, arg_8_0.butCountText)

	arg_8_0.pageUtil:setNumUpdate(function(arg_11_0)
		arg_8_0:updateBuyPanelWithNum(arg_11_0)

		return
	end)
	arg_8_0.pageUtil:setAddNum(1)
	arg_8_0.pageUtil:setMaxNum(math.max(arg_8_0.maxBuyCount, 1))
	arg_8_0.pageUtil:setDefaultNum(1)

	return
end

function var_0_0.updateGoodInfoPanel(arg_12_0)
	local var_12_0 = Drop.New({
		type = arg_12_0.goodVO:getConfig("commodity_type"),
		id = arg_12_0.goodVO:getConfig("commodity_id"),
		count = arg_12_0.goodVO:getConfig("num")
	})

	updateDrop(arg_12_0.itemTF, var_12_0)

	local var_12_1, var_12_2 = var_12_0:getOwnedCount()

	setActive(arg_12_0.countTF, var_12_2)

	if var_12_2 then
		setText(arg_12_0.countText, var_12_1)
	end

	setText(arg_12_0.nameText, var_12_0:getConfig("name"))

	local var_12_3 = var_12_0.desc or var_12_0:getConfig("desc")

	setText(arg_12_0.descText, string.gsub(var_12_3, "<[^>]+>", ""))

	return
end

function var_0_0.updateBuyPanelWithNum(arg_13_0, arg_13_1)
	arg_13_0.curBuyCount = arg_13_1 or 0

	setText(arg_13_0.buyNumText, arg_13_0.curBuyCount)
	setText(arg_13_0.butCountText, arg_13_0.curBuyCount)
	setText(arg_13_0.costNumText, arg_13_0.curBuyCount * arg_13_0.perCost)

	return
end

return var_0_0
