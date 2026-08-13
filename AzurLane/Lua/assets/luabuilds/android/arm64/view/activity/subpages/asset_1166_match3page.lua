class = var_0_10000

local var_0_0 = "Match3Page"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_1, "item")

	local var_1_2 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_2, "items")

	local var_1_3 = arg_1_0.bg

	arg_1_0.goBtn = var_1.Find(var_1_3, "go")
	UIItemList = var_1
	arg_1_0.itemList = var_1.New(arg_1_0.items, arg_1_0.item)

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity

	arg_2_0.drop = var_1.getConfig(var_2_0, "config_client").drop

	local var_2_1 = arg_2_0.activity

	arg_2_0.id = var_1.getConfig(var_2_1, "config_client").gameId
	arg_2_0.day = #arg_2_0.drop

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	setActive = var_1_10001

	var_1_10001(arg_3_0.item, false)

	getProxy = var_1_10001
	MiniGameProxy = var_3

	local var_3_0 = var_1_10001(var_3)
	local var_3_1 = var_1.GetHubByHubId
	local var_3_2 = arg_3_0.activity
	local var_3_3 = var_3_1(var_3_0, var_5.getConfig(var_3_2, "config_id"))

	setActive = var_3

	var_3(arg_3_0.item, false)

	local var_3_4 = arg_3_0.itemList

	var_3.make(var_3_4, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		local var_4_0

		if arg_4_0 == var_2_10003.EventInit then
			var_4_0 = arg_4_2:Find("item")

			local var_4_1 = arg_3_0.drop[arg_4_1 + 1]
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

				BaseUI = var_3_10003

				var_5_1(var_5_0, var_3_10003.ON_DROP, var_4_2)

				return
			end

			SFX_PANEL = var_2_10011

			var_6(var_4_3, var_4_4, var_4_5, var_2_10011)
		else
			UIItemList = var_4_0

			if arg_4_0 == var_4_0.EventUpdate then
				local var_4_6 = arg_4_2
				local var_4_7 = arg_4_2.Find(var_4_6, "got")
				local var_4_8 = arg_4_2:Find("mask")

				setActive = var_4_6

				var_4_6(var_4_7, arg_4_1 < var_3_3.usedtime)

				setActive = var_4_6

				var_4_6(var_4_8, arg_4_1 >= var_3_3.usedtime + var_3_3.count)
			end
		end

		return
	end)

	local var_3_5 = arg_3_0.itemList

	var_3.align(var_3_5, arg_3_0.day)

	onButton = var_3

	var_3(arg_3_0, arg_3_0.goBtn, function()
		pg = var_2_10000

		local var_6_0 = var_2_10000.m02
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10003

		var_6_1(var_6_0, var_2_10003.GO_MINI_GAME, arg_3_0.id)

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	local var_7_0 = arg_7_0.itemList

	var_1.align(var_7_0, arg_7_0.day)

	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
