ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleEvent
local var_0_2 = var_0.Battle.BattleConfig

class = var_0_10003

local var_0_3 = var_0_10003("BattleSkillOverrideAutoPilot", var_0.Battle.BattleSkillEffect)

var_0.Battle.BattleSkillOverrideAutoPilot = var_0_3
var_0_3.__name = "BattleSkillOverrideAutoPilot"

function var_0_3.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_3.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._AIID = arg_1_0._tempData.arg_list.ai_id

	return
end

function var_0_3.DoDataEffect(arg_2_0, arg_2_1)
	if not arg_2_1:GetFleetVO() then
		return
	end

	var_2:OverrideJoyStickAutoBot(arg_2_0._AIID)

	return
end

function var_0_3.DataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:DoDataEffect(arg_3_1)

	return
end

return
