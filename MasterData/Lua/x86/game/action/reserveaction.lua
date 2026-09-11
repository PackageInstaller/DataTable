local var_0_0 = {}

manager.net:Bind(63005, function(arg_1_0)
	ReserveData:InitData(arg_1_0)
end)
manager.net:Bind(63999, function(arg_2_0)
	if arg_2_0.default_teams_info.team_type == ReserveConst.RESERVE_TYPE.DEFAULT then
		ReserveData:UpdateSingleServerTeamTemplate(arg_2_0.default_teams_info.team_type, arg_2_0.default_teams_info)
	end
end)

function var_0_0.SaveContData(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = ReserveTools.GetReserveTemplateByReserveType(arg_3_0):GetContDataTemplateById(arg_3_1)

	manager.net:SendWithLoadingNew(63000, {
		team_type = arg_3_0,
		cont_team = var_3_0:ConvertToSendData()
	}, 63001, function(arg_4_0)
		if isSuccess(arg_4_0.result) then
			var_3_0:SetIsDirty(false)

			if arg_3_2 then
				arg_3_2(arg_4_0)
			end
		else
			ShowTips(arg_4_0.result)
		end
	end)
end

function var_0_0.ResetContData(arg_5_0, arg_5_1, arg_5_2)
	manager.net:SendWithLoadingNew(63002, {
		team_type = arg_5_0,
		cont_id = arg_5_1
	}, 63003, function(arg_6_0, arg_6_1)
		if isSuccess(arg_6_0.result) then
			ReserveTools.ResetContData(arg_5_0, arg_5_1)

			if arg_5_2 then
				arg_5_2(arg_6_0, arg_6_1)
			end

			manager.notify:Invoke(RESERVE_RESET_CONT_DATA, arg_5_0, arg_5_1)
		else
			ShowTips(arg_6_0.result)
		end
	end)
end

function var_0_0.SaveReserveProposal(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = ReserveConst.RESERVE_TYPE.PROPOSAL
	local var_7_1 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.PROPOSAL):GetContDataTemplateById(arg_7_0)

	manager.net:SendWithLoadingNew(63010, {
		team_type = ReserveConst.RESERVE_TYPE.PROPOSAL,
		cont_team = var_7_1:ConverAllTeamToSendData(),
		data = {
			cont_id = arg_7_0,
			name = var_7_1:GetName(),
			tags = var_7_1:GetAttributeTagList()
		}
	}, 63011, function(arg_8_0)
		if isSuccess(arg_8_0.result) then
			var_7_1:SetIsDirty(false)
			var_7_1:SetIsTemp(false)
			ReserveTools.GetReserveTemplateByReserveType(var_7_0, true):GetContDataTemplateById(arg_7_0):UpdateServerData(var_7_1)

			if arg_7_1 then
				arg_7_1()
			end
		else
			ShowTips(arg_8_0.result)

			if arg_7_2 then
				arg_7_2()
			end
		end
	end)
end

function var_0_0.RenameReserveProposal(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.PROPOSAL):GetContDataTemplateById(arg_9_0)
	local var_9_1 = var_9_0:GetName()
	local var_9_2 = var_9_0:GetAttributeTagList()

	var_9_0:SetName(arg_9_1)
	var_9_0:SetAttributeTagList(arg_9_2)
	var_0_0.SaveReserveProposal(arg_9_0, arg_9_3, function()
		var_9_0:SetName(var_9_1)
		var_9_0:SetAttributeTagList(var_9_2)
	end)
end

function var_0_0.SaveSoloChallengeContData(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = table.nums(SoloChallengeData:GetCompletedStageList(arg_11_0)[arg_11_1])
	local var_11_1 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE):GetContDataTemplateById(ActivitySoloChallengeCfg[arg_11_0].stage_id[arg_11_1][1])
	local var_11_2 = {}
	local var_11_3 = {}

	for iter_11_0, iter_11_1 in ipairs(ActivitySoloChallengeCfg[arg_11_0].stage_id[arg_11_1][2]) do
		if var_11_0 < iter_11_0 then
			var_11_2[#var_11_2 + 1] = var_11_1:GetSingleTeamData(iter_11_0):ConvertToSendData()
			var_11_3[#var_11_3 + 1] = {
				cont_id = var_11_1:GetContID(),
				team_index = iter_11_0,
				artifact = var_11_1:GetAffixList(iter_11_0)
			}
		end
	end

	manager.net:SendWithLoadingNew(63008, {
		team_type = ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE,
		cont_team = {
			cont_id = var_11_1:GetContID(),
			teams = var_11_2
		},
		data = var_11_3
	}, 63009, function(arg_12_0)
		if isSuccess(arg_12_0.result) then
			if arg_11_2 then
				arg_11_2()
			end
		else
			ShowTips(arg_12_0.result)
		end
	end)
end

function var_0_0.SaveMultiChessContData(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = GetHeroTeamActivityID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS, arg_13_3)
	local var_13_1 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.MULTI_CHESS):GetContDataTemplateById(var_13_0)
	local var_13_2 = {
		cont_id = var_13_0,
		teams = {}
	}

	for iter_13_0 = 1, arg_13_2 do
		var_13_2.teams[iter_13_0] = var_13_1:GetSingleTeamData(iter_13_0):ConvertToSendData()
	end

	manager.net:SendWithLoadingNew(63006, {
		team_type = ReserveConst.RESERVE_TYPE.MULTI_CHESS,
		cont_team = var_13_2,
		data = {
			chess_data_info_1 = {
				{
					cont_id = var_13_0,
					x = arg_13_0,
					z = arg_13_1
				}
			},
			chess_data_info_2 = {}
		}
	}, 63007, function(arg_14_0)
		if isSuccess(arg_14_0.result) then
			if arg_13_4 then
				arg_13_4()
			end
		else
			ShowTips(arg_14_0.result)
		end
	end)
end

return var_0_0
