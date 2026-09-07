local NewServerShopPage = class("NewServerShopPage", import("...base.BaseSubView"))

function NewServerShopPage:getUIName()
	return "NewServerShopPage"
end

function NewServerShopPage:OnLoaded()
	self.scrollrect = self._tf:Find("scrollView"):GetComponent("LScrollRect")
	self.resTxt = self._tf:Find("res_pt/Text"):GetComponent(typeof(Text))
	self.resIcon = self._tf:Find("res_pt/icon")
	self.pagefooters = {
		self._tf:Find("pagefooter/tpl")
	}
	self.pagefooterWid = self.pagefooters[1].rect.width
	self.pagefooterStartPosX = self.pagefooters[1].anchoredPosition.x
	self.purchasePage = NewServerShopPurchasePanel.New(self._tf, self.event, self.contextData)
	self.multiWindow = NewServerShopMultiWindow.New(self._tf, self.event)
	self.singleWindow = NewServerShopSingleWindow.New(self._tf, self.event)
	self._tf.localPosition = Vector3(-6, -25)

	return
end

function NewServerShopPage:UpdateRes()
	local var_3_0 = self.shop:GetPtId()

	self.resTxt.text = getProxy(PlayerProxy):getRawData():getResource(var_3_0)

	if not self.isInitResIcon then
		self.isInitResIcon = true

		GetImageSpriteFromAtlasAsync(Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = var_3_0
		}):getIcon(), "", self.resIcon)
	end

	return
end

function NewServerShopPage:OnInit()
	self.cards = {}

	function self.scrollrect.onInitItem(arg_5_0)
		self:OnInitItem(arg_5_0)

		return
	end

	function self.scrollrect.onUpdateItem(arg_6_0, arg_6_1)
		self:OnUpdateItem(arg_6_0, arg_6_1)

		return
	end

	return
end

function NewServerShopPage:OnInitItem(arg_7_1)
	local var_7_0 = NewServerGoodsCard.New(arg_7_1)

	onButton(self, var_7_0._tf, function()
		self:OnClickCard(var_7_0)

		return
	end, SFX_PANEL)

	self.cards[arg_7_1] = var_7_0

	return
end

function NewServerShopPage:OnClickCard(arg_9_1)
	local var_9_0, var_9_1 = arg_9_1.commodity:IsOpening(self.shop:GetStartTime())

	if not var_9_0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("newserver_shop_timelimit", (var_9_1.day > 0 and var_9_1.day .. i18n("word_date") or "") .. var_9_1.hour .. i18n("word_hour")))

		return
	end

	if arg_9_1.commodity:Selectable() then
		self.purchasePage:ExecuteAction("Show", arg_9_1.commodity)
	else
		((arg_9_1.commodity:getConfig("goods_purchase_limit") == 1 or arg_9_1.commodity:getConfig("type") == 4) and self.singleWindow or self.multiWindow):ExecuteAction("Open", arg_9_1.commodity, function(arg_10_0, arg_10_1, arg_10_2)
			if not arg_10_0:CanPurchase() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

				return
			end

			pg.m02:sendNotification(GAME.NEW_SERVER_SHOP_SHOPPING, {
				id = arg_10_0.id,
				selectedList = arg_10_0:getConfig("goods"),
				count = arg_10_1
			})

			return
		end)
	end

	return
end

function NewServerShopPage:OnUpdateItem(arg_11_1, arg_11_2)
	if not self.cards[arg_11_2] then
		self:OnInitItem(arg_11_2)
	end

	self.cards[arg_11_2]:Update(self.displays[arg_11_1 + 1], self.shop)

	return
end

function NewServerShopPage:FetchShop(arg_12_1)
	local var_12_0 = getProxy(ShopsProxy):GetNewServerShop(ActivityConst.ACTIVITY_TYPE_NEWSERVER_SHOP)

	if not var_12_0 then
		pg.m02:sendNotification(GAME.GET_NEW_SERVER_SHOP, {
			callback = arg_12_1
		})
	else
		arg_12_1(var_12_0)
	end

	return
end

function NewServerShopPage:SetShop(arg_13_1)
	self.shop = arg_13_1

	return
end

function NewServerShopPage:Flush()
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

local function var_0_1(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.pagefooters[arg_16_1]

	if not arg_16_0.pagefooters[arg_16_1] then
		var_16_0 = Object.Instantiate(arg_16_0.pagefooters[1], arg_16_0.pagefooters[1].parent)
		arg_16_0.pagefooters[arg_16_1] = var_16_0
	end

	setActive(var_16_0, true)

	return var_16_0
end

function NewServerShopPage:UpdatePageFooters()
	local var_17_0 = self.shop:GetPhases()

	self.pagefooterTrs = {}

	for iter_17_0 = 1, #var_17_0 do
		local var_17_1 = var_0_1(self, iter_17_0)

		self:UpdatePageFooter(var_17_1, iter_17_0)

		self.pagefooterTrs[iter_17_0] = var_17_1
	end

	for iter_17_1 = #var_17_0 + 1, #self.pagefooters do
		setActive(self.pagefooters[iter_17_1], false)
	end

	triggerButton(self.pagefooterTrs[self.contextData.index or 1])

	return
end

local var_0_2 = 0

function NewServerShopPage:UpdatePageFooter(arg_18_1, arg_18_2)
	setAnchoredPosition(arg_18_1, {
		x = self.pagefooterStartPosX + (var_0_2 + self.pagefooterWid) * (arg_18_2 - 1)
	})

	arg_18_1:Find("Text"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/newservershopui_atlas", "p" .. arg_18_2)
	arg_18_1:Find("mark"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/newservershopui_atlas", "p" .. arg_18_2 .. "_s")

	local var_18_0 = arg_18_1:Find("lock")

	if arg_18_2 ~= 1 then
		var_18_0:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/newservershopui_atlas", "p" .. arg_18_2 .. "_l")
	end

	setActive(var_18_0, not self.shop:IsOpenPhase(arg_18_2))
	setActive(arg_18_1:Find("tip"), self:isPhaseTip(arg_18_2))
	self:OnSwitch(arg_18_1, function()
		return self.openIndex ~= arg_18_2
	end, function()
		self:SwitchPhase(arg_18_2)
		setActive(arg_18_1:Find("tip"), self:isPhaseTip(arg_18_2))

		return
	end)

	return
end

function NewServerShopPage:OnSwitch(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_1:Find("mark")

	local function var_21_1()
		if self.markTr then
			setActive(self.markTr, false)
		end

		self.markTr = var_21_0

		setActive(var_21_0, true)

		return
	end

	onButton(self, arg_21_1, function()
		if not arg_21_2() then
			return
		end

		var_21_1()
		arg_21_3()

		return
	end, SFX_PANEL)

	return
end

function NewServerShopPage:SwitchPhase(arg_24_1)
	self.displays = self.shop:GetOpeningGoodsList(self.shop:GetPhases()[arg_24_1])

	table.sort(self.displays, function(arg_25_0, arg_25_1)
		local var_25_0 = arg_25_0:CanPurchase() and 1 or 0
		local var_25_1 = arg_25_1:CanPurchase() and 1 or 0

		if var_25_0 == var_25_1 then
			return arg_25_0.id < arg_25_1.id
		else
			return var_25_1 < var_25_0
		end

		return
	end)
	self.scrollrect:SetTotalCount(#self.displays)

	self.openIndex = arg_24_1

	self:updateLocalRedDotData(arg_24_1)

	return
end

function NewServerShopPage:Refresh()
	self:SwitchPhase(self.openIndex)
	self:UpdateRes()

	return
end

function NewServerShopPage:isPhaseTip(arg_27_1)
	self.playerId = self.playerId or getProxy(PlayerProxy):getData().id

	return arg_27_1 ~= 1 and self.shop:IsOpenPhase(arg_27_1) and PlayerPrefs.GetInt("newserver_shop_phase_" .. arg_27_1 .. "_" .. self.playerId) == 0
end

function NewServerShopPage:updateLocalRedDotData(arg_28_1)
	if self:isPhaseTip(arg_28_1) then
		PlayerPrefs.SetInt("newserver_shop_phase_" .. arg_28_1 .. "_" .. self.playerId, 1)
		self:emit(NewServerCarnivalMediator.UPDATE_SHOP_RED_DOT)
	end

	return
end

function NewServerShopPage:isTip()
	self.playerId = self.playerId or getProxy(PlayerProxy):getData().id

	if PlayerPrefs.GetInt("newserver_shop_first_" .. self.playerId) == 0 then
		return true
	end

	for iter_29_0, iter_29_1 in pairs(self.shop:GetPhases()) do
		if self:isPhaseTip(iter_29_0) then
			return true
		end
	end

	return false
end

function NewServerShopPage:OnDestroy()
	self.scrollrect.onInitItem = nil
	self.scrollrect.onUpdateItem = nil

	for iter_30_0, iter_30_1 in pairs(self.cards) do
		iter_30_1:Dispose()
	end

	self.cards = nil

	self.purchasePage:Destroy()

	self.purchasePage = nil

	self.multiWindow:Destroy()

	self.multiWindow = nil

	self.singleWindow:Destroy()

	self.singleWindow = nil

	NewServerShopPage.super.OnDestroy(self)

	return
end

return NewServerShopPage
