-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmm/config/AixinmmConfig.lua

module("logic.extensions.aixinmm.config.AixinmmConfig", package.seeall)

local AixinmmConfig = class("AixinmmConfig", BaseConfig)

function AixinmmConfig:onInit()
	return
end

function AixinmmConfig:getNames()
	return {
		"ai_xin_mm_monster",
		"ai_xin_mm_creeps",
		"ai_xin_mm_common"
	}
end

function AixinmmConfig:handleConfig(name, content)
	if name == "ai_xin_mm_monster" then
		self._ai_xin_mm_monsterCfg = content
	elseif name == "ai_xin_mm_creeps" then
		self._ai_xin_mm_creepsCfg = content
	elseif name == "ai_xin_mm_common" then
		self._ai_xin_mm_commonCfg = content
	end
end

function AixinmmConfig:getEvolvePetRaceId()
	return checknumber(self._ai_xin_mm_commonCfg.EVOLVE_PET_RACE_ID.value)
end

function AixinmmConfig:getCommonCfg(key)
	return self._ai_xin_mm_commonCfg[key].value
end

function AixinmmConfig:getChallengeId()
	return checknumber(self._ai_xin_mm_commonCfg.CHALLENGE_ID.value)
end

function AixinmmConfig:getMainViewModelSizeCfg()
	local str = self._ai_xin_mm_commonCfg.MAINVIEW_ROLEMODEL_CFG.value
	local arr = string.split(str, ",")

	return checknumber(arr[1]), checknumber(arr[2]), checknumber(arr[3])
end

function AixinmmConfig:getMonsterCfgs()
	return self._ai_xin_mm_monsterCfg
end

function AixinmmConfig:getMonsterCfg(masterId)
	return self._ai_xin_mm_monsterCfg[masterId]
end

function AixinmmConfig:getCreepCfgs(masterId)
	return self._ai_xin_mm_creepsCfg[masterId]
end

function AixinmmConfig:getCreepsCfg(masterId, creepsId)
	return self._ai_xin_mm_creepsCfg[masterId][creepsId]
end

AixinmmConfig.instance = AixinmmConfig.New()

return AixinmmConfig
