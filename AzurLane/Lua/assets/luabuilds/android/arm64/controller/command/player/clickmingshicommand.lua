local var_0_0 = class("ClickMingShiCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(PlayerProxy)
	local var_1_2 = var_1_1:getData()

	var_1_2.mingshiCount = var_1_2.mingshiCount + 1

	local var_1_3 = getProxy(ActivityProxy):getActivityById(mingshiActivityId)

	if var_1_3 and not var_1_3:isEnd() and not LOCK_CLICK_MINGSHI then
		if getProxy(TaskProxy):getmingshiTaskID(var_1_2.mingshiCount) > 0 then
			arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, {
				cmd = 1,
				activity_id = mingshiActivityId
			})
		end
	end

	if var_1_2.mingshiflag >= 2 then
		var_1_1:updatePlayer(var_1_2)

		return
	end

	pg.ConnectionMgr.GetInstance():Send(11506, {
		state = 0
	}, 11507, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2.chargeExp = var_1_2.chargeExp + 5
			var_1_2.mingshiflag = var_1_2.mingshiflag + 1

			arg_1_0:sendNotification(GAME.CLICK_MING_SHI_SUCCESS)
		else
			var_1_2.mingshiflag = 2
		end

		var_1_1:updatePlayer(var_1_2)

		return
	end)

	return
end

return var_0_0
