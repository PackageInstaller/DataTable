class = var_0_10000

local var_0_0 = "BattleActivityBossResultLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BattleResultLayer"))

function var_0_1.showRightBottomPanel(arg_1_0)
	local var_1_0 = arg_1_0._blurConatiner
	local var_1_1 = var_1.Find(var_1_0, "activitybossConfirmPanel")

	setActive = var_1_0

	var_1_0(var_1_1, true)
	var_0_1.super.showRightBottomPanel(arg_1_0)

	SetActive = var_2

	var_2(arg_1_0._rightBottomPanel, false)

	local var_1_2 = arg_1_0.contextData.system

	SYSTEM_BOSS_EXPERIMENT = var_3

	local var_1_3 = var_1_2 ~= var_3

	setActive = var_4

	var_4(var_1_1:Find("playAgain"), var_1_3)

	onButton = var_4

	local var_1_4 = arg_1_0
	local var_1_5 = var_1_1:Find("statisticsBtn")

	local function var_1_6()
		setActive = var_2_10000

		local var_2_0 = var_1_1
		local var_2_1 = var_1.Find(var_2_0, "playAgain")
		local var_2_2

		if arg_1_0._atkBG.gameObject.activeSelf then
			var_2_2 = var_1_3
		end

		var_2_10000(var_2_1, var_2_2)

		triggerButton = var_2_10000

		var_2_10000(arg_1_0._statisticsBtn)

		return
	end

	SFX_PANEL = var_8

	var_4(var_1_4, var_1_5, var_1_6, var_8)

	setText = var_4

	local var_1_7 = var_1_1
	local var_1_8 = var_1_1.Find(var_1_7, "confirmBtn/Image")

	i18n = var_1_7

	var_4(var_1_8, var_1_7("text_confirm"))

	onButton = var_4

	local var_1_9 = arg_1_0
	local var_1_10 = var_1_1:Find("confirmBtn")

	local function var_1_11()
		triggerButton = var_2_10000

		var_2_10000(arg_1_0._confirmBtn)

		return
	end

	SFX_CONFIRM = var_8

	var_4(var_1_9, var_1_10, var_1_11, var_8)

	setText = var_4

	local var_1_12 = var_1_1
	local var_1_13 = var_1_1.Find(var_1_12, "confirmBtn/Image")

	i18n = var_1_12

	var_4(var_1_13, var_1_12("text_confirm"))

	setText = var_4

	local var_1_14 = var_1_1
	local var_1_15 = var_1_1.Find(var_1_14, "playAgain/Image")

	i18n = var_1_14

	var_4(var_1_15, var_1_14("re_battle"))

	setText = var_4

	local var_1_16 = var_1_1
	local var_1_17 = var_1_1.Find(var_1_16, "playAgain/bonus/title")

	i18n = var_1_16

	var_4(var_1_17, var_1_16("expedition_extra_drop_tip"))

	getProxy = var_4
	FleetProxy = var_1_17

	local var_1_18 = var_4(var_1_17)
	local var_1_19 = var_4.getActivityFleets(var_1_18)[arg_1_0.contextData.actId]
	local var_1_20 = var_1_1:Find("playAgain/bonus")
	local var_1_21 = var_1_1
	local var_1_22 = var_1_1.Find(var_1_21, "playAgain/ticket")

	getProxy = var_1_21
	ActivityProxy = var_9

	local var_1_23 = var_1_21(var_9)
	local var_1_24 = var_8.getActivityById(var_1_23, arg_1_0.contextData.actId)
	local var_1_25 = arg_1_0.contextData.stageId
	local var_1_26 = var_1_24
	local var_1_27 = var_1_24.getConfig(var_1_26, "config_id")

	pg = var_1_26

	local var_1_28 = var_1_26.activity_event_worldboss[var_1_27].ticket
	local var_1_29 = var_1_24:GetStageBonus(var_1_25)
	local var_1_30 = var_1_24:IsOilLimit(var_1_25)
	local var_1_31 = 0
	local var_1_32 = var_11.use_oil_limit[arg_1_0.contextData.mainFleetId]

	local function var_1_33(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_0:GetCostSum().oil

		if 0 < arg_4_1 then
			math = var_3
			var_4_0 = var_3.min(var_4_0, var_1_32[1])
		end

		var_1_31 = var_1_31 + var_4_0

		return
	end

	local var_1_34 = var_1_19[arg_1_0.contextData.mainFleetId]
	local var_1_35

	if not var_1_30 or not var_1_32[1] then
		var_1_35 = 0
	end

	var_1_33(var_1_34, var_1_35)

	setText = var_1_33

	var_1_33(var_1_1:Find("playAgain/Text"), var_1_31)

	local var_1_36
	local var_1_37

	setActive = var_20

	var_20(var_1_20, var_1_29 > 0)

	setActive = var_20

	var_20(var_1_22, var_1_29 <= 0)

	setText = var_20

	var_20(var_1_20:Find("Text"), var_1_29)

	local var_1_38

	if var_1_29 <= 0 then
		Drop = var_1_38
		var_1_38 = var_1_38.New

		local var_1_39 = {}

		DROP_TYPE_RESOURCE = var_22
		var_1_39.type = var_22
		var_1_39.id = var_1_28

		local var_1_40 = var_1_38(var_1_39)

		var_1_38 = var_1_38.getIcon(var_1_40)
		GetSpriteFromAtlas = var_1_40

		local var_1_41 = var_1_40(var_1_38, "")

		setImageSprite = var_22

		var_22(var_1_22:Find("icon"), var_1_41)

		getProxy = var_22
		PlayerProxy = var_23

		local var_1_42 = var_22(var_23)
		local var_1_43 = var_22.getRawData(var_1_42)
		local var_1_44 = var_22.getResource(var_1_43, var_1_28)

		getProxy = var_1_43
		SettingsProxy = var_24

		local var_1_45 = var_1_43(var_24)

		var_1_37 = var_23.isTipActBossExchangeTicket(var_1_45) == 1
		var_1_36 = var_1_44 > 0

		local var_1_46 = 1
		local var_1_47 = var_1_22
		local var_1_48 = var_1_22.Find(var_1_47, "checkbox")

		SYSTEM_BOSS_EXPERIMENT = var_1_47

		if var_1_2 == var_1_47 then
			var_1_46 = 0
			triggerToggle = var_1_47

			var_1_47(var_1_48, false)

			setToggleEnabled = var_1_47

			var_1_47(var_1_48, false)
		else
			SYSTEM_HP_SHARE_ACT_BOSS = var_1_47

			if var_1_2 == var_1_47 then
				triggerToggle = var_1_47

				var_1_47(var_1_48, true)

				setToggleEnabled = var_1_47

				var_1_47(var_1_48, false)
			else
				SYSTEM_ACT_BOSS = var_1_47

				if var_1_2 == var_1_47 then
					setToggleEnabled = var_1_47

					var_1_47(var_1_48, var_1_36)

					triggerToggle = var_1_47

					local var_1_49 = var_1_48

					var_1_10027 = var_1_36 and var_1_37

					var_1_47(var_1_49, var_1_10027)
				end
			end
		end

		if var_1_44 < var_1_46 then
			setColorStr = var_1_47

			local var_1_50 = var_1_44

			COLOR_RED = var_1_10027
			var_1_44 = var_1_47(var_1_50, var_1_10027) or var_1_44
		end

		setText = var_1_47

		var_1_47(var_1_22:Find("Text"), var_1_46 .. "/" .. var_1_44)

		onToggle = var_1_47

		local var_1_51 = arg_1_0
		local var_1_52 = var_1_48

		local function var_1_53(arg_5_0)
			var_1_37 = arg_5_0
			getProxy = var_2_10001
			SettingsProxy = var_2_10002

			local var_5_0 = var_2_10001(var_2_10002)

			var_1.setActBossExchangeTicketTip(var_5_0, arg_5_0 and 1 or 0)

			return
		end

		SFX_PANEL = var_29
		SFX_CANCEL = var_1_10030

		var_1_47(var_1_51, var_1_52, var_1_53, var_29, var_1_10030)
	end

	onButton = var_1_38

	var_1_38(arg_1_0, var_1_1:Find("playAgain"), function()
		if arg_1_0.contextData.isLastBonus then
			var_2_10001 = arg_1_0

			local var_6_0 = var_0.PassMsgbox

			var_2_10002 = "lastBonus"
			var_2_10003 = {}
			i18n = var_2_10004
			var_2_10003.content = var_2_10004("expedition_drop_use_out")

			var_6_0(var_2_10001, var_2_10002, var_2_10003)

			return
		end

		local var_6_1 = var_1_2

		SYSTEM_HP_SHARE_ACT_BOSS = var_2_10001

		if var_6_1 == var_2_10001 and not var_1_36 then
			pg = var_6_1

			local var_6_2 = var_6_1.m02

			var_6_1 = var_6_1.sendNotification
			GAME = var_2_10002

			var_6_1(var_6_2, var_2_10002.GO_BACK)

			pg = var_6_1

			local var_6_3 = var_6_1.TipsMgr.GetInstance()

			var_6_1 = var_6_1.ShowTips
			i18n = var_2

			var_6_1(var_6_3, var_2("stage_beginStage_error_noTicket"))

			return
		end

		pg = var_6_1

		local var_6_4 = var_6_1.battle_cost_template[arg_1_0.contextData.system].oil_cost
		local var_6_5 = 0 < var_6_4

		getProxy = var_2
		PlayerProxy = var_2_10003

		local var_6_6 = var_2(var_2_10003)
		local var_6_7 = var_2.getRawData(var_6_6).oil

		if var_6_5 and var_6_7 < var_1_31 then
			var_2_10004 = arg_1_0

			var_6_6.PassMsgbox(var_2_10004, "oil", var_1_31)

			return
		end

		getProxy = var_6_6
		BayProxy = var_2_10004

		local var_6_8 = var_6_6(var_2_10004)
		local var_6_9 = var_3.getShipCount(var_6_8)

		getProxy = var_6_8
		PlayerProxy = var_2_10005

		local var_6_10 = var_6_8(var_2_10005)
		local var_6_11 = var_4.getRawData(var_6_10)

		if var_6_9 >= var_4.getMaxShipBag(var_6_11) then
			local var_6_12 = arg_1_0

			var_4.PassMsgbox(var_6_12, "shipCapacity")

			return
		end

		local var_6_13 = var_1_19[arg_1_0.contextData.mainFleetId]

		_ = var_5

		local var_6_14 = var_5.any

		_ = var_2_10006

		local var_6_15

		if var_6_14(var_2_10006.values(var_6_13.ships), function(arg_7_0)
			getProxy = var_3_10001
			BayProxy = var_3_10002

			local var_7_0 = var_3_10001(var_3_10002)

			if var_1.getShipById(var_7_0, arg_7_0) then
				::label_7_0::

				var_7_0 = var_1.energy
				Ship = var_3
				var_7_0 = var_7_0 == var_3.ENERGY_LOW
			end

			return var_7_0
		end) then
			var_6_15 = arg_1_0

			var_5.PassMsgbox(var_6_15, "energy", var_6_13)

			return
		end

		local var_6_16 = var_1_2

		SYSTEM_ACT_BOSS = var_6_15

		if var_6_16 == var_6_15 and var_1_36 and var_1_37 then
			pg = var_5

			local var_6_17 = var_5.m02
			local var_6_18 = var_5.sendNotification

			GAME = var_7

			var_6_18(var_6_17, var_7.ACT_BOSS_EXCHANGE_TICKET, {
				stageId = var_1_25
			})

			return
		end

		local var_6_19 = arg_1_0
		local var_6_20 = var_5.emit

		NewBattleResultMediator = var_7

		var_6_20(var_6_19, var_7.REENTER_STAGE)

		return
	end)

	return
end

function var_0_1.PassMsgbox(arg_8_0, arg_8_1, arg_8_2)
	getProxy = var_1_10003
	ContextProxy = var_1_10004

	local var_8_0 = var_1_10003(var_1_10004)
	local var_8_1 = var_3.GetPrevContext(var_8_0, 1).data

	var_8_1.msg = {
		type = arg_8_1,
		param = arg_8_2
	}
	pg = var_8_1

	local var_8_2 = var_8_1.m02
	local var_8_3 = var_4.sendNotification

	GAME = var_1_10006

	var_8_3(var_8_2, var_1_10006.GO_BACK)

	return
end

function var_0_1.HideConfirmPanel(arg_9_0)
	local var_9_0 = arg_9_0._blurConatiner
	local var_9_1 = var_1.Find(var_9_0, "activitybossConfirmPanel")

	setActive = var_9_0

	var_9_0(var_9_1, false)

	return
end

return var_0_1
