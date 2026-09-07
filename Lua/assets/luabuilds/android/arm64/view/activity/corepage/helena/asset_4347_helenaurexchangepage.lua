local HelenaUrExchangePage = class("HelenaUrExchangePage", import("view.activity.CorePage.CoreURExchangeTemplatePage"))

function HelenaUrExchangePage:OnInit()
	HelenaUrExchangePage.super.OnInit(self)

	self._btnExchange = self._tf:Find("AD/btn_exchange_on")
	self._btnExchange_off = self._tf:Find("AD/btn_exchange_off")
	self._msgBoxBtnCancel = self._msgBox:Find("msg_box/btn_cancel")
	self._msgBoxBtnConfirm = self._msgBox:Find("msg_box/btn_confirm")
	self._msgBoxLabel = self._msgBox:Find("msg_box/label/text_cn")
	self._msgBoxItem = self._msgBox:Find("msg_box/item/IconTpl")
	self._msgBoxItemName = self._msgBox:Find("msg_box/item/name")
	self._msgBoxItemDesc = self._msgBox:Find("msg_box/item/desc")

	return
end

function HelenaUrExchangePage:OnFirstFlush()
	HelenaUrExchangePage.super.OnFirstFlush(self)
	onButton(self, self._btnExchange, function()
		local var_3_0 = Drop.Create({
			self.curGoods.commodity_type,
			self.curGoods.commodity_id,
			1
		})

		updateDrop(self._msgBoxItem, var_3_0)
		setText(self._msgBoxItemName, var_3_0:getName())
		setText(self._msgBoxItemDesc, var_3_0.desc)
		pg.UIMgr.GetInstance():BlurPanel(self._msgBox)
		setActive(self._msgBox, true)

		self.isMsgBoxShow = true

		return
	end, SFX_PANEL)
	onButton(self, self._btnExchange_off, function()
		setActive(self._ptTip, true)

		self.leantween = LeanTween.delayedCall(1, System.Action(function()
			setActive(self._ptTip, false)

			return
		end)).uniqueId

		return
	end, SFX_PANEL)

	return
end

function HelenaUrExchangePage:OnUpdateFlush()
	self:UpdateExchangeStatus()
	self.uilist:align(#self.taskConfig)
	self:UpdatePtCount()
	setActive(self._btnExchange:Find("red"), self.canExchange)
	setActive(self._btnExchange, self.canExchange)
	setActive(self._btnExchange_off, not self.canExchange)

	return
end

return HelenaUrExchangePage
