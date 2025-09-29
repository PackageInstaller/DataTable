-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/model/MonitorMo.lua

module("logic.extensions.controlaction.model.MonitorMo", package.seeall)

local M = class("MonitorMo")

function M:ctor()
	self._zoneCode = 1
	self._dungeonGroupCode = 1
	self._code = 1
	self._zoneCo = false
	self._dungeonGroupCo = false
	self._postCo = false
end

function M:init(dataNO)
	self._zoneCode = dataNO.area
	self._dungeonGroupCode = dataNO.level
	self._code = dataNO.postCode

	if not self._zoneCo then
		self._zoneCo = ControlActionConfig.instance:getMonitorZoneCfg(self._zoneCode)

		if not self._zoneCo then
			printError("===the zone code error.=== code= ", self._zoneCode)
		end
	end

	if not self._dungeonGroupCo then
		self._dungeonGroupCo = ControlActionConfig.instance:getMonitorDungeonGroupCfg(self._dungeonGroupCode)

		if not self._dungeonGroupCo then
			printError("===the dungeonGroupCode code error.=== code= ", self._dungeonGroupCode)
		end
	end

	if not self._postCo then
		self._postCo = ControlActionConfig.instance:getThemePostCfg(self._code)

		if not self._postCo then
			printError("===the MonitorMo theme post code error.=== code= ", self._code)
		end
	end
end

function M:getZoneName()
	return self._zoneCo.name
end

function M:getZoneCo()
	return self._zoneCo
end

function M:getDungeonGroupCode()
	return self._dungeonGroupCode
end

function M:getDungeonGroupCo()
	return self._dungeonGroupCo
end

function M:getThemePostCo()
	return self._postCo
end

function M:getDungeonIndex(dungeonId)
	local dungeonGroupCo = self:getDungeonGroupCo()
	local index = table.indexof(dungeonGroupCo.dungeonCodes, dungeonId)

	return index and index or 1
end

return M
