local var_0_0 = import("game.reserve.ReserveContDataTemplate")
local var_0_1 = class("ReserveMultiChessContDataTemplate", var_0_0)

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.posDataList_ = {}
end

function var_0_1.UpdatePosData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if not arg_2_0.posDataList_[iter_2_0] then
			arg_2_0.posDataList_[iter_2_0] = ReserveMultiChessPosData.New()
		end

		arg_2_0.posDataList_[iter_2_0]:UpdateServerData(iter_2_1)
	end
end

function var_0_1.UpdateAiChip(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = iter_3_1.team_index

		if arg_3_0.team_dic[var_3_0] then
			arg_3_0.team_dic[var_3_0]:UpdateAiChip(iter_3_1)
		end
	end
end

return var_0_1
