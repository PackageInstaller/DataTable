local ChallengeRogueTeamPathHero = class("ChallengeRogueTeamPathHero", ReduxView)

function ChallengeRogueTeamPathHero:Init()
	self:BindCfgUI()

	self.hasHeroController_ = self.hasHeroCon_:GetController("hasHero")
end

function ChallengeRogueTeamPathHero:Ctor(arg_2_1)
	self.gameObject_ = arg_2_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ChallengeRogueTeamPathHero:SetData(arg_3_1, arg_3_2, arg_3_3)
	self.heroID_ = arg_3_2 or 0
	self.trialID_ = arg_3_3 or 0
	self.index_ = arg_3_1

	self:Refresh()
end

function ChallengeRogueTeamPathHero:Refresh()
	if self.heroID_ ~= 0 then
		local var_4_0 = ChallengeRogueTeamData:GetHeroData(self.heroID_, nil, true)

		self.icon_.spriteSync = "TextureConfig/Character/Itemshead/" .. ((var_4_0.using_skin ~= 0 or nil) and var_4_0.using_skin)
	end

	self.hasHeroController_:SetSelectedState(tostring(self.heroID_ ~= 0))
	self:RefreshHP()
end

function ChallengeRogueTeamPathHero:PlayEffect(arg_5_1)
	if self.trialID_ ~= 0 then
		self:PlayHPAnimator(ChallengeRogueTeamData:UIGetTeamHPData(self.heroID_, self.trialID_), ChallengeRogueTeamData:GetUnlockTrailHeroList()[self.trialID_].hpPercent)
	elseif self.heroID_ ~= 0 then
		self:PlayHPAnimator(ChallengeRogueTeamData:UIGetTeamHPData(self.heroID_, self.trialID_), ChallengeRogueTeamData:GetHeroList()[self.heroID_].hpPercent)
	end
end

function ChallengeRogueTeamPathHero:RefreshHP()
	self.hpSlider_.value = self.trialID_ ~= 0 and ChallengeRogueTeamData:UIGetTeamHPData(self.heroID_, self.trialID_) / 10000 or self.heroID_ ~= 0 and ChallengeRogueTeamData:UIGetTeamHPData(self.heroID_, self.trialID_) / 10000 or 0
end

function ChallengeRogueTeamPathHero:PlayHPAnimator(arg_7_1, arg_7_2)
	self.tween_ = LeanTween.value(self.gameObject_, arg_7_1, arg_7_2, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
		self.hpSlider_.value = arg_8_0 / 10000
	end)):setOnComplete(System.Action(function()
		self:RemoveTween()
		ChallengeRogueTeamData:UISetTeamHPData(self.heroID_, self.trialID_, arg_7_2)

		self.hpSlider_.value = arg_7_2 / 10000
	end))
end

function ChallengeRogueTeamPathHero:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function ChallengeRogueTeamPathHero:Dispose()
	ChallengeRogueTeamPathHero.super.Dispose(self)
	self:RemoveTween()

	self.gameObject_ = nil
end

return ChallengeRogueTeamPathHero
