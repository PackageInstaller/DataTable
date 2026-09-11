local var_0_0 = singletonClass("ActivitySummerSwimsuitPreheatData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}

function var_0_0:InitData()
	var_0_1[self.activity_id] = self.day
	var_0_2[self.activity_id] = self.finished_list
	var_0_3[self.activity_id] = self.got_item_stage
end

function var_0_0.GetDay(arg_2_0)
	return var_0_1[arg_2_0] or -1
end

function var_0_0._SetDay(arg_3_0, arg_3_1)
	var_0_1[arg_3_0] = arg_3_1
end

function var_0_0.AddClearedStage(arg_4_0, arg_4_1)
	local var_4_0 = var_0_2[arg_4_0] or {}

	if table.indexof(var_4_0, arg_4_1) then
		return
	end

	table.insert(var_4_0, arg_4_1)
end

function var_0_0.IsStageClear(arg_5_0, arg_5_1)
	local var_5_0 = var_0_2[arg_5_0]

	if var_0_2[arg_5_0] == nil then
		return false
	end

	return table.indexof(var_5_0, arg_5_1) ~= false
end

function var_0_0.GetStageReward(arg_6_0, arg_6_1)
	local var_6_0 = var_0_3[arg_6_0] or {}

	if table.indexof(var_6_0, arg_6_1) then
		return
	end

	table.insert(var_6_0, arg_6_1)
end

function var_0_0.IsGotStageReward(arg_7_0, arg_7_1)
	local var_7_0 = var_0_3[arg_7_0]

	if var_0_3[arg_7_0] == nil then
		return false
	end

	return table.indexof(var_7_0, arg_7_1) ~= false
end

return var_0_0
