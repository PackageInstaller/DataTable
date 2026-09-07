local Challenge2InfoRequestCommand = class("Challenge2InfoRequestCommand", pm.SimpleCommand)

function Challenge2InfoRequestCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE)
	local var_1_2 = getProxy(ChallengeProxy)

	if not var_1_1 or var_1_1:isEnd() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(24004, {
		activity_id = var_1_1.id
	}, 24005, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2:updateSeasonChallenge(arg_2_0.current_challenge)

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.user_challenge) do
				var_1_2:updateCurrentChallenge(iter_2_1)
			end

			if var_1_0 then
				var_1_0()
			end

			self:sendNotification(GAME.CHALLENGE2_INFO_DONE)
		else
			originalPrint("reqquest challenge info fail, data.result: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return Challenge2InfoRequestCommand
