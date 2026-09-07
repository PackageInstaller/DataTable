local RegisterPanelView = class("RegisterPanelView", import("...base.BaseSubView"))

function RegisterPanelView:getUIName()
	return "RegisterPanelView"
end

function RegisterPanelView:OnLoaded()
	return
end

function RegisterPanelView:SetShareData(arg_3_1)
	self.shareData = arg_3_1

	return
end

function RegisterPanelView:OnInit()
	self.registerPanel = self._tf
	self.registerUsername = self.registerPanel:Find("account/username")
	self.cancelButton = self.registerPanel:Find("cancel_button")
	self.confirmButton = self.registerPanel:Find("confirm_button")

	self:InitEvent()

	return
end

function RegisterPanelView:InitEvent()
	onButton(self, self.confirmButton, function()
		local var_6_0 = getInputText(self.registerUsername)

		if var_6_0 == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("login_loginScene_error_noUserName"))
			ActivateInputField(self.registerUsername)

			return
		end

		local var_6_1 = User.New({
			arg3 = "",
			arg2 = "",
			type = 2,
			arg1 = var_6_0
		})

		if var_6_1 then
			self.event:emit(LoginMediator.ON_REGISTER, var_6_1)
		end

		return
	end, SFX_CONFIRM)
	onButton(self, self.cancelButton, function()
		self:emit(LoginSceneConst.SWITCH_SUB_VIEW, {
			LoginSceneConst.DEFINE.LOGIN_PANEL_VIEW
		})

		return
	end, SFX_CANCEL)

	return
end

function RegisterPanelView:Clear()
	return
end

function RegisterPanelView:OnDestroy()
	return
end

return RegisterPanelView
