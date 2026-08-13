class = var_0_10000

local var_0_0 = "BattleFailTipLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.PowerUpBtn = {
	EquipLevelUp = 2,
	SkillLevelUp = 3,
	ShipBreakUp = 4,
	ShipLevelUp = 1
}

function var_0_1.getUIName(arg_1_0)
	return "BattleFailTipUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.initData(arg_3_0)
	arg_3_0.battleSystem = arg_3_0.contextData.battleSystem

	return
end

function var_0_1.findUI(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.powerUpTipPanel = var_1.Find(var_4_0, "Main")

	local var_4_1 = arg_4_0.powerUpTipPanel

	arg_4_0.shipLevelUpBtn = var_1.Find(var_4_1, "ShipLevelUpBtn")

	local var_4_2 = arg_4_0.powerUpTipPanel

	arg_4_0.equipLevelUpBtn = var_1.Find(var_4_2, "EquipLevelUpBtn")

	local var_4_3 = arg_4_0.powerUpTipPanel

	arg_4_0.skillLevelUpBtn = var_1.Find(var_4_3, "SkillLevelUpBtn")

	local var_4_4 = arg_4_0.powerUpTipPanel

	arg_4_0.shipBreakUpBtn = var_1.Find(var_4_4, "ShipBreakUpBtn")

	local var_4_5 = arg_4_0.powerUpTipPanel

	arg_4_0.closeBtn = var_1.Find(var_4_5, "CloseBtn")

	return
end

function var_0_1.addListener(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.closeBtn

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.shipLevelUpBtn

	local function var_5_5()
		local var_7_0 = arg_5_0.battleSystem

		SYSTEM_SCENARIO = var_2_10001

		if var_7_0 == var_2_10001 then
			pg = var_7_0

			local var_7_1 = var_7_0.MsgboxMgr.GetInstance()
			local var_7_2 = var_0.ShowMsgBox

			var_2_10002 = {}
			i18n = var_2_10003
			var_2_10002.content = var_2_10003("fightfail_up")

			function var_2_10002.onYes()
				local var_8_0 = arg_5_0.contextData.battleSystem

				SYSTEM_SCENARIO = var_3_10001

				if var_8_0 == var_3_10001 then
					arg_5_0.lastClickBtn = var_0_1.PowerUpBtn.ShipLevelUp

					local var_8_1 = arg_5_0
					local var_8_2 = var_0.emit

					BattleFailTipMediator = var_3_10002

					var_8_2(var_8_1, var_3_10002.CHAPTER_RETREAT)
				else
					local var_8_3 = arg_5_0
					local var_8_4 = var_0.emit

					BattleFailTipMediator = var_3_10002

					var_8_4(var_8_3, var_3_10002.GO_HIGEST_CHAPTER)
				end

				return
			end

			var_7_2(var_7_1, var_2_10002)
		else
			local var_7_3 = arg_5_0
			local var_7_4 = var_0.emit

			BattleFailTipMediator = var_2_10002

			var_7_4(var_7_3, var_2_10002.GO_HIGEST_CHAPTER)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10005)

	onButton = var_1_10001

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.equipLevelUpBtn

	local function var_5_8()
		local var_9_0 = arg_5_0.battleSystem

		SYSTEM_SCENARIO = var_2_10001

		if var_9_0 == var_2_10001 then
			pg = var_9_0

			local var_9_1 = var_9_0.MsgboxMgr.GetInstance()
			local var_9_2 = var_0.ShowMsgBox

			var_2_10002 = {}
			i18n = var_2_10003
			var_2_10002.content = var_2_10003("fightfail_equip")

			function var_2_10002.onYes()
				local var_10_0 = arg_5_0.contextData.battleSystem

				SYSTEM_SCENARIO = var_3_10001

				if var_10_0 == var_3_10001 then
					arg_5_0.lastClickBtn = var_0_1.PowerUpBtn.EquipLevelUp

					local var_10_1 = arg_5_0
					local var_10_2 = var_0.emit

					BattleFailTipMediator = var_3_10002

					var_10_2(var_10_1, var_3_10002.CHAPTER_RETREAT)
				else
					local var_10_3 = arg_5_0
					local var_10_4 = var_0.emit

					BattleFailTipMediator = var_3_10002

					var_10_4(var_10_3, var_3_10002.GO_DOCKYARD_EQUIP)
				end

				return
			end

			var_9_2(var_9_1, var_2_10002)
		else
			local var_9_3 = arg_5_0
			local var_9_4 = var_0.emit

			BattleFailTipMediator = var_2_10002

			var_9_4(var_9_3, var_2_10002.GO_DOCKYARD_EQUIP)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_6, var_5_7, var_5_8, var_1_10005)

	onButton = var_1_10001

	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0.skillLevelUpBtn

	local function var_5_11()
		local var_11_0 = arg_5_0
		local var_11_1 = var_0.emit

		BattleFailTipMediator = var_2_10002

		var_11_1(var_11_0, var_2_10002.GO_NAVALTACTICS)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_9, var_5_10, var_5_11, var_1_10005)

	onButton = var_1_10001

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.shipBreakUpBtn

	local function var_5_14()
		local var_12_0 = arg_5_0.battleSystem

		SYSTEM_SCENARIO = var_2_10001

		if var_12_0 == var_2_10001 then
			pg = var_12_0

			local var_12_1 = var_12_0.MsgboxMgr.GetInstance()
			local var_12_2 = var_0.ShowMsgBox

			var_2_10002 = {}
			i18n = var_2_10003
			var_2_10002.content = var_2_10003("fight_strengthen")

			function var_2_10002.onYes()
				local var_13_0 = arg_5_0.contextData.battleSystem

				SYSTEM_SCENARIO = var_3_10001

				if var_13_0 == var_3_10001 then
					arg_5_0.lastClickBtn = var_0_1.PowerUpBtn.ShipBreakUp

					local var_13_1 = arg_5_0
					local var_13_2 = var_0.emit

					BattleFailTipMediator = var_3_10002

					var_13_2(var_13_1, var_3_10002.CHAPTER_RETREAT)
				else
					local var_13_3 = arg_5_0
					local var_13_4 = var_0.emit

					BattleFailTipMediator = var_3_10002

					var_13_4(var_13_3, var_3_10002.GO_DOCKYARD_SHIP)
				end

				return
			end

			var_12_2(var_12_1, var_2_10002)
		else
			local var_12_3 = arg_5_0
			local var_12_4 = var_0.emit

			BattleFailTipMediator = var_2_10002

			var_12_4(var_12_3, var_2_10002.GO_DOCKYARD_SHIP)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_12, var_5_13, var_5_14, var_1_10005)

	return
end

function var_0_1.didEnter(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_14_0, arg_14_0._tf)
	arg_14_0:aniBeforeEnter()

	return
end

function var_0_1.onBackPressed(arg_15_0)
	arg_15_0:closeView()

	return
end

function var_0_1.willExit(arg_16_0)
	LeanTween = var_1_10001

	local var_16_0 = var_1_10001.cancel

	go = var_1_10002

	var_16_0(var_1_10002(arg_16_0._tf))

	pg = var_16_0

	local var_16_1 = var_16_0.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_16_1, arg_16_0._tf)

	return
end

function var_0_1.aniBeforeEnter(arg_17_0)
	GetComponent = var_1_10001

	local var_17_0 = var_1_10001(arg_17_0._tf, "CanvasGroup")

	LeanTween = var_2

	local var_17_1 = var_2.value

	go = var_3

	local var_17_2 = var_17_1(var_3(arg_17_0._tf), 0, 1, 0.6)
	local var_17_3 = var_2.setOnUpdate

	System = var_4

	var_17_3(var_17_2, var_4.Action_float(function(arg_18_0)
		var_17_0.alpha = arg_18_0

		return
	end))

	return
end

return var_0_1
