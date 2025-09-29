-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/DungeonControlModel.lua

module("logic.extensions.dungeon.model.DungeonControlModel", package.seeall)

local M = class("DungeonControlModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:_resetField()
end

function M:onReset()
	self:_resetField()
end

function M:_resetField()
	self._dungeonMoList = {}
end

function M:getDungeonMoById(dungeonId)
	if self._dungeonMoList[dungeonId] == nil then
		local dungeonMo = DungeonControlMO.New()
		local dungeonCo = DungeonConfig.instance:getDungeonCfgById(dungeonId)

		dungeonMo:initByConfig(dungeonCo)
		dungeonMo:initByData(DungeonModel.instance:getDungeonPassDataByDungeonId(dungeonId))

		self._dungeonMoList[dungeonId] = dungeonMo
	end

	return self._dungeonMoList[dungeonId]
end

M.instance = M.New()

return M
