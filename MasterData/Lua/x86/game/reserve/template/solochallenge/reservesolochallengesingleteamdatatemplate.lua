local ReserveSoloChallengeSingleTeamDataTemplate = class("ReserveSoloChallengeSingleTeamDataTemplate", (import("game.reserve.ReserveSingleTeamDataTemplate")))

function ReserveSoloChallengeSingleTeamDataTemplate:Ctor(arg_1_1, arg_1_2)
	ReserveSoloChallengeSingleTeamDataTemplate.super.Ctor(self, arg_1_1, arg_1_2)

	self.affixList = {
		0,
		0
	}
end

function ReserveSoloChallengeSingleTeamDataTemplate:SetAffix(arg_2_1, arg_2_2)
	self.affixList[arg_2_1] = arg_2_2 or 0
end

function ReserveSoloChallengeSingleTeamDataTemplate:SetAffixList(arg_3_1)
	self.affixList = clone(arg_3_1)
end

function ReserveSoloChallengeSingleTeamDataTemplate:GetAffixList()
	return self.affixList
end

return ReserveSoloChallengeSingleTeamDataTemplate
