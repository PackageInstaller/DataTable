local var_0_0 = class("FetchNpcShipActivityCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	if getProxy(ActivityProxy):getActivityById(var_1_0.activity_id).data1 > 0 then
		existCall(var_1_0.callback)

		return
	end

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 1,
		arg1 = 0,
		arg2 = 0,
		activity_id = var_1_0.activity_id,
		arg_list = {}
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_0.data1 = 1
			var_0.data2 = getProxy(BayProxy):getActivityNPCShipByActId(var_0.id)

			getProxy(ActivityProxy):updateActivity(var_0)
			arg_1_0:sendNotification(GAME.FETCH_NPC_SHIP_ACTIVITY_DONE, {
				items = PlayerConst.GetTranAwards(var_1_0, arg_2_0),
				callback = var_1_1
			})
		else
			originalPrint(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
