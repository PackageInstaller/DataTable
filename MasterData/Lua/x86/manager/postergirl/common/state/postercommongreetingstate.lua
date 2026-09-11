local PosterCommonGreetingState = class("PosterCommonGreetingState", PosterCommonInteractionState)

function PosterCommonGreetingState:Ctor(arg_1_1)
	PosterCommonGreetingState.super.Ctor(self, arg_1_1)

	self.interactionKey = PosterGirlConst.InteractionKey.greeting
end

function PosterCommonGreetingState:Enter()
	self.greetTimer = Timer.New(function()
		self:CheckInsteraction()
	end, 1.2, 1)

	self.greetTimer:Start()
end

function PosterCommonGreetingState:Exit()
	PosterCommonGreetingState.super.Exit(self)

	if self.greetTimer then
		self.greetTimer:Stop()

		self.greetTimer = nil
	end
end

return PosterCommonGreetingState
