local var_0_0 = class("SixthAnniversaryIslandShopWindowLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "SixthAnniversaryIslandGoodsWindow"
end

function var_0_0.setGoods(arg_2_0, arg_2_1)
	arg_2_0.goods = arg_2_1
	arg_2_0.singleCost = arg_2_1:getConfig("resource_num")
	arg_2_0.max = math.floor(Drop.New({
		type = arg_2_1:getConfig("resource_category"),
		id = arg_2_1:getConfig("resource_type")
	}):getOwnedCount() / arg_2_0.singleCost)

	if arg_2_1:getConfig("num_limit") ~= 0 then
		arg_2_0.max = math.min(arg_2_0.max, math.max(arg_2_1:GetPurchasableCnt(), 0))
	end

	return
end

function var_0_0.init(arg_3_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)

	local var_3_0 = arg_3_0._tf:Find("content/calc")

	setText(var_3_0:Find("cost/Text"), i18n("islandshop_tips3"))

	arg_3_0.rtCost = var_3_0:Find("cost/number")
	arg_3_0.rtCount = var_3_0:Find("dashboard/view/Text")

	onButton(arg_3_0, var_3_0:Find("dashboard/minus_10"), function()
		arg_3_0:updateCount(-10)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, var_3_0:Find("dashboard/plus_10"), function()
		arg_3_0:updateCount(10)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, var_3_0:Find("dashboard/view/minus"), function()
		arg_3_0:updateCount(-1)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, var_3_0:Find("dashboard/view/plus"), function()
		arg_3_0:updateCount(1)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, var_3_0:Find("dashboard/plus_max"), function()
		arg_3_0:updateCount(arg_3_0.max - arg_3_0.count)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("bg"), function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("content/bottom/btn_cancel"), function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("content/bottom/btn_confirm"), function()
		if arg_3_0.count > arg_3_0.max then
			pg.TipsMgr.GetInstance():ShowTips(i18n("islandshop_tips4", Drop.New({
				type = arg_3_0.goods:getConfig("resource_category"),
				id = arg_3_0.goods:getConfig("resource_type")
			}):getName()))

			return
		end

		arg_3_0:emit(SixthAnniversaryIslandShopWindowMediator.SHOPPING_CONFIRM, arg_3_0.count)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.updateCount(arg_12_0, arg_12_1)
	arg_12_0.count = math.clamp(arg_12_0.count + arg_12_1, 1, math.max(arg_12_0.max, 1))

	setText(arg_12_0.rtCount, arg_12_0.count)
	setText(arg_12_0.rtCost, arg_12_0.count * arg_12_0.singleCost)

	return
end

function var_0_0.didEnter(arg_13_0)
	local var_13_0 = {
		type = arg_13_0.goods:getConfig("commodity_type"),
		id = arg_13_0.goods:getConfig("commodity_id"),
		count = arg_13_0.goods:getConfig("num")
	}
	local var_13_1 = arg_13_0._tf:Find("content/main")

	updateDrop(var_13_1:Find("icon/IconTpl"), var_13_0)

	local var_13_2, var_13_3 = var_13_0:getOwnedCount()

	setActive(var_13_1:Find("owner"), var_13_3)

	if var_13_3 then
		setText(var_13_1:Find("owner"), i18n("word_own1") .. var_13_2)
	end

	setText(var_13_1:Find("line/name"), var_13_0:getConfig("name"))

	local var_13_4 = var_13_0.desc or var_13_0:getConfig("desc")

	setText(var_13_1:Find("line/content/Text"), string.gsub(var_13_4, "<[^>]+>", ""))
	GetImageSpriteFromAtlasAsync(Drop.New({
		type = arg_13_0.goods:getConfig("resource_category"),
		id = arg_13_0.goods:getConfig("resource_type")
	}):getIcon(), "", arg_13_0._tf:Find("content/calc/cost/icon"))

	arg_13_0.count = 1

	arg_13_0:updateCount(0)

	return
end

function var_0_0.willExit(arg_14_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_14_0._tf)

	return
end

return var_0_0
