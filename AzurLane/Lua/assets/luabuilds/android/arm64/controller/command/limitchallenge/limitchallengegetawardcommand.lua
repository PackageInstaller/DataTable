local var_0_0 = class("LimitChallengeGetAwardCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(24022, {
		challengeids = arg_1_1:getBody().challengeIDList
	}, 24023, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(LimitChallengeProxy)

			for iter_2_0, iter_2_1 in ipairs(var_0.challengeIDList) do
				var_2_0:setAwarded(iter_2_1)
			end

			pg.m02:sendNotification(LimitChallengeConst.GET_CHALLENGE_AWARD_DONE, {
				awards = PlayerConst.addTranDrop(arg_2_0.drop_list)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
