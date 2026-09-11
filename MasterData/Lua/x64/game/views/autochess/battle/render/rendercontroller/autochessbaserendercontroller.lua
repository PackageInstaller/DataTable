local AutoChessBaseRenderController = class("AutoChessBaseRenderController")

function AutoChessBaseRenderController:Ctor(arg_1_1)
	self.id = arg_1_1
	self.speed = 1
	self.finishCallback = nil
	self.status = AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.IDLE

	self:OnCtor()
end

function AutoChessBaseRenderController:Init(arg_2_1)
	self.speed = arg_2_1
end

function AutoChessBaseRenderController:RegistFinishCallback(arg_3_1)
	self.finishCallback = arg_3_1
end

function AutoChessBaseRenderController:SetSpeed(arg_4_1)
	self.speed = arg_4_1

	self:OnSpeedChange()
end

function AutoChessBaseRenderController:Play()
	self.status = AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.RUNNING

	AutoChessBattleRenderer.GetInstance():RegistPlayingRenderController(self)
	self:OnPlay()
end

function AutoChessBaseRenderController:Pause()
	if self:IsRunning() then
		self.status = AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.PAUSED

		self:OnPause()
	end
end

function AutoChessBaseRenderController:Resume()
	if self:IsPaused() then
		self.status = AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.RUNNING

		self:OnResume()
	end
end

function AutoChessBaseRenderController:Finish()
	self.status = AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.FINISHED

	self:OnFinish()

	if self.finishCallback then
		self.finishCallback()
	end
end

function AutoChessBaseRenderController:IsFinish()
	return self.status == AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.FINISHED
end

function AutoChessBaseRenderController:IsRunning()
	return self.status == AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.RUNNING
end

function AutoChessBaseRenderController:IsPaused()
	return self.status == AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.PAUSED
end

function AutoChessBaseRenderController:Reset()
	self.status = AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.IDLE
	self.speed = 1
	self.finishCallback = nil
end

function AutoChessBaseRenderController:OnCtor()
	return
end

function AutoChessBaseRenderController:OnPlay()
	return
end

function AutoChessBaseRenderController:Update()
	return
end

function AutoChessBaseRenderController:OnPause()
	return
end

function AutoChessBaseRenderController:OnResume()
	return
end

function AutoChessBaseRenderController:OnFinish()
	return
end

function AutoChessBaseRenderController:OnSpeedChange()
	return
end

return AutoChessBaseRenderController
