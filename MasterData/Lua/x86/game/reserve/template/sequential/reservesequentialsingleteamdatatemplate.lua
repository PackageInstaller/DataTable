local ReserveSequentialSingleTeamDataTemplate = class("ReserveSequentialSingleTeamDataTemplate", (import("game.reserve.ReserveSingleTeamDataTemplate")))

function ReserveSequentialSingleTeamDataTemplate:Ctor(arg_1_1, arg_1_2)
	ReserveSequentialSingleTeamDataTemplate.super.Ctor(self, arg_1_1, arg_1_2)

	self.affixList = {}
end

function ReserveSequentialSingleTeamDataTemplate:SetAffix(arg_2_1, arg_2_2)
	self.affixList[arg_2_1] = arg_2_2 or 0
end

function ReserveSequentialSingleTeamDataTemplate:SetAffixList(arg_3_1)
	self.affixList = clone(arg_3_1)
end

function ReserveSequentialSingleTeamDataTemplate:GetAffixList()
	return clone(self.affixList)
end

return ReserveSequentialSingleTeamDataTemplate
