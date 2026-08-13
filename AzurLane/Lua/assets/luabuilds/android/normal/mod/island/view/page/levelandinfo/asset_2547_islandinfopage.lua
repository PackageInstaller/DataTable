class = var_0_10000

local var_0_0 = "IslandInfoPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandInfoUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "frame/back")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "frame/left/level")
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.levelTxt = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "frame/left/objective/exp")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.expTxt = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "frame/left/objective/gold")
	local var_2_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.goldTxt = var_2_9(var_2_8, var_3(var_1_10004))

	local var_2_10 = arg_2_0._tf

	arg_2_0.expProgress = var_1.Find(var_2_10, "frame/left/exp/bar")

	local var_2_11 = arg_2_0._tf

	arg_2_0.preViewBtn = var_1.Find(var_2_11, "frame/left/preview")

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.Find(var_2_12, "frame/right/prosperity/level")
	local var_2_14 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.prosperityLevel = var_2_14(var_2_13, var_3(var_1_10004))

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_1.Find(var_2_15, "frame/right/prosperity/exp")
	local var_2_17 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.prosperityExp = var_2_17(var_2_16, var_3(var_1_10004))

	local var_2_18 = arg_2_0._tf

	arg_2_0.prosperityIcon = var_1.Find(var_2_18, "frame/right/prosperity/icon")

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_1.Find(var_2_19, "frame/left/name/Text")
	local var_2_21 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nameTxt = var_2_21(var_2_20, var_3(var_1_10004))

	local var_2_22 = arg_2_0._tf

	arg_2_0.editNameBtn = var_1.Find(var_2_22, "frame/left/name")
	UIItemList = var_1

	local var_2_23 = var_1.New
	local var_2_24 = arg_2_0._tf
	local var_2_25 = var_2.Find(var_2_24, "frame/right/ships/list")
	local var_2_26 = arg_2_0._tf

	arg_2_0.uiShipList = var_2_23(var_2_25, var_3.Find(var_2_26, "frame/right/ships/list/tpl"))

	local var_2_27 = arg_2_0._tf

	arg_2_0.upgradePreviewPanel = var_1.Find(var_2_27, "frame/left/upgrade_preview")
	UIItemList = var_1

	local var_2_28 = var_1.New
	local var_2_29 = arg_2_0._tf
	local var_2_30 = var_2.Find(var_2_29, "frame/left/upgrade_preview/content/awards/list/content")
	local var_2_31 = arg_2_0._tf

	arg_2_0.upgradeAwardList = var_2_28(var_2_30, var_3.Find(var_2_31, "frame/left/upgrade_preview/content/awards/list/content/tpl"))
	UIItemList = var_1

	local var_2_32 = var_1.New
	local var_2_33 = arg_2_0._tf
	local var_2_34 = var_2.Find(var_2_33, "frame/left/upgrade_preview/content/unlock/list/content")
	local var_2_35 = arg_2_0._tf

	arg_2_0.upgradeUnlockList = var_2_32(var_2_34, var_3.Find(var_2_35, "frame/left/upgrade_preview/content/awards/list/content/tpl"))
	UIItemList = var_1

	local var_2_36 = var_1.New
	local var_2_37 = arg_2_0._tf
	local var_2_38 = var_2.Find(var_2_37, "frame/right/prosperity/objective/content")
	local var_2_39 = arg_2_0._tf

	arg_2_0.prosperityLevelList = var_2_36(var_2_38, var_3.Find(var_2_39, "frame/right/prosperity/objective/content/tpl"))
	UIItemList = var_1

	local var_2_40 = var_1.New
	local var_2_41 = arg_2_0._tf
	local var_2_42 = var_2.Find(var_2_41, "frame/right/prosperity/objective/awards")
	local var_2_43 = arg_2_0._tf

	arg_2_0.prosperityAwardList = var_2_40(var_2_42, var_3.Find(var_2_43, "frame/right/prosperity/objective/awards/tpl"))

	local var_2_44 = arg_2_0._tf

	arg_2_0.getProsperityBtn = var_1.Find(var_2_44, "frame/right/prosperity/objective/get_btn")

	local var_2_45 = arg_2_0._tf

	arg_2_0.goProsperityBtn = var_1.Find(var_2_45, "frame/right/prosperity/objective/go_btn")

	local var_2_46 = arg_2_0._tf
	local var_2_47 = var_1.Find(var_2_46, "frame/right/prosperity/objective/go_btn/Text")
	local var_2_48 = var_1.GetComponent

	typeof = var_3
	Text = var_2_43
	arg_2_0.goProsperityBtnTxt = var_2_48(var_2_47, var_3(var_2_43))
	setText = var_1

	local var_2_49 = arg_2_0._tf
	local var_2_50 = var_2.Find(var_2_49, "frame/left/preview/Text")

	i18n = var_2_49

	var_1(var_2_50, var_2_49("island_upgrade_preview"))

	setText = var_1

	local var_2_51 = arg_2_0._tf
	local var_2_52 = var_2.Find(var_2_51, "frame/left/objective/label_exp")

	i18n = var_2_51

	var_1(var_2_52, var_2_51("island_upgrade_exp"))

	setText = var_1

	local var_2_53 = arg_2_0._tf
	local var_2_54 = var_2.Find(var_2_53, "frame/left/objective/label_gold")

	i18n = var_2_53

	var_1(var_2_54, var_2_53("island_upgrade_res"))

	setText = var_1

	local var_2_55 = arg_2_0._tf
	local var_2_56 = var_2.Find(var_2_55, "frame/left/upgrade_preview/content/awards/label")

	i18n = var_2_55

	var_1(var_2_56, var_2_55("island_word_award"))

	setText = var_1

	local var_2_57 = arg_2_0._tf
	local var_2_58 = var_2.Find(var_2_57, "frame/left/upgrade_preview/content/unlock/label")

	i18n = var_2_57

	var_1(var_2_58, var_2_57("island_word_unlock"))

	setText = var_1

	local var_2_59 = arg_2_0._tf
	local var_2_60 = var_2.Find(var_2_59, "frame/right/prosperity/objective/get_btn/Text")

	i18n = var_2_59

	var_1(var_2_60, var_2_59("island_word_get"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.editNameBtn

	local function var_3_8()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.OpenPage

		IslandEditNamePage = var_2_10002

		var_6_1(var_6_0, var_2_10002)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	arg_3_0.showPreviewPanel = false
	arg_3_0.displayPreviewLevel = -1
	onButton = var_1

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.preViewBtn

	local function var_3_11()
		getProxy = var_2_10000
		IslandProxy = var_2_10001

		local var_7_0 = var_2_10000(var_2_10001)
		local var_7_1 = var_0.GetIsland(var_7_0)

		if var_0.IsMaxLevel(var_7_1) then
			return
		end

		local var_7_2 = arg_3_0

		var_7_2.showPreviewPanel = not arg_3_0.showPreviewPanel
		setActive = var_7_2

		var_7_2(arg_3_0.upgradePreviewPanel, arg_3_0.showPreviewPanel)

		local var_7_3 = var_0:GetLevel()

		if arg_3_0.showPreviewPanel and arg_3_0.displayPreviewLevel ~= var_7_3 then
			arg_3_0.displayPreviewLevel = var_7_3

			local var_7_4 = arg_3_0

			var_2.InitUpgradeAwards(var_7_4, var_0)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_9, var_3_10, var_3_11, var_1_10005)

	return
end

function var_0_1.AddListeners(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.AddListener

	GAME = var_1_10003

	var_8_1(var_8_0, var_1_10003.ISLAND_UPGRADE_DONE, arg_8_0.OnUpgrade)

	local var_8_2 = arg_8_0
	local var_8_3 = arg_8_0.AddListener

	GAME = var_3

	var_8_3(var_8_2, var_3.ISLAND_PROSPERITY_AWARD_DONE, arg_8_0.OnGetAward)

	local var_8_4 = arg_8_0
	local var_8_5 = arg_8_0.AddListener

	GAME = var_3

	var_8_5(var_8_4, var_3.ISLAND_SET_NAME_DONE, arg_8_0.OnModifyName)

	return
end

function var_0_1.RemoveListeners(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.RemoveListener

	GAME = var_1_10003

	var_9_1(var_9_0, var_1_10003.ISLAND_UPGRADE_DONE, arg_9_0.OnUpgrade)

	local var_9_2 = arg_9_0
	local var_9_3 = arg_9_0.RemoveListener

	GAME = var_3

	var_9_3(var_9_2, var_3.ISLAND_PROSPERITY_AWARD_DONE, arg_9_0.OnGetAward)

	local var_9_4 = arg_9_0
	local var_9_5 = arg_9_0.RemoveListener

	GAME = var_3

	var_9_5(var_9_4, var_3.ISLAND_SET_NAME_DONE, arg_9_0.OnModifyName)

	return
end

function var_0_1.OnUpgrade(arg_10_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_10_0 = var_1_10001(var_1_10002)
	local var_10_1 = var_1.GetIsland(var_10_0)

	arg_10_0:UpdateLevel(var_10_1)

	return
end

function var_0_1.OnGetAward(arg_11_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_11_0 = var_1_10001(var_1_10002)
	local var_11_1 = var_1.GetIsland(var_11_0)

	arg_11_0:UpdateProsperity(var_11_1)

	return
end

function var_0_1.OnModifyName(arg_12_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_12_0 = var_1_10001(var_1_10002)
	local var_12_1 = var_1.GetIsland(var_12_0)

	arg_12_0:UpdateName(var_12_1)

	return
end

function var_0_1.Show(arg_13_0)
	var_0_1.super.Show(arg_13_0)

	getProxy = var_1
	IslandProxy = var_2

	local var_13_0 = var_1(var_2)
	local var_13_1 = var_1.GetIsland(var_13_0)

	arg_13_0:UpdateLevel(var_13_1)
	arg_13_0:UpdateProsperity(var_13_1)
	arg_13_0:UpdateName(var_13_1)
	arg_13_0:UpdateShips(var_13_1)

	pg = var_2

	local var_13_2 = var_2.UIMgr.GetInstance()
	local var_13_3 = var_2.OverlayPanel
	local var_13_4 = arg_13_0._tf
	local var_13_5 = {}
	local var_13_6 = {}
	local var_13_7 = arg_13_0._tf

	var_13_6[1] = var_7.Find(var_13_7, "frame/right")
	var_13_5.pbList = var_13_6

	var_13_3(var_13_2, var_13_4, var_13_5)

	return
end

function var_0_1.Hide(arg_14_0)
	var_0_1.super.Hide(arg_14_0)

	pg = var_1

	local var_14_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_14_0, arg_14_0._tf, arg_14_0._parentTf)

	return
end

function var_0_1.InitUpgradeAwards(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1:GetUpgradeAwards()
	local var_15_1 = arg_15_0.upgradeAwardList

	var_3.make(var_15_1, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = var_15_0[arg_16_1 + 1]

			Drop = var_4

			local var_16_1 = var_4.Create(var_16_0)

			updateCustomDrop = var_5

			var_5(arg_16_2, var_16_1)
		end

		return
	end)

	local var_15_2 = arg_15_0.upgradeAwardList

	var_3.align(var_15_2, #var_15_0)

	local var_15_3 = arg_15_1:GetUnlockBuildingList()
	local var_15_4 = arg_15_0.upgradeUnlockList

	var_4.make(var_15_4, function(arg_17_0, arg_17_1, arg_17_2)
		UIItemList = var_2_10003

		if arg_17_0 == var_2_10003.EventUpdate then
			local var_17_0 = var_15_3[arg_17_1 + 1]

			Drop = var_4

			local var_17_1 = var_4.Create(var_17_0)

			updateCustomDrop = var_5

			var_5(arg_17_2, var_17_1)
		end

		return
	end)

	local var_15_5 = arg_15_0.upgradeUnlockList

	var_4.align(var_15_5, #var_15_3)

	return
end

function var_0_1.UpdateLevel(arg_18_0, arg_18_1)
	arg_18_0.levelTxt.text = arg_18_1:GetLevel()

	local var_18_0 = arg_18_1:GetExp()
	local var_18_1 = arg_18_1:GetTargeExp()
	local var_18_2 = "#39bfff"
	local var_18_3 = "#f36c6e"

	customColorCount = var_1_10006

	var_1_10006(arg_18_0.expTxt, var_18_0, var_18_1, var_18_2, var_18_3)

	setFillAmount = var_1_10006

	local var_18_4 = arg_18_0.expProgress

	Mathf = var_8

	var_1_10006(var_18_4, var_8.Clamp01(var_18_0 / var_18_1))

	return
end

function var_0_1.UpdateProsperity(arg_19_0, arg_19_1)
	local var_19_0 = {}
	local var_19_1 = arg_19_0.prosperityLevelList

	var_3.make(var_19_1, function(arg_20_0, arg_20_1, arg_20_2)
		UIItemList = var_2_10003

		if arg_20_0 == var_2_10003.EventUpdate then
			pg = var_3

			local var_20_0 = var_3.island_prosperity.all[arg_20_1 + 1]
			local var_20_1 = arg_19_0

			var_4.UpdateProsperityCard(var_20_1, arg_20_2, var_20_0, arg_19_1)

			var_19_0[var_20_0] = arg_20_2
		end

		return
	end)

	local var_19_2 = arg_19_0.prosperityLevelList
	local var_19_3 = var_3.align

	pg = var_5

	var_19_3(var_19_2, #var_5.island_prosperity.all)

	local var_19_4

	if not var_19_0[arg_19_1:GetProsperityLevel()] then
		var_19_4 = var_19_0[1]
	end

	if var_19_4 then
		triggerToggle = var_5

		var_5(var_19_4, true)
	end

	return
end

function var_0_1.UpdateProsperityCard(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_3:CanGetProsperityAwards(arg_21_2)
	local var_21_1 = arg_21_3:IsReceiveProsperityAwards(arg_21_2)
	local var_21_2 = arg_21_3:GetProsperityLevel() == arg_21_2
	local var_21_3 = arg_21_3
	local var_21_4 = arg_21_3.GetMaxProsperityLevel(var_21_3)

	setActive = var_21_3

	var_21_3(arg_21_1:Find("line"), var_21_4 ~= arg_21_2)

	setActive = var_21_3

	var_21_3(arg_21_1:Find("got"), var_21_1)

	setActive = var_21_3

	var_21_3(arg_21_1:Find("get"), var_21_0)

	setActive = var_21_3

	var_21_3(arg_21_1:Find("lock"), not var_21_0 and not var_21_1 and not var_21_2)

	setActive = var_21_3

	var_21_3(arg_21_1:Find("curr"), var_21_2 and not var_21_1)

	onToggle = var_21_3

	local var_21_5 = arg_21_0
	local var_21_6 = arg_21_1

	local function var_21_7()
		local var_22_0 = arg_21_0

		var_0.FlushProsperity(var_22_0, arg_21_3, arg_21_2, var_21_0, var_21_1)

		return
	end

	SFX_PANEL = var_1_10012

	var_21_3(var_21_5, var_21_6, var_21_7, var_1_10012)

	return
end

function var_0_1.FlushProsperity(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	ArabicToRoman = var_1_10005

	local var_23_0 = var_1_10005(arg_23_2)

	arg_23_0.prosperityLevel.text = var_23_0

	local var_23_1 = arg_23_1:GetProsperity()
	local var_23_2 = arg_23_1:GetTargetProsperityByLevel(arg_23_2)
	local var_23_3 = arg_23_0.prosperityExp

	i18n = var_9
	var_23_3.text = var_9("island_prosperity_level_display", var_23_1 .. "/" .. var_23_2)

	local var_23_4 = arg_23_1:GetProsperityAward(arg_23_2)
	local var_23_5 = arg_23_0.prosperityAwardList

	var_9.make(var_23_5, function(arg_24_0, arg_24_1, arg_24_2)
		UIItemList = var_2_10003

		if arg_24_0 == var_2_10003.EventUpdate then
			local var_24_0 = var_23_4[arg_24_1 + 1]

			Drop = var_4

			local var_24_1 = var_4.Create(var_24_0)

			updateCustomDrop = var_5

			var_5(arg_24_2, var_24_1)
		end

		return
	end)

	local var_23_6 = arg_23_0.prosperityAwardList

	var_9.align(var_23_6, #var_23_4)

	setActive = var_9

	var_9(arg_23_0.getProsperityBtn, arg_23_3)

	setActive = var_9

	var_9(arg_23_0.goProsperityBtn, not arg_23_4 and not arg_23_3)

	local var_23_7 = arg_23_0.goProsperityBtnTxt

	i18n = var_10
	var_23_7.text = var_10("island_prosperity_value_display", var_23_2)
	onButton = var_23_7

	local var_23_8 = arg_23_0
	local var_23_9 = arg_23_0.getProsperityBtn

	local function var_23_10()
		local var_25_0 = arg_23_0
		local var_25_1 = var_0.emit

		IslandMediator = var_2_10002

		var_25_1(var_25_0, var_2_10002.GET_PROSPERITY_AWARD, arg_23_2)

		return
	end

	SFX_PANEL = var_13

	var_23_7(var_23_8, var_23_9, var_23_10, var_13)

	GetImageSpriteFromAtlasAsync = var_23_7

	var_23_7("island/IslandProsperityIcon/" .. arg_23_2, "", arg_23_0.prosperityIcon)

	return
end

function var_0_1.UpdateName(arg_26_0, arg_26_1)
	arg_26_0.nameTxt.text = arg_26_1:GetName()

	return
end

function var_0_1.UpdateShips(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1:GetCharacterAgency()
	local var_27_1 = var_2.GetShips(var_27_0)
	local var_27_2 = arg_27_0.uiShipList

	var_3.make(var_27_2, function(arg_28_0, arg_28_1, arg_28_2)
		UIItemList = var_2_10003

		if arg_28_0 == var_2_10003.EventUpdate then
			local var_28_0 = var_27_1[arg_28_1 + 1]
			local var_28_1 = arg_27_0

			var_4.UpdateShipCard(var_28_1, arg_28_2, var_28_0)
		end

		return
	end)

	local var_27_3 = arg_27_0.uiShipList

	var_3.align(var_27_3, 5)

	return
end

function var_0_1.UpdateShipCard(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_2 == nil

	setActive = var_1_10004

	var_1_10004(arg_29_1:Find("add"), var_29_0)

	setActive = var_1_10004

	var_1_10004(arg_29_1:Find("ship"), not var_29_0)

	if not var_29_0 then
		local var_29_1 = arg_29_2

		var_1_10004 = arg_29_2.GetPrefab(var_29_1)
		GetImageSpriteFromAtlasAsync = var_29_1

		var_29_1("SquareIcon/" .. var_1_10004, "", arg_29_1:Find("ship/mask/icon"))
	end

	onButton = var_1_10004

	local var_29_2 = arg_29_0
	local var_29_3 = arg_29_1

	local function var_29_4()
		pg = var_2_10000

		local var_30_0 = var_2_10000.TipsMgr.GetInstance()
		local var_30_1 = var_0.ShowTips

		i18n = var_2_10002

		var_30_1(var_30_0, var_2_10002("word_comingSoon"))

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10004(var_29_2, var_29_3, var_29_4, var_1_10008)

	return
end

function var_0_1.OnDestroy(arg_31_0)
	return
end

return var_0_1
