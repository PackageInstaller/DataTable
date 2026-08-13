ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleSkillEditCustomWarning", var_0.Battle.BattleSkillEffect)

var_0.Battle.BattleSkillEditCustomWarning = var_0_1
var_0_1.__name = "BattleSkillEditCustomWarning"
var_0_1.OP_ADD = 1
var_0_1.OP_REMOVE = 0
var_0_1.OP_REMOVE_PERMANENT = -1
var_0_1.OP_REMOVE_TEMPLATE = -2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = var_0_1.super.Ctor
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_1

	lv = var_1_10006

	var_1_0(var_1_1, var_1_2, var_1_10006)

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

function var_0_1.DoDataEffect(arg_2_0)
	arg_2_0:doEditWarning()

	return
end

function var_0_1.DoDataEffectWithoutTarget(arg_3_0)
	arg_3_0:doEditWarning()

	return
end

function var_0_1.doEditWarning(arg_4_0)
	local var_4_0 = var_0.Battle.BattleDataProxy.GetInstance()

	var_1.DispatchCustomWarning(var_4_0, arg_4_0._labelData)

	return
end

return
