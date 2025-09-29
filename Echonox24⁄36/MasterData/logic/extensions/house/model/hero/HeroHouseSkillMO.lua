-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/model/hero/HeroHouseSkillMO.lua

module("logic.extensions.house.model.hero.HeroHouseSkillMO", package.seeall)

local M = class("HeroHouseSkillMO")

function M:ctor(id)
	self._id = id
	self._ownerType = nil
	self._ownerId = nil
	self._co = HouseConfig.instance:getConfigByKey(ConfigName.HouseSkill, id)
end

function M:updateByAgent(skillNO)
	if skillNO.owner then
		self._ownerType = skillNO.owner.type
		self._ownerId = skillNO.owner.id
	end
end

function M:getName()
	return self._co.name
end

function M:getDescriptionStr()
	return self._co.description
end

function M:setIcon(img)
	IconLoader.setSprite(img, IconType.HouseSkill, self._co.icon)
end

return M
