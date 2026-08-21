local var_0_0 = class("BattleActivityBossResultLayer", import(".BattleResultLayer"))

function var_0_0.showRightBottomPanel(arg_1_0)
	local var_1_0 = arg_1_0._blurConatiner:Find("activitybossConfirmPanel")

	setActive(var_1_0, true)
	var_0_0.super.showRightBottomPanel(arg_1_0)
	SetActive(arg_1_0._rightBottomPanel, false)

	local var_1_1 = arg_1_0.contextData.system

	setActive(var_1_0:Find("playAgain"), arg_1_0.contextData.system ~= SYSTEM_BOSS_EXPERIMENT)
	onButton(arg_1_0, var_1_0:Find("statisticsBtn"), function()
		local var_2_0 = arg_1_0._atkBG.gameObject.activeSelf and var_0

		setActive(var_1_0:Find("playAgain"), var_2_0)
		triggerButton(arg_1_0._statisticsBtn)

		return
	end, SFX_PANEL)
	setText(var_1_0:Find("confirmBtn/Image"), i18n("text_confirm"))
	onButton(arg_1_0, var_1_0:Find("confirmBtn"), function()
		triggerButton(arg_1_0._confirmBtn)

		return
	end, SFX_CONFIRM)
	setText(var_1_0:Find("confirmBtn/Image"), i18n("text_confirm"))
	setText(var_1_0:Find("playAgain/Image"), i18n("re_battle"))
	setText(var_1_0:Find("playAgain/bonus/title"), i18n("expedition_extra_drop_tip"))

	local var_1_2 = var_1_0:Find("playAgain/bonus")
	local var_1_3 = var_1_0:Find("playAgain/ticket")
	local var_1_4 = getProxy(ActivityProxy):getActivityById(arg_1_0.contextData.actId)
	local var_1_5 = pg.activity_event_worldboss[var_1_4:getConfig("config_id")]
	local var_1_6 = var_1_5.ticket
	local var_1_7 = var_1_4:GetStageBonus(arg_1_0.contextData.stageId)
	local var_1_8 = 0
	local var_1_9 = var_1_5.use_oil_limit[arg_1_0.contextData.mainFleetId]
	local var_1_11 = getProxy(FleetProxy):getActivityFleets()[arg_1_0.contextData.actId][arg_1_0.contextData.mainFleetId]

	if var_1_4:IsOilLimit(arg_1_0.contextData.stageId) then
		local var_1_12 = var_1_5.use_oil_limit[arg_1_0.contextData.mainFleetId][1] or 0

		var_1_10(var_1_11, var_1_12)
		setText(var_1_0:Find("playAgain/Text"), var_1_8)

		local var_1_13
		local var_1_14

		setActive(var_1_2, var_1_7 > 0)
		setActive(var_1_3, var_1_7 <= 0)
		setText(var_1_2:Find("Text"), var_1_7)

		if var_1_7 <= 0 then
			setImageSprite(var_1_3:Find("icon"), (GetSpriteFromAtlas(Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = var_1_6
			}):getIcon(), "")))

			local var_1_15 = getProxy(PlayerProxy):getRawData():getResource(var_1_6)

			var_1_14 = getProxy(SettingsProxy):isTipActBossExchangeTicket() == 1
			var_1_13 = var_1_15 > 0

			local var_1_16 = 1
			local var_1_17 = var_1_3:Find("checkbox")

			if var_1_1 == SYSTEM_BOSS_EXPERIMENT then
				var_1_16 = 0

				triggerToggle(var_1_17, false)
				setToggleEnabled(var_1_17, false)
			elseif var_1_1 == SYSTEM_HP_SHARE_ACT_BOSS then
				triggerToggle(var_1_17, true)
				setToggleEnabled(var_1_17, false)
			elseif var_1_1 == SYSTEM_ACT_BOSS then
				setToggleEnabled(var_1_17, var_1_13)
				triggerToggle(var_1_17, var_1_13 and var_1_14)
			end

			var_1_15 = var_1_15 < var_1_16 and setColorStr(var_1_15, COLOR_RED) or var_1_15

			setText(var_1_3:Find("Text"), var_1_16 .. "/" .. var_1_15)
			onToggle(arg_1_0, var_1_17, function(arg_5_0)
				var_1_14 = arg_5_0

				getProxy(SettingsProxy):setActBossExchangeTicketTip(arg_5_0 and 1 or 0)

				return
			end, SFX_PANEL, SFX_CANCEL)
		end

		onButton(arg_1_0, var_1_0:Find("playAgain"), function()
			if arg_1_0.contextData.isLastBonus then
				arg_1_0:PassMsgbox("lastBonus", {
					content = i18n("expedition_drop_use_out")
				})

				return
			end

			local var_6_0

			if var_1_1 == SYSTEM_HP_SHARE_ACT_BOSS and not var_1_13 then
				pg.m02:sendNotification(GAME.GO_BACK)
				pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noTicket"))

				do return end

				var_6_0 = getProxy(PlayerProxy)
			end

			if pg.battle_cost_template[arg_1_0.contextData.system].oil_cost > 0 and var_6_0:getRawData().oil < var_1_8 then
				arg_1_0:PassMsgbox("oil", var_1_8)

				return
			end

			local var_6_1 = getProxy(BayProxy)

			if var_6_1:getShipCount() >= getProxy(PlayerProxy):getRawData():getMaxShipBag() then
				arg_1_0:PassMsgbox("shipCapacity")

				return
			end

			local var_6_2 = var_0[arg_1_0.contextData.mainFleetId]

			if _.any(_.values(var_0[arg_1_0.contextData.mainFleetId].ships), function(arg_7_0)
				local var_7_0 = getProxy(BayProxy):getShipById(arg_7_0)

				return var_7_0 and var_7_0.energy == Ship.ENERGY_LOW
			end) then
				arg_1_0:PassMsgbox("energy", var_6_2)

				return
			end

			if var_1_1 == SYSTEM_ACT_BOSS and var_1_13 and var_1_14 then
				pg.m02:sendNotification(GAME.ACT_BOSS_EXCHANGE_TICKET, {
					stageId = var_0
				})

				return
			end

			arg_1_0:emit(NewBattleResultMediator.REENTER_STAGE)

			return
		end)

		return
	end
end

function var_0_0.PassMsgbox(arg_8_0, arg_8_1, arg_8_2)
	getProxy(ContextProxy):GetPrevContext(1).data.msg = {
		type = arg_8_1,
		param = arg_8_2
	}

	pg.m02:sendNotification(GAME.GO_BACK)

	return
end

function var_0_0.HideConfirmPanel(arg_9_0)
	setActive(arg_9_0._blurConatiner:Find("activitybossConfirmPanel"), false)

	return
end

return var_0_0
