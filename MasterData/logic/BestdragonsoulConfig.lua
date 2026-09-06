-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bestdragonsoul/config/BestdragonsoulConfig.lua

module("logic.extensions.bestdragonsoul.config.BestdragonsoulConfig", package.seeall)

local BestdragonsoulConfig = class("BestdragonsoulConfig", BaseConfig)

function BestdragonsoulConfig:onInit()
	return
end

function BestdragonsoulConfig:getNames()
	return {
		"best_dragon_soul_activity",
		"best_dragon_soul_progress_prize",
		"best_dragon_soul_like",
		"best_dragon_soul_game",
		"best_dragon_soul_game_stage",
		"best_dragon_soul_game_prop",
		"best_dragon_soul_params"
	}
end

function BestdragonsoulConfig:handleConfig(name, content)
	if name == "best_dragon_soul_activity" then
		self._best_dragon_soul_activity = content
	elseif name == "best_dragon_soul_progress_prize" then
		self._best_dragon_soul_progress_prize = content
	elseif name == "best_dragon_soul_like" then
		self._best_dragon_soul_like = content
	elseif name == "best_dragon_soul_game" then
		self._best_dragon_soul_game = content
	elseif name == "best_dragon_soul_game_stage" then
		self._best_dragon_soul_game_stage = content
	elseif name == "best_dragon_soul_game_prop" then
		self._best_dragon_soul_game_prop = content
	elseif name == "best_dragon_soul_params" then
		self._best_dragon_soul_params = content
	end
end

function BestdragonsoulConfig:getGamePlanId(activityId)
	return self._best_dragon_soul_activity[activityId].gamePlanId
end

function BestdragonsoulConfig:getDayGameTimes(activityId)
	return self._best_dragon_soul_activity[activityId].dailyTimes
end

function BestdragonsoulConfig:getGameDataById(gamePlanId)
	return self._best_dragon_soul_game[gamePlanId]
end

function BestdragonsoulConfig:getMaxScorePerGame()
	return (self:getCommomValue("MAX_SCORE_PER_GAME", true))
end

function BestdragonsoulConfig:getCommomValue(key, need2number)
	local value = self._best_dragon_soul_params[key].value

	if need2number then
		return checknumber(value)
	end

	return value
end

function BestdragonsoulConfig:getGameStageCfg(gamePlanId)
	return self._best_dragon_soul_game_stage[gamePlanId]
end

function BestdragonsoulConfig:getGameAreaData(gamePlanId, stageIdx, areaIdx)
	return self:getGameStageData(gamePlanId, stageIdx)[areaIdx]
end

function BestdragonsoulConfig:getGameStageData(gamePlanId, stageIdx)
	return self:getGameStageCfg(gamePlanId)[stageIdx]
end

function BestdragonsoulConfig:getGamePropData(propId)
	return self._best_dragon_soul_game_prop[propId]
end

function BestdragonsoulConfig:getGamePassScore()
	return (self:getCommomValue("PASS_GAME_SCORE", true))
end

function BestdragonsoulConfig:getActCfg(activityId)
	return self._best_dragon_soul_activity[activityId]
end

function BestdragonsoulConfig:getLikeCfgs(activityId)
	return self._best_dragon_soul_like[activityId]
end

function BestdragonsoulConfig:getTotalLikeTime(activityId, typeId, progress)
	local likeTime = 0

	for i, v in ipairs(self._best_dragon_soul_progress_prize.dataList) do
		if v.activityId == activityId and v.type == typeId and progress >= v.progress then
			likeTime = v.likeTime + likeTime
		end
	end

	return likeTime
end

function BestdragonsoulConfig:getProgressPrizeCfgs(activityId, typeId)
	return self._best_dragon_soul_progress_prize[activityId][typeId]
end

function BestdragonsoulConfig:getProgressPrizeCfg(activityId, typeId, prizeId)
	return self._best_dragon_soul_progress_prize[activityId][typeId][prizeId]
end

BestdragonsoulConfig.instance = BestdragonsoulConfig.New()

return BestdragonsoulConfig
