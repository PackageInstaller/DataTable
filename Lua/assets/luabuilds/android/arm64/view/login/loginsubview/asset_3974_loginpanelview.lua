local LoginPanelView = class("LoginPanelView", import("...base.BaseSubView"))

function LoginPanelView:getUIName()
	return "LoginPanelView"
end

function LoginPanelView:OnLoaded()
	return
end

function LoginPanelView:SetShareData(arg_3_1)
	self.shareData = arg_3_1

	return
end

function LoginPanelView:OnInit()
	self.loginPanel = self._tf
	self.loginUsername = self.loginPanel:Find("account/username")
	self.loginPassword = self.loginPanel:Find("password/password")
	self.loginButton = self.loginPanel:Find("login_button")
	self.registerButton = self.loginPanel:Find("register_button")

	self:InitEvent()

	return
end

function LoginPanelView:InitEvent()
	onButton(self, self.loginButton, function()
		if self.shareData.autoLoginEnabled and self.shareData.lastLoginUser then
			self.event:emit(LoginMediator.ON_LOGIN, self.shareData.lastLoginUser)

			return
		end

		local var_6_0 = getInputText(self.loginUsername)

		if var_6_0 == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("login_loginScene_error_noUserName"))
			ActivateInputField(self.loginUsername)

			return
		end

		local var_6_1 = getInputText(self.loginPassword) or ""
		local var_6_2 = User.New({
			type = 2,
			arg1 = var_6_0,
			arg2 = var_6_1
		})

		if var_6_2 then
			self.event:emit(LoginMediator.ON_LOGIN, var_6_2)
		end

		return
	end, SFX_CONFIRM)
	onButton(self, self.registerButton, function()
		self:emit(LoginSceneConst.SWITCH_SUB_VIEW, {
			LoginSceneConst.DEFINE.REGISTER_PANEL_VIEW
		})
		self:emit(LoginSceneConst.CLEAR_REGISTER_VIEW)

		return
	end, SFX_MAIN)
	onInputChanged(self, self.loginUsername, function()
		self.shareData.autoLoginEnabled = false

		return
	end)
	onInputChanged(self, self.loginPassword, function()
		self.shareData.autoLoginEnabled = false

		return
	end)

	return
end

function LoginPanelView:SetContent(arg_10_1, arg_10_2)
	setInputText(self.loginUsername, arg_10_1)
	setInputText(self.loginPassword, arg_10_2)

	return
end

function LoginPanelView:OnDestroy()
	return
end

return LoginPanelView
