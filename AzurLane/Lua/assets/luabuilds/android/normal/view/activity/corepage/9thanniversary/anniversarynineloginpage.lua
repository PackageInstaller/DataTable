class = var_0_10000

local var_0_0 = "AnniversaryNineLoginPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.templatePage.CoreLoginSignTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.itemGroup = var_1.Find(var_1_1, "bg_item")

	local var_1_2 = arg_1_0.itemGroup

	arg_1_0.item = var_1.Find(var_1_2, "item")

	local var_1_3 = arg_1_0.itemGroup

	arg_1_0.items = var_1.Find(var_1_3, "items")
	UIItemList = var_1
	arg_1_0.itemList = var_1.New(arg_1_0.items, arg_1_0.item)

	local var_1_4 = arg_1_0.bg

	arg_1_0.btnMore = var_1.Find(var_1_4, "btn_more")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	setActive = var_1_10001

	var_1_10001(arg_2_0.item, false)

	local var_2_0 = arg_2_0.itemList

	var_1.make(var_2_0, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			local var_3_0 = arg_3_2:Find("item")
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

			local var_3_6 = arg_3_2
			local var_3_7 = arg_3_2.Find(var_3_6, "got")

			setActive = var_3_6

			var_3_6(var_3_7, arg_3_1 < arg_2_0.nday)
		end

		return
	end)

	onButton = var_1

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.btnMore

	local function var_2_3()
		Application = var_2_10000

		local var_5_0 = var_2_10000.OpenURL
		local var_5_1 = arg_2_0.activity

		var_5_0(var_1.getConfig(var_5_1, "config_client")[1])

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_2_1, var_2_2, var_2_3, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	var_0_1.super.OnUpdateFlush(arg_6_0)

	setText = var_1

	local var_6_0 = arg_6_0.itemGroup

	var_1(var_2.Find(var_6_0, "Text"), arg_6_0.nday .. "/" .. arg_6_0.Day)

	return
end

return var_0_1
