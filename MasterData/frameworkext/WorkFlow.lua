-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/workflow/WorkFlow.lua

module("frameworkext.ai.workflow.WorkFlow", package.seeall)

local WorkFlow = class("WorkFlow", FlowSingle)

function WorkFlow:ctor()
	self.super.ctor(self)

	self.currentWork = self
	self._guid = 0
	self._isInitWorkflow = false
end

function WorkFlow:start(context)
	self:_initWorkflow()

	self.currentWork = self

	self.currentWork:onStart(context)
end

function WorkFlow:stop()
	if self.status == WorkStatus.Running then
		self:onInterrupt()
	end
end

function WorkFlow:enterWork(work)
	self.currentWork = work
end

function WorkFlow:_initWorkflow()
	if self._isInitWorkflow then
		return
	end

	self._initChildWork(self, self, self)

	self._isInitWorkflow = true
end

function WorkFlow:_initChildWork(work, workflow)
	work.workflow = workflow

	if work.id == nil then
		work.id = self:_getNextGuid()
	end

	local children = work:getChildren()

	if children then
		for _, child in ipairs(children) do
			self:_initChildWork(child, workflow)
		end
	end
end

function WorkFlow:_getNextGuid()
	local id = self._guid + 1

	self._guid = id

	return id
end

function WorkFlow:serialize()
	self:_initWorkflow()

	local data = WorkFlow.super.serialize(self)

	data.currentWorkId = self.currentWork.id

	local serializeData = {}

	serializeData[self.id] = data

	self:_childSerialize(self._child, serializeData)

	local json = require("cjson")

	return json.encode(serializeData)
end

function WorkFlow:_childSerialize(child, serializeData)
	local data = child:serialize()

	if data then
		serializeData[child.id] = data
	end

	local children = child:getChildren()

	if children then
		for _, subChild in ipairs(children) do
			self:_childSerialize(subChild, serializeData)
		end
	end
end

function WorkFlow:deserialize(jsonData)
	self:_initWorkflow()

	local json = require("cjson")
	local serializeData = json.decode(jsonData)
	local data = serializeData[self.id]

	WorkFlow.super.deserialize(self, data)
	self:_childDeserialize(self._child, serializeData, data.currentWorkId)
end

function WorkFlow:_childDeserialize(child, serializeData, currentWorkId)
	if child.id == currentWorkId then
		self.currentWork = child
	end

	local data = serializeData[child.id]

	if data then
		child:deserialize(data)
	end

	local children = child:getChildren()

	if children then
		for _, subChild in ipairs(children) do
			self:_childDeserialize(subChild, serializeData, currentWorkId)
		end
	end
end

function WorkFlow:destroy()
	if self.status == WorkStatus.Running then
		self:onInterrupt()
	end

	self._isInitWorkflow = true
	self.currentWork = nil
	self._guid = 0

	self:onDestroy()
end

return WorkFlow
