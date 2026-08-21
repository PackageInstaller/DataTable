local var_0_0 = class("Challenge2SettleRequestCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE)

	if not var_1_1 or var_1_1:isEnd() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(24009, {
		activity_id = var_1_1.id
	}, 24010, function(arg_2_0)
		if arg_2_0.result == 0 then
			arg_1_0:sendNotification(GAME.CHALLENGE2_SETTLE_DONE)
		end

		return
	end)

	return
end

return var_0_0
