class = var_0_10000

local var_0_0 = "IslandShipInfoPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandShipInfoUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.energyTipTr = var_1.Find(var_2_0, "adapt/name_panel/tip")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "adapt/name_panel/tip/Text")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.energyTipTxt = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0._tf

	arg_2_0.energyTr = var_1.Find(var_2_4, "adapt/name_panel/energy")

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "adapt/name_panel/energy")
	local var_2_7 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.energyTxt = var_2_7(var_2_6, var_3(var_1_10004))

	local var_2_8 = arg_2_0._tf

	arg_2_0.energyLabel = var_1.Find(var_2_8, "adapt/name_panel/energy/label")

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "adapt/name_panel/name")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTxt = var_2_11(var_2_10, var_3(var_1_10004))

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.Find(var_2_12, "adapt/name_panel/en")
	local var_2_14 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameEnTxt = var_2_14(var_2_13, var_3(var_1_10004))

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_1.Find(var_2_15, "adapt/main_panel/level/level")
	local var_2_17 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.levelTxt = var_2_17(var_2_16, var_3(var_1_10004))

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_1.Find(var_2_18, "adapt/main_panel/level/exp")
	local var_2_20 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.expTxt = var_2_20(var_2_19, var_3(var_1_10004))

	local var_2_21 = arg_2_0._tf

	arg_2_0.expProgress = var_1.Find(var_2_21, "adapt/main_panel/level/progress")

	local var_2_22 = arg_2_0._tf

	arg_2_0.upgradeBtn = var_1.Find(var_2_22, "adapt/main_panel/level/add")

	local var_2_23 = arg_2_0._tf

	arg_2_0.breakoutBtn = var_1.Find(var_2_23, "adapt/main_panel/level/breakout")
	UIItemList = var_1

	local var_2_24 = var_1.New
	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_2.Find(var_2_25, "adapt/main_panel/attr/list")
	local var_2_27 = arg_2_0._tf

	arg_2_0.uiAttrList = var_2_24(var_2_26, var_3.Find(var_2_27, "adapt/main_panel/attr/list/tpl"))

	local var_2_28 = arg_2_0._tf

	arg_2_0.attrUpgradeBtn = var_1.Find(var_2_28, "adapt/main_panel/attr/upgrade")

	local var_2_29 = arg_2_0._tf

	arg_2_0.skillTr = var_1.Find(var_2_29, "adapt/main_panel/skill")

	local var_2_30 = arg_2_0._tf

	arg_2_0.skillIconImg = var_1.Find(var_2_30, "adapt/main_panel/skill/icon")

	local var_2_31 = arg_2_0._tf
	local var_2_32 = var_1.Find(var_2_31, "adapt/main_panel/skill/info/name")
	local var_2_33 = var_1.GetComponent

	typeof = var_3
	Text = var_2_27
	arg_2_0.skillName = var_2_33(var_2_32, var_3(var_2_27))

	local var_2_34 = arg_2_0._tf
	local var_2_35 = var_1.Find(var_2_34, "adapt/main_panel/skill/info/level")
	local var_2_36 = var_1.GetComponent

	typeof = var_3
	Text = var_2_27
	arg_2_0.skillLevel = var_2_36(var_2_35, var_3(var_2_27))

	local var_2_37 = arg_2_0._tf
	local var_2_38 = var_1.Find(var_2_37, "adapt/main_panel/skill/info/desc/Text")
	local var_2_39 = var_1.GetComponent

	typeof = var_3
	Text = var_2_27
	arg_2_0.skillDesc = var_2_39(var_2_38, var_3(var_2_27))

	local var_2_40 = arg_2_0._tf

	arg_2_0.skillMask = var_1.Find(var_2_40, "adapt/main_panel/skill_mask")

	local var_2_41 = arg_2_0._tf

	arg_2_0.skillMaskLabel = var_1.Find(var_2_41, "adapt/main_panel/skill_mask/content/Text")

	local var_2_42 = arg_2_0._tf

	arg_2_0.skillUpgradeBtn = var_1.Find(var_2_42, "adapt/main_panel/skill/upgrade")

	local var_2_43 = arg_2_0._tf

	arg_2_0.skillInfoBtn = var_1.Find(var_2_43, "adapt/main_panel/skill/click")
	UIItemList = var_1

	local var_2_44 = var_1.New
	local var_2_45 = arg_2_0._tf
	local var_2_46 = var_2.Find(var_2_45, "adapt/main_panel/level/starts")
	local var_2_47 = arg_2_0._tf

	arg_2_0.breakOutList = var_2_44(var_2_46, var_3.Find(var_2_47, "adapt/main_panel/level/starts/tpl"))
	IslandShipStatusPanel = var_1

	local var_2_48 = var_1.New
	local var_2_49 = arg_2_0._tf
	local var_2_50 = var_2.Find(var_2_49, "adapt/main_panel/status")
	local var_2_51 = arg_2_0._tf

	arg_2_0.statusPanel = var_2_48(var_2_50, var_3.Find(var_2_51, "adapt/main_panel/status_empty"))

	local var_2_52 = arg_2_0._tf

	arg_2_0.followerBtn = var_1.Find(var_2_52, "adapt/follower")

	local var_2_53 = arg_2_0._tf

	arg_2_0.followerBtnInvite = var_1.Find(var_2_53, "adapt/follower/1")

	local var_2_54 = arg_2_0._tf

	arg_2_0.followerBtnCancel = var_1.Find(var_2_54, "adapt/follower/2")

	local var_2_55 = arg_2_0._tf

	arg_2_0.followerBtnDisable = var_1.Find(var_2_55, "adapt/follower/3")
	setText = var_1

	local var_2_56 = arg_2_0.energyLabel

	i18n = var_3

	var_1(var_2_56, var_3("island_ship_energy"))

	setText = var_1

	local var_2_57 = arg_2_0.followerBtnInvite
	local var_2_58 = var_2.Find(var_2_57, "Text")

	i18n = var_2_57

	var_1(var_2_58, var_2_57("island_follow_btn_State_usable"))

	setText = var_1

	local var_2_59 = arg_2_0.followerBtnCancel
	local var_2_60 = var_2.Find(var_2_59, "Text")

	i18n = var_2_59

	var_1(var_2_60, var_2_59("island_follow_btn_State_cancel"))

	setText = var_1

	local var_2_61 = arg_2_0.followerBtnDisable
	local var_2_62 = var_2.Find(var_2_61, "Text")

	i18n = var_2_61

	var_1(var_2_62, var_2_61("island_follow_btn_State_disable"))

	setActive = var_1

	local var_2_63 = arg_2_0.followerBtnInvite

	var_1(var_2.Find(var_2_63, "Text"), false)

	setActive = var_1

	local var_2_64 = arg_2_0.followerBtnInvite

	var_1(var_2.Find(var_2_64, "Text"), true)

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.energyTr

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.DisplayEnergyTip(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.skillUpgradeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0.ship
		local var_5_1 = var_0.GetSkill(var_5_0)

		if var_0.IsMaxLevel(var_5_1) then
			return
		end

		local var_5_2 = arg_3_0
		local var_5_3 = var_0.OpenPage

		IslandShipSkillUpgradePage = var_2_10002

		var_5_3(var_5_2, var_2_10002, arg_3_0.ship)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.upgradeBtn

	local function var_3_8()
		local var_6_0 = arg_3_0.ship

		if var_0.IsMaxLevel(var_6_0) then
			local var_6_1 = arg_3_0.ship

			if var_0.IsMaxBreakLevel(var_6_1) then
				return
			end

			local var_6_2 = arg_3_0
			local var_6_3 = var_0.OpenPage

			IslandShipBreakoutPage = var_2_10002

			var_6_3(var_6_2, var_2_10002, arg_3_0.ship)
		else
			local var_6_4 = arg_3_0
			local var_6_5 = var_0.OpenPage

			IslandShipUpgradePage = var_2_10002

			var_6_5(var_6_4, var_2_10002, arg_3_0.ship)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.breakoutBtn

	local function var_3_11()
		triggerButton = var_2_10000

		var_2_10000(arg_3_0.upgradeBtn)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.attrUpgradeBtn

	local function var_3_14()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.OpenPage

		IslandShipAttrUpgradePage = var_2_10002

		var_8_1(var_8_0, var_2_10002, arg_3_0.ship)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_12, var_3_13, var_3_14, var_1_10005)

	onButton = var_1_10001

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.followerBtn

	local function var_3_17()
		getProxy = var_2_10000
		IslandProxy = var_2_10001

		local var_9_0 = var_2_10000(var_2_10001)
		local var_9_1 = var_0.GetIsland(var_9_0)
		local var_9_2 = var_0.GetFollowerAgency(var_9_1)
		local var_9_5

		if var_1.Following(var_9_2, arg_3_0.ship.id) then
			local var_9_3 = arg_3_0
			local var_9_4 = var_1.ShowMsgBox

			var_9_5 = {}
			i18n = var_2_10004
			var_9_5.content = var_2_10004("island_cancel_follow_tip")

			function var_9_5.onYes()
				local var_10_0 = arg_3_0
				local var_10_1 = var_0.emitCore

				ISLAND_EVT = var_3_10002

				var_10_1(var_10_0, var_3_10002.WILL_DEL_FOLLOWER, arg_3_0.ship.id)

				return
			end

			var_9_4(var_9_3, var_9_5)
		else
			local var_9_6 = arg_3_0
			local var_9_7 = var_1.emit

			IslandMediator = var_9_5

			var_9_7(var_9_6, var_9_5.ADD_FOLLOWER, arg_3_0.ship.id)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_15, var_3_16, var_3_17, var_1_10005)

	onButton = var_1_10001

	local var_3_18 = arg_3_0
	local var_3_19 = arg_3_0.skillInfoBtn

	local function var_3_20()
		local var_11_0 = arg_3_0
		local var_11_1 = var_0.ShowMsgBox
		local var_11_2 = {}

		IslandMsgBox = var_2_10003
		var_11_2.type = var_2_10003.TYPE_SHIP_SKILL

		local var_11_3 = arg_3_0.ship

		var_11_2.skill = var_3.GetSkill(var_11_3)

		var_11_1(var_11_0, var_11_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_18, var_3_19, var_3_20, var_1_10005)

	return
end

function var_0_1.OnShow(arg_12_0, arg_12_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_12_0 = var_1_10002(var_1_10003)
	local var_12_1 = var_2.GetIsland(var_12_0)
	local var_12_2 = var_2.GetCharacterAgency(var_12_1)

	if var_2.GetShipById(var_12_2, arg_12_1) == nil then
		return
	end

	arg_12_0:UpdateMainView(var_2)
	arg_12_0:UpdateFollowBtn(var_2)

	arg_12_0.ship = var_2

	return
end

function var_0_1.UpdateFollowBtn(arg_13_0, arg_13_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_13_0 = var_1_10002(var_1_10003)
	local var_13_1 = var_2.GetIsland(var_13_0)
	local var_13_2 = var_2.GetFollowerAgency(var_13_1)
	local var_13_3 = var_3.Following(var_13_2, arg_13_1.id)

	getProxy = var_13_2
	IslandProxy = var_5

	local var_13_4 = var_13_2(var_5)
	local var_13_5 = var_4.GetIsland(var_13_4)
	local var_13_6 = var_4.GetCharacterAgency(var_13_5)
	local var_13_7 = var_4.CanFollowPlayer(var_13_6, arg_13_1.id)

	setActive = var_13_6

	var_13_6(arg_13_0.followerBtnInvite, not var_13_3 and var_13_7)

	setActive = var_13_6

	var_13_6(arg_13_0.followerBtnCancel, var_13_3)

	local var_13_8 = not var_13_7 and not var_13_3

	setActive = var_7

	var_7(arg_13_0.followerBtnDisable, var_13_8)

	setButtonEnabled = var_7

	var_7(arg_13_0.followerBtn, not var_13_8)

	return
end

function var_0_1.AddListeners(arg_14_0)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.AddListener

	GAME = var_1_10003

	var_14_1(var_14_0, var_1_10003.ISLAND_USE_SHIP_EXP_BOOK_DONE, arg_14_0.OnUseExpBook)

	local var_14_2 = arg_14_0
	local var_14_3 = arg_14_0.AddListener

	GAME = var_3

	var_14_3(var_14_2, var_3.ISLAND_SHIP_BREAKOUT_DONE, arg_14_0.OnBreakOut)

	local var_14_4 = arg_14_0
	local var_14_5 = arg_14_0.AddListener

	GAME = var_3

	var_14_5(var_14_4, var_3.ISLNAD_SHIP_ATTR_UPGRADE_DONE, arg_14_0.OnAttrUpgrade)

	local var_14_6 = arg_14_0
	local var_14_7 = arg_14_0.AddListener

	GAME = var_3

	var_14_7(var_14_6, var_3.ISLAND_SHIP_SKILL_UPGRADE_DONE, arg_14_0.OnSkillUpgrade)

	local var_14_8 = arg_14_0
	local var_14_9 = arg_14_0.AddListener

	GAME = var_3

	var_14_9(var_14_8, var_3.ISLAND_FOLLOWER_OP_DONE, arg_14_0.OnFollowOpDone)

	return
end

function var_0_1.RemoveListeners(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.RemoveListener

	GAME = var_1_10003

	var_15_1(var_15_0, var_1_10003.ISLAND_USE_SHIP_EXP_BOOK_DONE, arg_15_0.OnUseExpBook)

	local var_15_2 = arg_15_0
	local var_15_3 = arg_15_0.RemoveListener

	GAME = var_3

	var_15_3(var_15_2, var_3.ISLAND_SHIP_BREAKOUT_DONE, arg_15_0.OnBreakOut)

	local var_15_4 = arg_15_0
	local var_15_5 = arg_15_0.RemoveListener

	GAME = var_3

	var_15_5(var_15_4, var_3.ISLNAD_SHIP_ATTR_UPGRADE_DONE, arg_15_0.OnAttrUpgrade)

	local var_15_6 = arg_15_0
	local var_15_7 = arg_15_0.RemoveListener

	GAME = var_3

	var_15_7(var_15_6, var_3.ISLAND_SHIP_SKILL_UPGRADE_DONE, arg_15_0.OnSkillUpgrade)

	local var_15_8 = arg_15_0
	local var_15_9 = arg_15_0.RemoveListener

	GAME = var_3

	var_15_9(var_15_8, var_3.ISLAND_FOLLOWER_OP_DONE, arg_15_0.OnFollowOpDone)

	return
end

function var_0_1.OnFollowOpDone(arg_16_0)
	arg_16_0:UpdateFollowBtn(arg_16_0.ship)

	return
end

function var_0_1.OnAttrUpgrade(arg_17_0)
	arg_17_0:UpdateAttrs(arg_17_0.ship)

	return
end

function var_0_1.OnUseExpBook(arg_18_0)
	arg_18_0:UpdateLevelAndExp(arg_18_0.ship)
	arg_18_0:UpdateAttrs(arg_18_0.ship)

	return
end

function var_0_1.OnBreakOut(arg_19_0)
	local var_19_0 = arg_19_0.ship

	arg_19_0:UpdateEnergy(var_19_0)
	arg_19_0:UpdateLevelAndExp(var_19_0)
	arg_19_0:UpdateAttrs(var_19_0)
	arg_19_0:UpdateSkill(var_19_0)
	arg_19_0:UpdateBreakOutLevel(var_19_0)

	return
end

function var_0_1.OnSkillUpgrade(arg_20_0)
	local var_20_0 = arg_20_0.ship

	arg_20_0:UpdateSkill(var_20_0)

	return
end

function var_0_1.UpdateMainView(arg_21_0, arg_21_1)
	arg_21_0:UpdateEnergy(arg_21_1)
	arg_21_0:UpdateLevelAndExp(arg_21_1)
	arg_21_0:UpdateAttrs(arg_21_1)
	arg_21_0:UpdateSkill(arg_21_1)
	arg_21_0:UpdateBreakOutLevel(arg_21_1)
	arg_21_0:UpdateStatus(arg_21_1)

	arg_21_0.ship = arg_21_1

	return
end

function var_0_1.DisplayEnergyTip(arg_22_0)
	arg_22_0:RemoveCloseEnergyTipTimer()

	setActive = var_1

	var_1(arg_22_0.energyTipTr, true)

	local var_22_0 = arg_22_0.energyTipTxt

	i18n = var_2
	var_22_0.text = var_2("island_ship_energy_full")

	arg_22_0:AddCloseEnergyTipTimer()

	return
end

function var_0_1.AddCloseEnergyTipTimer(arg_23_0)
	Timer = var_1_10001
	arg_23_0.timer = var_1_10001.New(function()
		local var_24_0 = arg_23_0

		var_0.RemoveCloseEnergyTipTimer(var_24_0)

		return
	end, 3)

	local var_23_0 = arg_23_0.timer

	var_1.Start(var_23_0)

	return
end

function var_0_1.RemoveCloseEnergyTipTimer(arg_25_0)
	setActive = var_1_10001

	var_1_10001(arg_25_0.energyTipTr, false)

	if arg_25_0.timer then
		local var_25_0 = arg_25_0.timer

		var_1.Stop(var_25_0)

		arg_25_0.timer = nil
	end

	return
end

function var_0_1.UpdateBreakOutLevel(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1:GetBreakLevel()
	local var_26_1 = arg_26_0.breakOutList

	var_3.make(var_26_1, function(arg_27_0, arg_27_1, arg_27_2)
		UIItemList = var_2_10003

		if arg_27_0 == var_2_10003.EventUpdate then
			local var_27_0 = arg_27_1 + 1

			setActive = var_2_10004

			var_2_10004(arg_27_2:Find("Image"), var_27_0 <= var_26_0)
		end

		return
	end)

	local var_26_2 = arg_26_0.breakOutList

	var_3.align(var_26_2, arg_26_1:GetBreakMaxLevel())

	return
end

function var_0_1.UpdateEnergy(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1:GetCurrentEnergy()
	local var_28_1 = arg_28_1:GetMaxEnergy()
	local var_28_2

	if not (var_28_0 <= 20) or not ("<color=#ab4734>" .. var_28_0 .. "</color>") then
		var_28_2 = var_28_0
	end

	arg_28_0.energyTxt.text = "[" .. var_28_2 .. "/" .. var_28_1 .. "]"

	return
end

function var_0_1.UpdateLevelAndExp(arg_29_0, arg_29_1)
	arg_29_0.nameTxt.text = arg_29_1:GetName()
	arg_29_0.nameEnTxt.text = arg_29_1:GetEnName()
	arg_29_0.levelTxt.text = "Level:" .. arg_29_1:GetLevel()

	local var_29_0

	if not arg_29_1:IsMaxLevel() then
		var_29_0 = arg_29_1:GetExp()

		local var_29_1 = arg_29_1:GetTargetExp()
		local var_29_2 = arg_29_0.expTxt

		var_29_2.text = var_29_0 .. "/" .. var_29_1
		setSlider = var_29_2

		var_29_2(arg_29_0.expProgress, 0, 1, var_29_0 / var_29_1)
	else
		var_29_0 = arg_29_0.expTxt
		var_29_0.text = "[MAX]"
		setSlider = var_29_0

		var_29_0(arg_29_0.expProgress, 0, 1, 1)
	end

	setActive = var_29_0

	var_29_0(arg_29_0.upgradeBtn, not arg_29_1:IsMaxLevel())

	setActive = var_29_0

	local var_29_3 = arg_29_0.breakoutBtn
	local var_29_4

	if arg_29_1:IsMaxLevel() then
		var_29_4 = not arg_29_1:IsMaxBreakLevel()
	end

	var_29_0(var_29_3, var_29_4)

	return
end

function var_0_1.RemoveAttrTimer(arg_30_0)
	if arg_30_0.attrTimer then
		local var_30_0 = arg_30_0.attrTimer

		var_1.Stop(var_30_0)

		arg_30_0.attrTimer = nil
	end

	return
end

function var_0_1.UpdateAttrs(arg_31_0, arg_31_1)
	IslandShipAttr = var_1_10002

	local var_31_0 = var_1_10002.ATTRS
	local var_31_1 = arg_31_0.uiAttrList

	var_3.make(var_31_1, function(arg_32_0, arg_32_1, arg_32_2)
		UIItemList = var_2_10003

		if arg_32_0 == var_2_10003.EventUpdate then
			local var_32_0 = arg_32_1 + 1
			local var_32_1 = arg_31_0

			var_4.UpdateAttr(var_32_1, arg_32_2, var_31_0, var_32_0, arg_31_1)
		end

		return
	end)

	local var_31_2 = arg_31_0.uiAttrList

	var_3.align(var_31_2, #var_31_0)

	return
end

function var_0_1.UpdateAttr(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = arg_33_2[arg_33_3]
	local var_33_1 = arg_33_4
	local var_33_2 = arg_33_4.GetAttr(var_33_1, var_33_0)

	setText = var_33_1

	local var_33_3 = arg_33_1
	local var_33_4 = arg_33_1.Find(var_33_3, "name")

	IslandShipAttr = var_33_3

	var_33_1(var_33_4, var_33_3.ToChinese(var_33_0))

	IslandProductTimeHelper = var_33_1

	local var_33_5 = var_33_1.GetAttributeAddPercentByAttribute(arg_33_4.id, arg_33_3)
	local var_33_6
	local var_33_7 = 0 < var_33_5 and "#00B91E" or var_33_5 < 0 and "#FF6767" or "#393A3C"

	setTextColor = var_9

	local var_33_8 = arg_33_1
	local var_33_9 = arg_33_1.Find(var_33_8, "value")

	Color = var_33_8

	var_9(var_33_9, var_33_8.NewHex(var_33_7))

	if var_33_5 ~= 0 then
		math = var_9

		local var_33_10

		if not var_9.floor(var_33_2 * (1 + 0.01 * var_33_5)) then
			var_33_10 = var_33_2
		end

		setText = var_33_9

		var_33_9(arg_33_1:Find("value"), var_33_10)

		if var_33_5 ~= 0 then
			local var_33_11 = arg_33_4

			var_33_9 = arg_33_4.GetDisplayStatus(var_33_11)
			_ = var_33_11
			var_33_9 = var_33_11.select(var_33_9, function(arg_34_0)
				local var_34_0 = arg_34_0
				local var_34_1 = arg_34_0.GetBuffType(var_34_0)

				IslandBuffType = var_34_0

				return var_34_1 == var_34_0.SHIP_ATTR
			end)
			onButton = var_11

			local var_33_12 = arg_33_0
			local var_33_13 = arg_33_1

			local function var_33_14()
				local var_35_0 = arg_33_0
				local var_35_1 = var_0.ShowMsgBox
				local var_35_2 = {
					hideNo = true
				}

				IslandMsgBox = var_2_10003
				var_35_2.type = var_2_10003.TYPE_SHIP_OWN_STATUS
				i18n = var_3
				var_35_2.title = var_3("island_word_ship_buff_desc")
				var_35_2.statusList = var_33_9

				var_35_1(var_35_0, var_35_2)

				return
			end

			SFX_PANEL = var_1_10015

			var_11(var_33_12, var_33_13, var_33_14, var_1_10015)
		else
			removeOnButton = var_33_9

			var_33_9(arg_33_1)
		end

		local var_33_15 = arg_33_4
		local var_33_16 = arg_33_4.GetAttrGradeByValue(var_33_15, var_33_10)

		IslandShipAttr = var_33_15

		local var_33_17 = var_33_15.Grade2Img(var_33_16)

		GetImageSpriteFromAtlasAsync = var_12

		var_12("ui/IslandShipUI_atlas", var_33_17[1], arg_33_1:Find("grade"))

		GetImageSpriteFromAtlasAsync = var_12

		var_12("ui/IslandShipUI_atlas", var_33_17[2], arg_33_1:Find("grade_bg"))

		return
	end
end

function var_0_1.UpdateSkill(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1
	local var_36_1 = arg_36_1.GetSkill(var_36_0)

	GetImageSpriteFromAtlasAsync = var_36_0

	var_36_0("island/IslandSkillIcon/" .. var_36_1:GetIcon(), "", arg_36_0.skillIconImg)

	arg_36_0.skillName.text = var_36_1:GetName()
	arg_36_0.skillLevel.text = "[Lv." .. var_36_1:GetLevel() .. "]"
	arg_36_0.skillDesc.text = var_36_1:GetEffectDesc()

	local var_36_2 = var_36_1
	local var_36_3 = var_36_1.IsUnlock(var_36_2)

	setActive = var_36_2

	var_36_2(arg_36_0.skillTr, var_36_3)

	setActive = var_36_2

	var_36_2(arg_36_0.skillMask, not var_36_3)

	setText = var_36_2

	local var_36_4 = arg_36_0.skillMaskLabel

	i18n = var_6

	var_36_2(var_36_4, var_6("island_need_star", arg_36_1:GetSkillUnlockLevel()))

	setActive = var_36_2

	var_36_2(arg_36_0.skillUpgradeBtn, not var_36_1:IsMaxLevel())

	return
end

function var_0_1.UpdateStatus(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.statusPanel

	var_2.Flush(var_37_0, arg_37_1)

	local var_37_1 = arg_37_1
	local var_37_2 = arg_37_1.GetDisplayStatus(var_37_1)

	onButton = var_37_1

	local var_37_3 = arg_37_0
	local var_37_4 = arg_37_0.statusPanel.viewBtn

	local function var_37_5()
		local var_38_0 = arg_37_0
		local var_38_1 = var_0.ShowMsgBox
		local var_38_2 = {
			hideNo = true
		}

		IslandMsgBox = var_2_10003
		var_38_2.type = var_2_10003.TYPE_SHIP_OWN_STATUS
		i18n = var_3
		var_38_2.title = var_3("island_word_ship_buff_desc")
		var_38_2.statusList = var_37_2

		var_38_1(var_38_0, var_38_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_37_1(var_37_3, var_37_4, var_37_5, var_1_10007)

	return
end

function var_0_1.OnHide(arg_39_0)
	arg_39_0:RemoveCloseEnergyTipTimer()

	return
end

function var_0_1.OnDestroy(arg_40_0)
	local var_40_0 = arg_40_0.statusPanel

	var_1.Dispose(var_40_0)

	arg_40_0.statusPanel = nil

	arg_40_0:RemoveCloseEnergyTipTimer()

	return
end

return var_0_1
