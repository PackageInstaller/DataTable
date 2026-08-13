class = var_0_10000

local var_0_0 = "IslandShareSignInCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	IslandProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_3.GetIsland(var_1_2)
	local var_1_4 = var_3.GetAccessAgency(var_1_3)
	local var_1_5 = var_4.HasOpenFlag

	IslandConst = var_1_10007

	local var_1_6 = not var_1_5(var_1_4, var_1_10007.OPEN_SIGNIN)
	local var_1_7 = {}
	local var_1_8 = {}

	if var_1_6 then
		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_1_9 = var_1_7

		IslandConst = var_1_10011

		var_1_10009(var_1_9, var_1_10011.OPEN_SIGNIN)
	else
		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_1_10 = var_1_8

		IslandConst = var_1_10011

		var_1_10009(var_1_10, var_1_10011.OPEN_SIGNIN)
	end

	pg = var_1_10009

	local var_1_11 = var_1_10009.ConnectionMgr.GetInstance()

	var_9.Send(var_1_11, 21002, {
		open_flag = var_1_7,
		close_flag = var_1_8
	}, 21003, function(arg_2_0)
		local var_2_5

		if arg_2_0.result == 0 then
			ipairs = var_2_5

			for iter_2_0, iter_2_1 in var_2_5(var_1_7) do
				local var_2_0 = var_0
				local var_2_1 = var_6.AddOpenFlag

				IslandConst = var_2_10008

				var_2_1(var_2_0, var_2_10008.OPEN_SIGNIN)
			end

			ipairs = var_2_5

			for iter_2_2, iter_2_3 in var_2_5(var_1_8) do
				local var_2_2 = var_0
				local var_2_3 = var_6.RemoveOpenFlag

				IslandConst = var_2_10008

				var_2_3(var_2_2, var_2_10008.OPEN_SIGNIN)
			end

			local var_2_4 = arg_1_0

			var_2_5 = var_2_5.sendNotification
			GAME = var_2_10003

			var_2_5(var_2_4, var_2_10003.ISLAND_SIGN_SHARE_SIGNIN_DONE)

			pg = var_2_5

			local var_2_6 = var_2_5.TipsMgr.GetInstance()

			var_2_5 = var_2_5.ShowTips
			i18n = var_2_10003

			var_2_5(var_2_6, var_2_10003("island_share_gift_success"))

			pg = var_2_5

			local var_2_7 = var_2_5.GameTrackerMgr.GetInstance()

			var_2_5 = var_2_5.Record
			GameTrackerBuilder = var_2_10003

			var_2_5(var_2_7, var_2_10003.BuildIslandShareSignIn())
		else
			pg = var_2_5

			local var_2_8 = var_2_5.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_9(var_2_8, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
