local Challenge2ResetRequestCommand = class("Challenge2ResetRequestCommand", pm.SimpleCommand)

function Challenge2ResetRequestCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().mode
	local var_1_1 = arg_1_1:getBody().isInfiniteSeasonClear
	local var_1_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CHALLENGE)

	if not var_1_2 or var_1_2:isEnd() then
		return
	end

	local var_1_3 = getProxy(ChallengeProxy)

	pg.ConnectionMgr.GetInstance():Send(24011, {
		activity_id = var_1_2.id,
		mode = var_1_0
	}, 24012, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_3:getUserChallengeInfoList()[var_1_0] = nil

			if var_1_1 == true then
				var_1_3:setCurMode(ChallengeProxy.MODE_CASUAL)
			end

			self:sendNotification(GAME.CHALLENGE2_RESET_DONE)
		end

		return
	end)

	return
end

return Challenge2ResetRequestCommand
