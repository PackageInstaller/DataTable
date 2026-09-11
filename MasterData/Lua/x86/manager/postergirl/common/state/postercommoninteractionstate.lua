local PosterCommonInteractionState = class("PosterCommonInteractionState", PosterCommonTimelineState)

function PosterCommonInteractionState:Ctor(arg_1_1, arg_1_2)
	PosterCommonInteractionState.super.Ctor(self, arg_1_1, arg_1_2)

	self.interactionKey = arg_1_2
end

function PosterCommonInteractionState:Enter()
	self:CheckInsteraction()
end

function PosterCommonInteractionState:CheckInsteraction()
	self.actor:EnableEyeController(false)

	local var_3_0 = SkinCfg[self.actor:GetSkinId()].hero
	local var_3_1 = self.actor:GetInteractionCfg()
	local var_3_2 = 1

	if #var_3_1[self.interactionKey] > 1 then
		var_3_2 = manager.posterGirl.actor == self.actor and self:RandomIndexOfInteractionType(self.interactionKey) or manager.posterGirl.actor:GetCurrentState().lastIndex
	end

	if var_3_1[self.interactionKey][var_3_2] then
		self.talking_ = var_3_1[self.interactionKey .. "_talk"][var_3_2]

		self:PlayAni(var_3_1[self.interactionKey][var_3_2])

		if var_3_1[self.interactionKey .. "_talk"][var_3_2] and var_3_1[self.interactionKey .. "_delay"][var_3_2] then
			self:PlaySpecialTalk(var_3_1[self.interactionKey .. "_talk"][var_3_2], var_3_1[self.interactionKey .. "_delay"][var_3_2])
		end
	end

	if self.interactionKey == PosterGirlConst.InteractionKey.mainTouch or self.interactionKey == PosterGirlConst.InteractionKey.mainQuickTouch then
		PlayerAction.TouchPosterGirl()
	end
end

function PosterCommonInteractionState:RandomIndexOfInteractionType(arg_4_1)
	self.lastIndex = manager.posterGirl:GetForceRandomIndex() or PosterGirlTools.ActorRandomIndexOfInteractionType(self.actor, arg_4_1, self.lastIndex)

	return self.lastIndex
end

function PosterCommonInteractionState:PlaySpecialTalk(arg_5_1, arg_5_2)
	if manager.story:IsPlay() then
		return
	end

	if self.talkDelayTimer_ then
		self.talkDelayTimer_:Stop()

		self.talkDelayTimer_ = nil
	end

	local var_5_0, var_5_1 = HeroTools.GetIntHeroIDAndInteractionVoiceFileName(arg_5_1)

	if arg_5_2 > 0 then
		self.talkDelayTimer_ = Timer.New(function()
			self.actor:PlayHeroTalk(var_5_0, var_5_1, nil)
		end, arg_5_2 / 1000)

		self.talkDelayTimer_:Start()
	else
		self.actor:PlayHeroTalk(var_5_0, var_5_1, nil)
	end
end

function PosterCommonInteractionState:Exit()
	PosterCommonInteractionState.super.Exit(self)

	if self.talkDelayTimer_ then
		self.talkDelayTimer_:Stop()

		self.talkDelayTimer_ = nil
	end
end

return PosterCommonInteractionState
