local ReserveMultiChessSingleTeamDataTemplate = class("ReserveMultiChessSingleTeamDataTemplate", (import("game.reserve.ReserveSingleTeamDataTemplate")))

function ReserveMultiChessSingleTeamDataTemplate:Ctor(arg_1_1, arg_1_2)
	ReserveMultiChessSingleTeamDataTemplate.super.Ctor(self, arg_1_1, arg_1_2)

	self.aiChipList = {}
end

function ReserveMultiChessSingleTeamDataTemplate:UpdateAiChip(arg_2_1)
	self.aiChipList = cleanProtoTable(arg_2_1)
end

function ReserveMultiChessSingleTeamDataTemplate:GetAiChip()
	return self.aiChipList
end

function ReserveMultiChessSingleTeamDataTemplate:SetAiChip(arg_4_1)
	self.aiChipList = clone(arg_4_1)
end

return ReserveMultiChessSingleTeamDataTemplate
