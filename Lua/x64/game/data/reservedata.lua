local var_0_0 = singletonClass("ReserveData")

function var_0_0.Init(arg_1_0)
	arg_1_0.serverTeamTemplateDicByType_ = {}
	arg_1_0.clientTeamTemplateDicByType_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0:UpdateServerTeamTemplate(arg_2_1.teams_info_list)
	arg_2_0:UpdateServerTeamTemplate(arg_2_1.formation_teams_info_list)
	arg_2_0:UpdateServerTeamTemplate(arg_2_1.chess_teams_info_list)
	arg_2_0:UpdateServerTeamTemplate(arg_2_1.solo_challenge_teams_info_list)
end

function var_0_0.UpdateServerTeamTemplate(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = iter_3_1.team_type

		arg_3_0:UpdateSingleServerTeamTemplate(var_3_0, iter_3_1)
	end
end

function var_0_0.UpdateSingleServerTeamTemplate(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0.serverTeamTemplateDicByType_[arg_4_1] then
		arg_4_0.serverTeamTemplateDicByType_[arg_4_1] = ReserveTools.GetReserveTemplateClass(arg_4_1).New(arg_4_1)
	end

	arg_4_0.serverTeamTemplateDicByType_[arg_4_1]:UpdateServerData(arg_4_2)

	if arg_4_0.clientTeamTemplateDicByType_[arg_4_1] then
		arg_4_0.clientTeamTemplateDicByType_[arg_4_1]:UpdateServerData(arg_4_2)
	end
end

function var_0_0.GetServerTeamTemplate(arg_5_0, arg_5_1)
	if not arg_5_0.serverTeamTemplateDicByType_[arg_5_1] then
		arg_5_0.serverTeamTemplateDicByType_[arg_5_1] = ReserveTools.GetReserveTemplateClass(arg_5_1).New(arg_5_1)
	end

	return arg_5_0.serverTeamTemplateDicByType_[arg_5_1]
end

function var_0_0.GetTeamTemplate(arg_6_0, arg_6_1)
	if not arg_6_0.clientTeamTemplateDicByType_[arg_6_1] then
		if arg_6_0.serverTeamTemplateDicByType_[arg_6_1] then
			arg_6_0.clientTeamTemplateDicByType_[arg_6_1] = arg_6_0.serverTeamTemplateDicByType_[arg_6_1]:Clone()
		else
			arg_6_0.clientTeamTemplateDicByType_[arg_6_1] = ReserveTools.GetReserveTemplateClass(arg_6_1).New(arg_6_1)
		end
	end

	return arg_6_0.clientTeamTemplateDicByType_[arg_6_1]
end

return var_0_0
