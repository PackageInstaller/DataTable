-- chunkname: @framework/core/workflow/flow/FlowParallel.lua

module("modules.core.workflow.flow.FlowParallel", package.seeall)

local FlowParallel = class("FlowParallel", BaseFlow)

function FlowParallel:ctor()
	self._workList = {}
	self._doneCount = 0
	self._succCount = 0
end

function FlowParallel:addWork(work)
	FlowParallel.super.addWork(self, work)
	table.insert(self._workList, work)
end

function FlowParallel:onWorkDone(work)
	self._doneCount = self._doneCount + 1

	if work.isSuccess then
		self._succCount = self._succCount + 1
	end

	work:onResetInternal()

	if self._doneCount == #self._workList then
		if self._doneCount == self._succCount then
			return self:onDone(true)
		else
			return self:onDone(false)
		end
	end
end

function FlowParallel:getWorkList()
	return self._workList
end

function FlowParallel:onStartInternal(context)
	FlowParallel.super.onStartInternal(self, context)

	if #self._workList == 0 then
		self:onDone(true)

		return
	end

	self._doneCount = 0
	self._succCount = 0

	for _, work in ipairs(self._workList) do
		work:onStartInternal(context)
	end
end

function FlowParallel:onStopInternal()
	FlowParallel.super.onStopInternal(self)

	for _, work in ipairs(self._workList) do
		if work.status == WorkStatus.Running then
			work:onStopInternal()
		end
	end
end

function FlowParallel:onResumeInternal()
	FlowParallel.super.onResumeInternal(self)

	for _, work in ipairs(self._workList) do
		if work.status == WorkStatus.Stopped then
			work:onResumeInternal()
		end
	end
end

function FlowParallel:onResetInternal()
	FlowParallel.super.onResetInternal(self)

	if self.status == WorkStatus.Running or self.status == WorkStatus.Stopped then
		for _, work in ipairs(self._workList) do
			if work.status == WorkStatus.Running or work.status == WorkStatus.Stopped then
				work:onResetInternal()
			end
		end
	end

	self._doneCount = 0
	self._succCount = 0
end

function FlowParallel:onDestroyInternal()
	FlowParallel.super.onDestroyInternal(self)

	if not self._workList then
		return
	end

	for _, work in ipairs(self._workList) do
		work:onStopInternal()
		work:onResetInternal()
	end

	for _, work in ipairs(self._workList) do
		work:onDestroyInternal()
	end

	self._workList = nil
end

return FlowParallel
