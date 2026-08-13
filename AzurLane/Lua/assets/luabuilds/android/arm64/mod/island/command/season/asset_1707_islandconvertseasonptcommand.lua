class = var_0_10000

local var_0_0 = "IslandConvertSeasonPtCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type
	local var_1_1 = var_2.list

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 21014, {
		type = var_1_0,
		item_list = var_1_1
	}, 21015, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			IslandProxy = var_2_10003

			local var_2_0 = var_2_2(var_2_10003)
			local var_2_1 = var_2_2.GetIsland(var_2_0)

			var_2_2 = var_2_2.GetInventoryAgency(var_2_1)

			local var_2_3 = 0

			pg = var_2_1

			local var_2_4 = var_2_1.island_item_data_template

			ipairs = var_2_10004

			for iter_2_0, iter_2_1 in var_2_10004(var_1_1) do
				if var_1_0 == 2 then
					var_2_2:RemoveOverflowItem(iter_2_1.id, iter_2_1.num)
				elseif var_1_0 == 1 then
					var_2_2:RemoveItem(iter_2_1.id, iter_2_1.num)
				end

				if var_2_4[iter_2_1.id].convert == 1 then
					var_2_3 = var_2_3 + var_2_4[iter_2_1.id].pt_num * iter_2_1.num
				end
			end

			var_2_10004 = {}
			ipairs = var_5

			for iter_2_2, iter_2_3 in var_5(arg_2_0.item_list) do
				table = var_2_10010
				var_2_10010 = var_2_10010.insert

				local var_2_5 = var_2_10004
				local var_2_6 = {}

				DROP_TYPE_ISLAND_ITEM = var_2_10014
				var_2_6.type = var_2_10014
				var_2_6.id = iter_2_3.id
				var_2_6.count = iter_2_3.num

				var_2_10010(var_2_5, var_2_6)
			end

			table = var_5

			local var_2_7 = var_5.insert
			local var_2_8 = var_2_10004
			local var_2_9 = {
				id = 0
			}

			VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT = iter_2_3
			var_2_9.type = iter_2_3
			var_2_9.count = var_2_3

			var_2_7(var_2_8, var_2_9)

			IslandDropHelper = var_2_7

			local var_2_10 = var_2_7.AddItems({
				drop_list = var_2_10004
			})
			local var_2_11 = arg_1_0
			local var_2_12 = var_6.sendNotification

			GAME = iter_2_3

			var_2_12(var_2_11, iter_2_3.ISLAND_CONVERT_SEASON_PT_DONE, {
				dropData = var_2_10
			})
		else
			pg = var_2_2

			local var_2_13 = var_2_2.TipsMgr.GetInstance()
			local var_2_14 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_14(var_2_13, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
