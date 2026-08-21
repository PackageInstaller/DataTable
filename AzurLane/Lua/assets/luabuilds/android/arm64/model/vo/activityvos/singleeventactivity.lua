local var_0_0 = class("SingleEventActivity", import("model.vo.Activity"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.eventData = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0:GetAllEventIds()) do
		local var_1_0 = SingleEvent.New({
			id = iter_1_1
		})

		if var_1_0:IsMain() then
			arg_1_0.eventData[iter_1_1] = var_1_0
		end
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_0:GetDailyEventIds()) do
		local var_1_1 = SingleEvent.New({
			id = iter_1_3
		})

		if var_1_1:IsDaily() then
			arg_1_0.eventData[iter_1_3] = var_1_1
		end
	end

	return
end

function var_0_0.GetEventById(arg_2_0, arg_2_1)
	return arg_2_0.eventData[arg_2_1]
end

function var_0_0.GetAllEventIds(arg_3_0)
	return arg_3_0:getConfig("config_data")
end

function var_0_0.GetFinishMainIds(arg_4_0)
	return arg_4_0.data1_list
end

function var_0_0.AddFinishMainId(arg_5_0, arg_5_1)
	if not table.contains(arg_5_0:GetFinishMainIds(), arg_5_1) then
		table.insert(arg_5_0:GetFinishMainIds(), arg_5_1)
	end

	return
end

function var_0_0.IsFinish(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:GetEventById(arg_6_1)

	if var_6_0:IsMain() then
		return table.contains(arg_6_0:GetFinishMainIds(), arg_6_1)
	end

	if var_6_0:IsDaily() then
		return table.contains(arg_6_0:GetDailyEventIds(), arg_6_1) and not table.contains(arg_6_0:GetUnFinishDailyIds(), arg_6_1)
	end

	return false
end

function var_0_0.IsFinishAllMain(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.eventData) do
		if iter_7_1:IsMain() and not arg_7_0:IsFinish(iter_7_1.id) then
			return false
		end
	end

	return true
end

function var_0_0.CheckDailyEventRequest(arg_8_0)
	return #arg_8_0:GetDailyEventIds() == 0
end

function var_0_0.SetDailyEventIds(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.eventData) do
		if iter_9_1:IsDaily() then
			arg_9_0.eventData[iter_9_0] = nil
		end
	end

	arg_9_0.data2_list = {}
	arg_9_0.data3_list = {}

	for iter_9_2, iter_9_3 in ipairs(arg_9_1) do
		table.insert(arg_9_0.data2_list, iter_9_3)
		table.insert(arg_9_0.data3_list, iter_9_3)

		local var_9_0 = SingleEvent.New({
			id = iter_9_3
		})

		if var_9_0:IsDaily() then
			arg_9_0.eventData[iter_9_3] = var_9_0
		end
	end

	return
end

function var_0_0.GetDailyEventIds(arg_10_0)
	return arg_10_0.data2_list
end

function var_0_0.GetUnFinishDailyIds(arg_11_0)
	return arg_11_0.data3_list
end

function var_0_0.RemoveFinishDailyId(arg_12_0, arg_12_1)
	if table.contains(arg_12_0:GetUnFinishDailyIds(), arg_12_1) then
		table.removebyvalue(arg_12_0:GetUnFinishDailyIds(), arg_12_1)
	end

	return
end

function var_0_0.CheckTrigger(arg_13_0, arg_13_1)
	if not arg_13_0.eventData[arg_13_1] then
		return false
	end

	if arg_13_0:IsFinish(arg_13_1) then
		return false
	end

	local var_13_0 = arg_13_0.eventData[arg_13_1]:GetPreEventId()

	return var_13_0 == 0 or arg_13_0:IsFinish(var_13_0)
end

function var_0_0.AddFinishEvent(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetEventById(arg_14_1)

	if var_14_0:IsMain() then
		arg_14_0:AddFinishMainId(arg_14_1)
	end

	if var_14_0:IsDaily() then
		arg_14_0:RemoveFinishDailyId(arg_14_1)
	end

	return
end

function var_0_0.GetUnlockMapAreas(arg_15_0)
	local var_15_0 = {}

	underscore.each(arg_15_0:GetFinishMainIds(), function(arg_16_0)
		if pg.activity_single_event[arg_16_0].map_options == "" then
			return
		end

		local var_16_0 = tonumber(pg.activity_single_event[arg_16_0].map_options)

		if not table.contains(var_15_0, var_16_0) then
			table.insert(var_15_0, var_16_0)
		end

		return
	end)

	return {}
end

function var_0_0.GetLastShowConfig(arg_17_0)
	local var_17_0 = arg_17_0:GetFinishMainIds()

	if #var_17_0 == 0 then
		return {}
	end

	table.sort(var_17_0)

	for iter_17_0 = #var_17_0 - 1, 1, -1 do
		if #pg.activity_single_event[var_17_0[iter_17_0]].options > 0 then
			return pg.activity_single_event[var_17_0[iter_17_0]].options
		end
	end

	return pg.activity_single_event[var_17_0[1]].options
end

function var_0_0.GetShowConfig(arg_18_0)
	local var_18_0 = arg_18_0:GetFinishMainIds()

	if #var_18_0 == 0 then
		return {}
	end

	table.sort(var_18_0)

	for iter_18_0 = #var_18_0, 1, -1 do
		if #pg.activity_single_event[var_18_0[iter_18_0]].options > 0 then
			return pg.activity_single_event[var_18_0[iter_18_0]].options
		end
	end

	return pg.activity_single_event[var_18_0[1]].options
end

function var_0_0.IsShowMapAnim(arg_19_0, arg_19_1)
	if not arg_19_0:GetEventById(arg_19_1):IsMain() then
		return false
	end

	local var_19_0 = arg_19_0:GetFinishMainIds()
	local var_19_1 = arg_19_0:GetUnlockMapAreas()
	local var_19_2 = {}

	for iter_19_0 = 1, #var_19_0 - 1 do
		table.insert({}, var_19_0[iter_19_0])
	end

	underscore.each({}, function(arg_20_0)
		if pg.activity_single_event[arg_20_0].map_options == "" then
			return
		end

		local var_20_0 = tonumber(pg.activity_single_event[arg_20_0].map_options)

		if not table.contains(var_19_2, var_20_0) then
			table.insert(var_19_2, var_20_0)
		end

		return
	end)

	return #var_19_1 ~= #var_19_2
end

return var_0_0
