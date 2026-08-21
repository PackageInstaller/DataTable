ys = ys or {}

local var_0_2 = class("BattleSkillOverrideAutoPilot", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillOverrideAutoPilot = var_0_2
var_0_2.__name = "BattleSkillOverrideAutoPilot"

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._AIID = arg_1_0._tempData.arg_list.ai_id

	return
end

function var_0_2.DoDataEffect(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:GetFleetVO()

	if not var_2_0 then
		return
	end

	var_2_0:OverrideJoyStickAutoBot(arg_2_0._AIID)

	return
end

function var_0_2.DataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:DoDataEffect(arg_3_1)

	return
end

return
