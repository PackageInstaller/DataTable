local var_0_0 = class("BattleBaseStageTemplate")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.roleDataInLua = {}
	arg_1_0.multiple_ = 1
	arg_1_0.comboSkillID_ = 0
	arg_1_0.maxRaceID_ = 0
	arg_1_0.maxRacePlayerCount_ = 1
	arg_1_0.serverTeamPlayer = nil
end

function var_0_0.Init(arg_2_0)
	return
end

function var_0_0.InitHeroList(arg_3_0)
	arg_3_0.heroList_, _, _, arg_3_0.heroTrialList_ = ReserveTools.GetHeroList(arg_3_0:GetReserveParams())
end

function var_0_0.GetDest(arg_4_0)
	return 0
end

function var_0_0.GetStageId(arg_5_0)
	return 0
end

function var_0_0.GetType(arg_6_0)
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
end

function var_0_0.GetMap(arg_7_0)
	return 0, false
end

function var_0_0.GetAILevel(arg_8_0)
	return 0
end

function var_0_0.GetEnemyLevel(arg_9_0)
	return 0
end

function var_0_0.GetStageAffix(arg_10_0)
	return {}, {}, {}
end

function var_0_0.GetBattleStageAffix(arg_11_0)
	if arg_11_0.affixIDList == nil or arg_11_0.levelIDList == nil or arg_11_0.targetTypeList == nil then
		arg_11_0.affixIDList, arg_11_0.levelIDList, arg_11_0.targetTypeList = arg_11_0:GetStageAffix()
	end

	return arg_11_0.affixIDList, arg_11_0.levelIDList, arg_11_0.targetTypeList
end

function var_0_0.GetSettingShowAffix(arg_12_0)
	local var_12_0 = {}
	local var_12_1, var_12_2, var_12_3 = arg_12_0:GetBattleStageAffix()
	local var_12_4 = #var_12_1

	for iter_12_0 = 1, var_12_4 do
		table.insert(var_12_0, {
			var_12_1[iter_12_0],
			var_12_2[iter_12_0],
			var_12_3[iter_12_0]
		})
	end

	return var_12_0
end

function var_0_0.GetRevive(arg_13_0)
	return false, 0, 0, 0
end

function var_0_0.GetMultiple(arg_14_0)
	return arg_14_0.multiple_ or 1
end

function var_0_0.SetMultiple(arg_15_0, arg_15_1)
	arg_15_0.multiple_ = arg_15_1
end

function var_0_0.GetClearTime(arg_16_0)
	return 0
end

function var_0_0.GetHeroTeam(arg_17_0)
	return {}, {}
end

function var_0_0.GetAssistHeroOwnerList(arg_18_0)
	return {}
end

function var_0_0.GetSystemHeroTeam(arg_19_0)
	return {}
end

function var_0_0.GetRoleDatas(arg_20_0)
	return arg_20_0.roleDataInLua
end

function var_0_0.GetThreeStar(arg_21_0)
	return {}
end

function var_0_0.GetAddUserExp(arg_22_0)
	return 0
end

function var_0_0.GetAddHeroExp(arg_23_0)
	return 0
end

function var_0_0.GetCost(arg_24_0)
	return 0
end

function var_0_0.GetAttributeFactor(arg_25_0)
	local var_25_0 = BattleStageTools.GetStageCfg(arg_25_0:GetType(), arg_25_0:GetStageId())

	if var_25_0.attribute_factor and var_25_0.attribute_factor[3] then
		local var_25_1 = var_25_0.attribute_factor[1] / 1000
		local var_25_2 = var_25_0.attribute_factor[2] / 1000
		local var_25_3 = var_25_0.attribute_factor[3] / 1000

		return Vector3.New(var_25_1, var_25_2, var_25_3)
	end

	return Vector3.New(1, 1, 1)
end

function var_0_0.UpdateRoleDatas(arg_26_0, arg_26_1)
	arg_26_0.serverTeamPlayer = arg_26_1
	arg_26_0.roleDataInLua = {}

	local var_26_0 = arg_26_0:GetSystemHeroTeam()

	for iter_26_0, iter_26_1 in ipairs(arg_26_1.heroList) do
		local var_26_1 = iter_26_1.trialID ~= 0 and iter_26_1.trialID or var_26_0[iter_26_0] or 0
		local var_26_2 = BattleController.GetInstance():SetHeroData(iter_26_1, var_26_1, arg_26_1.playerID, arg_26_1.level)

		table.insert(arg_26_0.roleDataInLua, var_26_2)
	end

	arg_26_0:SetMaxRaceData()
end

function var_0_0.GetHeroDataByPos(arg_27_0, arg_27_1)
	local var_27_0, var_27_1 = arg_27_0:GetHeroTeam()
	local var_27_2 = arg_27_0:GetSystemHeroTeam()

	if var_27_0[arg_27_1] and var_27_0[arg_27_1] ~= 0 then
		if var_27_2[arg_27_1] or var_27_1[arg_27_1] and var_27_1[arg_27_1] ~= 0 then
			local var_27_3 = var_27_2[arg_27_1] or var_27_1[arg_27_1]

			return GetVirtualData(var_27_3)
		else
			local var_27_4 = var_27_0[arg_27_1]
			local var_27_5 = arg_27_0.serverTeamPlayer and arg_27_0.serverTeamPlayer.heroList[arg_27_1]

			if var_27_5 == nil then
				return nil
			end

			return (GetPracticalData(var_27_5))
		end
	end

	return nil
end

function var_0_0.GetIsStoryTag(arg_28_0)
	return arg_28_0.storyTag or false
end

function var_0_0.SetIsStoryTag(arg_29_0, arg_29_1)
	arg_29_0.storyTag = arg_29_1
end

function var_0_0.GetIsCooperation(arg_30_0)
	return false, {}
end

function var_0_0.InitComboSkillID(arg_31_0)
	arg_31_0.comboSkillID_ = ReserveTools.GetComboSkillID(arg_31_0:GetReserveParams())
end

function var_0_0.GetComboSkillID(arg_32_0)
	return arg_32_0.comboSkillID_
end

function var_0_0.GetComboSkillLevel(arg_33_0)
	local var_33_0 = arg_33_0:GetComboSkillID()

	return ComboSkillData:GetCurComboSkillLevel(var_33_0)
end

function var_0_0.InitChipData(arg_34_0)
	local var_34_0 = BattleStageTools.GetStageCfg(arg_34_0:GetType(), arg_34_0:GetStageId())
	local var_34_1 = {}
	local var_34_2, var_34_3, var_34_4, var_34_5, var_34_6 = BattleStageTools.GetStageFixedChipInfo(arg_34_0:GetType(), arg_34_0:GetStageId())

	if var_34_2 then
		arg_34_0.chipManagerID_ = var_34_3
		var_34_1 = var_34_4
		arg_34_0.charChipBaseID_ = var_34_5
		arg_34_0.charChipExtraIDList_ = var_34_6
	else
		var_34_1 = arg_34_0:GetBaseChipData()
		arg_34_0.charChipBaseID_ = nil
		arg_34_0.charChipExtraIDList_ = nil
	end

	arg_34_0.chipList_ = arg_34_0:GetHeroChipData(var_34_1)
end

function var_0_0.GetBaseChipData(arg_35_0)
	local var_35_0 = {}
	local var_35_1

	arg_35_0.chipManagerID_, var_35_1 = ReserveTools.GetMimirData(arg_35_0:GetReserveParams())

	if not arg_35_0.chipManagerID_ or arg_35_0.chipManagerID_ == 0 then
		var_35_1 = {}
	end

	return var_35_1
end

function var_0_0.GetHeroChipData(arg_36_0, arg_36_1)
	local var_36_0, var_36_1 = arg_36_0:GetHeroTeam()

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		if iter_36_1 ~= 0 then
			local var_36_2 = var_36_1[iter_36_0]

			if var_36_2 and var_36_2 ~= 0 then
				local var_36_3 = HeroStandardSystemCfg[var_36_2]

				table.insertto(arg_36_1, var_36_3.using_hero_chip)
			else
				for iter_36_2, iter_36_3 in pairs(ChipData:GetEnableHeroChipIdByHeroId(iter_36_1) or {}) do
					if iter_36_3 > 0 then
						table.insert(arg_36_1, iter_36_3)
					end
				end
			end
		end
	end

	return arg_36_1
end

function var_0_0.GetChipManagerID(arg_37_0)
	return arg_37_0.chipManagerID_ or 0
end

function var_0_0.GetChipList(arg_38_0)
	return arg_38_0.chipList_ or {}
end

function var_0_0.GetChipOfHeroDic(arg_39_0)
	return {}
end

function var_0_0.SetMaxRaceData(arg_40_0)
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in pairs(arg_40_0.roleDataInLua) do
		var_40_0[#var_40_0 + 1] = SkinCfg[iter_40_1.ID].hero
	end

	arg_40_0.maxRaceID_, arg_40_0.maxRacePlayerCount_ = BattleTools.GetMaxRaceData(var_40_0)
end

function var_0_0.GetMaxRaceData(arg_41_0)
	return arg_41_0.maxRaceID_, arg_41_0.maxRacePlayerCount_
end

function var_0_0.GetPathList(arg_42_0)
	return {}
end

function var_0_0.GetActivityID(arg_43_0)
	return arg_43_0.activityID_ or 0
end

function var_0_0.GetServerExtant(arg_44_0)
	return 0
end

function var_0_0.GetBattleTime(arg_45_0)
	return 0
end

function var_0_0.GetResurrectHP(arg_46_0)
	return 0
end

function var_0_0.GetResurrectImmediately(arg_47_0)
	return false
end

function var_0_0.GetTargetEnemyID(arg_48_0)
	return 0
end

function var_0_0.SetReserveParams(arg_49_0, arg_49_1)
	arg_49_0.reserveParams_ = arg_49_1 or ReserveTools.GetReserveParams(arg_49_0:GetType(), arg_49_0:GetStageId(), arg_49_0:GetActivityID())
	arg_49_0.contID_ = arg_49_0.reserveParams_.contID
	arg_49_0.teamIndex_ = arg_49_0.reserveParams_.teamIndex
	arg_49_0.customReserveParams_ = arg_49_0.reserveParams_.customData
end

function var_0_0.GetReserveParams(arg_50_0)
	if not arg_50_0.reserveParams_ then
		arg_50_0.reserveParams_ = ReserveTools.GetReserveParams(arg_50_0:GetType(), arg_50_0:GetStageId(), arg_50_0:GetActivityID())
	end

	return arg_50_0.reserveParams_
end

function var_0_0.GetContID(arg_51_0)
	return arg_51_0.contID_ or ReserveTools.GetContID(arg_51_0:GetType(), arg_51_0:GetStageId())
end

function var_0_0.GetTeamIndex(arg_52_0)
	return arg_52_0.teamIndex_ or ReserveConst.DEFAULT_TEAM_INDEX
end

function var_0_0.GetCustomReserveParams(arg_53_0)
	return arg_53_0.customReserveParams_ or {}
end

function var_0_0.GetActivityReforgeSkillList(arg_54_0)
	return {}
end

function var_0_0.GetBattleParams(arg_55_0)
	return 0
end

function var_0_0.GetCharChipBaseID(arg_56_0)
	return arg_56_0.charChipBaseID_ or ReserveTools.GetCharChipBaseID(arg_56_0:GetReserveParams())
end

function var_0_0.GetCharChipIDList(arg_57_0)
	if arg_57_0.charChipBaseID_ then
		if arg_57_0.charChipBaseID_ == 0 then
			return {}
		end

		local var_57_0 = {
			arg_57_0.charChipBaseID_
		}

		table.insertto(var_57_0, arg_57_0.charChipExtraIDList_)

		return var_57_0
	end

	return ReserveTools.GetCharChipIDList(arg_57_0:GetReserveParams())
end

function var_0_0.GetCharChipExtraIDList(arg_58_0)
	return arg_58_0.charChipExtraIDList_ or ReserveTools.GetCharChipExtraIDList(arg_58_0:GetReserveParams())
end

function var_0_0.GetOpts(arg_59_0)
	return {}
end

return var_0_0
