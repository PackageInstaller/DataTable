local MiniGameShopFlushCommand = class("MiniGameShopFlushCommand", pm.SimpleCommand)

function MiniGameShopFlushCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(26154, {
		type = 0
	}, 26155, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(ShopsProxy):getMiniShop()

			var_2_0:setNextTime(arg_2_0.next_flash_time[1])
			getProxy(ShopsProxy):setMiniShop(var_2_0)
		end

		if var_1_1 then
			var_1_1(arg_2_0.result == 0)
		end

		return
	end)

	return
end

return MiniGameShopFlushCommand
