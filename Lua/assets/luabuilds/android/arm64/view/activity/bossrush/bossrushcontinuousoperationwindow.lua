local var_0_0 = class("BossRushContinuousOperationWindow", import("view.activity.worldboss.ContinuousOperationWindow"))

function var_0_0.getUIName(arg_1_0)
	return "BossRushContinuousOperationWindowUI"
end

function var_0_0.ResUISettings(arg_2_0)
	return {
		reset = true,
		gemOffsetX = 628,
		showType = PlayerResUI.TYPE_OIL
	}
end

function var_0_0.init(arg_3_0)
	arg_3_0.panel = arg_3_0._tf:Find("window/panel")
	arg_3_0._countSelect = arg_3_0.panel:Find("content")
	arg_3_0._pageUtil = PageUtil.New(arg_3_0._countSelect:Find("value_bg/left"), arg_3_0._countSelect:Find("value_bg/right"), arg_3_0._countSelect:Find("max"), arg_3_0._countSelect:Find("value_bg/value"))
	arg_3_0.consumeText = arg_3_0.panel:Find("content/consume"):GetComponent("RichText")

	setText(arg_3_0._tf:Find("window/top/bg/title/title"), i18n("multiple_sorties_title"))
	setText(arg_3_0._tf:Find("window/top/bg/title/title/title_en"), i18n("multiple_sorties_title_eng"))
	setText(arg_3_0.panel:Find("content/desc_txt"), i18n("multiple_sorties_times"))
	setText(arg_3_0.panel:Find("Tip"), i18n("multiple_sorties_tip"))
	setText(arg_3_0.panel:Find("battle/pic"), i18n("msgbox_text_battle"))
	setText(arg_3_0.panel:Find("bonus/Text"), i18n("expedition_extra_drop_tip"))
	setText(arg_3_0.panel:Find("ticket/Text"), i18n("multiple_sorties_challenge_ticket_use"))

	return
end

function var_0_0.SetActivity(arg_4_0, arg_4_1)
	arg_4_0.activity = arg_4_1

	return
end

function var_0_0.didEnter(arg_5_0)
	onButton(arg_5_0, arg_5_0.panel:Find("battle"), function()
		if arg_5_0.contextData.oilCost * arg_5_0.contextData.battleTimes > getProxy(PlayerProxy):getRawData().oil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noResource"))

			return
		end

		arg_5_0:emit(PreCombatMediator.CONTINUOUS_OPERATION)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0._tf:Find("window/top/btnBack"), function()
		arg_5_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_5_0, arg_5_0._tf:Find("bg"), function()
		arg_5_0:closeView()

		return
	end, SFX_CANCEL)
	arg_5_0._pageUtil:setNumUpdate(function(arg_9_0)
		arg_5_0.contextData.battleTimes = arg_9_0

		arg_5_0:UpdateContent()

		return
	end)
	arg_5_0._pageUtil:setMaxNum(arg_5_0.contextData.maxCount)

	arg_5_0.contextData.battleTimes = arg_5_0.contextData.battleTimes or 1

	arg_5_0._pageUtil:setDefaultNum(arg_5_0.contextData.battleTimes)
	arg_5_0:UpdateContent()
	pg.UIMgr.GetInstance():BlurPanel(arg_5_0._tf)

	return
end

function var_0_0.UpdateContent(arg_10_0)
	local var_10_0 = i18n("multiple_sorties_cost1", arg_10_0.contextData.oilCost * arg_10_0.contextData.battleTimes)

	if arg_10_0.contextData.oilCost * arg_10_0.contextData.battleTimes > getProxy(PlayerProxy):getRawData().oil then
		var_10_0 = string.gsub(var_10_0, "#92fc63", COLOR_RED)
	end

	arg_10_0.consumeText.text = var_10_0

	return
end

return var_0_0
