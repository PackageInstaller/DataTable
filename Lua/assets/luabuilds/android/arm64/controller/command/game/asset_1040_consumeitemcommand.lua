local ConsumeItemCommand = class("ConsumeItemCommand", pm.SimpleCommand)

function ConsumeItemCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if var_1_0.type == DROP_TYPE_RESOURCE then
		local var_1_1 = id2res(var_1_0.id)

		assert(var_1_1, "res should be defined: " .. var_1_0.id)

		local var_1_2 = getProxy(PlayerProxy)
		local var_1_3 = var_1_2:getData()

		var_1_3:consume({
			[var_1_1] = var_1_0.count
		})
		var_1_2:updatePlayer(var_1_3)
	elseif var_1_0.type == DROP_TYPE_ITEM then
		getProxy(BagProxy):removeItemById(var_1_0.id, var_1_0.count)
	elseif var_1_0.type == DROP_TYPE_ISLAND_ITEM then
		getProxy(IslandProxy):GetIsland():GetInventoryAgency():RemoveItem(var_1_0.id, var_1_0.count)
	else
		assert(false, "no support for type --" .. var_1_0.type)
	end

	return
end

return ConsumeItemCommand
