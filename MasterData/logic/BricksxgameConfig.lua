-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bricksxgame/config/BricksxgameConfig.lua

module("logic.extensions.bricksxgame.config.BricksxgameConfig", package.seeall)

local BricksxgameConfig = class("BricksxgameConfig", BaseConfig)

function BricksxgameConfig:getNames()
	return {
		"xiao_xiao_le_game_activity",
		"xiao_xiao_le_game_prize",
		"xiao_xiao_le_game_rank_prize",
		"xiao_xiao_le_game_shape_list",
		"xiao_xiao_le_game_block"
	}
end

function BricksxgameConfig:handleConfig(name, content)
	if name == "xiao_xiao_le_game_activity" then
		self._xiao_xiao_le_game_activity = content
	elseif name == "xiao_xiao_le_game_prize" then
		self._xiao_xiao_le_game_prize = content
	elseif name == "xiao_xiao_le_game_rank_prize" then
		self._xiao_xiao_le_game_rank_prize = content
	elseif name == "xiao_xiao_le_game_shape_list" then
		self._xiao_xiao_le_game_shape_list = content
	elseif name == "xiao_xiao_le_game_block" then
		self._xiao_xiao_le_game_block = content
	end
end

function BricksxgameConfig:getPorgressListById(activityId)
	return self._xiao_xiao_le_game_prize[activityId]
end

function BricksxgameConfig:getActivityCfgById(activityId)
	return self._xiao_xiao_le_game_activity[activityId]
end

function BricksxgameConfig:getBlockById(id)
	return self._xiao_xiao_le_game_block[id]
end

function BricksxgameConfig:getShapeListById(planId)
	return self._xiao_xiao_le_game_shape_list[planId]
end

function BricksxgameConfig:getRankPrizeCfg(activityId, rank)
	if not self._xiao_xiao_le_game_rank_prize[activityId] then
		for k, v in pairs(self._xiao_xiao_le_game_rank_prize[activityId]) do
			if rank >= v.rankRange[1] and rank <= v.rankRange[2] then
				return v
			end
		end
	end
end

BricksxgameConfig.instance = BricksxgameConfig.New()

return BricksxgameConfig
