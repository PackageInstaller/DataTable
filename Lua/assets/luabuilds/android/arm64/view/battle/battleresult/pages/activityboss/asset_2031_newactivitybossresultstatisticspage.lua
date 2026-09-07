local NewActivityBossResultStatisticsPage = class("NewActivityBossResultStatisticsPage", import("..NewBattleResultStatisticsPage"))

function NewActivityBossResultStatisticsPage:UpdateCommanders(arg_1_1)
	parallelAsync({
		function(arg_2_0)
			NewActivityBossResultStatisticsPage.super.UpdateCommanders(self, arg_2_0)

			return
		end,
		function(arg_3_0)
			self:LoadActivityBossRes(arg_3_0)

			return
		end
	}, arg_1_1)

	return
end

local function var_0_1(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = getProxy(ActivityProxy):RawGetActivityById(arg_4_0)
	local var_4_1 = pg.activity_event_worldboss[var_4_0:getConfig("config_id")].use_oil_limit[arg_4_2]
	local var_4_2 = getProxy(FleetProxy)
	local var_4_3 = var_4_2:getActivityFleets()[arg_4_0][arg_4_2].GetCostSum(var_4_2).oil

	if var_4_0:IsOilLimit(arg_4_1) and var_4_1[1] > 0 then
		var_4_3 = math.min(var_4_3, var_4_1[1])
	end

	return 0 + var_4_3
end

local function var_0_2(arg_5_0, arg_5_1)
	return (getProxy(ActivityProxy):RawGetActivityById(arg_5_0):GetStageBonus(arg_5_1))
end

function NewActivityBossResultStatisticsPage:GetTicketItemID(arg_6_1)
	return pg.activity_event_worldboss[getProxy(ActivityProxy):RawGetActivityById(arg_6_1):getConfig("config_id")].ticket
end

function NewActivityBossResultStatisticsPage:GetTicketUseCount()
	return 1
end

function NewActivityBossResultStatisticsPage:GetOilCost()
	if pg.battle_cost_template[self.contextData.system].oil_cost <= 0 then
		return 0
	end

	return var_0_1(self.contextData.actId, self.contextData.stageId, self.contextData.mainFleetId)
end

function NewActivityBossResultStatisticsPage:InitActivityPanel(arg_9_1)
	arg_9_1:SetAsFirstSibling()

	self.playAgain = arg_9_1:Find("playAgain")
	self.toggle = arg_9_1:Find("playAgain/ticket/checkbox")

	local var_9_0 = self:GetOilCost()
	local var_9_1 = var_0_2(self.contextData.actId, self.contextData.stageId)

	setActive(arg_9_1:Find("playAgain/bonus"), var_9_1 > 0)
	setActive(arg_9_1:Find("playAgain/ticket"), var_9_1 <= 0)
	setText(arg_9_1:Find("playAgain/bonus/Text"), var_9_1)

	if var_9_1 <= 0 then
		self:UpdateTicket(arg_9_1)
	end

	setText(arg_9_1:Find("playAgain/Text"), var_9_0)
	setText(arg_9_1:Find("playAgain/Image"), i18n("re_battle"))
	setText(arg_9_1:Find("playAgain/bonus/title"), i18n("expedition_extra_drop_tip"))

	return
end

function NewActivityBossResultStatisticsPage:UpdateTicket(arg_10_1)
	local var_10_0 = self:GetTicketItemID(self.contextData.actId)

	setImageSprite(arg_10_1:Find("playAgain/ticket/icon"), (GetSpriteFromAtlas(Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = var_10_0
	}):getIcon(), "")))

	local var_10_1 = getProxy(PlayerProxy):getRawData():getResource(var_10_0)
	local var_10_2 = self:GetTicketUseCount()
	local var_10_3 = var_10_1 > 0

	var_10_1 = var_10_1 < var_10_2 and setColorStr(var_10_1, COLOR_RED) or var_10_1

	setText(arg_10_1:Find("playAgain/ticket/Text"), var_10_2 .. "/" .. var_10_1)

	local var_10_4 = getProxy(SettingsProxy):isTipActBossExchangeTicket() == 1

	setToggleEnabled(self.toggle, var_10_3)
	triggerToggle(self.toggle, var_10_3 and var_10_4)

	return
end

function NewActivityBossResultStatisticsPage:LoadActivityBossRes(arg_11_1)
	ResourceMgr.Inst:getAssetAsync("BattleResultItems/Activityboss", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_12_0)
		if self.exited then
			return
		end

		self:InitActivityPanel(Object.Instantiate(arg_12_0, self.bottomPanel).transform)
		arg_11_1()

		return
	end), true, true)

	return
end

function NewActivityBossResultStatisticsPage:RegisterEvent(arg_13_1)
	NewActivityBossResultStatisticsPage.super.RegisterEvent(self, arg_13_1)
	onToggle(self, self.toggle, function(arg_14_0)
		getProxy(SettingsProxy):setActBossExchangeTicketTip(arg_14_0 and 1 or 0)

		return
	end, SFX_PANEL, SFX_CANCEL)
	onButton(self, self.playAgain, function()
		self:OnPlayAgain(arg_13_1)

		return
	end, SFX_PANEL)

	return
end

function NewActivityBossResultStatisticsPage:IsLastBonus()
	return self.contextData.isLastBonus
end

function NewActivityBossResultStatisticsPage:NotEnoughOilCost()
	local var_17_0 = self:GetOilCost()

	if var_17_0 > getProxy(PlayerProxy):getRawData().oil then
		return true, var_17_0
	end

	return false
end

function NewActivityBossResultStatisticsPage:NotEnoughShipBag()
	if getProxy(BayProxy):getShipCount() >= getProxy(PlayerProxy):getRawData():getMaxShipBag() then
		return true
	end

	return false
end

function NewActivityBossResultStatisticsPage:NotEnoughEnergy()
	if _.any(_.values(getProxy(FleetProxy):getActivityFleets()[self.contextData.actId][self.contextData.mainFleetId].ships), function(arg_20_0)
		local var_20_0 = getProxy(BayProxy):getShipById(arg_20_0)

		return var_20_0 and var_20_0.energy == Ship.ENERGY_LOW
	end) then
		return true, getProxy(FleetProxy):getActivityFleets()[self.contextData.actId][self.contextData.mainFleetId]
	end

	return false
end

function NewActivityBossResultStatisticsPage:NotEnoughTicket()
	if var_0_2(self.contextData.actId, self.contextData.stageId) > 0 then
		return false
	end

	if getProxy(PlayerProxy):getRawData():getResource((self:GetTicketItemID(self.contextData.actId))) > 0 and getProxy(SettingsProxy):isTipActBossExchangeTicket() == 1 then
		return true
	end

	return false
end

function NewActivityBossResultStatisticsPage:OnPlayAgain(arg_22_1)
	if self:IsLastBonus() then
		self:PassMsgbox("lastBonus", {
			content = i18n("expedition_drop_use_out")
		}, arg_22_1)

		return
	end

	local var_22_0, var_22_1 = self:NotEnoughOilCost()

	if var_22_0 then
		self:PassMsgbox("oil", var_22_1, arg_22_1)

		return
	end

	if self:NotEnoughShipBag() then
		self:PassMsgbox("shipCapacity", nil, arg_22_1)

		return
	end

	local var_22_2, var_22_3 = self:NotEnoughEnergy()

	if var_22_2 then
		self:PassMsgbox("energy", var_22_3, arg_22_1)

		return
	end

	if self:NotEnoughTicket() then
		pg.m02:sendNotification(GAME.ACT_BOSS_EXCHANGE_TICKET, {
			stageId = self.contextData.stageId
		})

		return
	end

	self:emit(NewBattleResultMediator.REENTER_STAGE)

	return
end

function NewActivityBossResultStatisticsPage:PassMsgbox(arg_23_1, arg_23_2, arg_23_3)
	getProxy(ContextProxy):GetPrevContext(1).data.msg = {
		type = arg_23_1,
		param = arg_23_2
	}

	arg_23_3()

	return
end

return NewActivityBossResultStatisticsPage
