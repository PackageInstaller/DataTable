class = var_0_10000

local var_0_0 = "ConsumeItemCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type

	DROP_TYPE_RESOURCE = var_1_10004

	if var_1_0 == var_1_10004 then
		id2res = var_1_0

		local var_1_1 = var_1_0(var_2.id)

		assert = var_1_10004

		var_1_10004(var_1_1, "res should be defined: " .. var_2.id)

		getProxy = var_1_10004
		PlayerProxy = var_5

		local var_1_2 = var_1_10004(var_5)
		local var_1_3 = var_1_10004.getData(var_1_2)

		var_5.consume(var_1_3, {
			[var_1_1] = var_2.count
		})
		var_1_10004:updatePlayer(var_5)
	else
		local var_1_4 = var_2.type

		DROP_TYPE_ITEM = var_1_10004

		if var_1_4 == var_1_10004 then
			getProxy = var_1_4
			BagProxy = var_1_10004

			local var_1_5 = var_1_4(var_1_10004)

			var_3.removeItemById(var_1_5, var_2.id, var_2.count)
		else
			local var_1_6 = var_2.type

			DROP_TYPE_ISLAND_ITEM = var_1_10004

			if var_1_6 == var_1_10004 then
				getProxy = var_1_6
				IslandProxy = var_1_10004

				local var_1_7 = var_1_6(var_1_10004)
				local var_1_8 = var_1_6.GetIsland(var_1_7)
				local var_1_9 = var_1_6.GetInventoryAgency(var_1_8)

				var_4.RemoveItem(var_1_9, var_2.id, var_2.count)
			else
				assert = var_1_6

				var_1_6(false, "no support for type --" .. var_2.type)
			end
		end
	end

	return
end

return var_0_1
