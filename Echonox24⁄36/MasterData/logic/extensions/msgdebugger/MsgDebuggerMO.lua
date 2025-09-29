-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/msgdebugger/MsgDebuggerMO.lua

module("logic.extensions.msgdebugger.MsgDebuggerMO", package.seeall)

local MsgDebuggerMO = class("MsgDebuggerMO")

function MsgDebuggerMO:ctor()
	self.ext = 0
	self.cmd = 0
	self.pbUpStructName = nil
	self.time = 0
	self.msg = nil
	self.isBlock = false
	self.extCmdValue = 0
	self.paramCount = 0
	self.hasModifyValue = false
	self.callStackTrace = nil
	self.connType = nil
	self._paramMOCache = nil
end

function MsgDebuggerMO:init(ext, cmd, pbUpStructName, time, msg, callStackTrace, connType)
	self.ext = ext
	self.cmd = cmd
	self.pbUpStructName = pbUpStructName
	self.time = time
	self.msg = msg
	self.extCmdValue = ext * 10000 + cmd
	self.paramCount = #getmetatable(msg)._descriptor.fields
	self.callStackTrace = callStackTrace
	self.connType = connType
end

function MsgDebuggerMO:setIsBlock(isBlock)
	self.isBlock = isBlock
end

function MsgDebuggerMO:getParamList(paramDepth)
	if not self._paramMOCache then
		local fieldsDescriptor = getmetatable(self.msg)._descriptor.fields
		local parentParamMO = MsgDebuggerParamMO.New()

		parentParamMO:initMsg(self, self.msg)

		self._paramMOCache = self:_buildProtoParamMOList(parentParamMO, fieldsDescriptor, self.msg)
	end

	local moList = self._paramMOCache
	local paramDepthCount = paramDepth and #paramDepth or 0

	for i = 1, paramDepthCount do
		local oneDepthKey = paramDepth[i]
		local paramListKey = oneDepthKey .. "_list"
		local prevMOList = moList

		moList = moList[paramListKey]

		if not moList then
			local paramMO = prevMOList[oneDepthKey]

			if paramMO:isRepeated() then
				moList = self:_buildRepeatedParamMOList(paramMO)
			elseif paramMO.msgValue then
				local fieldsDescriptor = getmetatable(paramMO.msgValue)._descriptor.fields

				moList = self:_buildProtoParamMOList(paramMO, fieldsDescriptor, paramMO.msgValue)
			elseif paramMO.parentParamMO and paramMO.parentParamMO:isRepeated() then
				local fieldsDescriptor = getmetatable(paramMO.msgValue)._descriptor.fields

				moList = self:_buildProtoParamMOList(paramMO, fieldsDescriptor, paramMO.msgValue)
			end

			prevMOList[paramListKey] = moList
		end
	end

	return moList
end

function MsgDebuggerMO:_buildProtoParamMOList(parentParamMO, parentProtoKeys, parentProtoValues)
	local moList = {}

	for i = 1, #parentProtoKeys do
		local key = parentProtoKeys[i]
		local value

		if parentParamMO:isRepeated() then
			value = parentProtoValues._fields[i]
		else
			value = parentProtoValues._fields[key]
		end

		local paramMO = MsgDebuggerParamMO.New()

		paramMO:initProto(self, parentParamMO, key, value)
		table.insert(moList, paramMO)

		moList[paramMO.paramName] = paramMO
	end

	table.sort(moList, function(mo1, mo2)
		return mo1.id < mo2.id
	end)

	for i = 1, #moList do
		moList[i].id = i
	end

	return moList
end

function MsgDebuggerMO:_buildRepeatedParamMOList(parentParamMO)
	local moList = {}
	local count = parentParamMO.msgValue and #parentParamMO.msgValue + 1 or 1

	for i = 1, count do
		local paramMO = MsgDebuggerParamMO.New()

		paramMO:initRepeated(self, parentParamMO, i)
		table.insert(moList, paramMO)
	end

	return moList
end

return MsgDebuggerMO
