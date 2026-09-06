-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/model/ArenaRankPrizeMO.lua

module("logic.extensions.arena.model.ArenaRankPrizeMO", package.seeall)

local ArenaRankPrizeMO = class("ArenaRankPrizeMO")

function ArenaRankPrizeMO:ctor()
	self._arenaAchieveInfos = nil
end

function ArenaRankPrizeMO:initMO(arenaAchieveInfos)
	if self._arenaAchieveInfos then
		self._arenaAchieveInfos = nil
		self._arenaAchieveInfos = {}
	end

	for i, v in ipairs(arenaAchieveInfos) do
		table.insert(self._arenaAchieveInfos, v)
	end
end

return ArenaRankPrizeMO
