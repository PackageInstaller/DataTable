ys = ys or {}

local var_0_0 = class("BattleSkillEditCustomWarning", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillEditCustomWarning = var_0_0
var_0_0.__name = "BattleSkillEditCustomWarning"
var_0_0.OP_ADD = 1
var_0_0.OP_REMOVE = 0
var_0_0.OP_REMOVE_PERMANENT = -1
var_0_0.OP_REMOVE_TEMPLATE = -2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, lv)

	arg_1_0._labelData = {
		op = arg_1_0._tempData.arg_list.op,
		key = arg_1_0._tempData.arg_list.key,
		x = arg_1_0._tempData.arg_list.x,
		y = arg_1_0._tempData.arg_list.y,
		dialogue = arg_1_0._tempData.arg_list.dialogue,
		duration = arg_1_0._tempData.arg_list.duration
	}

	return
end

function var_0_0.DoDataEffect(arg_2_0)
	arg_2_0:doEditWarning()

	return
end

function var_0_0.DoDataEffectWithoutTarget(arg_3_0)
	arg_3_0:doEditWarning()

	return
end

function var_0_0.doEditWarning(arg_4_0)
	var_0.Battle.BattleDataProxy.GetInstance():DispatchCustomWarning(arg_4_0._labelData)

	return
end

return
