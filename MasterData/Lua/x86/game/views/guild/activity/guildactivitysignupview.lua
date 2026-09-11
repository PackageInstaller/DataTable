local GuildActivitySignUpView = class("GuildActivitySignUpView", ReduxView)

function GuildActivitySignUpView:UIName()
	return "UI/GuildActivityUI/GuildActivitytSignupUI"
end

function GuildActivitySignUpView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildActivitySignUpView:OnCtor()
	return
end

function GuildActivitySignUpView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySignUpView:InitUI()
	self:BindCfgUI()

	self.isSignedUpController_ = ControllerUtil.GetController(self.gameObject_.transform, "isSignedUp")
	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
end

function GuildActivitySignUpView:AddUIListener()
	self:AddBtnListener(self.signupBtn_, nil, function()
		if PlayerData:GetPlayerInfo().userLevel >= GameSetting.activity_club_user_level_limit.value[1] then
			GuildActivityAction.Register(function()
				if ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) then
					StartGuildActivity(GuildActivityData:GetCurrentGrid())
				else
					self:UpdateView()
				end
			end)
		else
			ShowTips("ACTIVITY_CLUB_REGISTER_CANT_TIP")
		end
	end)
end

function GuildActivitySignUpView:AddEventListeners()
	return
end

function GuildActivitySignUpView:OnTop()
	self:UpdateBar()
end

function GuildActivitySignUpView:OnBehind()
	manager.windowBar:HideBar()
end

function GuildActivitySignUpView:UpdateBar()
	self:ShowDefaultBar()
end

function GuildActivitySignUpView:OnEnter()
	self:AddEventListeners()
	self:StartTimer()
	self:UpdateTimer()
	self:UpdateView()
end

function GuildActivitySignUpView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
	self:StopTimer()
end

function GuildActivitySignUpView:UpdateView()
	self.isSignedUpController_:SetSelectedState(GuildActivityData:HaveRegister() and "true" or "false")

	self.conditionLabel_.text = GameSetting.activity_club_user_level_limit.value[1] <= PlayerData:GetPlayerInfo().userLevel and string.format(GetTips("UPGRADE_LIMIT_LEVEL"), GameSetting.activity_club_user_level_limit.value[1]) or string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), GameSetting.activity_club_user_level_limit.value[1])
end

function GuildActivitySignUpView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.timer_:Start()
end

function GuildActivitySignUpView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function GuildActivitySignUpView:UpdateTimer()
	self.lastTimeLabel_.text = manager.time:GetLostTimeStr(ActivityData:GetActivityData(ActivityConst.GUILD_ACTIVITY).stopTime)

	if ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) then
		self.statusController_:SetSelectedState("resignup")

		self.contentLabel1_.text = GetTips("ACTIVITY_CLUB_RESIGNUP")
		self.titleLabel_.text = GetTips("ACTIVITY_CLUB_RESIGNUP_TITLE")
	else
		self.statusController_:SetSelectedState("signup")

		self.contentLabel1_.text = GetTips("ACTIVITY_CLUB_SIGNUP")
		self.titleLabel_.text = GetTips("ACTIVITY_CLUB_SIGNUP_TITLE")
	end
end

function GuildActivitySignUpView:OnMainHomeViewTop()
	return
end

function GuildActivitySignUpView:Dispose()
	self:StopTimer()
	GuildActivitySignUpView.super.Dispose(self)
end

return GuildActivitySignUpView
