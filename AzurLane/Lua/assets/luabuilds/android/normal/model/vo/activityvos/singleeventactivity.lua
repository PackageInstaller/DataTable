class = var_0_10000

local var_0_0 = "SingleEventActivity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.Activity"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.eventData = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_0:GetAllEventIds()) do
		SingleEvent = var_1_10007

		local var_1_0 = var_1_10007.New({
			id = iter_1_1
		})

		if var_1_10007.IsMain(var_1_0) then
			arg_1_0.eventData[iter_1_1] = var_1_10007
		end
	end

	ipairs = var_2

	for iter_1_2, iter_1_3 in var_2(arg_1_0:GetDailyEventIds()) do
		SingleEvent = var_1_10007

		local var_1_1 = var_1_10007.New({
			id = iter_1_3
		})

		if var_1_10007.IsDaily(var_1_1) then
			arg_1_0.eventData[iter_1_3] = var_1_10007
		end
	end

	return
end

function var_0_1.GetEventById(arg_2_0, arg_2_1)
	return arg_2_0.eventData[arg_2_1]
end

function var_0_1.GetAllEventIds(arg_3_0)
	return arg_3_0:getConfig("config_data")
end

function var_0_1.GetFinishMainIds(arg_4_0)
	return arg_4_0.data1_list
end

function var_0_1.AddFinishMainId(arg_5_0, arg_5_1)
	table = var_1_10002

	if not var_1_10002.contains(arg_5_0:GetFinishMainIds(), arg_5_1) then
		table = var_2

		var_2.insert(arg_5_0:GetFinishMainIds(), arg_5_1)
	end

	return
end

function var_0_1.IsFinish(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:GetEventById(arg_6_1)

	if var_2.IsMain(var_6_0) then
		table = var_3

		return var_3.contains(arg_6_0:GetFinishMainIds(), arg_6_1)
	end

	if var_2:IsDaily() then
		table = var_3

		local var_6_1

		if var_3.contains(arg_6_0:GetDailyEventIds(), arg_6_1) then
			table = var_6_1
			var_6_1 = not var_6_1.contains(arg_6_0:GetUnFinishDailyIds(), arg_6_1)
		end

		return var_6_1
	end

	return false
end

function var_0_1.IsFinishAllMain(arg_7_0)
	pairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.eventData) do
		if iter_7_1:IsMain() and not arg_7_0:IsFinish(iter_7_1.id) then
			return false
		end
	end

	return true
end

function var_0_1.CheckDailyEventRequest(arg_8_0)
	return #arg_8_0:GetDailyEventIds() == 0
end

function var_0_1.SetDailyEventIds(arg_9_0, arg_9_1)
	pairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0.eventData) do
		if iter_9_1:IsDaily() then
			var_1_10007 = arg_9_0.eventData
			var_1_10007[iter_9_0] = nil
		end
	end

	arg_9_0.data2_list = {}
	arg_9_0.data3_list = {}
	ipairs = var_2

	for iter_9_2, iter_9_3 in var_2(arg_9_1) do
		table = var_1_10007

		var_1_10007.insert(arg_9_0.data2_list, iter_9_3)

		table = var_1_10007

		var_1_10007.insert(arg_9_0.data3_list, iter_9_3)

		SingleEvent = var_1_10007

		local var_9_0 = var_1_10007.New({
			id = iter_9_3
		})

		if var_1_10007.IsDaily(var_9_0) then
			arg_9_0.eventData[iter_9_3] = var_1_10007
		end
	end

	return
end

function var_0_1.GetDailyEventIds(arg_10_0)
	return arg_10_0.data2_list
end

function var_0_1.GetUnFinishDailyIds(arg_11_0)
	return arg_11_0.data3_list
end

function var_0_1.RemoveFinishDailyId(arg_12_0, arg_12_1)
	table = var_1_10002

	if var_1_10002.contains(arg_12_0:GetUnFinishDailyIds(), arg_12_1) then
		table = var_2

		var_2.removebyvalue(arg_12_0:GetUnFinishDailyIds(), arg_12_1)
	end

	return
end

function var_0_1.CheckTrigger(arg_13_0, arg_13_1)
	if not arg_13_0.eventData[arg_13_1] then
		return false
	end

	if arg_13_0:IsFinish(arg_13_1) then
		return false
	end

	local var_13_0 = arg_13_0.eventData[arg_13_1]

	return var_2.GetPreEventId(var_13_0) == 0 or arg_13_0:IsFinish(var_2)
end

function var_0_1.AddFinishEvent(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetEventById(arg_14_1)

	if var_2.IsMain(var_14_0) then
		arg_14_0:AddFinishMainId(arg_14_1)
	end

	if var_2:IsDaily() then
		arg_14_0:RemoveFinishDailyId(arg_14_1)
	end

	return
end

function var_0_1.GetUnlockMapAreas(arg_15_0)
	local var_15_0 = {}

	underscore = var_1_10002

	var_1_10002.each(arg_15_0:GetFinishMainIds(), function(arg_16_0)
		pg = var_2_10001

		if var_2_10001.activity_single_event[arg_16_0].map_options == "" then
			return
		end

		tonumber = var_2_10002

		local var_16_0 = var_2_10002(var_1)

		table = var_2

		if not var_2.contains(var_15_0, var_16_0) then
			table = var_2

			var_2.insert(var_15_0, var_16_0)
		end

		return
	end)

	return var_15_0
end

function var_0_1.GetLastShowConfig(arg_17_0)
	if #arg_17_0:GetFinishMainIds() == 0 then
		return {}
	end

	table = var_2

	var_2.sort(var_1)

	for iter_17_0 = #var_1 - 1, 1, -1 do
		pg = var_1_10006

		if #var_1_10006.activity_single_event[var_1[iter_17_0]].options > 0 then
			return var_1_10006
		end
	end

	pg = var_2

	return var_2.activity_single_event[var_1[1]].options
end

function var_0_1.GetShowConfig(arg_18_0)
	if #arg_18_0:GetFinishMainIds() == 0 then
		return {}
	end

	table = var_2

	var_2.sort(var_1)

	for iter_18_0 = #var_1, 1, -1 do
		pg = var_1_10006

		if #var_1_10006.activity_single_event[var_1[iter_18_0]].options > 0 then
			return var_1_10006
		end
	end

	pg = var_2

	return var_2.activity_single_event[var_1[1]].options
end

function var_0_1.IsShowMapAnim(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:GetEventById(arg_19_1)

	if not var_2.IsMain(var_19_0) then
		return false
	end

	local var_19_1 = arg_19_0:GetFinishMainIds()
	local var_19_2 = arg_19_0:GetUnlockMapAreas()
	local var_19_3 = {}
	local var_19_4 = {}

	for iter_19_0 = 1, #var_19_1 - 1 do
		table = var_1_10011

		var_1_10011.insert(var_19_3, var_19_1[iter_19_0])
	end

	underscore = var_7

	var_7.each(var_19_3, function(arg_20_0)
		pg = var_2_10001

		if var_2_10001.activity_single_event[arg_20_0].map_options == "" then
			return
		end

		tonumber = var_2_10002

		local var_20_0 = var_2_10002(var_1)

		table = var_2

		if not var_2.contains(var_19_4, var_20_0) then
			table = var_2

			var_2.insert(var_19_4, var_20_0)
		end

		return
	end)

	return #var_19_2 ~= #var_19_4
end

return var_0_1
