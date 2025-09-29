-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/SkillPerformanceCOUtil.lua

module("logic.battle.config.SkillPerformanceCOUtil", package.seeall)

local SkillPerformanceCOUtil = {}
local kThousandFactor = 0.001

function SkillPerformanceCOUtil.getExtDuration(extValue)
	return extValue.duration * kThousandFactor
end

function SkillPerformanceCOUtil.getExtOffsetX(extValue)
	return (extValue.offsetX or 0) * kThousandFactor
end

function SkillPerformanceCOUtil.getExtOffsetY(extValue)
	return (extValue.offsetY or 0) * kThousandFactor
end

function SkillPerformanceCOUtil.isSoloPerformance(skillCode, status)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillCode)

	return skillCOWrapper:getSelectableTarget(status) == BattleEnum.SkillSelectableTarget.SELF or skillCOWrapper:getSelectableTarget(status) == BattleEnum.SkillSelectableTarget.POSITION or skillCOWrapper:getSkillEffectType(status) == BattleEnum.SkillPurpose.TRANSPORT or skillCOWrapper:getSkillEffectType(status) == BattleEnum.SkillPurpose.SUMMON or skillCOWrapper:getSkillEffectType(status) == BattleEnum.SkillPurpose.PASSIVE or skillCOWrapper:getSkillEffectType(status) == BattleEnum.SkillPurpose.MULTI_ROUND_AOE or skillCOWrapper:getSkillEffectType(status) == BattleEnum.SkillPurpose.MARK or ActiveSkillCOUtil.isReleaseTypeSniping(skillCOWrapper, status)
end

function SkillPerformanceCOUtil.isMultiSoloPerformance(unit, skillCode)
	local modelCO = ModelConfig.instance:getModelConfig(unit.property:getModelCode())
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillCode)
	local animState = skillCOWrapper:getMainAnimState(unit.skill:getSkillStatus())

	return ModelCOUtil.isMultiSoloAnimation(modelCO, animState)
end

function SkillPerformanceCOUtil.isHideUnrelated(skillCode, status)
	local isSoloPerformance = SkillPerformanceCOUtil.isSoloPerformance(skillCode, status)

	if isSoloPerformance then
		local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillCode)

		if skillCOWrapper:getSkillEffectType(status) == BattleEnum.SkillPurpose.PASSIVE and skillCOWrapper:getPerformanceAnimType(status) == BattleEnum.AnimStateType.SpecialAnimName and not string.nilorempty(skillCOWrapper:getMainAnimState(status)) then
			return false
		end

		return true
	end

	return false
end

function SkillPerformanceCOUtil.judgeDeadAudioName(deadCareer)
	if deadCareer == GameEnum.CareerEnum.Grox then
		return "character_death"
	end

	return "grox_death"
end

return SkillPerformanceCOUtil
