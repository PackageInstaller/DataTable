local PosterDlcTouchState = class("PosterDlcTouchState", PosterDlcInteractionState)

function PosterDlcTouchState:Ctor(arg_1_1)
	PosterDlcTouchState.super.Ctor(self, arg_1_1, PosterGirlConst.InteractionKey.mainTouch)
end

function PosterDlcTouchState:Enter()
	local var_2_0 = self.actor:GetViewDirect()

	self.interactionKey = PosterGirlConst.ViewDirect.left == var_2_0 and PosterGirlConst.InteractionKey.touch2 or PosterGirlConst.ViewDirect.right == var_2_0 and PosterGirlConst.InteractionKey.touch3 or PosterGirlConst.InteractionKey.mainTouch

	if self.lastInteractionKey ~= self.interactionKey then
		self.lastInteractionKey = self.interactionKey
		self.lastIndex = 0
	end

	PosterDlcTouchState.super.Enter(self)
end

return PosterDlcTouchState
