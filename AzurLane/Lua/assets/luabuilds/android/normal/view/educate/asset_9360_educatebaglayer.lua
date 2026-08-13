class = var_0_10000

local var_0_0 = "EducateBagLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".base.EducateBaseUI"))
local var_0_2 = "FFFFFF"
local var_0_3 = "939495"

function var_0_1.getUIName(arg_1_0)
	return "EducateBagUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.initData(arg_3_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)

	arg_3_0.itemVOs = var_1.GetItemList(var_3_0)

	return
end

function var_0_1.findUI(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "anim_root")
	local var_4_2 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_4_0.anim = var_4_2(var_4_1, var_3(var_1_10004))

	local var_4_3 = arg_4_0._tf
	local var_4_4 = var_1.Find(var_4_3, "anim_root")
	local var_4_5 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_4_0.animEvent = var_4_5(var_4_4, var_3(var_1_10004))

	local var_4_6 = arg_4_0.animEvent

	var_1.SetEndEvent(var_4_6, function()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_4_7 = arg_4_0._tf

	arg_4_0.windowTF = var_1.Find(var_4_7, "anim_root/window")
	setText = var_1

	local var_4_8 = arg_4_0.windowTF
	local var_4_9 = var_2.Find(var_4_8, "title/Text")

	i18n = var_4_8

	var_1(var_4_9, var_4_8("child_btn_bag"))

	local var_4_10 = arg_4_0.windowTF

	arg_4_0.closeBtn = var_1.Find(var_4_10, "close_btn")

	local var_4_11 = arg_4_0.windowTF

	arg_4_0.togglesTF = var_1.Find(var_4_11, "toggles")

	local var_4_12 = arg_4_0.windowTF

	arg_4_0.itemView = var_1.Find(var_4_12, "item_scrollview")

	local var_4_13 = arg_4_0.windowTF

	arg_4_0.emptyTF = var_1.Find(var_4_13, "empty")
	setText = var_1

	local var_4_14 = arg_4_0.emptyTF
	local var_4_15 = var_2.Find(var_4_14, "Text")

	i18n = var_4_14

	var_1(var_4_15, var_4_14("child_bag_empty_tip"))

	return
end

function var_0_1.addListener(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_3.Find(var_6_1, "anim_root/bg")

	local function var_6_3()
		local var_7_0 = arg_6_0

		var_0._close(var_7_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_6_0, var_6_2, var_6_3, var_5)

	onButton = var_1_10001

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.closeBtn

	local function var_6_6()
		local var_8_0 = arg_6_0

		var_0._close(var_8_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_6_4, var_6_5, var_6_6, var_5)

	eachChild = var_1_10001

	var_1_10001(arg_6_0.togglesTF, function(arg_9_0)
		setText = var_2_10001

		local var_9_0 = arg_9_0
		local var_9_1 = arg_9_0.Find(var_9_0, "Text")

		i18n = var_9_0

		var_2_10001(var_9_1, var_9_0("child_item_type" .. arg_9_0.name))

		onToggle = var_2_10001

		var_2_10001(arg_6_0, arg_9_0, function(arg_10_0)
			local var_10_0

			if not arg_10_0 or not var_0_2 then
				var_10_0 = var_0_3
			end

			setImageColor = var_3_10002

			local var_10_1 = arg_9_0
			local var_10_2 = var_3.Find(var_10_1, "icon")

			Color = var_10_1

			var_3_10002(var_10_2, var_10_1.NewHex(var_10_0))

			setTextColor = var_3_10002

			local var_10_3 = arg_9_0
			local var_10_4 = var_3.Find(var_10_3, "Text")

			Color = var_10_3

			var_3_10002(var_10_4, var_10_3.NewHex(var_10_0))

			if arg_10_0 then
				local var_10_5 = arg_6_0.anim

				var_2.Play(var_10_5, "anim_educate_bag_change")

				local var_10_6 = arg_6_0
				local var_10_7 = var_2.updateItems

				tonumber = var_4

				var_10_7(var_10_6, var_4(arg_9_0.name))
			end

			return
		end)

		return
	end)

	return
end

function var_0_1.didEnter(arg_11_0)
	arg_11_0:OverlayPanel(arg_11_0._tf, {
		groupDelta = 1
	})
	arg_11_0:initItems()

	triggerToggle = var_1

	local var_11_0 = arg_11_0.togglesTF

	var_1(var_2.Find(var_11_0, "0"), true)

	return
end

function var_0_1.initItems(arg_12_0)
	local var_12_0 = arg_12_0.itemView

	arg_12_0.itemRect = var_1.GetComponent(var_12_0, "LScrollRect")

	function arg_12_0.itemRect.onInitItem(arg_13_0)
		local var_13_0 = arg_12_0

		var_1.initItem(var_13_0, arg_13_0)

		return
	end

	function arg_12_0.itemRect.onUpdateItem(arg_14_0, arg_14_1)
		local var_14_0 = arg_12_0

		var_2.updateItem(var_14_0, arg_14_0, arg_14_1)

		return
	end

	function arg_12_0.itemRect.onReturnItem(arg_15_0, arg_15_1)
		local var_15_0 = arg_12_0

		var_2.returnItem(var_15_0, arg_15_0, arg_15_1)

		return
	end

	return
end

function var_0_1.updateItems(arg_16_0, arg_16_1)
	arg_16_0.showVOs = {}
	underscore = var_2
	arg_16_0.showVOs = var_2.select(arg_16_0.itemVOs, function(arg_17_0)
		local var_17_0

		if arg_17_0:IsShow() then
			var_17_0 = arg_16_1 == 0 or arg_17_0:GetType() == arg_16_1
		end

		return var_17_0
	end)
	table = var_2

	local var_16_0 = var_2.sort
	local var_16_1 = arg_16_0.showVOs

	CompareFuncs = var_4

	var_16_0(var_16_1, var_4({
		function(arg_18_0)
			return arg_18_0:CanUse() and 1 or 0
		end,
		function(arg_19_0)
			return -arg_19_0:GetRarity()
		end,
		function(arg_20_0)
			return -arg_20_0.count
		end,
		function(arg_21_0)
			return -arg_21_0.id
		end
	}))

	local var_16_2 = arg_16_0.itemRect

	var_2.SetTotalCount(var_16_2, #arg_16_0.showVOs, -1)

	setActive = var_2

	var_2(arg_16_0.emptyTF, #arg_16_0.showVOs <= 0)

	return
end

function var_0_1.initItem(arg_22_0, arg_22_1)
	return
end

function var_0_1.updateItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.showVOs[arg_23_1 + 1]
	local var_23_1 = var_3.GetShowInfo(var_23_0)

	EducateHelper = var_23_0

	var_23_0.UpdateDropShow(arg_23_2, var_23_1)

	onButton = var_5

	local var_23_2 = arg_23_0
	local var_23_3 = arg_23_2

	local function var_23_4()
		local var_24_0 = arg_23_0

		var_0.emit(var_24_0, var_0_1.EDUCATE_ON_ITEM, {
			drop = var_23_1
		})

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_23_2, var_23_3, var_23_4, var_1_10009)

	return
end

function var_0_1.returnItem(arg_25_0, arg_25_1, arg_25_2)
	removeOnButton = var_1_10003

	var_1_10003(arg_25_2)

	return
end

function var_0_1._close(arg_26_0)
	local var_26_0 = arg_26_0.anim

	var_1.Play(var_26_0, "anim_educate_bag_out")

	return
end

function var_0_1.onBackPressed(arg_27_0)
	arg_27_0:_close()

	return
end

function var_0_1.willExit(arg_28_0)
	local var_28_0 = arg_28_0.animEvent

	var_1.SetEndEvent(var_28_0, nil)
	arg_28_0:UnOverlayPanel(arg_28_0._tf)

	return
end

return var_0_1
