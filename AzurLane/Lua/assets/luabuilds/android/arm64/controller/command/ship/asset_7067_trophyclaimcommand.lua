class = var_0_10000

local var_0_0 = "TrophyClaimCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).trophyID

	getProxy = var_1_0
	CollectionProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	pg = var_1_10005

	local var_1_3 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 17301, {
		id = var_1_1
	}, 17302, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = arg_2_0.timestamp
			local var_2_1 = var_1_2

			var_2.updateTrophyClaim(var_2_1, var_1_1, var_2_0)

			local var_2_2 = {}

			ipairs = var_2_10003

			for iter_2_0, iter_2_1 in var_2_10003(arg_2_0.next) do
				local var_2_3 = #var_2_2 + 1

				Trophy = var_2_10009
				var_2_2[var_2_3] = var_2_10009.New(iter_2_1)
			end

			local var_2_4 = var_1_2

			var_3.unlockNewTrophy(var_2_4, var_2_2)

			local var_2_5 = arg_1_0
			local var_2_6 = var_3.sendNotification

			GAME = var_6

			var_2_6(var_2_5, var_6.TROPHY_CLAIM_DONE, {
				trophyID = var_1_1
			})

			local var_2_7 = var_1_2

			var_3.updateTrophy(var_2_7)
		end

		return
	end)

	return
end

return var_0_1
