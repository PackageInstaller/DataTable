local StoryPlayBaseNode = class("StoryPlayBaseNode")

function StoryPlayBaseNode:Ctor(arg_1_1)
	self.storyPlayer_ = arg_1_1

	self:ResetStatus()
	self:OnCtor(arg_1_1)
end

function StoryPlayBaseNode:ResetStatus()
	self.curTime_ = 0
	self.startTime_ = 0
	self.duration_ = 0.033
	self.isResident_ = false
	self.status_ = StoryPlayerConst.NODE_STATUS.IDLE
	self.onPlayInvoked_ = false
	self.onFinishInvoked_ = false
	self.onDisposeInvoked_ = false
end

function StoryPlayBaseNode:SetConfig(arg_3_1)
	self.config_ = arg_3_1 or {}
	self.startTime_ = arg_3_1.startTime or 0
	self.duration_ = arg_3_1.duration or 0.033
	self.isResident_ = arg_3_1.isResident or false

	self:OnSetConfig(arg_3_1)
end

function StoryPlayBaseNode:GetStartTime()
	return self.startTime_
end

function StoryPlayBaseNode:GetCurTime()
	return self.curTime_
end

function StoryPlayBaseNode:GetDuration()
	return self.duration_
end

function StoryPlayBaseNode:SetDuration(arg_7_1)
	self.duration_ = arg_7_1
end

function StoryPlayBaseNode:OnSetConfig(arg_8_1)
	return
end

function StoryPlayBaseNode:OnCtor(arg_9_1)
	return
end

function StoryPlayBaseNode:OnPlay()
	return
end

function StoryPlayBaseNode:OnUpdate()
	return
end

function StoryPlayBaseNode:OnFinish()
	return
end

function StoryPlayBaseNode:OnPause()
	return
end

function StoryPlayBaseNode:OnResume()
	return
end

function StoryPlayBaseNode:OnHide()
	return
end

function StoryPlayBaseNode:OnDispose()
	return
end

function StoryPlayBaseNode:GetStatus()
	return self.status_
end

function StoryPlayBaseNode:GetConfig()
	return self.config_
end

function StoryPlayBaseNode:Play()
	self.onPlayInvoked_ = true
	self.status_ = StoryPlayerConst.NODE_STATUS.PLAYING
	self.curTime_ = 0

	self:OnPlay()
end

function StoryPlayBaseNode:Update(arg_20_1)
	self.status_ = StoryPlayerConst.NODE_STATUS.PLAYING
	self.curTime_ = self.curTime_ + arg_20_1

	self:OnUpdate(arg_20_1)
end

function StoryPlayBaseNode:Finish()
	self.onFinishInvoked_ = true
	self.status_ = StoryPlayerConst.NODE_STATUS.FINISHED
	self.curTime_ = self.startTime_ + self.duration_

	self:OnFinish()
end

function StoryPlayBaseNode:Pause()
	self.status_ = StoryPlayerConst.NODE_STATUS.PAUSED

	self:OnPause()
end

function StoryPlayBaseNode:Resume()
	self.status_ = StoryPlayerConst.NODE_STATUS.PLAYING

	self:OnResume()
end

function StoryPlayBaseNode:Hide()
	self.status_ = StoryPlayerConst.NODE_STATUS.HIDE

	self:OnHide()
end

function StoryPlayBaseNode:Dispose()
	self.onDisposeInvoked_ = true

	self:OnDispose()
end

return StoryPlayBaseNode
