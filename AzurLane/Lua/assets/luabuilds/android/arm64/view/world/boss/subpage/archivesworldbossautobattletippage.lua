local var_0_0 = class("ArchivesWorldBossAutoBattleTipPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "ArchivesWorldBossAutoBattleTipUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("window/top/close")
	arg_2_0.startBtn = arg_2_0._tf:Find("window/btns/start")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("window/btns/cancel")

	setText(arg_2_0._tf:Find("window/top/title"), i18n("world_boss_title_auto_battle"))
	setText(arg_2_0._tf:Find("window/msg_panel/highest_damage/label"), i18n("world_boss_title_highest_damge"))
	setText(arg_2_0._tf:Find("window/msg_panel/label"), i18n("world_boss_title_estimation"))
	setText(arg_2_0._tf:Find("window/msg_panel/battle_cnt/label"), i18n("world_boss_title_battle_cnt"))
	setText(arg_2_0._tf:Find("window/msg_panel/oil/label"), i18n("world_boss_title_consume_oil_cnt"))
	setText(arg_2_0._tf:Find("window/msg_panel/time/label"), i18n("world_boss_title_spend_time"))
	setText(arg_2_0._tf:Find("window/btns/cancel/pic"), i18n("word_cancel"))
	setText(arg_2_0._tf:Find("window/btns/start/pic"), i18n("word_start"))

	arg_2_0.highestDamageTxt = arg_2_0._tf:Find("window/msg_panel/highest_damage/Text"):GetComponent(typeof(Text))
	arg_2_0.battleCntTxt = arg_2_0._tf:Find("window/msg_panel/battle_cnt/Text"):GetComponent(typeof(Text))
	arg_2_0.oilTxt = arg_2_0._tf:Find("window/msg_panel/oil/Text"):GetComponent(typeof(Text))
	arg_2_0.timeTxt = arg_2_0._tf:Find("window/msg_panel/time/Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.startBtn, function()
		if arg_3_0.OnYes then
			arg_3_0.OnYes()
		end

		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_8_0, arg_8_1)
	var_0_0.super.Show(arg_8_0)

	arg_8_0.highestDamageTxt.text = arg_8_1.highestDamage
	arg_8_0.battleCntTxt.text = arg_8_1.autoBattleCnt > 100 and ">100" or arg_8_1.autoBattleCnt
	arg_8_0.oilTxt.text = arg_8_1.oil
	arg_8_0.timeTxt.text = arg_8_1.time .. "MIN"
	arg_8_0.OnYes = arg_8_1.onYes

	return
end

function var_0_0.Hide(arg_9_0)
	var_0_0.super.Hide(arg_9_0)

	arg_9_0.OnYes = nil

	return
end

function var_0_0.OnDestroy(arg_10_0)
	if arg_10_0:isShowing() then
		arg_10_0:Hide()
	end

	return
end

return var_0_0
