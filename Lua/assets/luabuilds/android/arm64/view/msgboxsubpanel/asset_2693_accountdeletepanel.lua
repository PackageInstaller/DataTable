local AccountDeletePanel = class("AccountDeletePanel", import(".MsgboxSubPanel"))

AccountDeletePanel.ConfigData = {}

function AccountDeletePanel:getUIName()
	return "AccountDeleteBox"
end

function AccountDeletePanel:UpdateView(arg_2_1)
	local var_2_0 = arg_2_1.onYes

	print("onYesFunc", tostring(arg_2_1.onYes))

	if arg_2_1.onYes then
		function arg_2_1.onYes()
			var_2_0((getInputText(self.inputField)))

			return
		end
	end

	self:PreRefresh(arg_2_1)

	rtf(self.viewParent._window).sizeDelta = Vector2.New(1000, 638)
	self.inputField = self._tf:Find("InputField")

	setText(self._tf:Find("Title"), (i18n("box_account_del_input", (i18n("box_account_del_target")))))
	setText(self._tf:Find("InputField/Placeholder"), i18n("box_account_del_click"))
	self:PostRefresh(arg_2_1)

	return
end

return AccountDeletePanel
