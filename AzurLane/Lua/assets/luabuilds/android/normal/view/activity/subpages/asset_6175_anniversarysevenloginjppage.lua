class = var_0_10000

local var_0_0 = "AnniversarySevenLoginJPPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.LoginTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	setActive = var_1_10001

	var_1_10001(arg_1_0.item, false)

	local var_1_0 = arg_1_0.itemList

	var_1.make(var_1_0, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_2_2:Find("item")
			local var_2_1 = arg_1_0.config.front_drops[arg_2_1 + 1]
			local var_2_2 = {
				type = var_2_1[1],
				id = var_2_1[2],
				count = var_2_1[3]
			}

			updateDrop = var_6

			var_6(var_2_0, var_2_2)

			onButton = var_6

			local var_2_3 = arg_1_0
			local var_2_4 = arg_2_2

			local function var_2_5()
				local var_3_0 = arg_1_0
				local var_3_1 = var_0.emit

				BaseUI = var_3_10002

				var_3_1(var_3_0, var_3_10002.ON_DROP, var_2_2)

				return
			end

			SFX_PANEL = var_2_10010

			var_6(var_2_3, var_2_4, var_2_5, var_2_10010)

			local var_2_6 = arg_2_2
			local var_2_7 = arg_2_2.Find(var_2_6, "got")

			setActive = var_2_6

			var_2_6(var_2_7, arg_2_1 < arg_1_0.nday)
		end

		return
	end)

	setActive = var_1

	local var_1_1 = arg_1_0.bg

	var_1(var_2.Find(var_1_1, "btn_more"), false)

	onButton = var_1

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bg
	local var_1_4 = var_3.Find(var_1_3, "btn_more")

	local function var_1_5()
		Application = var_2_10000

		local var_4_0 = var_2_10000.OpenURL
		local var_4_1 = arg_1_0.activity

		var_4_0(var_1.getConfig(var_4_1, "config_client")[1])

		return
	end

	SFX_CONFIRM = var_5

	var_1(var_1_2, var_1_4, var_1_5, var_5)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	var_0_1.super.OnUpdateFlush(arg_5_0)

	setText = var_1

	local var_5_0 = arg_5_0.bg

	var_1(var_2.Find(var_5_0, "Text"), arg_5_0.nday .. "/" .. arg_5_0.Day)

	return
end

return var_0_1
