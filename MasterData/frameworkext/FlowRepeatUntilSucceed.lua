-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/workflow/flow/FlowRepeatUntilSucceed.lua

module("frameworkext.ai.workflow.flow.FlowRepeatUntilSucceed", package.seeall)

local FlowRepeatUntilSucceed = class("FlowRepeatUntilSucceed", FlowRepeatForever)

function FlowRepeatUntilSucceed:ctor()
	FlowRepeatUntilSucceed.super.ctor(self)
end

function FlowRepeatUntilSucceed:onChildDone(child)
	if child.result == WorkResult.Succeed then
		self:onDone(WorkResult.Succeed)
	else
		child:onStart(self.context)
	end
end

return FlowRepeatUntilSucceed
