class = var_0_10000

local var_0_0 = "BossSingleContinuousOperationWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.worldboss.ContinuousOperationWindow"))
local var_0_2 = 15

function var_0_1.getUIName(arg_1_0)
	return "BossSingleContinuousOperationWindowUI"
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

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.panel
	local var_4_2 = var_3.Find(var_4_1, "battle")

	local function var_4_3()
		local var_5_0 = arg_4_0.contextData.battleTimes
		local var_5_1 = arg_4_0.contextData.oilCost * var_5_0

		getProxy = var_2_10002
		PlayerProxy = var_2_10003

		local var_5_2 = var_2_10002(var_2_10003)

		if var_2.getRawData(var_5_2).oil < var_5_1 then
			pg = var_3

			local var_5_3 = var_3.TipsMgr.GetInstance()
			local var_5_4 = var_3.ShowTips

			i18n = var_2_10005

			var_5_4(var_5_3, var_2_10005("stage_beginStage_error_noResource"))

			return
		end

		local var_5_5 = arg_4_0
		local var_5_6 = var_3.emit

		BossSinglePreCombatMediator = var_2_10005

		var_5_6(var_5_5, var_2_10005.CONTINUOUS_OPERATION)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_0, var_4_2, var_4_3, var_5)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0._tf
	local var_4_6 = var_3.Find(var_4_5, "window/top/btnBack")

	local function var_4_7()
		local var_6_0 = arg_4_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_4_4, var_4_6, var_4_7, var_5)

	onButton = var_1_10001

	local var_4_8 = arg_4_0
	local var_4_9 = arg_4_0._tf
	local var_4_10 = var_3.Find(var_4_9, "bg")

	local function var_4_11()
		local var_7_0 = arg_4_0

		var_0.closeView(var_7_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_4_8, var_4_10, var_4_11, var_5)

	local var_4_12 = arg_4_0._pageUtil

	var_1.setNumUpdate(var_4_12, function(arg_8_0)
		arg_4_0.contextData.battleTimes = arg_8_0

		local var_8_0 = arg_4_0

		var_1.UpdateContent(var_8_0)

		return
	end)

	local var_4_13 = arg_4_0._pageUtil

	var_1.setMaxNum(var_4_13, var_0_2)

	local var_4_14 = arg_4_0.contextData
	local var_4_15

	if not arg_4_0.contextData.battleTimes then
		var_4_15 = 1
	end

	var_4_14.battleTimes = var_4_15

	local var_4_16 = arg_4_0._pageUtil

	var_1.setDefaultNum(var_4_16, arg_4_0.contextData.battleTimes)
	arg_4_0:UpdateContent()

	pg = var_1

	local var_4_17 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_4_17, arg_4_0._tf)

	return
end

function var_0_1.UpdateContent(arg_9_0)
	local var_9_0 = arg_9_0.contextData.battleTimes
	local var_9_1 = arg_9_0.contextData.oilCost * var_9_0

	i18n = var_1_10003

	local var_9_2 = var_1_10003("multiple_sorties_cost1", var_9_1)

	getProxy = var_4
	PlayerProxy = var_5

	local var_9_3 = var_4(var_5)

	if var_4.getRawData(var_9_3).oil < var_9_1 then
		string = var_5

		local var_9_4 = var_5.gsub
		local var_9_5 = var_9_2
		local var_9_6 = "#92fc63"

		COLOR_RED = var_1_10008
		var_9_2 = var_9_4(var_9_5, var_9_6, var_1_10008)
	end

	arg_9_0.consumeText.text = var_9_2

	return
end

return var_0_1
