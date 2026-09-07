local GetMilitaryShopCommand = class("GetMilitaryShopCommand", pm.SimpleCommand)

function GetMilitaryShopCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(18100, {
		type = 0
	}, 18101, function(arg_2_0)
		local var_2_0 = MeritorousShop.New({
			id = 1,
			good_list = arg_2_0.arena_shop_list,
			refreshCount = arg_2_0.flash_count,
			nextTime = arg_2_0.next_flash_time
		})

		getProxy(ShopsProxy):addMeritorousShop(var_2_0)

		if var_1_1 then
			var_1_1(var_2_0)
		end

		self:sendNotification(GAME.GET_MILITARY_SHOP_DONE, Clone(var_2_0))

		return
	end)

	return
end

return GetMilitaryShopCommand
