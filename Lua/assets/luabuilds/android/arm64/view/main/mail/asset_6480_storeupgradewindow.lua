local StoreUpgradeWindow = class("StoreUpgradeWindow", import("view.base.BaseSubView"))

function StoreUpgradeWindow:getUIName()
	return "MailStoreExtendMsgboxUI"
end

function StoreUpgradeWindow:OnInit()
	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.closeBtn = self._tf:Find("window/top/btnBack")

	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.btnDiamond = self._tf:Find("window/button_container/btn_diamond")

	onButton(self, self.btnDiamond, function()
		self:emit(MailMediator.ON_EXTEND_STORE, true)
		self:Hide()

		return
	end, SFX_PANEL)

	self.btnGold = self._tf:Find("window/button_container/btn_gold")

	onButton(self, self.btnGold, function()
		self:emit(MailMediator.ON_EXTEND_STORE, false)
		self:Hide()

		return
	end, SFX_PANEL)
	setText(self._tf:Find("window/top/bg/infomation/title"), i18n("mail_boxroom_extend_title"))
	setText(self._tf:Find("window/frame/tip/Text"), i18n("mail_boxroom_extend_tips"))
	setText(self.btnGold:Find("Text"), i18n("mail_buy_button"))
	setText(self.btnDiamond:Find("Text"), i18n("mail_buy_button"))
	setText(self._tf:Find("window/frame/price/Text"), i18n("mail_all_price"))

	return
end

function StoreUpgradeWindow:UpdateInfo()
	local var_7_0 = self._tf:Find("window/frame")
	local var_7_1 = getProxy(PlayerProxy):getRawData()
	local var_7_2, var_7_3 = var_7_1:GetExtendStoreCost()

	setText(var_7_0:Find("gold/before"), pg.mail_storeroom[var_7_1.mailStoreLevel].gold_store)
	setText(var_7_0:Find("gold/after"), pg.mail_storeroom[var_7_1.mailStoreLevel + 1].gold_store)
	setText(var_7_0:Find("oil/before"), pg.mail_storeroom[var_7_1.mailStoreLevel].oil_store)
	setText(var_7_0:Find("oil/after"), pg.mail_storeroom[var_7_1.mailStoreLevel + 1].oil_store)
	setText(var_7_0:Find("oil/name"), i18n("mail_oil_res"))
	setText(var_7_0:Find("gold/name"), i18n("mail_gold_res"))
	setActive(var_7_0:Find("price/price_diamond"), var_7_2)
	setText(var_7_0:Find("price/price_diamond/Text"), (var_7_2 or nil) and (var_7_2.count or 0))
	setActive(var_7_0:Find("price/price_gold"), var_7_3)
	setText(var_7_0:Find("price/price_gold/Text"), (var_7_3 or nil) and (var_7_3.count or 0))
	setActive(var_7_0:Find("price/line"), var_7_2 and var_7_3)
	setActive(self.btnDiamond, var_7_2)
	setActive(self.btnGold, var_7_3)

	return
end

function StoreUpgradeWindow:Show()
	StoreUpgradeWindow.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:UpdateInfo()

	return
end

function StoreUpgradeWindow:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	StoreUpgradeWindow.super.Hide(self)

	return
end

function StoreUpgradeWindow:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return StoreUpgradeWindow
