local PosterDlcInteractionState = class("PosterDlcInteractionState", PosterDlcTimelineState)

function PosterDlcInteractionState:Ctor(arg_1_1, arg_1_2)
	PosterDlcInteractionState.super.Ctor(self, arg_1_1, arg_1_2)

	self.interactionKey = arg_1_2
end

function PosterDlcInteractionState:Enter()
	PosterDlcInteractionState.super.Enter(self)
	self.actor:EnableEyeController(false)

	local var_2_0 = self.actor:GetInteractionCfg()
	local var_2_1 = 1

	if #var_2_0[self.interactionKey] > 1 then
		var_2_1 = manager.posterGirl.actor == self.actor and self:RandomIndexOfInteractionType(self.interactionKey) or manager.posterGirl.actor:GetCurrentState().lastIndex
	end

	if var_2_0[self.interactionKey][var_2_1] then
		self.talking_ = var_2_0[self.interactionKey .. "_talk"][var_2_1]

		self:PlayAni(var_2_0[self.interactionKey][var_2_1])

		if var_2_0[self.interactionKey .. "_talk"][var_2_1] and var_2_0[self.interactionKey .. "_delay"][var_2_1] and var_2_0[self.interactionKey .. "_delay"][var_2_1] >= 0 then
			self:PlaySpecialTalk(var_2_0[self.interactionKey .. "_talk"][var_2_1], var_2_0[self.interactionKey .. "_delay"][var_2_1])
		end
	end

	if self.interactionKey == PosterGirlConst.InteractionKey.mainTouch or self.interactionKey == PosterGirlConst.InteractionKey.mainQuickTouch or self.interactionKey == PosterGirlConst.InteractionKey.touch2 or self.interactionKey == PosterGirlConst.InteractionKey.touch3 then
		PlayerAction.TouchPosterGirl()
	end
end

function PosterDlcInteractionState:RandomIndexOfInteractionType(arg_3_1)
	self.lastIndex = manager.posterGirl:GetForceRandomIndex() or PosterGirlTools.ActorRandomIndexOfInteractionType(self.actor, arg_3_1, self.lastIndex)

	return self.lastIndex
end

function PosterDlcInteractionState:Exit(arg_4_1)
	PosterDlcInteractionState.super.Exit(self, arg_4_1)

	if self.talkDelayTimer_ then
		self.talkDelayTimer_:Stop()

		self.talkDelayTimer_ = nil
	end
end

return PosterDlcInteractionState
