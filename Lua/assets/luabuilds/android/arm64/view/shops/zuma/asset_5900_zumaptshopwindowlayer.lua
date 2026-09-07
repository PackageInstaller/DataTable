local ZumaPTShopWindowLayer = class("ZumaPTShopWindowLayer", import("...base.BaseUI"))

function ZumaPTShopWindowLayer:getUIName()
	return "ZumaPTShopWindowUI"
end

function ZumaPTShopWindowLayer:init()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function ZumaPTShopWindowLayer:didEnter()
	self:updateGoodInfoPanel()
	self:updateBuyPanelWithNum(1)

	return
end

function ZumaPTShopWindowLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self.pageUtil:Dispose()

	return
end

function ZumaPTShopWindowLayer:onBackPressed()
	self:closeView()

	return
end

function ZumaPTShopWindowLayer:initData()
	self.actShopVO = self.contextData.actShopVO
	self.goodVO = self.contextData.goodVO
	self.perCost = self.goodVO:getConfig("resource_num")
	self.maxBuyCount = math.floor(Drop.New({
		type = self.goodVO:getConfig("resource_category"),
		id = self.goodVO:getConfig("resource_type")
	}):getOwnedCount() / self.perCost)

	if self.goodVO:getConfig("num_limit") ~= 0 then
		self.maxBuyCount = math.min(self.maxBuyCount, math.max(self.goodVO:GetPurchasableCnt(), 0))
	end

	self.curBuyCount = 1
	self.costItemInfo = Drop.New({
		type = self.goodVO:getConfig("resource_category"),
		id = self.goodVO:getConfig("resource_type")
	})

	return
end

function ZumaPTShopWindowLayer:findUI()
	self.bg = self._tf:Find("BG")

	local var_7_0 = self._tf:Find("Panel")
	local var_7_1 = var_7_0:Find("Info")

	self.nameText = var_7_1:Find("Name/Text")
	self.descText = var_7_1:Find("Desc")
	self.itemTF = var_7_1:Find("CommonItemTemplate")
	self.countTF = var_7_1:Find("Count")
	self.countText = var_7_1:Find("Count/Num")

	setText(var_7_1:Find("Count/Tip"), i18n("word_own1"))

	self.titleTF = var_7_0:Find("Title")

	local var_7_2 = var_7_0:Find("Buy")

	self.minusBtn = var_7_2:Find("Minus")
	self.addBtn = var_7_2:Find("Add")
	self.maxBtn = var_7_2:Find("Max")
	self.buyNumText = var_7_2:Find("Num")
	self.butCountText = var_7_0:Find("BuyCount/Num")
	self.costNumText = var_7_0:Find("Cost/Num")
	self.confirmBtn = var_7_0:Find("ConfirmBtn")
	self.cancelBtn = var_7_0:Find("CancelBtn")

	return
end

function ZumaPTShopWindowLayer:addListener()
	local function var_8_0()
		self:closeView()

		return
	end

	onButton(self, self.bg, var_8_0, SFX_CANCEL)
	onButton(self, self.cancelBtn, var_8_0, SFX_CANCEL)
	onButton(self, self.confirmBtn, function()
		if self.curBuyCount > self.maxBuyCount then
			pg.TipsMgr.GetInstance():ShowTips(i18n("islandshop_tips4", self.costItemInfo:getName()))

			return
		end

		pg.m02:sendNotification(GAME.ISLAND_SHOPPING, {
			shop = self.actShopVO,
			arg1 = self.goodVO.id,
			arg2 = self.curBuyCount
		})

		return
	end, SFX_CANCEL)

	self.pageUtil = PageUtil.New(self.minusBtn, self.addBtn, self.maxBtn, self.butCountText)

	self.pageUtil:setNumUpdate(function(arg_11_0)
		self:updateBuyPanelWithNum(arg_11_0)

		return
	end)
	self.pageUtil:setAddNum(1)
	self.pageUtil:setMaxNum(math.max(self.maxBuyCount, 1))
	self.pageUtil:setDefaultNum(1)

	return
end

function ZumaPTShopWindowLayer:updateGoodInfoPanel()
	local var_12_0 = Drop.New({
		type = self.goodVO:getConfig("commodity_type"),
		id = self.goodVO:getConfig("commodity_id"),
		count = self.goodVO:getConfig("num")
	})

	updateDrop(self.itemTF, var_12_0)

	local var_12_1, var_12_2 = var_12_0:getOwnedCount()

	setActive(self.countTF, var_12_2)

	if var_12_2 then
		setText(self.countText, var_12_1)
	end

	setText(self.nameText, var_12_0:getConfig("name"))
	setText(self.descText, string.gsub(var_12_0.desc or var_12_0:getConfig("desc"), "<[^>]+>", ""))

	return
end

function ZumaPTShopWindowLayer:updateBuyPanelWithNum(arg_13_1)
	self.curBuyCount = arg_13_1 or 0

	setText(self.buyNumText, self.curBuyCount)
	setText(self.butCountText, self.curBuyCount)
	setText(self.costNumText, self.curBuyCount * self.perCost)

	return
end

return ZumaPTShopWindowLayer
