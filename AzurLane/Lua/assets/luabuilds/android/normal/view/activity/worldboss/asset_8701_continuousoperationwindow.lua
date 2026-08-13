class = var_0_10000

local var_0_0 = "ContinuousOperationWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))
local var_0_2 = 15

function var_0_1.getUIName(arg_1_0)
	return "ContinuousOperationWindowUI"
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

	var_1(var_3_19, var_3_18("multiple_sorties_tip"))

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

function var_0_1.SetActivity(arg_4_0, arg_4_1)
	arg_4_0.activity = arg_4_1

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.panel
	local var_5_2 = var_3.Find(var_5_1, "battle")

	local function var_5_3()
		local var_6_0 = arg_5_0.contextData.battleTimes
		local var_6_1 = arg_5_0.contextData.oilCost * var_6_0

		getProxy = var_2_10002
		PlayerProxy = var_2_10003

		local var_6_2 = var_2_10002(var_2_10003)

		if var_2.getRawData(var_6_2).oil < var_6_1 then
			pg = var_3

			local var_6_3 = var_3.TipsMgr.GetInstance()
			local var_6_4 = var_3.ShowTips

			i18n = var_2_10005

			var_6_4(var_6_3, var_2_10005("stage_beginStage_error_noResource"))

			return
		end

		local var_6_5 = arg_5_0
		local var_6_6 = var_3.emit

		PreCombatMediator = var_2_10005

		var_6_6(var_6_5, var_2_10005.CONTINUOUS_OPERATION)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5)

	onButton = var_1_10001

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0._tf
	local var_5_6 = var_3.Find(var_5_5, "window/top/btnBack")

	local function var_5_7()
		local var_7_0 = arg_5_0

		var_0.closeView(var_7_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_5_4, var_5_6, var_5_7, var_5)

	onButton = var_1_10001

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0._tf
	local var_5_10 = var_3.Find(var_5_9, "bg")

	local function var_5_11()
		local var_8_0 = arg_5_0

		var_0.closeView(var_8_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_5_8, var_5_10, var_5_11, var_5)

	getProxy = var_1_10001
	SettingsProxy = var_5_8

	local var_5_12 = var_1_10001(var_5_8)
	local var_5_13 = var_1.isTipActBossExchangeTicket(var_5_12) == 1
	local var_5_14 = arg_5_0.contextData

	defaultValue = var_5_10
	var_5_14.useTicket = var_5_10(arg_5_0.contextData.useTicket, var_5_13)
	triggerToggle = var_5_14

	local var_5_15 = arg_5_0.panel

	var_5_14(var_3.Find(var_5_15, "ticket/checkbox"), var_5_13)

	onToggle = var_5_14

	local var_5_16 = arg_5_0
	local var_5_17 = arg_5_0.panel
	local var_5_18 = var_4.Find(var_5_17, "ticket/checkbox")

	local function var_5_19(arg_9_0)
		arg_5_0.contextData.useTicket = arg_9_0

		local var_9_0 = arg_5_0

		var_1.UpdateContent(var_9_0)

		return
	end

	SFX_PANEL = var_6
	SFX_CANCEL = var_1_10007

	var_5_14(var_5_16, var_5_18, var_5_19, var_6, var_1_10007)

	local var_5_20 = arg_5_0.activity
	local var_5_21 = var_2.getConfig(var_5_20, "config_id")

	pg = var_5_20

	local var_5_22 = var_5_20.activity_event_worldboss[var_5_21].ticket

	Drop = var_5_19

	local var_5_23 = var_5_19.New
	local var_5_24 = {}

	DROP_TYPE_RESOURCE = var_1_10007
	var_5_24.type = var_1_10007
	var_5_24.id = var_5_22

	local var_5_25 = var_5_23(var_5_24)
	local var_5_26 = var_5.getIcon(var_5_25)

	LoadSprite = var_5_25

	local var_5_27 = var_5_25(var_5_26, "")
	local var_5_28 = arg_5_0.consumeText

	var_7.AddSprite(var_5_28, "ticket", var_5_27)

	setImageSprite = var_7

	local var_5_29 = arg_5_0.panel

	var_7(var_8.Find(var_5_29, "ticket/Text/Icon"), var_5_27)

	local var_5_30 = arg_5_0._pageUtil

	var_7.setNumUpdate(var_5_30, function(arg_10_0)
		arg_5_0.contextData.battleTimes = arg_10_0

		local var_10_0 = arg_5_0

		var_1.UpdateContent(var_10_0)

		return
	end)

	local var_5_31 = arg_5_0._pageUtil

	var_7.setMaxNum(var_5_31, var_0_2)

	local var_5_32 = arg_5_0.contextData
	local var_5_33

	if not arg_5_0.contextData.battleTimes then
		var_5_33 = 1
	end

	var_5_32.battleTimes = var_5_33

	local var_5_34 = arg_5_0._pageUtil

	var_7.setDefaultNum(var_5_34, arg_5_0.contextData.battleTimes)
	arg_5_0:UpdateContent()

	pg = var_7

	local var_5_35 = var_7.UIMgr.GetInstance()

	var_7.BlurPanel(var_5_35, arg_5_0._tf)

	return
end

function var_0_1.UpdateContent(arg_11_0)
	local var_11_0 = arg_11_0.contextData.battleTimes
	local var_11_1 = arg_11_0.contextData.stageId
	local var_11_2 = arg_11_0.activity
	local var_11_3 = var_3.getConfig(var_11_2, "config_id")

	pg = var_11_2

	local var_11_4 = var_11_2.activity_event_worldboss[var_11_3].ticket

	getProxy = var_1_10006
	PlayerProxy = var_1_10007

	local var_11_5 = var_1_10006(var_1_10007)
	local var_11_6 = var_6.getRawData(var_11_5)
	local var_11_7 = var_6.getResource(var_11_6, var_11_4)
	local var_11_8 = arg_11_0.activity
	local var_11_9 = var_7.GetStageBonus(var_11_8, var_11_1)

	math = var_11_8

	local var_11_10 = var_11_8.clamp(var_11_0 - var_11_9, 0, var_11_7)
	local var_11_11 = arg_11_0.contextData.useTicket and var_11_10 or 0

	tostring = var_10

	local var_11_12 = var_10(var_11_9)
	local var_11_13

	if 0 < var_11_11 then
		var_11_13 = var_11_12
		setColorStr = var_1_10012

		local var_11_14 = "+" .. var_11_11

		COLOR_GREEN = var_14
		var_11_12 = var_11_13 .. var_1_10012(var_11_14, var_14)
	end

	setText = var_11_13

	local var_11_15 = arg_11_0.panel

	var_11_13(var_12.Find(var_11_15, "bonus/Number"), var_11_12)

	setText = var_11_13

	local var_11_16 = arg_11_0.panel

	var_11_13(var_12.Find(var_11_16, "ticket/Number"), var_11_11 .. "/" .. var_11_7)

	local var_11_17 = var_11_7 > 0 and var_11_10 > 0

	setActive = var_12

	local var_11_18 = arg_11_0.panel

	var_12(var_13.Find(var_11_18, "ticket/checkboxBan"), not var_11_17)

	setToggleEnabled = var_12

	local var_11_19 = arg_11_0.panel

	var_12(var_13.Find(var_11_19, "ticket/checkbox"), var_11_17)

	local var_11_20 = arg_11_0.contextData.oilCost * var_11_0

	i18n = var_13

	local var_11_21 = var_13("multiple_sorties_cost1", var_11_20)

	getProxy = var_14
	PlayerProxy = var_15

	local var_11_22 = var_14(var_15)

	if var_14.getRawData(var_11_22).oil < var_11_20 then
		string = var_15

		local var_11_23 = var_15.gsub

		var_1_10016 = var_11_21

		local var_11_24 = "#92fc63"

		COLOR_RED = var_1_10018
		var_11_21 = var_11_23(var_1_10016, var_11_24, var_1_10018)
	end

	if var_11_11 > 0 then
		local var_11_25 = var_11_21

		i18n = var_1_10016
		var_11_21 = var_11_25 .. var_1_10016("multiple_sorties_cost2", var_11_11)
	end

	arg_11_0.consumeText.text = var_11_21

	return
end

function var_0_1.willExit(arg_12_0)
	local var_12_0 = arg_12_0._pageUtil

	var_1.Dispose(var_12_0)

	pg = var_1

	local var_12_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_12_1, arg_12_0._tf)

	return
end

return var_0_1
