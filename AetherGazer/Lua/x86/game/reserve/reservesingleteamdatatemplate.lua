local var_0_0 = class("ReserveSingleTeamDataTemplate")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.team_type = arg_1_1 or ReserveConst.RESERVE_TYPE.DEFAULT
	arg_1_0.team_index = arg_1_2 or ReserveConst.DEFAULT_TEAM_INDEX
	arg_1_0.hero_list = {}
	arg_1_0.last_hero_list = {}
	arg_1_0.cooperate_unique_skill_id = ReserveConst.DEFAULT_COMBO_SKILL_ID
	arg_1_0.mimir_info = arg_1_0:GetMimirDataClass().New()
	arg_1_0.char_chip_id = 0

	for iter_1_0 = 1, ReserveConst.MAX_HERO_POS_COUNT do
		arg_1_0.hero_list[iter_1_0] = arg_1_0:GetHeroPosClass().New(iter_1_0)
	end
end

function var_0_0.UpdateServerData(arg_2_0, arg_2_1)
	arg_2_0.team_index = arg_2_1.team_index
	arg_2_0.hero_list = arg_2_0.hero_list or {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.hero_list) do
		arg_2_0.hero_list[iter_2_0]:UpdateServerData(iter_2_1, iter_2_0)
	end

	arg_2_0.cooperate_unique_skill_id = arg_2_1.cooperate_unique_skill_id

	arg_2_0.mimir_info:UpdateServerData(arg_2_1.mimir_info)

	arg_2_0.char_chip_id = arg_2_1.mimir_info.hero_id or arg_2_1.char_chip_id or 0
end

function var_0_0.GetTeamIndex(arg_3_0)
	return arg_3_0.team_index
end

function var_0_0.SetTeamIndex(arg_4_0, arg_4_1)
	arg_4_0.team_index = arg_4_1 or ReserveConst.DEFAULT_TEAM_INDEX
end

function var_0_0.SetTeamType(arg_5_0, arg_5_1)
	arg_5_0.team_type = arg_5_1
end

function var_0_0.GetTeamType(arg_6_0)
	return arg_6_0.team_type
end

function var_0_0.SetHeroList(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1 = arg_7_1 or {}
	arg_7_2 = arg_7_2 or {}

	arg_7_0:SaveLastHeroList()

	for iter_7_0, iter_7_1 in ipairs(arg_7_0:GetHeroList()) do
		arg_7_0:SetHeroPosData(iter_7_0, arg_7_1[iter_7_0], arg_7_2[iter_7_0])
	end

	arg_7_0:TryUpdateComboSkillID()
end

function var_0_0.SaveLastHeroList(arg_8_0)
	arg_8_0.last_hero_list = deepClone(arg_8_0.hero_list)
end

function var_0_0.GetHeroList(arg_9_0)
	return arg_9_0.hero_list
end

function var_0_0.GetLastHeroList(arg_10_0)
	return arg_10_0.last_hero_list
end

function var_0_0.GetAddedHeroIDList(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = arg_11_0:GetLastHeroList()

	if #var_11_1 == 0 then
		return var_11_0
	end

	local var_11_2 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		var_11_2[iter_11_1:GetHeroID()] = true
	end

	for iter_11_2, iter_11_3 in ipairs(arg_11_0:GetHeroList()) do
		if not var_11_2[iter_11_3:GetHeroID()] then
			var_11_0[#var_11_0 + 1] = iter_11_3:GetHeroID()
		end
	end

	return var_11_0
end

function var_0_0.GetHeroPosData(arg_12_0, arg_12_1)
	if not arg_12_0.hero_list[arg_12_1] then
		arg_12_0.hero_list[arg_12_1] = arg_12_0:GetHeroPosClass().New(arg_12_1)
	end

	return arg_12_0.hero_list[arg_12_1]
end

function var_0_0.SetHeroPosData(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0:GetHeroPosData(arg_13_1)

	var_13_0:SetHeroID(arg_13_2)
	var_13_0:SetTrialID(arg_13_3)
end

function var_0_0.TryUpdateComboSkillID(arg_14_0)
	local var_14_0 = arg_14_0:GetHeroList()
	local var_14_1 = arg_14_0:GetLastHeroList()
	local var_14_2 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		var_14_2[iter_14_1:GetHeroID()] = true
	end

	local var_14_3 = true

	for iter_14_2, iter_14_3 in ipairs(var_14_0) do
		if not var_14_2[iter_14_3:GetHeroID()] then
			var_14_3 = false
		end
	end

	if not var_14_3 then
		arg_14_0:UpdateComboSkillID()
	end
end

function var_0_0.GetComboSkillID(arg_15_0)
	return arg_15_0.cooperate_unique_skill_id
end

function var_0_0.SetComboSkillID(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 or ReserveConst.DEFAULT_COMBO_SKILL_ID
	arg_16_0.cooperate_unique_skill_id = arg_16_1
end

function var_0_0.UpdateComboSkillID(arg_17_0)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_0:GetHeroList()) do
		var_17_0[iter_17_0] = iter_17_1:GetHeroID()
	end

	arg_17_0:SetComboSkillID(ComboSkillTools.GetRecommendSkillID(var_17_0, true))
end

function var_0_0.GetMimirInfo(arg_18_0)
	return arg_18_0.mimir_info
end

function var_0_0.GetMimirID(arg_19_0)
	return arg_19_0.mimir_info.mimir_id
end

function var_0_0.SetMimirID(arg_20_0, arg_20_1)
	arg_20_1 = arg_20_1 or 0
	arg_20_0.mimir_info.mimir_id = arg_20_1

	if arg_20_1 ~= 0 then
		arg_20_0:SetCharChipBaseID(0)
	end
end

function var_0_0.GetMimirChipList(arg_21_0)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.mimir_info.chip_list) do
		local var_21_1 = ChipCfg[iter_21_1]

		if var_21_1 and (var_21_1.type_id == ChipConst.TYPE_MANAGER or var_21_1.type_id == ChipConst.TYPE_CHIP) then
			table.insert(var_21_0, iter_21_1)
		end
	end

	return var_21_0
end

function var_0_0.SetMimirChipList(arg_22_0, arg_22_1)
	if not arg_22_1 then
		arg_22_1 = {}
	else
		arg_22_1 = clone(arg_22_1)
	end

	arg_22_0.mimir_info.chip_list = arg_22_1
end

function var_0_0.ResetMimirChipList(arg_23_0)
	arg_23_0.mimir_info.chip_list = {}
end

function var_0_0.GetHeroPosClass(arg_24_0)
	return ReserveTools.GetHeroPosDataClass(arg_24_0:GetTeamType())
end

function var_0_0.GetMimirDataClass(arg_25_0)
	return ReserveTools.GetMimirDataClass(arg_25_0:GetTeamType())
end

function var_0_0.GetCharChipBaseID(arg_26_0)
	return arg_26_0.char_chip_id or 0
end

function var_0_0.SetCharChipBaseID(arg_27_0, arg_27_1)
	arg_27_0.char_chip_id = arg_27_1 or 0

	if arg_27_1 ~= 0 then
		arg_27_0:SetMimirID(0)
	end
end

function var_0_0.Clone(arg_28_0)
	return deepClone(arg_28_0)
end

function var_0_0.ConvertToSendData(arg_29_0)
	local var_29_0 = {
		team_index = arg_29_0:GetTeamIndex(),
		hero_list = {}
	}

	for iter_29_0, iter_29_1 in ipairs(arg_29_0:GetHeroList()) do
		var_29_0.hero_list[iter_29_0] = iter_29_1:ConvertToSendData()
	end

	var_29_0.cooperate_unique_skill_id = arg_29_0:GetComboSkillID()
	var_29_0.mimir_info = arg_29_0:GetMimirInfo():ConvertToSendData()
	var_29_0.mimir_info.hero_id = arg_29_0:GetCharChipBaseID()
	var_29_0.mimir_info.hero_chip_list = ChipTools.GetCharChipExtraIDListUnlock(arg_29_0:GetCharChipBaseID())

	return var_29_0
end

function var_0_0.Reset(arg_30_0)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0.hero_list) do
		iter_30_1:Reset()
	end

	arg_30_0.cooperate_unique_skill_id = ReserveConst.DEFAULT_COMBO_SKILL_ID

	arg_30_0.mimir_info:Reset()
end

return var_0_0
