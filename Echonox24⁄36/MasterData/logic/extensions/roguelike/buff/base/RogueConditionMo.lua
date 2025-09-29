-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/buff/base/RogueConditionMo.lua

module("logic.extensions.roguelike.buff.base.RogueConditionMo", package.seeall)

local M = class("RogueConditionMo")

function M:ctor(conditionCO, unit)
	self._conditionCO = conditionCO
	self._unit = unit
	self._id = conditionCO.id

	if conditionCO.program == "" then
		return
	end

	self._program = conditionCO.program

	local condition = RogueBuffClsUtil.getHandlerCls(conditionCO.program)

	self._conditionHandler = condition and condition:createInstance() or nil
end

function M:getProgram()
	return self._program
end

function M:getConditionHandler()
	return self._conditionHandler
end

function M:setConditionHandler(handlerName)
	local condition = RogueBuffClsUtil.getHandlerCls(handlerName)

	if not condition then
		return
	end

	self._conditionHandler = RogueBuffClsUtil.getHandlerCls(handlerName):createInstance()

	self._conditionHandler:onAdd(self._unit, self)
end

function M:isTrigger()
	if not self._conditionHandler then
		return false
	end

	return self._conditionHandler:onTrigger(self)
end

function M:reset()
	self._conditionCO = false
	self._id = 0
	self._conditionHandler = nil
end

function M:destroy()
	self._conditionCO = nil
	self._id = nil
	self._conditionHandler = nil
end

function M:setId(id)
	self._id = id
end

function M:getId()
	return self._id
end

function M:getConditionCO()
	return self._conditionCO
end

function M:getProgram()
	return self._conditionCO.program
end

function M:getParams()
	return self._conditionCO.params
end

return M
