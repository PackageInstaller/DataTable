local HeroUITimelineMgr = class("HeroUITimelineMgr")

function HeroUITimelineMgr:Ctor()
	self:Init()
end

function HeroUITimelineMgr:Init()
	if self.inited_ then
		return
	end

	self.inited_ = true
	self.timelineStopped_ = handler(self, self._OnHeroTimelineStopped)
	self.timelineBlendSignal_ = handler(self, self._OnTimelineBlendSignal)
	self.timeline_ = HeroUITimeline.New()

	self.timeline_:AddCallback(self.timelineStopped_, self.timelineBlendSignal_)
end

function HeroUITimelineMgr:GetModelPath(arg_3_1)
	return string.format("Char/%s", arg_3_1)
end

function HeroUITimelineMgr:BindHero(arg_4_1, arg_4_2, arg_4_3)
	self:_GetTimeline():BindHero(arg_4_1, arg_4_2, arg_4_3)
end

function HeroUITimelineMgr:Unbind()
	self:_GetTimeline():Unbind()

	if self.pool then
		self.pool:Cleanup()
	end
end

function HeroUITimelineMgr:TryJumpToEnd()
	self:_GetTimeline():TryJumpToEnd()
end

function HeroUITimelineMgr:PlayAction(arg_7_1, arg_7_2)
	self:_GetTimeline():PlayAction(arg_7_1, arg_7_2)
end

function HeroUITimelineMgr:PrepareAction(arg_8_1)
	self:_GetTimeline():PrepareAction(arg_8_1)
end

function HeroUITimelineMgr:SetCallbackStopped(arg_9_1)
	self.curStoppedCallback_ = arg_9_1
end

function HeroUITimelineMgr:SetCallbackBlendSignal(arg_10_1)
	self.curBlendSignalCallback_ = arg_10_1
end

function HeroUITimelineMgr:SetCallbackByTime(arg_11_1, arg_11_2, arg_11_3)
	self.timeline_:AddTimeCallback(arg_11_1, arg_11_2, arg_11_3)
end

function HeroUITimelineMgr:_OnHeroTimelineStopped(arg_12_1)
	if self.curStoppedCallback_ then
		self.curStoppedCallback_(arg_12_1)
	end
end

function HeroUITimelineMgr:_OnTimelineBlendSignal()
	if self.curBlendSignalCallback_ then
		self.curBlendSignalCallback_()
	end
end

function HeroUITimelineMgr:_GetTimeline()
	if not self.timeline_ then
		self:Init()
	end

	return self.timeline_
end

function HeroUITimelineMgr:JumpToTime(arg_15_1, arg_15_2)
	self:_GetTimeline():JumpToTime(arg_15_1, arg_15_2)
end

function HeroUITimelineMgr:Dispose()
	if self.timeline_ then
		self.timeline_:RemoveCallback(self.timelineStopped_, self.timelineBlendSignal_)
		self.timeline_:Dispose()

		self.timeline_ = nil
	end

	self.curStoppedCallback_ = nil
	self.curBlendSignalCallback_ = nil
	self.timelineStopped_ = nil
	self.timelineBlendSignal_ = nil
	self.inited_ = false
end

return HeroUITimelineMgr
