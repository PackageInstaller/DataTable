-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echoitem/data/EchoItemData.lua

module("logic.extensions.echoitem.data.EchoItemData", package.seeall)

local M = class("EchoItemData", ItemData)

function M:ctor(params)
	M.super.ctor(self, params)

	self._heroId = nil
	self._level = nil
	self._cost = nil
	self._decomposedItemId = false
	self._decomposedItemCount = false
end

function M:getId()
	return self._itemInfo.id
end

function M:getCareer()
	return self._itemInfo.career
end

function M:getCost()
	local cost

	if not self:getIsMaxLevel() then
		local attCfg = EchoItemConfig.instance:getCfg(self:getId(), self:getLevel() + 1)

		if attCfg and not string.nilorempty(attCfg.cost) then
			local strKeyVal = string.match(attCfg.cost, "%d+:%d+")
			local arr = string.splitToNumber(strKeyVal, ":")

			cost = {
				code = tonumber(arr[1]),
				count = tonumber(arr[2])
			}
		end
	end

	return cost
end

function M:getDecomposedItem()
	if not self._decomposedItemId then
		local decomposedItem = self._itemInfo.decomposedItem
		local info = string.gmatch(decomposedItem, "(%d+):(%d+)")

		for id, count in info do
			self._decomposedItemId = id
			self._decomposedItemCount = tonumber(count)
		end
	end

	local hasBreakCount = self:getToBreakTargetLevelNeed(self._level) + 1
	local decomposedItemCount = self._decomposedItemCount * hasBreakCount

	return self._decomposedItemId, decomposedItemCount
end

function M:getToBreakTargetLevelNeed(level)
	if not level then
		return 0
	end

	local count = 0

	for i = 2, level do
		count = count + self:getUpgradeNeedCount(i)
	end

	return count
end

function M:_getSkills()
	local attCfg = EchoItemConfig.instance:getCfg(self:getId(), self:getLevel())

	return attCfg and attCfg.skills or {}
end

function M:_getSkillId()
	return self:_getSkills()[1]
end

function M:_getEnhanceSkills()
	local skills = self:_getSkills()

	return TableUtil.subTable(skills, 2, #skills)
end

function M:getHouseNo()
	return self._itemInfo.houseNo
end

function M:getReport()
	return self._itemInfo.report
end

function M:isCanDecompose()
	return not self._itemInfo.prohibitDecompose
end

function M:isDescTagContainTargetTag(tagIds)
	local skillEnhanceMO = self:getSkillEnhanceMO()
	local dict = skillEnhanceMO:getDescTagIdList()

	if not dict then
		return false
	end

	for key, value in pairs(tagIds) do
		if dict[value] then
			return true
		end
	end

	return false
end

function M:getSkillEnhanceMO()
	if not self._skillEnhanceMO then
		local skill = self:_getSkillId()

		self._skillEnhanceMO = SkillEnhanceMO.New(skill)

		if self._skillEnhanceMO then
			self._skillEnhanceMO:rebuild()
			self._skillEnhanceMO:buildDescription()
		end
	end

	return self._skillEnhanceMO
end

function M:updateSkillEnhanceMO()
	local skillEnhanceMO = self:getSkillEnhanceMO()
	local skillIds = self:_getEnhanceSkills()

	skillEnhanceMO:clear()

	for i = 1, #skillIds do
		skillEnhanceMO:addSkillEnhanceCode(skillIds[i])
	end

	skillEnhanceMO:rebuild()
end

function M:getBigIcon()
	return self._itemInfo.bigIcon
end

function M:setHeroId(heroId)
	self._heroId = heroId
end

function M:getHeroId(heroId)
	return self._heroId or 0
end

function M:setLevel(level)
	if self._level ~= level then
		self._level = level

		self:updateSkillEnhanceMO()
	end
end

function M:getLevel()
	return self._level or 1
end

function M:getIsMaxLevel()
	return self._level == self:getMaxLevel()
end

function M:getMaxLevel()
	return EchoItemConfig.instance:getMaxLevel(self:getId())
end

function M:getUpgradeNeedCount(lv)
	lv = lv or self:getLevel() + 1

	return EchoItemConfig.instance:getUpgradeNeedCount(lv, self:getQuality())
end

function M:getAttr()
	return EchoItemConfig.instance:getAttrLst(self:getId(), self:getLevel())
end

function M:getIsEquip()
	if self._heroId then
		return self._heroId ~= 0
	else
		return false
	end
end

function M:isUnlockDynamicEffect()
	local unlockLevel = EchoItemConfig.instance:getUnlockDynamicEffectLevel(self:getQuality())

	return unlockLevel <= self:getLevel()
end

return M
