local SettingsAccountUSPanle = class("SettingsAccountUSPanle", import(".SettingsBasePanel"))

function SettingsAccountUSPanle:GetUIName()
	return "SettingsAccountUS"
end

function SettingsAccountUSPanle:GetTitle()
	return "Account"
end

function SettingsAccountUSPanle:GetTitleEn()
	return "  / ACCOUNT"
end

function SettingsAccountUSPanle:OnInit()
	local var_4_0 = findTF(self._tf, "page1")
	local var_4_1 = findTF(var_4_0, "btn_layout/twitter_con")

	self.btnBindTwitter = findTF(var_4_1, "bind_twitter")
	self.btnUnlinkTwitter = findTF(var_4_1, "unlink_twitter")
	self.twitterStatus = findTF(var_4_1, "twitter_status")

	local var_4_2 = findTF(var_4_0, "btn_layout/facebook_con")

	self.btnBindFacebook = findTF(var_4_2, "bind_facebook")
	self.btnUnlinkFacebook = findTF(var_4_2, "unlink_facebook")
	self.facebookStatus = findTF(var_4_2, "facebook_status")

	local var_4_3 = setActive
	local var_4_4 = var_4_2
	local var_4_5

	if PLATFORM_CODE == PLATFORM_US then
		if pg.SdkMgr.GetInstance():GetChannelUID() == "3" then
			var_4_5 = false

			goto label_4_0
		end
	end

	::label_4_0::

	var_4_3(var_4_4, true)

	local var_4_6 = findTF(var_4_0, "btn_layout/yostar_con")

	self.btnBindYostar = findTF(var_4_6, "bind_yostar")
	self.btnUnlinkYostar = findTF(var_4_6, "unlink_yostar")
	self.yostarStatus = findTF(var_4_6, "yostar_status")

	local var_4_7 = findTF(var_4_0, "btn_layout/apple_con")

	self.btnBindApple = findTF(var_4_7, "bind_apple")
	self.btnUnlinkApple = findTF(var_4_7, "unlink_apple")
	self.appleStatus = findTF(var_4_7, "apple_status")

	local var_4_8 = setActive
	local var_4_9 = var_4_7
	local var_4_10

	if PLATFORM_CODE == PLATFORM_US then
		if pg.SdkMgr.GetInstance():GetChannelUID() ~= "1" then
			var_4_10 = false

			goto label_4_1
		end
	end

	::label_4_1::

	var_4_8(var_4_9, true)

	local var_4_11 = findTF(var_4_0, "btn_layout/amazon_con")

	self.btnBindAmazon = findTF(var_4_11, "bind_amazon")
	self.btnUnlinkAmazon = findTF(var_4_11, "unlink_amazon")
	self.amazonStatus = findTF(var_4_11, "amazon_status")

	local var_4_12 = setActive
	local var_4_13 = var_4_11
	local var_4_14

	if PLATFORM_CODE == PLATFORM_US then
		if pg.SdkMgr.GetInstance():GetChannelUID() ~= "3" then
			var_4_14 = false

			goto label_4_2
		end
	end

	::label_4_2::

	var_4_12(var_4_13, true)

	self.pgsCon = findTF(var_4_0, "btn_layout/pgs_con")
	self.btnBindPGS = findTF(self.pgsCon, "bind")
	self.btnUnlinkPGS = findTF(self.pgsCon, "unlink")
	self.pgsStatus = findTF(self.pgsCon, "status")
	self.yostarAlert = findTF(self._tf, "page2")
	self.yostarEmailTxt = findTF(self.yostarAlert, "email_input_txt")
	self.yostarCodeTxt = findTF(self.yostarAlert, "code_input_txt")
	self.yostarGenCodeBtn = findTF(self.yostarAlert, "gen_code_btn")
	self.yostarGenTxt = findTF(self.yostarGenCodeBtn, "Text")
	self.yostarSureBtn = findTF(self.yostarAlert, "login_btn")

	self:RegisterEvent()

	return
end

function SettingsAccountUSPanle:RegisterEvent()
	onButton(self, self.btnBindTwitter, function()
		pg.SdkMgr.GetInstance():LinkSocial(AIRI_PLATFORM_TWITTER)

		return
	end)
	onButton(self, self.btnUnlinkTwitter, function()
		pg.SdkMgr.GetInstance():UnlinkSocial(AIRI_PLATFORM_TWITTER)

		return
	end)
	onButton(self, self.btnBindFacebook, function()
		pg.SdkMgr.GetInstance():LinkSocial(AIRI_PLATFORM_FACEBOOK)

		return
	end)
	onButton(self, self.btnUnlinkFacebook, function()
		pg.SdkMgr.GetInstance():UnlinkSocial(AIRI_PLATFORM_FACEBOOK)

		return
	end)
	onButton(self, self.btnBindApple, function()
		pg.SdkMgr.GetInstance():LinkSocial(AIRI_PLATFORM_APPLE)

		return
	end)
	onButton(self, self.btnUnlinkApple, function()
		pg.SdkMgr.GetInstance():UnlinkSocial(AIRI_PLATFORM_APPLE)

		return
	end)
	onButton(self, self.btnBindAmazon, function()
		pg.SdkMgr.GetInstance():LinkSocial(AIRI_PLATFORM_AMAZON)

		return
	end)
	onButton(self, self.btnUnlinkAmazon, function()
		pg.SdkMgr.GetInstance():UnlinkSocial(AIRI_PLATFORM_AMAZON)

		return
	end)
	onButton(self, self.btnBindYostar, function()
		pg.UIMgr.GetInstance():BlurPanel(self.yostarAlert)
		setActive(self.yostarAlert, true)

		return
	end)
	onButton(self, self.yostarAlert, function()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.yostarAlert, self.accountUS)
		setActive(self.yostarAlert, false)

		return
	end)
	onButton(self, self.yostarGenCodeBtn, function()
		local var_16_0 = getInputText(self.yostarEmailTxt)

		if var_16_0 ~= "" then
			pg.SdkMgr.GetInstance():VerificationCodeReq(var_16_0)
			self:checkAiriGenCodeCounter_US()
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("verification_code_req_tip1"))
		end

		return
	end)
	onButton(self, self.yostarSureBtn, function()
		local var_17_0 = getInputText(self.yostarEmailTxt)
		local var_17_1 = getInputText(self.yostarCodeTxt)

		if var_17_0 ~= "" and var_17_1 ~= "" then
			pg.UIMgr.GetInstance():LoadingOn()
			pg.SdkMgr.GetInstance():LinkSocial(AIRI_PLATFORM_YOSTAR, var_17_0, var_17_1)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("verification_code_req_tip3"))
		end

		triggerButton(self.yostarAlert)

		return
	end)
	onButton(self, self.btnUnlinkPGS, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("pgs_unbind_tip1"),
			onYes = function()
				pg.SdkMgr.GetInstance():UnlinkSocial(AIRI_PLATFORM_GPS)

				return
			end
		})

		return
	end)

	return
end

function SettingsAccountUSPanle:OnUpdate()
	self:checkAllAccountState_US()
	self:checkAiriGenCodeCounter_US()

	return
end

function SettingsAccountUSPanle:checkAllAccountState_US()
	self:checkAccountTwitterView_US()
	self:checkAccountFacebookView_US()
	self:checkAccountAppleView_US()
	self:checkAccountYostarView_US()
	self:checkAccountAmazonView_US()
	self:checkAccountPGSView_US()

	return
end

function SettingsAccountUSPanle:checkAccountTwitterView_US()
	local var_22_0 = pg.SdkMgr.GetInstance():IsSocialLink(AIRI_PLATFORM_TWITTER)

	setActive(self.btnUnlinkTwitter, var_22_0)
	setActive(self.twitterStatus, var_22_0)
	setActive(self.btnBindTwitter, not var_22_0)

	if var_22_0 then
		setText(self.twitterStatus, i18n("twitter_link_title", pg.SdkMgr.GetInstance():GetSocialName(AIRI_PLATFORM_TWITTER)))
	end

	return
end

function SettingsAccountUSPanle:checkAccountFacebookView_US()
	if PLATFORM_CODE == PLATFORM_US then
		if pg.SdkMgr.GetInstance():GetChannelUID() ~= "3" then
			local var_23_0 = pg.SdkMgr.GetInstance():IsSocialLink(AIRI_PLATFORM_FACEBOOK)

			setActive(self.btnUnlinkFacebook, var_23_0)
			setActive(self.facebookStatus, var_23_0)
			setActive(self.btnBindFacebook, not var_23_0)

			if var_23_0 then
				setText(self.facebookStatus, i18n("facebook_link_title", pg.SdkMgr.GetInstance():GetSocialName(AIRI_PLATFORM_FACEBOOK)))
			end
		end
	end

	return
end

function SettingsAccountUSPanle:checkAccountAppleView_US()
	local var_24_0 = pg.SdkMgr.GetInstance():IsSocialLink(AIRI_PLATFORM_APPLE)

	setActive(self.btnUnlinkApple, var_24_0)
	setActive(self.appleStatus, var_24_0)
	setActive(self.btnBindApple, not var_24_0)

	if var_24_0 then
		setText(self.appleStatus, i18n("apple_link_title", pg.SdkMgr.GetInstance():GetSocialName(AIRI_PLATFORM_APPLE)))
	end

	return
end

function SettingsAccountUSPanle:checkAccountAmazonView_US()
	if pg.SdkMgr.GetInstance():GetChannelUID() == "3" then
		local var_25_0 = pg.SdkMgr.GetInstance():IsSocialLink(AIRI_PLATFORM_AMAZON)

		setActive(self.btnUnlinkAmazon, var_25_0)
		setActive(self.amazonStatus, var_25_0)
		setActive(self.btnBindAmazon, not var_25_0)

		if var_25_0 then
			setText(self.amazonStatus, i18n("amazon_link_title", pg.SdkMgr.GetInstance():GetSocialName(AIRI_PLATFORM_AMAZON)))
		end
	end

	return
end

function SettingsAccountUSPanle:checkAccountYostarView_US()
	local var_26_0 = pg.SdkMgr.GetInstance():IsSocialLink(AIRI_PLATFORM_YOSTAR)

	setActive(self.btnUnlinkYostar, var_26_0)
	setActive(self.yostarStatus, var_26_0)
	setActive(self.btnBindYostar, not var_26_0)

	if var_26_0 then
		setText(self.yostarStatus, i18n("yostar_link_title", pg.SdkMgr.GetInstance():GetSocialName(AIRI_PLATFORM_YOSTAR)))
	end

	return
end

function SettingsAccountUSPanle:checkAccountPGSView_US()
	local var_27_0 = pg.SdkMgr.GetInstance():IsSocialLink(AIRI_PLATFORM_GPS)

	setActive(self.pgsCon, var_27_0)
	setActive(self.btnUnlinkPGS, var_27_0)
	setActive(self.pgsStatus, var_27_0)
	setActive(self.btnBindPGS, false)

	if var_27_0 then
		setText(self.pgsStatus, i18n("pgs_binding_account", pg.SdkMgr.GetInstance():GetSocialName(AIRI_PLATFORM_GPS)))
	end

	return
end

function SettingsAccountUSPanle:checkAiriGenCodeCounter_US()
	if GetAiriGenCodeTimeRemain() > 0 then
		setButtonEnabled(self.yostarGenCodeBtn, false)

		self.genCodeTimer = Timer.New(function()
			local var_29_0 = GetAiriGenCodeTimeRemain()

			if var_29_0 > 0 then
				setText(self.yostarGenTxt, "(" .. var_29_0 .. ")")
			else
				setText(self.yostarGenTxt, "Generate")
				self:clearAiriGenCodeTimer_US()
			end

			return
		end, 1, -1)

		self.genCodeTimer:Start()
	end

	return
end

function SettingsAccountUSPanle:clearAiriGenCodeTimer_US()
	setButtonEnabled(self.yostarGenCodeBtn, true)

	if self.genCodeTimer then
		self.genCodeTimer:Stop()

		self.genCodeTimer = nil
	end

	return
end

function SettingsAccountUSPanle:Dispose()
	SettingsAccountUSPanle.super.Dispose(self)

	if self.genCodeTimer then
		self.genCodeTimer:Stop()

		self.genCodeTimer = nil
	end

	return
end

return SettingsAccountUSPanle
