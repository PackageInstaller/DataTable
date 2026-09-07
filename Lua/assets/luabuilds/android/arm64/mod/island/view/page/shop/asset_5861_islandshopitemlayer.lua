local IslandShopItemLayer = class("IslandShopItemLayer", import("...base.IslandBasePage"))

function IslandShopItemLayer:getUIName()
	return "IslandShopItemUI"
end

function IslandShopItemLayer:OnLoaded()
	self.panel = self._tf:Find("panel")
	self.closeBtn = self.panel:Find("closeBtn")
	self.icon = self.panel:Find("icon")
	self.discount = self.panel:Find("discount")
	self.remainTimer = self.panel:Find("remainTimer")
	self.name = self.panel:Find("name")
	self.desc = self.panel:Find("desc")
	self.buyDesc = self.panel:Find("buyDesc")
	self.count = self.panel:Find("count/number_panel/value")
	self.leftBtn = self.panel:Find("count/left")
	self.rightBtn = self.panel:Find("count/right")
	self.minBtn = self.panel:Find("count/min")
	self.maxBtn = self.panel:Find("count/max")
	self.bottomItemList = UIItemList.New(self.panel:Find("itemList/Viewport/Content"), self.panel:Find("itemList/Viewport/Content/IslandItemTpl"))
	self.buyBtn = self.panel:Find("buyBtn")
	self.consumeIcon = self.buyBtn:Find("consume/icon")
	self.consumeCount = self.buyBtn:Find("consume/count")

	setText(self._tf:Find("panel/title"), i18n("island_3Dshop_buy_confirm"))
	setText(self._tf:Find("panel/buyBtn/text"), i18n("island_3Dshop_buy"))
	setText(self._tf:Find("panel/getDesc"), i18n("island_3Dshop_buy_tip0"))

	return
end

function IslandShopItemLayer:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function IslandShopItemLayer:SetUp(arg_6_1, arg_6_2)
	if self.charaId then
		GetImageSpriteFromAtlasAsync("island/islandshipiconall/" .. self.charaId, "", self.icon)
	else
		GetImageSpriteFromAtlasAsync(arg_6_2:GetIcon(), "", self.icon)
	end

	setText(self.name, arg_6_2:GetName())
	setText(self.desc, arg_6_2:GetDescription())
	setActive(self.discount, arg_6_2:GetDiscount() ~= 0)
	setText(self.discount:Find("Text"), "-" .. arg_6_2:GetDiscount() .. "%")

	local var_6_0 = arg_6_2:IsTimeLimitCommodity()

	setActive(self.remainTimer, var_6_0)

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

		self:StartTimer(function()
			local var_7_0 = var_6_2 - pg.TimeMgr.GetInstance():GetServerTime()

			if var_7_0 < var_6_3 then
				setText(self.remainTimer:Find("text"), (pg.TimeMgr.GetInstance():DescCDTime(var_7_0)))
			else
				setText(self.remainTimer:Find("text"), i18n("island_3Dshop_goods_time", math.floor(var_7_0 / var_6_3)))
			end

			return
		end)
	end

	local var_6_4 = i18n("island_3Dshop_buy_no")

	if arg_6_2:GetMaxNum() ~= 0 then
		var_6_4 = var_6_4 .. i18n("island_3Dshop_last", arg_6_2:GetMaxNum() - arg_6_2.purchasedNum)
	end

	setText(self.buyDesc, var_6_4)

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
		elseif var_6_6[2] == 4 or var_6_6[2] == 14 then
			var_6_8 = math.floor(var_6_9:getTotalGem() / var_6_7)
		end
	elseif var_6_6[1] == DROP_TYPE_ISLAND_ITEM then
		var_6_8 = math.floor(getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetOwnCount(var_6_6[2]) / var_6_7)
	end

	local var_6_10 = math.clamp(var_6_8, 1, var_6_5)
	local var_6_11 = arg_6_2:GetItemsWithPt()

	local function var_6_12(arg_8_0)
		arg_8_0 = math.clamp(arg_8_0, 1, var_6_10)
		self.curCount = arg_8_0

		setText(self.count, arg_8_0)

		for iter_8_0 = 1, #self.itemsCountTFs do
			setText(self.itemsCountTFs[iter_8_0], var_6_11[iter_8_0][3] * self.curCount)
		end

		setText(self.consumeCount, math.ceil(var_6_7 * self.curCount))

		return
	end

	pressPersistTrigger(self.leftBtn, 0.5, function(arg_9_0)
		var_6_12(self.curCount - 1)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(self.rightBtn, 0.5, function(arg_10_0)
		var_6_12(self.curCount + 1)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(self.minBtn, 0.5, function(arg_11_0)
		var_6_12(self.curCount - 10)

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(self.maxBtn, 0.5, function(arg_12_0)
		var_6_12(self.curCount + 10)

		return
	end, nil, true, true, 0.1, SFX_PANEL)

	self.itemsCountTFs = {}

	self.bottomItemList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_13_2, {
				type = var_6_11[arg_13_1 + 1][1],
				id = var_6_11[arg_13_1 + 1][2],
				count = var_6_11[arg_13_1 + 1][3]
			}, {
				style = "island"
			})
			table.insert(self.itemsCountTFs, arg_13_2:Find("icon_bg/count_bg/count"))
		end

		return
	end)
	self.bottomItemList:align(#var_6_11)
	var_6_12(1)

	if var_6_6[1] == DROP_TYPE_RESOURCE then
		GetImageSpriteFromAtlasAsync(Drop.New({
			type = var_6_6[1],
			id = var_6_6[2]
		}):getIcon(), "", self.consumeIcon)
	elseif var_6_6[1] == DROP_TYPE_ISLAND_ITEM then
		GetImageSpriteFromAtlasAsync(Drop.New({
			type = var_6_6[1],
			id = var_6_6[2]
		}):getIcon(), "", self.consumeIcon)
	end

	onButton(self, self.buyBtn, function()
		self:emit(IslandMediator.BUY_COMMODITY, {
			{
				key = arg_6_1,
				value1 = arg_6_2.id,
				value2 = self.curCount
			}
		})

		return
	end, SFX_PANEL)

	return
end

function IslandShopItemLayer:AddListeners()
	self:AddListener(GAME.ISLAND_SHOP_OP_DONE, self.Hide)

	return
end

function IslandShopItemLayer:RemoveListeners()
	self:RemoveListener(GAME.ISLAND_SHOP_OP_DONE, self.Hide)

	return
end

function IslandShopItemLayer:OnShow(arg_17_1, arg_17_2, arg_17_3)
	self:BlurPanel(self._tf)

	self.shopId = arg_17_1
	self.commodity = arg_17_2

	self:SetUp(arg_17_1, arg_17_2)

	if arg_17_3 then
		self.charaId = arg_17_3
	end

	return
end

function IslandShopItemLayer:Refresh()
	self:SetUp(self.shopId, self.commodity)

	return
end

function IslandShopItemLayer:StartTimer(arg_19_1)
	self.timer = Timer.New(arg_19_1, 1, -1)

	self.timer:Start()

	return
end

function IslandShopItemLayer:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandShopItemLayer:OnHide()
	self:RemoveTimer()
	self:UnOverlayPanel(self._tf, self._parentTf)

	return
end

function IslandShopItemLayer:OnDestroy()
	return
end

return IslandShopItemLayer
