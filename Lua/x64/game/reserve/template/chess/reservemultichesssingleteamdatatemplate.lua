local var_0_0 = import("game.reserve.ReserveSingleTeamDataTemplate")
local var_0_1 = class("ReserveMultiChessSingleTeamDataTemplate", var_0_0)

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.aiChipList = {}
end

function var_0_1.UpdateAiChip(arg_2_0, arg_2_1)
	arg_2_0.aiChipList = cleanProtoTable(arg_2_1)
end

function var_0_1.GetAiChip(arg_3_0)
	return arg_3_0.aiChipList
end

function var_0_1.SetAiChip(arg_4_0, arg_4_1)
	arg_4_0.aiChipList = clone(arg_4_1)
end

return var_0_1
