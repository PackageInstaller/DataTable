local IslandTradeConfirmWindow = class("IslandTradeConfirmWindow", import(".IslandBaseMsgboxWindow"))

function IslandTradeConfirmWindow:getUIName()
	return "IslandTradeConfirmUI"
end

function IslandTradeConfirmWindow:OnLoaded()
	self.panel = self._tf:Find("panel")
	self.closeBtn = self.panel:Find("closeBtn")
	self.icon = self.panel:Find("icon")
	self.name = self.panel:Find("name"):GetComponent(typeof(Text))
	self.desc = self.panel:Find("desc"):GetComponent(typeof(Text))
	self.count = self.panel:Find("count/number_panel/value"):GetComponent(typeof(Text))
	self.leftBtn = self.panel:Find("count/left")
	self.rightBtn = self.panel:Find("count/right")
	self.minBtn = self.panel:Find("count/min")
	self.maxBtn = self.panel:Find("count/max")
	self.bottomItemList = UIItemList.New(self.panel:Find("itemList/Viewport/Content"), self.panel:Find("itemList/Viewport/Content/IslandItemTpl"))
	self.buyBtn = self.panel:Find("buyBtn")
	self.consumeIcon = self.buyBtn:Find("consume/icon")
	self.consumeCount = self.buyBtn:Find("consume/count"):GetComponent(typeof(Text))

	setText(self._tf:Find("panel/getDesc"), i18n("island_3Dshop_buy_tip0"))

	return
end

function IslandTradeConfirmWindow:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	pressPersistTrigger(self.leftBtn, 0.5, function(arg_6_0)
		self:UpdateCount(self.curCount - 1)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(self.rightBtn, 0.5, function(arg_7_0)
		self:UpdateCount(self.curCount + 1)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(self.minBtn, 0.5, function(arg_8_0)
		self:UpdateCount(self.curCount - 10)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(self.maxBtn, 0.5, function(arg_9_0)
		self:UpdateCount(self.curCount + 10)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	self.bottomItemList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_10_2, {
				count = 1,
				type = DROP_TYPE_ISLAND_ITEM,
				id = self.awards[arg_10_1 + 1].id
			})

			if self.settings.mode == IslandConst.TRADE_PURCHASE then
				setText(arg_10_2:Find("icon_bg/count_bg/count"), self.curCount)
			elseif self.settings.mode == IslandConst.TRADE_SELL then
				setText(arg_10_2:Find("icon_bg/count_bg/count"), self.price * self.curCount)
			end
		end

		return
	end)
	onButton(self, self.buyBtn, function()
		if self.curCount <= 0 then
			if self.settings.mode == IslandConst.TRADE_PURCHASE then
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_trade_cnt_inadequate"))
			elseif self.settings.mode == IslandConst.TRADE_SELL then
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_trade_sell_failed_label"))
			end

			return
		end

		if self.curCount > self.settings.maxCnt then
			if settings.mode == IslandConst.TRADE_PURCHASE then
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_trade_purchase_failed_label"))
			elseif settings.mode == IslandConst.TRADE_SELL then
				pg.TipsMgr.GetInstance():ShowTips(i18n("island_trade_sell_failed_label2"))
			end

			return
		end

		if self.settings.onYes then
			self.settings.onYes(self.curCount)
		end

		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function IslandTradeConfirmWindow:OnShow()
	self.curCount = 1
	self.price = self.settings.price or 0
	self.maxCnt = self.settings.maxCnt or 0
	self.awards = {}

	local var_12_0 = IslandItem.New({
		id = IslandItem.PEARL_ID
	})
	local var_12_1 = IslandItem.New({
		id = IslandItem.GOLD_ID
	})

	if self.settings.mode == IslandConst.TRADE_PURCHASE then
		setText(self._tf:Find("panel/title"), i18n("island_trade_purchase_sub_label"))
		setText(self._tf:Find("panel/buyBtn/text"), i18n("island_trade_purchase_sub_label"))
		GetImageSpriteFromAtlasAsync("island/" .. var_12_1:GetIcon(), "", self.consumeIcon)
		table.insert(self.awards, var_12_0)
	elseif self.settings.mode == IslandConst.TRADE_SELL then
		setText(self._tf:Find("panel/title"), i18n("island_trade_sell_sub_label"))
		setText(self._tf:Find("panel/buyBtn/text"), i18n("island_trade_sell_sub_label"))
		GetImageSpriteFromAtlasAsync("island/" .. var_12_0:GetIcon(), "", self.consumeIcon)
		table.insert(self.awards, var_12_1)
	end

	GetImageSpriteFromAtlasAsync("island/" .. var_12_0:GetIcon(), "", self.icon)

	self.name.text = var_12_0:getConfig("name")
	self.desc.text = var_12_0:getConfig("desc")

	self:UpdateCount(self.curCount)

	return
end

function IslandTradeConfirmWindow:UpdateCount(arg_13_1)
	self.curCount = math.min(self.maxCnt, math.max(0, arg_13_1))
	self.count.text = self.curCount

	if self.settings.mode == IslandConst.TRADE_PURCHASE then
		self.consumeCount.text = self.curCount * self.price
	elseif self.settings.mode == IslandConst.TRADE_SELL then
		self.consumeCount.text = self.curCount
	end

	self.bottomItemList:align(#self.awards)

	return
end

function IslandTradeConfirmWindow:OnHide()
	return
end

return IslandTradeConfirmWindow
