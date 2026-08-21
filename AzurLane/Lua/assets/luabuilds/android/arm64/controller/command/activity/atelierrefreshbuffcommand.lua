local var_0_0 = class("AtelierRefreshBuffCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)

	assert(var_1_0)

	local var_1_1 = {}

	table.Foreach(arg_1_1.body, function(arg_2_0, arg_2_1)
		if arg_2_1[1] == 0 then
			return
		end

		table.insert(var_1_1, {
			pos = arg_2_0,
			itemid = arg_2_1[1],
			itemnum = arg_2_1[2]
		})

		return
	end)
	pg.ConnectionMgr.GetInstance():Send(26055, {
		act_id = var_1_0.id,
		slots = {}
	}, 26056, function(arg_3_0)
		if arg_3_0.result == 0 then
			var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)

			var_1_0:UpdateBuffSlots(var_1_1)
			getProxy(ActivityProxy):updateActivity(var_1_0)
			arg_1_0:sendNotification(GAME.UPDATE_ATELIER_BUFF_DONE, var_1_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_3_0.result))
		end

		return
	end)

	return
end

return var_0_0
