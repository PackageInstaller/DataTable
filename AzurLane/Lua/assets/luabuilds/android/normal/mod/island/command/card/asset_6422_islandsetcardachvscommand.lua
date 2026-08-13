class = var_0_10000

local var_0_0 = "IslandSetCardAchvsCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().achvIds
	local var_1_1 = {}

	pg = var_1_10005

	local var_1_2 = var_1_10005.island_achievement

	ipairs = var_1_10006

	for iter_1_0, iter_1_1 in var_1_10006(var_1_0) do
		table = var_1_10011

		var_1_10011.insert(var_1_1, var_1_2[iter_1_1].group)
	end

	pg = var_6

	local var_1_3 = var_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 21338, {
		group_list = var_1_1
	}, 21339, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = arg_1_0

			var_2_1 = var_2_1.sendNotification
			GAME = var_2_10003

			var_2_1(var_2_0, var_2_10003.ISLAND_SET_CARD_ACHVS_DONE, {
				achvIds = var_1_0
			})
		else
			pg = var_2_1

			local var_2_2 = var_2_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_3(var_2_2, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
