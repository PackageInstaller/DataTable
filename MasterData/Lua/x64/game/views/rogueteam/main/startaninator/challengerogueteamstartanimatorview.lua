local ChallengeRogueTeamStartAnimatorView = class("ChallengeRogueTeamStartAnimatorView", BaseView)

function ChallengeRogueTeamStartAnimatorView:Ctor()
	self.gameObject_ = Object.Instantiate(Asset.Load(self:UIName()), self:UIParent())
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ChallengeRogueTeamStartAnimatorView:UIName()
	return "Widget/System/Activity_Roulike/item/RoulikeSwitchUI"
end

function ChallengeRogueTeamStartAnimatorView:UIParent()
	return manager.ui.uiStory.transform
end

function ChallengeRogueTeamStartAnimatorView:Init()
	self:BindCfgUI()
	ChallengeRogueTeamData:UISetNeedPlayStartAnimator(false)
	self:AddTimer()
end

function ChallengeRogueTeamStartAnimatorView:Dispose()
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamStartAnimatorView:AddListeners()
	return
end

function ChallengeRogueTeamStartAnimatorView:AddTimer()
	self:StopTimer()

	local var_7_0 = true

	self.timer_ = FrameTimer.New(function()
		local var_8_0 = self.animator_:GetCurrentAnimatorStateInfo(0)

		if var_8_0.normalizedTime > 0.1 and var_7_0 then
			JumpTools.GoToSystem("/challengeRogueTeamPathMain")

			var_7_0 = false
		end

		if var_8_0.normalizedTime < 1 then
			return
		end

		self:StopTimer()
		self:Dispose()
	end, 1, -1)

	self.timer_:Start()
end

function ChallengeRogueTeamStartAnimatorView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ChallengeRogueTeamStartAnimatorView
