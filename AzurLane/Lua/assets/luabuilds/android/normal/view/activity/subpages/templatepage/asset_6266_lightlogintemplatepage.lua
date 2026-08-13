class = var_0_10000

local var_0_0 = "LightLoginTemplatePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.bar = var_1.Find(var_1_1, "bar")

	local var_1_2 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_2, "item")

	local var_1_3 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_3, "items")
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
	setActive = var_1_10001

	var_1_10001(arg_3_0.item, false)

	local var_3_0 = arg_3_0.itemList

	var_1.make(var_3_0, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		local var_4_0

		if arg_4_0 == var_2_10003.EventInit then
			var_2_10004 = arg_4_2
			var_4_0 = arg_4_2.Find(var_2_10004, "item")
			Drop = var_2_10004
			var_2_10004 = var_2_10004.Create(arg_3_0.config.front_drops[arg_4_1 + 1])
			updateDrop = var_5

			var_5(var_4_0, var_2_10004)

			onButton = var_5

			local var_4_1 = arg_3_0
			local var_4_2 = arg_4_2

			local function var_4_3()
				local var_5_0 = arg_3_0
				local var_5_1 = var_0.emit

				BaseUI = var_3_10002

				var_5_1(var_5_0, var_3_10002.ON_DROP, var_2_10004)

				return
			end

			SFX_PANEL = var_2_10009

			var_5(var_4_1, var_4_2, var_4_3, var_2_10009)

			GetImageSpriteFromAtlasAsync = var_5

			var_5("ui/share/light_login_atlas", "DAY" .. arg_4_1 + 1, arg_4_2:Find("day"), true)
		else
			UIItemList = var_4_0

			if arg_4_0 == var_4_0.EventUpdate then
				local var_4_4 = arg_4_1 < arg_3_0.nday

				setActive = var_2_10004

				var_2_10004(arg_4_2:Find("got"), var_4_4)

				setActive = var_2_10004

				var_2_10004(arg_4_2:Find("get"), var_4_4)

				setActive = var_2_10004

				var_2_10004(arg_4_2:Find("bg"), not var_4_4)
			end
		end

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	arg_6_0.nday = arg_6_0.activity.data1

	local var_6_0 = arg_6_0.itemList

	var_1.align(var_6_0, arg_6_0.Day)

	setFillAmount = var_1

	var_1(arg_6_0.bar, arg_6_0.nday / arg_6_0.Day)

	return
end

function var_0_1.OnDestroy(arg_7_0)
	clearImageSprite = var_1_10001

	var_1_10001(arg_7_0.bg)

	removeAllChildren = var_1_10001

	var_1_10001(arg_7_0.items)

	return
end

return var_0_1
