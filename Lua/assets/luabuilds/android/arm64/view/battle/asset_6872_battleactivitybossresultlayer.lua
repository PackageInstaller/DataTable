local BattleActivityBossResultLayer = class("BattleActivityBossResultLayer", import(".BattleResultLayer"))

function BattleActivityBossResultLayer:showRightBottomPanel()
	local var_1_0 = self._blurConatiner:Find("activitybossConfirmPanel")

	setActive(var_1_0, true)
	BattleActivityBossResultLayer.super.showRightBottomPanel(self)
	SetActive(self._rightBottomPanel, false)

	local var_1_1 = self.contextData.system
	local var_1_2 = self.contextData.system ~= SYSTEM_BOSS_EXPERIMENT

	setActive(var_1_0:Find("playAgain"), self.contextData.system ~= SYSTEM_BOSS_EXPERIMENT)
	onButton(self, var_1_0:Find("statisticsBtn"), function()
		setActive(var_1_0:Find("playAgain"), self._atkBG.gameObject.activeSelf and var_1_2)
		triggerButton(self._statisticsBtn)

		return
	end, SFX_PANEL)
	setText(var_1_0:Find("confirmBtn/Image"), i18n("text_confirm"))
	onButton(self, var_1_0:Find("confirmBtn"), function()
		triggerButton(self._confirmBtn)

		return
	end, SFX_CONFIRM)
	setText(var_1_0:Find("confirmBtn/Image"), i18n("text_confirm"))
	setText(var_1_0:Find("playAgain/Image"), i18n("re_battle"))
	setText(var_1_0:Find("playAgain/bonus/title"), i18n("expedition_extra_drop_tip"))

	local var_1_3 = getProxy(FleetProxy):getActivityFleets()[self.contextData.actId]
	local var_1_4 = var_1_0:Find("playAgain/bonus")
	local var_1_5 = var_1_0:Find("playAgain/ticket")
	local var_1_6 = getProxy(ActivityProxy):getActivityById(self.contextData.actId)
	local var_1_7 = self.contextData.stageId
	local var_1_8 = pg.activity_event_worldboss[var_1_6:getConfig("config_id")]
	local var_1_9 = var_1_8.ticket
	local var_1_10 = var_1_6:GetStageBonus(self.contextData.stageId)
	local var_1_11 = 0
	local var_1_12 = var_1_8.use_oil_limit[self.contextData.mainFleetId]

	;(function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_0:GetCostSum().oil

		if arg_4_1 > 0 then
			var_4_0 = math.min(var_4_0, var_1_12[1])
		end

		var_1_11 = var_1_11 + var_4_0

		return
	end)(var_1_3[self.contextData.mainFleetId], (var_1_6:IsOilLimit(self.contextData.stageId) or nil) and (var_1_8.use_oil_limit[self.contextData.mainFleetId][1] or 0))
	setText(var_1_0:Find("playAgain/Text"), var_1_11)

	local var_1_15
	local var_1_16

	setActive(var_1_4, var_1_10 > 0)
	setActive(var_1_5, var_1_10 <= 0)
	setText(var_1_4:Find("Text"), var_1_10)

	if var_1_10 <= 0 then
		setImageSprite(var_1_5:Find("icon"), (GetSpriteFromAtlas(Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = var_1_9
		}):getIcon(), "")))

		local var_1_17 = getProxy(PlayerProxy):getRawData():getResource(var_1_9)

		var_1_16 = getProxy(SettingsProxy):isTipActBossExchangeTicket() == 1
		var_1_15 = var_1_17 > 0

		local var_1_18 = 1
		local var_1_19 = var_1_5:Find("checkbox")

		if var_1_1 == SYSTEM_BOSS_EXPERIMENT then
			var_1_18 = 0

			triggerToggle(var_1_19, false)
			setToggleEnabled(var_1_19, false)
		elseif var_1_1 == SYSTEM_HP_SHARE_ACT_BOSS then
			triggerToggle(var_1_19, true)
			setToggleEnabled(var_1_19, false)
		elseif var_1_1 == SYSTEM_ACT_BOSS then
			setToggleEnabled(var_1_19, var_1_15)
			triggerToggle(var_1_19, var_1_15 and var_1_16)
		end

		var_1_17 = var_1_17 < var_1_18 and setColorStr(var_1_17, COLOR_RED) or var_1_17

		setText(var_1_5:Find("Text"), var_1_18 .. "/" .. var_1_17)
		onToggle(self, var_1_19, function(arg_5_0)
			var_1_16 = arg_5_0

			getProxy(SettingsProxy):setActBossExchangeTicketTip(arg_5_0 and 1 or 0)

			return
		end, SFX_PANEL, SFX_CANCEL)
	end

	onButton(self, var_1_0:Find("playAgain"), function()
		if self.contextData.isLastBonus then
			self:PassMsgbox("lastBonus", {
				content = i18n("expedition_drop_use_out")
			})

			return
		end

		local var_6_0

		if var_1_1 == SYSTEM_HP_SHARE_ACT_BOSS and not var_1_15 then
			pg.m02:sendNotification(GAME.GO_BACK)
			pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_noTicket"))

			do return end

			var_6_0 = getProxy(PlayerProxy)
		end

		if pg.battle_cost_template[self.contextData.system].oil_cost > 0 and var_6_0:getRawData().oil < var_1_11 then
			self:PassMsgbox("oil", var_1_11)

			return
		end

		if getProxy(BayProxy):getShipCount() >= getProxy(PlayerProxy):getRawData():getMaxShipBag() then
			self:PassMsgbox("shipCapacity")

			return
		end

		if _.any(_.values(var_1_3[self.contextData.mainFleetId].ships), function(arg_7_0)
			local var_7_0 = getProxy(BayProxy):getShipById(arg_7_0)

			return var_7_0 and var_7_0.energy == Ship.ENERGY_LOW
		end) then
			self:PassMsgbox("energy", var_1_3[self.contextData.mainFleetId])

			return
		end

		if var_1_1 == SYSTEM_ACT_BOSS and var_1_15 and var_1_16 then
			pg.m02:sendNotification(GAME.ACT_BOSS_EXCHANGE_TICKET, {
				stageId = var_1_7
			})

			return
		end

		self:emit(NewBattleResultMediator.REENTER_STAGE)

		return
	end)

	return
end

function BattleActivityBossResultLayer:PassMsgbox(arg_8_1, arg_8_2)
	getProxy(ContextProxy):GetPrevContext(1).data.msg = {
		type = arg_8_1,
		param = arg_8_2
	}

	pg.m02:sendNotification(GAME.GO_BACK)

	return
end

function BattleActivityBossResultLayer:HideConfirmPanel()
	setActive(self._blurConatiner:Find("activitybossConfirmPanel"), false)

	return
end

return BattleActivityBossResultLayer
