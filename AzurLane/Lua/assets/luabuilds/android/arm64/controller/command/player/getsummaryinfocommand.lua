local var_0_0 = class("GetSummaryInfoCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(26021, {
		act_id = arg_1_1:getBody().activityId
	}, 26022, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = Summary.New(arg_2_0)

			getProxy(PlayerProxy):setSummaryInfo(var_2_0)
			arg_1_0:sendNotification(GAME.GET_PLAYER_SUMMARY_INFO_DONE, Clone(var_2_0))
		end

		return
	end)

	return
end

return var_0_0
