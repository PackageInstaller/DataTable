local ReserveMultiChessTemplate = class("ReserveMultiChessTemplate", (import("game.reserve.template.ReserveBaseTemplate")))

function ReserveMultiChessTemplate:UpdateServerData(arg_1_1)
	ReserveMultiChessTemplate.super.UpdateServerData(self, arg_1_1)

	if self.cont_dic[arg_1_1.data.cont_id] then
		local var_1_0 = self:GetContDataTemplateById(arg_1_1.data.cont_id)

		var_1_0:UpdatePosData(arg_1_1.data.chess_data_info_1)
		var_1_0:UpdateAiChip(arg_1_1.data.chess_data_info_2)
	end
end

return ReserveMultiChessTemplate
