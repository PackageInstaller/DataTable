local var_0_0 = class("TrophyClaimCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(CollectionProxy)

	pg.ConnectionMgr.GetInstance():Send(17301, {
		id = arg_1_1:getBody().trophyID
	}, 17302, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_0:updateTrophyClaim(var_0, arg_2_0.timestamp)

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.next) do
				({})[#{} + 1] = Trophy.New(iter_2_1)
			end

			var_1_0:unlockNewTrophy({})
			arg_1_0:sendNotification(GAME.TROPHY_CLAIM_DONE, {
				trophyID = var_0
			})
			var_1_0:updateTrophy()
		end

		return
	end)

	return
end

return var_0_0
