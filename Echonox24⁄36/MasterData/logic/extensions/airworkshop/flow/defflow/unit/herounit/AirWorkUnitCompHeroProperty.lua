-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/unit/herounit/AirWorkUnitCompHeroProperty.lua

module("logic.extensions.airworkshop.flow.defflow.unit.herounit.AirWorkUnitCompHeroProperty", package.seeall)

local M = class("AirWorkUnitCompHeroProperty", BattleUnitCompBase)

function M:onInit()
	return
end

function M:onReset()
	self:onInit()
end

function M:onDestroy()
	self:onInit()
end

function M:setUnitMO(mo)
	self._heroMO = mo
end

function M:getUnitMO()
	return self._heroMO
end

function M:setUnionIndex(unionIndex)
	self._heroMO:setUnionIndex(unionIndex)
end

function M:isStateActive(state)
	return false
end

function M:setEntityCode(entityCode)
	self._entityCode = entityCode

	local entityCO = CharacterConfig.instance:getCfgInfoByID(entityCode)
	local characterInfoCO = PastInfoConfig.instance:getCharacterInfo(entityCode)

	self._name = characterInfoCO.name
	self._colorType = entityCO.colorType
	self._career = entityCO.career
	self._battleCamp = entityCO.camp
	self._modelCode = entityCO.modelId
end

function M:setEntityId(entityId)
	self._entityId = entityId
end

function M:getEntityId()
	return self._entityId
end

function M:getEntityCode()
	return self._entityCode
end

function M:getName()
	return self._name
end

function M:getModelCode()
	return self._modelCode or 0
end

function M:getCareer()
	return self._career
end

function M:getMonsterType()
	return BattleEnum.MonsterType.NORMAL
end

function M:getUnitType()
	return self._heroMO:getUnitType()
end

function M:getTabType()
	return self._heroMO:getTabType()
end

function M:getBattleCamp()
	return self._battleCamp
end

return M
