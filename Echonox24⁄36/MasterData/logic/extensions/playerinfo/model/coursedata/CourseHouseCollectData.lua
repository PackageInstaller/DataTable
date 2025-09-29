-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/coursedata/CourseHouseCollectData.lua

module("logic.extensions.playerinfo.model.coursedata.CourseHouseCollectData", package.seeall)

local M = class("CourseHouseCollectData")

function M:ctor(houseInfo)
	local houses = {}

	for i, v in ipairs(houseInfo.room) do
		local house = CourseHouseData.buildFromMsg(v)

		house.sortIndex = i

		table.insert(houses, house)
	end

	self._houseData = houses
	self._count = houseInfo.totalCount
	self._atmosphere = houseInfo.totalAtmosphere
end

function M:updateContent(ids)
	local houses = {}

	for i, v in ipairs(ids) do
		local mo = LivingFacilitiesZoneModel.instance:getZoneById(v)

		if mo then
			local house = CourseHouseData.buildFromDepot(mo)

			house.sortIndex = i

			table.insert(houses, house)
		end
	end

	self._houseData = houses
end

function M:getDisplayHouse()
	return self._houseData
end

function M:getHouseCount()
	return self._count
end

function M:getHouseAtmosphere()
	return self._atmosphere
end

return M
