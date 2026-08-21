local var_0_0 = {}

local function var_0_1(arg_1_0)
	local var_1_0 = {}

	for iter_1_0 = 0, arg_1_0.Count - 1 do
		table.insert(var_1_0, arg_1_0[iter_1_0])
	end

	return var_1_0
end

function var_0_0.GetTechUnlock(arg_2_0)
	return civilization.CivilizationLuaBridge.GetTechUnlock(arg_2_0)
end

function var_0_0.GetTechSelect(arg_3_0)
	return civilization.CivilizationLuaBridge.GetTechSelect(arg_3_0)
end

function var_0_0.EnterGameView(arg_4_0, arg_4_1)
	local var_4_0 = ActivityCivilizationStageCfg[arg_4_1]

	JumpTools.OpenPageByJump("/civilizationGameView", {
		heroID = arg_4_0,
		stageID = arg_4_1,
		activityID = var_4_0.activity_id,
		gameType = var_4_0.type
	})
end

function var_0_0.PreLoadCfg(arg_5_0)
	civilization.CivilizationLuaBridge.PreLoadGame()
	var_0_0.InitTechLevel(arg_5_0)
	var_0_0.InitTech(arg_5_0)
	var_0_0.InitAge(arg_5_0)
	var_0_0.InitHero()
	var_0_0.InitSkill()
	var_0_0.InitStage()
end

function var_0_0.InitTechLevel(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(ActivityCivilizationFactorLevelCfg.get_id_list_by_type[arg_6_0]) do
		local var_6_0 = ActivityCivilizationFactorLevelCfg[iter_6_1]

		civilization.CivilizationLuaBridge.PreLoadFactorLevel(var_6_0.level, var_6_0.cost, var_6_0.factor_pool)
	end
end

function var_0_0.InitTech()
	for iter_7_0, iter_7_1 in ipairs(ActivityCivilizationFactorCfg.all) do
		local var_7_0 = ActivityCivilizationFactorCfg[iter_7_1]
		local var_7_1 = {}

		if type(var_7_0.effect[1]) == "table" then
			for iter_7_2, iter_7_3 in ipairs(var_7_0.effect[1]) do
				table.insert(var_7_1, iter_7_3)
			end

			for iter_7_4 = 2, #var_7_0.effect do
				table.insert(var_7_1, var_7_0.effect[iter_7_4])
			end
		else
			var_7_1 = var_7_0.effect
		end

		civilization.CivilizationLuaBridge.PreLoadFactor(var_7_0.id, var_7_0.effect_type, var_7_0.gain_type, var_7_1)
	end
end

function var_0_0.InitHero()
	for iter_8_0, iter_8_1 in ipairs(ActivityCivilizationHeroCfg.all) do
		local var_8_0 = ActivityCivilizationHeroCfg[iter_8_1]

		civilization.CivilizationLuaBridge.PreLoadHero(var_8_0.id, var_8_0.starting_skill[1], var_8_0.hex_skill_1, var_8_0.hex_skill_2, var_8_0.hex_skill_3)
	end
end

function var_0_0.InitAge(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(ActivityCivilizationSettingCfg.get_id_list_by_type[arg_9_0]) do
		local var_9_0 = ActivityCivilizationSettingCfg[iter_9_1]
		local var_9_1 = var_9_0.map_bigger == 1 and true or false
		local var_9_2 = var_9_0.hex == 1 and true or false

		civilization.CivilizationLuaBridge.PreLoadAge(var_9_0.id, var_9_0.begin_time, var_9_0.each_turn_num, var_9_0.food_cost, var_9_1, var_9_2, var_9_0.cells_list)
	end
end

function var_0_0.InitSkill()
	for iter_10_0, iter_10_1 in ipairs(ActivityCivilizationSkillCfg.all) do
		local var_10_0 = ActivityCivilizationSkillCfg[iter_10_1]
		local var_10_1 = SpritePathCfg.CivilizationGame.path .. var_10_0.icon

		civilization.CivilizationLuaBridge.PreLoadSkill(var_10_0.id, var_10_0.cost, var_10_0.cd, var_10_1)
	end
end

function var_0_0.InitStage()
	for iter_11_0, iter_11_1 in ipairs(ActivityCivilizationStageCfg.all) do
		local var_11_0 = ActivityCivilizationStageCfg[iter_11_1]

		civilization.CivilizationLuaBridge.PreLoadStage(var_11_0.id, var_11_0.activity_id, var_11_0.init_cells_list, var_11_0.init_cells_location, var_11_0.init_resource, var_11_0.init_factor)

		if iter_11_1 == 2 then
			civilization.CivilizationLuaBridge.PreLoadTeachStage(iter_11_1, var_11_0.init_cells_location_list, var_11_0.create_cells_location)
		end
	end
end

function var_0_0.ParseIlluList(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = var_0_1(arg_12_0.gridTypeList)

	for iter_12_0, iter_12_1 in ipairs(var_12_2) do
		table.insert(var_12_1, ActivityCivilizationIlluCfg.get_id_list_by_target_id[iter_12_1][1])
		table.insert(var_12_0, ActivityCivilizationIlluCfg.get_id_list_by_target_id[iter_12_1][1])
	end

	local var_12_3 = {}
	local var_12_4 = var_0_1(arg_12_0.hexList)

	for iter_12_2, iter_12_3 in ipairs(var_12_4) do
		table.insert(var_12_3, ActivityCivilizationIlluCfg.get_id_list_by_target_id[iter_12_3][1])
		table.insert(var_12_0, ActivityCivilizationIlluCfg.get_id_list_by_target_id[iter_12_3][1])
	end

	local var_12_5 = {}
	local var_12_6 = var_0_1(arg_12_0.techList)

	for iter_12_4, iter_12_5 in ipairs(var_12_6) do
		table.insert(var_12_5, ActivityCivilizationIlluCfg.get_id_list_by_target_id[iter_12_5][1])
		table.insert(var_12_0, ActivityCivilizationIlluCfg.get_id_list_by_target_id[iter_12_5][1])
	end

	return var_12_0, var_12_1, var_12_3, var_12_5
end

function var_0_0.GetNewIlluList(arg_13_0)
	local var_13_0 = CivilizationGameData:GetDataByPara("illu_list")
	local var_13_1, var_13_2, var_13_3, var_13_4 = var_0_0.ParseIlluList(arg_13_0)
	local var_13_5 = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		if not table.indexof(var_13_0, iter_13_1) then
			table.insert(var_13_5, iter_13_1)
		end
	end

	return var_13_5
end

function var_0_0.getIsFirst(arg_14_0)
	local var_14_0 = CivilizationGameData:GetDataByPara("finishStage")

	if table.indexof(var_14_0, arg_14_0) then
		return true
	end

	return false
end

return var_0_0
