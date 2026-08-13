class = var_0_10000

local var_0_0 = "IslandTechnology"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.STATUS = {
	STUDYING = "studying",
	NORMAL = "normal",
	RECEIVE = "receive",
	FINISHED = "finished",
	LOCK = "lock",
	UNLOCK = "unlock"
}
var_0_1.UNLOCK_TYPE = {
	FINISH_TASK = 1,
	LEVEL = 0,
	EXIST_ABILITY = 2,
	FINISH_TECHNOLOGY = 3
}

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_1
	arg_1_0.finishedCnt = arg_1_2 or 0

	return
end

function var_0_1.SetFinishedCnt(arg_2_0, arg_2_1)
	arg_2_0.finishedCnt = arg_2_1

	return
end

function var_0_1.AddFinishedCnt(arg_3_0)
	arg_3_0.finishedCnt = arg_3_0.finishedCnt + 1

	if arg_3_0.finishedCnt == 1 then
		IslandAchievementHelper = var_1

		var_1.OnFinishTechnolog(arg_3_0.id)

		IslandTaskHelper = var_1

		local var_3_0 = var_1.UpdateRuntimeTaskByTargetType

		IslandTaskTargetType = var_3

		var_3_0(var_3.TECHNOLOGY)
	end

	return
end

function var_0_1.GetFinishedCnt(arg_4_0)
	return arg_4_0.finishedCnt
end

function var_0_1.bindConfigTable(arg_5_0)
	pg = var_1_10001

	return var_1_10001.island_technology_template
end

function var_0_1.IsAutoType(arg_6_0)
	return arg_6_0:getConfig("auto_finish") == 0
end

function var_0_1.CheckFinishImmd(arg_7_0)
	local var_7_0

	if arg_7_0:IsUnlock() and arg_7_0:IsAutoType() then
		var_7_0 = arg_7_0.finishedCnt == 0
	end

	return var_7_0
end

function var_0_1.GetFormulaId(arg_8_0)
	return arg_8_0:getConfig("formula_id")
end

function var_0_1.IsOnceType(arg_9_0)
	return arg_9_0:getConfig("tech_repeat")[1] == 0
end

function var_0_1.IsNoLimitType(arg_10_0)
	return not arg_10_0:IsOnceType() and arg_10_0:getConfig("tech_repeat")[2] == 0
end

function var_0_1.GetMaxFinishedCnt(arg_11_0)
	return arg_11_0:IsOnceType() and 1 or arg_11_0:getConfig("tech_repeat")[2]
end

function var_0_1.CheckRemainCnt(arg_12_0)
	local var_12_0

	if not arg_12_0:IsNoLimitType() then
		var_12_0 = arg_12_0:GetMaxFinishedCnt() - arg_12_0.finishedCnt > 0
	end

	return var_12_0
end

function var_0_1.GetAbilityId(arg_13_0)
	pg = var_1_10001

	return var_1_10001.island_formula[arg_13_0:GetFormulaId()].unlock_type
end

function var_0_1.IsUnlock(arg_14_0)
	local var_14_3

	if arg_14_0:GetAbilityId() ~= 0 then
		getProxy = var_1_10002
		IslandProxy = var_1_10004

		local var_14_0 = var_1_10002(var_1_10004)
		local var_14_1 = var_2.GetIsland(var_14_0)
		local var_14_2 = var_2.GetAblityAgency(var_14_1)

		var_14_3 = var_2.HasAbility(var_14_2, var_1)

		if false then
			var_14_3 = false
		end
	else
		var_14_3 = true
	end

	return var_14_3
end

function var_0_1.GetCostItems(arg_15_0)
	local var_15_0 = {}

	underscore = var_1_10002

	local var_15_1 = var_1_10002.each

	pg = var_1_10004

	var_15_1(var_1_10004.island_formula[arg_15_0:GetFormulaId()].commission_cost, function(arg_16_0)
		table = var_2_10001

		local var_16_0 = var_2_10001.insert
		local var_16_1 = var_15_0

		Drop = var_2_10004

		local var_16_2 = var_2_10004.New
		local var_16_3 = {}

		DROP_TYPE_ISLAND_ITEM = var_2_10007
		var_16_3.type = var_2_10007
		var_16_3.id = arg_16_0[1]
		var_16_3.count = arg_16_0[2]

		var_16_0(var_16_1, var_16_2(var_16_3))

		return
	end)

	return var_15_0
end

function var_0_1.CanUnlock(arg_17_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_17_0 = var_1_10001(var_1_10003)
	local var_17_1 = var_1.GetIsland(var_17_0)

	if var_1.GetLevel(var_17_1) < arg_17_0:getConfig("island_level") then
		return false
	end

	if arg_17_0:getConfig("sys_unlock") == "" or #var_1 == 0 then
		return true
	end

	underscore = var_2

	return var_2.all(var_1, function(arg_18_0)
		local var_18_0 = arg_17_0

		return var_1.MatchCondition(var_18_0, arg_18_0)
	end)
end

function var_0_1.MatchCondition(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1[1]
	local var_19_1 = arg_19_1[2]

	switch = var_1_10004

	return var_1_10004(var_19_0, {
		[var_0_1.UNLOCK_TYPE.LEVEL] = function()
			getProxy = var_2_10000
			IslandProxy = var_2_10002

			local var_20_0 = var_2_10000(var_2_10002)
			local var_20_1 = var_0.GetIsland(var_20_0)
			local var_20_2 = var_0.GetLevel(var_20_1)
			local var_20_3 = arg_19_0

			return var_20_2 >= var_1.getConfig(var_20_3, "island_level")
		end,
		[var_0_1.UNLOCK_TYPE.FINISH_TASK] = function()
			getProxy = var_2_10000
			IslandProxy = var_2_10002

			local var_21_0 = var_2_10000(var_2_10002)
			local var_21_1 = var_0.GetIsland(var_21_0)
			local var_21_2 = var_0.GetTaskAgency(var_21_1)

			return var_0.IsFinishTask(var_21_2, var_19_1)
		end,
		[var_0_1.UNLOCK_TYPE.EXIST_ABILITY] = function()
			getProxy = var_2_10000
			IslandProxy = var_2_10002

			local var_22_0 = var_2_10000(var_2_10002)
			local var_22_1 = var_0.GetIsland(var_22_0)
			local var_22_2 = var_0.GetAblityAgency(var_22_1)

			return var_0.HasAbility(var_22_2, var_19_1)
		end,
		[var_0_1.UNLOCK_TYPE.FINISH_TECHNOLOGY] = function()
			getProxy = var_2_10000
			IslandProxy = var_2_10002

			local var_23_0 = var_2_10000(var_2_10002)
			local var_23_1 = var_0.GetIsland(var_23_0)
			local var_23_2 = var_0.GetTechnologyAgency(var_23_1)

			return var_0.IsFinishedTech(var_23_2, var_19_1)
		end
	}, function()
		return false
	end)
end

function var_0_1.GetStatus(arg_25_0)
	local var_25_0 = arg_25_0
	local var_25_1

	if not arg_25_0.IsUnlock(var_25_0) then
		var_25_0 = arg_25_0

		if not arg_25_0.CanUnlock(var_25_0) or not var_0_1.STATUS.UNLOCK then
			var_25_1 = var_0_1.STATUS.LOCK
		end

		return var_25_1
	end

	getProxy = var_25_1
	IslandProxy = var_25_0

	local var_25_2 = var_25_1(var_25_0)
	local var_25_3 = var_1.GetIsland(var_25_2)
	local var_25_4 = var_1.GetBuildingAgency(var_25_3)

	if var_1.GetDelegationSlotDataByTechId(var_25_4, arg_25_0.id) then
		local var_25_5

		if not var_1:GetSlotRewardData() or not var_0_1.STATUS.RECEIVE then
			var_25_5 = var_0_1.STATUS.STUDYING
		end

		return var_25_5
	else
		local var_25_6

		if not arg_25_0:CheckRemainCnt() or not var_0_1.STATUS.NORMAL then
			var_25_6 = var_0_1.STATUS.FINISHED
		end

		return var_25_6
	end

	return
end

function var_0_1.GetSlotId(arg_26_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_26_0 = var_1_10001(var_1_10003)
	local var_26_1 = var_1.GetIsland(var_26_0)
	local var_26_2 = var_1.GetBuildingAgency(var_26_1)

	return var_1.GetDelegationSlotDataByTechId(var_26_2, arg_26_0.id) and var_1.id
end

function var_0_1.GetUnlockText(arg_27_0)
	local var_27_0 = arg_27_0[1]
	local var_27_1 = arg_27_0[2]

	switch = var_1_10003

	return var_1_10003(var_27_0, {
		[var_0_1.UNLOCK_TYPE.LEVEL] = function()
			i18n = var_2_10000

			return var_2_10000("island_tech_unlock_tip0", var_27_1)
		end,
		[var_0_1.UNLOCK_TYPE.FINISH_TASK] = function()
			i18n = var_2_10000

			local var_29_0 = "island_tech_unlock_tip1"

			pg = var_2_10003

			return var_2_10000(var_29_0, var_2_10003.island_task[var_27_1].name)
		end,
		[var_0_1.UNLOCK_TYPE.EXIST_ABILITY] = function()
			i18n = var_2_10000

			local var_30_0 = "island_tech_unlock_tip2"

			pg = var_2_10003

			return var_2_10000(var_30_0, var_2_10003.island_ability_template[var_27_1].unlock_text)
		end,
		[var_0_1.UNLOCK_TYPE.FINISH_TECHNOLOGY] = function()
			i18n = var_2_10000

			local var_31_0 = "island_tech_unlock_tip3"

			pg = var_2_10003

			return var_2_10000(var_31_0, var_2_10003.island_technology_template[var_27_1].tech_name)
		end
	})
end

return var_0_1
