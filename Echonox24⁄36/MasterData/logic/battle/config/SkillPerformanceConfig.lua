-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/SkillPerformanceConfig.lua

module("logic.battle.config.SkillPerformanceConfig", package.seeall)

local SkillPerformanceConfig = class("SkillPerformanceConfig")

function SkillPerformanceConfig:getSkillPerformanceTimeline(animState, modeCode)
	if not animState or string.nilorempty(animState) then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("该技能没有配置表现动作:%s", modeCode))
		end

		return
	end

	local modelCO = ModelConfig.instance:getModelConfig(modeCode)

	return string.format("%s_%s", ModelCOUtil.getPerformanceResName(modelCO), animState)
end

function SkillPerformanceConfig:getCounteredSkillAnimState(skillCode, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillCode)

	return skillCOWrapper:getCounteredAnimState(status)
end

function SkillPerformanceConfig:getMainSkillAnimState(skillCode, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillCode)

	return skillCOWrapper:getMainAnimState(status)
end

function SkillPerformanceConfig:getSkillMultiPerformanceTimeline(animState, modeCode, part)
	if not animState or string.nilorempty(animState) then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("该技能没有配置表现动作:%s %s", modeCode, part))
		end

		return
	end

	local modelCO = ModelConfig.instance:getModelConfig(modeCode)

	return string.format("%s_%s_%s", ModelCOUtil.getPerformanceResName(modelCO), animState, part)
end

local kDefaultAttackSkip = "default_attack_skip"

function SkillPerformanceConfig:getSkillSkipPerformanceTimeline(attacker, skillId)
	if BattleSkillAssist:isCure(skillId, attacker.skill:getSkillStatus()) then
		return kDefaultAttackSkip
	end

	if attacker.meshModel:containsAnimation(UnitAnimState.AttackSkip) then
		local modeCode = attacker.property:getModelCode()
		local modelCO = ModelConfig.instance:getModelConfig(modeCode)

		return string.format("%s_%s", ModelCOUtil.getPerformanceResName(modelCO), UnitAnimState.AttackSkip)
	else
		if BattleLog.enableWarn then
			BattleLog.warn("Cannot find attack skip animation,already change to default timeline.")
		end

		return kDefaultAttackSkip
	end
end

function SkillPerformanceConfig:getSimplePerformanceTimeline(modeCode, animState)
	local modelCO = ModelConfig.instance:getModelConfig(modeCode)

	return string.format("%s_%s", ModelCOUtil.getPerformanceResName(modelCO), animState)
end

function SkillPerformanceConfig:getPerformanceTimelineWithSuffix(timelineResPath, suffix)
	return string.format("%s_%s", timelineResPath, suffix)
end

function SkillPerformanceConfig:isSpecialPerformance(animState)
	return not string.nilorempty(animState)
end

function SkillPerformanceConfig:isGlobalSkill(animState)
	if animState and string.find(animState, "global:") then
		return true
	end

	return false
end

function SkillPerformanceConfig:getGlobalSkillEffect(animState)
	if animState and string.find(animState, "global:") then
		local effectCode = checkint(string.gsub(animState, "global:", ""))

		if effectCode == 0 and enableErrorLog then
			printError("全局技能Code配置错误:", animState)

			return
		end

		return effectCode
	end

	return false
end

function SkillPerformanceConfig:isSkipPerformance(attackInfo)
	local attacker = attackInfo:getAttacker()
	local skillId = attackInfo:getSkillId()

	if not SkillPerformanceCOUtil.isSoloPerformance(skillId, attacker.skill:getSkillStatus()) then
		local settingModel = BattleMgr.instance:getSettingModel()

		return not settingModel:isEnableSkillPerformance(attacker)
	end

	return false
end

SkillPerformanceConfig.instance = SkillPerformanceConfig.New()

return SkillPerformanceConfig
