-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/model/ArenaLastPrizeMO.lua

module("logic.extensions.arena.model.ArenaLastPrizeMO", package.seeall)

local ArenaLastPrizeMO = class("ArenaLastPrizeMO")

function ArenaLastPrizeMO:ctor()
	self._arenaId = 0
	self._zoneId = 0
	self._position = 0
	self._topGroupId = 0
	self._hasGain = 0
end

function ArenaLastPrizeMO:initMo(key, value)
	self["_" .. key] = value
end

return ArenaLastPrizeMO
