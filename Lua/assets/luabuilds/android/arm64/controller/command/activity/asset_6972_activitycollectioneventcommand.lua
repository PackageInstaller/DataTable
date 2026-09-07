local ActivityCollectionEventCommand = class("ActivityCollectionEventCommand", pm.SimpleCommand)

function ActivityCollectionEventCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.event
	local var_1_2 = var_1_0.arg1
	local var_1_3 = var_1_0.onConfirm
	local var_1_4 = var_1_0.callBack
	local var_1_5 = getProxy(EventProxy)
	local var_1_6 = getProxy(ActivityProxy)
	local var_1_7 = var_1_6:getActivityByType(ActivityConst.ACTIVITY_TYPE_COLLECTION_EVENT)

	if not var_1_7 or var_1_7:isEnd() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(11202, {
		activity_id = var_1_7.id,
		cmd = var_1_0.cmd,
		arg1 = var_1_0.arg1,
		arg2 = var_1_0.arg2,
		arg_list = var_1_0.arg_list
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_0.cmd == ActivityConst.COLLETION_EVENT_OP_JOIN then
				EventStartCommand.OnStart(var_1_1)

				if var_1_4 then
					var_1_4()
				end

				if var_1_3 then
					var_1_3()
				end
			elseif var_1_0.cmd == ActivityConst.COLLETION_EVENT_OP_SUBMIT then
				table.insert(var_1_7.data1_list, var_1_2)
				var_1_6:updateActivity(var_1_7)
				EventFinishCommand.OnFinish(var_1_2, {
					exp = arg_2_0.number[1],
					drop_list = arg_2_0.award_list,
					new_collection = {},
					is_cri = arg_2_0.number[2]
				}, var_1_3)
				getProxy(EventProxy):CheckAddActivityEvent()

				if var_1_4 then
					var_1_4()
				end
			elseif var_1_0.cmd == ActivityConst.COLLETION_EVENT_OP_GIVE_UP then
				EventGiveUpCommand.OnCancel(var_1_2)
				getProxy(EventProxy):CheckAddActivityEvent()

				if var_1_4 then
					var_1_4()
				end

				if var_1_3 then
					var_1_3()
				end
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return ActivityCollectionEventCommand
