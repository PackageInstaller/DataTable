-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelinvestor/config/AngelInvestorConfig.lua

module("logic.extensions.angelinvestor.config.AngelInvestorConfig", package.seeall)

local AngelInvestorConfig = class("AngelInvestorConfig", BaseConfig)

function AngelInvestorConfig:getNames()
	return {
		"angel_investor_activity",
		"angel_investor_creeps",
		"angel_investor_invest_level",
		"angel_investor_master",
		"angel_investor_prize_lv",
		"angel_investor_prize",
		"angel_investor_stage",
		"angel_investor_system_pet"
	}
end

function AngelInvestorConfig:handleConfig(name, content)
	if name == "angel_investor_activity" then
		self._angel_investor_activity = content
	elseif name == "angel_investor_creeps" then
		self._angel_investor_creeps = content
	elseif name == "angel_investor_invest_level" then
		self._angel_investor_invest_level = content
	elseif name == "angel_investor_master" then
		self._angel_investor_master = content
	elseif name == "angel_investor_prize_lv" then
		self._angel_investor_prize_lv = content
	elseif name == "angel_investor_prize" then
		self._angel_investor_prize = content
	elseif name == "angel_investor_stage" then
		self._angel_investor_stage = content
	elseif name == "angel_investor_system_pet" then
		self._angel_investor_system_pet = content
	end
end

function AngelInvestorConfig:getActivityCfg(activityId)
	return self._angel_investor_activity[activityId]
end

function AngelInvestorConfig:getCreepsCfgs(creepsMasterId)
	return self._angel_investor_creeps[creepsMasterId]
end

function AngelInvestorConfig:getInvestLevelCfgs(activityId)
	return self._angel_investor_invest_level[activityId]
end

function AngelInvestorConfig:getInvestLevelCfg(activityId, level)
	return self._angel_investor_invest_level[activityId] and self._angel_investor_invest_level[activityId][level]
end

function AngelInvestorConfig:getMasterCfg(creepsMasterId)
	return self._angel_investor_master[creepsMasterId]
end

function AngelInvestorConfig:getPrizeLvCfgs(activityId, prizeId)
	return self._angel_investor_prize_lv[activityId] and self._angel_investor_prize_lv[activityId][prizeId]
end

function AngelInvestorConfig:getPrizeLvCfg(activityId, prizeId, lv)
	local cfgs = self:getPrizeLvCfgs(activityId, prizeId)

	return cfgs and cfgs[lv]
end

function AngelInvestorConfig:getPrizeCfgs(activityId)
	return self._angel_investor_prize[activityId]
end

function AngelInvestorConfig:getPrizeCfg(activityId, prizeId)
	return self._angel_investor_prize[activityId] and self._angel_investor_prize[activityId][prizeId]
end

function AngelInvestorConfig:getStageCfgs(activityId)
	return self._angel_investor_stage[activityId]
end

function AngelInvestorConfig:getStageCfg(activityId, stageId)
	return self._angel_investor_stage[activityId] and self._angel_investor_stage[activityId][stageId]
end

function AngelInvestorConfig:getCreepMasterId(activityId, stageId)
	local stageCfg = self:getStageCfg(activityId, stageId)

	return stageCfg and stageCfg.creepsMasterId
end

function AngelInvestorConfig:getSystemPetCfgs(activityId)
	local actCfg = self:getActivityCfg(activityId)

	if actCfg then
		if not actCfg.systemPetPlanId then
			local systemPetPlanId = 0

			return self._angel_investor_system_pet[systemPetPlanId]
		end
	end
end

function AngelInvestorConfig:getOpenRewardPrizeCfgs(activityId, angelLv, curType)
	local prizeCfgs = self:getPrizeCfgs(activityId)
	local cfgs = {}

	for i, cfg in ipairs(prizeCfgs) do
		if angelLv >= cfg.unlockLv and cfg.type == curType then
			table.insert(cfgs, cfg)
		end
	end

	return cfgs
end

AngelInvestorConfig.instance = AngelInvestorConfig.New()

return AngelInvestorConfig
