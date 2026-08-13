ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffOrb", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffOrb = var_0_1
var_0_1.__name = "BattleBuffOrb"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._buffID = arg_2_0._tempData.arg_list.buff_id

	local var_2_0

	if not var_3.rant then
		var_2_0 = 10000
	end

	arg_2_0._rant = var_2_0

	local var_2_1

	if not var_3.level then
		var_2_1 = 1
	end

	arg_2_0._level = var_2_1

	local var_2_2

	if not var_3.buff_level then
		var_2_2 = 1
	end

	arg_2_0._buffLevel = var_2_2
	arg_2_0._type = var_3.type

	return
end

function var_0_1.onTrigger(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_3._bullet

	if arg_3_0._type and var_3_0:GetTemplate().type ~= arg_3_0._type then
		return
	end

	arg_3_0:attachOrb(var_3_0)
	var_0_1.super.onTrigger(arg_3_0, arg_3_1, arg_3_2, arg_3_3)

	return
end

function var_0_1.attachOrb(arg_4_0, arg_4_1)
	local var_4_0 = {
		buff_id = arg_4_0._buffID,
		rant = arg_4_0._rant,
		level = arg_4_0._level,
		buff_level = arg_4_0._buffLevel
	}

	arg_4_1:AppendAttachBuff(var_4_0)

	return
end

return
