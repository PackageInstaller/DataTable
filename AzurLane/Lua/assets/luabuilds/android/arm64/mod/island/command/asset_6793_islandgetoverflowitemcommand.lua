class = var_0_10000

local var_0_0 = "IslandGetOverFlowItemCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 21006, {
		type = 0
	}, 21007, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = #arg_2_0.item_list

			if 0 < var_2_0 then
				var_2_0 = {}
				getProxy = var_2
				IslandProxy = var_2_10004
				var_2_10004 = var_2(var_2_10004)

				local var_2_1 = var_2.GetIsland(var_2_10004)
				local var_2_2 = var_2.GetInventoryAgency(var_2_1)

				ipairs = var_2_10004

				for iter_2_0, iter_2_1 in var_2_10004(arg_2_0.item_list) do
					local var_2_3 = {}

					DROP_TYPE_ISLAND_ITEM = var_2_10010
					var_2_3.type = var_2_10010
					var_2_3.id = iter_2_1.id
					var_2_3.count = iter_2_1.num

					var_2_2:RemoveOverflowItem(iter_2_1.id, iter_2_1.num)

					table = var_2_10010

					var_2_10010.insert(var_2_0, var_2_3)
				end

				IslandDropHelper = var_2_10004
				var_2_10004 = var_2_10004.AddItems({
					drop_list = var_2_0
				})

				local var_2_4 = arg_1_0
				local var_2_5 = var_5.sendNotification

				GAME = iter_2_1

				var_2_5(var_2_4, iter_2_1.ISLAND_GET_OVERFLOW_ITEM_DOME, {
					awards = var_2_10004.awards
				})
			end
		else
			pg = var_2_0

			local var_2_6 = var_2_0.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_7(var_2_6, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
