-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/workflow/flow/FlowBase.lua

module("frameworkext.ai.workflow.flow.FlowBase", package.seeall)

local FlowBase = class("FlowBase", WorkBase)

function FlowBase:ctor()
	FlowBase.super.ctor(self)
end

function FlowBase:onChildDone(child)
	return
end

return FlowBase
