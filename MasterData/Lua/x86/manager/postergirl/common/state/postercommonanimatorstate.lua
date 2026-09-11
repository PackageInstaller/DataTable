local PosterGirlAnimatorState = class("PosterGirlAnimatorState", PosterGirlBaseState)
local var_0_1 = 0.4

function PosterGirlAnimatorState:Ctor(arg_1_1, arg_1_2)
	PosterGirlAnimatorState.super.Ctor(self, arg_1_1)

	self.clipName = arg_1_2
	self.animator = self.actor:GetAnimator()
end

function PosterGirlAnimatorState:PlayAni(arg_2_1)
	local var_2_0 = self.animator
	local var_2_2 = not self.animator:GetCurrentAnimatorStateInfo(0):IsName("ui_stand") and self.clipName ~= "ui_stand"

	self.animator.speed = 1

	if var_2_2 then
		self.animator:CrossFade(arg_2_1, var_0_1 / self.animator:GetCurrentAnimatorStateInfo(0).length, 0)
	else
		self.animator:Play(arg_2_1)
	end

	self.timer = Timer.New(function()
		local var_3_0 = var_2_0:GetCurrentAnimatorStateInfo(0)

		if var_3_0:IsName(arg_2_1) and var_3_0.normalizedTime >= 1 - ((var_2_2 or nil) and (var_0_1 or 0)) / var_3_0.length then
			if self.timer ~= nil then
				self.timer:Stop()

				self.timer = nil
			end

			self:AnimationEndCall()
		end
	end, 0.033, -1)

	self.timer:Start()
end

function PosterGirlAnimatorState:AnimationEndCall()
	self.actor:ChangeState(PosterGirlConst.StateKay.init)
end

function PosterGirlAnimatorState:Exit()
	if self.timer ~= nil then
		self.timer:Stop()

		self.timer = nil
	end

	self.actor:ResetBlendShapes()
end

return PosterGirlAnimatorState
