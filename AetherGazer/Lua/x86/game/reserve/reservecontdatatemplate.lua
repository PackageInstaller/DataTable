local var_0_0 = class("ReserveContDataTemplate")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.team_type = arg_1_1 or ReserveConst.RESERVE_TYPE.DEFAULT
	arg_1_0.cont_id = arg_1_2 or ReserveConst.DETAULT_CONT_ID
	arg_1_0.teams = {}
	arg_1_0.team_dic = {}
	arg_1_0.is_dirty = false
end

function var_0_0.UpdateServerData(arg_2_0, arg_2_1)
	arg_2_0.cont_id = arg_2_1.cont_id

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.teams) do
		local var_2_0 = iter_2_1.team_index

		arg_2_0:GetSingleTeamData(var_2_0):UpdateServerData(iter_2_1)
	end
end

function var_0_0.SetTeamType(arg_3_0, arg_3_1)
	arg_3_0.team_type = arg_3_1
end

function var_0_0.GetTeamType(arg_4_0)
	return arg_4_0.team_type
end

function var_0_0.GetContID(arg_5_0)
	return arg_5_0.cont_id
end

function var_0_0.SetContID(arg_6_0, arg_6_1)
	arg_6_0.cont_id = arg_6_1
end

function var_0_0.GetIsDirty(arg_7_0)
	return arg_7_0.is_dirty
end

function var_0_0.SetIsDirty(arg_8_0, arg_8_1)
	arg_8_0.is_dirty = arg_8_1
end

function var_0_0.GetHeroList(arg_9_0, arg_9_1)
	return arg_9_0:GetSingleTeamData(arg_9_1):GetHeroList()
end

function var_0_0.SetHeroList(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0:SetIsDirty(true)
	arg_10_0:GetSingleTeamData(arg_10_3):SetHeroList(arg_10_1, arg_10_2)
end

function var_0_0.GetAddedHeroIDList(arg_11_0, arg_11_1)
	return arg_11_0:GetSingleTeamData(arg_11_1):GetAddedHeroIDList()
end

function var_0_0.GetComboSkillID(arg_12_0, arg_12_1)
	return arg_12_0:GetSingleTeamData(arg_12_1):GetComboSkillID()
end

function var_0_0.SetComboSkillID(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:SetIsDirty(true)
	arg_13_0:GetSingleTeamData(arg_13_2):SetComboSkillID(arg_13_1)
end

function var_0_0.GetMimirID(arg_14_0, arg_14_1)
	return arg_14_0:GetSingleTeamData(arg_14_1):GetMimirID()
end

function var_0_0.SetMimirID(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:SetIsDirty(true)
	arg_15_0:GetSingleTeamData(arg_15_2):SetMimirID(arg_15_1)
end

function var_0_0.GetMimirChipList(arg_16_0, arg_16_1)
	return arg_16_0:GetSingleTeamData(arg_16_1):GetMimirChipList()
end

function var_0_0.SetMimirChipList(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:SetIsDirty(true)
	arg_17_0:GetSingleTeamData(arg_17_2):SetMimirChipList(arg_17_1)
end

function var_0_0.ResetMimirChipList(arg_18_0, arg_18_1)
	arg_18_0:GetSingleTeamData(arg_18_1):ResetMimirChipList()
end

function var_0_0.GetCharChipBaseID(arg_19_0, arg_19_1)
	return arg_19_0:GetSingleTeamData(arg_19_1):GetCharChipBaseID()
end

function var_0_0.SetCharChipBaseID(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0:SetIsDirty(true)

	return arg_20_0:GetSingleTeamData(arg_20_2):SetCharChipBaseID(arg_20_1)
end

function var_0_0.GetTeamDataList(arg_21_0)
	return arg_21_0.teams
end

function var_0_0.GetSingleTeamData(arg_22_0, arg_22_1)
	arg_22_1 = arg_22_1 or arg_22_0:GetTeamIndex()

	if not arg_22_0.team_dic[arg_22_1] then
		arg_22_0.team_dic[arg_22_1] = arg_22_0:GetSingleTeamDataTemplateClass().New(arg_22_0:GetTeamType(), arg_22_1)
		arg_22_0.teams[#arg_22_0.teams + 1] = arg_22_0.team_dic[arg_22_1]
	end

	return arg_22_0.team_dic[arg_22_1]
end

function var_0_0.SwapTeam(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0:GetSingleTeamData(arg_23_1)
	local var_23_1 = arg_23_0:GetSingleTeamData(arg_23_2)

	var_23_0:SetTeamIndex(arg_23_2)

	arg_23_0.team_dic[arg_23_2] = var_23_0

	var_23_1:SetTeamIndex(arg_23_1)

	arg_23_0.team_dic[arg_23_1] = var_23_1
end

function var_0_0.GetTeamIndex(arg_24_0)
	return ReserveConst.DEFAULT_TEAM_INDEX
end

function var_0_0.GetTeamCount(arg_25_0)
	return #arg_25_0.teams
end

function var_0_0.CleanCacheData(arg_26_0)
	if not arg_26_0:GetIsDirty() then
		return
	end

	local var_26_0 = ReserveTools.GetReserveTemplateByReserveType(arg_26_0:GetTeamType(), true):GetContDataTemplateById(arg_26_0:GetContID())

	for iter_26_0, iter_26_1 in pairs(arg_26_0.team_dic) do
		iter_26_1:UpdateServerData(var_26_0:GetSingleTeamData(iter_26_0))
	end

	arg_26_0:SetIsDirty(false)
end

function var_0_0.Clone(arg_27_0)
	return deepClone(arg_27_0)
end

function var_0_0.GetSingleTeamDataTemplateClass(arg_28_0)
	return ReserveTools.GetSingleTeamDataClass(arg_28_0:GetTeamType())
end

function var_0_0.ConvertToSendData(arg_29_0)
	local var_29_0 = {
		cont_id = arg_29_0:GetContID(),
		teams = {}
	}

	for iter_29_0, iter_29_1 in ipairs(arg_29_0.team_dic) do
		var_29_0.teams[iter_29_0] = iter_29_1:ConvertToSendData()
	end

	return var_29_0
end

function var_0_0.ConverAllTeamToSendData(arg_30_0)
	local var_30_0 = {
		cont_id = arg_30_0:GetContID(),
		teams = {}
	}

	for iter_30_0, iter_30_1 in ipairs(arg_30_0.teams) do
		var_30_0.teams[iter_30_0] = iter_30_1:ConvertToSendData()
	end

	return var_30_0
end

function var_0_0.Reset(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.team_dic) do
		iter_31_1:Reset()
	end

	arg_31_0.teams = {}
	arg_31_0.team_dic = {}
	arg_31_0.is_dirty = false
end

return var_0_0
