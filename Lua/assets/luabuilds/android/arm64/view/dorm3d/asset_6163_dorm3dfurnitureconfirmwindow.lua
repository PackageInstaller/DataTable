local Dorm3dFurnitureConfirmWindow = class("Dorm3dFurnitureConfirmWindow", import("view.base.BaseUI"))

function Dorm3dFurnitureConfirmWindow:getUIName()
	return "Dorm3dFurnitureConfirmWindow"
end

function Dorm3dFurnitureConfirmWindow:init()
	return
end

function Dorm3dFurnitureConfirmWindow:didEnter()
	onButton(self, self._tf:Find("Window/Confirm"), function()
		self:closeView()
		existCall(self.contextData.onYes)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("Window/Cancel"), function()
		self:closeView()
		existCall(self.contextData.onNo)

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("Mask"), function()
		self:closeView()
		existCall(self.contextData.onClose)

		return
	end)
	onButton(self, self._tf:Find("Window/Close"), function()
		self:closeView()
		existCall(self.contextData.onClose)

		return
	end, SFX_CANCEL)
	setText(self._tf:Find("Window/Title"), self.contextData.title)
	setText(self._tf:Find("Window/Content"), self.contextData.content)
	setText(self._tf:Find("Window/Confirm/Text"), i18n("msgbox_text_confirm"))
	setText(self._tf:Find("Window/Cancel/Text"), i18n("msgbox_text_cancel"))

	return
end

function Dorm3dFurnitureConfirmWindow:willExit()
	return
end

return Dorm3dFurnitureConfirmWindow
