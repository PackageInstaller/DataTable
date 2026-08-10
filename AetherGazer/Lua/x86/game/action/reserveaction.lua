local var_0_0 = {}

manager.net:Bind(63005, function(arg_1_0)
	ReserveData:InitData(arg_1_0)
end)
manager.net:Bind(63999, function(arg_2_0)
	local var_2_0 = arg_2_0.default_teams_info.team_type

	if var_2_0 == ReserveConst.RESERVE_TYPE.DEFAULT then
		ReserveData:UpdateSingleServerTeamTemplate(var_2_0, arg_2_0.default_teams_info)
	end
end)

function var_0_0.SaveContData(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = ReserveTools.GetReserveTemplateByReserveType(arg_3_0):GetContDataTemplateById(arg_3_1)
	local var_3_1 = var_3_0:ConvertToSendData()
	local var_3_2 = {
		team_type = arg_3_0,
		cont_team = var_3_1
	}

	manager.net:SendWithLoadingNew(63000, var_3_2, 63001, function(arg_4_0)
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
	local var_5_0 = {
		team_type = arg_5_0,
		cont_id = arg_5_1
	}

	manager.net:SendWithLoadingNew(63002, var_5_0, 63003, function(arg_6_0, arg_6_1)
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
	local var_7_1 = ReserveTools.GetReserveTemplateByReserveType(var_7_0):GetContDataTemplateById(arg_7_0)
	local var_7_2 = var_7_1:ConverAllTeamToSendData()
	local var_7_3 = {
		cont_id = arg_7_0,
		name = var_7_1:GetName(),
		tags = var_7_1:GetAttributeTagList()
	}
	local var_7_4 = {
		team_type = var_7_0,
		cont_team = var_7_2,
		data = var_7_3
	}

	manager.net:SendWithLoadingNew(63010, var_7_4, 63011, function(arg_8_0)
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
	local var_9_0 = ReserveConst.RESERVE_TYPE.PROPOSAL
	local var_9_1 = ReserveTools.GetReserveTemplateByReserveType(var_9_0):GetContDataTemplateById(arg_9_0)
	local var_9_2 = var_9_1:GetName()
	local var_9_3 = var_9_1:GetAttributeTagList()

	var_9_1:SetName(arg_9_1)
	var_9_1:SetAttributeTagList(arg_9_2)
	var_0_0.SaveReserveProposal(arg_9_0, arg_9_3, function()
		var_9_1:SetName(var_9_2)
		var_9_1:SetAttributeTagList(var_9_3)
	end)
end

function var_0_0.SaveSoloChallengeContData(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = table.nums(SoloChallengeData:GetCompletedStageList(arg_11_0)[arg_11_1])
	local var_11_1 = ActivitySoloChallengeCfg[arg_11_0].stage_id[arg_11_1][2]
	local var_11_2 = ActivitySoloChallengeCfg[arg_11_0].stage_id[arg_11_1][1]
	local var_11_3 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE):GetContDataTemplateById(var_11_2)
	local var_11_4 = {}
	local var_11_5 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		if var_11_0 < iter_11_0 then
			local var_11_6 = var_11_3:GetSingleTeamData(iter_11_0):ConvertToSendData()

			var_11_4[#var_11_4 + 1] = var_11_6

			local var_11_7 = var_11_3:GetAffixList(iter_11_0)
			local var_11_8 = {
				cont_id = var_11_3:GetContID(),
				team_index = iter_11_0,
				artifact = var_11_7
			}

			var_11_5[#var_11_5 + 1] = var_11_8
		end
	end

	local var_11_9 = {
		cont_id = var_11_3:GetContID(),
		teams = var_11_4
	}
	local var_11_10 = {
		team_type = ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE,
		cont_team = var_11_9,
		data = var_11_5
	}

	manager.net:SendWithLoadingNew(63008, var_11_10, 63009, function(arg_12_0)
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
	local var_13_0 = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS
	local var_13_1 = GetHeroTeamActivityID(var_13_0, arg_13_3)
	local var_13_2 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.MULTI_CHESS):GetContDataTemplateById(var_13_1)
	local var_13_3 = {
		cont_id = var_13_1,
		teams = {}
	}

	for iter_13_0 = 1, arg_13_2 do
		local var_13_4 = var_13_2:GetSingleTeamData(iter_13_0):ConvertToSendData()

		var_13_3.teams[iter_13_0] = var_13_4
	end

	local var_13_5 = {
		chess_data_info_1 = {
			{
				cont_id = var_13_1,
				x = arg_13_0,
				z = arg_13_1
			}
		},
		chess_data_info_2 = {}
	}
	local var_13_6 = {
		team_type = ReserveConst.RESERVE_TYPE.MULTI_CHESS,
		cont_team = var_13_3,
		data = var_13_5
	}

	manager.net:SendWithLoadingNew(63006, var_13_6, 63007, function(arg_14_0)
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
