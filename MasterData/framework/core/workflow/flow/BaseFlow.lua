-- chunkname: @framework/core/workflow/flow/BaseFlow.lua

module("framework.core.workflow.flow.BaseFlow", package.seeall)

local BaseFlow = class("BaseFlow", BaseWork)

function BaseFlow:start(context)
	self:onStartInternal(context)
end

function BaseFlow:stop()
	self:onStopInternal()
end

function BaseFlow:resume()
	self:onResumeInternal()
end

function BaseFlow:destroy()
	self:onDestroyInternal()
end

function BaseFlow:reset()
	self:onResetInternal()
end

function BaseFlow:addWork(work)
	work:initInternal()

	work.flowName = self.flowName

	work:setParentInternal(self)
end

function BaseFlow:onWorkDone(work)
	work:onResetInternal()
end

return BaseFlow
