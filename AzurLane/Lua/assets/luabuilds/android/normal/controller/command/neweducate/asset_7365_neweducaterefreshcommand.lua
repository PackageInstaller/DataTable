class = var_0_10000

local var_0_0 = "NewEducateRefreshCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.difficulty
	local var_1_2 = var_2.callback

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 29092, {
		id = var_1_0,
		difficulty = var_1_1
	}, 29093, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			NewEducateProxy = var_2_10002

			local var_2_0 = var_2_2(var_2_10002)

			var_2_2.RefreshChar(var_2_0, var_1_0, arg_2_0.tb)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_3

			var_2_2(var_2_1, var_3.NEW_EDUCATE_REFRESH_DONE, {
				id = var_1_0
			})

			existCall = var_2_2

			var_2_2(var_1_2)
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_3, "NewEducate_Refresh: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
