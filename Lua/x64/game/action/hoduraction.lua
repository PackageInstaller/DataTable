local var_0_0 = {}

manager.net:Bind(89421, function(arg_1_0)
	HodurSystemData:InitData(arg_1_0)
end)

function var_0_0.ResetChapter(arg_2_0)
	local var_2_0 = {
		activity_id = ActivityConst.ACTIVITY_HODUR_MAIN,
		chapter_id = arg_2_0
	}

	manager.net:SendWithLoadingNew(89422, var_2_0, 89423, function(arg_3_0, arg_3_1)
		var_0_0.OnResetChapter(arg_3_0, arg_3_1)
	end)
end

function var_0_0.OnResetChapter(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		HodurSystemData:OnResetChapter(arg_4_1.chapter_id)
		manager.notify:CallUpdateFunc(HODUR_RESET_CHAPTER)
	else
		ShowTips(GetTips(arg_4_0.result))
	end
end

function var_0_0.SettleChallenge()
	local var_5_0 = {
		activity_id = ActivityConst.ACTIVITY_HODUR_MAIN
	}

	manager.net:SendWithLoadingNew(89424, var_5_0, 89425, function(arg_6_0, arg_6_1)
		var_0_0.OnSettleChallenge(arg_6_0, arg_6_1)
	end)
end

function var_0_0.OnSettleChallenge(arg_7_0, arg_7_1)
	if isSuccess(arg_7_0.result) then
		HodurSystemData:OnSettleChallenge()
		HodurSystemData:ClearChallengeTeamCache()
	else
		ShowTips(GetTips(arg_7_0.result))
	end
end

function var_0_0.SelectEvent(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {
		activity_id = ActivityConst.ACTIVITY_HODUR_MAIN,
		chapter_id = arg_8_0,
		option_id = arg_8_1
	}

	manager.net:SendWithLoadingNew(89426, var_8_0, 89427, function(arg_9_0, arg_9_1)
		var_0_0.OnSelectEvent(arg_9_0, arg_9_1, arg_8_2)
	end)
end

function var_0_0.OnSelectEvent(arg_10_0, arg_10_1, arg_10_2)
	if isSuccess(arg_10_0.result) then
		HodurSystemData:OnSelectEvent(arg_10_1.chapter_id, arg_10_1.option_id)
		manager.notify:CallUpdateFunc(HODUR_SELECT_EVENT, arg_10_2)

		local var_10_0 = ActivityHodurEventCfg.get_id_list_by_event_option[arg_10_1.option_id][1]
		local var_10_1 = ActivityHodurEventCfg[var_10_0]
		local var_10_2 = ActivityHodurEventOptionCfg[arg_10_1.option_id]
		local var_10_3 = string.format("[%s,%s]", var_10_1.event_option[1], var_10_1.event_option[2])
		local var_10_4 = string.format("[%s]", var_10_2.buff_id or 0)

		SDKTools.SendMessageToSDK("activity_currency_opt", {
			area_id = 1,
			activity_id = arg_10_1.activity_id,
			chapter_id = arg_10_1.chapter_id,
			round = arg_10_0.round,
			params_list = var_10_3,
			params_select = arg_10_1.option_id,
			buff_list = var_10_4
		})
	else
		ShowTips(GetTips(arg_10_0.result))
	end
end

function var_0_0.InitRedPoint()
	HodurSystemData:InitRedPointGroup()
	HodurSystemData:UpdateTaskRedPoint()
end

return var_0_0
