class = var_0_10000

local var_0_0 = "NewServerLogin2Page"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_1, "item")

	local var_1_2 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_2, "scrollrect/items")
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
			var_4_0 = arg_4_2:Find("item")

			local var_4_1 = arg_3_0.config.front_drops[arg_4_1 + 1]
			local var_4_2 = {
				type = var_4_1[1],
				id = var_4_1[2],
				count = var_4_1[3]
			}

			updateDrop = var_6

			var_6(var_4_0, var_4_2)

			onButton = var_6

			local var_4_3 = arg_3_0
			local var_4_4 = arg_4_2

			local function var_4_5()
				local var_5_0 = arg_3_0
				local var_5_1 = var_0.emit

				BaseUI = var_3_10002

				var_5_1(var_5_0, var_3_10002.ON_DROP, var_4_2)

				return
			end

			SFX_PANEL = var_2_10010

			var_6(var_4_3, var_4_4, var_4_5, var_2_10010)

			GetImageSpriteFromAtlasAsync = var_6

			var_6("ui/activityuipage/newserverlogin2page_atlas", arg_4_1 + 1, arg_4_2:Find("day"), true)
		else
			UIItemList = var_4_0

			if arg_4_0 == var_4_0.EventUpdate then
				local var_4_6 = arg_4_2
				local var_4_7 = arg_4_2.Find(var_4_6, "got")

				setActive = var_4_6

				var_4_6(var_4_7, arg_4_1 < arg_3_0.nday)
			end
		end

		return
	end)

	onButton = var_1

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.bg
	local var_3_3 = var_3.Find(var_3_2, "go_btn")

	local function var_3_4()
		pg = var_2_10000

		local var_6_0 = var_2_10000.m02
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_6_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_6_1(var_6_0, var_6_2, var_2_10003.NAVALTACTICS)

		return
	end

	SFX_PANEL = var_5

	var_1(var_3_1, var_3_3, var_3_4, var_5)

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	arg_7_0.nday = arg_7_0.activity.data1

	local var_7_0 = arg_7_0.itemList

	var_1.align(var_7_0, arg_7_0.Day)

	setLocalPosition = var_1

	local var_7_1 = arg_7_0.items

	Vector2 = var_3

	var_1(var_7_1, var_3(-185 - 106 * (arg_7_0.nday - 1), 0))

	return
end

function var_0_1.OnDestroy(arg_8_0)
	clearImageSprite = var_1_10001

	var_1_10001(arg_8_0.bg)

	removeAllChildren = var_1_10001

	var_1_10001(arg_8_0.items)

	return
end

return var_0_1
