class = var_0_10000

local var_0_0 = "ArchivesWorldBossAutoBattleResultMsg"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ArchivesWorldBossAutoBattleResultUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "window/top/close")

	local var_2_1 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_1, "window/btns/start")
	setText = var_1

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "window/top/title")

	i18n = var_2_2

	var_1(var_2_3, var_2_2("world_boss_title_auto_battle"))

	setText = var_1

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_2.Find(var_2_4, "window/msg_panel/label")

	i18n = var_2_4

	var_1(var_2_5, var_2_4("world_boss_archives_auto_battle_reusle_title"))

	setText = var_1

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_2.Find(var_2_6, "window/msg_panel/battle_cnt/label")

	i18n = var_2_6

	var_1(var_2_7, var_2_6("world_boss_title_battle_cnt"))

	setText = var_1

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_2.Find(var_2_8, "window/msg_panel/damage/label")

	i18n = var_2_8

	var_1(var_2_9, var_2_8("world_boss_title_total_damage"))

	setText = var_1

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_2.Find(var_2_10, "window/msg_panel/oil/label")

	i18n = var_2_10

	var_1(var_2_11, var_2_10("world_boss_title_consume_oil_cnt"))

	setText = var_1

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_2.Find(var_2_12, "window/btns/start/pic")

	i18n = var_2_12

	var_1(var_2_13, var_2_12("text_confirm"))

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_1.Find(var_2_14, "window/msg_panel/battle_cnt/Text")
	local var_2_16 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.battleCntTxt = var_2_16(var_2_15, var_3(var_4))

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_1.Find(var_2_17, "window/msg_panel/damage/Text")
	local var_2_19 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.damageTxt = var_2_19(var_2_18, var_3(var_4))

	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_1.Find(var_2_20, "window/msg_panel/oil/Text")
	local var_2_22 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.oilTxt = var_2_22(var_2_21, var_3(var_4))

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
	local var_3_7 = arg_3_0.confirmBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	arg_7_0.battleCntTxt.text = arg_7_1.battleCnt
	arg_7_0.damageTxt.text = arg_7_1.damage
	arg_7_0.oilTxt.text = arg_7_1.oil

	var_0_1.super.Show(arg_7_0)

	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
