-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/buff/RogueUnitCompBuffs.lua

module("logic.extensions.roguelike.unit.comp.buff.RogueUnitCompBuffs", package.seeall)

local M = class("RogueUnitCompBuffs", RogueUnitCompBase)

function M:onInit()
	self._buffMOTable = {}
	self._conditionMOTable = {}
end

function M:onReset()
	self:clearAllBuff()
end

function M:onDestroy()
	self:onReset()
end

function M:getAllBuff()
	return self._buffMOTable
end

function M:getAllCondition()
	return self._conditionMOTable
end

function M:clearAllBuff()
	self._buffMOTable = {}
	self._conditionMOTable = {}
end

function M:addCondition(id)
	local conditionCo = RoguelikeConfig.instance:getConditionById(id)

	if conditionCo == nil then
		printError("找不到触发配置", id)

		return
	end

	local conditionMo = RogueConditionMo.New(conditionCo, self._unit)

	self._conditionMOTable[id] = conditionMo

	RogueMgr.instance:getRogueFlow().conditionMgr:addHandler(conditionMo:getProgram(), conditionMo:getConditionHandler())
end

function M:addBuff(id, code)
	local buffCo = RoguelikeConfig.instance:getEffectById(id)

	if buffCo == nil then
		if id ~= 0 then
			printError("找不到效果配置", id)
		end

		return
	end

	local buffMo = RogueBuffMo.New(buffCo, self._unit)

	if buffMo:getBuffHandler() == nil then
		return
	end

	self._buffMOTable[id] = buffMo

	buffMo:getBuffHandler():onAdd(self._unit, buffMo)
end

function M:removeBuff(id)
	self._buffMOTable[id] = nil
end

function M:getBuffMO(id)
	return self._buffMOTable[id] or false
end

function M:getConditionMO(id)
	return self._conditionMOTable[id] or false
end

return M
