local var_0_0 = {}

manager.net:Bind(89421, function(arg_1_0)
	HodurSystemData:InitData(arg_1_0)
end)

function var_0_0.ResetChapter(arg_2_0)
	manager.net:SendWithLoadingNew(89422, {
		activity_id = ActivityConst.ACTIVITY_HODUR_MAIN,
		chapter_id = arg_2_0
	}, 89423, function(arg_3_0, arg_3_1)
		var_0_0.OnResetChapter(arg_3_0, arg_3_1)
	end)
end

function var_0_0:OnResetChapter(arg_4_1)
	if isSuccess(self.result) then
		HodurSystemData:OnResetChapter(arg_4_1.chapter_id)
		manager.notify:CallUpdateFunc(HODUR_RESET_CHAPTER)
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.SettleChallenge()
	manager.net:SendWithLoadingNew(89424, {
		activity_id = ActivityConst.ACTIVITY_HODUR_MAIN
	}, 89425, function(arg_6_0, arg_6_1)
		var_0_0.OnSettleChallenge(arg_6_0, arg_6_1)
	end)
end

function var_0_0:OnSettleChallenge(arg_7_1)
	if isSuccess(self.result) then
		HodurSystemData:OnSettleChallenge()
		HodurSystemData:ClearChallengeTeamCache()
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.SelectEvent(arg_8_0, arg_8_1, arg_8_2)
	manager.net:SendWithLoadingNew(89426, {
		activity_id = ActivityConst.ACTIVITY_HODUR_MAIN,
		chapter_id = arg_8_0,
		option_id = arg_8_1
	}, 89427, function(arg_9_0, arg_9_1)
		var_0_0.OnSelectEvent(arg_9_0, arg_9_1, arg_8_2)
	end)
end

function var_0_0:OnSelectEvent(arg_10_1, arg_10_2)
	if isSuccess(self.result) then
		HodurSystemData:OnSelectEvent(arg_10_1.chapter_id, arg_10_1.option_id)
		manager.notify:CallUpdateFunc(HODUR_SELECT_EVENT, arg_10_2)

		local var_10_0 = ActivityHodurEventOptionCfg[arg_10_1.option_id].buff_id
		local var_10_1

		if not ActivityHodurEventOptionCfg[arg_10_1.option_id].buff_id then
			var_10_0 = 0
			var_10_1 = {
				area_id = 1,
				activity_id = arg_10_1.activity_id,
				chapter_id = arg_10_1.chapter_id,
				round = self.round,
				params_list = string.format("[%s,%s]", ActivityHodurEventCfg[ActivityHodurEventCfg.get_id_list_by_event_option[arg_10_1.option_id][1]].event_option[1], ActivityHodurEventCfg[ActivityHodurEventCfg.get_id_list_by_event_option[arg_10_1.option_id][1]].event_option[2]),
				params_select = arg_10_1.option_id
			}
		end

		var_10_1.buff_list = string.format("[%s]", var_10_0)

		SDKTools.SendMessageToSDK("activity_currency_opt", var_10_1)
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.InitRedPoint()
	HodurSystemData:InitRedPointGroup()
	HodurSystemData:UpdateTaskRedPoint()
end

return var_0_0
