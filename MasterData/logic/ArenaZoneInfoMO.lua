-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/model/ArenaZoneInfoMO.lua

module("logic.extensions.arena.model.ArenaZoneInfoMO", package.seeall)

local ArenaZoneInfoMO = class("ArenaZoneInfoMO")

function ArenaZoneInfoMO:ctor()
	self._userId = 0
	self._userName = ""
	self._clothes = 0
	self._maxZdl = 0
	self._position = 0
	self.gender = 0
end

function ArenaZoneInfoMO:initMo(mo)
	self._userId = mo.userId
	self._userName = mo.userName
	self._clothes = mo.clothes or {}
	self._maxZdl = mo.maxZdl
	self._position = mo.position
	self.gender = mo.gender

	if checknumber(mo.userId) == -1 then
		self._userName = lang("替身木桩")
	end

	for i, v in ipairs(mo.clothes) do
		printInfo("clothes:==============" .. v)
	end

	printInfo("self._userid:" .. self._userId)
	printInfo("self._userName:" .. self._userName)
	printInfo("self._position:" .. self._position)
end

function ArenaZoneInfoMO:getPosition()
	return self._position
end

return ArenaZoneInfoMO
