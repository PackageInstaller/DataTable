ys = ys or {}

local var_0_0 = class("BattleSkillPhaseJump", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillPhaseJump = var_0_0
var_0_0.__name = "BattleSkillPhaseJump"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, lv)

	arg_1_0._phaseIndex = arg_1_0._tempData.arg_list.index or 0

	return
end

function var_0_0.DoDataEffect(arg_2_0, arg_2_1)
	arg_2_0:doJump(arg_2_1)

	return
end

function var_0_0.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:doJump(arg_3_1)

	return
end

function var_0_0.doJump(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetPhaseSwitcher()

	if var_4_0 then
		var_4_0:ForceSwitch(arg_4_0._phaseIndex)
	end

	return
end

return
