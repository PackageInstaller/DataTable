-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlecalculateeditor/flow/BattleCalculateEditorModel.lua

module("logic.extensions.battlecalculateeditor.flow.BattleCalculateEditorModel", package.seeall)

local M = class("BattleCalculateEditorModel", BattleModel)
local kDefaultScene = "sx-s116_abandoned-city/scene_run/sx-s116_abandoned-city_run"

function M:onStart()
	self._sceneCode = 0

	self:setScenePath(kDefaultScene)
end

function M:getSceneName()
	return self._resName
end

function M:getScenePath()
	return self._resPath
end

function M:setScenePath(path)
	local splitStrs = string.split(path, "/")
	local count = #splitStrs
	local name = string.gsub(splitStrs[count], ".unity", "")

	self._resPath = string.format("%s/%s/%s", splitStrs[count - 2], splitStrs[count - 1], name)
	self._resName = name
end

function M:getSceneCode()
	self._sceneCode = self._sceneCode + 1

	return self._sceneCode
end

function M:getOperateCampId()
	return 1
end

return M
