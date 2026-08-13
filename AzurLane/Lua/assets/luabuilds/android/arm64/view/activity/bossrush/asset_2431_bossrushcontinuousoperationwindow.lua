class = var_0_10000

local var_0_0 = "BossRushContinuousOperationWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.worldboss.ContinuousOperationWindow"))

function var_0_1.getUIName(arg_1_0)
	return "BossRushContinuousOperationWindowUI"
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
	local var_3_4 = var_3.Find(var_3_3, "value_bg/left")
	local var_3_5 = arg_3_0._countSelect
	local var_3_6 = var_4.Find(var_3_5, "value_bg/right")
	local var_3_7 = arg_3_0._countSelect
	local var_3_8 = var_5.Find(var_3_7, "max")
	local var_3_9 = arg_3_0._countSelect

	arg_3_0._pageUtil = var_3_2(var_3_4, var_3_6, var_3_8, var_6.Find(var_3_9, "value_bg/value"))

	local var_3_10 = arg_3_0.panel
	local var_3_11 = var_1.Find(var_3_10, "content/consume")

	arg_3_0.consumeText = var_1.GetComponent(var_3_11, "RichText")
	setText = var_1

	local var_3_12 = arg_3_0._tf
	local var_3_13 = var_3.Find(var_3_12, "window/top/bg/title/title")

	i18n = var_4

	var_1(var_3_13, var_4("multiple_sorties_title"))

	setText = var_1

	local var_3_14 = arg_3_0._tf
	local var_3_15 = var_3.Find(var_3_14, "window/top/bg/title/title/title_en")

	i18n = var_4

	var_1(var_3_15, var_4("multiple_sorties_title_eng"))

	setText = var_1

	local var_3_16 = arg_3_0.panel
	local var_3_17 = var_3.Find(var_3_16, "content/desc_txt")

	i18n = var_4

	var_1(var_3_17, var_4("multiple_sorties_times"))

	setText = var_1

	local var_3_18 = arg_3_0.panel
	local var_3_19 = var_3.Find(var_3_18, "Tip")

	i18n = var_4

	var_1(var_3_19, var_4("multiple_sorties_tip"))

	setText = var_1

	local var_3_20 = arg_3_0.panel
	local var_3_21 = var_3.Find(var_3_20, "battle/pic")

	i18n = var_4

	var_1(var_3_21, var_4("msgbox_text_battle"))

	setText = var_1

	local var_3_22 = arg_3_0.panel
	local var_3_23 = var_3.Find(var_3_22, "bonus/Text")

	i18n = var_4

	var_1(var_3_23, var_4("expedition_extra_drop_tip"))

	setText = var_1

	local var_3_24 = arg_3_0.panel
	local var_3_25 = var_3.Find(var_3_24, "ticket/Text")

	i18n = var_4

	var_1(var_3_25, var_4("multiple_sorties_challenge_ticket_use"))

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
	local var_5_2 = var_4.Find(var_5_1, "battle")

	local function var_5_3()
		local var_6_0 = arg_5_0.contextData.battleTimes
		local var_6_1 = arg_5_0.contextData.oilCost * var_6_0

		getProxy = var_2_10002
		PlayerProxy = var_2_10004

		local var_6_2 = var_2_10002(var_2_10004)

		if var_2.getRawData(var_6_2).oil < var_6_1 then
			pg = var_3

			local var_6_3 = var_3.TipsMgr.GetInstance()
			local var_6_4 = var_3.ShowTips

			i18n = var_2_10006

			var_6_4(var_6_3, var_2_10006("stage_beginStage_error_noResource"))

			return
		end

		local var_6_5 = arg_5_0
		local var_6_6 = var_3.emit

		PreCombatMediator = var_2_10006

		var_6_6(var_6_5, var_2_10006.CONTINUOUS_OPERATION)

		return
	end

	SFX_PANEL = var_5_1

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5_1)

	onButton = var_1_10001

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0._tf
	local var_5_6 = var_4.Find(var_5_5, "window/top/btnBack")

	local function var_5_7()
		local var_7_0 = arg_5_0

		var_0.closeView(var_7_0)

		return
	end

	SFX_CANCEL = var_5_5

	var_1_10001(var_5_4, var_5_6, var_5_7, var_5_5)

	onButton = var_1_10001

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0._tf
	local var_5_10 = var_4.Find(var_5_9, "bg")

	local function var_5_11()
		local var_8_0 = arg_5_0

		var_0.closeView(var_8_0)

		return
	end

	SFX_CANCEL = var_5_9

	var_1_10001(var_5_8, var_5_10, var_5_11, var_5_9)

	local var_5_12 = arg_5_0._pageUtil

	var_1.setNumUpdate(var_5_12, function(arg_9_0)
		arg_5_0.contextData.battleTimes = arg_9_0

		local var_9_0 = arg_5_0

		var_1.UpdateContent(var_9_0)

		return
	end)

	local var_5_13 = arg_5_0.contextData.maxCount
	local var_5_14 = arg_5_0._pageUtil

	var_2.setMaxNum(var_5_14, var_5_13)

	local var_5_15 = arg_5_0.contextData
	local var_5_16

	if not arg_5_0.contextData.battleTimes then
		var_5_16 = 1
	end

	var_5_15.battleTimes = var_5_16

	local var_5_17 = arg_5_0._pageUtil

	var_2.setDefaultNum(var_5_17, arg_5_0.contextData.battleTimes)
	arg_5_0:UpdateContent()

	pg = var_2

	local var_5_18 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_5_18, arg_5_0._tf)

	return
end

function var_0_1.UpdateContent(arg_10_0)
	local var_10_0 = arg_10_0.contextData.battleTimes
	local var_10_1 = arg_10_0.contextData.oilCost * var_10_0

	i18n = var_1_10003

	local var_10_2 = var_1_10003("multiple_sorties_cost1", var_10_1)

	getProxy = var_1_10004
	PlayerProxy = var_6

	local var_10_3 = var_1_10004(var_6)

	if var_4.getRawData(var_10_3).oil < var_10_1 then
		string = var_5

		local var_10_4 = var_5.gsub
		local var_10_5 = var_10_2
		local var_10_6 = "#92fc63"

		COLOR_RED = var_1_10009
		var_10_2 = var_10_4(var_10_5, var_10_6, var_1_10009)
	end

	arg_10_0.consumeText.text = var_10_2

	return
end

return var_0_1
