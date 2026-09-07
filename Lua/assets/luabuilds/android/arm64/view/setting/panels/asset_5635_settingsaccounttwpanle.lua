local SettingsAccountTwPanle = class("SettingsAccountTwPanle", import(".SettingsBasePanel"))

function SettingsAccountTwPanle:GetUIName()
	return "SettingsAccountTW"
end

function SettingsAccountTwPanle:InitTitle()
	return
end

function SettingsAccountTwPanle:OnInit()
	self.googleBtn = self._tf:Find("page1/bind_google")
	self.gamecenterBtn = self._tf:Find("page1/bind_gamecenter")
	self.faceBookBtn = self._tf:Find("page1/bind_facebook")
	self.phoneBtn = self._tf:Find("page1/bind_phone")
	self.appleBtn = self._tf:Find("page1/bind_apple")

	setActive(self.appleBtn, true)

	local var_3_0 = pg.SdkMgr.GetInstance()
	local var_3_1 = {
		var_3_0:IsBindFaceBook(),
		var_3_0:IsBindGoogle(),
		var_3_0:IsBindPhone(),
		var_3_0:IsBindGameCenter(),
		(var_3_0:IsBindApple())
	}

	for iter_3_0, iter_3_1 in ipairs({
		self.faceBookBtn,
		self.googleBtn,
		self.phoneBtn,
		self.gamecenterBtn,
		self.appleBtn
	}) do
		local var_3_2 = var_3_1[iter_3_0]

		setActive(iter_3_1:Find("unbind"), not var_3_1[iter_3_0])
		setActive(iter_3_1:Find("bind"), var_3_1[iter_3_0])
		onButton(self, iter_3_1, function()
			if not var_3_2 then
				var_3_0:BindSocial(iter_3_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function SettingsAccountTwPanle:OnUpdate()
	if PLATFORM == PLATFORM_ANDROID then
		setActive(self.googleBtn, true)
		setActive(self.gamecenterBtn, false)
	else
		setActive(self.googleBtn, true)
		setActive(self.gamecenterBtn, false)
	end

	return
end

return SettingsAccountTwPanle
