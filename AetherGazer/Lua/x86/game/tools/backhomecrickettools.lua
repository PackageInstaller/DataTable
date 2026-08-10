local var_0_0 = {}

local function var_0_1(arg_1_0)
	local var_1_0 = {
		effectType = arg_1_0.effect_type,
		object = arg_1_0.object,
		triggetTime = arg_1_0.trigger_time,
		round = arg_1_0.round,
		probability = arg_1_0.probability
	}
end

function var_0_0.GetSkillEffectStruct(arg_2_0)
	local var_2_0 = IdolTraineeSkillEffectCfg[arg_2_0]

	if var_2_0 then
		local var_2_1 = var_0_1(var_2_0)
		local var_2_2 = var_2_1.effectType
		local var_2_3 = var_2_0.unique

		if var_2_2 == BackHomeCricketConst.SKILL_EFFECT_TYPE.ATTRIBUTE_CHNAGE then
			var_2_1 = {
				attributeType = var_2_3[1],
				percent = var_2_3[2]
			}
		elseif var_2_2 == BackHomeCricketConst.SKILL_EFFECT_TYPE.ACTION_SCORE_CHANGE then
			var_2_1 = {
				attributeAction = var_2_3[1],
				percent = var_2_3[2]
			}
		elseif var_2_2 == BackHomeCricketConst.SKILL_EFFECT_TYPE.SKILL_RELEASE then
			var_2_1 = {
				percent = var_2_3[1]
			}
		elseif var_2_2 == BackHomeCricketConst.SKILL_EFFECT_TYPE.BEHAVIOR_SCORE_CHANGE then
			var_2_1 = {
				point = var_2_3[1]
			}
		elseif var_2_2 == BackHomeCricketConst.SKILL_EFFECT_TYPE.TOTAL_SCORE_CHANGE then
			var_2_1 = {
				percent = var_2_3[1]
			}
		end

		return var_2_1
	else
		Debug.LogError("未获取到对应技能效果id配置 " .. arg_2_0)
	end
end

return var_0_0
