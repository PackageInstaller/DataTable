class = var_0_10000

local var_0_0 = "ChallengePreCombatLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ChapterPreCombatUI"
end

function var_0_1.ResUISettings(arg_2_0)
	return true
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0.rtAdapt

	arg_3_0._startBtn = var_1.Find(var_3_0, "right/start")

	local var_3_1 = arg_3_0.rtAdapt

	arg_3_0._popup = var_1.Find(var_3_1, "right/popup")
	setActive = var_1

	var_1(arg_3_0._popup, false)

	local var_3_2 = arg_3_0.rtAdapt

	arg_3_0._backBtn = var_1.Find(var_3_2, "top/back_btn")

	local var_3_3 = arg_3_0.rtAdapt
	local var_3_4 = var_1.Find(var_3_3, "middle")

	arg_3_0._mainGS = var_1.Find(var_3_4, "gear_score/main/Text")
	arg_3_0._vanguardGS = var_1:Find("gear_score/vanguard/Text")
	setText = var_2

	var_2(arg_3_0._mainGS, 0)

	setText = var_2

	var_2(arg_3_0._vanguardGS, 0)

	local var_3_5 = {}

	TeamType = var_3
	var_3_5[var_3.Vanguard] = {}
	TeamType = var_3
	var_3_5[var_3.Main] = {}
	arg_3_0._gridTFs = var_3_5
	arg_3_0._gridFrame = var_1:Find("mask/GridFrame")

	for iter_3_0 = 1, 3 do
		local var_3_6 = arg_3_0._gridTFs

		TeamType = var_1_10007

		local var_3_7 = var_3_6[var_1_10007.Vanguard]
		local var_3_8 = arg_3_0._gridFrame

		var_3_7[iter_3_0] = var_1_10007.Find(var_3_8, "vanguard_" .. iter_3_0)

		local var_3_9 = arg_3_0._gridTFs

		TeamType = var_1_10007

		local var_3_10 = var_3_9[var_1_10007.Main]
		local var_3_11 = arg_3_0._gridFrame

		var_3_10[iter_3_0] = var_1_10007.Find(var_3_11, "main_" .. iter_3_0)
	end

	arg_3_0._heroContainer = var_1:Find("HeroContainer")
	arg_3_0._strategy = var_1:Find("strategy")
	setActive = var_2

	var_2(arg_3_0._strategy, false)

	arg_3_0._formationList = var_1:Find("formation_list")
	setActive = var_2

	var_2(arg_3_0._formationList, false)

	local var_3_12 = arg_3_0.rtAdapt

	arg_3_0._goals = var_2.Find(var_3_12, "right/infomation/goal")
	arg_3_0._heroInfo = arg_3_0:getTpl("heroInfo")
	arg_3_0._starTpl = arg_3_0:getTpl("star_tpl")
	BaseFormation = var_2
	arg_3_0._formationLogic = var_2.New(arg_3_0._tf, arg_3_0._heroContainer, arg_3_0._heroInfo, arg_3_0._gridTFs)

	local var_3_13 = arg_3_0.rtAdapt

	arg_3_0._middle = var_2.Find(var_3_13, "middle")

	local var_3_14 = arg_3_0.rtAdapt

	arg_3_0._right = var_2.Find(var_3_14, "right")

	local var_3_15 = arg_3_0.rtAdapt

	arg_3_0._fleet = var_2.Find(var_3_15, "middle/fleet")
	setText = var_2

	local var_3_16 = arg_3_0.rtAdapt
	local var_3_17 = var_3.Find(var_3_16, "middle/gear_score/vanguard/line/Image/Text1")

	i18n = var_3_16

	var_2(var_3_17, var_3_16("pre_combat_vanguard"))

	setText = var_2

	local var_3_18 = arg_3_0.rtAdapt
	local var_3_19 = var_3.Find(var_3_18, "middle/gear_score/main/line/Image/Text1")

	i18n = var_3_18

	var_2(var_3_19, var_3_18("pre_combat_main"))

	setText = var_2

	local var_3_20 = arg_3_0._fleet
	local var_3_21 = var_3.Find(var_3_20, "title_bg/Text")

	i18n = var_3_20

	var_2(var_3_21, var_3_20("pre_combat_team"))

	local var_3_22 = arg_3_0._fleet

	arg_3_0._ship_tpl = var_2.Find(var_3_22, "shiptpl")

	local var_3_23 = arg_3_0._fleet

	arg_3_0._empty_tpl = var_2.Find(var_3_23, "emptytpl")
	setActive = var_2

	var_2(arg_3_0._ship_tpl, false)

	setActive = var_2

	var_2(arg_3_0._empty_tpl, false)

	local var_3_24 = arg_3_0.rtAdapt

	arg_3_0._autoToggle = var_2.Find(var_3_24, "middle/auto_toggle")

	local var_3_25 = arg_3_0.rtAdapt

	arg_3_0._autoSubToggle = var_2.Find(var_3_25, "middle/sub_toggle_container/sub_toggle")

	local var_3_26 = arg_3_0.rtAdapt

	arg_3_0.topPanel = var_2.Find(var_3_26, "top")

	local var_3_27 = arg_3_0._tf

	arg_3_0.strategyInfo = var_2.Find(var_3_27, "strategy_info")
	setActive = var_2

	var_2(arg_3_0.strategyInfo, false)

	setAnchoredPosition = var_2

	var_2(arg_3_0._middle, {
		x = -840
	})

	setAnchoredPosition = var_2

	var_2(arg_3_0._right, {
		x = 470
	})
	arg_3_0:Register()

	return
end

function var_0_1.uiStartAnimating(arg_4_0)
	setAnchoredPosition = var_1_10001

	var_1_10001(arg_4_0.topPanel, {
		y = 100
	})

	local var_4_0 = 0
	local var_4_1 = 0.3

	shiftPanel = var_3

	var_3(arg_4_0._middle, 0, nil, var_4_1, var_4_0, true, true)

	shiftPanel = var_3

	var_3(arg_4_0._right, 0, nil, var_4_1, var_4_0, true, true, nil)

	shiftPanel = var_3

	var_3(arg_4_0.topPanel, nil, 0, var_4_1, var_4_0, true, true, nil, nil)

	return
end

function var_0_1.uiExitAnimating(arg_5_0)
	local var_5_0 = 0
	local var_5_1 = 0.3

	shiftPanel = var_1_10003

	var_1_10003(arg_5_0._middle, -840, nil, var_5_1, var_5_0, true, true)

	shiftPanel = var_1_10003

	var_1_10003(arg_5_0._right, 470, nil, var_5_1, var_5_0, true, true)

	shiftPanel = var_1_10003

	var_1_10003(arg_5_0.topPanel, nil, arg_5_0.topPanel.rect.height, var_5_1, var_5_0, true, true, nil, nil)

	return
end

function var_0_1.didEnter(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._backBtn

	local function var_6_2()
		GetOrAddComponent = var_2_10000

		local var_7_0 = arg_6_0._tf

		typeof = var_2_10002
		CanvasGroup = var_2_10003
		var_2_10000(var_7_0, var_2_10002(var_2_10003)).interactable = false

		local var_7_1 = arg_6_0

		var_1.uiExitAnimating(var_7_1)

		LeanTween = var_1

		local var_7_2 = var_1.delayedCall
		local var_7_3 = 0.3

		System = var_2_10003

		var_7_2(var_7_3, var_2_10003.Action(function()
			local var_8_0 = arg_6_0

			var_0.emit(var_8_0, var_0_1.ON_CLOSE)

			return
		end))

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10005)

	onButton = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0._startBtn

	local function var_6_5()
		local var_9_0 = arg_6_0.fleet.ships

		pairs = var_2_10001

		for iter_9_0, iter_9_1 in var_2_10001(var_9_0) do
			ShipStatus = var_2_10006

			local var_9_1

			var_2_10006, var_9_1 = var_2_10006.ShipStatusConflict("inActivity", iter_9_1, {
				inActivity = false
			})
			ShipStatus = var_8

			if var_2_10006 == var_8.STATE_CHANGE_FAIL then
				pg = var_8

				local var_9_2 = var_8.TipsMgr.GetInstance()
				local var_9_3 = var_8.ShowTips

				i18n = var_2_10010

				var_9_3(var_9_2, var_2_10010(var_9_1))

				return
			end
		end

		local var_9_4 = arg_6_0
		local var_9_5 = var_1.emit

		ChallengePreCombatMediator = var_3

		var_9_5(var_9_4, var_3.ON_START)

		return
	end

	SFX_UI_WEIGHANCHOR = var_1_10005

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10005)

	onToggle = var_1_10001

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0._autoToggle

	local function var_6_8(arg_10_0)
		local var_10_0 = arg_6_0
		local var_10_1 = var_1.emit

		ChallengePreCombatMediator = var_2_10003

		var_10_1(var_10_0, var_2_10003.ON_AUTO, {
			isOn = not arg_10_0,
			toggle = arg_6_0._autoToggle
		})

		if arg_10_0 and arg_6_0.subUseable == true then
			setActive = var_10_1

			var_10_1(arg_6_0._autoSubToggle, true)

			onToggle = var_10_1

			local var_10_2 = arg_6_0
			local var_10_3 = arg_6_0._autoSubToggle

			local function var_10_4(arg_11_0)
				local var_11_0 = arg_6_0
				local var_11_1 = var_1.emit

				ChallengePreCombatMediator = var_3_10003

				var_11_1(var_11_0, var_3_10003.ON_SUB_AUTO, {
					isOn = not arg_11_0,
					toggle = arg_6_0._autoSubToggle
				})

				return
			end

			SFX_PANEL = var_5
			SFX_PANEL = var_2_10006

			var_10_1(var_10_2, var_10_3, var_10_4, var_5, var_2_10006)

			triggerToggle = var_10_1

			local var_10_5 = arg_6_0._autoSubToggle

			ys = var_10_3

			var_10_1(var_10_5, var_10_3.Battle.BattleState.IsAutoSubActive())
		else
			setActive = var_10_1

			var_10_1(arg_6_0._autoSubToggle, false)
		end

		return
	end

	SFX_PANEL = var_1_10005
	SFX_PANEL = var_1_10006

	var_1_10001(var_6_6, var_6_7, var_6_8, var_1_10005, var_1_10006)

	pg = var_1_10001

	local var_6_9 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_6_9, arg_6_0._tf)

	setParent = var_1

	var_1(arg_6_0.strategyInfo, arg_6_0._tf.parent)

	triggerToggle = var_1

	local var_6_10 = arg_6_0._autoToggle

	ys = var_3

	var_1(var_6_10, var_3.Battle.BattleState.IsAutoBotActive())

	setAnchoredPosition = var_1

	var_1(arg_6_0.topPanel, {
		y = arg_6_0.topPanel.rect.height
	})

	onNextTick = var_1

	var_1(function()
		local var_12_0 = arg_6_0

		var_0.uiStartAnimating(var_12_0)

		return
	end)

	return
end

function var_0_1.Register(arg_13_0)
	local var_13_0 = arg_13_0._formationLogic

	var_1.AddHeroInfoModify(var_13_0, function(arg_14_0, arg_14_1)
		setAnchoredPosition = var_2_10002

		var_2_10002(arg_14_0, {
			x = 0,
			y = 0
		})

		SetActive = var_2_10002

		var_2_10002(arg_14_0, true)

		arg_14_0.name = "info"

		local var_14_0 = arg_14_0:Find("info")
		local var_14_1 = var_2.Find(var_14_0, "stars")
		local var_14_2 = arg_14_1
		local var_14_3 = arg_14_1.getEnergy(var_14_2)

		Ship = var_14_2

		local var_14_4 = var_14_3 <= var_14_2.ENERGY_MID
		local var_14_5 = var_2
		local var_14_6 = var_2.Find(var_14_5, "energy")

		if var_14_4 then
			local var_14_7

			var_14_5, var_14_7 = arg_14_1:getEnergyPrint()
			GetSpriteFromAtlas = var_2_10008

			if not var_2_10008("energy", var_14_5) then
				warning = var_9

				var_9("找不到疲劳")
			end

			setImageSprite = var_9

			var_9(var_14_6, var_8)
		end

		setActive = var_14_5

		var_14_5(var_14_6, var_14_4)

		local var_14_8 = arg_14_1:getStar()

		for iter_14_0 = 1, var_14_8 do
			cloneTplTo = var_2_10011

			var_2_10011(arg_13_0._starTpl, var_14_1)
		end

		GetSpriteFromAtlas = var_7

		local var_14_9 = "shiptype"

		shipType2print = var_9

		if not var_7(var_14_9, var_9(arg_14_1:getShipType())) then
			warning = var_14_9

			var_14_9("找不到船形, shipConfigId: " .. arg_14_1.configId)
		end

		setImageSprite = var_14_9

		var_14_9(var_2:Find("type"), var_7, true)

		setText = var_14_9

		var_14_9(var_2:Find("frame/lv_contain/lv"), arg_14_1.level)

		local var_14_10 = var_2:Find("blood")
		local var_14_11 = var_8.Find(var_14_10, "fillarea/green")
		local var_14_12 = var_8
		local var_14_13 = var_8.Find(var_14_12, "fillarea/red")

		setActive = var_14_12

		local var_14_14 = var_14_11
		local var_14_15 = arg_14_1.hpRant

		ChapterConst = var_2_10014

		var_14_12(var_14_14, var_2_10014.HpGreen <= var_14_15)

		setActive = var_14_12

		local var_14_16 = var_14_13
		local var_14_17 = arg_14_1.hpRant

		ChapterConst = var_14

		var_14_12(var_14_16, var_14_17 < var_14.HpGreen)

		local var_14_18 = arg_14_1.hpRant

		ChapterConst = var_14_16

		local var_14_19 = var_14_18 >= var_14_16.HpGreen and var_14_11 or var_14_13

		var_11.GetComponent(var_14_19, "Image").fillAmount = arg_14_1.hpRant * 0.0001

		local var_14_20 = var_2
		local var_14_21 = var_2.Find(var_14_20, "expbuff")

		setActive = var_14_20

		var_14_20(var_14_21, false)

		return
	end)

	local var_13_1 = arg_13_0._formationLogic

	var_1.AddShiftOnly(var_13_1, function(arg_15_0)
		local var_15_0 = arg_13_0

		var_1.updateView(var_15_0, false)

		return
	end)

	local var_13_2 = arg_13_0._formationLogic

	var_1.AddCheckRemove(var_13_2, function(arg_16_0, arg_16_1)
		arg_16_0()

		return
	end)

	return
end

function var_0_1.onBackPressed(arg_17_0)
	local var_17_1

	if arg_17_0.strategyPanel and arg_17_0.strategyPanel._go then
		isActive = var_17_1

		if var_17_1(arg_17_0.strategyPanel._go) then
			pg = var_17_1

			local var_17_0 = var_17_1.CriMgr.GetInstance()

			var_17_1 = var_17_1.PlaySoundEffect_V3
			SFX_CANCEL = var_1_10003

			var_17_1(var_17_0, var_1_10003)

			goto label_17_0
		end
	end

	pg = var_17_1

	do
		local var_17_2 = var_17_1.CriMgr.GetInstance()
		local var_17_3 = var_1.PlaySoundEffect_V3

		SFX_CANCEL = var_1_10003

		var_17_3(var_17_2, var_1_10003)

		triggerButton = var_17_3

		var_17_3(arg_17_0._backBtn)
	end

	::label_17_0::

	return
end

function var_0_1.setPlayerInfo(arg_18_0, arg_18_1)
	return
end

function var_0_1.updateChallenge(arg_19_0, arg_19_1)
	arg_19_0.challenge = arg_19_1
	arg_19_0.fleet = arg_19_1:getRegularFleet()

	local var_19_0 = arg_19_0.fleet.ships
	local var_19_1 = arg_19_0._formationLogic

	var_3.SetFleetVO(var_19_1, arg_19_0.fleet)

	local var_19_2 = arg_19_0._formationLogic

	var_3.SetShipVOs(var_19_2, var_19_0)
	arg_19_0:updateView(true)

	return
end

function var_0_1.setSubFlag(arg_20_0, arg_20_1)
	arg_20_0.subUseable = arg_20_1 or false

	return
end

function var_0_1.updateView(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._formationLogic
	local var_21_1 = var_2.ResetGrid

	TeamType = var_1_10004

	var_21_1(var_21_0, var_1_10004.Vanguard)

	local var_21_2 = arg_21_0._formationLogic
	local var_21_3 = var_2.ResetGrid

	TeamType = var_4

	var_21_3(var_21_2, var_4.Main)

	SetActive = var_21_3

	local var_21_4 = arg_21_0._gridTFs

	TeamType = var_4

	local var_21_5 = var_21_4[var_4.Main][1]

	var_21_3(var_3.Find(var_21_5, "flag"), true)

	if arg_21_1 then
		arg_21_0:updateStageView()

		local var_21_6 = arg_21_0._formationLogic

		var_2.LoadAllCharacter(var_21_6)
	else
		local var_21_7 = arg_21_0._formationLogic

		var_2.SetAllCharacterPos(var_21_7)
	end

	arg_21_0:updateBattleFleetView()
	arg_21_0:displayFleetInfo()

	return
end

function var_0_1.updateStageView(arg_22_0)
	local function var_22_0(arg_23_0, arg_23_1)
		type = var_2_10002

		local var_23_0

		if var_2_10002(arg_23_0) == "table" then
			setActive = var_23_0

			var_23_0(arg_23_1, true)

			i18n = var_23_0
			PreCombatLayer = var_3
			var_23_0 = var_23_0(var_3.ObjectiveList[arg_23_0[1]], arg_23_0[2])
			setWidgetText = var_3

			var_3(arg_23_1, var_23_0)
		else
			setActive = var_23_0

			var_23_0(arg_23_1, false)
		end

		return
	end

	local var_22_1 = {}
	local var_22_2 = arg_22_0._goals

	var_22_1[1] = var_3.Find(var_22_2, "goal_tpl")

	local var_22_3 = arg_22_0._goals

	var_22_1[2] = var_3.Find(var_22_3, "goal_sink")

	local var_22_4 = arg_22_0._goals

	var_22_1[3] = var_3.Find(var_22_4, "goal_time")

	local var_22_5 = {
		{
			1
		},
		false,
		false
	}
	local var_22_6 = 1

	ipairs = var_5

	for iter_22_0, iter_22_1 in var_5(var_22_5) do
		type = var_1_10010

		if var_1_10010(iter_22_1) ~= "string" then
			var_22_0(iter_22_1, var_22_1[var_22_6])

			var_22_6 = var_22_6 + 1
		end
	end

	return
end

function var_0_1.updateBattleFleetView(arg_24_0)
	local function var_24_0(arg_25_0, arg_25_1)
		removeAllChildren = var_2_10002

		var_2_10002(arg_25_0)

		for iter_25_0 = 1, 3 do
			if arg_25_1[iter_25_0] then
				cloneTplTo = var_6

				local var_25_0 = var_6(arg_24_0._ship_tpl, arg_25_0)

				updateShip = var_7

				var_7(var_25_0, arg_25_1[iter_25_0])

				local var_25_1 = arg_25_1[iter_25_0].hpRant
				local var_25_2 = var_25_0:Find("blood")
				local var_25_3 = var_25_0:Find("blood/fillarea/green")
				local var_25_4 = var_25_0
				local var_25_5 = var_25_0.Find(var_25_4, "blood/fillarea/red")

				setActive = var_25_4

				local var_25_6 = var_25_3

				ChapterConst = var_2_10013
				var_2_10013 = var_2_10013.HpGreen <= var_25_1

				var_25_4(var_25_6, var_2_10013)

				setActive = var_25_4

				local var_25_7 = var_25_5

				ChapterConst = var_2_10013
				var_2_10013 = var_25_1 < var_2_10013.HpGreen

				var_25_4(var_25_7, var_2_10013)

				ChapterConst = var_25_4
				var_2_10013 = var_25_1 >= var_25_4.HpGreen and var_25_3 or var_25_5
				var_11.GetComponent(var_2_10013, "Image").fillAmount = var_25_1 * 0.0001
			end
		end

		return
	end

	local var_24_1 = arg_24_0.challenge
	local var_24_2 = var_2.getRegularFleet(var_24_1)
	local var_24_3 = var_24_0
	local var_24_4 = arg_24_0._fleet
	local var_24_5 = var_4.Find(var_24_4, "main")
	local var_24_6 = var_24_2
	local var_24_7 = var_24_2.getShipsByTeam

	TeamType = var_1_10007

	var_24_3(var_24_5, var_24_7(var_24_6, var_1_10007.Main, true))

	local var_24_8 = var_24_0
	local var_24_9 = arg_24_0._fleet
	local var_24_10 = var_4.Find(var_24_9, "vanguard")
	local var_24_11 = var_24_2
	local var_24_12 = var_24_2.getShipsByTeam

	TeamType = var_7

	var_24_8(var_24_10, var_24_12(var_24_11, var_7.Vanguard, true))

	return
end

function var_0_1.displayFleetInfo(arg_26_0)
	local var_26_0 = arg_26_0.challenge
	local var_26_1 = var_1.getRegularFleet(var_26_0)
	local var_26_2 = var_1.getCommanders(var_26_1)

	_ = var_26_1

	local var_26_3 = var_26_1.reduce
	local var_26_4 = var_1
	local var_26_5 = var_1.getShipsByTeam

	TeamType = var_1_10006

	local var_26_6 = var_26_3(var_26_5(var_26_4, var_1_10006.Vanguard, false), 0, function(arg_27_0, arg_27_1)
		return arg_27_0 + arg_27_1:getShipCombatPower(var_26_2)
	end)

	_ = var_4

	local var_26_7 = var_4.reduce
	local var_26_8 = var_1
	local var_26_9 = var_1.getShipsByTeam

	TeamType = var_7

	local var_26_10 = var_26_7(var_26_9(var_26_8, var_7.Main, false), 0, function(arg_28_0, arg_28_1)
		return arg_28_0 + arg_28_1:getShipCombatPower(var_26_2)
	end)

	FormationUI = var_5

	var_5.tweenNumText(arg_26_0._vanguardGS, var_26_6)

	FormationUI = var_5

	var_5.tweenNumText(arg_26_0._mainGS, var_26_10)

	return
end

function var_0_1.willExit(arg_29_0)
	setParent = var_1_10001

	var_1_10001(arg_29_0.strategyInfo, arg_29_0._tf)

	local var_29_0 = arg_29_0._formationLogic

	var_1.Destroy(var_29_0)

	arg_29_0._formationLogic = nil
	pg = var_1

	local var_29_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_29_1, arg_29_0._tf)

	return
end

return var_0_1
