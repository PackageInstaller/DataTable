-- chunkname: @framework/core/workflow/flow/FlowSequence.lua

module("framework.core.workflow.flow.FlowSequence", package.seeall)

local FlowSequence = class("FlowSequence", BaseFlow)

function FlowSequence:ctor()
	self._workList = {}
	self._curIndex = 0
end

function FlowSequence:addWork(work)
	FlowSequence.super.addWork(self, work)
	table.insert(self._workList, work)
end

function FlowSequence:onWorkDone(work)
	local currWork = self._workList[self._curIndex]

	if currWork and work ~= currWork then
		return
	end

	if work.isSuccess then
		work:onResetInternal()

		return self:_runNext()
	else
		work:onResetInternal()

		return self:onDone(false)
	end
end

function FlowSequence:getWorkList()
	return self._workList
end

function FlowSequence:onStartInternal(context)
	FlowSequence.super.onStartInternal(self, context)

	self._curIndex = 0

	return self:_runNext()
end

function FlowSequence:onStopInternal()
	FlowSequence.super.onStopInternal(self)

	local currWork = self._workList[self._curIndex]

	if currWork and currWork.status == WorkStatus.Running then
		currWork:onStopInternal()
	end
end

function FlowSequence:onResumeInternal()
	FlowSequence.super.onResumeInternal(self)

	local currWork = self._workList[self._curIndex]

	if currWork and currWork.status == WorkStatus.Stopped then
		currWork:onResumeInternal()
	end
end

function FlowSequence:onResetInternal()
	FlowSequence.super.onResetInternal(self)

	if self.status == WorkStatus.Running or self.status == WorkStatus.Stopped then
		local currWork = self._workList[self._curIndex]

		if currWork and (currWork.status == WorkStatus.Running or currWork.status == WorkStatus.Stopped) then
			currWork:onResetInternal()
		end
	end

	self._curIndex = 0
end

function FlowSequence:onDestroyInternal()
	FlowSequence.super.onDestroyInternal(self)

	if not self._workList then
		return
	end

	if self.status == WorkStatus.Running or self.status == WorkStatus.Stopped then
		local currWork = self._workList[self._curIndex]

		if currWork then
			currWork:onStopInternal()
			currWork:onResetInternal()
		end
	end

	for _, work in ipairs(self._workList) do
		work:onDestroyInternal()
	end

	self._workList = nil
	self._curIndex = nil
end

function FlowSequence:_runNext()
	self._curIndex = self._curIndex + 1

	if self._curIndex <= #self._workList then
		return self._workList[self._curIndex]:onStartInternal(self.context)
	else
		return self:onDone(true)
	end
end

return FlowSequence
