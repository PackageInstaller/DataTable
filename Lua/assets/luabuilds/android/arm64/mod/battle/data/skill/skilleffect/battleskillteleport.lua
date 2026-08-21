ys = ys or {}

local var_0_0 = class("BattleSkillTeleport", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillTeleport = var_0_0
var_0_0.__name = "BattleSkillTeleport"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_0.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1:SetPosition((arg_2_0.calcCorrdinate(arg_2_0._tempData.arg_list, arg_2_1, arg_2_2)))

	return
end

function var_0_0.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_1:SetPosition((arg_3_0.calcCorrdinate(arg_3_0._tempData.arg_list, arg_3_1)))

	return
end

return
