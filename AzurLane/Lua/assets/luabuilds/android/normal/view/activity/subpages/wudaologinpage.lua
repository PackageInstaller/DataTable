class = var_0_10000

local var_0_0 = "WudaoLoginPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0._tf

	arg_1_0.labelDay = var_1.Find(var_1_1, "days")

	local var_1_2 = arg_1_0._tf

	arg_1_0.items = var_1.Find(var_1_2, "items")

	local var_1_3 = arg_1_0._tf

	arg_1_0.item = var_1.Find(var_1_3, "item")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.activity_7_day_sign
	local var_2_1 = arg_2_0.activity

	arg_2_0.config = var_2_0[var_2.getConfig(var_2_1, "config_id")]

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	setActive = var_1_10001

	var_1_10001(arg_3_0.item, false)

	for iter_3_0 = 1, 8 do
		cloneTplTo = var_1_10005

		local var_3_0 = arg_3_0.item
		local var_3_1 = arg_3_0.items
		local var_3_2 = var_1_10005(var_3_0, var_7.Find(var_3_1, "layout"))
		local var_3_3 = var_1_10005.Find(var_3_2, "item")
		local var_3_4 = arg_3_0.config.front_drops[iter_3_0]
		local var_3_5 = {
			type = var_3_4[1],
			id = var_3_4[2],
			count = var_3_4[3]
		}

		updateDrop = var_9

		var_9(var_3_3, var_3_5)

		onButton = var_9

		local var_3_6 = arg_3_0
		local var_3_7 = var_1_10005

		local function var_3_8()
			local var_4_0 = arg_3_0
			local var_4_1 = var_0.emit

			BaseUI = var_2_10002

			var_4_1(var_4_0, var_2_10002.ON_DROP, var_3_5)

			return
		end

		SFX_PANEL = var_1_10013

		var_9(var_3_6, var_3_7, var_3_8, var_1_10013)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	for iter_5_0 = 1, 8 do
		local var_5_0 = arg_5_0.items
		local var_5_1 = var_5.Find(var_5_0, "layout")
		local var_5_2 = var_5.GetChild(var_5_1, iter_5_0 - 1)
		local var_5_3 = iter_5_0 <= arg_5_0.activity.data1

		GetImageSpriteFromAtlasAsync = var_7

		local var_5_4 = "ui/activityuipage/wudaologinpage_atlas"

		string = var_1_10009

		var_7(var_5_4, var_1_10009.format("number%d", iter_5_0), var_5_2:Find("day"), true)

		setActive = var_7
		var_1_10009 = var_5_2

		var_7(var_5_2.Find(var_1_10009, "got"), var_5_3)
	end

	return
end

function var_0_1.OnDestroy(arg_6_0)
	clearImageSprite = var_1_10001

	var_1_10001(arg_6_0.bg)

	removeAllChildren = var_1_10001

	var_1_10001(arg_6_0.items)

	return
end

return var_0_1
