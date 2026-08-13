class = var_0_10000

local var_0_0 = "IslandShareSignInCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = var_3.GetIsland(var_1_1)
	local var_1_3 = var_3.GetAccessAgency(var_1_2)
	local var_1_4 = var_4.HasOpenFlag

	IslandConst = var_1_10008

	local var_1_5 = not var_1_4(var_1_3, var_1_10008.OPEN_SIGNIN)
	local var_1_6 = {}
	local var_1_7 = {}

	if var_1_5 then
		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_1_8 = var_1_6

		IslandConst = var_1_10012

		var_1_10009(var_1_8, var_1_10012.OPEN_SIGNIN)
	else
		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_1_9 = var_1_7

		IslandConst = var_1_10012

		var_1_10009(var_1_9, var_1_10012.OPEN_SIGNIN)
	end

	pg = var_1_10009

	local var_1_10 = var_1_10009.ConnectionMgr.GetInstance()

	var_9.Send(var_1_10, 21002, {
		open_flag = var_1_6,
		close_flag = var_1_7
	}, 21003, function(arg_2_0)
		local var_2_5

		if arg_2_0.result == 0 then
			ipairs = var_2_5

			for iter_2_2, iter_2_1 in var_2_5(var_1_6) do
				local var_2_0 = var_0
				local var_2_1 = var_6.AddOpenFlag

				IslandConst = var_2_10009

				var_2_1(var_2_0, var_2_10009.OPEN_SIGNIN)
			end

			ipairs = var_2_5

			for iter_2_2, iter_2_3 in var_2_5(var_1_7) do
				local var_2_2 = var_0
				local var_2_3 = var_6.RemoveOpenFlag

				IslandConst = var_2_10009

				var_2_3(var_2_2, var_2_10009.OPEN_SIGNIN)
			end

			local var_2_4 = arg_1_0

			var_2_5 = var_2_5.sendNotification
			GAME = iter_2_2

			var_2_5(var_2_4, iter_2_2.ISLAND_SIGN_SHARE_SIGNIN_DONE)

			pg = var_2_5

			local var_2_6 = var_2_5.TipsMgr.GetInstance()

			var_2_5 = var_2_5.ShowTips
			i18n = iter_2_2

			var_2_5(var_2_6, iter_2_2("island_share_gift_success"))

			pg = var_2_5

			local var_2_7 = var_2_5.GameTrackerMgr.GetInstance()

			var_2_5 = var_2_5.Record
			GameTrackerBuilder = iter_2_2

			var_2_5(var_2_7, iter_2_2.BuildIslandShareSignIn())
		else
			pg = var_2_5

			local var_2_8 = var_2_5.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			ERROR_MESSAGE = iter_2_2

			var_2_9(var_2_8, iter_2_2[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
