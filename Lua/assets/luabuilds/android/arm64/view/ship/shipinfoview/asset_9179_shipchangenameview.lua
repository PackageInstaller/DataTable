local ShipChangeNameView = class("ShipChangeNameView", import("...base.BaseSubView"))

function ShipChangeNameView:getUIName()
	return "ShipChangeNameView"
end

function ShipChangeNameView:OnInit()
	self._renamePanel = self._tf
	self._renameConfirmBtn = self._renamePanel:Find("frame/queren")
	self._renameCancelBtn = self._renamePanel:Find("frame/cancel")
	self._renameRevert = self._renamePanel:Find("frame/revert_button")
	self._renameCloseBtn = self._renamePanel:Find("frame/close_btn")

	setText(findTF(self._tf, "frame/name_field/Placeholder"), i18n("rename_input"))
	onButton(self, self._renameConfirmBtn, function()
		self:emit(ShipMainMediator.RENAME_SHIP, self:GetShipVO().id, (getInputText(findTF(self._renamePanel, "frame/name_field"))))

		return
	end, SFX_CONFIRM)
	onButton(self, self._renameRevert, function()
		setInputText(findTF(self._renamePanel, "frame/name_field"), (self:GetShipVO():isRemoulded() or nil) and (pg.ship_skin_template[self:GetShipVO():getRemouldSkinId()].name or pg.ship_data_statistics[self:GetShipVO().configId].name))

		return
	end, SFX_PANEL)
	onButton(self, self._renameCloseBtn, function()
		self:DisplayRenamePanel(false)

		return
	end, SFX_PANEL)
	onButton(self, self._renameCancelBtn, function()
		self:DisplayRenamePanel(false)

		return
	end, SFX_CANCEL)

	return
end

function ShipChangeNameView:SetShareData(arg_7_1)
	self.shareData = arg_7_1

	return
end

function ShipChangeNameView:GetShipVO()
	if self.shareData and self.shareData.shipVO then
		return self.shareData.shipVO
	end

	return nil
end

function ShipChangeNameView:DisplayRenamePanel(arg_9_1)
	self.isOpenRenamePanel = arg_9_1

	SetActive(self._renamePanel, arg_9_1)

	if arg_9_1 then
		pg.UIMgr.GetInstance():BlurPanel(self._renamePanel)
		setInputText(findTF(self._renamePanel, "frame/name_field"), (self:GetShipVO():getName()))
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(self._renamePanel, self._tf)
	end

	return
end

function ShipChangeNameView:OnDestroy()
	self.shareData = nil

	return
end

return ShipChangeNameView
