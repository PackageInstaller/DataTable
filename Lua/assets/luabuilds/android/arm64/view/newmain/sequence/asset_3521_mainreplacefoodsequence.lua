local MainReplaceFoodSequence = class("MainReplaceFoodSequence")

function MainReplaceFoodSequence:Execute(arg_1_1)
	local var_1_0 = getProxy(ActivityProxy):getActiveBannerByType(GAMEUI_BANNER_10)

	if var_1_0 then
		self:Repalce(var_1_0, arg_1_1)
	else
		self:Revert()
		arg_1_1()
	end

	return
end

function MainReplaceFoodSequence:Repalce(arg_2_1, arg_2_2)
	if MainReplaceFoodSequence.backUp then
		arg_2_2()

		return
	end

	local var_2_0

	var_2_0 = coroutine.wrap(function()
		onNextTick(var_2_0)
		coroutine.yield()

		MainReplaceFoodSequence.backUp = {
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
	end)

	;(nil)()

	return
end

function MainReplaceFoodSequence:Revert()
	if MainReplaceFoodSequence.backUp then
		pg.item_data_statistics[50004].icon = MainReplaceFoodSequence.backUp.icon
		pg.item_data_statistics[50004].name = MainReplaceFoodSequence.backUp.name
		pg.item_data_statistics[50004].display = MainReplaceFoodSequence.backUp.display
		pg.benefit_buff_template[1].icon = MainReplaceFoodSequence.backUp.icon
		MainReplaceFoodSequence.backUp = nil
	end

	return
end

return MainReplaceFoodSequence
