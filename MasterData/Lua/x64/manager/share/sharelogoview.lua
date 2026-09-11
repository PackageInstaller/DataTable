local ShareLogoView = class("ShareLogoView")

function ShareLogoView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)

	self.logoParent_ = {
		[0] = self.ltLogo_,
		self.lbLogo_,
		self.rtLogo_,
		self.rbLogo_
	}
	self.cardParent_ = {
		[0] = self.ltCard_,
		self.lbCard_,
		self.rtCard_,
		self.rbCard_
	}
	self.logoController = ControllerUtil.GetController(self.gameObject_.transform, "logo")
end

function ShareLogoView:ShowLogo(arg_2_1)
	local var_2_0 = {}

	var_2_0 = not arg_2_1 and {
		cardShowUID = true,
		cardShowLv = true,
		logoPos = 0,
		cardPos = 1,
		cardShow = true
	} or arg_2_1

	SetActive(self.goCardPanel_, var_2_0.cardShow)
	self.transformLogo_:SetParent(self.logoParent_[var_2_0.logoPos], false)
	self.logoController:SetSelectedIndex(GameToSDK.CURRENT_SERVER == "kr" and 1 or 0)

	if var_2_0.cardShow then
		self.transformCard_:SetParent(self.cardParent_[var_2_0.cardPos], false)

		local var_2_1 = PlayerData:GetPlayerInfo()

		self.textNick_.text = var_2_1.nick
		self.textLv_.text = var_2_0.cardShowLv and GetTips("LEVEL") .. var_2_1.userLevel or GetTips("LEVEL") .. "**"
		self.textUID_.text = var_2_0.cardShowUID and "UID：" .. USER_ID or "UID：************"
	end

	SetActive(self.gameObject_, true)
end

function ShareLogoView:HideLogo()
	SetActive(self.gameObject_, false)
end

function ShareLogoView:Dispose()
	return
end

return ShareLogoView
