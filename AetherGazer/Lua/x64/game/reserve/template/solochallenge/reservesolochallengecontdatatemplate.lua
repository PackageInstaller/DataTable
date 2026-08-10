local var_0_0 = import("game.reserve.ReserveContDataTemplate")
local var_0_1 = class("ReserveSoloChallengeContDataTemplate", var_0_0)

function var_0_1.SetAffix(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_0.team_dic[arg_1_1] then
		arg_1_0.team_dic[arg_1_1]:SetAffix(arg_1_2, arg_1_3)
	end
end

function var_0_1.SetAffixList(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.team_dic[arg_2_1] then
		arg_2_0.team_dic[arg_2_1]:SetAffixList(arg_2_2)
	end
end

function var_0_1.GetAffixList(arg_3_0, arg_3_1)
	if arg_3_0.team_dic[arg_3_1] then
		return arg_3_0.team_dic[arg_3_1]:GetAffixList()
	else
		return {}
	end
end

function var_0_1.GetSummaryHeroList(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0.team_dic) do
		local var_4_2 = iter_4_1:GetTeamIndex()
		local var_4_3 = iter_4_1:GetHeroList()

		var_4_0[var_4_2] = var_4_3[1]:GetHeroID()
		var_4_1[var_4_2] = var_4_3[1]:GetTrialID()
	end

	return var_4_0, var_4_1
end

function var_0_1.GetLockHeroList(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {}
	local var_5_1, var_5_2 = arg_5_0:GetSummaryHeroList()
	local var_5_3 = SoloChallengeData:GetCompletedStageList(arg_5_1)[arg_5_2] or {}
	local var_5_4 = ActivitySoloChallengeCfg[arg_5_1].stage_id[arg_5_2][2]

	for iter_5_0 = 1, #var_5_4 do
		if table.indexof(var_5_3, var_5_4[iter_5_0]) then
			if var_5_2[iter_5_0] ~= 0 then
				table.insert(var_5_0, var_5_2[iter_5_0])
			elseif var_5_1[iter_5_0] ~= 0 then
				table.insert(var_5_0, var_5_1[iter_5_0])
			end
		end
	end

	return var_5_0
end

function var_0_1.SetSummaryHeroList(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.team_dic) do
		local var_6_0 = iter_6_1:GetTeamIndex()

		iter_6_1:SetHeroPosData(1, arg_6_1[var_6_0] or 0, arg_6_2[var_6_0] or 0)
	end
end

return var_0_1
