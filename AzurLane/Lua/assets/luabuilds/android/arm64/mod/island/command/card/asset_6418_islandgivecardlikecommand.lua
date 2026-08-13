class = var_0_10000

local var_0_0 = "IslandGiveCardLikeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().userId
	local var_1_1 = var_2.callback

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 21334, {
		user_id = var_1_0
	}, 21335, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			existCall = var_2_1

			var_2_1(var_1_1)

			local var_2_0 = arg_1_0

			var_2_1 = var_2_1.sendNotification
			GAME = var_2_10004

			var_2_1(var_2_0, var_2_10004.ISLAND_GIVE_CARD_LIKE_DONE)
		else
			pg = var_2_1

			local var_2_2 = var_2_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_3(var_2_2, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
