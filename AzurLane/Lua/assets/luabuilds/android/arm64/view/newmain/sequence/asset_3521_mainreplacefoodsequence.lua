class = var_0_10000

local var_0_0 = var_0_10000("MainReplaceFoodSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)
	local var_1_1 = var_2.getActiveBannerByType

	GAMEUI_BANNER_10 = var_1_10005

	if var_1_1(var_1_0, var_1_10005) then
		arg_1_0:Repalce(var_2, arg_1_1)
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

	coroutine = var_1_10004

	var_1_10004.wrap(function()
		onNextTick = var_2_10000

		var_2_10000(var_2_0)

		coroutine = var_2_10000

		var_2_10000.yield()

		pg = var_0

		local var_3_0 = var_0.item_data_statistics[50004]
		local var_3_1 = var_0_0

		var_3_1.backUp = {
			icon = var_3_0.icon,
			name = var_3_0.name,
			display = var_3_0.display
		}
		onNextTick = var_3_1

		var_3_1(var_2_0)

		coroutine = var_3_1

		var_3_1.yield()

		var_3_0.icon = "Props/" .. arg_2_1.pic
		string = var_1
		var_3_0.name = var_1.split(arg_2_1.param, "|")[1]
		var_3_0.display = var_1[2]
		pg = var_2
		var_2.benefit_buff_template[1].icon = "Props/" .. arg_2_1.pic

		arg_2_2()

		return
	end)()

	return
end

function var_0_0.Revert(arg_4_0)
	if var_0_0.backUp then
		pg = var_1

		local var_4_0 = var_1.item_data_statistics[50004]

		var_4_0.icon = var_0_0.backUp.icon
		var_4_0.name = var_0_0.backUp.name
		var_4_0.display = var_0_0.backUp.display
		pg = var_2
		var_2.benefit_buff_template[1].icon = var_0_0.backUp.icon
		var_0_0.backUp = nil
	end

	return
end

return var_0_0
