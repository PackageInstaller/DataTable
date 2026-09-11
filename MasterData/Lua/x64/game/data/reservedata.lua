local var_0_0 = singletonClass("ReserveData")

function var_0_0.Init(arg_1_0)
	arg_1_0.serverTeamTemplateDicByType_ = {}
	arg_1_0.clientTeamTemplateDicByType_ = {}
end

function var_0_0:InitData(arg_2_1)
	self:UpdateServerTeamTemplate(arg_2_1.teams_info_list)
	self:UpdateServerTeamTemplate(arg_2_1.formation_teams_info_list)
	self:UpdateServerTeamTemplate(arg_2_1.chess_teams_info_list)
	self:UpdateServerTeamTemplate(arg_2_1.solo_challenge_teams_info_list)
end

function var_0_0:UpdateServerTeamTemplate(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		self:UpdateSingleServerTeamTemplate(iter_3_1.team_type, iter_3_1)
	end
end

function var_0_0:UpdateSingleServerTeamTemplate(arg_4_1, arg_4_2)
	self.serverTeamTemplateDicByType_[arg_4_1] = self.serverTeamTemplateDicByType_[arg_4_1] or ReserveTools.GetReserveTemplateClass(arg_4_1).New(arg_4_1)

	self.serverTeamTemplateDicByType_[arg_4_1]:UpdateServerData(arg_4_2)

	if self.clientTeamTemplateDicByType_[arg_4_1] then
		self.clientTeamTemplateDicByType_[arg_4_1]:UpdateServerData(arg_4_2)
	end
end

function var_0_0:GetServerTeamTemplate(arg_5_1)
	self.serverTeamTemplateDicByType_[arg_5_1] = self.serverTeamTemplateDicByType_[arg_5_1] or ReserveTools.GetReserveTemplateClass(arg_5_1).New(arg_5_1)

	return self.serverTeamTemplateDicByType_[arg_5_1]
end

function var_0_0:GetTeamTemplate(arg_6_1)
	self.clientTeamTemplateDicByType_[arg_6_1] = self.clientTeamTemplateDicByType_[arg_6_1] or self.serverTeamTemplateDicByType_[arg_6_1] and self.serverTeamTemplateDicByType_[arg_6_1]:Clone() or ReserveTools.GetReserveTemplateClass(arg_6_1).New(arg_6_1)

	return self.clientTeamTemplateDicByType_[arg_6_1]
end

return var_0_0
