-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/config/DungeonEntranceConfig.lua

module("logic.extensions.dungeon.config.DungeonEntranceConfig", package.seeall)

local M = class("DungeonEntranceConfig", BaseConfig)

function M:onInit()
	self._cfgDungeonFristEntrance = false
	self._cfgDungeonSecondEntrance = false
	self._cfgDungeonMainLineChapter = false
end

function M:getNames()
	return {
		ConfigName.DungeonFirstEntrance,
		ConfigName.DungeonSecondEntrance,
		ConfigName.DungeonMainLineChapter
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.DungeonFirstEntrance then
		self._cfgDungeonFristEntrance = content
	elseif name == ConfigName.DungeonSecondEntrance then
		self._cfgDungeonSecondEntrance = content
	elseif name == ConfigName.DungeonMainLineChapter then
		self._cfgDungeonMainLineChapter = content
	elseif enableErrorLog then
		printError("unhandle config", name)
	end
end

function M:getDungeonFirstEntranceByCode(entranceCode)
	local firstEntranceCO = self._cfgDungeonFristEntrance[entranceCode]

	return firstEntranceCO
end

function M:getCfgFirstEntrance()
	return self._cfgDungeonFristEntrance.dataList
end

function M:getCfgSecondEntrance()
	return self._cfgDungeonSecondEntrance.dataList
end

function M:getCfgMainLineChapter()
	return self._cfgDungeonMainLineChapter.dataList
end

M.instance = M.New()

return M
