local var_0_0 = class("BuildPoolExchangeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().activity_id
	local var_1_1 = getProxy(ActivityProxy):getActivityById(var_1_0)

	if not var_1_1 or var_1_1:isEnd() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 2,
		arg1 = 0,
		arg2 = 0,
		activity_id = var_1_0,
		arg_list = {}
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1.data2 = var_1_1.data2 + 1

			getProxy(ActivityProxy):updateActivity(var_1_1)
			arg_1_0:sendNotification(GAME.ACTIVITY_BUILD_POOL_EXCHANGE_DONE, {
				awards = PlayerConst.addTranDrop(arg_2_0.award_list)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
