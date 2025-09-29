-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/def/AirWorkHeroMO.lua

module("logic.extensions.airworkshop.model.def.AirWorkHeroMO", package.seeall)

local M = class("AirWorkHeroMO", AirWorkUnitMOBase)

function M:createInstance(entityId, heroId, unionIndex, msgMO, heroAttrInfo)
	local mo = AirWorkHeroMO.New()

	mo:setEntityId(entityId)
	mo:setId(heroId)
	mo:setUnionIndex(unionIndex)
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

function M:initAttrByClient()
	self._heroAttrInfo = AirWorkHeroAttrInfo:createInstance()

	self._heroAttrInfo:initAttrByClient(self._heroId)
end

function M:getHeroAttrInfo()
	return self._heroAttrInfo
end

function M:getLevel()
	return self._heroAttrInfo.level
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

function M:getUnitType()
	return AirWorkShopEnum.UnitType.Hero
end

function M:getTabType()
	return AirWorkShopEnum.TabEnum.Hero
end

function M:_initByAgent(unitNO)
	self:setId(unitNO.heroId)
	self:setUnionIndex(BoardIndexConverter.coordinatesToUnionIndex(unitNO.cell.x, unitNO.cell.z))

	local msgMO = AirWorkMessageMO:createByAgent(unitNO.msg)

	self:setMsgMO(msgMO)
end

function M:trans2AgentForm()
	local heroNO = BattleExtension_pb.HeroNO()

	heroNO.heroId = self._heroId
	heroNO.cell.x, heroNO.cell.z = BoardIndexConverter.unionIndexToCoordinates(self._unionIndex)

	if self._messageMO then
		self._messageMO:trans2AgentForm(heroNO.msg)
	end

	return heroNO
end

function M:getId()
	return self._heroId
end

function M:setId(heroId)
	self._heroId = heroId
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

function M:setMsgMO(mo)
	self._messageMO = mo
end

function M:getMsgMO()
	return self._messageMO
end

function M:isSame(heroMO)
	if self._unionIndex ~= heroMO:getUnionIndex() then
		return false
	end

	if self._heroId ~= heroMO:getId() then
		return false
	end

	local msgMO = heroMO:getMsgMO()

	if self._messageMO and msgMO then
		if not self._messageMO:isSame(msgMO) then
			printWarn("viking_issame_message", msgMO)

			return false
		end
	elseif not self._messageMO and not msgMO then
		-- block empty
	else
		return false
	end

	if not self._heroAttrInfo:isSame(heroMO:getHeroAttrInfo()) then
		return false
	end

	return true
end

return M
