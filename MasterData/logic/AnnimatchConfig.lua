-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/config/AnnimatchConfig.lua

module("logic.extensions.annimatch.config.AnnimatchConfig", package.seeall)

local AnnimatchConfig = class("AnnimatchConfig", BaseConfig)

function AnnimatchConfig:onInit()
	AnnimatchConfig.super.onInit(self)
end

function AnnimatchConfig:getNames()
	return {
		"annual_competition",
		"annual_competition_system_pet",
		"annual_competition_buff",
		"annual_competition_prize",
		"annual_competition_task",
		"annual_competition_form_check",
		"annual_competition_common",
		"annual_competition_rank_prize",
		"annual_competition_form"
	}
end

function AnnimatchConfig:handleConfig(name, content)
	if name == "annual_competition" then
		self.annual_competitionCfg = content
	elseif name == "annual_competition_system_pet" then
		self.annual_competition_system_petCfg = content
	elseif name == "annual_competition_buff" then
		self.annual_competition_buffCfg = content
	elseif name == "annual_competition_prize" then
		self.annual_competition_prizeCfg = content
	elseif name == "annual_competition_task" then
		self.annual_competition_taskCfg = content
	elseif name == "annual_competition_form_check" then
		self.annual_competition_form_checkCfg = content
	elseif name == "annual_competition_common" then
		self.annual_competition_commonCfg = content
	elseif name == "annual_competition_rank_prize" then
		self.annual_competition_rank_prize = content
	elseif name == "annual_competition_form" then
		self._annual_competition_form = content
	end
end

function AnnimatchConfig:getCfgById(id)
	return self.annual_competitionCfg[id]
end

function AnnimatchConfig:getCommonByKey(key)
	if self.annual_competition_commonCfg[key] then
		if not string.nilorempty(self.annual_competition_commonCfg[key].value2) then
			return self.annual_competition_commonCfg[key].value2
		else
			return self.annual_competition_commonCfg[key].value
		end
	end

	return ""
end

function AnnimatchConfig:getPetCfgs(planId)
	return self.annual_competition_system_petCfg[planId]
end

function AnnimatchConfig:getPetCfg(planId, creepsId)
	return self.annual_competition_system_petCfg[planId][creepsId]
end

function AnnimatchConfig:getPetCheckList()
	return self.annual_competition_form_checkCfg.dataList
end

function AnnimatchConfig:getBuffCfg(planId, id)
	id = checknumber(id)

	return self.annual_competition_buffCfg[planId][id]
end

function AnnimatchConfig:getCompetitionPrizeCfg(planId)
	return self.annual_competition_prizeCfg[planId]
end

function AnnimatchConfig:getCompetitionPrizeCfgByWinTimes(planId, winTimes)
	if self.annual_competition_prizeCfg[planId] then
		return self.annual_competition_prizeCfg[planId][winTimes]
	end
end

function AnnimatchConfig:getCompetitionTaskCfg(planId)
	return self.annual_competition_taskCfg[planId]
end

function AnnimatchConfig:getRankPrizeCfg(actId, rank)
	local rankCfgs = self.annual_competition_rank_prize[actId]

	if rankCfgs then
		for _, cfg in ipairs(rankCfgs) do
			if rank >= cfg.rankRange[1] and rank <= cfg.rankRange[2] then
				return cfg.prize
			end
		end

		return rankCfgs[#rankCfgs].prize
	end
end

function AnnimatchConfig:getFormCfg(activityId, formId)
	return self._annual_competition_form[activityId] and self._annual_competition_form[activityId][formId]
end

AnnimatchConfig.instance = AnnimatchConfig.New()

return AnnimatchConfig
