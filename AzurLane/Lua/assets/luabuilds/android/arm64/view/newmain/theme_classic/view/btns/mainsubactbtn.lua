local var_0_0 = class("MainSubActBtn", import(".MainBaseActivityBtn"))

function var_0_0.GetEventName(arg_1_0)
	return "event_sub_act"
end

function var_0_0.GetActivity(arg_2_0)
	if arg_2_0.config and arg_2_0.config.time and arg_2_0.config.time[1] == "default" then
		local var_2_0 = getProxy(ActivityProxy):getActivityById(arg_2_0.config.time[2])

		if var_2_0 and not var_2_0:isEnd() then
			return var_2_0
		end
	end

	return nil
end

function var_0_0.GetActivityID(arg_3_0)
	local var_3_0 = arg_3_0:GetActivity()

	return var_3_0 and var_3_0.id
end

function var_0_0.OnInit(arg_4_0)
	setActive(arg_4_0.tipTr, arg_4_0:IsShowTip())

	return
end

function var_0_0.IsShowTip(arg_5_0)
	local var_5_0 = arg_5_0:GetActivity()

	return switch(arg_5_0:GetActivity():getConfig("type"), {
		[ActivityConst.ACTIVITY_TYPE_TOWN2] = function()
			return LiquorFloorMapScene.ShouldShowTaskTip()
		end
	}, function()
		return var_5_0:readyToAchieve()
	end)
end

return var_0_0
