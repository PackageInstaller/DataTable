local YostarAlertView = class("YostarAlertView", import("...base.BaseSubView"))

function YostarAlertView:getUIName()
	return "YostarAlertView"
end

function YostarAlertView:OnLoaded()
	return
end

function YostarAlertView:SetShareData(arg_3_1)
	self.shareData = arg_3_1

	return
end

function YostarAlertView:OnInit()
	self.yostarAlert = self._tf
	self.yostarEmailTxt = self.yostarAlert:Find("email_input_txt")
	self.yostarCodeTxt = self.yostarAlert:Find("code_input_txt")
	self.yostarGenCodeBtn = self.yostarAlert:Find("gen_code_btn")
	self.yostarGenTxt = self.yostarGenCodeBtn:Find("Text")
	self.yostarSureBtn = self.yostarAlert:Find("login_btn")
	self.email_text = self.yostarAlert:Find("title1")
	self.emailhold_text = self.yostarEmailTxt:Find("Placeholder")
	self.code_text = self.yostarAlert:Find("title2")
	self.codehold_text = self.yostarCodeTxt:Find("Placeholder")
	self.genBtn_text = self.yostarGenCodeBtn:Find("Text")
	self.desc_text = self.yostarAlert:Find("desc")
	self.loginBtn_text = self.yostarSureBtn:Find("Image")

	setText(self.email_text, i18n("email_text"))
	setText(self.emailhold_text, i18n("emailhold_text"))
	setText(self.code_text, i18n("code_text"))
	setText(self.codehold_text, i18n("codehold_text"))
	setText(self.genBtn_text, i18n("genBtn_text"))
	setText(self.desc_text, i18n("desc_text"))
	setText(self.loginBtn_text, self.contextData.isLinkMode == true and i18n("linkBtn_text") or i18n("loginBtn_text"))
	self:InitEvent()

	return
end

function YostarAlertView:InitEvent()
	onButton(self, self.yostarAlert, function()
		setActive(self.yostarAlert, false)

		if self.contextData.isDestroyOnClose == true then
			self:Destroy()
		end

		return
	end)
	onButton(self, self.yostarGenCodeBtn, function()
		local var_7_0 = getInputText(self.yostarEmailTxt)

		if var_7_0 ~= "" then
			pg.SdkMgr.GetInstance():VerificationCodeReq(var_7_0)
			self:CheckAiriGenCodeCounter()
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("verification_code_req_tip1"))
		end

		return
	end)
	onButton(self, self.yostarSureBtn, function()
		local var_8_0 = getInputText(self.yostarEmailTxt)
		local var_8_1 = getInputText(self.yostarCodeTxt)

		if var_8_0 ~= "" and var_8_1 ~= "" then
			if self.contextData.isLinkMode == true then
				pg.SdkMgr.GetInstance():LinkSocial(AIRI_PLATFORM_YOSTAR, var_8_0, var_8_1)
			else
				pg.SdkMgr.GetInstance():LoginWithSocial(AIRI_PLATFORM_YOSTAR, var_8_0, var_8_1)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("verification_code_req_tip3"))
		end

		return
	end)
	self:CheckAiriGenCodeCounter()

	return
end

function YostarAlertView:CheckAiriGenCodeCounter()
	if GetAiriGenCodeTimeRemain() > 0 then
		setButtonEnabled(self.yostarGenCodeBtn, false)

		self.genCodeTimer = Timer.New(function()
			local var_10_0 = GetAiriGenCodeTimeRemain()

			if var_10_0 > 0 then
				setText(self.yostarGenTxt, "(" .. var_10_0 .. ")")
			else
				setText(self.yostarGenTxt, i18n("genBtn_text"))
				self:ClearAiriGenCodeTimer()
			end

			return
		end, 1, -1)

		self.genCodeTimer:Start()
	end

	return
end

function YostarAlertView:ClearAiriGenCodeTimer()
	setButtonEnabled(self.yostarGenCodeBtn, true)

	if self.genCodeTimer then
		self.genCodeTimer:Stop()

		self.genCodeTimer = nil
	end

	return
end

function YostarAlertView:OnDestroy()
	self:ClearAiriGenCodeTimer()

	return
end

return YostarAlertView
