class = var_0_10000

local var_0_0 = "AtelierCompositeConfirmView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject
	arg_1_0._tf = arg_1_1
	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)

	setActive = var_3

	var_3(arg_1_0._go, false)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitCustom()

	return
end

function var_0_1.InitCustom(arg_3_0)
	return
end

function var_0_1.SetContextData(arg_4_0, arg_4_1)
	arg_4_0.contextData = arg_4_1

	return
end

function var_0_1.SetActivity(arg_5_0, arg_5_1)
	arg_5_0.activity = arg_5_1

	return
end

function var_0_1.didEnter(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_3.Find(var_6_1, "BG")

	local function var_6_3()
		local var_7_0 = arg_6_0

		var_0.HideCompositeConfirmWindow(var_7_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_6_0, var_6_2, var_6_3, var_5)

	onButton = var_1_10001

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0._tf
	local var_6_6 = var_3.Find(var_6_5, "Window/Cancel")

	local function var_6_7()
		local var_8_0 = arg_6_0

		var_0.HideCompositeConfirmWindow(var_8_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_6_4, var_6_6, var_6_7, var_5)

	return
end

local var_0_2 = 41
local var_0_3 = 5

function var_0_1.ShowCompositeConfirmWindow(arg_9_0, arg_9_1)
	setActive = var_1_10002

	var_1_10002(arg_9_0._go, true)

	pg = var_1_10002

	local var_9_0 = var_1_10002.UIMgr.GetInstance()

	var_2.BlurPanel(var_9_0, arg_9_0._tf)

	local var_9_1 = 1
	local var_9_2 = {}
	local var_9_3 = {}

	_ = var_1_10005

	var_1_10005.each(arg_9_1, function(arg_10_0)
		local var_10_0 = arg_10_0.Instance
		local var_10_1 = var_1.GetConfigID(var_10_0)

		table = var_10_0

		local var_10_2 = var_10_0.insert
		local var_10_3 = var_9_2
		local var_10_4 = {}
		local var_10_5 = arg_10_0.Data

		var_10_4.key = var_5.GetConfigID(var_10_5)
		var_10_4.value = var_10_1

		var_10_2(var_10_3, var_10_4)

		local var_10_6 = var_9_3
		local var_10_7

		if not var_9_3[var_10_1] then
			var_10_7 = 0
		end

		var_10_6[var_10_1] = var_10_7 + 1

		return
	end)

	onButton = var_5

	local var_9_4 = arg_9_0
	local var_9_5 = arg_9_0._tf
	local var_9_6 = var_7.Find(var_9_5, "Window/Confirm")

	local function var_9_7()
		local var_11_0 = arg_9_0._parentClass
		local var_11_1 = var_0.emit

		GAME = var_2_10002

		var_11_1(var_11_0, var_2_10002.COMPOSITE_ATELIER_RECIPE, var_9_2, var_9_1)

		local var_11_2 = arg_9_0._parentClass

		var_0.PlaySoundEffect(var_11_2, arg_9_0._parentClass.soundStr.compositeConfirm)

		return
	end

	SFX_PANEL = var_9

	var_5(var_9_4, var_9_6, var_9_7, var_9)

	local var_9_8 = arg_9_0.activity
	local var_9_9 = var_5.GetFormulas(var_9_8)[arg_9_0.contextData.formulaId]
	local var_9_10 = var_5.GetMaxLimit(var_9_9) ~= 1
	local var_9_11

	if not (var_5:GetMaxLimit() > 0) or not (var_5:GetMaxLimit() - var_5:GetUsedCount()) then
		var_9_11 = 10000
	end

	local var_9_12 = arg_9_0.activity
	local var_9_13 = var_8.GetItems(var_9_12)

	pairs = var_9_12

	for iter_9_0, iter_9_1 in var_9_12(var_9_3) do
		local var_9_14

		if not var_9_13[iter_9_0] or not var_9_13[iter_9_0].count then
			var_9_14 = 0
		end

		math = var_1_10015
		var_1_10015 = var_1_10015.min

		local var_9_15 = var_9_11

		math = var_1_10017
		var_9_11 = var_1_10015(var_9_15, var_1_10017.floor(var_9_14 / iter_9_1))
	end

	local var_9_16 = var_9_11
	local var_9_17 = {
		1,
		var_9_10 and var_9_16 or 1
	}

	Drop = var_11

	local var_9_18 = var_11.New({
		type = var_5:GetProduction()[1],
		id = var_5:GetProduction()[2]
	})
	local var_9_19 = arg_9_0._parentClass
	local var_9_20 = var_12.UpdateRyzaDrop
	local var_9_21 = arg_9_0._tf

	var_9_20(var_9_19, var_14.Find(var_9_21, "Window/Icon"), var_9_18)

	local var_9_22 = arg_9_0._tf
	local var_9_23 = var_12.Find(var_9_22, "Window/Counters")
	local var_9_24 = var_9_18
	local var_9_25 = var_9_18.getConfig(var_9_24, "name")

	setActive = var_9_24

	var_9_24(var_9_23, var_9_10)

	if var_9_10 then
		setAnchoredPosition = var_9_24

		local var_9_26 = arg_9_0._tf

		var_9_24(var_15.Find(var_9_26, "Window/Icon"), {
			y = var_0_2
		})
		;(function()
			setText = var_2_10000

			local var_12_0 = var_9_23

			var_2_10000(var_1.Find(var_12_0, "Number"), var_9_1)

			setText = var_2_10000

			local var_12_1 = arg_9_0._tf
			local var_12_2 = var_1.Find(var_12_1, "Window/Text")

			i18n = var_12_1

			var_2_10000(var_12_2, var_12_1("ryza_composite_confirm", var_9_25, var_9_1))

			return
		end)()

		onButton = var_15

		var_15(arg_9_0, var_9_23:Find("Plus"), function()
			local var_13_0 = var_9_1

			var_9_1 = var_9_1 + 1
			math = var_1
			var_9_1 = var_1.clamp(var_9_1, var_9_17[1], var_9_17[2])

			if var_13_0 == var_9_1 then
				pg = var_1

				local var_13_1 = var_1.TipsMgr.GetInstance()
				local var_13_2 = var_1.ShowTips

				i18n = var_3

				var_13_2(var_13_1, var_3("ryza_tip_max_composite_count"))

				return
			end

			var_9_24()

			return
		end)

		onButton = var_15

		var_15(arg_9_0, var_9_23:Find("Minus"), function()
			var_9_1 = var_9_1 - 1
			math = var_0
			var_9_1 = var_0.clamp(var_9_1, var_9_17[1], var_9_17[2])

			var_9_24()

			return
		end)

		onButton = var_15

		var_15(arg_9_0, var_9_23:Find("Plus10"), function()
			local var_15_0 = var_9_1

			var_9_1 = var_9_1 + 10
			math = var_1
			var_9_1 = var_1.clamp(var_9_1, var_9_17[1], var_9_17[2])

			if var_15_0 == var_9_1 then
				pg = var_1

				local var_15_1 = var_1.TipsMgr.GetInstance()
				local var_15_2 = var_1.ShowTips

				i18n = var_3

				var_15_2(var_15_1, var_3("ryza_tip_max_composite_count"))

				return
			end

			var_9_24()

			return
		end)

		onButton = var_15

		var_15(arg_9_0, var_9_23:Find("Minus10"), function()
			var_9_1 = var_9_1 - 10
			math = var_0
			var_9_1 = var_0.clamp(var_9_1, var_9_17[1], var_9_17[2])

			var_9_24()

			return
		end)
	else
		setAnchoredPosition = var_9_24

		local var_9_27 = arg_9_0._tf

		var_9_24(var_15.Find(var_9_27, "Window/Icon"), {
			y = var_0_3
		})

		setText = var_9_24

		local var_9_28 = arg_9_0._tf
		local var_9_29 = var_15.Find(var_9_28, "Window/Text")

		i18n = var_9_28

		var_9_24(var_9_29, var_9_28("ryza_composite_confirm_single", var_9_25, var_9_1))
	end

	return
end

function var_0_1.HideCompositeConfirmWindow(arg_17_0)
	isActive = var_1_10001

	if not var_1_10001(arg_17_0._go) then
		return
	end

	pg = var_1

	local var_17_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_17_0, arg_17_0._tf, arg_17_0._parentClass._tf)

	setActive = var_1

	var_1(arg_17_0._go, false)

	return true
end

function var_0_1.willExit(arg_18_0)
	arg_18_0:detach()

	return
end

return var_0_1
