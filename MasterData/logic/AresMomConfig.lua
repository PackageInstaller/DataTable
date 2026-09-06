-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/config/AresMomConfig.lua

module("logic.extensions.aresmom.config.AresMomConfig", package.seeall)

local AresMomConfig = class("AresMomConfig", BaseConfig)

function AresMomConfig:onInit()
	AresMomConfig.super.onInit(self)
end

function AresMomConfig:getNames()
	return {
		"ares_mom",
		"ares_client_common",
		"ares_mom_type",
		"ares_mom_stage",
		"ares_mom_settler",
		"ares_mom_prize",
		"ares_mom_master",
		"ares_mom_creeps",
		"ares_mom_sys_pet",
		"ares_mom_game",
		"ares_mom_game_block",
		"ares_mom_sld_setting"
	}
end

function AresMomConfig:handleConfig(name, content)
	if name == "ares_mom" then
		self._actCfg = content
	elseif name == "ares_client_common" then
		self._clientCommonCfg = content
	elseif name == "ares_mom_type" then
		self._planCfgs = content
	elseif name == "ares_mom_stage" then
		self._stageCfgs = content
	elseif name == "ares_mom_settler" then
		self._settlerCfgs = content
	elseif name == "ares_mom_prize" then
		self._prizeCfgs = content
	elseif name == "ares_mom_master" then
		self._creepCfgs = content
	elseif name == "ares_mom_creeps" then
		self._creepMonsterCfgs = content
	elseif name == "ares_mom_sys_pet" then
		self._supportPetsCfgs = content
	elseif name == "ares_mom_game" then
		self._gameCfgs = content
	elseif name == "ares_mom_game_block" then
		self._blockCfgs = content
	elseif name == "ares_mom_sld_setting" then
		self._sldSettingCfgs = content
	end
end

function AresMomConfig:getActCfgById(id)
	return self._actCfg[id]
end

function AresMomConfig:getAmClientCommonValue(challengeId, key, isToNumber)
	local baseData = self:getActCfgById(challengeId)

	if baseData then
		if not baseData.comPlanId then
			local comPlanId = 0

			if self._clientCommonCfg[comPlanId] then
				local data = self._clientCommonCfg[comPlanId][key]
				local value

				if data then
					value = data.value

					if isToNumber then
						value = checknumber(value)
					end
				end

				return value
			end
		end
	end
end

function AresMomConfig:getTypeCfg(challengeId, type)
	if not self._planCfgs[challengeId] then
		return self._planCfgs[challengeId][type]
	end
end

function AresMomConfig:getGamePlanId(challengeId, type)
	local data = self:getTypeCfg(challengeId, type)

	return data and data.gridPlanId
end

function AresMomConfig:getStagePlanId(challengeId, type)
	local data = self:getTypeCfg(challengeId, type)

	return data and data.stagePlanId
end

function AresMomConfig:getStageCfg(planId, dayId, stageId)
	return self._stageCfgs[planId] and self._stageCfgs[planId][dayId] and self._stageCfgs[planId][dayId][stageId]
end

function AresMomConfig:getSettlerCfg(Id)
	return self._settlerCfgs[Id]
end

function AresMomConfig:getPrizeCfgs(prizePlanId)
	return self._prizeCfgs[prizePlanId]
end

function AresMomConfig:getCreepCfg(creepId)
	return self._creepCfgs[creepId]
end

function AresMomConfig:getCreepMonstersCfgs(creepId)
	return self._creepMonsterCfgs[creepId]
end

function AresMomConfig:getSupportPetsCfgs(planId)
	return self._supportPetsCfgs[planId]
end

function AresMomConfig:getGameCfg(planId, subId)
	return self._gameCfgs[planId] and self._gameCfgs[planId][subId]
end

function AresMomConfig:getBlockCfg(cheallengeId, Id)
	return self._blockCfgs[cheallengeId][Id]
end

function AresMomConfig:getSldCfgs()
	return self._sldSettingCfgs
end

AresMomConfig.instance = AresMomConfig.New()

return AresMomConfig
