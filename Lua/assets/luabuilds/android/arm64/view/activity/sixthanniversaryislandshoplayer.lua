local var_0_0 = class("SixthAnniversaryIslandShopLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "SixthAnniversaryIslandShopUI"
end

function var_0_0.setShop(arg_2_0, arg_2_1)
	arg_2_0.shop = arg_2_1
	arg_2_0.goodsList = arg_2_1:getSortGoods()
	arg_2_0.activity = getProxy(ActivityProxy):getActivityById(arg_2_1.activityId)

	return
end

function var_0_0.setPlayer(arg_3_0, arg_3_1)
	arg_3_0.player = arg_3_1

	local var_3_0 = arg_3_0.player:getResById(350) or 0

	setText(arg_3_0.rtRes:Find("Text"), var_3_0)

	return
end

function var_0_0.init(arg_4_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_4_0._tf)

	local var_4_0 = arg_4_0._tf:Find("main")

	setText(var_4_0:Find("time/Text"), i18n("islandshop_tips1"))

	arg_4_0.rtTime = var_4_0:Find("time/Text_2")
	arg_4_0.rtRes = var_4_0:Find("tpl")

	local var_4_1 = arg_4_0._tf:Find("main/view/content")

	arg_4_0.goodsItemList = UIItemList.New(var_4_1, var_4_1:Find("goods"))

	arg_4_0.goodsItemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			arg_4_0.goodsCardDic[arg_4_0.goodsList[arg_5_1].id] = arg_5_2

			onButton(arg_4_0, arg_5_2, function()
				arg_4_0:emit(SixthAnniversaryIslandShopMediator.OPEN_GOODS_WINDOW, arg_4_0.goodsList[arg_5_1])

				return
			end, SFX_PANEL)
			arg_4_0:updateGoodsCard(arg_5_2, arg_4_0.goodsList[arg_5_1])
		end

		return
	end)
	onButton(arg_4_0, arg_4_0._tf:Find("bg"), function()
		arg_4_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0._tf:Find("main/btn_back"), function()
		arg_4_0:closeView()

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.updateGoodsCard(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2:CheckCntLimit()

	setActive(arg_9_1:Find("mask"), not var_9_0)
	setGray(arg_9_1, var_9_0 and not arg_9_2:CheckArgLimit())

	local var_9_1 = arg_9_2:GetConsume()

	setActive(arg_9_1:Find("btn_unable"), var_9_1:getOwnedCount() < var_9_1.count)
	setButtonEnabled(arg_9_1, var_9_0)
	updateDrop(arg_9_1:Find("icon/IconTpl"), {
		type = arg_9_2:getConfig("commodity_type"),
		id = arg_9_2:getConfig("commodity_id"),
		count = arg_9_2:getConfig("num")
	})
	onNextTick(function()
		changeToScrollText(arg_9_1:Find("Text"), var_0:getConfig("name"))

		return
	end)
	GetImageSpriteFromAtlasAsync(Drop.New({
		type = arg_9_2:getConfig("resource_category"),
		id = arg_9_2:getConfig("resource_type")
	}):getIcon(), "", arg_9_1:Find("res_icon"))
	setText(arg_9_1:Find("btn_pay/cost"), arg_9_2:getConfig("resource_num"))
	setText(arg_9_1:Find("btn_unable/cost"), arg_9_2:getConfig("resource_num"))

	local var_9_2 = arg_9_2:getConfig("num_limit")

	if var_9_2 == 0 then
		setText(arg_9_1:Find("limit"), i18n("common_no_limit"))
	else
		setText(arg_9_1:Find("limit"), i18n("islandshop_tips2") .. math.max(arg_9_2:GetPurchasableCnt(), 0) .. "/" .. var_9_2)
	end

	return
end

function var_0_0.refreshGoodsCard(arg_11_0, arg_11_1)
	arg_11_0:updateGoodsCard(arg_11_0.goodsCardDic[arg_11_1], arg_11_0.shop:getGoodsById(arg_11_1))

	return
end

function var_0_0.didEnter(arg_12_0)
	local var_12_0 = pg.TimeMgr.GetInstance()

	arg_12_0.timer = Timer.New(function()
		if arg_12_0.delta then
			arg_12_0.delta = arg_12_0.delta - 1 or arg_12_0.activity.stopTime - var_12_0:GetServerTime()

			local var_13_0 = string.format("%d" .. i18n("word_date") .. "%d" .. i18n("word_hour"), var_12_0:parseTimeFrom(arg_12_0.delta))

			if arg_12_0.strTime ~= var_13_0 then
				setText(arg_12_0.rtTime, var_13_0)
			end

			return
		end
	end, 1)

	arg_12_0.timer.func()
	arg_12_0.timer:Start()

	arg_12_0.goodsCardDic = {}

	arg_12_0.goodsItemList:align(#arg_12_0.goodsList)

	return
end

function var_0_0.willExit(arg_14_0)
	arg_14_0.timer:Stop()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_14_0._tf)

	return
end

return var_0_0
