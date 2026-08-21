local var_0_0 = class("MainActLotteryBtn", import(".MainBaseActivityBtn"))

function var_0_0.GetEventName(arg_1_0)
	return "event_LanternFestival"
end

function var_0_0.GetActivityID(arg_2_0)
	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOTTERY)

	return var_2_0 and var_2_0.id
end

function var_0_0.OnInit(arg_3_0)
	local var_3_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOTTERY)
	local var_3_1 = var_3_0:getAwardInfos()

	setActive(arg_3_0._tf:Find("Tip"), (_.any(var_3_0:getConfig("config_data"), function(arg_4_0)
		local var_4_0 = ActivityItemPool.New({
			id = arg_4_0,
			awards = var_3_1[arg_4_0]
		})
		local var_4_1 = var_4_0:getComsume()
		local var_4_2 = getProxy(PlayerProxy):getRawData()[id2res(var_4_1.id)]

		return var_4_2 >= var_4_1.count and var_4_0:getleftItemCount() > 0
	end)))

	return
end

function var_0_0.CustomOnClick(arg_5_0)
	local var_5_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOTTERY)

	if var_5_0 then
		arg_5_0:emit(NewMainMediator.SKIP_LOTTERY, var_5_0.id)
	end

	return
end

return var_0_0
