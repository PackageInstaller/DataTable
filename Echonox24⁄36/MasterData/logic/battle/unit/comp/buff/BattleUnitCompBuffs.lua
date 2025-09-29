-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/buff/BattleUnitCompBuffs.lua

module("logic.battle.unit.comp.buff.BattleUnitCompBuffs", package.seeall)

local BattleUnitCompBuffs = class("BattleUnitCompBuffs", BattleUnitCompBase)

local function sort_buff(buffMOA, buffMOB)
	if buffMOA and buffMOB then
		local sa = buffMOA:isForever() and 10 or 0
		local sb = buffMOB:isForever() and 10 or 0

		if sa == sb then
			return buffMOA:getId() < buffMOB:getId()
		else
			return sb < sa
		end
	end

	return false
end

function BattleUnitCompBuffs:onInit()
	self._buffMOList = {}
	self._property = self._unit.property
end

function BattleUnitCompBuffs:onReset()
	self:clearAllBuff()
end

function BattleUnitCompBuffs:onDestroy()
	self:onReset()

	self._property = nil
end

function BattleUnitCompBuffs:getAllBuff()
	return self._buffMOList
end

function BattleUnitCompBuffs:clearAllBuff()
	BattleTableUtil.clearReusableTable(self._buffMOList)

	if self._unit.property:isStateActive(BattleEnum.State.DIZZY_OR_SLEEP) then
		self._unit.property:inactiveState(BattleEnum.State.DIZZY_OR_SLEEP)
		self._unit.stateEffect:refreshStateEffect()
	end
end

function BattleUnitCompBuffs:addBuff(id, code, round, layer)
	local buffMO = self:getBuffMO(id)

	if not buffMO then
		buffMO = BuffMO:createInstance()

		buffMO:setId(id)
		buffMO:setCode(code)
		buffMO:setRound(round)
		buffMO:setLayer(layer)
		table.insert(self._buffMOList, buffMO)
		table.sort(self._buffMOList, sort_buff)
	else
		buffMO:setRound(round)
		buffMO:setLayer(layer)
	end

	self._unit:dispatchInnerEvent(UnitActionType.BattleBuffUpdate)
end

function BattleUnitCompBuffs:removeBuff(id, isSilent)
	local buffMO = self:_removeBuff(id)

	if buffMO then
		if not isSilent then
			self._unit:dispatchInnerEvent(UnitActionType.BattleBuffUpdate)
		end

		buffMO:returnSelf()
	end
end

function BattleUnitCompBuffs:decRound(buffIds, decrement)
	for _, buffId in ipairs(buffIds) do
		local buffMO = self:getBuffMO(buffId)

		if buffMO then
			buffMO:decRound(decrement)
		elseif BattleLog.enableError then
			BattleLog.error(string.format("cannot find BuffMO[%s]", buffId))
		end
	end

	self._unit:dispatchInnerEvent(UnitActionType.BattleBuffUpdate)
end

function BattleUnitCompBuffs:getBuffMO(id)
	return self:_findBuffMO(id)
end

function BattleUnitCompBuffs:_findBuffMO(id)
	for _, buffMO in ipairs(self._buffMOList) do
		if buffMO:getId() == id then
			return buffMO
		end
	end

	return false
end

function BattleUnitCompBuffs:findBuffMOByCode(code, outList)
	for _, buffMO in ipairs(self._buffMOList) do
		if buffMO:getBuffCode() == code then
			table.insert(outList, buffMO)
		end
	end

	return outList
end

function BattleUnitCompBuffs:constainsBuffCode(code)
	for _, buffMO in ipairs(self._buffMOList) do
		if buffMO:getBuffCode() == code then
			return true
		end
	end

	return false
end

function BattleUnitCompBuffs:_removeBuff(id)
	for index, buffMO in ipairs(self._buffMOList) do
		if buffMO:getId() == id then
			table.remove(self._buffMOList, index)

			return buffMO
		end
	end

	return false
end

return BattleUnitCompBuffs
