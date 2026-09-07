local FetchNpcShipActivityCommand = class("FetchNpcShipActivityCommand", pm.SimpleCommand)

function FetchNpcShipActivityCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = getProxy(ActivityProxy):getActivityById(var_1_0.activity_id)

	if var_1_2.data1 > 0 then
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
			var_1_2.data1 = 1
			var_1_2.data2 = getProxy(BayProxy):getActivityNPCShipByActId(var_1_2.id)

			getProxy(ActivityProxy):updateActivity(var_1_2)
			self:sendNotification(GAME.FETCH_NPC_SHIP_ACTIVITY_DONE, {
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

return FetchNpcShipActivityCommand
