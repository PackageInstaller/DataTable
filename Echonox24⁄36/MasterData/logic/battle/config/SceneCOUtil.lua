-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/SceneCOUtil.lua

module("logic.battle.config.SceneCOUtil", package.seeall)

local SceneCOUtil = {}
local kDelimiter = "/"

function SceneCOUtil.getSceneName(sceneCO)
	return string.split(sceneCO.resPath, kDelimiter)[3]
end

function SceneCOUtil.getBattleSceneName(sceneCO)
	return string.split(sceneCO.battleResPath, kDelimiter)[2]
end

return SceneCOUtil
