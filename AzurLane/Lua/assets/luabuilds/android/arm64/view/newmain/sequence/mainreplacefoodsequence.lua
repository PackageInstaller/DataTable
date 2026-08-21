local var_0_0 = class("MainReplaceFoodSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(ActivityProxy):getActiveBannerByType(GAMEUI_BANNER_10)

	if var_1_0 then
		arg_1_0:Repalce(var_1_0, arg_1_1)
	else
		arg_1_0:Revert()
		arg_1_1()
	end

	return
end

function var_0_0.Repalce(arg_2_0, arg_2_1, arg_2_2)
	if var_0_0.backUp then
		arg_2_2()

		return
	end

	local var_2_0

	coroutine.wrap(function()
		onNextTick(var_2_0)
		coroutine.yield()

		var_0_0.backUp = {
			icon = pg.item_data_statistics[50004].icon,
			name = pg.item_data_statistics[50004].name,
			display = pg.item_data_statistics[50004].display
		}

		onNextTick(var_2_0)
		coroutine.yield()

		pg.item_data_statistics[50004].icon = "Props/" .. arg_2_1.pic

		local var_3_0 = string.split(arg_2_1.param, "|")

		pg.item_data_statistics[50004].name = var_3_0[1]
		pg.item_data_statistics[50004].display = var_3_0[2]
		pg.benefit_buff_template[1].icon = "Props/" .. arg_2_1.pic

		arg_2_2()

		return
	end)()

	return
end

function var_0_0.Revert(arg_4_0)
	if var_0_0.backUp then
		pg.item_data_statistics[50004].icon = var_0_0.backUp.icon
		pg.item_data_statistics[50004].name = var_0_0.backUp.name
		pg.item_data_statistics[50004].display = var_0_0.backUp.display
		pg.benefit_buff_template[1].icon = var_0_0.backUp.icon
		var_0_0.backUp = nil
	end

	return
end

return var_0_0
