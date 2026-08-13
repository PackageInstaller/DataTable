class = var_0_10000

local var_0_0 = "GetMilitaryShopCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() and var_2.callback

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 18100, {
		type = 0
	}, 18101, function(arg_2_0)
		MeritorousShop = var_2_10001

		local var_2_0 = var_2_10001.New({
			id = 1,
			good_list = arg_2_0.arena_shop_list,
			refreshCount = arg_2_0.flash_count,
			nextTime = arg_2_0.next_flash_time
		})

		getProxy = var_2
		ShopsProxy = var_3

		local var_2_1 = var_2(var_3)

		var_2.addMeritorousShop(var_2_1, var_2_0)

		if var_1_0 then
			var_1_0(var_2_0)
		end

		local var_2_2 = arg_1_0
		local var_2_3 = var_3.sendNotification

		GAME = var_5

		local var_2_4 = var_5.GET_MILITARY_SHOP_DONE

		Clone = var_2_10006

		var_2_3(var_2_2, var_2_4, var_2_10006(var_2_0))

		return
	end)

	return
end

return var_0_1
