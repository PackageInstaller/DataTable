class = var_0_10000

local var_0_0 = "IslandSetAccessAuthorityCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().openList
	local var_1_1 = var_2.closeList

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 21002, {
		open_flag = var_1_0,
		close_flag = var_1_1
	}, 21003, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			IslandProxy = var_2_10003

			local var_2_0 = var_2_2(var_2_10003)
			local var_2_1 = var_2_2.GetIsland(var_2_0)

			var_2_2 = var_2_2.GetAccessAgency(var_2_1)
			ipairs = var_2_10002

			for iter_2_0, iter_2_1 in var_2_10002(var_1_1) do
				var_2_2:RemoveOpenFlag(iter_2_1)
			end

			ipairs = var_2

			for iter_2_2, iter_2_3 in var_2(var_1_0) do
				var_2_2:AddOpenFlag(iter_2_3)
			end

			var_2_10004 = arg_1_0

			local var_2_3 = var_2.sendNotification

			GAME = iter_2_2

			var_2_3(var_2_10004, iter_2_2.ISLAND_SET_ACCESS_TYPE_DONE)
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_5(var_2_4, var_2_10004[arg_2_0.result] .. arg_2_0.ret)
		end

		return
	end)

	return
end

return var_0_1
