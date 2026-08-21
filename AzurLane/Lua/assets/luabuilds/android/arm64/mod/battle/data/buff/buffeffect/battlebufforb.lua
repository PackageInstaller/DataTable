ys = ys or {}

local var_0_0 = class("BattleBuffOrb", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffOrb = var_0_0
var_0_0.__name = "BattleBuffOrb"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._buffID = arg_2_0._tempData.arg_list.buff_id
	arg_2_0._rant = arg_2_0._tempData.arg_list.rant or 10000
	arg_2_0._level = arg_2_0._tempData.arg_list.level or 1
	arg_2_0._buffLevel = arg_2_0._tempData.arg_list.buff_level or 1
	arg_2_0._type = arg_2_0._tempData.arg_list.type

	return
end

function var_0_0.onTrigger(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_0._type and arg_3_3._bullet:GetTemplate().type ~= arg_3_0._type then
		return
	end

	arg_3_0:attachOrb(arg_3_3._bullet)
	var_0_0.super.onTrigger(arg_3_0, arg_3_1, arg_3_2, arg_3_3)

	return
end

function var_0_0.attachOrb(arg_4_0, arg_4_1)
	arg_4_1:AppendAttachBuff({
		buff_id = arg_4_0._buffID,
		rant = arg_4_0._rant,
		level = arg_4_0._level,
		buff_level = arg_4_0._buffLevel
	})

	return
end

return
