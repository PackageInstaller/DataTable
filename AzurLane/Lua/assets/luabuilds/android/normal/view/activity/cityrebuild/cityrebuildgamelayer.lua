class = var_0_10000

local var_0_0 = "CityRebuildGameLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "CityRebuildGameUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bg1 = var_1.Find(var_2_0, "bgs/bg1")

	local var_2_1 = arg_2_0._tf

	arg_2_0.bg2 = var_1.Find(var_2_1, "bgs/bg2")

	local var_2_2 = arg_2_0._tf

	arg_2_0.bg3 = var_1.Find(var_2_2, "bgs/bg3")

	local var_2_3 = arg_2_0._tf

	arg_2_0._ship = var_1.Find(var_2_3, "ship")

	local var_2_4 = arg_2_0._tf

	arg_2_0._ship2 = var_1.Find(var_2_4, "ship2")

	local var_2_5 = arg_2_0._tf

	arg_2_0.effect = var_1.Find(var_2_5, "effect")

	local var_2_6 = arg_2_0._tf

	arg_2_0.ui = var_1.Find(var_2_6, "ui")

	local var_2_7 = arg_2_0.ui

	arg_2_0.backBtn = var_1.Find(var_2_7, "top/backBtn")

	local var_2_8 = arg_2_0.ui

	arg_2_0.homeBtn = var_1.Find(var_2_8, "top/homeBtn")

	local var_2_9 = arg_2_0.ui

	arg_2_0.hpSlider = var_1.Find(var_2_9, "top/hpSlider")

	local var_2_10 = arg_2_0.ui

	arg_2_0.hp = var_1.Find(var_2_10, "top/hp")
	UIItemList = var_1

	local var_2_11 = var_1.New
	local var_2_12 = arg_2_0.ui
	local var_2_13 = var_2.Find(var_2_12, "top/awardPanel/first/items")
	local var_2_14 = arg_2_0.ui

	arg_2_0.firstAwardList = var_2_11(var_2_13, var_3.Find(var_2_14, "top/awardPanel/first/items/item"))

	local var_2_15 = arg_2_0.ui

	arg_2_0.ptAwardCount = var_1.Find(var_2_15, "top/awardPanel/others/count")

	local var_2_16 = arg_2_0.ui

	arg_2_0.cityLevel = var_1.Find(var_2_16, "left/cityLevel/Text")

	local var_2_17 = arg_2_0.ui

	arg_2_0.battleLevel = var_1.Find(var_2_17, "left/battleLevel/Text")

	local var_2_18 = arg_2_0.ui

	arg_2_0.summaryPanel = var_1.Find(var_2_18, "left/panel")

	local var_2_19 = arg_2_0.ui

	arg_2_0.currentLevel = var_1.Find(var_2_19, "top/currentLevel/Text")

	local var_2_20 = arg_2_0.ui

	arg_2_0.enemyName = var_1.Find(var_2_20, "top/enemyName")

	local var_2_21 = arg_2_0.ui

	arg_2_0.resultBtn = var_1.Find(var_2_21, "right/resultBtn")

	local var_2_22 = arg_2_0.ui

	arg_2_0.bookBtn = var_1.Find(var_2_22, "right/bookBtn")

	local var_2_23 = arg_2_0.ui

	arg_2_0.taskBtn = var_1.Find(var_2_23, "right/taskBtn")

	local var_2_24 = arg_2_0.ui

	arg_2_0.previousLevelBtn = var_1.Find(var_2_24, "right/previousLevelBtn")

	local var_2_25 = arg_2_0.ui

	arg_2_0.nextLevelBtn = var_1.Find(var_2_25, "right/nextLevelBtn")

	local var_2_26 = arg_2_0._tf
	local var_2_27 = var_1.Find(var_2_26, "damage")
	local var_2_28 = var_1.GetComponent

	typeof = var_3
	Animation = var_2_14
	arg_2_0.damageAni = var_2_28(var_2_27, var_3(var_2_14))

	local var_2_29 = arg_2_0._tf

	arg_2_0.damageText = var_1.Find(var_2_29, "damage/Text")

	local var_2_30 = arg_2_0._tf

	arg_2_0.effect = var_1.Find(var_2_30, "effect")

	local var_2_31 = {}
	local var_2_32 = arg_2_0.effect

	var_2_31[1] = var_2.Find(var_2_32, "xinnianyouxi_baozha")

	local var_2_33 = arg_2_0.effect

	var_2_31[2] = var_2.Find(var_2_33, "xinnianyouxi_baozha2")

	local var_2_34 = arg_2_0.effect

	var_2_31[3] = var_2.Find(var_2_34, "xinnianyouxi_baozha3")
	arg_2_0.deadEffectList = var_2_31
	setText = var_2_31

	local var_2_35 = arg_2_0.ui
	local var_2_36 = var_2.Find(var_2_35, "left/cityLevel/title")

	i18n = var_2_35

	var_2_31(var_2_36, var_2_35("ninja_game_citylevel"))

	setText = var_2_31

	local var_2_37 = arg_2_0.ui
	local var_2_38 = var_2.Find(var_2_37, "left/battleLevel/title")

	i18n = var_2_37

	var_2_31(var_2_38, var_2_37("ninja_game_wave"))

	setText = var_2_31

	local var_2_39 = arg_2_0.summaryPanel
	local var_2_40 = var_2.Find(var_2_39, "buildingDPS")

	i18n = var_2_39

	var_2_31(var_2_40, var_2_39("ninja_game_citydmg"))

	setText = var_2_31

	local var_2_41 = arg_2_0.summaryPanel
	local var_2_42 = var_2.Find(var_2_41, "charaDPS")

	i18n = var_2_41

	var_2_31(var_2_42, var_2_41("ninja_game_allydmg"))

	setText = var_2_31

	local var_2_43 = arg_2_0.summaryPanel
	local var_2_44 = var_2.Find(var_2_43, "DPS")

	i18n = var_2_43

	var_2_31(var_2_44, var_2_43("ninja_game_dps"))

	setText = var_2_31

	local var_2_45 = arg_2_0.summaryPanel
	local var_2_46 = var_2.Find(var_2_45, "time")

	i18n = var_2_45

	var_2_31(var_2_46, var_2_45("ninja_game_time"))

	setText = var_2_31

	local var_2_47 = arg_2_0.summaryPanel
	local var_2_48 = var_2.Find(var_2_47, "pts")

	i18n = var_2_47

	var_2_31(var_2_48, var_2_47("ninja_game_income"))

	setText = var_2_31

	local var_2_49 = arg_2_0.summaryPanel
	local var_2_50 = var_2.Find(var_2_49, "pt")

	i18n = var_2_49

	var_2_31(var_2_50, var_2_49("ninja_game_ptcount"))

	pg = var_2_31

	local var_2_51 = var_2_31.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_51, arg_2_0._tf)

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:InitData()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.homeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_HOME)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.bookBtn

	local function var_3_8()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		CityRebuildGameMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.OPEN_BOOK)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.taskBtn

	local function var_3_11()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		CityRebuildGameMediator = var_2_10002

		var_7_1(var_7_0, var_2_10002.OPEN_TASKS)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_9, var_3_10, var_3_11, var_1_10005)

	onButton = var_1

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.previousLevelBtn

	local function var_3_14()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.emit

		CityRebuildGameMediator = var_2_10002

		var_8_1(var_8_0, var_2_10002.CHOOSE_LEVEL, arg_3_0.activityId, arg_3_0.cityRebuildData.curLevel - 1)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_12, var_3_13, var_3_14, var_1_10005)

	onButton = var_1

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.nextLevelBtn

	local function var_3_17()
		local var_9_0 = arg_3_0
		local var_9_1 = var_0.emit

		CityRebuildGameMediator = var_2_10002

		var_9_1(var_9_0, var_2_10002.CHOOSE_LEVEL, arg_3_0.activityId, arg_3_0.cityRebuildData.curLevel + 1)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_15, var_3_16, var_3_17, var_1_10005)

	onButton = var_1

	local var_3_18 = arg_3_0
	local var_3_19 = arg_3_0.resultBtn

	local function var_3_20()
		local var_10_0 = arg_3_0
		local var_10_1 = var_0.emit

		CityRebuildGameMediator = var_2_10002

		var_10_1(var_10_0, var_2_10002.RESULT, arg_3_0.activityId)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_3_18, var_3_19, var_3_20, var_1_10005)
	arg_3_0:BgScroll()
	arg_3_0:Refresh()

	return
end

function var_0_1.InitData(arg_11_0)
	ActivityConst = var_1_10001
	arg_11_0.activityId = var_1_10001.NINJA_CITY_ACT_ID
	getProxy = var_1
	CityRebuildProxy = var_1_10002
	arg_11_0.cityRebuildProxy = var_1(var_1_10002)

	local var_11_0 = arg_11_0.cityRebuildProxy

	arg_11_0.cityRebuildData = var_1.GetData(var_11_0, arg_11_0.activityId)

	if arg_11_0.cityRebuildData.startTime == 0 then
		local var_11_1 = arg_11_0
		local var_11_2 = arg_11_0.emit

		CityRebuildGameMediator = var_3

		var_11_2(var_11_1, var_3.INIT_TIME, arg_11_0.activityId)
	end

	return
end

function var_0_1.BgScroll(arg_12_0)
	local var_12_0 = 0.66 * arg_12_0._tf.rect.height / 1080
	local var_12_1 = arg_12_0.bg1

	Vector3 = var_1_10003
	var_12_1.localScale = var_1_10003(var_12_0, var_12_0, 0)

	local var_12_2 = arg_12_0.bg2

	Vector3 = var_3
	var_12_2.localScale = var_3(var_12_0, var_12_0, 0)

	local var_12_3 = arg_12_0.bg3

	Vector3 = var_3
	var_12_3.localScale = var_3(var_12_0, var_12_0, 0)

	local var_12_4 = arg_12_0.bg1.rect.width * var_12_0
	local var_12_5 = arg_12_0.bg2.rect.width * var_12_0
	local var_12_6 = arg_12_0.bg3.rect.width * var_12_0

	LeanTween = var_5

	local var_12_7 = var_5.value

	go = var_6

	local var_12_8 = var_12_7(var_6(arg_12_0.bg1), 0, var_12_4, 20)
	local var_12_9 = var_5.setOnUpdate

	System = var_7

	local var_12_10 = var_12_9(var_12_8, var_7.Action_float(function(arg_13_0)
		local var_13_0 = arg_12_0.bg1

		Vector2 = var_2_10002
		var_13_0.anchoredPosition = var_2_10002(arg_13_0, 0)

		return
	end))
	local var_12_11 = var_5.setEase

	LeanTweenType = var_7

	local var_12_12 = var_12_11(var_12_10, var_7.linear)

	var_5.setLoopClamp(var_12_12)

	LeanTween = var_5

	local var_12_13 = var_5.value

	go = var_12_12

	local var_12_14 = var_12_13(var_12_12(arg_12_0.bg2), 0, var_12_5, 14)
	local var_12_15 = var_5.setOnUpdate

	System = var_7

	local var_12_16 = var_12_15(var_12_14, var_7.Action_float(function(arg_14_0)
		local var_14_0 = arg_12_0.bg2

		Vector2 = var_2_10002
		var_14_0.anchoredPosition = var_2_10002(arg_14_0, 0)

		return
	end))
	local var_12_17 = var_5.setEase

	LeanTweenType = var_7

	local var_12_18 = var_12_17(var_12_16, var_7.linear)

	var_5.setLoopClamp(var_12_18)

	LeanTween = var_5

	local var_12_19 = var_5.value

	go = var_12_18

	local var_12_20 = var_12_19(var_12_18(arg_12_0.bg3), 0, var_12_6, 10)
	local var_12_21 = var_5.setOnUpdate

	System = var_7

	local var_12_22 = var_12_21(var_12_20, var_7.Action_float(function(arg_15_0)
		local var_15_0 = arg_12_0.bg3

		Vector2 = var_2_10002
		var_15_0.anchoredPosition = var_2_10002(arg_15_0, 0)

		return
	end))
	local var_12_23 = var_5.setEase

	LeanTweenType = var_7

	local var_12_24 = var_12_23(var_12_22, var_7.linear)

	var_5.setLoopClamp(var_12_24)

	return
end

function var_0_1.Refresh(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.cityRebuildProxy

	arg_16_0.cityRebuildData = var_2.GetData(var_16_0, arg_16_0.activityId)

	if not arg_16_1 then
		arg_16_0:SetSpine()
	end

	setText = var_2

	var_2(arg_16_0.cityLevel, "LV." .. arg_16_0.cityRebuildData.cityLevel)

	setText = var_2

	var_2(arg_16_0.battleLevel, arg_16_0.cityRebuildData.maxChooseLevel)
	arg_16_0:SetLevelAndAward()
	arg_16_0:SetSummaryPanelAndHp()

	return
end

function var_0_1.SetSpine(arg_17_0)
	arg_17_0:ClearSpine()

	pg = var_1
	arg_17_0.prefab = var_1.activity_ninja_enemy[arg_17_0.cityRebuildData.curLevel].model

	local var_17_0 = arg_17_0.prefab

	tonumber = var_2
	pg = var_1_10003

	local var_17_1 = var_2(var_1_10003.activity_ninja_enemy[arg_17_0.cityRebuildData.curLevel].scale)

	Vector3 = var_3

	local var_17_2 = var_3(-var_17_1, var_17_1, 1)

	Vector3 = var_4

	local var_17_3 = var_4(0, -328, 0)

	Vector3 = var_5

	local var_17_4 = var_5(-600, -328, 0)

	arg_17_0.aliveEnemy = 1
	PoolMgr = var_6

	local var_17_5 = var_6.GetInstance()

	var_6.GetSpineChar(var_17_5, var_17_0, true, function(arg_18_0)
		if var_17_0 ~= arg_17_0.prefab or var_17_0 == arg_17_0.loadedPrefab then
			PoolMgr = var_1

			local var_18_0 = var_1.GetInstance()

			var_1.ReturnSpineChar(var_18_0, var_17_0, arg_18_0)

			return
		end

		arg_17_0.loadedPrefab = var_17_0
		arg_17_0.model = arg_18_0

		local var_18_1 = arg_17_0.model.transform

		Vector3 = var_2
		var_18_1.localScale = var_2.one

		local var_18_2 = arg_17_0.model.transform

		Vector3 = var_2
		var_18_2.localPosition = var_2.zero

		local var_18_3 = arg_17_0.model.transform

		var_1.SetParent(var_18_3, arg_17_0._ship, false)

		arg_17_0._ship.localScale = var_17_2

		local var_18_4 = arg_17_0
		local var_18_5 = arg_17_0.model
		local var_18_6 = var_2.GetComponent

		typeof = var_4
		SpineAnimUI = var_2_10005
		var_18_4.anim = var_18_6(var_18_5, var_4(var_2_10005))

		local var_18_7 = arg_17_0

		var_1.WalkSpine(var_18_7, arg_17_0.model, arg_17_0.anim, arg_17_0._ship)

		return
	end)

	PoolMgr = var_6

	local var_17_6 = var_6.GetInstance()

	var_6.GetSpineChar(var_17_6, var_17_0, true, function(arg_19_0)
		if var_17_0 ~= arg_17_0.prefab or var_17_0 == arg_17_0.loadedPrefab2 then
			PoolMgr = var_1

			local var_19_0 = var_1.GetInstance()

			var_1.ReturnSpineChar(var_19_0, var_17_0, arg_19_0)

			return
		end

		arg_17_0.loadedPrefab2 = var_17_0
		arg_17_0.model2 = arg_19_0

		local var_19_1 = arg_17_0.model2.transform

		Vector3 = var_2
		var_19_1.localScale = var_2.one

		local var_19_2 = arg_17_0.model2.transform

		Vector3 = var_2
		var_19_2.localPosition = var_2.zero

		local var_19_3 = arg_17_0.model2.transform

		var_1.SetParent(var_19_3, arg_17_0._ship2, false)

		arg_17_0._ship2.localScale = var_17_2

		local var_19_4 = arg_17_0
		local var_19_5 = arg_17_0.model2
		local var_19_6 = var_2.GetComponent

		typeof = var_4
		SpineAnimUI = var_2_10005
		var_19_4.anim2 = var_19_6(var_19_5, var_4(var_2_10005))

		return
	end)

	setActive = var_6

	var_6(arg_17_0._ship, true)

	setActive = var_6

	var_6(arg_17_0._ship2, false)

	return
end

function var_0_1.WalkSpine(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_1 and arg_20_2 then
		setActive = var_1_10004

		var_1_10004(arg_20_3, true)

		Vector3 = var_1_10004

		local var_20_0 = var_1_10004(0, -4, 0)

		Vector3 = var_5

		local var_20_1 = var_5(-600, -4, 0)

		arg_20_2:SetAction("move", 0)

		LeanTween = var_6

		local var_20_2 = var_6.value(arg_20_0._go, 0, 1, 0.5)
		local var_20_3 = var_6.setOnUpdate

		System = var_8

		var_20_3(var_20_2, var_8.Action_float(function(arg_21_0)
			local var_21_0 = arg_20_3

			Vector3 = var_2_10002
			var_21_0.anchoredPosition3D = var_2_10002.Lerp(var_20_0, var_20_1, arg_21_0)

			return
		end))
	end

	return
end

function var_0_1.DeadSpine(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_1 and arg_22_2 then
		ipairs = var_1_10004

		for iter_22_0, iter_22_1 in var_1_10004(arg_22_0.deadEffectList) do
			isActive = var_1_10009

			if not var_1_10009(iter_22_1) then
				setActive = var_1_10009

				var_1_10009(arg_22_3, false)

				setActive = var_1_10009

				var_1_10009(iter_22_1, true)
				arg_22_0:StartTimers(function()
					setActive = var_2_10000

					var_2_10000(iter_22_1, false)

					local var_23_0 = arg_22_0.timerList["effect" .. iter_22_0]

					var_0.Stop(var_23_0)

					arg_22_0.timerList["effect" .. iter_22_0] = nil

					return
				end, 2, "effect" .. iter_22_0)

				break
			end
		end
	end

	return
end

function var_0_1.ClearSpine(arg_24_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_24_0.model) then
		PoolMgr = var_1

		local var_24_0 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_24_0, arg_24_0.prefab, arg_24_0.model)

		arg_24_0.loadedPrefab = nil
	end

	IsNil = var_1

	if not var_1(arg_24_0.model2) then
		PoolMgr = var_1

		local var_24_1 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_24_1, arg_24_0.prefab, arg_24_0.model2)

		arg_24_0.loadedPrefab2 = nil
	end

	return
end

function var_0_1.SetLevelAndAward(arg_25_0)
	pg = var_1_10001

	local var_25_0 = var_1_10001.activity_ninja_enemy[arg_25_0.cityRebuildData.curLevel]

	setText = var_2

	var_2(arg_25_0.currentLevel, arg_25_0.cityRebuildData.curLevel)

	setText = var_2

	var_2(arg_25_0.enemyName, var_25_0.name)

	local var_25_1 = arg_25_0.firstAwardList

	var_2.make(var_25_1, function(arg_26_0, arg_26_1, arg_26_2)
		UIItemList = var_2_10003

		if arg_26_0 == var_2_10003.EventUpdate then
			local var_26_0 = var_25_0.first_drop_show[arg_26_1 + 1]
			local var_26_1 = {
				type = var_26_0[1],
				id = var_26_0[2],
				count = var_26_0[3]
			}

			updateDrop = var_5

			var_5(arg_26_2:Find("mask/item"), var_26_1)

			onButton = var_5

			local var_26_2 = arg_25_0
			local var_26_3 = arg_26_2

			local function var_26_4()
				local var_27_0 = arg_25_0
				local var_27_1 = var_0.emit

				BaseUI = var_3_10002

				var_27_1(var_27_0, var_3_10002.ON_DROP, var_26_1)

				return
			end

			SFX_PANEL = var_2_10009

			var_5(var_26_2, var_26_3, var_26_4, var_2_10009)
		end

		return
	end)

	local var_25_2 = arg_25_0.firstAwardList

	var_2.align(var_25_2, #var_25_0.first_drop_show)

	setActive = var_2

	local var_25_3 = arg_25_0.resultBtn

	var_2(var_3.Find(var_25_3, "count"), arg_25_0.cityRebuildData.summaryPt > 0)

	setText = var_2

	local var_25_4 = arg_25_0.resultBtn
	local var_25_5 = var_3.Find(var_25_4, "count")

	CityRebuildData = var_25_4

	var_2(var_25_5, var_25_4.PtToShow(arg_25_0.cityRebuildData.summaryPt) .. "+")

	return
end

function var_0_1.SetSummaryPanelAndHp(arg_28_0)
	local var_28_0 = arg_28_0.cityRebuildData.buildings
	local var_28_1 = arg_28_0.cityRebuildData.roles
	local var_28_2 = arg_28_0.cityRebuildData.buffLevels
	local var_28_3 = arg_28_0.cityRebuildData.curLevel % 5 == 0
	local var_28_4 = 0

	pg = var_1_10007

	local var_28_5 = var_1_10007.activity_ninja_enemy[var_4].basic
	local var_28_6

	if var_4 < 51 then
		math = var_28_6
		var_28_6 = var_28_6.ceil

		local var_28_7 = var_28_5 * (var_4 - 1 + arg_28_0:GetParam(9)^(var_4 - 1))
		local var_28_8

		if not var_28_3 or not arg_28_0:GetParam(10) then
			var_28_8 = 1
		end

		var_28_4 = var_28_6(var_28_7 * var_28_8 * arg_28_0:GetParam(11)^(var_28_2[3] - 1))
	else
		math = var_28_6
		var_28_6 = var_28_6.ceil

		local var_28_9 = var_28_5 * (arg_28_0:GetParam(16) + arg_28_0:GetParam(9)^arg_28_0:GetParam(16) * arg_28_0:GetParam(13)^(var_4 - (arg_28_0:GetParam(16) + 1)))
		local var_28_10

		if not var_28_3 or not arg_28_0:GetParam(10) then
			var_28_10 = 1
		end

		var_28_4 = var_28_6(var_28_9 * var_28_10 * arg_28_0:GetParam(11)^(var_28_2[3] - 1))
	end

	math = var_28_6

	local var_28_11 = var_28_6.ceil(arg_28_0:GetParam(14)^var_4 * arg_28_0:GetParam(15)^var_28_2[4])

	math = var_9

	local var_28_12 = var_9.ceil((#var_28_0 + var_28_2[10] + (#var_28_0 + var_28_2[10]) * arg_28_0:GetParam(1)^(var_28_2[8] - 1) / arg_28_0:GetParam(2)) * arg_28_0:GetParam(3)^(var_28_2[9] - 1) + arg_28_0:GetParam(4) * var_28_2[7])

	math = var_10

	local var_28_13 = var_28_12 + var_10.ceil((#var_28_1 + var_28_2[5]) * arg_28_0:GetParam(5)^(var_28_2[1] - 1) + arg_28_0:GetParam(6) * var_28_2[2])

	CityRebuildData = var_12

	local var_28_14 = var_12.PtToShow(arg_28_0.cityRebuildData.pt)

	math = var_13

	local var_28_15 = var_13.ceil(var_28_4 / var_28_13)

	string = var_14

	local var_28_16 = var_14.format("%.2f", var_28_11 / var_28_15)

	setText = var_15

	local var_28_17 = arg_28_0.summaryPanel

	var_15(var_16.Find(var_28_17, "buildingDPS/Text"), var_28_12)

	setText = var_15

	local var_28_18 = arg_28_0.summaryPanel

	var_15(var_16.Find(var_28_18, "charaDPS/Text"), var_10)

	setText = var_15

	local var_28_19 = arg_28_0.summaryPanel

	var_15(var_16.Find(var_28_19, "DPS/Text"), var_28_13)

	setText = var_15

	local var_28_20 = arg_28_0.summaryPanel

	var_15(var_16.Find(var_28_20, "time/Text"), var_28_15 .. "s")

	setText = var_15

	local var_28_21 = arg_28_0.summaryPanel

	var_15(var_16.Find(var_28_21, "pts/Text"), "+" .. var_28_16 .. "/s")

	setText = var_15

	local var_28_22 = arg_28_0.summaryPanel

	var_15(var_16.Find(var_28_22, "pt/Text"), var_28_14)

	setText = var_15

	local var_28_23 = arg_28_0.ptAwardCount

	CityRebuildData = var_17

	var_15(var_28_23, var_17.PtToShow(var_28_11))

	local var_28_24 = var_28_4

	if arg_28_0.cityRebuildData.leftHp ~= 0 then
		var_28_24 = arg_28_0.cityRebuildData.leftHp
	end

	math = var_16

	local var_28_25 = var_16.ceil(var_28_24 / var_28_13)

	setActive = var_17

	var_17(arg_28_0.previousLevelBtn, var_4 > 1)

	pg = var_17

	local var_28_26 = var_17.activity_ninja_enemy.all

	pg = var_18

	local var_28_27 = var_28_26[#var_18.activity_ninja_enemy.all] > arg_28_0.cityRebuildData.curLevel

	arg_28_0.canChangeNextLevel = arg_28_0.cityRebuildData.curLevel < arg_28_0.cityRebuildData.maxLevel + 1

	local var_28_29

	if not arg_28_0.canChangeNextLevel then
		pg = var_28_29

		local var_28_28 = var_28_29.TimeMgr.GetInstance()

		var_28_29 = var_28_25 <= var_28_29.GetServerTime(var_28_28) - arg_28_0.cityRebuildData.startTime
		arg_28_0.canChangeNextLevel = var_28_29
	end

	setActive = var_28_29

	local var_28_30 = arg_28_0.nextLevelBtn
	local var_28_31

	if arg_28_0.canChangeNextLevel then
		var_28_31 = var_28_27
	end

	var_28_29(var_28_30, var_28_31)

	setText = var_28_29

	var_28_29(arg_28_0.damageText, "-" .. var_28_13)

	tostring = var_28_29

	local var_28_32 = #var_28_29(var_28_13)
	local var_28_33 = 70

	if var_28_32 > 3 then
		var_28_33 = 67 + var_28_32
	end

	local var_28_34 = arg_28_0.damageText
	local var_28_35 = var_21.GetComponent

	typeof = var_1_10023
	Text = var_1_10024
	var_28_35(var_28_34, var_1_10023(var_1_10024)).fontSize = var_28_33

	local var_28_36 = {}
	local var_28_37 = {}
	local var_28_38 = arg_28_0.cityRebuildData.buffs

	ipairs = var_1_10024

	for iter_28_0, iter_28_1 in var_1_10024(var_28_38) do
		pg = var_1_10029
		var_1_10029 = var_1_10029.activity_ninja_buff[iter_28_1].battle_effect
		table = var_1_10030

		if not var_1_10030.contains(var_28_36, var_1_10029) then
			table = var_1_10030

			var_1_10030.insert(var_28_36, var_1_10029)

			table = var_1_10030
			var_1_10030 = var_1_10030.insert

			local var_28_39 = var_28_37
			local var_28_40 = arg_28_0.effect

			var_1_10030(var_28_39, var_32.Find(var_28_40, var_1_10029))
		end
	end

	arg_28_0.effectWaitingTime = 0
	arg_28_0.effectPlayingTime = 2
	arg_28_0.isPlayingEffect = false

	arg_28_0:RemoveTimer()
	arg_28_0:StartTimer(function()
		pg = var_2_10000

		local var_29_0 = var_2_10000.TimeMgr.GetInstance()
		local var_29_1 = var_0.GetServerTime(var_29_0) - arg_28_0.cityRebuildData.startTime
		local var_29_2 = 0

		if var_28_25 <= var_29_1 then
			var_29_2 = var_28_4 - (var_29_1 - var_28_25) % var_28_15 * var_28_13
		else
			var_29_2 = var_28_24 - var_29_1 * var_28_13
		end

		setSlider = var_2

		var_2(arg_28_0.hpSlider, 0, var_28_4, var_29_2)

		setText = var_2

		local var_29_3 = arg_28_0.hp

		CityRebuildData = var_4

		local var_29_4 = var_4.PtToShow(var_29_2)
		local var_29_5 = "/<color=#b7b7b7>"

		CityRebuildData = var_6

		var_2(var_29_3, var_29_4 .. var_29_5 .. var_6.PtToShow(var_28_4) .. "</color>")

		if not arg_28_0.canChangeNextLevel then
			arg_28_0.canChangeNextLevel = var_29_1 >= var_28_25

			if arg_28_0.canChangeNextLevel and var_28_27 then
				setActive = var_2

				var_2(arg_28_0.nextLevelBtn, true)
			end
		end

		local var_29_11

		if var_29_2 == var_28_4 and var_29_1 >= var_28_25 then
			local var_29_6 = arg_28_0.model
			local var_29_7 = arg_28_0.anim
			local var_29_8 = arg_28_0._ship
			local var_29_9 = arg_28_0.model2
			local var_29_10 = arg_28_0.anim2

			var_29_11 = arg_28_0._ship2

			if arg_28_0.aliveEnemy == 2 then
				var_29_6 = arg_28_0.model2
				var_29_7 = arg_28_0.anim2
				var_29_8 = arg_28_0._ship2
				var_29_9 = arg_28_0.model
				var_29_10 = arg_28_0.anim
				var_29_11 = arg_28_0._ship
			end

			arg_28_0.aliveEnemy = arg_28_0.aliveEnemy == 1 and 2 or 1

			local var_29_12 = arg_28_0

			var_8.DeadSpine(var_29_12, var_29_6, var_29_7, var_29_8)

			local var_29_13 = arg_28_0

			var_8.WalkSpine(var_29_13, var_29_9, var_29_10, var_29_11)
		end

		if arg_28_0.effectWaitingTime == 0 then
			arg_28_0.isPlayingEffect = true

			local var_29_14 = arg_28_0

			math = var_3
			var_29_14.effectWaitingTime = var_3.random(3)
			ipairs = var_29_14

			for iter_29_0, iter_29_1 in var_29_14(var_28_37) do
				setActive = var_29_11

				var_29_11(iter_29_1, true)
			end
		end

		if arg_28_0.effectPlayingTime == 0 then
			arg_28_0.isPlayingEffect = false

			local var_29_15 = arg_28_0

			var_29_15.effectPlayingTime = 2
			ipairs = var_29_15

			for iter_29_2, iter_29_3 in var_29_15(var_28_37) do
				setActive = var_29_11

				var_29_11(iter_29_3, false)
			end
		end

		if arg_28_0.isPlayingEffect then
			arg_28_0.effectPlayingTime = arg_28_0.effectPlayingTime - 1
		else
			arg_28_0.effectWaitingTime = arg_28_0.effectWaitingTime - 1
		end

		local var_29_16 = arg_28_0.damageAni

		var_2.Play(var_29_16, "Anim_CityRebuildGameUI_damage")

		return
	end)

	return
end

function var_0_1.GetParam(arg_30_0, arg_30_1)
	pg = var_1_10002

	local var_30_0

	if var_1_10002.gameset["ninja_Param" .. arg_30_1].key_value == 0 or not var_2.key_value then
		tonumber = var_30_0
		var_30_0 = var_30_0(var_2.description)
	end

	return var_30_0
end

function var_0_1.Summary(arg_31_0, arg_31_1, arg_31_2)
	tostring = var_1_10003

	local var_31_0 = #var_1_10003(arg_31_2)
	local var_31_1 = 1
	local var_31_2 = 1
	local var_31_3

	if var_31_0 < 3 then
		var_31_1 = 1
		var_31_3 = 1
	elseif var_31_0 < 5 then
		var_31_1 = 1
		var_31_3 = 2
	elseif var_31_0 < 7 then
		var_31_1 = 2
		var_31_3 = 3
	elseif var_31_0 < 9 then
		var_31_1 = 2
		var_31_3 = 4
	else
		var_31_1 = 3
		var_31_3 = 5
	end

	setActive = var_6

	local var_31_4 = arg_31_0._tf

	var_6(var_7.Find(var_31_4, "resultEffect/" .. var_31_1), true)
	arg_31_0:StartTimers(function()
		setActive = var_2_10000

		local var_32_0 = arg_31_0._tf

		var_2_10000(var_1.Find(var_32_0, "resultEffect/" .. var_31_1), false)
		arg_31_1()

		return
	end, var_31_3, "result")

	return
end

function var_0_1.StartTimer(arg_33_0, arg_33_1)
	Timer = var_1_10002
	arg_33_0.timer = var_1_10002.New(arg_33_1, 1, -1)

	local var_33_0 = arg_33_0.timer

	var_2.Start(var_33_0)

	return
end

function var_0_1.RemoveTimer(arg_34_0)
	if arg_34_0.timer then
		local var_34_0 = arg_34_0.timer

		var_1.Stop(var_34_0)

		arg_34_0.timer = nil
	end

	return
end

function var_0_1.StartTimers(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	if not arg_35_0.timerList then
		arg_35_0.timerList = {}
	end

	Timer = var_4

	local var_35_0 = var_4.New(arg_35_1, arg_35_2, 1)

	var_4.Start(var_35_0)

	arg_35_0.timerList[arg_35_3] = var_4

	return
end

function var_0_1.RemoveAllTimers(arg_36_0)
	if arg_36_0.timerList then
		pairs = var_1

		for iter_36_0, iter_36_1 in var_1(arg_36_0.timerList) do
			iter_36_1:Stop()
		end

		arg_36_0.timerList = {}
	end

	return
end

function var_0_1.willExit(arg_37_0)
	arg_37_0:ClearSpine()
	arg_37_0:RemoveTimer()
	arg_37_0:RemoveAllTimers()

	LeanTween = var_1

	var_1.cancel(arg_37_0.bg1)

	LeanTween = var_1

	var_1.cancel(arg_37_0.bg2)

	LeanTween = var_1

	var_1.cancel(arg_37_0.bg3)

	pg = var_1

	local var_37_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_37_0, arg_37_0._tf)

	return
end

return var_0_1
