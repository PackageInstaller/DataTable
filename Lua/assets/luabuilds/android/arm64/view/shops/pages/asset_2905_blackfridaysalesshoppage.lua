local BlackFridaySalesShopPage = class("BlackFridaySalesShopPage", import("...base.BaseSubView"))

function BlackFridaySalesShopPage:getUIName()
	return "BlackFridaySalesShopPage"
end

function BlackFridaySalesShopPage:OnLoaded()
	self.scrollrect = self._tf:Find("scrollView"):GetComponent("LScrollRect")
	self.resTxt = self._tf:Find("res_pt/Text"):GetComponent(typeof(Text))
	self.resIcon = self._tf:Find("res_pt/icon")
	self.pagefooters = {
		self._tf:Find("pagefooter/ptShop"),
		self._tf:Find("pagefooter/gemShop"),
		self._tf:Find("pagefooter/coinShop")
	}

	setText(self._tf:Find("pagefooter/coinShop/Text"), i18n("blackfriday_coinshop"))
	setText(self._tf:Find("pagefooter/coinShop/mark"), i18n("blackfriday_coinshop"))
	setText(self._tf:Find("pagefooter/gemShop/Text"), i18n("blackfriday_gemshop"))
	setText(self._tf:Find("pagefooter/gemShop/mark"), i18n("blackfriday_gemshop"))
	setText(self._tf:Find("pagefooter/ptShop/Text"), i18n("blackfriday_ptshop"))
	setText(self._tf:Find("pagefooter/ptShop/mark"), i18n("blackfriday_ptshop"))

	self.ress = {
		self._tf:Find("res_pt/icon_pt"),
		self._tf:Find("res_pt/icon_gem"),
		self._tf:Find("res_pt/icon_coin")
	}
	self.resText = self._tf:Find("res_pt/Text")
	self.pagefooterWid = self.pagefooters[1].rect.width
	self.pagefooterStartPosX = self.pagefooters[1].anchoredPosition.x
	self.purchasePage = BlackFridayServerShopPurchasePanel.New(self._tf, self.event, self.contextData)
	self.multiWindow = NewServerShopMultiWindow.New(self._tf, self.event)
	self.singleWindow = NewServerShopSingleWindow.New(self._tf, self.event)
	self._tf.localPosition = Vector3(-6, -25)

	return
end

function BlackFridaySalesShopPage:UpdateRes()
	local var_3_1 = self.shop:GetResID(self.openIndex or 1)

	self.resTxt.text = getProxy(PlayerProxy):getRawData():getResource(var_3_1)

	if not self.isInitResIcon then
		self.isInitResIcon = true

		GetImageSpriteFromAtlasAsync(Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = var_3_1
		}):getIcon(), "", self.resIcon)
	end

	return
end

function BlackFridaySalesShopPage:OnInit()
	self.cards = {}

	function self.scrollrect.onInitItem(arg_5_0)
		self:OnInitItem(arg_5_0)

		return
	end

	function self.scrollrect.onUpdateItem(arg_6_0, arg_6_1)
		self:OnUpdateItem(arg_6_0, arg_6_1)

		return
	end

	self:Flush()

	return
end

function BlackFridaySalesShopPage:OnInitItem(arg_7_1)
	local var_7_0 = BlackFridayGoodsCard.New(arg_7_1)

	onButton(self, var_7_0._tf, function()
		self:OnClickCard(var_7_0)

		return
	end, SFX_PANEL)

	self.cards[arg_7_1] = var_7_0

	return
end

function BlackFridaySalesShopPage:OnClickCard(arg_9_1)
	if arg_9_1.commodity:Selectable() then
		self.purchasePage:ExecuteAction("Show", arg_9_1.commodity)
	else
		((arg_9_1.commodity:getConfig("goods_purchase_limit") == 1 or arg_9_1.commodity:getConfig("type") == 4) and self.singleWindow or self.multiWindow):ExecuteAction("Open", arg_9_1.commodity, function(arg_10_0, arg_10_1, arg_10_2)
			if not arg_10_0:CanPurchase() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

				return
			end

			pg.m02:sendNotification(GAME.NEW_SERVER_SHOP_SHOPPING, {
				actType = ActivityConst.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP,
				id = arg_10_0.id,
				selectedList = arg_10_0:getConfig("goods"),
				count = arg_10_1
			})

			return
		end)
	end

	return
end

function BlackFridaySalesShopPage:OnUpdateItem(arg_11_1, arg_11_2)
	if not self.cards[arg_11_2] then
		self:OnInitItem(arg_11_2)
	end

	self.cards[arg_11_2]:Update(self.displays[arg_11_1 + 1], self.shop)

	return
end

function BlackFridaySalesShopPage:FetchShop(arg_12_1)
	local var_12_0 = getProxy(ShopsProxy):GetNewServerShop(ActivityConst.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP)

	if not var_12_0 then
		pg.m02:sendNotification(GAME.GET_NEW_SERVER_SHOP, {
			callback = arg_12_1
		})
	else
		arg_12_1(var_12_0)
	end

	return
end

function BlackFridaySalesShopPage:SetShop(arg_13_1)
	self.shop = arg_13_1

	return
end

function BlackFridaySalesShopPage:Flush()
	if self.shop then
		self:Show()
		self:UpdatePageFooters()
		self:UpdateRes()
	else
		self:FetchShop(function(arg_15_0)
			if not arg_15_0 then
				return
			end

			self.shop = arg_15_0

			self:Show()
			self:UpdatePageFooters()
			self:UpdateRes()

			return
		end)
	end

	return
end

function BlackFridaySalesShopPage:UpdatePageFooters()
	self.pagefooterTrs = {}

	for iter_16_0 = 1, self.shop:GetTabCount() do
		self:UpdatePageFooter(self.pagefooters[iter_16_0], iter_16_0)

		self.pagefooterTrs[iter_16_0] = self.pagefooters[iter_16_0]
	end

	triggerButton(self.pagefooterTrs[self.contextData.index or 1])

	return
end

local var_0_1 = 0

function BlackFridaySalesShopPage:UpdatePageFooter(arg_17_1, arg_17_2)
	setAnchoredPosition(arg_17_1, {
		x = self.pagefooterStartPosX + (var_0_1 + self.pagefooterWid) * (arg_17_2 - 1)
	})
	self:OnSwitch(arg_17_1, function()
		self:SwitchTab(arg_17_2)

		return
	end)

	return
end

function BlackFridaySalesShopPage:OnSwitch(arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1:Find("mark")

	local function var_19_1()
		if self.markTr then
			setActive(self.markTr, false)
		end

		self.markTr = var_19_0

		setActive(var_19_0, true)

		return
	end

	onButton(self, arg_19_1, function()
		var_19_1()
		arg_19_2()

		return
	end, SFX_PANEL)

	return
end

function BlackFridaySalesShopPage:SwitchTab(arg_22_1)
	self.openIndex = arg_22_1

	if self.resTF then
		setActive(self.resTF, false)
	end

	self.resTF = self.ress[arg_22_1]

	setActive(self.resTF, true)
	self:UpdateRes()

	if self.shop:GetTabCount() <= 1 then
		setActive(self._tf:Find("pagefooter"), false)
	end

	self.displays = self.shop:GetGoodsByTabs(arg_22_1)

	table.sort(self.displays, function(arg_23_0, arg_23_1)
		return arg_23_0.id < arg_23_1.id
	end)
	self.scrollrect:SetTotalCount(#self.displays)

	return
end

function BlackFridaySalesShopPage:Refresh()
	self:SwitchTab(self.openIndex)
	self:UpdateRes()

	return
end

function BlackFridaySalesShopPage:updateLocalRedDotData(arg_25_1)
	if self:isPhaseTip(arg_25_1) then
		PlayerPrefs.SetInt("newserver_shop_phase_" .. arg_25_1 .. "_" .. self.playerId, 1)
		self:emit(NewServerCarnivalMediator.UPDATE_SHOP_RED_DOT)
	end

	return
end

function BlackFridaySalesShopPage:isTip()
	return false
end

function BlackFridaySalesShopPage:OnDestroy()
	self.scrollrect.onInitItem = nil
	self.scrollrect.onUpdateItem = nil

	for iter_27_0, iter_27_1 in pairs(self.cards) do
		iter_27_1:Dispose()
	end

	self.cards = nil

	self.purchasePage:Destroy()

	self.purchasePage = nil

	self.multiWindow:Destroy()

	self.multiWindow = nil

	self.singleWindow:Destroy()

	self.singleWindow = nil

	BlackFridaySalesShopPage.super.OnDestroy(self)

	return
end

return BlackFridaySalesShopPage
