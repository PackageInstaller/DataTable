class = var_0_10000

local var_0_0 = "IslandMsgBoxSingleDropWindow"

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

	local var_3_0 = arg_3_0.settings.dropData

	IslandDropDescribeInfo = var_1_10003

	local var_3_1 = var_1_10003.New(var_3_0)

	arg_3_0:FlushMain(var_3_1)
	arg_3_0:FlushAcquiringWay(var_3_1)

	return
end

function var_0_1.FlushMain(arg_4_0, arg_4_1)
	arg_4_0.nameTxt.text = arg_4_1:GetName()

	local var_4_0 = arg_4_0.contentTxt
	local var_4_1 = arg_4_1

	var_4_0.text = arg_4_1.GetDes(var_4_1)

	local var_4_2 = arg_4_1:GetOwnCount()
	local var_4_3 = arg_4_0.ownTxt

	i18n = var_4_1

	local var_4_4 = var_4_1("island_own_cnt")

	setColorStr = var_5
	var_4_3.text = var_4_4 .. var_5(var_4_2, "#39beff")
	updateCustomDrop = var_4_3

	var_4_3(arg_4_0.itemTr, arg_4_1:GetDrop(), {
		style = "island"
	})

	return
end

function var_0_1.FlushAcquiringWay(arg_5_0, arg_5_1)
	local var_5_0
	local var_5_1 = arg_5_1

	if arg_5_1.IsTecUnlocked(var_5_1) then
		var_5_1 = arg_5_1
		var_5_0 = arg_5_1.GetAcquiringWay(var_5_1)
	else
		var_5_0 = {}

		local var_5_2 = {}

		table = var_5_1

		var_5_1.insert(var_5_2, arg_5_1:GetTecDes())

		table = var_4

		var_4.insert(var_5_0, var_5_2)
	end

	local var_5_3 = #var_5_0
	local var_5_4 = 0 < var_5_3

	setActive = var_4

	local var_5_5 = arg_5_0._tf

	var_4(var_5.Find(var_5_5, "line"), var_5_4)

	setActive = var_4

	local var_5_6 = arg_5_0._tf

	var_4(var_5.Find(var_5_6, "label"), var_5_4)

	setActive = var_4

	local var_5_7 = arg_5_0._tf

	var_4(var_5.Find(var_5_7, "way"), var_5_4)

	local var_5_8 = arg_5_0.uiItemList

	var_4.make(var_5_8, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = var_5_0[arg_6_1 + 1]

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

	local var_5_9 = arg_5_0.uiItemList

	var_4.align(var_5_9, #var_5_0)

	setAnchoredPosition = var_4

	var_4(arg_5_0.contentTF, {
		x = 0,
		y = 0
	})

	return
end

function var_0_1.FlushBtn(arg_8_0, arg_8_1)
	setActive = var_1_10002

	var_1_10002(arg_8_0.cancelBtn, false)

	return
end

return var_0_1
