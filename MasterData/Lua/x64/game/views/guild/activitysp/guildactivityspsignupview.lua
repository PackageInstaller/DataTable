local GuildActivitySPSignUpView = class("GuildActivitySPSignUpView", ReduxView)

function GuildActivitySPSignUpView:UIName()
	return "UI/GuildActivitySPUI/GuildActivitySPSignupUI"
end

function GuildActivitySPSignUpView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildActivitySPSignUpView:OnCtor()
	return
end

function GuildActivitySPSignUpView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPSignUpView:InitUI()
	self:BindCfgUI()

	self.isSignedUpController_ = ControllerUtil.GetController(self.gameObject_.transform, "isSignedUp")
	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
end

function GuildActivitySPSignUpView:AddUIListener()
	self:AddBtnListener(self.signupBtn_, nil, function()
		if PlayerData:GetPlayerInfo().userLevel >= GameSetting.activity_club_sp_user_level_limit.value[1] then
			GuildActivitySPAction.Register(function()
				if ActivityData:GetActivityIsOpen((GuildActivitySPData:GetCurRunActivityID())) then
					StartGuildActivitySP(GuildActivitySPData:GetCurrentGrid())
				else
					self:UpdateView()
				end
			end)
		else
			ShowTips("ACTIVITY_CLUB_REGISTER_CANT_TIP")
		end
	end)
end

function GuildActivitySPSignUpView:AddEventListeners()
	return
end

function GuildActivitySPSignUpView:OnTop()
	self:UpdateBar()
end

function GuildActivitySPSignUpView:OnBehind()
	manager.windowBar:HideBar()
end

function GuildActivitySPSignUpView:UpdateBar()
	self:ShowDefaultBar()
end

function GuildActivitySPSignUpView:OnEnter()
	self:AddEventListeners()
	self:StartTimer()
	self:UpdateTimer()
	self:UpdateView()
end

function GuildActivitySPSignUpView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
	self:StopTimer()
end

function GuildActivitySPSignUpView:UpdateView()
	self.isSignedUpController_:SetSelectedState(GuildActivitySPData:HaveRegister() and "true" or "false")

	self.conditionLabel_.text = GameSetting.activity_club_sp_user_level_limit.value[1] <= PlayerData:GetPlayerInfo().userLevel and string.format(GetTips("UPGRADE_LIMIT_LEVEL"), GameSetting.activity_club_sp_user_level_limit.value[1]) or string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), GameSetting.activity_club_sp_user_level_limit.value[1])
end

function GuildActivitySPSignUpView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.timer_:Start()
end

function GuildActivitySPSignUpView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function GuildActivitySPSignUpView:UpdateTimer()
	self.lastTimeLabel_.text = manager.time:GetLostTimeStr(ActivityData:GetActivityData((GuildActivitySPData:GetCurMainActivityID())).stopTime)

	if ActivityData:GetActivityIsOpen((GuildActivitySPData:GetCurRunActivityID())) then
		self.statusController_:SetSelectedState("resignup")
	else
		self.statusController_:SetSelectedState("signup")
	end
end

function GuildActivitySPSignUpView:OnMainHomeViewTop()
	return
end

function GuildActivitySPSignUpView:Dispose()
	self:StopTimer()
	GuildActivitySPSignUpView.super.Dispose(self)
end

return GuildActivitySPSignUpView
