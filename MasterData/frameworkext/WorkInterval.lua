-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/workflow/impl/WorkInterval.lua

module("frameworkext.ai.workflow.impl.WorkInterval", package.seeall)

local WorkInterval = class("WorkInterval", WorkBase)

function WorkInterval:ctor(interval)
	WorkInterval.super.ctor(self)

	self._interval = interval
end

function WorkInterval:onStart()
	WorkInterval.super.onStart(self)
	settimer(self._interval, self._onTimer, self, false)
end

function WorkResult.onInterrupt()
	WorkInterval.super.onInterrupt(self)
	removetimer(self._onTimer, self)
end

function WorkInterval:_onTimer()
	self:onDone(WorkResult.Succeed)
end

return WorkInterval
