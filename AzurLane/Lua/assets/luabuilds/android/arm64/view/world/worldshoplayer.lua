local var_0_0 = class("WorldShopLayer", import("view.base.BaseUI"))

var_0_0.Listeners = {
	onUpdateGoods = "updateGoods"
}
var_0_0.optionsPath = {
	"adapt/top/title/option"
}

function var_0_0.getUIName(arg_1_0)
	return "WorldShopUI"
end

function var_0_0.getBGM(arg_2_0)
	return "story-richang"
end

function var_0_0.init(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(var_0_0.Listeners) do
		arg_3_0[iter_3_0] = function(...)
			var_0_0[iter_3_1](arg_3_0, ...)

			return
		end
	end

	arg_3_0.btnBack = arg_3_0._tf:Find("adapt/top/title/back_button")
	arg_3_0.rtRes = arg_3_0._tf:Find("adapt/middle/content/res")
	arg_3_0.rtResetTime = arg_3_0._tf:Find("adapt/middle/content/resetTimer")
	arg_3_0.rtResetTip = arg_3_0._tf:Find("adapt/middle/content/resetTip")
	arg_3_0.rtShop = arg_3_0._tf:Find("adapt/middle/content/world_shop")
	arg_3_0.goodsItemList = UIItemList.New(arg_3_0.rtShop:Find("content"), arg_3_0.rtShop:Find("content/item_tpl"))
	arg_3_0.singleWindow = OriginShopSingleWindow.New(arg_3_0._tf, arg_3_0.event)
	arg_3_0.multiWindow = OriginShopMultiWindow.New(arg_3_0._tf, arg_3_0.event)

	arg_3_0:OverlayPanel(arg_3_0._tf)

	return
end

function var_0_0.didEnter(arg_5_0)
	onButton(arg_5_0, arg_5_0.btnBack, function()
		arg_5_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_5_0, arg_5_0.rtRes, function()
		arg_5_0:emit(var_0_0.ON_DROP, {
			type = DROP_TYPE_RESOURCE,
			id = WorldConst.ResourceID
		})

		return
	end, SFX_PANEL)
	arg_5_0.goodsItemList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			local var_8_0 = Goods.Create(arg_5_0.goodsList[arg_8_1 + 1], Goods.TYPE_WORLD)

			WorldGoodsCard.New(arg_8_2):update(var_8_0)

			local var_8_1 = var_8_0:getLimitCount()

			setText(arg_8_2:Find("item/count_contain/label"), i18n("activity_shop_exchange_count"))
			setText(arg_8_2:Find("item/count_contain/count"), var_8_1 - var_8_0.buyCount .. "/" .. var_8_1)
			setTextColor(arg_8_2:Find("item/count_contain/count"), Color.New(unpack(ActivityGoodsCard.DefaultColor)))
			setTextColor(arg_8_2:Find("item/count_contain/label"), Color.New(unpack(ActivityGoodsCard.DefaultColor)))
			onButton(arg_5_0, arg_8_2, function()
				local var_9_0 = nowWorld()

				if var_8_0:getConfig("genre") == ShopArgs.WorldCollection then
					if var_9_0:GetTaskProxy():hasDoingCollectionTask() then
						pg.TipsMgr.GetInstance():ShowTips(i18n("world_collection_task_tip_1"))

						do return end

						goto label_9_0
					end
				end

				if var_8_0.id == 100000 and not underscore.any(underscore.values(var_9_0.pressingAwardDic), function(arg_10_0)
					return arg_10_0.flag
				end) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("world_complete_item_tip"))

					return
				end

				::label_9_0::

				if not var_8_0:canPurchase() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

					return
				end

				if var_8_1 > 1 then
					var_9_1:ExecuteAction("Open", var_8_0, function(arg_11_0, arg_11_1)
						arg_5_0:emit(WorldShopMediator.BUY_ITEM, arg_11_0.id, arg_11_1)

						return
					end)

					return
				end
			end, SFX_PANEL)
		end

		return
	end)
	arg_5_0:AddWorldListener()

	local var_5_0 = nowWorld()

	arg_5_0:updateGoods(nil, nil, var_5_0:GetWorldShopGoodsDictionary())

	local var_5_1 = var_5_0:IsReseted()

	setActive(arg_5_0.rtResetTime, var_5_1)
	setActive(arg_5_0.rtResetTip, not var_5_1)
	setText(arg_5_0.rtResetTime:Find("number"), math.floor(var_5_0:GetResetWaitingTime() / 0))
	setText(arg_5_0.rtResetTip:Find("info"), i18n("world_shop_preview_tip"))

	if var_5_1 then
		WorldGuider.GetInstance():PlayGuide("WorldG180")
	end

	return
end

function var_0_0.onBackPressed(arg_12_0)
	if arg_12_0.singleWindow:isShowing() then
		arg_12_0.singleWindow:Close()

		return
	end

	if arg_12_0.multiWindow:isShowing() then
		arg_12_0.multiWindow:Close()

		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(arg_12_0.btnBack)

	return
end

function var_0_0.willExit(arg_13_0)
	arg_13_0:UnOverlayPanel(arg_13_0._tf)
	arg_13_0:RemoveWorldListener()
	arg_13_0.singleWindow:Destroy()
	arg_13_0.multiWindow:Destroy()

	return
end

function var_0_0.setPlayer(arg_14_0, arg_14_1)
	arg_14_0.player = arg_14_1

	GetImageSpriteFromAtlasAsync(Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = WorldConst.ResourceID
	}):getIcon(), "", arg_14_0.rtRes:Find("icon"), true)
	setText(arg_14_0.rtRes:Find("number"), arg_14_0.player:getResource(WorldConst.ResourceID))

	return
end

function var_0_0.AddWorldListener(arg_15_0)
	nowWorld():AddListener(World.EventUpdateShopGoods, arg_15_0.onUpdateGoods)

	return
end

function var_0_0.RemoveWorldListener(arg_16_0)
	nowWorld():RemoveListener(World.EventUpdateShopGoods, arg_16_0.onUpdateGoods)

	return
end

function var_0_0.updateGoods(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = pg.TimeMgr.GetInstance()
	local var_17_1 = nowWorld()
	local var_17_2 = var_17_1:GetTaskProxy()

	for iter_17_0, iter_17_1 in pairs(arg_17_3) do
		if not var_17_0:inTime(pg.shop_template[iter_17_0].time) or not var_17_0:inTime(pg.shop_template[iter_17_0].time, var_17_1.expiredTime - 1) then
			-- block empty
		else
			if iter_17_0 == 100000 then
				local var_17_3 = nowWorld()

				if not var_17_3:IsReseted() then
					goto label_17_0
				end
			end

			if pg.shop_template[iter_17_0].genre == ShopArgs.WorldCollection and iter_17_1 == 0 and var_17_2:getRecycleTask(pg.shop_template[iter_17_0].effect_args[2]) then
				-- block empty
			else
				table.insert({}, {
					id = iter_17_0,
					count = iter_17_1
				})
			end
		end

		::label_17_0::
	end

	table.sort({}, CompareFuncs({
		function(arg_18_0)
			return pg.shop_template[arg_18_0.id].order
		end,
		function(arg_19_0)
			return arg_19_0.id
		end
	}))

	arg_17_0.goodsList = {}

	arg_17_0.goodsItemList:align(#arg_17_0.goodsList)

	return
end

return var_0_0
