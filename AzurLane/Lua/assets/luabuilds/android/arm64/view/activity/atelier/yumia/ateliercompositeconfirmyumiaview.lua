class = var_0_10000

local var_0_0 = "AtelierCompositeConfirmYumiaView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.Atelier.base.AtelierCompositeConfirmView"))

function var_0_1.InitCustom(arg_1_0)
	setText = var_1_10001

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_3.Find(var_1_0, "Window/titleBg/Name")

	i18n = var_1_10004

	var_1_10001(var_1_1, var_1_10004("yumia_atelier_tip14"))

	return
end

function var_0_1.didEnter(arg_2_0)
	var_0_1.super.didEnter(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_4.Find(var_2_1, "Window/titleBg/closeBtn")

	local function var_2_3()
		local var_3_0 = arg_2_0

		var_0.HideCompositeConfirmWindow(var_3_0)

		return
	end

	SFX_CANCEL = var_2_1

	var_1(var_2_0, var_2_2, var_2_3, var_2_1)

	return
end

function var_0_1.HideCompositeConfirmWindow(arg_4_0)
	isActive = var_1_10001

	if not var_1_10001(arg_4_0._go) then
		return
	end

	GetComponent = var_1

	local var_4_0 = arg_4_0._tf

	typeof = var_1_10004
	Animation = var_1_10006

	local var_4_1 = var_1(var_4_0, var_1_10004(var_1_10006))

	var_1.Play(var_4_1, "Anim_AtelierCompositeYumiaUI_ConfirmWindow_Out")

	pg = var_2

	local var_4_2 = var_2.UIMgr.GetInstance()

	var_2.LoadingOn(var_4_2, false)

	FrameTimer = var_2
	arg_4_0.closeTimer = var_2.New(function()
		local var_5_0 = var_0

		if not var_0.IsPlaying(var_5_0, "Anim_AtelierCompositeYumiaUI_ConfirmWindow_Out") then
			local var_5_1 = arg_4_0

			var_0.StopCloseTimer(var_5_1)

			pg = var_0

			local var_5_2 = var_0.UIMgr.GetInstance()

			var_0.LoadingOff(var_5_2)
			var_0_1.super.HideCompositeConfirmWindow(arg_4_0)
		end

		return
	end, 1, -1)

	local var_4_3 = arg_4_0.closeTimer

	var_2.Start(var_4_3)

	return true
end

function var_0_1.StopCloseTimer(arg_6_0)
	if arg_6_0.closeTimer then
		local var_6_0 = arg_6_0.closeTimer

		var_1.Stop(var_6_0)

		arg_6_0.closeTimer = nil
	end

	return
end

function var_0_1.ShowCompositeConfirmWindow(arg_7_0, arg_7_1)
	GetComponent = var_1_10002

	local var_7_0 = arg_7_0._tf

	typeof = var_1_10005
	Animation = var_1_10007

	local var_7_1 = var_1_10002(var_7_0, var_1_10005(var_1_10007))

	var_2.Play(var_7_1, "Anim_AtelierCompositeYumiaUI_ConfirmWindow_In")

	setActive = var_3

	var_3(arg_7_0._go, true)

	pg = var_3

	local var_7_2 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_7_2, arg_7_0._tf)

	local var_7_3 = 1
	local var_7_4 = {}
	local var_7_5 = {}

	_ = var_6

	var_6.each(arg_7_1, function(arg_8_0)
		local var_8_0 = arg_8_0.Instance
		local var_8_1 = var_1.GetConfigID(var_8_0)

		table = var_2_10002

		local var_8_2 = var_2_10002.insert
		local var_8_3 = var_7_4
		local var_8_4 = {}
		local var_8_5 = arg_8_0.Data

		var_8_4.key = var_6.GetConfigID(var_8_5)
		var_8_4.value = var_8_1

		var_8_2(var_8_3, var_8_4)

		local var_8_6 = var_7_5
		local var_8_7

		if not var_7_5[var_8_1] then
			var_8_7 = 0
		end

		var_8_6[var_8_1] = var_8_7 + 1

		return
	end)

	onButton = var_6

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0._tf
	local var_7_8 = var_9.Find(var_7_7, "Window/Confirm")

	local function var_7_9()
		local var_9_0 = arg_7_0._parentClass
		local var_9_1 = var_0.emit

		GAME = var_2_10003

		var_9_1(var_9_0, var_2_10003.COMPOSITE_ATELIER_RECIPE, var_7_4, var_7_3)

		local var_9_2 = arg_7_0._parentClass

		var_0.PlaySoundEffect(var_9_2, arg_7_0._parentClass.soundStr.compositeConfirm)

		return
	end

	SFX_PANEL = var_7_7

	var_6(var_7_6, var_7_8, var_7_9, var_7_7)

	local var_7_10 = arg_7_0.activity
	local var_7_11 = var_6.GetFormulas(var_7_10)[arg_7_0.contextData.formulaId]
	local var_7_12 = var_6.GetMaxLimit(var_7_11) ~= 1
	local var_7_13 = var_6

	if var_6.GetMaxLimit(var_7_13) > 0 then
		var_7_13 = var_6

		local var_7_14

		if not (var_6.GetMaxLimit(var_7_13) - var_6:GetUsedCount()) then
			var_7_14 = 10000
		end

		local var_7_15 = arg_7_0.activity
		local var_7_16 = var_9.GetItems(var_7_15)

		pairs = var_7_13

		for iter_7_0, iter_7_1 in var_7_13(var_7_5) do
			local var_7_17

			if not var_7_16[iter_7_0] or not var_7_16[iter_7_0].count then
				var_7_17 = 0
			end

			math = var_1_10016
			var_1_10016 = var_1_10016.min

			local var_7_18 = var_7_14

			math = var_1_10019
			var_7_14 = var_1_10016(var_7_18, var_1_10019.floor(var_7_17 / iter_7_1))
		end

		local var_7_19 = var_7_14
		local var_7_20 = {
			1,
			var_7_12 and var_7_19 or 1
		}

		Drop = var_12

		local var_7_21 = var_12.New({
			type = var_6:GetProduction()[1],
			id = var_6:GetProduction()[2]
		})
		local var_7_22 = arg_7_0._tf
		local var_7_23 = var_13.Find(var_7_22, "Window/Icon")
		local var_7_24 = arg_7_0._tf
		local var_7_25 = var_14.Find(var_7_24, "Window/AtelierCommonYumiaItem")
		local var_7_26 = var_7_21.type

		DROP_TYPE_RYZA_DROP = var_7_24

		if var_7_26 ~= var_7_24 then
			local var_7_27 = arg_7_0._parentClass

			var_15.UpdateRyzaDrop(var_7_27, var_7_23, var_7_21)

			setActive = var_15

			var_15(var_7_23, true)

			setActive = var_15

			var_15(var_7_25, false)
		else
			local var_7_28 = var_6:GetProduction()[2]

			AtelierMaterial = var_7_24

			local var_7_29 = var_7_24.New({
				configId = var_7_28
			})

			var_7_29.count = 1

			local var_7_30 = arg_7_0._parentClass

			var_17.UpdateRyzaItem(var_7_30, var_7_25, var_7_29)

			setActive = var_17

			var_17(var_7_23, false)

			setActive = var_17

			var_17(var_7_25, true)
		end

		local var_7_31 = arg_7_0._tf
		local var_7_32 = var_15.Find(var_7_31, "Window/Counters")
		local var_7_33 = var_7_21:getConfig("name")

		setActive = var_7_31

		var_7_31(var_7_32, var_7_12)

		if var_7_12 then
			(function()
				setText = var_2_10000

				local var_10_0 = var_7_32

				var_2_10000(var_2.Find(var_10_0, "Number"), var_7_3)

				setText = var_2_10000

				local var_10_1 = arg_7_0._tf
				local var_10_2 = var_2.Find(var_10_1, "Window/Text")

				i18n = var_3

				var_2_10000(var_10_2, var_3("yumia_atelier_tip20", var_7_33, var_7_3))

				setText = var_2_10000

				local var_10_3 = var_7_25

				var_2_10000(var_2.Find(var_10_3, "cntText"), var_7_3)

				return
			end)()

			onButton = var_18

			var_18(arg_7_0, var_7_32:Find("Plus"), function()
				local var_11_0 = var_7_3

				var_7_3 = var_7_3 + 1
				math = var_1
				var_7_3 = var_1.clamp(var_7_3, var_7_20[1], var_7_20[2])

				if var_11_0 == var_7_3 then
					pg = var_1

					local var_11_1 = var_1.TipsMgr.GetInstance()
					local var_11_2 = var_1.ShowTips

					i18n = var_4

					var_11_2(var_11_1, var_4("yumia_atelier_tip21"))

					return
				end

				var_7_31()

				return
			end)

			onButton = var_18

			var_18(arg_7_0, var_7_32:Find("Minus"), function()
				var_7_3 = var_7_3 - 1
				math = var_0
				var_7_3 = var_0.clamp(var_7_3, var_7_20[1], var_7_20[2])

				var_7_31()

				return
			end)

			onButton = var_18

			var_18(arg_7_0, var_7_32:Find("Plus10"), function()
				local var_13_0 = var_7_3

				var_7_3 = var_7_3 + 10
				math = var_1
				var_7_3 = var_1.clamp(var_7_3, var_7_20[1], var_7_20[2])

				if var_13_0 == var_7_3 then
					pg = var_1

					local var_13_1 = var_1.TipsMgr.GetInstance()
					local var_13_2 = var_1.ShowTips

					i18n = var_4

					var_13_2(var_13_1, var_4("yumia_atelier_tip21"))

					return
				end

				var_7_31()

				return
			end)

			onButton = var_18

			var_18(arg_7_0, var_7_32:Find("Minus10"), function()
				var_7_3 = var_7_3 - 10
				math = var_0
				var_7_3 = var_0.clamp(var_7_3, var_7_20[1], var_7_20[2])

				var_7_31()

				return
			end)
		else
			setText = var_7_31

			local var_7_34 = arg_7_0._tf
			local var_7_35 = var_19.Find(var_7_34, "Window/Text")

			i18n = var_20

			var_7_31(var_7_35, var_20("yumia_atelier_tip19", var_7_33, var_7_3))
		end

		return
	end
end

return var_0_1
