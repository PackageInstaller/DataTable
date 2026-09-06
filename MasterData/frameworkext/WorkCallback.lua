-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/workflow/impl/WorkCallback.lua

module("frameworkext.ai.workflow.impl.WorkCallback", package.seeall)

local WorkCallback = class("WorkCallback", WorkBase)

function WorkCallback:ctor(handler, handlerObj)
	WorkCallback.super.ctor(self)

	self._handler = handler
	self._handlerObj = handlerObj
end

function WorkCallback:onStart()
	WorkCallback.super.onStart(self)

	if self._handler then
		self._handler(self._handlerObj)
	end

	self:onDone(WorkResult.Succeed)
end

function WorkCallback:onDestroy()
	self._handler = nil
	self._handlerObj = nil

	WorkCallback.super.onDestroy()
end

return WorkCallback
