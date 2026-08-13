class = var_0_10000

local var_0_0 = "IslandTechnologyAgency"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseAgency"))

var_0_1.PLACE_ID = 702

function var_0_1.OnInit(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.tech.finish_list
	local var_1_1 = {}

	ipairs = var_1_10004

	for iter_1_0, iter_1_1 in var_1_10004(arg_1_1.tech.repeat_finish_list) do
		var_1_1[iter_1_1.id] = iter_1_1.num
	end

	arg_1_0.techData = {}
	arg_1_0.formula2Id = {}
	ipairs = var_4
	pg = var_5

	for iter_1_2, iter_1_3 in var_4(var_5.island_technology_template.all) do
		IslandTechnology = var_1_10009

		local var_1_2 = var_1_10009.New(iter_1_3)

		if var_1_10009.IsOnceType(var_1_2) then
			local var_1_3 = var_1_10009
			local var_1_4 = var_1_10009.SetFinishedCnt

			table = var_1_10012
			var_1_10012 = var_1_10012.contains(var_1_0, iter_1_3) and 1 or 0

			var_1_4(var_1_3, var_1_10012)
		else
			local var_1_5 = var_1_10009
			local var_1_6 = var_1_10009.SetFinishedCnt

			if not var_1_1[iter_1_3] then
				var_1_10012 = 0
			end

			var_1_6(var_1_5, var_1_10012)
		end

		arg_1_0.techData[var_1_10009.id] = var_1_10009

		local var_1_7 = arg_1_0.formula2Id

		var_1_10012 = var_1_10009
		var_1_7[var_1_10009.GetFormulaId(var_1_10012)] = var_1_10009.id
	end

	return
end

function var_0_1.InitLockData(arg_2_0)
	arg_2_0.lockIds = {}
	pairs = var_1

	for iter_2_0, iter_2_1 in var_1(arg_2_0.techData) do
		if not iter_2_1:IsUnlock() then
			table = var_6

			var_6.insert(arg_2_0.lockIds, iter_2_1.id)
		end
	end

	return
end

function var_0_1.GetTechnology(arg_3_0, arg_3_1)
	return arg_3_0.techData[arg_3_1]
end

function var_0_1.GetTechnologys(arg_4_0)
	return arg_4_0.techData
end

function var_0_1.GetTechnologyByFormulaId(arg_5_0, arg_5_1)
	return arg_5_0.techData[arg_5_0.formula2Id[arg_5_1]]
end

function var_0_1.AddFinishCntByFormulatId(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:GetTechnologyByFormulaId(arg_6_1)

	var_2.AddFinishedCnt(var_6_0)

	return
end

function var_0_1.GetAutoFinishList(arg_7_0)
	local var_7_0 = {}

	pairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_0.techData) do
		if iter_7_1:CheckFinishImmd() then
			table = var_7

			var_7.insert(var_7_0, iter_7_1.id)
		end
	end

	return var_7_0
end

function var_0_1.IsUnlockTech(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.techData[arg_8_1]

	return var_2.IsUnlock(var_8_0)
end

function var_0_1.IsFinishedTech(arg_9_0, arg_9_1)
	if not arg_9_0.techData[arg_9_1] then
		return false
	end

	local var_9_0 = arg_9_0.techData[arg_9_1]

	return var_2.GetFinishedCnt(var_9_0) > 0
end

function var_0_1.GetPctByType(arg_10_0, arg_10_1)
	pg = var_1_10002

	local var_10_0 = var_1_10002.island_technology_template.get_id_list_by_tech_belong[arg_10_1]

	math = var_1_10003

	return var_1_10003.floor(arg_10_0:GetFinishCntByType(arg_10_1) / #var_10_0 * 100)
end

function var_0_1.GetFinishCntByType(arg_11_0, arg_11_1)
	pg = var_1_10002

	local var_11_0 = var_1_10002.island_technology_template.get_id_list_by_tech_belong[arg_11_1]

	underscore = var_1_10003

	return var_1_10003.reduce(var_11_0, 0, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_11_0

		return arg_12_0 + (var_2.IsFinishedTech(var_12_0, arg_12_1) and 1 or 0)
	end)
end

function var_0_1.GetAllTypeFinishCnt(arg_13_0)
	underscore = var_1_10001

	local var_13_0 = var_1_10001.reduce

	pg = var_1_10002

	return var_13_0(var_1_10002.island_technology_template.all, 0, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_13_0

		return arg_14_0 + (var_2.IsFinishedTech(var_14_0, arg_14_1) and 1 or 0)
	end)
end

function var_0_1.GetEmptySlotId(arg_15_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_15_0 = var_1_10001(var_1_10002)
	local var_15_1 = var_1.GetIsland(var_15_0)
	local var_15_2 = var_1.GetBuildingAgency(var_15_1)
	local var_15_3 = var_1.GetBuilding(var_15_2, var_0_1.PLACE_ID)

	ipairs = var_15_2

	for iter_15_0, iter_15_1 in var_15_2(var_0_1.GetSlotIds()) do
		if var_15_3:GetDelegationSlotData(iter_15_1) and var_7:CanStartDelegation() then
			return iter_15_1
		end
	end

	return nil
end

function var_0_1.RemoveLockId(arg_16_0, arg_16_1)
	table = var_1_10002

	var_1_10002.removebyvalue(arg_16_0.lockIds, arg_16_1)

	return
end

function var_0_1.TryAutoUnlock(arg_17_0, arg_17_1)
	if arg_17_0.isInPlan then
		return
	end

	local var_17_0 = {}

	ipairs = var_1_10003

	for iter_17_0, iter_17_1 in var_1_10003(arg_17_0.lockIds) do
		table = var_1_10008

		var_1_10008.insert(var_17_0, function(arg_18_0)
			local var_18_0 = arg_17_0.techData[iter_17_1]

			if not var_1.IsUnlock(var_18_0) then
				local var_18_1 = arg_17_0.techData[iter_17_1]

				if var_1.CanUnlock(var_18_1) then
					pg = var_1

					local var_18_2 = var_1.m02
					local var_18_3 = var_1.sendNotification

					GAME = var_2_10003

					var_18_3(var_18_2, var_2_10003.ISLAND_UNLOCK_TECH, {
						techId = iter_17_1,
						callback = arg_18_0
					})

					goto label_18_0
				end
			end

			arg_18_0()

			::label_18_0::

			return
		end)
	end

	arg_17_0.isInPlan = true
	seriesAsync = var_3

	var_3(var_17_0, function()
		existCall = var_2_10000

		var_2_10000(arg_17_1)

		arg_17_0.isInPlan = false

		return
	end)

	return
end

function var_0_1.IsTip(arg_20_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_20_0 = var_1_10001(var_1_10002)
	local var_20_1 = var_1.GetIsland(var_20_0)
	local var_20_2 = var_1.GetBuildingAgency(var_20_1)
	local var_20_3 = var_1.GetBuilding(var_20_2, var_0_1.PLACE_ID)
	local var_20_4 = var_0_1.GetSlotIds()

	ipairs = var_3

	for iter_20_0, iter_20_1 in var_3(var_20_4) do
		if var_20_3:GetDelegationSlotData(iter_20_1) and var_8:GetSlotRewardData() then
			return true
		end
	end

	return false
end

function var_0_1.GetSlotIds()
	pg = var_1_10000

	return var_1_10000.island_production_slot.get_id_list_by_place[var_0_1.PLACE_ID]
end

return var_0_1
