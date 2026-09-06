-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anmoyangame/config/AnMoYanConfig.lua

module("logic.extensions.anmoyangame.config.AnMoYanConfig", package.seeall)

local AnMoYanConfig = class("AnMoYanConfig", BaseConfig)

function AnMoYanConfig:onInit()
	AnMoYanConfig.super.onInit(self)
end

function AnMoYanConfig:getNames()
	return {
		"dark_mo_yan_game_activity",
		"dark_mo_yan_game_progress_prize",
		"dark_mo_yan_game_plan",
		"dark_mo_yan_drop_plan",
		"dark_mo_yan_piece",
		"dark_mo_yan_game_buy_times"
	}
end

function AnMoYanConfig:handleConfig(name, content)
	if name == "dark_mo_yan_game_activity" then
		self._dark_mo_yan_game_activity = content
	elseif name == "dark_mo_yan_game_progress_prize" then
		self._dark_mo_yan_game_progress_prize = content
	elseif name == "dark_mo_yan_game_plan" then
		self._dark_mo_yan_game_plan = content
	elseif name == "dark_mo_yan_drop_plan" then
		self._dark_mo_yan_drop_plan = content
	elseif name == "dark_mo_yan_piece" then
		self._dark_mo_yan_piece = content
	elseif name == "dark_mo_yan_game_buy_times" then
		self._dark_mo_yan_game_buy_times = content
	end
end

function AnMoYanConfig:getActCfg(activityId)
	return self._dark_mo_yan_game_activity[activityId]
end

function AnMoYanConfig:getProgressCfg(activityId)
	return self._dark_mo_yan_game_progress_prize[activityId]
end

function AnMoYanConfig:getGameCfg(planId)
	return self._dark_mo_yan_game_plan[planId]
end

function AnMoYanConfig:getDropPlanCfg()
	return self._dark_mo_yan_drop_plan
end

function AnMoYanConfig:getDropPlanCfgById(dropPlanId)
	return self._dark_mo_yan_drop_plan[dropPlanId]
end

function AnMoYanConfig:getDropPieceCfg()
	return self._dark_mo_yan_piece
end

function AnMoYanConfig:getDropBuyTimesCfg(planId)
	return self._dark_mo_yan_game_buy_times[planId]
end

function AnMoYanConfig:getDropBuyTimesCfgsByType(planId, typeId)
	return self._dark_mo_yan_game_buy_times[planId] and self._dark_mo_yan_game_buy_times[planId][typeId]
end

function AnMoYanConfig:getGamePlanId(activityId)
	return self._dark_mo_yan_game_activity[activityId] and self._dark_mo_yan_game_activity[activityId].gamePlanId
end

function AnMoYanConfig:getBuyTimePlanId(activityId)
	return self._dark_mo_yan_game_activity[activityId] and self._dark_mo_yan_game_activity[activityId].buyTimePlanId
end

AnMoYanConfig.instance = AnMoYanConfig.New()

return AnMoYanConfig
