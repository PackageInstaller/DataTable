local WorldShopLayer = class("WorldShopLayer", import("view.base.BaseUI"))

WorldShopLayer.Listeners = {
	onUpdateGoods = "updateGoods"
}
WorldShopLayer.optionsPath = {
	"adapt/top/title/option"
}

function WorldShopLayer:getUIName()
	return "WorldShopUI"
end

function WorldShopLayer:getBGM()
	return "story-richang"
end

function WorldShopLayer:init()
	for iter_3_0, iter_3_1 in pairs(WorldShopLayer.Listeners) do
		self[iter_3_0] = function(...)
			WorldShopLayer[iter_3_1](self, ...)

			return
		end
	end

	self.btnBack = self._tf:Find("adapt/top/title/back_button")
	self.rtRes = self._tf:Find("adapt/middle/content/res")
	self.rtResetTime = self._tf:Find("adapt/middle/content/resetTimer")
	self.rtResetTip = self._tf:Find("adapt/middle/content/resetTip")
	self.rtShop = self._tf:Find("adapt/middle/content/world_shop")
	self.goodsItemList = UIItemList.New(self.rtShop:Find("content"), self.rtShop:Find("content/item_tpl"))
	self.singleWindow = OriginShopSingleWindow.New(self._tf, self.event)
	self.multiWindow = OriginShopMultiWindow.New(self._tf, self.event)

	self:OverlayPanel(self._tf)

	return
end

function WorldShopLayer:didEnter()
	onButton(self, self.btnBack, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.rtRes, function()
		self:emit(WorldShopLayer.ON_DROP, {
			type = DROP_TYPE_RESOURCE,
			id = WorldConst.ResourceID
		})

		return
	end, SFX_PANEL)
	self.goodsItemList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			local var_8_0 = Goods.Create(self.goodsList[arg_8_1 + 1], Goods.TYPE_WORLD)

			WorldGoodsCard.New(arg_8_2):update(var_8_0)

			local var_8_1 = var_8_0:getLimitCount()

			setText(arg_8_2:Find("item/count_contain/label"), i18n("activity_shop_exchange_count"))
			setText(arg_8_2:Find("item/count_contain/count"), var_8_1 - var_8_0.buyCount .. "/" .. var_8_1)
			setTextColor(arg_8_2:Find("item/count_contain/count"), Color.New(unpack(ActivityGoodsCard.DefaultColor)))
			setTextColor(arg_8_2:Find("item/count_contain/label"), Color.New(unpack(ActivityGoodsCard.DefaultColor)))
			onButton(self, arg_8_2, function()
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

				;((var_8_1 > 1 or nil) and (self.multiWindow or self.singleWindow)):ExecuteAction("Open", var_8_0, function(arg_11_0, arg_11_1)
					self:emit(WorldShopMediator.BUY_ITEM, arg_11_0.id, arg_11_1)

					return
				end)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self:AddWorldListener()

	local var_5_0 = nowWorld()

	self:updateGoods(nil, nil, var_5_0:GetWorldShopGoodsDictionary())

	local var_5_1 = var_5_0:IsReseted()

	setActive(self.rtResetTime, var_5_1)
	setActive(self.rtResetTip, not var_5_1)
	setText(self.rtResetTime:Find("number"), math.floor(var_5_0:GetResetWaitingTime() / 0))
	setText(self.rtResetTip:Find("info"), i18n("world_shop_preview_tip"))

	if var_5_1 then
		WorldGuider.GetInstance():PlayGuide("WorldG180")
	end

	return
end

function WorldShopLayer:onBackPressed()
	if self.singleWindow:isShowing() then
		self.singleWindow:Close()

		return
	end

	if self.multiWindow:isShowing() then
		self.multiWindow:Close()

		return
	end

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(self.btnBack)

	return
end

function WorldShopLayer:willExit()
	self:UnOverlayPanel(self._tf)
	self:RemoveWorldListener()
	self.singleWindow:Destroy()
	self.multiWindow:Destroy()

	return
end

function WorldShopLayer:setPlayer(arg_14_1)
	self.player = arg_14_1

	GetImageSpriteFromAtlasAsync(Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = WorldConst.ResourceID
	}):getIcon(), "", self.rtRes:Find("icon"), true)
	setText(self.rtRes:Find("number"), self.player:getResource(WorldConst.ResourceID))

	return
end

function WorldShopLayer:AddWorldListener()
	nowWorld():AddListener(World.EventUpdateShopGoods, self.onUpdateGoods)

	return
end

function WorldShopLayer:RemoveWorldListener()
	nowWorld():RemoveListener(World.EventUpdateShopGoods, self.onUpdateGoods)

	return
end

function WorldShopLayer:updateGoods(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = pg.TimeMgr.GetInstance()
	local var_17_1 = nowWorld()
	local var_17_2 = var_17_1:GetTaskProxy()
	local var_17_3 = {}

	for iter_17_0, iter_17_1 in pairs(arg_17_3) do
		if not var_17_0:inTime(pg.shop_template[iter_17_0].time) or not var_17_0:inTime(pg.shop_template[iter_17_0].time, var_17_1.expiredTime - 1) then
			-- block empty
		else
			if iter_17_0 == 100000 then
				if not nowWorld():IsReseted() then
					goto label_17_0
				end
			end

			if pg.shop_template[iter_17_0].genre == ShopArgs.WorldCollection and iter_17_1 == 0 and var_17_2:getRecycleTask(pg.shop_template[iter_17_0].effect_args[2]) then
				-- block empty
			else
				table.insert(var_17_3, {
					id = iter_17_0,
					count = iter_17_1
				})
			end
		end

		::label_17_0::
	end

	table.sort(var_17_3, CompareFuncs({
		function(arg_18_0)
			return pg.shop_template[arg_18_0.id].order
		end,
		function(arg_19_0)
			return arg_19_0.id
		end
	}))

	self.goodsList = var_17_3

	self.goodsItemList:align(#self.goodsList)

	return
end

return WorldShopLayer
