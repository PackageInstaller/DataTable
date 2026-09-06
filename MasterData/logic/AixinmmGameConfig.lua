-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmmgame/config/AixinmmGameConfig.lua

module("logic.extensions.aixinmmgame.config.AixinmmGameConfig", package.seeall)

local AixinmmGameConfig = class("AixinmmGameConfig", BaseConfig)

function AixinmmGameConfig:onInit()
	AixinmmGameConfig.super.onInit(self)

	self.axmm_game_activity = nil
	self.axmm_game_prize = nil
	self.axmm_game_plan = nil
	self.axmm_game_common = nil
	self.axmm_game_put_common = nil
	self.axmm_game_put_model = nil
	self.axmm_game_put_pet = nil
end

function AixinmmGameConfig:getNames()
	return {
		"axmm_game_activity",
		"axmm_game_prize",
		"axmm_game_plan",
		"axmm_game_common",
		"axmm_game_put_common",
		"axmm_game_put_model",
		"axmm_game_put_pet"
	}
end

function AixinmmGameConfig:handleConfig(name, content)
	if name == "axmm_game_activity" then
		self.axmm_game_activity = content
	elseif name == "axmm_game_prize" then
		self.axmm_game_prize = content
	elseif name == "axmm_game_plan" then
		self.axmm_game_plan = content
	elseif name == "axmm_game_common" then
		self.axmm_game_common = content
	elseif name == "axmm_game_put_common" then
		self.axmm_game_put_common = content
	elseif name == "axmm_game_put_model" then
		self.axmm_game_put_model = content
	elseif name == "axmm_game_put_pet" then
		self.axmm_game_put_pet = content
	end
end

function AixinmmGameConfig:getActCfg(actId)
	return self.axmm_game_activity[actId]
end

function AixinmmGameConfig:getGamePrizeCfgs(planId)
	return self.axmm_game_prize[planId]
end

function AixinmmGameConfig:getDefineValue(key, need2number)
	if need2number then
		return checknumber(self.axmm_game_common[key].value)
	else
		return self.axmm_game_common[key].value
	end
end

function AixinmmGameConfig:getGameSlotCfg(slotId)
	return self.axmm_game_put_common[slotId]
end

function AixinmmGameConfig:getGamePlanCfgs(planId)
	return self.axmm_game_plan[planId]
end

function AixinmmGameConfig:getGameTemplateCfgs(templateId)
	return self.axmm_game_put_model[templateId]
end

function AixinmmGameConfig:getPetTemplateCfgs(stageId)
	return self.axmm_game_put_pet[stageId]
end

AixinmmGameConfig.instance = AixinmmGameConfig.New()

return AixinmmGameConfig
