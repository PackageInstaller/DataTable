class = var_0_10000

local var_0_0 = "BuildShipMsgBox"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "BuildShipMsgBoxUI"
end

function var_0_1.OnLoaded(arg_2_0)
	findTF = var_1_10001
	arg_2_0.cancenlBtn = var_1_10001(arg_2_0._go, "window/btns/cancel_btn")
	findTF = var_1
	arg_2_0.confirmBtn = var_1(arg_2_0._go, "window/btns/confirm_btn")
	findTF = var_1
	arg_2_0.closeBtn = var_1(arg_2_0._go, "window/close_btn")
	arg_2_0.count = 1
	findTF = var_1
	arg_2_0.minusBtn = var_1(arg_2_0._go, "window/content/calc_panel/minus")
	findTF = var_1
	arg_2_0.addBtn = var_1(arg_2_0._go, "window/content/calc_panel/add")
	findTF = var_1
	arg_2_0.maxBtn = var_1(arg_2_0._go, "window/content/max")
	findTF = var_1

	local var_2_0 = var_1(arg_2_0._go, "window/content/calc_panel/Text")
	local var_2_1 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.valueTxt = var_2_1(var_2_0, var_4(var_1_10006))
	findTF = var_1

	local var_2_2 = var_1(arg_2_0._go, "window/content/Text")
	local var_2_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.text = var_2_3(var_2_2, var_4(var_1_10006))
	setText = var_1

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_3.Find(var_2_4, "window/btns/cancel_btn/Image/Image (1)")

	i18n = var_4

	var_1(var_2_5, var_4("text_cancel"))

	setText = var_1

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_3.Find(var_2_6, "window/btns/confirm_btn/Image/Image (1)")

	i18n = var_4

	var_1(var_2_7, var_4("text_confirm"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.cancenlBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.confirmBtn

	local function var_3_8()
		if arg_3_0.onConfirm then
			arg_3_0.onConfirm(arg_3_0.count)
		end

		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.closeBtn

	local function var_3_11()
		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.minusBtn

	local function var_3_14()
		local var_8_0 = arg_3_0

		math = var_2_10001
		var_8_0.count = var_2_10001.max(arg_3_0.count - 1, 1)

		local var_8_1 = arg_3_0

		var_0.updateTxt(var_8_1, arg_3_0.count)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_12, var_3_13, var_3_14, var_1_10006)

	onButton = var_1_10001

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.addBtn

	local function var_3_17()
		if arg_3_0.buildType == "ticket" then
			local var_9_0 = arg_3_0.count

			if arg_3_0.itemVO.count <= var_9_0 then
				pg = var_9_0

				local var_9_1 = var_9_0.TipsMgr.GetInstance()
				local var_9_2 = var_0.ShowTips

				i18n = var_2_10003
				var_2_10005 = "tip_build_ticket_not_enough"

				local var_9_3 = arg_3_0.itemVO

				var_9_2(var_9_1, var_2_10003(var_2_10005, var_6.getConfig(var_9_3, "name")))

				return
			end
		end

		local var_9_4 = arg_3_0

		math = var_2_10001

		local var_9_5 = var_2_10001.clamp
		local var_9_6 = arg_3_0.count + 1
		local var_9_7 = 1

		MAX_BUILD_WORK_COUNT = var_2_10005
		var_9_4.count = var_9_5(var_9_6, var_9_7, var_2_10005)

		local var_9_8 = arg_3_0

		var_0.updateTxt(var_9_8, arg_3_0.count)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_15, var_3_16, var_3_17, var_1_10006)

	onButton = var_1_10001

	local var_3_18 = arg_3_0
	local var_3_19 = arg_3_0.maxBtn

	local function var_3_20()
		local var_10_0 = arg_3_0

		MAX_BUILD_WORK_COUNT = var_2_10001
		var_10_0.count = var_2_10001

		if arg_3_0.buildType == "ticket" then
			local var_10_1 = arg_3_0

			math = var_2_10001

			local var_10_2 = var_2_10001.clamp
			local var_10_3 = arg_3_0.itemVO.count
			local var_10_4 = 1

			MAX_BUILD_WORK_COUNT = var_2_10005
			var_10_1.count = var_10_2(var_10_3, var_10_4, var_2_10005)
		end

		local var_10_5 = arg_3_0

		var_0.updateTxt(var_10_5, arg_3_0.count)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_18, var_3_19, var_3_20, var_1_10006)

	return
end

function var_0_1.updateTxt(arg_11_0, arg_11_1)
	arg_11_0.valueTxt.text = arg_11_1

	local var_11_0 = arg_11_0:GetDesc(arg_11_1)

	arg_11_0.text.text = var_11_0

	return
end

function var_0_1.GetDesc(arg_12_0, arg_12_1)
	local var_12_0 = ""

	switch = var_1_10003

	var_1_10003(arg_12_0.buildType, {
		base = function()
			local var_13_0 = arg_12_0.buildPool

			if arg_12_1 <= arg_12_0.max and arg_12_0.player.gold >= arg_12_1 * var_13_0.use_gold and arg_12_0.itemVO.count >= arg_12_1 * var_13_0.number_1 then
				i18n = var_1

				local var_13_1 = "build_ship_tip"
				local var_13_2 = arg_12_1
				local var_13_3 = var_13_0.name
				local var_13_4 = arg_12_1 * var_13_0.use_gold
				local var_13_5 = arg_12_1 * var_13_0.number_1

				COLOR_GREEN = var_8
				var_12_0 = var_1(var_13_1, var_13_2, var_13_3, var_13_4, var_13_5, var_8)
			else
				i18n = var_1

				local var_13_6 = "build_ship_tip"
				local var_13_7 = arg_12_1
				local var_13_8 = var_13_0.name
				local var_13_9 = arg_12_1 * var_13_0.use_gold
				local var_13_10 = arg_12_1 * var_13_0.number_1

				COLOR_RED = var_8
				var_12_0 = var_1(var_13_6, var_13_7, var_13_8, var_13_9, var_13_10, var_8)
			end

			return
		end,
		ticket = function()
			if arg_12_1 <= arg_12_0.max and arg_12_0.itemVO.count >= arg_12_1 then
				i18n = var_0

				local var_14_0 = "build_ship_tip_use_ticket"
				local var_14_1 = arg_12_1
				local var_14_2 = arg_12_0.buildPool.name
				local var_14_3 = arg_12_1
				local var_14_4 = arg_12_0.itemVO
				local var_14_5 = var_6.getConfig(var_14_4, "name")

				COLOR_GREEN = var_2_10007
				var_12_0 = var_0(var_14_0, var_14_1, var_14_2, var_14_3, var_14_5, var_2_10007)
			else
				i18n = var_0

				local var_14_6 = "build_ship_tip_use_ticket"
				local var_14_7 = arg_12_1
				local var_14_8 = arg_12_0.buildPool.name
				local var_14_9 = arg_12_1
				local var_14_10 = arg_12_0.itemVO
				local var_14_11 = var_6.getConfig(var_14_10, "name")

				COLOR_RED = var_2_10007
				var_12_0 = var_0(var_14_6, var_14_7, var_14_8, var_14_9, var_14_11, var_2_10007)
			end

			return
		end,
		medal = function()
			if arg_12_1 <= arg_12_0.max and arg_12_0.itemVO.count >= arg_12_1 * arg_12_0.cost then
				i18n = var_0

				local var_15_0 = "honor_medal_support_tips_confirm"
				local var_15_1 = arg_12_1
				local var_15_2 = arg_12_1 * arg_12_0.cost

				COLOR_GREEN = var_5
				var_12_0 = var_0(var_15_0, var_15_1, var_15_2, var_5)
			else
				i18n = var_0

				local var_15_3 = "honor_medal_support_tips_confirm"
				local var_15_4 = arg_12_1
				local var_15_5 = arg_12_1 * arg_12_0.cost

				COLOR_RED = var_5
				var_12_0 = var_0(var_15_3, var_15_4, var_15_5, var_5)
			end

			return
		end
	})

	return var_12_0
end

function var_0_1.Show(arg_16_0, arg_16_1)
	arg_16_0.showing = true
	pairs = var_2

	for iter_16_0, iter_16_1 in var_2(arg_16_1) do
		arg_16_0[iter_16_0] = iter_16_1
	end

	arg_16_0.count = 1

	arg_16_0:updateTxt(arg_16_0.count)

	setText = var_2

	local var_16_0 = arg_16_0._tf
	local var_16_1 = var_4.Find(var_16_0, "window/content/title")

	i18n = var_5

	var_2(var_16_1, var_5(arg_16_0.buildType == "medal" and "support_times_tip" or "build_times_tip"))

	setActiveViaLayer = var_2

	var_2(arg_16_0._go, true)

	pg = var_2

	local var_16_2 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_16_2, arg_16_0._tf)

	return
end

function var_0_1.Hide(arg_17_0)
	arg_17_0.showing = false

	if arg_17_0._go then
		arg_17_0.onConfirm = nil
		arg_17_0.count = 1
		arg_17_0.max = 1
		setActiveViaLayer = var_1

		var_1(arg_17_0._go, false)
	end

	pg = var_1

	local var_17_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_17_0, arg_17_0._tf, arg_17_0._parentTf)

	return
end

function var_0_1.isShowing(arg_18_0)
	return arg_18_0.showing
end

function var_0_1.OnDestroy(arg_19_0)
	arg_19_0:Hide()

	return
end

return var_0_1
