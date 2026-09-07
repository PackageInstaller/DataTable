local BaseShopPage = class("BaseShopPage", import("...base.BasePanel"))

function BaseShopPage:Ctor(arg_1_1, arg_1_2)
	BaseShopPage.super.Ctor(self, arg_1_2)
	self:attach(arg_1_1)

	self.event = arg_1_1.event

	self:CustomInit()

	return
end

function BaseShopPage:init()
	self.canvasGroup = self._go:GetComponent(typeof(CanvasGroup))
	self.lScrollrect = GetComponent(self._tf:Find("scroll"), "LScrollRect")
	self.scrollbar = self._tf:Find("scroll/Scrollbar")
	self.tipTextGo = self._tf:Find("bg/tipBg")
	self.tipText = self._tf:Find("bg/tipBg/tipText"):GetComponent(typeof(Text))
	self.helpBtn = self._tf:Find("bg/resList/helpBtn")
	self.refreshBtn = self._tf:Find("timeBtn")
	self.timerText = self._tf:Find("timeBtn/Text"):GetComponent(typeof(Text))
	self.resolveBtn = self._tf:Find("resolveBtn")

	setText(self._tf:Find("resolveBtn/Text"), i18n("shop_fragment_resolve"))

	return
end

function BaseShopPage:CustomInit()
	return
end

function BaseShopPage:SetShop(arg_4_1)
	self.shop = arg_4_1

	return
end

function BaseShopPage:SetPlayer(arg_5_1)
	self.player = arg_5_1

	self:OnUpdatePlayer()

	return
end

function BaseShopPage:SetItems(arg_6_1)
	self.items = arg_6_1

	self:OnUpdateItems()

	return
end

function BaseShopPage:SetUp(arg_7_1, arg_7_2, arg_7_3)
	self:SetShop(arg_7_1)
	self:Show()
	self:SetPlayer(arg_7_2)
	self:SetItems(arg_7_3)
	self:InitCommodities()
	self:OnSetUp()
	self:SetPainting()
	self:RefreshUI()

	return
end

function BaseShopPage:InitCommodities()
	self.displays, self.cards = self.shop:GetCommodities(), {}
	self.lScrollrect.enabled = true

	self.lScrollrect:SetTotalCount(#self.displays, 0)

	return
end

function BaseShopPage:RefreshUI()
	setActive(self.tipTextGo, false)
	setActive(self.helpBtn, false)
	setActive(self.resolveBtn, false)
	setActive(self.refreshBtn, false)

	return
end

function BaseShopPage:Show()
	function self.lScrollrect.onInitItem(arg_11_0)
		self:OnInitItem(arg_11_0)

		return
	end

	function self.lScrollrect.onUpdateItem(arg_12_0, arg_12_1)
		self:OnUpdateItem(arg_12_0, arg_12_1)

		return
	end

	self.canvasGroup.alpha = 1
	self.canvasGroup.blocksRaycasts = true

	self:PlayBGM()

	return
end

function BaseShopPage:Hide()
	self:StopBGM()

	for iter_13_0, iter_13_1 in pairs(self.cards) do
		iter_13_1:Dispose()
	end

	self.displays = {}
	self.cards = {}

	ClearLScrollrect(self.lScrollrect)

	self.canvasGroup.alpha = 0
	self.canvasGroup.blocksRaycasts = false

	return
end

function BaseShopPage:GetResDataList()
	return {}
end

function BaseShopPage:RefreshResItemList()
	self.parent:RefreshResItemList(self:GetResDataList() or {})

	return
end

function BaseShopPage:OnDestroy()
	self:detach()

	return
end

function BaseShopPage:SetPainting()
	local var_17_0, var_17_1, var_17_2 = self:GetPaintingName()

	if self.contextData.paintingView.name ~= var_17_0 then
		self.contextData.paintingView:Init(var_17_0, var_17_1, var_17_2, function()
			local var_18_0, var_18_1, var_18_2 = self:GetPaintingEnterVoice()

			self.contextData.paintingView:Chat(var_18_0, var_18_1, var_18_2, true)

			return
		end, function()
			local var_19_0, var_19_1, var_19_2 = self:GetPaintingTouchVoice()

			self.contextData.paintingView:Chat(var_19_0, var_19_1, var_19_2, false)

			return
		end)
	end

	return
end

function BaseShopPage:UpdateShop(arg_20_1)
	self:SetShop(arg_20_1)
	pg.MsgboxMgr.GetInstance():hide()

	if self.contextData.singleWindow:GetLoaded() and self.contextData.singleWindow:isShowing() then
		self.contextData.singleWindow:ExecuteAction("Close")
	end

	if self.contextData.multiWindow:GetLoaded() and self.contextData.multiWindow:isShowing() then
		self.contextData.multiWindow:ExecuteAction("Close")
	end

	self:OnUpdateAll()

	return
end

function BaseShopPage:UpdateCommodity(arg_21_1, arg_21_2)
	self:SetShop(arg_21_1)

	local var_21_0 = arg_21_1:GetCommodityById(arg_21_2)

	if DROP_TYPE_SHIP == var_21_0:getConfig("commodity_type") then
		self:OnUpdateAll()
	else
		self:OnUpdateCommodity(var_21_0)
	end

	local var_21_1
	local var_21_2
	local var_21_3

	if arg_21_1:IsPurchaseAll() then
		var_21_1, var_21_2, var_21_3 = self:GetPaintingAllPurchaseVoice()
	else
		var_21_1, var_21_2, var_21_3 = self:GetPaintingCommodityUpdateVoice()
	end

	self.contextData.paintingView:Chat(var_21_1, var_21_2, var_21_3, true)

	return
end

function BaseShopPage:OnClickCommodity(arg_22_1, arg_22_2)
	local var_22_0 = Drop.New({
		type = arg_22_1:getConfig("commodity_type"),
		id = arg_22_1:getConfig("commodity_id"),
		count = arg_22_1:getConfig("num")
	})

	if var_22_0.type == DROP_TYPE_VITEM and var_22_0:getConfig("virtual_type") == 22 then
		local var_22_1 = getProxy(ActivityProxy):getActivityById(var_22_0:getConfig("link_id"))

		if not var_22_1 or var_22_1:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tip_build_ticket_exchange_expired", var_22_0:getName()))

			return
		end
	end

	;(var_22_0.type == DROP_TYPE_EQUIPMENT_SKIN and self.contextData.singleWindowForESkin or (arg_22_1:getConfig("num_limit") == 1 or arg_22_1:getConfig("commodity_type") == 4 or isa(arg_22_1, QuotaCommodity) and arg_22_1:GetLimitGoodCount() == 1) and self.contextData.singleWindow or self.contextData.multiWindow):ExecuteAction("Open", arg_22_1, function(arg_23_0, arg_23_1, arg_23_2)
		local var_23_0 = {}

		if arg_23_0:getConfig("commodity_type") == 4 or self.shop.type == ShopArgs.ShopActivity then
			table.insert(var_23_0, function(arg_24_0)
				self:TipPurchase(arg_23_0, arg_23_1, arg_23_2, arg_24_0)

				return
			end)
		else
			table.insert(var_23_0, function(arg_25_0)
				if self:getSpecialRule(arg_23_0) then
					arg_25_0()
				end

				return
			end)
		end

		table.insert(var_23_0, function(arg_26_0)
			if not arg_23_0:canPurchase() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

				return
			end

			local var_26_0 = Drop.New({
				type = arg_23_0:getConfig("resource_category"),
				id = arg_23_0:getConfig("resource_type")
			})

			if var_26_0:getOwnedCount() < arg_23_0:getConfig("resource_num") * arg_23_1 then
				if not ItemTipPanel.ShowItemTip(arg_23_0:getConfig("resource_category"), arg_23_0:getConfig("resource_type")) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_x", var_26_0:getName()))
				end

				return
			end

			arg_26_0()

			return
		end)
		seriesAsync(var_23_0, function()
			arg_22_2(arg_23_0, arg_23_1)

			return
		end)

		return
	end)

	return
end

function BaseShopPage:TipPurchase(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("pt_reconfirm", arg_28_3 or "??"),
		onYes = arg_28_4
	})

	return
end

function BaseShopPage:getSpecialRule(arg_29_1)
	if arg_29_1:getConfig("commodity_type") == DROP_TYPE_ITEM and self.shop.type == ShopArgs.ShopFragment then
		local var_29_0 = arg_29_1:getConfig("commodity_id")
		local var_29_1 = Item.getConfigData(var_29_0)

		if var_29_1 and var_29_1.type == 7 and #var_29_1.shiptrans_id > 0 then
			local var_29_2 = getProxy(BayProxy)

			if getProxy(BagProxy):getItemCountById(var_29_0) > 0 or underscore.any(var_29_1.shiptrans_id, function(arg_30_0)
				return var_29_2:getConfigShipCount(arg_30_0) > 0
			end) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("special_transform_limit_reach"))

				return false
			end
		end
	end

	return true
end

function BaseShopPage:CanOpen(arg_31_1, arg_31_2)
	return true
end

function BaseShopPage:GetPaintingName()
	return "buzhihuo_shop"
end

function BaseShopPage:GetPaintingEnterVoice()
	local var_33_0 = string.split(pg.navalacademy_shoppingstreet_template[1].words_enter, "|")
	local var_33_1 = math.random(#var_33_0)

	return var_33_0[var_33_1], "enter_" .. var_33_1, false
end

function BaseShopPage:GetPaintingCommodityUpdateVoice()
	local var_34_0 = string.split(pg.navalacademy_shoppingstreet_template[1].words_buy, "|")
	local var_34_1 = math.random(#var_34_0)

	return var_34_0[var_34_1], "buy_" .. var_34_1, false
end

function BaseShopPage:GetPaintingAllPurchaseVoice()
	return nil, nil, nil
end

function BaseShopPage:GetPaintingTouchVoice()
	local var_36_0 = string.split(pg.navalacademy_shoppingstreet_template[1].words_touch, "|")
	local var_36_1 = math.random(#var_36_0)

	return var_36_0[var_36_1], "touch_" .. var_36_1, false
end

function BaseShopPage:GetBg(arg_37_1)
	return
end

function BaseShopPage:OnSetUp()
	return
end

function BaseShopPage:getBGM()
	return nil
end

function BaseShopPage:PlayBGM()
	local var_40_0 = self:getBGM()

	if var_40_0 and pg.voice_bgm[var_40_0] then
		pg.BgmMgr.GetInstance():Push(var_40_0, pg.voice_bgm[var_40_0].bgm)
	end

	return
end

function BaseShopPage:StopBGM()
	local var_41_0 = self:getBGM()

	if var_41_0 and pg.voice_bgm[var_41_0] then
		pg.BgmMgr.GetInstance():Pop(var_41_0)
	end

	return
end

function BaseShopPage:OnUpdateAll()
	return
end

function BaseShopPage:OnUpdateCommodity(arg_43_1)
	return
end

function BaseShopPage:OnUpdatePlayer()
	return
end

function BaseShopPage:OnUpdateItems()
	return
end

function BaseShopPage:OnInitItem(arg_46_1)
	return
end

function BaseShopPage:OnUpdateItem(arg_47_1, arg_47_2)
	return
end

function BaseShopPage:CanOpenPurchaseWindow(arg_48_1)
	return arg_48_1:canPurchase()
end

return BaseShopPage
