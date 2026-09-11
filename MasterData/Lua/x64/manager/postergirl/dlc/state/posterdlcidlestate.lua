local PosterDlcIdleState = class("PosterDlcIdleState", PosterDlcInteractionState)

function PosterDlcIdleState:Ctor(arg_1_1)
	PosterDlcIdleState.super.Ctor(self, arg_1_1, PosterGirlConst.InteractionKey.idle)
end

function PosterDlcIdleState:Enter()
	local var_2_0 = self.actor:GetViewDirect()

	self.interactionKey = PosterGirlConst.ViewDirect.left == var_2_0 and PosterGirlConst.InteractionKey.idle2 or PosterGirlConst.ViewDirect.right == var_2_0 and PosterGirlConst.InteractionKey.idle3 or PosterGirlConst.InteractionKey.idle

	if self.lastInteractionKey ~= self.interactionKey then
		self.lastInteractionKey = self.interactionKey
		self.lastIndex = 0
	end

	PosterDlcIdleState.super.Enter(self)
end

return PosterDlcIdleState
