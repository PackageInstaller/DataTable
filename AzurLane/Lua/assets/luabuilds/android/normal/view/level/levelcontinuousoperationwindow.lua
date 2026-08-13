class = var_0_10000

local var_0_0 = "LevelContinuousOperationWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.worldboss.ContinuousOperationWindow"))

function var_0_1.getUIName(arg_1_0)
	return "LevelContinuousOperationWindowUI"
end

function var_0_1.ResUISettings(arg_2_0)
	local var_2_0 = {
		reset = true,
		gemOffsetX = 628
	}

	PlayerResUI = var_1_10002
	var_2_0.showType = var_1_10002.TYPE_OIL

	return var_2_0
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.panel = var_1.Find(var_3_0, "window/panel")

	local var_3_1 = arg_3_0.panel

	arg_3_0._countSelect = var_1.Find(var_3_1, "content")
	PageUtil = var_1

	local var_3_2 = var_1.New
	local var_3_3 = arg_3_0._countSelect
	local var_3_4 = var_2.Find(var_3_3, "value_bg/left")
	local var_3_5 = arg_3_0._countSelect
	local var_3_6 = var_3.Find(var_3_5, "value_bg/right")
	local var_3_7 = arg_3_0._countSelect
	local var_3_8 = var_4.Find(var_3_7, "max")
	local var_3_9 = arg_3_0._countSelect

	arg_3_0._pageUtil = var_3_2(var_3_4, var_3_6, var_3_8, var_5.Find(var_3_9, "value_bg/value"))

	local var_3_10 = arg_3_0.panel
	local var_3_11 = var_1.Find(var_3_10, "content/consume")

	arg_3_0.consumeText = var_1.GetComponent(var_3_11, "RichText")
	setText = var_1

	local var_3_12 = arg_3_0._tf
	local var_3_13 = var_2.Find(var_3_12, "window/top/bg/title/title")

	i18n = var_3_12

	var_1(var_3_13, var_3_12("multiple_sorties_title"))

	setText = var_1

	local var_3_14 = arg_3_0._tf
	local var_3_15 = var_2.Find(var_3_14, "window/top/bg/title/title/title_en")

	i18n = var_3_14

	var_1(var_3_15, var_3_14("multiple_sorties_title_eng"))

	setText = var_1

	local var_3_16 = arg_3_0.panel
	local var_3_17 = var_2.Find(var_3_16, "content/desc_txt")

	i18n = var_3_16

	var_1(var_3_17, var_3_16("multiple_sorties_times"))

	setText = var_1

	local var_3_18 = arg_3_0.panel
	local var_3_19 = var_2.Find(var_3_18, "Tip")

	i18n = var_3_18

	var_1(var_3_19, var_3_18("multiple_sorties_main_tip"))

	setText = var_1

	local var_3_20 = arg_3_0.panel
	local var_3_21 = var_2.Find(var_3_20, "battle/pic")

	i18n = var_3_20

	var_1(var_3_21, var_3_20("msgbox_text_battle"))

	setText = var_1

	local var_3_22 = arg_3_0.panel
	local var_3_23 = var_2.Find(var_3_22, "bonus/Text")

	i18n = var_3_22

	var_1(var_3_23, var_3_22("expedition_extra_drop_tip"))

	setText = var_1

	local var_3_24 = arg_3_0.panel
	local var_3_25 = var_2.Find(var_3_24, "ticket/Text")

	i18n = var_3_24

	var_1(var_3_25, var_3_24("multiple_sorties_challenge_ticket_use"))

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_3.Find(var_4_1, "window/top/btnBack")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_4_0, var_4_2, var_4_3, var_5)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0._tf
	local var_4_6 = var_3.Find(var_4_5, "bg")

	local function var_4_7()
		local var_6_0 = arg_4_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_4_4, var_4_6, var_4_7, var_5)

	local var_4_8 = arg_4_0.contextData.extraRate.enabled
	local var_4_9 = arg_4_0.contextData

	defaultValue = var_4_7
	var_4_9.useTicket = var_4_7(arg_4_0.contextData.useTicket, var_4_8)
	triggerToggle = var_4_9

	local var_4_10 = arg_4_0.panel

	var_4_9(var_4.Find(var_4_10, "ticket/checkbox"), var_4_8)

	onToggle = var_4_9

	local var_4_11 = arg_4_0
	local var_4_12 = arg_4_0.panel
	local var_4_13 = var_5.Find(var_4_12, "ticket/checkbox")

	local function var_4_14(arg_7_0)
		arg_4_0.contextData.useTicket = arg_7_0

		local var_7_0 = arg_4_0
		local var_7_1 = var_1.emit

		LevelMediator2 = var_2_10003

		var_7_1(var_7_0, var_2_10003.ON_SPITEM_CHANGED, arg_7_0)

		local var_7_2 = arg_4_0

		var_1.UpdateContent(var_7_2)

		return
	end

	SFX_PANEL = var_7
	SFX_CANCEL = var_1_10008

	var_4_9(var_4_11, var_4_13, var_4_14, var_7, var_1_10008)

	local var_4_15 = arg_4_0._pageUtil

	var_3.setNumUpdate(var_4_15, function(arg_8_0)
		arg_4_0.contextData.battleTimes = arg_8_0

		local var_8_0 = arg_4_0

		var_1.UpdateContent(var_8_0)

		return
	end)

	local var_4_16 = arg_4_0.contextData.maxCount
	local var_4_17 = arg_4_0._pageUtil

	var_4.setMaxNum(var_4_17, var_4_16)

	if var_4_16 >= 0 then
		local var_4_18 = arg_4_0.contextData.oilCost

		getProxy = var_4_17
		PlayerProxy = var_6

		local var_4_19 = var_4_17(var_6)
		local var_4_20 = var_5.getRawData(var_4_19).oil

		math = var_4_19

		local var_4_21 = var_4_19.floor(var_4_20 / var_4_18)

		warning = var_7

		var_7(var_4_18, var_4_20, var_4_21)

		local var_4_22 = arg_4_0.contextData

		math = var_8
		var_4_22.battleTimes = var_8.min(var_4_16, var_4_21)

		local var_4_23 = arg_4_0.contextData

		math = var_8
		var_4_23.battleTimes = var_8.max(arg_4_0.contextData.battleTimes, 1)
	end

	local var_4_24 = arg_4_0._pageUtil

	var_4.setDefaultNum(var_4_24, arg_4_0.contextData.battleTimes)
	arg_4_0:UpdateContent()

	pg = var_4

	local var_4_25 = var_4.UIMgr.GetInstance()

	var_4.BlurPanel(var_4_25, arg_4_0._tf)

	return
end

function var_0_1.UpdateContent(arg_9_0)
	local var_9_0 = arg_9_0.contextData.battleTimes
	local var_9_1 = arg_9_0.contextData.extraRate.extraCount
	local var_9_2 = var_2.freeBonus

	math = var_1_10005

	local var_9_3 = var_1_10005.clamp(var_9_0 - var_9_2, 0, var_9_1)
	local var_9_4 = arg_9_0.contextData.useTicket and var_9_3 or 0

	if arg_9_0.contextData.useTicket then
		setColorStr = var_8
		var_1_10009 = var_9_4

		if var_9_0 <= var_9_1 then
			COLOR_GREEN = var_1_10010

			if not var_1_10010 then
				COLOR_RED = var_1_10010
			end

			local var_9_5 = var_8(var_1_10009, var_1_10010)

			setText = var_8

			local var_9_6 = arg_9_0.panel

			var_8(var_1_10009.Find(var_9_6, "ticket/Number"), var_9_5 .. "/" .. var_9_1)

			if false then
				setText = var_8

				local var_9_7 = arg_9_0.panel

				var_8(var_1_10009.Find(var_9_7, "ticket/Number"), var_9_1)
			end

			local var_9_8 = var_9_1 > 0 and var_9_3 > 0

			setActive = var_1_10009

			local var_9_9 = arg_9_0.panel

			var_1_10009(var_10.Find(var_9_9, "ticket/checkboxBan"), not var_9_8)

			setToggleEnabled = var_1_10009

			local var_9_10 = arg_9_0.panel

			var_1_10009(var_10.Find(var_9_10, "ticket/checkbox"), var_9_8)

			if arg_9_0.contextData.useTicket and not var_9_8 then
				triggerToggle = var_9

				local var_9_11 = arg_9_0.panel

				var_9(var_10.Find(var_9_11, "ticket/checkbox"), false)
			end

			local var_9_12 = arg_9_0.contextData.oilCost * (var_9_0 + (var_2.rate - 1) * var_6)

			i18n = var_10

			local var_9_13 = var_10("multiple_sorties_cost1", var_9_12)

			getProxy = var_11
			PlayerProxy = var_12

			local var_9_14 = var_11(var_12)

			if var_11.getRawData(var_9_14).oil < var_9_12 then
				string = var_12

				local var_9_15 = var_12.gsub

				var_1_10013 = var_9_13

				local var_9_16 = "#92fc63"

				COLOR_RED = var_1_10015
				var_9_13 = var_9_15(var_1_10013, var_9_16, var_1_10015)
			end

			if var_6 > 0 then
				local var_9_17 = var_9_13

				i18n = var_1_10013
				var_9_13 = var_9_17 .. var_1_10013("multiple_sorties_cost3", var_6)
			end

			local var_9_18 = arg_9_0.consumeText

			var_9_18.text = var_9_13
			onButton = var_9_18

			local var_9_19 = arg_9_0
			local var_9_20 = arg_9_0.panel
			local var_9_21 = var_14.Find(var_9_20, "battle")

			local function var_9_22()
				if var_9_12 > var_0.oil then
					pg = var_0

					local var_10_0 = var_0.TipsMgr.GetInstance()
					local var_10_1 = var_0.ShowTips

					i18n = var_2_10002

					var_10_1(var_10_0, var_2_10002("stage_beginStage_error_noResource"))

					return
				end

				local var_10_2 = arg_9_0
				local var_10_3 = var_0.emit

				PreCombatMediator = var_2_10002

				var_10_3(var_10_2, var_2_10002.CONTINUOUS_OPERATION)

				return
			end

			SFX_PANEL = var_16

			var_9_18(var_9_19, var_9_21, var_9_22, var_16)

			return
		end
	end
end

return var_0_1
