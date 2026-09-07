local UseAddShipExpCommand = class("UseAddShipExpCommand", pm.SimpleCommand)

function UseAddShipExpCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = {}
	local var_1_3 = 0

	for iter_1_0, iter_1_1 in pairs(var_1_0.items) do
		if iter_1_1 > 0 then
			table.insert(var_1_2, {
				id = iter_1_0,
				num = iter_1_1
			})

			var_1_3 = var_1_3 + tonumber(Item.getConfigData(iter_1_0).usage_arg) * iter_1_1
		end
	end

	pg.ConnectionMgr.GetInstance():Send(22011, {
		ship_id = var_1_0.id,
		books = var_1_2
	}, 22012, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(BayProxy)
			local var_2_1 = var_2_0:getShipById(var_1_1)

			var_2_1:addExp(var_1_3)
			var_2_0:updateShip(var_2_1)

			local var_2_2 = getProxy(BagProxy)

			for iter_2_0, iter_2_1 in pairs(var_1_0.items) do
				if iter_2_1 > 0 then
					var_2_2:removeItemById(iter_2_0, iter_2_1)
				end
			end

			self:sendNotification(GAME.USE_ADD_SHIPEXP_ITEM_DONE, {
				id = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return UseAddShipExpCommand
