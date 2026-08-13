class = var_0_10000

local var_0_0 = "BattleActivityBossResultLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BattleResultLayer"))

function var_0_1.showRightBottomPanel(arg_1_0)
	local var_1_0 = arg_1_0._blurConatiner
	local var_1_1 = var_1.Find(var_1_0, "activitybossConfirmPanel")

	setActive = var_1_10002

	var_1_10002(var_1_1, true)
	var_0_1.super.showRightBottomPanel(arg_1_0)

	SetActive = var_2

	var_2(arg_1_0._rightBottomPanel, false)

	local var_1_2 = arg_1_0.contextData.system

	SYSTEM_BOSS_EXPERIMENT = var_1_0

	local var_1_3 = var_1_2 ~= var_1_0

	setActive = var_4

	var_4(var_1_1:Find("playAgain"), var_1_3)

	onButton = var_4

	local var_1_4 = arg_1_0
	local var_1_5 = var_1_1
	local var_1_6 = var_1_1.Find(var_1_5, "statisticsBtn")

	local function var_1_7()
		setActive = var_2_10000

		local var_2_0 = var_1_1
		local var_2_1 = var_2.Find(var_2_0, "playAgain")
		local var_2_2

		if arg_1_0._atkBG.gameObject.activeSelf then
			var_2_2 = var_1_3
		end

		var_2_10000(var_2_1, var_2_2)

		triggerButton = var_2_10000

		var_2_10000(arg_1_0._statisticsBtn)

		return
	end

	SFX_PANEL = var_1_5

	var_4(var_1_4, var_1_6, var_1_7, var_1_5)

	setText = var_4

	local var_1_8 = var_1_1:Find("confirmBtn/Image")

	i18n = var_1_6

	var_4(var_1_8, var_1_6("text_confirm"))

	onButton = var_4

	local var_1_9 = arg_1_0
	local var_1_10 = var_1_1
	local var_1_11 = var_1_1.Find(var_1_10, "confirmBtn")

	local function var_1_12()
		triggerButton = var_2_10000

		var_2_10000(arg_1_0._confirmBtn)

		return
	end

	SFX_CONFIRM = var_1_10

	var_4(var_1_9, var_1_11, var_1_12, var_1_10)

	setText = var_4

	local var_1_13 = var_1_1:Find("confirmBtn/Image")

	i18n = var_1_11

	var_4(var_1_13, var_1_11("text_confirm"))

	setText = var_4

	local var_1_14 = var_1_1:Find("playAgain/Image")

	i18n = var_7

	var_4(var_1_14, var_7("re_battle"))

	setText = var_4

	local var_1_15 = var_1_1:Find("playAgain/bonus/title")

	i18n = var_7

	var_4(var_1_15, var_7("expedition_extra_drop_tip"))

	getProxy = var_4
	FleetProxy = var_1_15

	local var_1_16 = var_4(var_1_15)
	local var_1_17 = var_4.getActivityFleets(var_1_16)[arg_1_0.contextData.actId]
	local var_1_18 = var_1_1
	local var_1_19 = var_1_1.Find(var_1_18, "playAgain/bonus")
	local var_1_20 = var_1_1:Find("playAgain/ticket")

	getProxy = var_1_18
	ActivityProxy = var_10

	local var_1_21 = var_1_18(var_10)
	local var_1_22 = var_8.getActivityById(var_1_21, arg_1_0.contextData.actId)
	local var_1_23 = arg_1_0.contextData.stageId
	local var_1_24 = var_1_22:getConfig("config_id")

	pg = var_11

	local var_1_25 = var_11.activity_event_worldboss[var_1_24].ticket
	local var_1_26 = var_1_22:GetStageBonus(var_1_23)
	local var_1_27 = var_1_22:IsOilLimit(var_1_23)
	local var_1_28 = 0
	local var_1_29 = var_11.use_oil_limit[arg_1_0.contextData.mainFleetId]

	local function var_1_30(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_0:GetCostSum().oil

		if 0 < arg_4_1 then
			math = var_3
			var_4_0 = var_3.min(var_4_0, var_1_29[1])
		end

		var_1_28 = var_1_28 + var_4_0

		return
	end

	local var_1_31 = var_1_17[arg_1_0.contextData.mainFleetId]
	local var_1_32

	if not var_1_27 or not var_1_29[1] then
		var_1_32 = 0
	end

	var_1_30(var_1_31, var_1_32)

	setText = var_1_30

	var_1_30(var_1_1:Find("playAgain/Text"), var_1_28)

	local var_1_33
	local var_1_34

	setActive = var_20

	var_20(var_1_19, var_1_26 > 0)

	setActive = var_20

	var_20(var_1_20, var_1_26 <= 0)

	setText = var_20

	var_20(var_1_19:Find("Text"), var_1_26)

	local var_1_35

	if var_1_26 <= 0 then
		Drop = var_1_35
		var_1_35 = var_1_35.New

		local var_1_36 = {}

		DROP_TYPE_RESOURCE = var_23
		var_1_36.type = var_23
		var_1_36.id = var_1_25

		local var_1_37 = var_1_35(var_1_36)

		var_1_35 = var_1_35.getIcon(var_1_37)
		GetSpriteFromAtlas = var_21

		local var_1_38 = var_21(var_1_35, "")

		setImageSprite = var_1_37

		var_1_37(var_1_20:Find("icon"), var_1_38)

		getProxy = var_1_37
		PlayerProxy = var_24

		local var_1_39 = var_1_37(var_24)
		local var_1_40 = var_22.getRawData(var_1_39)
		local var_1_41 = var_22.getResource(var_1_40, var_1_25)

		getProxy = var_23
		SettingsProxy = var_25

		local var_1_42 = var_23(var_25)

		var_1_34 = var_23.isTipActBossExchangeTicket(var_1_42) == 1
		var_1_33 = var_1_41 > 0

		local var_1_43 = 1
		local var_1_44 = var_1_20:Find("checkbox")

		SYSTEM_BOSS_EXPERIMENT = var_1_42

		if var_1_2 == var_1_42 then
			var_1_43 = 0
			triggerToggle = var_1_42

			var_1_42(var_1_44, false)

			setToggleEnabled = var_1_42

			var_1_42(var_1_44, false)
		else
			SYSTEM_HP_SHARE_ACT_BOSS = var_1_42

			if var_1_2 == var_1_42 then
				triggerToggle = var_1_42

				var_1_42(var_1_44, true)

				setToggleEnabled = var_1_42

				var_1_42(var_1_44, false)
			else
				SYSTEM_ACT_BOSS = var_1_42

				if var_1_2 == var_1_42 then
					setToggleEnabled = var_1_42

					var_1_42(var_1_44, var_1_33)

					triggerToggle = var_1_42

					local var_1_45 = var_1_44

					var_1_10028 = var_1_33 and var_1_34

					var_1_42(var_1_45, var_1_10028)
				end
			end
		end

		if var_1_41 < var_1_43 then
			setColorStr = var_1_42

			local var_1_46 = var_1_41

			COLOR_RED = var_1_10028
			var_1_41 = var_1_42(var_1_46, var_1_10028) or var_1_41
		end

		setText = var_1_42

		var_1_42(var_1_20:Find("Text"), var_1_43 .. "/" .. var_1_41)

		onToggle = var_1_42

		local var_1_47 = arg_1_0
		local var_1_48 = var_1_44

		local function var_1_49(arg_5_0)
			var_1_34 = arg_5_0
			getProxy = var_2_10001
			SettingsProxy = var_2_10003

			local var_5_0 = var_2_10001(var_2_10003)

			var_1.setActBossExchangeTicketTip(var_5_0, arg_5_0 and 1 or 0)

			return
		end

		SFX_PANEL = var_30
		SFX_CANCEL = var_1_10031

		var_1_42(var_1_47, var_1_48, var_1_49, var_30, var_1_10031)
	end

	onButton = var_1_35

	var_1_35(arg_1_0, var_1_1:Find("playAgain"), function()
		if arg_1_0.contextData.isLastBonus then
			local var_6_0 = arg_1_0
			local var_6_1 = var_0.PassMsgbox

			var_2_10003 = "lastBonus"
			var_2_10004 = {}
			i18n = var_2_10005
			var_2_10004.content = var_2_10005("expedition_drop_use_out")

			var_6_1(var_6_0, var_2_10003, var_2_10004)

			return
		end

		local var_6_2 = var_1_2

		SYSTEM_HP_SHARE_ACT_BOSS = var_2_10001

		if var_6_2 == var_2_10001 and not var_1_33 then
			pg = var_6_2

			local var_6_3 = var_6_2.m02

			var_6_2 = var_6_2.sendNotification
			GAME = var_2_10003

			var_6_2(var_6_3, var_2_10003.GO_BACK)

			pg = var_6_2

			local var_6_4 = var_6_2.TipsMgr.GetInstance()

			var_6_2 = var_6_2.ShowTips
			i18n = var_2_10003

			var_6_2(var_6_4, var_2_10003("stage_beginStage_error_noTicket"))

			return
		end

		pg = var_6_2

		local var_6_5 = var_6_2.battle_cost_template[arg_1_0.contextData.system].oil_cost
		local var_6_6 = 0 < var_6_5

		getProxy = var_2
		PlayerProxy = var_2_10004

		local var_6_7 = var_2(var_2_10004)
		local var_6_8 = var_2.getRawData(var_6_7).oil

		if var_6_6 and var_6_8 < var_1_28 then
			var_2_10005 = arg_1_0

			var_2_10003.PassMsgbox(var_2_10005, "oil", var_1_28)

			return
		end

		getProxy = var_2_10003
		BayProxy = var_2_10005

		local var_6_9 = var_2_10003(var_2_10005)
		local var_6_10 = var_3.getShipCount(var_6_9)

		getProxy = var_6_7
		PlayerProxy = var_2_10006

		local var_6_11 = var_6_7(var_2_10006)
		local var_6_12 = var_4.getRawData(var_6_11)

		if var_6_10 >= var_4.getMaxShipBag(var_6_12) then
			var_6_12 = arg_1_0

			var_4.PassMsgbox(var_6_12, "shipCapacity")

			return
		end

		local var_6_13 = var_1_17[arg_1_0.contextData.mainFleetId]

		_ = var_5

		local var_6_14 = var_5.any

		_ = var_2_10007

		if var_6_14(var_2_10007.values(var_6_13.ships), function(arg_7_0)
			getProxy = var_3_10001
			BayProxy = var_3_10003

			local var_7_0 = var_3_10001(var_3_10003)

			if var_1.getShipById(var_7_0, arg_7_0) then
				::label_7_0::

				var_3_10002 = var_1.energy
				Ship = var_7_0
				var_3_10002 = var_3_10002 == var_7_0.ENERGY_LOW
			end

			return var_3_10002
		end) then
			local var_6_15 = arg_1_0

			var_5.PassMsgbox(var_6_15, "energy", var_6_13)

			return
		end

		local var_6_16 = var_1_2

		SYSTEM_ACT_BOSS = var_6_12

		if var_6_16 == var_6_12 and var_1_33 and var_1_34 then
			pg = var_5

			local var_6_17 = var_5.m02
			local var_6_18 = var_5.sendNotification

			GAME = var_8

			var_6_18(var_6_17, var_8.ACT_BOSS_EXCHANGE_TICKET, {
				stageId = var_1_23
			})

			return
		end

		local var_6_19 = arg_1_0
		local var_6_20 = var_5.emit

		NewBattleResultMediator = var_8

		var_6_20(var_6_19, var_8.REENTER_STAGE)

		return
	end)

	return
end

function var_0_1.PassMsgbox(arg_8_0, arg_8_1, arg_8_2)
	getProxy = var_1_10003
	ContextProxy = var_1_10005

	local var_8_0 = var_1_10003(var_1_10005)
	local var_8_1 = var_3.GetPrevContext(var_8_0, 1).data

	var_8_1.msg = {
		type = arg_8_1,
		param = arg_8_2
	}
	pg = var_8_1

	local var_8_2 = var_8_1.m02
	local var_8_3 = var_4.sendNotification

	GAME = var_1_10007

	var_8_3(var_8_2, var_1_10007.GO_BACK)

	return
end

function var_0_1.HideConfirmPanel(arg_9_0)
	local var_9_0 = arg_9_0._blurConatiner
	local var_9_1 = var_1.Find(var_9_0, "activitybossConfirmPanel")

	setActive = var_1_10002

	var_1_10002(var_9_1, false)

	return
end

return var_0_1
