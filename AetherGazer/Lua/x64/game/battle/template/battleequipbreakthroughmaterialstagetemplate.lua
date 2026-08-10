local var_0_0 = class("BattleEquipBreakThroughMaterialStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.cfg = BattleEquipBreakThroughMaterialStageCfg[arg_1_1]
	arg_1_0.mapStageID_ = EquipBreakThroughMaterialData:GetChooseMapStageID()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.id
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_7_0)
	return arg_7_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_8_0)
	return arg_8_0.cfg.monster_level
end

function var_0_0.InitChipData(arg_9_0)
	arg_9_0.chipManagerID_ = EquipBreakThroughMaterialData:GetChipManagerID()
	arg_9_0.chipList_ = arg_9_0:GetHeroChipData(clone(EquipBreakThroughMaterialData:GetChipList()))
end

function var_0_0.GetChipAndAIList(arg_10_0, arg_10_1)
	local var_10_0 = {}
	local var_10_1 = arg_10_0.chipManagerID_

	if var_10_1 ~= 0 then
		table.insert(var_10_0, var_10_1)
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.chipList_) do
		table.insert(var_10_0, iter_10_1)
	end

	if arg_10_1 ~= 0 then
		arg_10_1 = SkinCfg[arg_10_1].hero
	end

	local var_10_2, var_10_3 = arg_10_0:GetHeroTeam()
	local var_10_4 = table.keyof(var_10_2, arg_10_1)

	if var_10_4 and arg_10_1 ~= 0 and var_10_3[var_10_4] == 0 then
		local var_10_5 = ChipData:GetEnableHeroChipIdByHeroId(arg_10_1) or {}

		for iter_10_2, iter_10_3 in ipairs(var_10_5) do
			table.insert(var_10_0, iter_10_3)
		end
	end

	return var_10_0
end

function var_0_0.GetHeroTeam(arg_11_0)
	return arg_11_0.heroList_, arg_11_0.heroTrialList_
end

function var_0_0.UpdateRoleDatas(arg_12_0, arg_12_1)
	arg_12_0.serverTeamPlayer = arg_12_1
	arg_12_0.roleDataInLua = {}

	local var_12_0 = arg_12_0:GetSystemHeroTeam()

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.heroList) do
		local var_12_1 = iter_12_1.trialID ~= 0 and iter_12_1.trialID or var_12_0[iter_12_0] or 0
		local var_12_2 = BattleController.GetInstance():SetEquipBreakThroughMaterialHeroData(iter_12_0, iter_12_1, var_12_1, arg_12_1.playerID, arg_12_1.level)

		table.insert(arg_12_0.roleDataInLua, var_12_2)
	end

	arg_12_0:SetMaxRaceData()
end

function var_0_0.GetMaxRaceData(arg_13_0)
	return 0, 0
end

function var_0_0.GetStageAffix(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = {}
	local var_14_2 = {}
	local var_14_3 = EquipBreakThroughMaterialData:GetGlobalAffixList()

	for iter_14_0, iter_14_1 in pairs(var_14_3 or {}) do
		table.insert(var_14_0, iter_14_1[1])
		table.insert(var_14_1, iter_14_1[2])
		table.insert(var_14_2, iter_14_1[3])
	end

	local var_14_4 = EquipBreakThroughMaterialData:GetBuffList()

	for iter_14_2, iter_14_3 in pairs(var_14_4 or {}) do
		local var_14_5 = EquipBreakThroughMaterialItemCfg[iter_14_3].params

		table.insert(var_14_0, var_14_5[1])
		table.insert(var_14_1, var_14_5[2])
		table.insert(var_14_2, var_14_5[3])
	end

	local var_14_6 = EquipBreakThroughMaterialData:GetAttributeList()

	for iter_14_4, iter_14_5 in pairs(var_14_6 or {}) do
		local var_14_7 = getAttributeAffix(iter_14_4, iter_14_5)

		table.insert(var_14_0, var_14_7[1])
		table.insert(var_14_1, var_14_7[2])
		table.insert(var_14_2, var_14_7[3])
	end

	return var_14_0, var_14_1, var_14_2
end

function var_0_0.GetAttributeFactor(arg_15_0)
	local var_15_0 = EquipBreakThroughMaterialData:GetSelectModeID()
	local var_15_1 = EquipBreakThroughMaterialDifficultyCfg[var_15_0]
	local var_15_2 = var_15_1.difficult_multipliter[1] / 1000
	local var_15_3 = var_15_1.difficult_multipliter[2] / 1000
	local var_15_4 = var_15_1.difficult_multipliter[3] / 1000

	return Vector3.New(var_15_2, var_15_3, var_15_4)
end

function var_0_0.GetServerExtant(arg_16_0)
	return arg_16_0.mapStageID_
end

return var_0_0
