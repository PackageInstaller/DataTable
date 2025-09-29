-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/model/RogueEquipMo.lua

module("logic.extensions.roguelike.model.RogueEquipMo", package.seeall)

local M = class("RogueEquipMo")

function M:ctor(equipNo)
	self:updateByNo(equipNo)
end

function M:updateByNo(equipNo)
	self._id = equipNo.id
	self._level = equipNo.lv
	self._cd = equipNo.cd
	self._co = BackpackConfig.instance:getItemInfoByItemId(equipNo.id)
	self._equipCo = RoguelikeConfig.instance:getEquipById(equipNo.id, equipNo.lv)
end

function M:getId()
	return self._id
end

function M:getLevel()
	return self._level
end

function M:setLevel(level)
	self._level = level
end

function M:getMaxLevel()
	return RoguelikeConfig.instance:getEquipMaxLevel(self._id)
end

function M:getIsMaxLevel()
	local maxLevel = RoguelikeConfig.instance:getEquipMaxLevel(self._id)

	return maxLevel <= self._level
end

function M:getName()
	return self._co.name
end

function M:getQuality()
	return self._co.quality
end

function M:getIcon()
	return self._co.icon
end

function M:getCo()
	return self._co
end

function M:getCd()
	return self._cd
end

function M:getPassiveEffects()
	return self._equipCo.passiveEffects
end

function M:getActiveEffects()
	return self._equipCo.activeEffects
end

function M:getRejectedScripts()
	return self._co.rejectedScripts
end

function M:getIsInRejectedScripts(scriptId)
	local reject = self:getRejectedScripts() or {}

	for k, v in pairs(reject) do
		if v == scriptId then
			return true
		end
	end

	return false
end

return M
