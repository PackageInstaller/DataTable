local AutoChessAnimatorRenderController = class("AutoChessAnimatorRenderController", (import("game.views.autoChess.battle.render.renderController.AutoChessBaseRenderController")))

function AutoChessAnimatorRenderController:OnCtor()
	self.animator = nil
	self.animaName = nil
end

function AutoChessAnimatorRenderController:PlayAnim(arg_2_1, arg_2_2, arg_2_3)
	self.animator = arg_2_1
	self.animaName = arg_2_2
	self.delaySecond = arg_2_3 or 0
	self.curDelaySecond = self.delaySecond

	if self.delaySecond <= 0 then
		self:Play()
	end
end

function AutoChessAnimatorRenderController:OnPlay()
	self.animator.enabled = true
	self.animator.speed = self.speed

	self.animator:Play(self.animaName, -1, 0)
	self.animator:Update(0)
end

function AutoChessAnimatorRenderController:Update(arg_4_1)
	if self.status == AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.RUNNING then
		self:CheckFinish()
	elseif self.curDelaySecond > 0 then
		self.curDelaySecond = self.curDelaySecond - arg_4_1

		if self.curDelaySecond <= 0 then
			self:Play()
		end
	end
end

function AutoChessAnimatorRenderController:CheckFinish()
	local var_5_0 = self.animator:GetCurrentAnimatorStateInfo(0)

	if not var_5_0:IsName(self.animaName) or ((table.indexof(AutoChessConst.COMPLETE_PLAY_ANIM, self.animName) or nil) and 1) <= var_5_0.normalizedTime then
		self.animator = nil
		self.animaName = nil

		self:Finish()
	end
end

function AutoChessAnimatorRenderController:Reset()
	AutoChessAnimatorRenderController.super.Reset(self)

	self.animator = nil
	self.animaName = nil
end

function AutoChessAnimatorRenderController:OnPause()
	self.animator.speed = 0
end

function AutoChessAnimatorRenderController:OnResume()
	self.animator.speed = self.speed
end

function AutoChessAnimatorRenderController:OnSpeedChange()
	self.animator.speed = self.speed
end

return AutoChessAnimatorRenderController
