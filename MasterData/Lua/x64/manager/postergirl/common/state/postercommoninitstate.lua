local PosterCommonInitState = class("PosterCommonInitState", PosterCommonTimelineState)

function PosterCommonInitState:Ctor(arg_1_1, arg_1_2)
	PosterCommonInitState.super.Ctor(self, arg_1_1)

	self.skipBlend = arg_1_2
end

function PosterCommonInitState:Enter()
	PosterCommonInitState.super.Enter(self)
	self.actor:EnableEyeController(true)

	if manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.home and #self.actor:GetInteractionCfg()[PosterGirlConst.InteractionKey.idle] ~= 0 then
		self.idleTimer = Timer.New(function()
			self:OnlyMainActorDo(function()
				manager.posterGirl:DoIdle()
			end)
		end, 60, -1)

		self.idleTimer:Start()
	end

	if self.skipBlend then
		self.skipBlend = nil

		self:PlayAni("action1_1", 0)
	else
		self:PlayAni("action1_1")
	end
end

function PosterCommonInitState:AnimationEndCall()
	return
end

function PosterCommonInitState:Exit()
	PosterCommonInitState.super.Exit(self)

	if self.idleTimer then
		self.idleTimer:Stop()

		self.idleTimer = nil
	end
end

return PosterCommonInitState
