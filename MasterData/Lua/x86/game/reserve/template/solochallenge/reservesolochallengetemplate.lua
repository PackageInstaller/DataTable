local ReserveSoloChallengeTemplate = class("ReserveSoloChallengeTemplate", (import("game.reserve.template.ReserveBaseTemplate")))

function ReserveSoloChallengeTemplate:UpdateServerData(arg_1_1)
	ReserveSoloChallengeTemplate.super.UpdateServerData(self, arg_1_1)

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.data) do
		if self.cont_dic[iter_1_1.cont_id] then
			self:GetContDataTemplateById(iter_1_1.cont_id):SetAffixList(iter_1_1.team_index, cleanProtoTable(iter_1_1.artifact))
		end
	end
end

function ReserveSoloChallengeTemplate:GetLockHero(arg_2_1, arg_2_2)
	arg_2_2.lockHeroList = self:GetContDataTemplateById(arg_2_1.contID):GetLockHeroList(arg_2_1.customData.activityID, arg_2_1.customData.difficultyIndex)
	arg_2_2.lockStateList = {
		true,
		true,
		true
	}
end

return ReserveSoloChallengeTemplate
