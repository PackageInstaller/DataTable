local AutoChessTimelineRenderController = class("AutoChessTimelineRenderController", (import("game.views.autoChess.battle.render.renderController.AutoChessBaseRenderController")))

function AutoChessTimelineRenderController:OnCtor()
	self.playableDirector = nil
	self.playableAsset = nil
	self.timelineFinishHandler = handler(self, self.OnTimelineFinish)
end

function AutoChessTimelineRenderController:InitPlayable(arg_2_1, arg_2_2)
	self.playableDirector = arg_2_1
	self.playableAsset = arg_2_2
end

function AutoChessTimelineRenderController:OnPlay()
	self.playableDirector.enabled = true
	self.playableDirector.stopped = self.playableDirector.stopped - self.timelineFinishHandler

	self.playableDirector:Play(self.playableAsset)

	self.playableDirector.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.None
	self.playableDirector.time = 0
	self.playableDirector.stopped = self.playableDirector.stopped + self.timelineFinishHandler

	LuaForUtil.SetTimelineSpeed(self.playableDirector, self.speed)
end

function AutoChessTimelineRenderController:Reset()
	AutoChessTimelineRenderController.super.Reset(self)

	if self.playableDirector then
		self.playableDirector.stopped = self.playableDirector.stopped - self.timelineFinishHandler
		self.playableDirector = nil
		self.playableAsset = nil
	end
end

function AutoChessTimelineRenderController:OnPause()
	if self.playableDirector then
		LuaForUtil.SetTimelineSpeed(self.playableDirector, 0)
	end
end

function AutoChessTimelineRenderController:OnResume()
	if self.playableDirector then
		LuaForUtil.SetTimelineSpeed(self.playableDirector, self.speed)
	end
end

function AutoChessTimelineRenderController:OnSpeedChange()
	if self.playableDirector then
		LuaForUtil.SetTimelineSpeed(self.playableDirector, self.speed)
	end
end

function AutoChessTimelineRenderController:OnTimelineFinish()
	self:Finish()
end

return AutoChessTimelineRenderController
