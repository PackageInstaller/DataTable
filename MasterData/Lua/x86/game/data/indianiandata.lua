local var_0_0 = singletonClass("IndiaNianData")
local var_0_1
local var_0_2
local var_0_3
local var_0_4
local var_0_5
local var_0_6
local var_0_7
local var_0_8
local var_0_9
local var_0_10

function var_0_0.UpdateNianData(arg_1_0, arg_1_1)
	var_0_1 = arg_1_1.activity_id

	if arg_1_1.round then
		var_0_2 = arg_1_1.round
	end

	var_0_5 = 0

	for iter_1_0, iter_1_1 in ipairs(IndiaNianCfg.get_id_list_by_group_id[100]) do
		if IndiaNianCfg[iter_1_1].stage_type ~= 1 then
			var_0_5 = var_0_5 + IndiaNianCfg[iter_1_1].boss_hp
		end
	end

	if arg_1_1.clear_id_list then
		var_0_3 = {}

		for iter_1_2, iter_1_3 in ipairs(arg_1_1.clear_id_list) do
			table.insert(var_0_3, iter_1_3)
		end
	end

	if arg_1_1.boss_list then
		var_0_4 = {}

		for iter_1_4, iter_1_5 in ipairs(cleanProtoTable(arg_1_1.boss_list)) do
			var_0_4[IndiaNianCfg[iter_1_5.id].group_id] = iter_1_5.hp
		end
	end
end

function var_0_0.SetSelectedDestID(arg_2_0, arg_2_1)
	var_0_9 = arg_2_1
end

function var_0_0.GetSelectedDestID(arg_3_0)
	return var_0_9
end

function var_0_0.GetClearedBossIDList(arg_4_0)
	return var_0_3
end

function var_0_0.SetSelectedDescIndex(arg_5_0, arg_5_1)
	var_0_8 = arg_5_1
end

function var_0_0.GetSelectedDescIndex(arg_6_0)
	return var_0_8 or 0
end

function var_0_0.GetTotalHp(arg_7_0)
	return var_0_5
end

function var_0_0.SetSelectedStage(arg_8_0, arg_8_1)
	var_0_6 = arg_8_1
end

function var_0_0.GetSelectedStageID(arg_9_0)
	return var_0_6
end

function var_0_0.SetSelectedStageCost(arg_10_0, arg_10_1)
	arg_10_1 = arg_10_1 or {
		54043,
		1
	}
end

function var_0_0.GetSelectedStageCost(arg_11_0)
	return var_0_7 or {
		54043,
		1
	}
end

function var_0_0.SetMainSelectedIndex(arg_12_0, arg_12_1)
	var_0_10 = arg_12_1
end

function var_0_0.GetMainSelectedIndex(arg_13_0)
	return var_0_10 or 0
end

function var_0_0.GetCurrentHpByID(arg_14_0, arg_14_1)
	local var_14_0 = 0

	if IndiaNianCfg[arg_14_1].group_id == 100 then
		for iter_14_0, iter_14_1 in ipairs(IndiaNianCfg.get_id_list_by_group_id[100]) do
			if IndiaNianCfg[iter_14_1].round > var_0_2 and IndiaNianCfg[iter_14_1].stage_type ~= 1 then
				var_14_0 = var_14_0 + IndiaNianCfg[iter_14_1].boss_hp
			end
		end
	end

	return var_14_0 + (var_0_4[IndiaNianCfg[arg_14_1].group_id] or 0)
end

function var_0_0.GetActivityID(arg_15_0)
	return var_0_1
end

function var_0_0.GetRound(arg_16_0)
	return var_0_2
end

function var_0_0.IsBossRound(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(IndiaNianCfg.get_id_list_by_group_id[100]) do
		if IndiaNianCfg[iter_17_1].round == arg_17_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetStageHasClearedByID(arg_18_0, arg_18_1)
	return not not table.keyof(var_0_3, (IndiaNianCfg[arg_18_1].stage_type ~= 1 or nil) and IndiaNianCfg.get_id_list_by_group_id[IndiaNianCfg[arg_18_1].group_id][2])
end

function var_0_0.GetHasCompeletedTask(arg_19_0)
	local var_19_0 = {}
	local var_19_1 = TaskData2:GetActivityTaskSortList(IndiaNianData:GetActivityID())

	if table.isEmpty(var_19_1) then
		return false
	end

	for iter_19_0, iter_19_1 in pairs(var_19_1) do
		table.insert(var_19_0, iter_19_1)
	end

	table.sort(var_19_0, function(arg_20_0, arg_20_1)
		return arg_20_0.id < arg_20_1.id
	end)

	for iter_19_2, iter_19_3 in ipairs(var_19_0) do
		if AssignmentCfg[iter_19_3.id].need <= iter_19_3.progress and iter_19_3.complete_flag < 1 then
			return true
		end
	end

	return false
end

function var_0_0.GetClearBuffNum(arg_21_0)
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in ipairs(var_0_3) do
		if IndiaNianCfg[iter_21_1].group_id ~= 100 and IndiaNianCfg[iter_21_1].stage_type == 1 then
			var_21_0 = var_21_0 + 1
		end
	end

	return var_21_0
end

function var_0_0:GetHasUnlockBuff()
	if (getData("ActivityIndiaNian" .. self:GetActivityID() .. PlayerData:GetPlayerInfo().userID, "buffNum") or 0) < self:GetClearBuffNum() then
		return true
	end

	return false
end

return var_0_0
