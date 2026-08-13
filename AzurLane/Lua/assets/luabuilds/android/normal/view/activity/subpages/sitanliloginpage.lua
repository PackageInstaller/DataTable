class = var_0_10000

local var_0_0 = "SitanliLoginPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.LoginTemplatePage"))

function var_0_1.OnDataSetting(arg_1_0)
	pg = var_1_10001

	local var_1_0 = var_1_10001.activity_7_day_sign
	local var_1_1 = arg_1_0.activity

	arg_1_0.config = var_1_0[var_2.getConfig(var_1_1, "config_id")]
	arg_1_0.Day = 14

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	setActive = var_1_10001

	var_1_10001(arg_2_0.item, false)

	local var_2_0 = arg_2_0.itemList

	var_1.make(var_2_0, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		local var_3_0

		if arg_3_0 == var_2_10003.EventInit then
			var_3_0 = arg_3_2:Find("item")

			local var_3_1 = arg_2_0.config.front_drops[arg_3_1 + 1]
			local var_3_2 = {
				type = var_3_1[1],
				id = var_3_1[2],
				count = var_3_1[3]
			}

			updateDrop = var_6

			var_6(var_3_0, var_3_2)

			onButton = var_6

			local var_3_3 = arg_2_0
			local var_3_4 = arg_3_2

			local function var_3_5()
				local var_4_0 = arg_2_0
				local var_4_1 = var_0.emit

				BaseUI = var_3_10002

				var_4_1(var_4_0, var_3_10002.ON_DROP, var_3_2)

				return
			end

			SFX_PANEL = var_2_10010

			var_6(var_3_3, var_3_4, var_3_5, var_2_10010)
		else
			UIItemList = var_3_0

			if arg_3_0 == var_3_0.EventUpdate then
				local var_3_6 = arg_3_2
				local var_3_7 = arg_3_2.Find(var_3_6, "got")

				setActive = var_3_6

				var_3_6(var_3_7, arg_3_1 < arg_2_0.nday)
			end
		end

		return
	end)

	return
end

return var_0_1
