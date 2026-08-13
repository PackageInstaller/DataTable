class = var_0_10000

local var_0_0 = "ConsumeItemCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).type

	DROP_TYPE_RESOURCE = var_1_0

	if var_1_1 == var_1_0 then
		id2res = var_1_1

		local var_1_2 = var_1_1(var_2.id)

		assert = var_1_0

		var_1_0(var_1_2, "res should be defined: " .. var_2.id)

		getProxy = var_1_0
		PlayerProxy = var_6

		local var_1_3 = var_1_0(var_6)
		local var_1_4 = var_1_0.getData(var_1_3)

		var_1_10005.consume(var_1_4, {
			[var_1_2] = var_2.count
		})
		var_1_0:updatePlayer(var_1_10005)
	else
		local var_1_5 = var_2.type

		DROP_TYPE_ITEM = var_1_0

		if var_1_5 == var_1_0 then
			getProxy = var_1_5
			BagProxy = var_1_10005

			local var_1_6 = var_1_5(var_1_10005)

			var_3.removeItemById(var_1_6, var_2.id, var_2.count)
		else
			local var_1_7 = var_2.type

			DROP_TYPE_ISLAND_ITEM = var_1_0

			if var_1_7 == var_1_0 then
				getProxy = var_1_7
				IslandProxy = var_1_10005

				local var_1_8 = var_1_7(var_1_10005)
				local var_1_9 = var_1_7.GetIsland(var_1_8)
				local var_1_10 = var_1_7.GetInventoryAgency(var_1_9)

				var_4.RemoveItem(var_1_10, var_2.id, var_2.count)
			else
				assert = var_1_7

				var_1_7(false, "no support for type --" .. var_2.type)
			end
		end
	end

	return
end

return var_0_1
