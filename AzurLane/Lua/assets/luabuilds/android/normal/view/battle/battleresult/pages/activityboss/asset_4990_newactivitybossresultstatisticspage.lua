class = var_0_10000

local var_0_0 = "NewActivityBossResultStatisticsPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..NewBattleResultStatisticsPage"))

function var_0_1.UpdateCommanders(arg_1_0, arg_1_1)
	parallelAsync = var_1_10002

	var_1_10002({
		function(arg_2_0)
			var_0_1.super.UpdateCommanders(arg_1_0, arg_2_0)

			return
		end,
		function(arg_3_0)
			local var_3_0 = arg_1_0

			var_1.LoadActivityBossRes(var_3_0, arg_3_0)

			return
		end
	}, arg_1_1)

	return
end

local function var_0_2(arg_4_0, arg_4_1, arg_4_2)
	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_4_0 = var_1_10003(var_1_10004)
	local var_4_1 = var_3.RawGetActivityById(var_4_0, arg_4_0)
	local var_4_2 = var_3.getConfig(var_4_1, "config_id")

	pg = var_4_1

	local var_4_3 = var_4_1.activity_event_worldboss[var_4_2]
	local var_4_4 = var_3:IsOilLimit(arg_4_1)
	local var_4_5 = 0
	local var_4_6 = var_4_3.use_oil_limit[arg_4_2]

	getProxy = var_1_10009
	FleetProxy = var_1_10010

	local var_4_7 = var_1_10009(var_1_10010)
	local var_4_8 = var_9.getActivityFleets(var_4_7)[arg_4_0][arg_4_2]
	local var_4_9 = var_11.GetCostSum(var_4_8).oil

	if var_4_4 and var_4_6[1] > 0 then
		math = var_13
		var_4_9 = var_13.min(var_4_9, var_4_6[1])
	end

	return var_4_5 + var_4_9
end

local function var_0_3(arg_5_0, arg_5_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_5_0 = var_1_10002(var_1_10003)
	local var_5_1 = var_2.RawGetActivityById(var_5_0, arg_5_0)

	return (var_2.GetStageBonus(var_5_1, arg_5_1))
end

function var_0_1.GetTicketItemID(arg_6_0, arg_6_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_6_0 = var_1_10002(var_1_10003)
	local var_6_1 = var_2.RawGetActivityById(var_6_0, arg_6_1)
	local var_6_2 = var_2.getConfig(var_6_1, "config_id")

	pg = var_6_1

	return var_6_1.activity_event_worldboss[var_6_2].ticket
end

function var_0_1.GetTicketUseCount(arg_7_0)
	return 1
end

function var_0_1.GetOilCost(arg_8_0)
	pg = var_1_10001

	if not (var_1_10001.battle_cost_template[arg_8_0.contextData.system].oil_cost > 0) then
		return 0
	end

	return var_0_2(arg_8_0.contextData.actId, arg_8_0.contextData.stageId, arg_8_0.contextData.mainFleetId)
end

function var_0_1.InitActivityPanel(arg_9_0, arg_9_1)
	arg_9_1:SetAsFirstSibling()

	arg_9_0.playAgain = arg_9_1:Find("playAgain")
	arg_9_0.toggle = arg_9_1:Find("playAgain/ticket/checkbox")

	local var_9_0 = arg_9_0:GetOilCost()
	local var_9_1 = var_0_3(arg_9_0.contextData.actId, arg_9_0.contextData.stageId)

	setActive = var_4

	var_4(arg_9_1:Find("playAgain/bonus"), var_9_1 > 0)

	setActive = var_4

	var_4(arg_9_1:Find("playAgain/ticket"), var_9_1 <= 0)

	setText = var_4

	var_4(arg_9_1:Find("playAgain/bonus/Text"), var_9_1)

	if var_9_1 <= 0 then
		arg_9_0:UpdateTicket(arg_9_1)
	end

	setText = var_4

	var_4(arg_9_1:Find("playAgain/Text"), var_9_0)

	setText = var_4

	local var_9_2 = arg_9_1
	local var_9_3 = arg_9_1.Find(var_9_2, "playAgain/Image")

	i18n = var_9_2

	var_4(var_9_3, var_9_2("re_battle"))

	setText = var_4

	local var_9_4 = arg_9_1
	local var_9_5 = arg_9_1.Find(var_9_4, "playAgain/bonus/title")

	i18n = var_9_4

	var_4(var_9_5, var_9_4("expedition_extra_drop_tip"))

	return
end

function var_0_1.UpdateTicket(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.GetTicketItemID(var_10_0, arg_10_0.contextData.actId)

	GetSpriteFromAtlas = var_10_0
	Drop = var_4

	local var_10_2 = var_4.New
	local var_10_3 = {}

	DROP_TYPE_RESOURCE = var_1_10006
	var_10_3.type = var_1_10006
	var_10_3.id = var_10_1

	local var_10_4 = var_10_2(var_10_3)
	local var_10_5 = var_10_0(var_4.getIcon(var_10_4), "")

	setImageSprite = var_4

	var_4(arg_10_1:Find("playAgain/ticket/icon"), var_10_5)

	getProxy = var_4
	PlayerProxy = var_5

	local var_10_6 = var_4(var_5)
	local var_10_7 = var_4.getRawData(var_10_6)
	local var_10_8 = var_4.getResource(var_10_7, var_10_1)
	local var_10_9 = arg_10_0:GetTicketUseCount()
	local var_10_10 = var_10_8 > 0

	if var_10_8 < var_10_9 then
		setColorStr = var_7

		local var_10_11 = var_10_8

		COLOR_RED = var_1_10009
		var_10_8 = var_7(var_10_11, var_1_10009) or var_10_8
	end

	setText = var_7

	var_7(arg_10_1:Find("playAgain/ticket/Text"), var_10_9 .. "/" .. var_10_8)

	getProxy = var_7
	SettingsProxy = var_8

	local var_10_12 = var_7(var_8)
	local var_10_13 = var_7.isTipActBossExchangeTicket(var_10_12) == 1

	setToggleEnabled = var_10_12

	var_10_12(arg_10_0.toggle, var_10_10)

	triggerToggle = var_10_12

	var_10_12(arg_10_0.toggle, var_10_10 and var_10_13)

	return
end

function var_0_1.LoadActivityBossRes(arg_11_0, arg_11_1)
	ResourceMgr = var_1_10002

	local var_11_0 = var_1_10002.Inst
	local var_11_1 = var_2.getAssetAsync
	local var_11_2 = "BattleResultItems/Activityboss"
	local var_11_3 = ""

	UnityEngine = var_1_10006

	var_11_1(var_11_0, var_11_2, var_11_3, var_1_10006.Events.UnityAction_UnityEngine_Object(function(arg_12_0)
		if arg_11_0.exited then
			return
		end

		Object = var_1

		local var_12_0 = var_1.Instantiate(arg_12_0, arg_11_0.bottomPanel)
		local var_12_1 = arg_11_0

		var_2.InitActivityPanel(var_12_1, var_12_0.transform)
		arg_11_1()

		return
	end), true, true)

	return
end

function var_0_1.RegisterEvent(arg_13_0, arg_13_1)
	var_0_1.super.RegisterEvent(arg_13_0, arg_13_1)

	onToggle = var_2

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.toggle

	local function var_13_2(arg_14_0)
		getProxy = var_2_10001
		SettingsProxy = var_2_10002

		local var_14_0 = var_2_10001(var_2_10002)

		var_1.setActBossExchangeTicketTip(var_14_0, arg_14_0 and 1 or 0)

		return
	end

	SFX_PANEL = var_1_10006
	SFX_CANCEL = var_1_10007

	var_2(var_13_0, var_13_1, var_13_2, var_1_10006, var_1_10007)

	onButton = var_2

	local var_13_3 = arg_13_0
	local var_13_4 = arg_13_0.playAgain

	local function var_13_5()
		local var_15_0 = arg_13_0

		var_0.OnPlayAgain(var_15_0, arg_13_1)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_13_3, var_13_4, var_13_5, var_1_10006)

	return
end

function var_0_1.IsLastBonus(arg_16_0)
	return arg_16_0.contextData.isLastBonus
end

function var_0_1.NotEnoughOilCost(arg_17_0)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.GetOilCost(var_17_0)

	getProxy = var_17_0
	PlayerProxy = var_1_10003

	local var_17_2 = var_17_0(var_1_10003)

	if var_17_1 > var_2.getRawData(var_17_2).oil then
		return true, var_17_1
	end

	return false
end

function var_0_1.NotEnoughShipBag(arg_18_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_18_0 = var_1_10001(var_1_10002)
	local var_18_1 = var_1.getShipCount(var_18_0)

	getProxy = var_18_0
	PlayerProxy = var_1_10003

	local var_18_2 = var_18_0(var_1_10003)
	local var_18_3 = var_2.getRawData(var_18_2)

	if var_18_1 >= var_2.getMaxShipBag(var_18_3) then
		return true
	end

	return false
end

function var_0_1.NotEnoughEnergy(arg_19_0)
	getProxy = var_1_10001
	FleetProxy = var_1_10002

	local var_19_0 = var_1_10001(var_1_10002)
	local var_19_1 = var_1.getActivityFleets(var_19_0)[arg_19_0.contextData.actId][arg_19_0.contextData.mainFleetId]

	_ = var_1_10004

	local var_19_2 = var_1_10004.any

	_ = var_1_10005

	if var_19_2(var_1_10005.values(var_19_1.ships), function(arg_20_0)
		getProxy = var_2_10001
		BayProxy = var_2_10002

		local var_20_0 = var_2_10001(var_2_10002)

		if var_1.getShipById(var_20_0, arg_20_0) then
			::label_20_0::

			var_20_0 = var_1.energy
			Ship = var_3
			var_20_0 = var_20_0 == var_3.ENERGY_LOW
		end

		return var_20_0
	end) then
		return true, var_19_1
	end

	return false
end

function var_0_1.NotEnoughTicket(arg_21_0)
	if var_0_3(arg_21_0.contextData.actId, arg_21_0.contextData.stageId) > 0 then
		return false
	end

	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.GetTicketItemID(var_21_0, arg_21_0.contextData.actId)

	getProxy = var_21_0
	PlayerProxy = var_4

	local var_21_2 = var_21_0(var_4)
	local var_21_3 = var_3.getRawData(var_21_2)
	local var_21_4 = var_3.getResource(var_21_3, var_21_1)

	getProxy = var_21_3
	SettingsProxy = var_5

	local var_21_5 = var_21_3(var_5)
	local var_21_6 = var_4.isTipActBossExchangeTicket(var_21_5) == 1

	if var_21_4 > 0 and var_21_6 then
		return true
	end

	return false
end

function var_0_1.OnPlayAgain(arg_22_0, arg_22_1)
	if arg_22_0:IsLastBonus() then
		local var_22_0 = arg_22_0
		local var_22_1 = arg_22_0.PassMsgbox
		local var_22_2 = "lastBonus"
		local var_22_3 = {}

		i18n = var_1_10006
		var_22_3.content = var_1_10006("expedition_drop_use_out")

		var_22_1(var_22_0, var_22_2, var_22_3, arg_22_1)

		return
	end

	local var_22_4, var_22_5 = arg_22_0:NotEnoughOilCost()

	if var_22_4 then
		arg_22_0:PassMsgbox("oil", var_22_5, arg_22_1)

		return
	end

	if arg_22_0:NotEnoughShipBag() then
		arg_22_0:PassMsgbox("shipCapacity", nil, arg_22_1)

		return
	end

	local var_22_6, var_22_7 = arg_22_0:NotEnoughEnergy()

	if var_22_6 then
		arg_22_0:PassMsgbox("energy", var_22_7, arg_22_1)

		return
	end

	if arg_22_0:NotEnoughTicket() then
		pg = var_6

		local var_22_8 = var_6.m02
		local var_22_9 = var_6.sendNotification

		GAME = var_1_10008

		var_22_9(var_22_8, var_1_10008.ACT_BOSS_EXCHANGE_TICKET, {
			stageId = arg_22_0.contextData.stageId
		})

		return
	end

	local var_22_10 = arg_22_0
	local var_22_11 = arg_22_0.emit

	NewBattleResultMediator = var_1_10008

	var_22_11(var_22_10, var_1_10008.REENTER_STAGE)

	return
end

function var_0_1.PassMsgbox(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	getProxy = var_1_10004
	ContextProxy = var_1_10005

	local var_23_0 = var_1_10004(var_1_10005)

	var_4.GetPrevContext(var_23_0, 1).data.msg = {
		type = arg_23_1,
		param = arg_23_2
	}

	arg_23_3()

	return
end

return var_0_1
