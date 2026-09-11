local var_0_0 = {}

function var_0_0.GetOpenActivityCfgIDList()
	local var_1_0 = {}

	for iter_1_0 = #ActivityAdvertiseCfg.all, 1, -1 do
		if ActivityTools.GetActivityStatus(ActivityAdvertiseCfg[ActivityAdvertiseCfg.all[iter_1_0]].activity_id) == 1 and var_0_0.UnDisplayedAdvertise(ActivityAdvertiseCfg.all[iter_1_0]) then
			table.insert(var_1_0, ActivityAdvertiseCfg.all[iter_1_0])
		end
	end

	table.sort(var_1_0, function(arg_2_0, arg_2_1)
		if ActivityAdvertiseCfg[arg_2_1].order < ActivityAdvertiseCfg[arg_2_0].order then
			return true
		elseif ActivityAdvertiseCfg[arg_2_0].order < ActivityAdvertiseCfg[arg_2_1].order then
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
	if ActivityAdvertiseData:GetOpenAdvertiseFlag(arg_4_0) or manager.time:IsToday(getData("activityAdvertise", tostring(arg_4_0)) or 0) and (getData("activityAdvertise", "prompt" .. arg_4_0) or false) then
		return false
	end

	if ActivityAdvertiseCfg[arg_4_0].hide_condition_list ~= "" then
		local var_4_2 = false

		for iter_4_0, iter_4_1 in ipairs(ActivityAdvertiseCfg[arg_4_0].hide_condition_list) do
			var_4_2 = IsConditionAchieved(iter_4_1)

			if var_4_2 == false then
				break
			end
		end

		if var_4_2 then
			return false
		end
	end

	return true
end

function var_0_0.StopAllAdvertise()
	local var_5_0 = {}

	for iter_5_0 = #ActivityAdvertiseCfg.all, 1, -1 do
		if ActivityTools.GetActivityStatus(ActivityAdvertiseCfg[ActivityAdvertiseCfg.all[iter_5_0]].activity_id) == 1 then
			table.insert(var_5_0, ActivityAdvertiseCfg.all[iter_5_0])
		end
	end

	local var_5_1 = manager.time:GetServerTime()

	for iter_5_1, iter_5_2 in ipairs(var_5_0) do
		saveData("activityAdvertise", tostring(iter_5_2), var_5_1)
		ActivityAdvertiseData:SetOpenAdvertiseFlag(iter_5_2, true)

		local var_5_2 = ActivityAdvertiseData:GetDefaultPrompt()

		if not getData("activityAdvertise", "prompt" .. iter_5_2) and var_5_2 then
			saveData("activityAdvertise", "prompt" .. iter_5_2, var_5_2)
		end
	end
end

return var_0_0
