local ReserveMultiChessContDataTemplate = class("ReserveMultiChessContDataTemplate", (import("game.reserve.ReserveContDataTemplate")))

function ReserveMultiChessContDataTemplate:Ctor(arg_1_1, arg_1_2)
	ReserveMultiChessContDataTemplate.super.Ctor(self, arg_1_1, arg_1_2)

	self.posDataList_ = {}
end

function ReserveMultiChessContDataTemplate:UpdatePosData(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		self.posDataList_[iter_2_0] = self.posDataList_[iter_2_0] or ReserveMultiChessPosData.New()

		self.posDataList_[iter_2_0]:UpdateServerData(iter_2_1)
	end
end

function ReserveMultiChessContDataTemplate:UpdateAiChip(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if self.team_dic[iter_3_1.team_index] then
			self.team_dic[iter_3_1.team_index]:UpdateAiChip(iter_3_1)
		end
	end
end

return ReserveMultiChessContDataTemplate
