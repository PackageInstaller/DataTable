local GoldExchangeView = class("GoldExchangeView")

GoldExchangeView.itemid1 = 12
GoldExchangeView.itemid2 = 24
GoldExchangeView.const = 5
GoldExchangeView.goldNum = {
	[1] = 3000,
	[2] = 15000
}
GoldExchangeView.gemNum = {
	[1] = 100,
	[2] = 450
}

function GoldExchangeView:Ctor()
	pg.DelegateInfo.New(self)
	PoolMgr.GetInstance():GetUI("GoldExchangeWindow", false, function(arg_2_0)
		arg_2_0.transform:SetParent(pg.UIMgr.GetInstance().UIMain.transform, false)

		self._go = arg_2_0
		self._tf = arg_2_0.transform

		self:init()

		return
	end)

	return
end

function GoldExchangeView:init()
	self:initData()
	self:initUI()
	self:addListener()
	self:overLayMyself(true)
	self:updateView()

	return
end

function GoldExchangeView:exit()
	pg.DelegateInfo.Dispose(self)
	self:overLayMyself(false)
	PoolMgr.GetInstance():ReturnUI("GoldExchangeWindow", self._go)

	pg.goldExchangeMgr = nil

	return
end

function GoldExchangeView:initData()
	self.selectedIndex = 1
	self.selectedNum = 1
	self.selectedMax = 10
	self.player = getProxy(PlayerProxy):getData()

	return
end

function GoldExchangeView:initUI()
	self.bg = self._tf:Find("BG")
	self.btnBack = self._tf:Find("Window/top/btnBack")
	self.contentTF = self._tf:Find("Window/Content")
	self.goldTF = {}
	self.goldTF[1] = {}
	self.goldTF_1 = self.contentTF:Find("Gold1")
	self.goldTF[1].itemTF = self.goldTF_1
	self.goldTF[1].countTF = self.goldTF_1:Find("item/icon_bg/count")
	self.goldTF[1].priceTF = self.goldTF_1:Find("item/consume/contain/price")
	self.goldTF[1].selectedTF = self.goldTF_1:Find("item/selected")
	self.goldTF[1].selectedNumTF = self.goldTF[1].selectedTF:Find("reduce/Text")

	setText(self.goldTF[1].countTF, GoldExchangeView.goldNum[1])
	setText(self.goldTF[1].priceTF, GoldExchangeView.gemNum[1])

	self.goldTF[2] = {}
	self.goldTF_2 = self.contentTF:Find("Gold2")
	self.goldTF[2].itemTF = self.goldTF_2
	self.goldTF[2].countTF = self.goldTF_2:Find("item/icon_bg/count")
	self.goldTF[2].priceTF = self.goldTF_2:Find("item/consume/contain/price")
	self.goldTF[2].selectedTF = self.goldTF_2:Find("item/selected")
	self.goldTF[2].selectedNumTF = self.goldTF[2].selectedTF:Find("reduce/Text")

	setText(self.goldTF[2].countTF, GoldExchangeView.goldNum[2])
	setText(self.goldTF[2].priceTF, GoldExchangeView.gemNum[2])

	self.gemCountText = self.contentTF:Find("Tip/DiamondCount")
	self.goldCountText = self.contentTF:Find("Tip/GoldCount")
	self.shopBtn = self._tf:Find("Window/button_container/ShopBtn")
	self.confirmBtn = self._tf:Find("Window/button_container/ConfirmBtn")

	return
end

function GoldExchangeView:addListener()
	onButton(self, self.bg, function()
		self:exit()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnBack, function()
		self:exit()

		return
	end, SFX_CANCEL)
	onButton(self, self.shopBtn, function()
		if getProxy(ContextProxy):getContextByMediator(NewShopMainMediator) then
			self:exit()
		else
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
				wrap = ChargeScene.TYPE_ITEM
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		local var_11_0

		if self.selectedIndex == 1 then
			var_11_0 = GoldExchangeView.itemid1
		elseif self.selectedIndex == 2 then
			var_11_0 = GoldExchangeView.itemid2
		end

		pg.m02:sendNotification(GAME.SHOPPING, {
			isQuickShopping = true,
			id = var_11_0,
			count = self.selectedNum
		})
		self:exit()

		return
	end, SFX_PANEL)

	for iter_7_0 = 1, 2 do
		onButton(self, self.goldTF[iter_7_0].itemTF, function()
			if self.selectedIndex == iter_7_0 then
				self.selectedNum = math.min(self.selectedNum + 1, self.selectedMax)
			else
				self.selectedIndex = iter_7_0
				self.selectedNum = 1
			end

			self:updateView()

			return
		end, SFX_PANEL)
		onButton(self, self.goldTF[iter_7_0].selectedTF, function()
			if self.selectedNum > 1 then
				self.selectedNum = self.selectedNum - 1

				self:updateView()
			end

			return
		end, SFX_PANEL)
	end

	return
end

function GoldExchangeView:updateView()
	for iter_14_0 = 1, 2 do
		setActive(self.goldTF[iter_14_0].selectedTF, iter_14_0 == self.selectedIndex)
		setActive(self.goldTF[3 - iter_14_0].selectedTF, iter_14_0 ~= self.selectedIndex)

		if iter_14_0 == self.selectedIndex then
			setText(self.goldTF[iter_14_0].selectedNumTF, self.selectedNum)
		end
	end

	setText(self.gemCountText, GoldExchangeView.gemNum[self.selectedIndex] * self.selectedNum)

	if GoldExchangeView.gemNum[self.selectedIndex] * self.selectedNum > self.player:getTotalGem() then
		setTextColor(self.gemCountText, Color.red)
	else
		setTextColor(self.gemCountText, Color.yellow)
	end

	setText(self.goldCountText, var_14_1)

	return
end

function GoldExchangeView:overLayMyself(arg_15_1)
	if arg_15_1 == true then
		pg.UIMgr.GetInstance():BlurPanel(self._tf)
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	end

	return
end

return GoldExchangeView
