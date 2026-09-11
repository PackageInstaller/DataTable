local AutoChessActionBaseRenderer = class("AutoChessActionBaseRenderer")

function AutoChessActionBaseRenderer:Ctor(arg_1_1)
	self.id = arg_1_1
	self.status = AutoChessConst.ACTION_RENDERER_STATUS.IDLE
	self.actionData = nil
end

function AutoChessActionBaseRenderer:Init(arg_2_1)
	self.actionData = arg_2_1
end

function AutoChessActionBaseRenderer:Play()
	self.status = AutoChessConst.ACTION_RENDERER_STATUS.RUNNING

	self:OnPlay()
end

function AutoChessActionBaseRenderer:Pause()
	if self:IsRunning() then
		self.status = AutoChessConst.ACTION_RENDERER_STATUS.PAUSED

		self:OnPause()
	end
end

function AutoChessActionBaseRenderer:Resume()
	if self:IsPaused() then
		self.status = AutoChessConst.ACTION_RENDERER_STATUS.RUNNING

		self:OnResume()
	end
end

function AutoChessActionBaseRenderer:Finish()
	self.status = AutoChessConst.ACTION_RENDERER_STATUS.FINISHED

	self:OnFinish()
end

function AutoChessActionBaseRenderer:Reset()
	self.status = AutoChessConst.ACTION_RENDERER_STATUS.IDLE

	self:OnReset()

	self.actionData = nil
end

function AutoChessActionBaseRenderer:IsFinish()
	return self.status == AutoChessConst.ACTION_RENDERER_STATUS.FINISHED
end

function AutoChessActionBaseRenderer:IsRunning()
	return self.status == AutoChessConst.ACTION_RENDERER_STATUS.RUNNING
end

function AutoChessActionBaseRenderer:IsPaused()
	return self.status == AutoChessConst.ACTION_RENDERER_STATUS.PAUSED
end

function AutoChessActionBaseRenderer:SetSpeed(arg_11_1)
	return
end

function AutoChessActionBaseRenderer:OnPlay()
	return
end

function AutoChessActionBaseRenderer:Update()
	return
end

function AutoChessActionBaseRenderer:OnPause()
	return
end

function AutoChessActionBaseRenderer:OnResume()
	return
end

function AutoChessActionBaseRenderer:OnFinish()
	return
end

function AutoChessActionBaseRenderer:OnReset()
	return
end

return AutoChessActionBaseRenderer
