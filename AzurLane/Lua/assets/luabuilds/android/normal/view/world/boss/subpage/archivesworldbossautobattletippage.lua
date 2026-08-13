class = var_0_10000

local var_0_0 = "ArchivesWorldBossAutoBattleTipPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ArchivesWorldBossAutoBattleTipUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "window/top/close")

	local var_2_1 = arg_2_0._tf

	arg_2_0.startBtn = var_1.Find(var_2_1, "window/btns/start")

	local var_2_2 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_2, "window/btns/cancel")
	setText = var_1

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_2.Find(var_2_3, "window/top/title")

	i18n = var_2_3

	var_1(var_2_4, var_2_3("world_boss_title_auto_battle"))

	setText = var_1

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_2.Find(var_2_5, "window/msg_panel/highest_damage/label")

	i18n = var_2_5

	var_1(var_2_6, var_2_5("world_boss_title_highest_damge"))

	setText = var_1

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_2.Find(var_2_7, "window/msg_panel/label")

	i18n = var_2_7

	var_1(var_2_8, var_2_7("world_boss_title_estimation"))

	setText = var_1

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_2.Find(var_2_9, "window/msg_panel/battle_cnt/label")

	i18n = var_2_9

	var_1(var_2_10, var_2_9("world_boss_title_battle_cnt"))

	setText = var_1

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_2.Find(var_2_11, "window/msg_panel/oil/label")

	i18n = var_2_11

	var_1(var_2_12, var_2_11("world_boss_title_consume_oil_cnt"))

	setText = var_1

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_2.Find(var_2_13, "window/msg_panel/time/label")

	i18n = var_2_13

	var_1(var_2_14, var_2_13("world_boss_title_spend_time"))

	setText = var_1

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_2.Find(var_2_15, "window/btns/cancel/pic")

	i18n = var_2_15

	var_1(var_2_16, var_2_15("word_cancel"))

	setText = var_1

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_2.Find(var_2_17, "window/btns/start/pic")

	i18n = var_2_17

	var_1(var_2_18, var_2_17("word_start"))

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_1.Find(var_2_19, "window/msg_panel/highest_damage/Text")
	local var_2_21 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.highestDamageTxt = var_2_21(var_2_20, var_3(var_4))

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_1.Find(var_2_22, "window/msg_panel/battle_cnt/Text")
	local var_2_24 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.battleCntTxt = var_2_24(var_2_23, var_3(var_4))

	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_1.Find(var_2_25, "window/msg_panel/oil/Text")
	local var_2_27 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.oilTxt = var_2_27(var_2_26, var_3(var_4))

	local var_2_28 = arg_2_0._tf
	local var_2_29 = var_1.Find(var_2_28, "window/msg_panel/time/Text")
	local var_2_30 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.timeTxt = var_2_30(var_2_29, var_3(var_4))

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

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.cancelBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.startBtn

	local function var_3_11()
		if arg_3_0.OnYes then
			arg_3_0.OnYes()
		end

		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	return
end

function var_0_1.Show(arg_8_0, arg_8_1)
	var_0_1.super.Show(arg_8_0)

	arg_8_0.highestDamageTxt.text = arg_8_1.highestDamage
	arg_8_0.battleCntTxt.text = arg_8_1.autoBattleCnt > 100 and ">100" or arg_8_1.autoBattleCnt
	arg_8_0.oilTxt.text = arg_8_1.oil
	arg_8_0.timeTxt.text = arg_8_1.time .. "MIN"
	arg_8_0.OnYes = arg_8_1.onYes

	return
end

function var_0_1.Hide(arg_9_0)
	var_0_1.super.Hide(arg_9_0)

	arg_9_0.OnYes = nil

	return
end

function var_0_1.OnDestroy(arg_10_0)
	if arg_10_0:isShowing() then
		arg_10_0:Hide()
	end

	return
end

return var_0_1
