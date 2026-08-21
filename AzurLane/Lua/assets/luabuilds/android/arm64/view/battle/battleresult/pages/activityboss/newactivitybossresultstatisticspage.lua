local var_0_0 = class("NewActivityBossResultStatisticsPage", import("..NewBattleResultStatisticsPage"))

function var_0_0.UpdateCommanders(arg_1_0, arg_1_1)
	parallelAsync({
		function(arg_2_0)
			var_0_0.super.UpdateCommanders(arg_1_0, arg_2_0)

			return
		end,
		function(arg_3_0)
			arg_1_0:LoadActivityBossRes(arg_3_0)

			return
		end
	}, arg_1_1)

	return
end

local function var_0_1(arg_4_0, arg_4_1, arg_4_2)
	local var_4_9000
	local var_4_0 = getProxy(ActivityProxy):RawGetActivityById(arg_4_0)
	local var_4_1 = pg.activity_event_worldboss[var_4_0:getConfig("config_id")].use_oil_limit[arg_4_2]
	local var_4_2 = getProxy(FleetProxy)
	local var_4_3 = var_4_2.getActivityFleets(var_4_9000)[arg_4_0][arg_4_2].GetCostSum(var_4_2).oil

	if var_4_0:IsOilLimit(arg_4_1) and var_4_1[1] > 0 then
		var_4_3 = math.min(var_4_3, var_4_1[1])
	end

	return 0 + var_4_3
end

local function var_0_2(arg_5_0, arg_5_1)
	return (getProxy(ActivityProxy):RawGetActivityById(arg_5_0):GetStageBonus(arg_5_1))
end

function var_0_0.GetTicketItemID(arg_6_0, arg_6_1)
	return pg.activity_event_worldboss[getProxy(ActivityProxy):RawGetActivityById(arg_6_1):getConfig("config_id")].ticket
end

function var_0_0.GetTicketUseCount(arg_7_0)
	return 1
end

function var_0_0.GetOilCost(arg_8_0)
	if pg.battle_cost_template[arg_8_0.contextData.system].oil_cost <= 0 then
		return 0
	end

	return var_0_1(arg_8_0.contextData.actId, arg_8_0.contextData.stageId, arg_8_0.contextData.mainFleetId)
end

function var_0_0.InitActivityPanel(arg_9_0, arg_9_1)
	arg_9_1:SetAsFirstSibling()

	arg_9_0.playAgain = arg_9_1:Find("playAgain")
	arg_9_0.toggle = arg_9_1:Find("playAgain/ticket/checkbox")

	local var_9_0 = arg_9_0:GetOilCost()
	local var_9_1 = var_0_2(arg_9_0.contextData.actId, arg_9_0.contextData.stageId)

	setActive(arg_9_1:Find("playAgain/bonus"), var_9_1 > 0)
	setActive(arg_9_1:Find("playAgain/ticket"), var_9_1 <= 0)
	setText(arg_9_1:Find("playAgain/bonus/Text"), var_9_1)

	if var_9_1 <= 0 then
		arg_9_0:UpdateTicket(arg_9_1)
	end

	setText(arg_9_1:Find("playAgain/Text"), var_9_0)
	setText(arg_9_1:Find("playAgain/Image"), i18n("re_battle"))
	setText(arg_9_1:Find("playAgain/bonus/title"), i18n("expedition_extra_drop_tip"))

	return
end

function var_0_0.UpdateTicket(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:GetTicketItemID(arg_10_0.contextData.actId)

	setImageSprite(arg_10_1:Find("playAgain/ticket/icon"), (GetSpriteFromAtlas(Drop.New({
		type = DROP_TYPE_RESOURCE,
		id = var_10_0
	}):getIcon(), "")))

	local var_10_1 = getProxy(PlayerProxy):getRawData():getResource(var_10_0)
	local var_10_2 = arg_10_0:GetTicketUseCount()
	local var_10_3 = var_10_1 > 0

	var_10_1 = var_10_1 < var_10_2 and setColorStr(var_10_1, COLOR_RED) or var_10_1

	setText(arg_10_1:Find("playAgain/ticket/Text"), var_10_2 .. "/" .. var_10_1)

	local var_10_4 = getProxy(SettingsProxy):isTipActBossExchangeTicket() == 1

	setToggleEnabled(arg_10_0.toggle, var_10_3)
	triggerToggle(arg_10_0.toggle, var_10_3 and var_10_4)

	return
end

function var_0_0.LoadActivityBossRes(arg_11_0, arg_11_1)
	ResourceMgr.Inst:getAssetAsync("BattleResultItems/Activityboss", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_12_0)
		if arg_11_0.exited then
			return
		end

		arg_11_0:InitActivityPanel(Object.Instantiate(arg_12_0, arg_11_0.bottomPanel).transform)
		arg_11_1()

		return
	end), true, true)

	return
end

function var_0_0.RegisterEvent(arg_13_0, arg_13_1)
	var_0_0.super.RegisterEvent(arg_13_0, arg_13_1)
	onToggle(arg_13_0, arg_13_0.toggle, function(arg_14_0)
		getProxy(SettingsProxy):setActBossExchangeTicketTip(arg_14_0 and 1 or 0)

		return
	end, SFX_PANEL, SFX_CANCEL)
	onButton(arg_13_0, arg_13_0.playAgain, function()
		arg_13_0:OnPlayAgain(arg_13_1)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.IsLastBonus(arg_16_0)
	return arg_16_0.contextData.isLastBonus
end

function var_0_0.NotEnoughOilCost(arg_17_0)
	local var_17_0 = arg_17_0:GetOilCost()

	if var_17_0 > getProxy(PlayerProxy):getRawData().oil then
		return true, var_17_0
	end

	return false
end

function var_0_0.NotEnoughShipBag(arg_18_0)
	if getProxy(BayProxy):getShipCount() >= getProxy(PlayerProxy):getRawData():getMaxShipBag() then
		return true
	end

	return false
end

function var_0_0.NotEnoughEnergy(arg_19_0)
	local var_19_0 = getProxy(FleetProxy):getActivityFleets()[arg_19_0.contextData.actId]

	if _.any(_.values(var_19_0[arg_19_0.contextData.mainFleetId].ships), function(arg_20_0)
		local var_20_0 = getProxy(BayProxy):getShipById(arg_20_0)

		return var_20_0 and var_20_0.energy == Ship.ENERGY_LOW
	end) then
		return true, var_19_0[arg_19_0.contextData.mainFleetId]
	end

	return false
end

function var_0_0.NotEnoughTicket(arg_21_0)
	if var_0_2(arg_21_0.contextData.actId, arg_21_0.contextData.stageId) > 0 then
		return false
	end

	local var_21_0 = getProxy(PlayerProxy):getRawData():getResource((arg_21_0:GetTicketItemID(arg_21_0.contextData.actId)))
	local var_21_1 = getProxy(SettingsProxy):isTipActBossExchangeTicket() == 1

	if var_21_0 > 0 and var_21_1 then
		return true
	end

	return false
end

function var_0_0.OnPlayAgain(arg_22_0, arg_22_1)
	if arg_22_0:IsLastBonus() then
		arg_22_0:PassMsgbox("lastBonus", {
			content = i18n("expedition_drop_use_out")
		}, arg_22_1)

		return
	end

	local var_22_0, var_22_1 = arg_22_0:NotEnoughOilCost()

	if var_22_0 then
		arg_22_0:PassMsgbox("oil", var_22_1, arg_22_1)

		return
	end

	if arg_22_0:NotEnoughShipBag() then
		arg_22_0:PassMsgbox("shipCapacity", nil, arg_22_1)

		return
	end

	local var_22_2, var_22_3 = arg_22_0:NotEnoughEnergy()

	if var_22_2 then
		arg_22_0:PassMsgbox("energy", var_22_3, arg_22_1)

		return
	end

	if arg_22_0:NotEnoughTicket() then
		pg.m02:sendNotification(GAME.ACT_BOSS_EXCHANGE_TICKET, {
			stageId = arg_22_0.contextData.stageId
		})

		return
	end

	arg_22_0:emit(NewBattleResultMediator.REENTER_STAGE)

	return
end

function var_0_0.PassMsgbox(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	getProxy(ContextProxy):GetPrevContext(1).data.msg = {
		type = arg_23_1,
		param = arg_23_2
	}

	arg_23_3()

	return
end

return var_0_0
