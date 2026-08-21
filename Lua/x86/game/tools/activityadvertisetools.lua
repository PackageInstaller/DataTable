local var_0_0 = {}

function var_0_0.GetOpenActivityCfgIDList()
	local var_1_0 = {}

	for iter_1_0 = #ActivityAdvertiseCfg.all, 1, -1 do
		local var_1_1 = ActivityAdvertiseCfg.all[iter_1_0]
		local var_1_2 = ActivityAdvertiseCfg[var_1_1].activity_id

		if ActivityTools.GetActivityStatus(var_1_2) == 1 and var_0_0.UnDisplayedAdvertise(var_1_1) then
			table.insert(var_1_0, var_1_1)
		end
	end

	table.sort(var_1_0, function(arg_2_0, arg_2_1)
		local var_2_0 = ActivityAdvertiseCfg[arg_2_0].order
		local var_2_1 = ActivityAdvertiseCfg[arg_2_1].order

		if var_2_1 < var_2_0 then
			return true
		elseif var_2_0 < var_2_1 then
			return false
		else
			return arg_2_0 < arg_2_1
		end
	end)

	return var_1_0
end

function var_0_0.NeedShowAdvertise()
	local var_3_0 = var_0_0.GetOpenActivityCfgIDList()[1]

	if var_3_0 == nil then
		return false
	end

	return var_0_0.UnDisplayedAdvertise(var_3_0)
end

function var_0_0.UnDisplayedAdvertise(arg_4_0)
	local var_4_0 = ActivityAdvertiseCfg[arg_4_0]
	local var_4_1 = var_4_0.activity_id
	local var_4_2 = getData("activityAdvertise", tostring(arg_4_0)) or 0
	local var_4_3 = getData("activityAdvertise", "prompt" .. arg_4_0) or false

	if ActivityAdvertiseData:GetOpenAdvertiseFlag(arg_4_0) or manager.time:IsToday(var_4_2) and var_4_3 then
		return false
	end

	if var_4_0.hide_condition_list ~= "" then
		local var_4_4 = false

		for iter_4_0, iter_4_1 in ipairs(var_4_0.hide_condition_list) do
			var_4_4 = IsConditionAchieved(iter_4_1)

			if var_4_4 == false then
				break
			end
		end

		if var_4_4 then
			return false
		end
	end

	return true
end

function var_0_0.StopAllAdvertise()
	local var_5_0 = {}

	for iter_5_0 = #ActivityAdvertiseCfg.all, 1, -1 do
		local var_5_1 = ActivityAdvertiseCfg.all[iter_5_0]
		local var_5_2 = ActivityAdvertiseCfg[var_5_1].activity_id

		if ActivityTools.GetActivityStatus(var_5_2) == 1 then
			table.insert(var_5_0, var_5_1)
		end
	end

	local var_5_3 = manager.time:GetServerTime()

	for iter_5_1, iter_5_2 in ipairs(var_5_0) do
		saveData("activityAdvertise", tostring(iter_5_2), var_5_3)
		ActivityAdvertiseData:SetOpenAdvertiseFlag(iter_5_2, true)

		local var_5_4 = ActivityAdvertiseData:GetDefaultPrompt()

		if not getData("activityAdvertise", "prompt" .. iter_5_2) and var_5_4 then
			saveData("activityAdvertise", "prompt" .. iter_5_2, var_5_4)
		end
	end
end

return var_0_0
