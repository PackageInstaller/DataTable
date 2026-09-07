local MainActLotteryBtn = class("MainActLotteryBtn", import(".MainBaseActivityBtn"))

function MainActLotteryBtn:GetEventName()
	return "event_LanternFestival"
end

function MainActLotteryBtn:GetActivityID()
	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOTTERY)

	return var_2_0 and var_2_0.id
end

function MainActLotteryBtn:OnInit()
	local var_3_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOTTERY)
	local var_3_1 = var_3_0:getAwardInfos()

	setActive(self._tf:Find("Tip"), (_.any(var_3_0:getConfig("config_data"), function(arg_4_0)
		local var_4_0 = ActivityItemPool.New({
			id = arg_4_0,
			awards = var_3_1[arg_4_0]
		})
		local var_4_1 = var_4_0:getComsume()

		return getProxy(PlayerProxy):getRawData()[id2res(var_4_1.id)] >= var_4_1.count and var_4_0:getleftItemCount() > 0
	end)))

	return
end

function MainActLotteryBtn:CustomOnClick()
	local var_5_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_LOTTERY)

	if var_5_0 then
		self:emit(NewMainMediator.SKIP_LOTTERY, var_5_0.id)
	end

	return
end

return MainActLotteryBtn
