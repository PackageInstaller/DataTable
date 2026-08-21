local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveMultiChessTemplate", var_0_0)

function var_0_1.UpdateServerData(arg_1_0, arg_1_1)
	var_0_1.super.UpdateServerData(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_1.data
	local var_1_1 = var_1_0.cont_id

	if arg_1_0.cont_dic[var_1_1] then
		local var_1_2 = arg_1_0:GetContDataTemplateById(var_1_1)

		var_1_2:UpdatePosData(var_1_0.chess_data_info_1)
		var_1_2:UpdateAiChip(var_1_0.chess_data_info_2)
	end
end

return var_0_1
