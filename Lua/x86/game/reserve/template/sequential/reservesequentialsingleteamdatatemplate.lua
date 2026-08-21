local var_0_0 = import("game.reserve.ReserveSingleTeamDataTemplate")
local var_0_1 = class("ReserveSequentialSingleTeamDataTemplate", var_0_0)

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.affixList = {}
end

function var_0_1.SetAffix(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.affixList[arg_2_1] = arg_2_2 or 0
end

function var_0_1.SetAffixList(arg_3_0, arg_3_1)
	arg_3_0.affixList = clone(arg_3_1)
end

function var_0_1.GetAffixList(arg_4_0)
	return clone(arg_4_0.affixList)
end

return var_0_1
