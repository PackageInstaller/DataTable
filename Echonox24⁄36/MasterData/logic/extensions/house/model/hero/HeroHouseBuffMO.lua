-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/model/hero/HeroHouseBuffMO.lua

module("logic.extensions.house.model.hero.HeroHouseBuffMO", package.seeall)

local M = class("HeroHouseBuffMO")

function M:ctor(id)
	self._id = id
	self._co = HouseConfig.instance:getConfigByKey(ConfigName.HouseBuff, id)
	self._layer = 0
	self._endTime = 0
end

function M:updateByAgent(NO)
	self._layer = NO.layer
	self._endTime = NO.endTime
end

function M:getName()
	return self._co.name
end

function M:getDescriptionStr()
	return self._co.description
end

function M:setIcon(img)
	IconLoader.setSprite(img, IconType.HouseBuff, self._co.icon)
end

return M
