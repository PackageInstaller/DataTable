local HeroDisplaySnapView = class("HeroDisplaySnapView", ReduxView)

function HeroDisplaySnapView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

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
end

function HeroDisplaySnapView:Snap(arg_2_1, arg_2_2)
	SetActive(self.gameObject_, true)

	local var_2_0 = arg_2_2 or HeroDisplayData:GetSetting()

	SetActive(self.goCardPanel_, var_2_0.cardShow)
	self.transformLogo_:SetParent(self.logoParent_[var_2_0.logoPos], false)

	if var_2_0.cardShow then
		self.transformCard_:SetParent(self.cardParent_[var_2_0.cardPos], false)

		local var_2_1 = PlayerData:GetPlayerInfo()

		self.textNick_.text = GetI18NText(var_2_1.nick)
		self.textLv_.text = var_2_0.cardShowLv and GetTips("LEVEL") .. var_2_1.userLevel or GetTips("LEVEL") .. "**"
		self.textUID_.text = var_2_0.cardShowUID and "UID：" .. USER_ID or "UID：************"
	end

	manager.ui:ShowScreenTap(false)
	WaitRenderFrameUtil.inst.StartScreenShot(function()
		manager.ui:ShowScreenTap(true)
		SetActive(self.gameObject_, false)
		arg_2_1()
	end)
end

function HeroDisplaySnapView:OnExit()
	return
end

function HeroDisplaySnapView:Dispose()
	return
end

return HeroDisplaySnapView
