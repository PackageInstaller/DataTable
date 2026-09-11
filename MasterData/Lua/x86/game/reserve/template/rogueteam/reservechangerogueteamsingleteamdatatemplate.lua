local ReserveChangeRogueTeamSingleTeamDataTemplate = class("ReserveChangeRogueTeamSingleTeamDataTemplate", (import("game.reserve.ReserveSingleTeamDataTemplate")))

function ReserveChangeRogueTeamSingleTeamDataTemplate:Ctor(arg_1_1, arg_1_2)
	ReserveChangeRogueTeamSingleTeamDataTemplate.super.Ctor(self, arg_1_1, arg_1_2)

	self.aiChipList = {}
end

function ReserveChangeRogueTeamSingleTeamDataTemplate:UpdateAiChip(arg_2_1)
	self.aiChipList = cleanProtoTable(arg_2_1)
end

function ReserveChangeRogueTeamSingleTeamDataTemplate:GetAiChip()
	return self.aiChipList
end

function ReserveChangeRogueTeamSingleTeamDataTemplate:SetAiChip(arg_4_1)
	self.aiChipList = clone(arg_4_1)
end

return ReserveChangeRogueTeamSingleTeamDataTemplate
