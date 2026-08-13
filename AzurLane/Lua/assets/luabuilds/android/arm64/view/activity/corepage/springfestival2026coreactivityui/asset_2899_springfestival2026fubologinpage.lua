class = var_0_10000

local var_0_0 = "SpringFestival2026FuboLoginPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_1, "items")

	local var_1_2 = arg_1_0.bg

	arg_1_0.item = var_1.GetChild(var_1_2, 0)
	UIItemList = var_1
	arg_1_0.itemList = var_1.New(arg_1_0.items, arg_1_0.item)

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.activity_7_day_sign
	local var_2_1 = arg_2_0.activity

	arg_2_0.config = var_2_0[var_2.getConfig(var_2_1, "config_id")]
	arg_2_0.Day = #arg_2_0.config.front_drops

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	local var_3_0 = arg_3_0.itemList

	var_1.make(var_3_0, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_4_2:Find("container/item")
			local var_4_1 = arg_3_0.config.front_drops[arg_4_1 + 1]

			Drop = var_5

			local var_4_2 = var_5.Create(var_4_1)

			updateDrop = var_6

			var_6(var_4_0, var_4_2)

			onButton = var_6

			local var_4_3 = arg_3_0
			local var_4_4 = arg_4_2

			local function var_4_5()
				local var_5_0 = arg_3_0
				local var_5_1 = var_0.emit

				BaseUI = var_3_10003

				var_5_1(var_5_0, var_3_10003.ON_DROP, var_4_2)

				return
			end

			SFX_PANEL = var_2_10011

			var_6(var_4_3, var_4_4, var_4_5, var_2_10011)

			local var_4_6 = arg_4_2:Find("got")
			local var_4_7 = arg_4_2:Find("container")
			local var_4_8 = var_7.GetComponent

			typeof = var_10
			CanvasGroup = var_2_10012
			var_4_8(var_4_7, var_10(var_2_10012)).alpha = arg_4_1 < arg_3_0.nday and 0.5 or 1
			setActive = var_8

			var_8(var_4_6, arg_4_1 < arg_3_0.nday)
		end

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	arg_6_0.nday = arg_6_0.activity.data1

	local var_6_0 = arg_6_0.itemList

	var_1.align(var_6_0, arg_6_0.Day)

	return
end

return var_0_1
