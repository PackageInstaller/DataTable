class = var_0_10000

local var_0_0 = "Day7LoginPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "bg")

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

	for iter_3_0 = 1, 7 do
		cloneTplTo = var_1_10005

		local var_3_0 = var_1_10005(arg_3_0.item, arg_3_0.items)
		local var_3_1 = var_1_10005.Find(var_3_0, "item")

		Drop = var_3_0

		local var_3_2 = var_3_0.Create(arg_3_0.config.front_drops[iter_3_0])

		updateDrop = var_8

		var_8(var_3_1, var_3_2)

		onButton = var_8

		local var_3_3 = arg_3_0
		local var_3_4 = var_1_10005

		local function var_3_5()
			local var_4_0 = arg_3_0
			local var_4_1 = var_0.emit

			BaseUI = var_2_10002

			var_4_1(var_4_0, var_2_10002.ON_DROP, var_3_2)

			return
		end

		SFX_PANEL = var_1_10012

		var_8(var_3_3, var_3_4, var_3_5, var_1_10012)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	GetImageSpriteFromAtlasAsync = var_1_10001

	local var_5_0 = "ui/activityuipage/day7_login_atlas"

	string = var_1_10003

	local var_5_1 = var_1_10003.format
	local var_5_2 = "0%d"

	math = var_1_10005

	var_1_10001(var_5_0, var_5_1(var_5_2, var_1_10005.max(arg_5_0.activity.data1, 1)), arg_5_0.labelDay, true)

	for iter_5_0 = 1, 7 do
		local var_5_3 = arg_5_0.items
		local var_5_4 = var_5.GetChild(var_5_3, iter_5_0 - 1)
		local var_5_5 = iter_5_0 <= arg_5_0.activity.data1

		GetImageSpriteFromAtlasAsync = var_7

		local var_5_6 = "ui/activityuipage/day7_login_atlas"

		string = var_1_10009

		var_7(var_5_6, var_1_10009.format("day%d", iter_5_0) .. (var_5_5 and "_sel" or ""), var_5_4:Find("day"), true)

		setActive = var_7
		var_1_10009 = var_5_4

		var_7(var_5_4.Find(var_1_10009, "got"), var_5_5)
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
