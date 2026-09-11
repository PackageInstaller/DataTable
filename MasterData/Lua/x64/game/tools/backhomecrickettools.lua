local var_0_0 = {}

local function var_0_1(arg_1_0)
	return
end

function var_0_0.GetSkillEffectStruct(arg_2_0)
	if IdolTraineeSkillEffectCfg[arg_2_0] then
		local var_2_0 = var_0_1(IdolTraineeSkillEffectCfg[arg_2_0])

		if var_2_0.effectType == BackHomeCricketConst.SKILL_EFFECT_TYPE.ATTRIBUTE_CHNAGE then
			var_2_0 = {
				attributeType = IdolTraineeSkillEffectCfg[arg_2_0].unique[1],
				percent = IdolTraineeSkillEffectCfg[arg_2_0].unique[2]
			}
		elseif var_2_0.effectType == BackHomeCricketConst.SKILL_EFFECT_TYPE.ACTION_SCORE_CHANGE then
			var_2_0 = {
				attributeAction = IdolTraineeSkillEffectCfg[arg_2_0].unique[1],
				percent = IdolTraineeSkillEffectCfg[arg_2_0].unique[2]
			}
		elseif var_2_0.effectType == BackHomeCricketConst.SKILL_EFFECT_TYPE.SKILL_RELEASE then
			var_2_0 = {
				percent = IdolTraineeSkillEffectCfg[arg_2_0].unique[1]
			}
		elseif var_2_0.effectType == BackHomeCricketConst.SKILL_EFFECT_TYPE.BEHAVIOR_SCORE_CHANGE then
			var_2_0 = {
				point = IdolTraineeSkillEffectCfg[arg_2_0].unique[1]
			}
		elseif var_2_0.effectType == BackHomeCricketConst.SKILL_EFFECT_TYPE.TOTAL_SCORE_CHANGE then
			var_2_0 = {
				percent = IdolTraineeSkillEffectCfg[arg_2_0].unique[1]
			}
		end

		return var_2_0
	else
		Debug.LogError("未获取到对应技能效果id配置 " .. arg_2_0)
	end
end

return var_0_0
