class = var_0_10000

local var_0_0 = "IslandSendDressColorCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.dress_id
	local var_1_2 = var_2.color_id

	getProxy = var_1_10006
	IslandProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)
	local var_1_4 = var_6.GetIsland(var_1_3)

	pg = var_1_3

	local var_1_5 = var_1_3.ConnectionMgr.GetInstance()

	var_7.Send(var_1_5, 21628, {
		id = var_1_0,
		dress_id = var_1_1,
		color_id = var_1_2
	}, 21629, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			if var_1_0 == 0 then
				local var_2_0 = var_1_4

				var_2_10003 = var_2_2.GetDressUpAgency(var_2_0)

				var_2_2.AddDressColor(var_2_10003, var_1_1, var_1_2)
			end

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10003

			var_2_2(var_2_1, var_2_10003.ISLAND_BUY_ROLE_DRESS_COLOR_DONE)
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_4(var_2_3, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
