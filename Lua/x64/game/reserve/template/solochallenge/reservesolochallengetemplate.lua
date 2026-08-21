local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveSoloChallengeTemplate", var_0_0)

function var_0_1.UpdateServerData(arg_1_0, arg_1_1)
	var_0_1.super.UpdateServerData(arg_1_0, arg_1_1)

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.data) do
		local var_1_0 = iter_1_1.cont_id

		if arg_1_0.cont_dic[var_1_0] then
			local var_1_1 = arg_1_0:GetContDataTemplateById(var_1_0)
			local var_1_2 = iter_1_1.team_index

			var_1_1:SetAffixList(var_1_2, cleanProtoTable(iter_1_1.artifact))
		end
	end
end

function var_0_1.GetLockHero(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2.lockHeroList = arg_2_0:GetContDataTemplateById(arg_2_1.contID):GetLockHeroList(arg_2_1.customData.activityID, arg_2_1.customData.difficultyIndex)
	arg_2_2.lockStateList = {
		true,
		true,
		true
	}
end

return var_0_1
