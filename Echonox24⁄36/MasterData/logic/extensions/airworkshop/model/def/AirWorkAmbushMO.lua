-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/def/AirWorkAmbushMO.lua

module("logic.extensions.airworkshop.model.def.AirWorkAmbushMO", package.seeall)

local M = class("AirWorkAmbushMO", AirWorkUnitMOBase)

function M:createInstance(entityId, heroId, unionIndex, condition, params, msgMO, heroAttrInfo)
	local mo = AirWorkAmbushMO.New()

	mo:onInit()
	mo:setEntityId(entityId)
	mo:setId(heroId)
	mo:setUnionIndex(unionIndex)
	mo:setConditionAndParams(condition, params)
	mo:setMsgMO(msgMO)
	mo:setHeroAttrInfo(heroAttrInfo)

	if not heroAttrInfo then
		mo:initAttrByClient()
	end

	return mo
end

function M:initAttrByAgent(entityAttributeNO)
	local heroAttrInfo = AirWorkHeroAttrInfo:createInstance()

	heroAttrInfo:initByAgent(entityAttributeNO)

	self._heroAttrInfo = heroAttrInfo
end

function M:getLevel()
	return self._heroAttrInfo.level
end

function M:getHeroAttrInfo()
	return self._heroAttrInfo
end

function M:setHeroAttrInfo(info)
	self._heroAttrInfo = info
end

function M:deepCopyClientPart(heroMO)
	local newHeroAttrInfo = AirWorkHeroAttrInfo:createInstance()
	local heroAttrInfo = heroMO:getHeroAttrInfo()

	if heroAttrInfo then
		newHeroAttrInfo:copy(heroAttrInfo)
	end

	self:setHeroAttrInfo(newHeroAttrInfo)
end

function M:onInit()
	self._condition = 1001
	self._params = 1
end

function M:getUnitType()
	return AirWorkShopEnum.UnitType.Ambush
end

function M:getTabType()
	return AirWorkShopEnum.TabEnum.Hero
end

function M:_initByAgent(unitNO)
	self._heroId = unitNO.hero.heroId
	self._unionIndex = BoardIndexConverter.coordinatesToUnionIndex(unitNO.hero.cell.x, unitNO.hero.cell.z)
	self._condition = unitNO.condition
	self._params = unitNO.params

	local msgMO = AirWorkMessageMO:createByAgent(unitNO.hero.msg)

	self:setMsgMO(msgMO)
end

function M:trans2AgentForm()
	local ambushNO = BattleExtension_pb.AmbushNO()

	ambushNO.hero.heroId = self._heroId
	ambushNO.hero.cell.x, ambushNO.hero.cell.z = BoardIndexConverter.unionIndexToCoordinates(self._unionIndex)
	ambushNO.condition = self._condition
	ambushNO.params = self._params

	if self._messageMO then
		self._messageMO:trans2AgentForm(ambushNO.hero.msg)
	end

	return ambushNO
end

function M:getUnitType()
	return AirWorkShopEnum.UnitType.Ambush
end

function M:setId(heroId)
	self._heroId = heroId
end

function M:getId()
	return self._heroId
end

function M:setUnionIndex(unionIndex)
	self._unionIndex = unionIndex
end

function M:getUnionIndex()
	return self._unionIndex or -1
end

function M:getPosition()
	return BoardIndexConverter.unionIndexToCoordinates(self._unionIndex)
end

function M:getCondition()
	return self._condition
end

function M:getParams()
	return self._params
end

function M:setMsgMO(mo)
	self._messageMO = mo
end

function M:getMsgMO()
	return self._messageMO
end

function M:setConditionAndParams(condition, params)
	self._condition = condition
	self._params = params
end

function M:isSame(heroMO)
	if self._unionIndex ~= heroMO:getUnionIndex() then
		return false
	end

	if self._heroId ~= heroMO:getId() then
		return false
	end

	if self._condition ~= heroMO:getCondition() then
		return false
	end

	local params = heroMO:getParams()

	if self._params ~= params then
		return false
	end

	if self._messageMO then
		local msgMO = heroMO:getMsgMO()

		if not self._messageMO:isSame(msgMO) then
			return false
		end
	elseif heroMO:getMsgMO() then
		return false
	end

	if not self._heroAttrInfo:isSame(heroMO:getHeroAttrInfo()) then
		return false
	end

	return true
end

return M
