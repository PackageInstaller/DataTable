class = var_0_10000

local var_0_0 = "FourthAnniversarySignPageKR"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.LoginTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_1, "item")

	local var_1_2 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_2, "mask/items")
	UIItemList = var_1
	arg_1_0.itemList = var_1.New(arg_1_0.items, arg_1_0.item)
	arg_1_0.initItems = {}

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	setActive = var_1_10001

	var_1_10001(arg_2_0.item, false)

	local var_2_0 = arg_2_0.itemList

	var_1.make(var_2_0, function(arg_3_0, arg_3_1, arg_3_2)
		UIItemList = var_2_10003

		if arg_3_0 == var_2_10003.EventUpdate then
			table = var_3

			if not var_3.contains(arg_2_0.initItems, arg_3_1) then
				local var_3_0 = arg_3_2:Find("item")

				var_2_10004 = arg_2_0.config.front_drops[arg_3_1 + 1]

				local var_3_1 = {
					type = var_2_10004[1],
					id = var_2_10004[2],
					count = var_2_10004[3]
				}

				updateDrop = var_6

				var_6(var_3_0, var_3_1)

				onButton = var_6

				local var_3_2 = arg_2_0
				local var_3_3 = arg_3_2

				local function var_3_4()
					local var_4_0 = arg_2_0
					local var_4_1 = var_0.emit

					BaseUI = var_3_10003

					var_4_1(var_4_0, var_3_10003.ON_DROP, var_3_1)

					return
				end

				SFX_PANEL = var_2_10011

				var_6(var_3_2, var_3_3, var_3_4, var_2_10011)

				table = var_6

				var_6.insert(arg_2_0.initItems, arg_3_1)
			end

			local var_3_5 = arg_3_2:Find("got")

			setActive = var_2_10004

			var_2_10004(var_3_5, arg_3_1 < arg_2_0.nday)
		end

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	var_0_1.super.OnUpdateFlush(arg_5_0)

	eachChild = var_1

	var_1(arg_5_0.items, function(arg_6_0)
		return
	end)

	return
end

return var_0_1
