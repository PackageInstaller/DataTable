class = var_0_10000

local var_0_0 = "IslandCheaterOperateCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type
	local var_1_1 = var_2.arg_list

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 23103, {
		type = var_1_0,
		arg_list = var_1_1
	}, 23104, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			switch = var_2_2

			local var_2_0 = var_1_0

			var_2_10003 = {}
			IslandCheaterTavernConst = var_2_10004
			var_2_10003[var_2_10004.PlayerOperateType.PutCard] = function()
				getProxy = var_3_10000
				IslandProxy = var_3_10001

				local var_3_0 = var_3_10000(var_3_10001)
				local var_3_1 = var_0.GetIsland(var_3_0)
				local var_3_2 = var_0.GetCheaterTavernAgency(var_3_1)

				var_0.MainPlayerPutCard(var_3_2, var_1_1)

				return
			end
			IslandCheaterTavernConst = var_4
			var_2_10003[var_4.PlayerOperateType.Query] = function()
				return
			end
			IslandCheaterTavernConst = var_4
			var_2_10003[var_4.PlayerOperateType.Shoot] = function()
				return
			end

			var_2_2(var_2_0, var_2_10003)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10003

			var_2_2(var_2_1, var_2_10003.ISLAND_PLAYER_CHEATER_OPERATE_DONE, {
				type = var_1_0,
				arg_list = var_1_1
			})
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_4(var_2_3, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end, false)

	return
end

return var_0_1
