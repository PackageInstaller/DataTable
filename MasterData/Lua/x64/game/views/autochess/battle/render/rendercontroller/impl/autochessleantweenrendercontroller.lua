local AutoChessLeanTweenRenderController = class("AutoChessLeanTweenRenderController", (import("game.views.autoChess.battle.render.renderController.AutoChessBaseRenderController")))

function AutoChessLeanTweenRenderController:OnCtor()
	self.leanTween = nil
	self.tweenUpdateCallback = nil
end

function AutoChessLeanTweenRenderController:RegistTweenUpdateCallback(arg_2_1)
	self.tweenUpdateCallback = arg_2_1

	self.leanTween:setOnUpdate(LuaHelper.FloatAction(function(arg_3_0)
		self.tweenUpdateCallback(arg_3_0)
	end))
end

function AutoChessLeanTweenRenderController:Value(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self.leanTween = LeanTween.value(arg_4_1, arg_4_2, arg_4_3):setScale(self.speed)

	self.leanTween:setOnComplete(System.Action(function()
		self:ClearLeanTween()
		self:Finish()
	end))

	if arg_4_4 then
		self.leanTween:setEase(arg_4_4)
	end
end

function AutoChessLeanTweenRenderController:OnPause()
	if self.leanTween then
		self.leanTween:pause()
	end
end

function AutoChessLeanTweenRenderController:OnResume()
	if self.leanTween then
		self.leanTween:resume()
	end
end

function AutoChessLeanTweenRenderController:OnSpeedChange()
	if self.leanTween then
		self.leanTween:setScale(self.speed)
	end
end

function AutoChessLeanTweenRenderController:Reset()
	AutoChessLeanTweenRenderController.super.Reset(self)
	self:ClearLeanTween()
end

function AutoChessLeanTweenRenderController:ClearLeanTween()
	if self.leanTween then
		self.leanTween:setOnUpdate(nil):setOnComplete(nil)
		LeanTween.cancel(self.leanTween.id)

		self.leanTween = nil
	end

	self.tweenUpdateCallback = nil
end

return AutoChessLeanTweenRenderController
