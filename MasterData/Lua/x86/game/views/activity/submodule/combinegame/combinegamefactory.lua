local var_0_0 = {}
local var_0_1 = CombineGameConst.TypeConst
local var_0_2 = CombineGameConst.FactorType
local var_0_3 = CombineGameConst.RefreshType
local var_0_4 = {}
local var_0_5 = {}

function var_0_0.ResetGameData(arg_1_0)
	var_0_5 = {}
	var_0_4.skillCost = 0
	var_0_4.initResource = clone(GameSetting.activity_combine_game_init.value)
	var_0_4.resourceChange = {
		0,
		0,
		0,
		0,
		0,
		0
	}
	var_0_4.effectCD = 0
	var_0_4.combineEffect = 0
	var_0_4.nextTurnCost = {
		0,
		0,
		0,
		0,
		0
	}
	var_0_4.maxLevel = 2
	var_0_4.minLevel = 1
	var_0_4.speed = 1
	var_0_4.roleLv = 1
	var_0_4.pool = clone(GameSetting.activity_combine_game_init_cells_list.value)
	var_0_4.techRate = 1
	var_0_4.turnRate = 1
	var_0_4.nowTurn = 1
	var_0_4.food = 0
	var_0_4.tech = 0
	var_0_4.rock = 0
	var_0_4.nextTechNeed = 0
	var_0_4.nextStageTurn = 0
	var_0_4.age = 0
	var_0_4.totalRock = 0
	var_0_4.totalFood = 0
	var_0_4.totalTech = 0
	var_0_4.skillIndex = 0
	var_0_4.skillList = {}
	var_0_4.stageFoodChange = {}
	var_0_4.buildResource = 0
	var_0_4.needRefreshSkill = false
	var_0_4.needRefreshBlock = false
end

function var_0_0.GetGameData(arg_2_0)
	var_0_4.food = var_0_4.initResource[1]
	var_0_4.rock = var_0_4.initResource[2]
	var_0_4.tech = var_0_4.initResource[3]

	return var_0_4
end

function var_0_0.NewFactor(arg_3_0, arg_3_1, arg_3_2)
	if ActivityCombineFactorCfg[arg_3_1] == nil then
		return
	end

	var_0_5[arg_3_1] = ActivityCombineFactorCfg[arg_3_1].effect

	if var_0_3[ActivityCombineFactorCfg[arg_3_1].effect_type] and arg_3_2 then
		if var_0_3[ActivityCombineFactorCfg[arg_3_1].effect_type] == 1 then
			var_0_4.needRefreshSkill = true
		elseif var_0_3[ActivityCombineFactorCfg[arg_3_1].effect_type] == 2 then
			var_0_4.needRefreshBlock = true
		end
	end

	if ActivityCombineFactorCfg[arg_3_1].effect_type == var_0_2.UNLOCK_SKILL then
		table.insert(var_0_4.skillList, ActivityCombineFactorCfg[arg_3_1].effect[1])
	elseif ActivityCombineFactorCfg[arg_3_1].effect_type == var_0_2.COST_CHANGE then
		var_0_4.skillCost = var_0_4.skillCost + ActivityCombineFactorCfg[arg_3_1].effect[1]
	elseif ActivityCombineFactorCfg[arg_3_1].effect_type == var_0_2.RESOURCE_GET_CHANGE then
		var_0_4.resourceChange[ActivityCombineFactorCfg[arg_3_1].effect[1]] = var_0_4.resourceChange[ActivityCombineFactorCfg[arg_3_1].effect[1]] + ActivityCombineFactorCfg[arg_3_1].effect[2]
	elseif ActivityCombineFactorCfg[arg_3_1].effect_type == var_0_2.SKILL_CD_CHANGE then
		var_0_4.effectCD = var_0_4.effectCD + ActivityCombineFactorCfg[arg_3_1].effect[1]
	elseif ActivityCombineFactorCfg[arg_3_1].effect_type == var_0_2.COMBINE_EFFECT_CHANGE then
		var_0_4.combineEffect = var_0_4.combineEffect + ActivityCombineFactorCfg[arg_3_1].effect[1]
	elseif ActivityCombineFactorCfg[arg_3_1].effect_type == var_0_2.NEXT_TURN_EFFECT_CHANGE then
		var_0_4.nextTurnCost[ActivityCombineFactorCfg[arg_3_1].effect[1]] = var_0_4.nextTurnCost[ActivityCombineFactorCfg[arg_3_1].effect[1]] - ActivityCombineFactorCfg[arg_3_1].effect[2]
	elseif ActivityCombineFactorCfg[arg_3_1].effect_type == var_0_2.MAX_LEVEL_EXCHANGE then
		var_0_4.maxLevel = ActivityCombineFactorCfg[arg_3_1].effect[1]
	elseif ActivityCombineFactorCfg[arg_3_1].effect_type == var_0_2.MIN_LEVEL_EXCHANGE then
		var_0_4.minLevel = ActivityCombineFactorCfg[arg_3_1].effect[1]
	elseif ActivityCombineFactorCfg[arg_3_1].effect_type == var_0_2.SPEED_CHANGE then
		var_0_4.speed = var_0_4.speed + ActivityCombineFactorCfg[arg_3_1].effect[1]
	elseif ActivityCombineFactorCfg[arg_3_1].effect_type == var_0_2.EXP_CHANGE then
		var_0_4.techRate = var_0_4.techRate + ActivityCombineFactorCfg[arg_3_1].effect[1] / 100
	elseif ActivityCombineFactorCfg[arg_3_1].effect_type == var_0_2.POOL_CHANGE then
		var_0_4.pool[ActivityCombineFactorCfg[arg_3_1].effect[1]] = var_0_4.pool[ActivityCombineFactorCfg[arg_3_1].effect[1]] + ActivityCombineFactorCfg[arg_3_1].effect[2]
	elseif ActivityCombineFactorCfg[arg_3_1].effect_type == var_0_2.ROLE_LEVEL_CHANGE then
		var_0_4.roleLv = ActivityCombineFactorCfg[arg_3_1].effect[1]
	elseif ActivityCombineFactorCfg[arg_3_1].effect_type == var_0_2.NEXT_TECH_CHANGE then
		var_0_4.turnRate = var_0_4.turnRate + ActivityCombineFactorCfg[arg_3_1].effect[1] / 100
	elseif ActivityCombineFactorCfg[arg_3_1].effect_type == var_0_2.INIT_RESOURCE_CHANGE then
		var_0_4.initResource[ActivityCombineFactorCfg[arg_3_1].effect[1]] = var_0_4.initResource[ActivityCombineFactorCfg[arg_3_1].effect[1]] + ActivityCombineFactorCfg[arg_3_1].effect[2]
	elseif ActivityCombineFactorCfg[arg_3_1].effect_type == var_0_2.STAGE_FOOD_CHANGE then
		var_0_4.stageFoodChange[ActivityCombineFactorCfg[arg_3_1].effect[1]] = ActivityCombineFactorCfg[arg_3_1].effect[2]
	elseif ActivityCombineFactorCfg[arg_3_1].effect_type == var_0_2.BUILDING_CHANGE then
		var_0_4.buildResource = ActivityCombineFactorCfg[arg_3_1].effect[1] + var_0_4.buildResource
	end
end

function var_0_0:StartGame(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = ActivityCombineLevelCfg[arg_4_1]

	self:ResetGameData()

	for iter_4_0, iter_4_1 in pairs(arg_4_2 or {}) do
		self:NewFactor(iter_4_0)
	end

	for iter_4_2, iter_4_3 in ipairs(ActivityCombineLevelCfg[arg_4_1].default_entry) do
		self:NewFactor(iter_4_3)
	end

	TimeTools.StartAfterSeconds(0.2, function()
		JumpTools.GoToSystem("/CombineGameView", {
			factorList = arg_4_2,
			heroId = var_4_0.can_use_hero[arg_4_3],
			levelId = arg_4_1
		})
	end, {})
end

function var_0_0.EndGame(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_3 then
		return
	end

	if ActivityCombineLevelCfg[arg_6_1].type == var_0_1.ENDLESS then
		for iter_6_0, iter_6_1 in pairs(arg_6_2 or {}) do
			-- block empty
		end
	end
end

function var_0_0.CheckFactor(arg_7_0)
	return var_0_5[arg_7_0] ~= nil
end

function var_0_0.GetFactorPara(arg_8_0)
	return var_0_5[arg_8_0][1]
end

function var_0_0.PlayEffect(arg_9_0)
	manager.audio:PlayEffect(CombineGameConst.SheeList[arg_9_0], CombineGameConst.NameList[arg_9_0], "")
end

function var_0_0.ChangeResource(arg_10_0, arg_10_1)
	if arg_10_0 == 0 then
		return arg_10_1
	end

	if arg_10_1 > 0 then
		arg_10_1 = arg_10_1 + var_0_4.resourceChange[arg_10_0]
	end

	return arg_10_1
end

local var_0_6 = {}

function var_0_0.PlayAni(arg_11_0, arg_11_1, arg_11_2)
	table.insert(var_0_6, arg_11_2)
	AnimatorTools.PlayAnimationWithCallback(arg_11_0, arg_11_1, function()
		for iter_12_0, iter_12_1 in ipairs(var_0_6) do
			SetActive(iter_12_1, false)
		end

		var_0_6 = {}
	end)
end

function var_0_0:GameBreak()
	self:ResetGameData()
end

return var_0_0
