local var_0_0 = class("ContinuousOperationWindow", import("view.base.BaseUI"))
local var_0_1 = 15

function var_0_0.getUIName(arg_1_0)
	return "ContinuousOperationWindowUI"
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

	local var_5_0 = getProxy(SettingsProxy):isTipActBossExchangeTicket() == 1

	arg_5_0.contextData.useTicket = defaultValue(arg_5_0.contextData.useTicket, var_5_0)

	triggerToggle(arg_5_0.panel:Find("ticket/checkbox"), var_5_0)
	onToggle(arg_5_0, arg_5_0.panel:Find("ticket/checkbox"), function(arg_9_0)
		arg_5_0.contextData.useTicket = arg_9_0

		arg_5_0:UpdateContent()

		return
	end, SFX_PANEL, SFX_CANCEL)

	local var_5_1 = LoadSprite(Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = pg.activity_event_worldboss[arg_5_0.activity:getConfig("config_id")].ticket
	}):getIcon(), "")

	arg_5_0.consumeText:AddSprite("ticket", var_5_1)
	setImageSprite(arg_5_0.panel:Find("ticket/Text/Icon"), var_5_1)
	arg_5_0._pageUtil:setNumUpdate(function(arg_10_0)
		arg_5_0.contextData.battleTimes = arg_10_0

		arg_5_0:UpdateContent()

		return
	end)
	arg_5_0._pageUtil:setMaxNum(var_0_1)

	arg_5_0.contextData.battleTimes = arg_5_0.contextData.battleTimes or 1

	arg_5_0._pageUtil:setDefaultNum(arg_5_0.contextData.battleTimes)
	arg_5_0:UpdateContent()
	pg.UIMgr.GetInstance():BlurPanel(arg_5_0._tf)

	return
end

function var_0_0.UpdateContent(arg_11_0)
	local var_11_0 = arg_11_0.contextData.battleTimes
	local var_11_1 = getProxy(PlayerProxy):getRawData():getResource(pg.activity_event_worldboss[arg_11_0.activity:getConfig("config_id")].ticket)
	local var_11_2 = arg_11_0.activity:GetStageBonus(arg_11_0.contextData.stageId)
	local var_11_3 = math.clamp(arg_11_0.contextData.battleTimes - var_11_2, 0, var_11_1)
	local var_11_4 = arg_11_0.contextData.useTicket and var_11_3 or 0
	local var_11_5 = tostring(var_11_2)

	if (arg_11_0.contextData.useTicket and var_11_3 or 0) > 0 then
		var_11_5 = var_11_5 .. setColorStr("+" .. var_11_4, COLOR_GREEN)
	end

	setText(arg_11_0.panel:Find("bonus/Number"), var_11_5)
	setText(arg_11_0.panel:Find("ticket/Number"), var_11_4 .. "/" .. var_11_1)

	local var_11_6 = var_11_1 > 0 and var_11_3 > 0

	setActive(arg_11_0.panel:Find("ticket/checkboxBan"), not (var_11_1 > 0 and var_11_3 > 0))
	setToggleEnabled(arg_11_0.panel:Find("ticket/checkbox"), var_11_6)

	local var_11_7 = i18n("multiple_sorties_cost1", arg_11_0.contextData.oilCost * var_11_0)

	if arg_11_0.contextData.oilCost * var_11_0 > getProxy(PlayerProxy):getRawData().oil then
		var_11_7 = string.gsub(var_11_7, "#92fc63", COLOR_RED)
	end

	if var_11_4 > 0 then
		var_11_7 = var_11_7 .. i18n("multiple_sorties_cost2", var_11_4)
	end

	arg_11_0.consumeText.text = var_11_7

	return
end

function var_0_0.willExit(arg_12_0)
	arg_12_0._pageUtil:Dispose()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_12_0._tf)

	return
end

return var_0_0
