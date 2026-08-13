class = var_0_10000

local var_0_0 = "IslandSignInInvitationCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1:getBody().list then
		var_1_0 = {}
	end

	getProxy = var_1_10004
	IslandProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.GetIsland(var_1_1)
	local var_1_3 = var_4.GetSignInAgency(var_1_2)

	_ = var_1_2

	if #var_1_2.select(var_1_0, function(arg_2_0)
		local var_2_0 = var_1_3

		return not var_1.IsInvited(var_2_0, arg_2_0)
	end) == 0 then
		return
	end

	pg = var_7

	local var_1_4 = var_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 21312, {
		friend_list = var_6
	}, 21313, function(arg_3_0)
		local var_3_2

		if arg_3_0.result == 0 then
			ipairs = var_3_2

			for iter_3_0, iter_3_1 in var_3_2(var_0) do
				local var_3_0 = var_1_3

				var_6.AddInviter(var_3_0, iter_3_1)
			end

			local var_3_1 = arg_1_0

			var_3_2 = var_3_2.sendNotification
			GAME = var_2_10003

			var_3_2(var_3_1, var_2_10003.ISLAND_SIGN_IN_INVITATION_DONE)

			pg = var_3_2

			local var_3_3 = var_3_2.TipsMgr.GetInstance()

			var_3_2 = var_3_2.ShowTips
			i18n = var_2_10003

			var_3_2(var_3_3, var_2_10003("island_invitation_gift_success"))

			pg = var_3_2

			local var_3_4 = var_3_2.GameTrackerMgr.GetInstance()

			var_3_2 = var_3_2.Record
			GameTrackerBuilder = var_2_10003

			var_3_2(var_3_4, var_2_10003.BuildIslandInvitation(var_0))
		else
			pg = var_3_2

			local var_3_5 = var_3_2.TipsMgr.GetInstance()
			local var_3_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_3_6(var_3_5, var_2_10003[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

return var_0_1
