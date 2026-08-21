local var_0_0 = class("MainCommonActDelegationBtn", import(".MainBaseSpcailActBtn"))

function var_0_0.GetEventName(arg_1_0)
	return "event_old_act"
end

function var_0_0.GetContainer(arg_2_0)
	return arg_2_0.root.parent:Find("eventPanel")
end

function var_0_0.GetLinkConfig(arg_3_0)
	local var_3_0 = pg.activity_link_button
	local var_3_1 = pg.activity_link_button.get_id_list_by_name[arg_3_0:GetEventName()] or {}
	local var_3_2 = _.select(var_3_1, function(arg_4_0)
		if type(var_3_0[arg_4_0].time) == "table" and var_3_0[arg_4_0].time[1] and var_3_0[arg_4_0].time[1] == "default" then
			return arg_3_0:InActTime(var_3_0[arg_4_0].time[2])
		else
			return pg.TimeMgr.GetInstance():inTime(var_3_0[arg_4_0].time)
		end

		return
	end)

	if #var_3_2 > 0 then
		table.sort(var_3_2, CompareFuncs({
			function(arg_5_0)
				return var_3_0[arg_5_0].order
			end
		}))

		return pg.activity_link_button[var_3_2[1]]
	end

	return
end

function var_0_0.InActTime(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1 or arg_6_0:GetActivityID()

	if var_6_0 then
		local var_6_1 = getProxy(ActivityProxy):getActivityById(var_6_0)

		return var_6_1 and not var_6_1:isEnd()
	end

	return false
end

function var_0_0.InShowTime(arg_7_0)
	local var_7_0 = arg_7_0:GetLinkConfig()

	if var_7_0 ~= nil then
		arg_7_0.config = var_7_0

		return true
	else
		return false
	end

	return
end

function var_0_0.GetUIName(arg_8_0)
	return "MainCommonActDelegationBtn"
end

function var_0_0.OnClick(arg_9_0)
	MainBaseActivityBtn.Skip(arg_9_0, arg_9_0.config)

	return
end

function var_0_0.OnInit(arg_10_0)
	arg_10_0.tipTr = arg_10_0._tf:Find("tip")

	setActive(arg_10_0.tipTr, arg_10_0:IsShowTip())

	return
end

function var_0_0.GetActivity(arg_11_0)
	if arg_11_0.config and arg_11_0.config.time and arg_11_0.config.time[1] == "default" then
		local var_11_0 = getProxy(ActivityProxy):getActivityById(arg_11_0.config.time[2])

		if var_11_0 and not var_11_0:isEnd() then
			return var_11_0
		end
	end

	return nil
end

function var_0_0.IsShowTip(arg_12_0)
	local var_12_0 = arg_12_0:GetActivity()

	return switch(arg_12_0:GetActivity():getConfig("type"), {
		[ActivityConst.ACTIVITY_TYPE_TOWN2] = function()
			return LiquorFloorMapScene.ShouldShowTaskTip()
		end
	}, function()
		return var_12_0:readyToAchieve()
	end)
end

function var_0_0.emit(arg_15_0, ...)
	arg_15_0.event:emit(...)

	return
end

function var_0_0.OnRegister(arg_16_0)
	return
end

function var_0_0.OnClear(arg_17_0)
	return
end

return var_0_0
