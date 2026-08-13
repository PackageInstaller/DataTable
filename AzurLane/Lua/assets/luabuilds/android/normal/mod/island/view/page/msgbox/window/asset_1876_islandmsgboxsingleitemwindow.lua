class = var_0_10000

local var_0_0 = "IslandMsgBoxSingleItemWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandCommonMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCommonMsgBoxWithSingleItem"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.itemTr = var_1.Find(var_2_0, "IslandItemTpl")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "name")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTxt = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "own")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.ownTxt = var_2_6(var_2_5, var_3(var_1_10004))
	UIItemList = var_1

	local var_2_7 = var_1.New
	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_2.Find(var_2_8, "way/Viewport/list")
	local var_2_10 = arg_2_0._tf

	arg_2_0.uiItemList = var_2_7(var_2_9, var_3.Find(var_2_10, "way/Viewport/list/tpl"))

	local var_2_11 = arg_2_0._tf

	arg_2_0.contentTF = var_1.Find(var_2_11, "way/Viewport/list")
	setText = var_1

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_2.Find(var_2_12, "label/Text")

	i18n = var_2_12

	var_1(var_2_13, var_2_12("island_get_way"))

	return
end

function var_0_1.OnShow(arg_3_0)
	var_0_1.super.OnShow(arg_3_0)

	local var_3_0 = arg_3_0.settings.itemId

	arg_3_0:FlushMain(var_3_0)
	arg_3_0:FlushAcquiringWay(var_3_0)

	return
end

function var_0_1.FlushMain(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.island_item_data_template[arg_4_1]

	arg_4_0.nameTxt.text = var_4_0.name

	local var_4_1 = arg_4_0.contentTxt

	var_4_1.text = var_4_0.desc
	getProxy = var_4_1
	IslandProxy = var_4

	local var_4_2 = var_4_1(var_4)
	local var_4_3 = var_3.GetIsland(var_4_2)
	local var_4_4 = var_3.GetInventoryAgency(var_4_3)
	local var_4_5 = var_3.GetOwnCount(var_4_4, arg_4_1)
	local var_4_6 = arg_4_0.ownTxt

	i18n = var_5

	local var_4_7 = var_5("island_own_cnt")

	setColorStr = var_6
	var_4_6.text = var_4_7 .. var_6(var_4_5, "#39beff")
	Drop = var_4_6

	local var_4_8 = var_4_6.New
	local var_4_9 = {
		count = 0
	}

	DROP_TYPE_ISLAND_ITEM = var_6
	var_4_9.type = var_6
	var_4_9.id = arg_4_1

	local var_4_10 = var_4_8(var_4_9)

	updateCustomDrop = var_4_9

	var_4_9(arg_4_0.itemTr, var_4_10)

	return
end

function var_0_1.FlushAcquiringWay(arg_5_0, arg_5_1)
	IslandItem = var_1_10002

	local var_5_0 = var_1_10002.New({
		num = 0,
		id = arg_5_1
	})
	local var_5_1 = #var_2.GetAcquiringWay(var_5_0)
	local var_5_2 = 0 < var_5_1

	setActive = var_5

	local var_5_3 = arg_5_0._tf

	var_5(var_6.Find(var_5_3, "line"), var_5_2)

	setActive = var_5

	local var_5_4 = arg_5_0._tf

	var_5(var_6.Find(var_5_4, "label"), var_5_2)

	setActive = var_5

	local var_5_5 = arg_5_0._tf

	var_5(var_6.Find(var_5_5, "way"), var_5_2)

	local var_5_6 = arg_5_0.uiItemList

	var_5.make(var_5_6, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = var_0[arg_6_1 + 1]

			setText = var_4

			var_4(arg_6_2:Find("Text"), var_6_0[1])

			setText = var_4

			local var_6_1 = arg_6_2
			local var_6_2 = arg_6_2.Find(var_6_1, "go/Text")

			i18n = var_6_1

			var_4(var_6_2, var_6_1("island_word_go"))

			onButton = var_4

			local var_6_3 = arg_5_0
			local var_6_4 = arg_6_2:Find("go")

			local function var_6_5()
				Clone = var_3_10000

				local var_7_0 = var_3_10000(var_6_0[2])[1]

				table = var_3_10002

				var_3_10002.remove(var_0, 1)

				local var_7_1 = arg_5_0
				local var_7_2 = var_2.GetMsgBoxMgr(var_7_1)
				local var_7_3 = var_2.emit

				IslandMediator = var_4

				var_7_3(var_7_2, var_4.OPEN_PAGE, var_7_0, var_0)

				local var_7_4 = arg_5_0

				var_2.Hide(var_7_4)

				return
			end

			SFX_PANEL = var_8

			var_4(var_6_3, var_6_4, var_6_5, var_8)

			setActive = var_4

			local var_6_6 = arg_6_2:Find("go")
			local var_6_7

			if var_6_0[2] then
				var_6_7 = #var_6_0[2] > 0
			end

			var_4(var_6_6, var_6_7)
		end

		return
	end)

	local var_5_7 = arg_5_0.uiItemList

	var_5.align(var_5_7, #var_3)

	IsNil = var_5

	if not var_5(arg_5_0.contentTF) then
		setAnchoredPosition = var_5

		var_5(arg_5_0.contentTF, {
			x = 0,
			y = 0
		})
	end

	return
end

function var_0_1.FlushBtn(arg_8_0, arg_8_1)
	setActive = var_1_10002

	var_1_10002(arg_8_0.cancelBtn, false)

	return
end

return var_0_1
