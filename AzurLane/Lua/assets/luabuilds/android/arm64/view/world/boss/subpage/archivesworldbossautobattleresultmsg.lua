local var_0_0 = class("ArchivesWorldBossAutoBattleResultMsg", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "ArchivesWorldBossAutoBattleResultUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("window/top/close")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("window/btns/start")

	setText(arg_2_0._tf:Find("window/top/title"), i18n("world_boss_title_auto_battle"))
	setText(arg_2_0._tf:Find("window/msg_panel/label"), i18n("world_boss_archives_auto_battle_reusle_title"))
	setText(arg_2_0._tf:Find("window/msg_panel/battle_cnt/label"), i18n("world_boss_title_battle_cnt"))
	setText(arg_2_0._tf:Find("window/msg_panel/damage/label"), i18n("world_boss_title_total_damage"))
	setText(arg_2_0._tf:Find("window/msg_panel/oil/label"), i18n("world_boss_title_consume_oil_cnt"))
	setText(arg_2_0._tf:Find("window/btns/start/pic"), i18n("text_confirm"))

	arg_2_0.battleCntTxt = arg_2_0._tf:Find("window/msg_panel/battle_cnt/Text"):GetComponent(typeof(Text))
	arg_2_0.damageTxt = arg_2_0._tf:Find("window/msg_panel/damage/Text"):GetComponent(typeof(Text))
	arg_2_0.oilTxt = arg_2_0._tf:Find("window/msg_panel/oil/Text"):GetComponent(typeof(Text))

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
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	arg_7_0.battleCntTxt.text = arg_7_1.battleCnt
	arg_7_0.damageTxt.text = arg_7_1.damage
	arg_7_0.oilTxt.text = arg_7_1.oil

	var_0_0.super.Show(arg_7_0)

	return
end

function var_0_0.OnDestroy(arg_8_0)
	return
end

return var_0_0
