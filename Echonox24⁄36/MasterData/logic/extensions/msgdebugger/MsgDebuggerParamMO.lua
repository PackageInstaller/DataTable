-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/msgdebugger/MsgDebuggerParamMO.lua

module("logic.extensions.msgdebugger.MsgDebuggerParamMO", package.seeall)

local MsgDebuggerParamMO = class("MsgDebuggerParamMO")

function MsgDebuggerParamMO:ctor()
	self.hasModifyValue = false
end

function MsgDebuggerParamMO:initMsg(msgDebuggerMO, msg)
	self.msgDebuggerMO = msgDebuggerMO
	self.parentParamMO = nil
	self.id = 1
	self.paramName = msg._cname
	self.paramFullName = msg._cname
	self.paramTypeStr = MsgDebuggerConfig.ParamType.proto
	self.paramLabelStr = MsgDebuggerConfig.LabelType.required
	self.msgKey = 1
	self.msgValue = msg
end

function MsgDebuggerParamMO:initProto(msgDebuggerMO, parentParamMO, msgKey, msgValue)
	self.msgDebuggerMO = msgDebuggerMO
	self.parentParamMO = parentParamMO
	self.id = msgKey.number
	self.paramName = msgKey.name
	self.paramFullName = msgKey.full_name
	self.paramTypeStr = MsgDebuggerConfig.ParamType[msgKey.type]
	self.paramLabelStr = MsgDebuggerConfig.LabelType[msgKey.label]
	self.msgKey = msgKey
	self.msgValue = msgValue
end

function MsgDebuggerParamMO:initRepeated(msgDebuggerMO, parentParamMO, id)
	self.msgDebuggerMO = msgDebuggerMO
	self.parentParamMO = parentParamMO
	self.id = id
	self.paramName = parentParamMO.paramName
	self.paramFullName = parentParamMO.paramFullName
	self.paramTypeStr = parentParamMO.paramTypeStr
	self.paramLabelStr = MsgDebuggerConfig.LabelType.optional
	self.msgKey = parentParamMO.msgKey[id]
	self.msgValue = parentParamMO.msgValue and parentParamMO.msgValue[id]
end

function MsgDebuggerParamMO:isNilParam()
	return self.parentParamMO and self.parentParamMO:isRepeated() and (not self.parentParamMO.msgValue or self.parentParamMO.msgValue[self.id] == nil)
end

function MsgDebuggerParamMO:modifyValue(value)
	self.msgDebuggerMO.hasModifyValue = true
	self.hasModifyValue = true

	if self.paramTypeStr == MsgDebuggerConfig.ParamType.string then
		self.msgValue = value
	elseif self.paramTypeStr == MsgDebuggerConfig.ParamType.int32 or self.paramTypeStr == MsgDebuggerConfig.ParamType.uint32 or self.paramTypeStr == MsgDebuggerConfig.ParamType.int64 or self.paramTypeStr == MsgDebuggerConfig.ParamType.uint64 then
		self.msgValue = tonumber(value)
	elseif self.paramTypeStr == MsgDebuggerConfig.ParamType.bool then
		self.msgValue = (string.lower(value) == "true" or value == "1") and true or false
	else
		printError("暂时不支持的类型")
	end

	if self.parentParamMO:isRepeated() then
		self.parentParamMO.msgValue[self.id] = self.msgValue
	else
		self.parentParamMO.msgValue[self.paramName] = self.msgValue
	end

	self:modifyParent()
end

function MsgDebuggerParamMO:modifyParent()
	if self.parentParamMO then
		self.parentParamMO.hasModifyValue = true

		self.parentParamMO:modifyParent()
	end
end

function MsgDebuggerParamMO:setDefaultValue()
	self.msgDebuggerMO.hasModifyValue = true
	self.hasModifyValue = true

	if self.paramTypeStr == MsgDebuggerConfig.ParamType.string then
		self.msgValue = ""
	elseif self.paramTypeStr == MsgDebuggerConfig.ParamType.int32 or self.paramTypeStr == MsgDebuggerConfig.ParamType.uint32 or self.paramTypeStr == MsgDebuggerConfig.ParamType.int64 or self.paramTypeStr == MsgDebuggerConfig.ParamType.uint64 then
		self.msgValue = 0
	elseif self.paramTypeStr == MsgDebuggerConfig.ParamType.bool then
		self.msgValue = false
	else
		self.msgValue = self.parentParamMO.msgKey.message_type._concrete_class()
	end

	if not self.parentParamMO.msgValue then
		self.parentParamMO.msgValue = self.parentParamMO.parentParamMO.msgValue[self.parentParamMO.paramName]
	end

	table.insert(self.parentParamMO.msgValue, self.msgValue)
	self:modifyParent()
end

function MsgDebuggerParamMO:isRepeated()
	return self.paramLabelStr == MsgDebuggerConfig.LabelType.repeated
end

function MsgDebuggerParamMO:isProtoType()
	return self.paramTypeStr == MsgDebuggerConfig.ParamType.proto
end

return MsgDebuggerParamMO
