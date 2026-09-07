local CryptolaliaPurchaseWindow = class("CryptolaliaPurchaseWindow", import("view.base.BaseSubView"))

function CryptolaliaPurchaseWindow:getUIName()
	return "CryptolaliaPurchaseWindowui"
end

function CryptolaliaPurchaseWindow:OnLoaded()
	self.icon = self._tf:Find("window/cover/icon"):GetComponent(typeof(Image))
	self.signature = self._tf:Find("window/cover/signature"):GetComponent(typeof(Image))
	self.name = self._tf:Find("window/cover/name"):GetComponent(typeof(Text))
	self.shipname = self._tf:Find("window/cover/shipname"):GetComponent(typeof(Text))
	self.gemToggle = self._tf:Find("window/gem")
	self.ticketToggle = self._tf:Find("window/ticket")
	self.gemCntTxt = self.gemToggle:Find("Text"):GetComponent(typeof(Text))
	self.ticketCntTxt = self.ticketToggle:Find("Text"):GetComponent(typeof(Text))
	self.exchangeBtn = self._tf:Find("exchange")

	setText(self.gemToggle:Find("title"), i18n("cryptolalia_use_gem_title"))
	setText(self.ticketToggle:Find("title"), i18n("cryptolalia_use_ticket_title"))
	setText(self.exchangeBtn:Find("Text"), i18n("cryptolalia_exchange"))

	return
end

function CryptolaliaPurchaseWindow:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.costType = Cryptolalia.COST_TYPE_GEM

	onToggle(self, self.gemToggle, function(arg_5_0)
		if arg_5_0 then
			self.costType = Cryptolalia.COST_TYPE_GEM
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.ticketToggle, function(arg_6_0)
		if arg_6_0 then
			self.costType = Cryptolalia.COST_TYPE_TICKET
		end

		return
	end, SFX_PANEL)

	return
end

function CryptolaliaPurchaseWindow:Show(arg_7_1)
	CryptolaliaPurchaseWindow.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	triggerToggle(self.gemToggle, true)

	self.name.text = arg_7_1:GetName()
	self.shipname.text = arg_7_1:GetShipName()

	LoadSpriteAtlasAsync("CryptolaliaShip/" .. arg_7_1:GetShipGroupId(), "cd", function(arg_8_0)
		if self.exited then
			return
		end

		self.icon.sprite = arg_8_0

		self.icon:SetNativeSize()

		return
	end)
	onButton(self, self.exchangeBtn, function()
		if not self.costType then
			return
		end

		self:emit(CryptolaliaMediator.UNLOCK, arg_7_1.id, self.costType)

		return
	end, SFX_PANEL)

	local var_7_0 = arg_7_1:GetCost(Cryptolalia.COST_TYPE_GEM)
	local var_7_1 = getProxy(PlayerProxy):getRawData()
	local var_7_2 = var_7_1:getResource(var_7_0.id)

	self.gemCntTxt.text = setColorStr(var_7_2, (var_7_2 < var_7_0.count or nil) and (COLOR_RED or COLOR_GREEN)) .. setColorStr("/" .. var_7_0.count, "#AFAFAF")

	local var_7_3 = arg_7_1:GetCost(Cryptolalia.COST_TYPE_TICKET)
	local var_7_4 = var_7_1:getResource(var_7_3.id)

	self.ticketCntTxt.text = setColorStr(var_7_4, (var_7_4 < var_7_3.count or nil) and (COLOR_RED or COLOR_GREEN)) .. setColorStr("/" .. var_7_3.count, "#AFAFAF")

	triggerToggle(self.ticketToggle, true)

	return
end

function CryptolaliaPurchaseWindow:Hide()
	CryptolaliaPurchaseWindow.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function CryptolaliaPurchaseWindow:OnDestroy()
	self.exited = true

	return
end

return CryptolaliaPurchaseWindow
