local QWBaseStroyStrategy = class("QWBaseStroyStrategy")

function QWBaseStroyStrategy:Ctor()
	self:Init()
end

function QWBaseStroyStrategy:Init()
	self.luaTarget = nil
	self.isInTalk = false
	self.storyID = -1

	self:OnInit()
end

function QWBaseStroyStrategy:OnInit()
	return
end

function QWBaseStroyStrategy:Dispose()
	return
end

function QWBaseStroyStrategy:StartStory(arg_5_1, arg_5_2)
	if self.isInTalk then
		QWorldMgr:GetQWorldStoryMgr():PreContinueStop()
	end

	self.luaTarget = arg_5_2
	self.isInTalk = true
	self.storyID = arg_5_1

	self:OnStartStory(arg_5_1)
end

function QWBaseStroyStrategy:StopStory()
	self:OnEndStory()

	self.luaTarget = nil
	self.isInTalk = false
	self.storyID = -1
end

function QWBaseStroyStrategy:OnStartStory(arg_7_1, arg_7_2)
	return
end

function QWBaseStroyStrategy:OnEndStory()
	return
end

function QWBaseStroyStrategy:PreContinueStop()
	return
end

function QWBaseStroyStrategy:GetTarget()
	return self.luaTarget
end

function QWBaseStroyStrategy:GetStoryID()
	return self.storyID
end

function QWBaseStroyStrategy:GetStoryHistory()
	return {}
end

function QWBaseStroyStrategy:ChangeAutoPlayState(arg_13_1)
	return
end

function QWBaseStroyStrategy:GetAutoPlayState()
	return
end

return QWBaseStroyStrategy
