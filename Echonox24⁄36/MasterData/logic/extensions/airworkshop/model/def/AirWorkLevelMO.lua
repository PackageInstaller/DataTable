-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/def/AirWorkLevelMO.lua

module("logic.extensions.airworkshop.model.def.AirWorkLevelMO", package.seeall)

local M = class("AirWorkLevelMO")

function M:ctor()
	self._id = false
	self._testPass = false
	self._online = false
	self._mapMo = false
	self._statMo = false
	self._index = false
end

function M:initByAgent(levelNO)
	self._id = levelNO.id
	self._testPass = levelNO.testPass
	self._online = levelNO.online
	self._index = levelNO.createPos
	self._mapMo = AirWorkMapMO.New()

	self._mapMo:initByAgent(levelNO.info, levelNO.attribute)

	self._cover = levelNO.stat.cover
	self._statMo = AirWorkStatMO.New()

	self._statMo:initByAgent(levelNO.stat)
end

function M:getId()
	return self._id
end

function M:setId(id)
	self._id = id
end

function M:getMapMO()
	return self._mapMo
end

function M:setMapMO(mapMo)
	self._mapMo = mapMo
end

function M:setIndex(index)
	self._index = index
end

function M:getIndex()
	return self._index
end

function M:setPassTest(status)
	self._testPass = status
end

function M:getPassTest()
	return self._testPass
end

function M:setOnlineStatus(status)
	self._online = status
end

function M:getOnlineStatus()
	return self._online
end

function M:getStatMO()
	return self._statMo
end

function M:setStatMO(statMo)
	self._statMo = statMo
end

function M:getCover()
	return self._cover
end

function M:setCover(cover)
	self._cover = cover
end

return M
