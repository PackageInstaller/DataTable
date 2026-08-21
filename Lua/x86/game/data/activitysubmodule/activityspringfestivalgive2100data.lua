local var_0_0 = singletonClass("ActivitySpringFestivalGive2100Data")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = 1

function var_0_0.InitData(arg_1_0, arg_1_1)
	var_0_3 = 1
	var_0_1 = arg_1_1.day_list

	var_0_0:SetDayListInfo()
	var_0_0:InitRedPoint()
end

function var_0_0.SetDayListInfo(arg_2_0)
	local var_2_0 = #ActivitySpringFestivalGive2100Cfg.all

	var_0_2 = {}

	for iter_2_0 = 1, var_2_0 do
		local var_2_1 = ActivitySpringFestivalGive2100Cfg.all[iter_2_0]
		local var_2_2 = var_0_0:GetState(var_2_1)
		local var_2_3 = {
			day = iter_2_0,
			state = var_2_2
		}

		table.insert(var_0_2, var_2_3)
	end

	for iter_2_1, iter_2_2 in ipairs(var_0_2) do
		if iter_2_2.state == "reward" then
			var_0_3 = iter_2_2.day

			break
		end
	end
end

function var_0_0.GetDayListInfo(arg_3_0)
	return var_0_2
end

function var_0_0.GetState(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(var_0_1) do
		if iter_4_1 == arg_4_1 then
			return "complete"
		end
	end

	if not ActivityData:GetActivityIsOpen(arg_4_1) then
		return "lock"
	else
		return "reward"
	end
end

function var_0_0.SetCurSelectDay(arg_5_0, arg_5_1)
	var_0_3 = arg_5_1
end

function var_0_0.GetCurSelectDay(arg_6_0, arg_6_1)
	if arg_6_1 then
		for iter_6_0, iter_6_1 in ipairs(var_0_2) do
			if iter_6_1.state == "reward" then
				var_0_3 = iter_6_1.day

				break
			end
		end
	end

	return var_0_3
end

function var_0_0.GetDayListInfoByIndex(arg_7_0, arg_7_1)
	return var_0_2[arg_7_1]
end

function var_0_0.SetDayListInfoByIndex(arg_8_0, arg_8_1)
	var_0_2[arg_8_1].state = "complete"
end

function var_0_0.InitRedPoint(arg_9_0)
	local var_9_0 = 0
	local var_9_1 = string.format("%s_%s", RedPointConst.ACTIVITY_SPRING_FESTIVAL_GIVE_2100, ActivityConst.ACTIVITY_SPRING_FESTIVAL_GIVE_2100)

	for iter_9_0, iter_9_1 in ipairs(var_0_2) do
		local var_9_2 = ActivitySpringFestivalGive2100Cfg.all[iter_9_0]
		local var_9_3 = ActivityData:GetActivityData(var_9_2).startTime

		if iter_9_1.state == "complete" then
			-- block empty
		elseif ActivityData:GetActivityIsOpen(var_9_2) and iter_9_1.state == "reward" and var_9_3 < manager.time:GetServerTime() then
			var_9_0 = var_9_0 + 1
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SPRING_FESTIVAL_GIVE_2100, ActivityConst.ACTIVITY_SPRING_FESTIVAL_GIVE_2100), var_9_0)
end

return var_0_0
