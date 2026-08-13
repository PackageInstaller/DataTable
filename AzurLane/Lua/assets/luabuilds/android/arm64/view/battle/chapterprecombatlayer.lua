class = var_0_10000

local var_0_0 = "ChapterPreCombatLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

import = var_0_10001

local var_0_2 = var_0_10001("..ship.FormationUI")
local var_0_3 = {
	[99] = true
}

var_0_1.optionsPath = {
	"adapt/top/option"
}

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

	local var_3_2 = arg_3_0.rtAdapt

	arg_3_0._costText = var_1.Find(var_3_2, "right/popup/Text")

	local var_3_3 = arg_3_0.rtAdapt

	arg_3_0._costTip = var_1.Find(var_3_3, "right/popup/tip")

	local var_3_4 = arg_3_0.rtAdapt

	arg_3_0._extraCostBuffIcon = var_1.Find(var_3_4, "right/operation_buff_icon")

	local var_3_5 = arg_3_0.rtAdapt

	arg_3_0._backBtn = var_1.Find(var_3_5, "top/back_btn")

	local var_3_6 = arg_3_0._tf

	arg_3_0._moveLayer = var_1.Find(var_3_6, "moveLayer")

	local var_3_7 = arg_3_0.rtAdapt
	local var_3_8 = var_1.Find(var_3_7, "middle")

	arg_3_0._mainGS = var_1.Find(var_3_8, "gear_score/main/Text")
	arg_3_0._vanguardGS = var_1:Find("gear_score/vanguard/Text")
	setText = var_2

	var_2(arg_3_0._mainGS, 0)

	setText = var_2

	var_2(arg_3_0._vanguardGS, 0)

	arg_3_0._gridTFs = {
		vanguard = {},
		main = {}
	}
	arg_3_0._gridFrame = var_1:Find("mask/GridFrame")

	for iter_3_0 = 1, 3 do
		local var_3_9 = arg_3_0._gridTFs

		TeamType = var_1_10007

		local var_3_10 = var_3_9[var_1_10007.Vanguard]
		local var_3_11 = arg_3_0._gridFrame

		var_3_10[iter_3_0] = var_1_10007.Find(var_3_11, "vanguard_" .. iter_3_0)

		local var_3_12 = arg_3_0._gridTFs

		TeamType = var_1_10007

		local var_3_13 = var_3_12[var_1_10007.Main]
		local var_3_14 = arg_3_0._gridFrame

		var_3_13[iter_3_0] = var_1_10007.Find(var_3_14, "main_" .. iter_3_0)
	end

	arg_3_0._heroContainer = var_1:Find("HeroContainer")
	arg_3_0._strategy = var_1:Find("strategy")
	setActive = var_2

	var_2(arg_3_0._strategy, true)

	local var_3_15 = arg_3_0.rtAdapt

	arg_3_0._spoilsContainer = var_2.Find(var_3_15, "right/infomation/spoils/items/items_container")

	local var_3_16 = arg_3_0.rtAdapt

	arg_3_0._goals = var_2.Find(var_3_16, "right/infomation/goal")
	arg_3_0._item = arg_3_0:getTpl("right/infomation/spoils/items/item_tpl", arg_3_0.rtAdapt)
	arg_3_0._heroInfo = arg_3_0:getTpl("heroInfo")
	arg_3_0._starTpl = arg_3_0:getTpl("star_tpl")

	local var_3_17 = arg_3_0.rtAdapt

	arg_3_0._middle = var_2.Find(var_3_17, "middle")

	local var_3_18 = arg_3_0.rtAdapt

	arg_3_0._right = var_2.Find(var_3_18, "right")
	BaseFormation = var_2
	arg_3_0._formationLogic = var_2.New(arg_3_0._tf, arg_3_0._heroContainer, arg_3_0._heroInfo, arg_3_0._gridTFs)

	local var_3_19 = {
		Shift = function(arg_4_0, arg_4_1, arg_4_2)
			return
		end
	}

	setmetatable = var_3

	var_3(var_3_19, arg_3_0._formationLogic)

	setText = var_3

	local var_3_20 = arg_3_0.rtAdapt
	local var_3_21 = var_5.Find(var_3_20, "middle/gear_score/vanguard/line/Image/Text1")

	i18n = var_6

	var_3(var_3_21, var_6("pre_combat_vanguard"))

	setText = var_3

	local var_3_22 = arg_3_0.rtAdapt
	local var_3_23 = var_5.Find(var_3_22, "middle/gear_score/main/line/Image/Text1")

	i18n = var_6

	var_3(var_3_23, var_6("pre_combat_main"))

	local var_3_24 = arg_3_0.rtAdapt

	arg_3_0._fleet = var_3.Find(var_3_24, "middle/fleet")
	setText = var_3

	local var_3_25 = arg_3_0._fleet
	local var_3_26 = var_5.Find(var_3_25, "title_bg/Text")

	i18n = var_6

	var_3(var_3_26, var_6("pre_combat_team"))

	local var_3_27 = arg_3_0._fleet

	arg_3_0._ship_tpl = var_3.Find(var_3_27, "shiptpl")

	local var_3_28 = arg_3_0._fleet

	arg_3_0._empty_tpl = var_3.Find(var_3_28, "emptytpl")
	setActive = var_3

	var_3(arg_3_0._ship_tpl, false)

	setActive = var_3

	var_3(arg_3_0._empty_tpl, false)

	local var_3_29 = arg_3_0.rtAdapt

	arg_3_0._autoToggle = var_3.Find(var_3_29, "middle/auto_toggle")

	local var_3_30 = arg_3_0.rtAdapt

	arg_3_0._autoSubToggle = var_3.Find(var_3_30, "middle/sub_toggle_container/sub_toggle")

	local var_3_31 = arg_3_0.rtAdapt

	arg_3_0.topPanel = var_3.Find(var_3_31, "top")

	local var_3_32 = arg_3_0._tf

	arg_3_0.strategyInfo = var_3.Find(var_3_32, "strategy_info")
	setActive = var_3

	var_3(arg_3_0.strategyInfo, false)

	local var_3_33 = arg_3_0._extraCostBuffIcon

	arg_3_0._operaionBuffTips = var_3.Find(var_3_33, "popup")
	setAnchoredPosition = var_3

	var_3(arg_3_0._middle, {
		x = -840
	})

	setAnchoredPosition = var_3

	var_3(arg_3_0._right, {
		x = 470
	})
	arg_3_0:Register()

	return
end

function var_0_1.uiStartAnimating(arg_5_0)
	setAnchoredPosition = var_1_10001

	var_1_10001(arg_5_0.topPanel, {
		y = 100
	})

	local var_5_0 = 0
	local var_5_1 = 0.3

	shiftPanel = var_3

	var_3(arg_5_0._middle, 0, nil, var_5_1, var_5_0, true, true)

	shiftPanel = var_3

	var_3(arg_5_0._right, 0, nil, var_5_1, var_5_0, true, true, nil)

	shiftPanel = var_3

	var_3(arg_5_0.topPanel, nil, 0, var_5_1, var_5_0, true, true, nil, nil)

	return
end

function var_0_1.uiExitAnimating(arg_6_0)
	local var_6_0 = 0
	local var_6_1 = 0.3

	shiftPanel = var_1_10003

	var_1_10003(arg_6_0._middle, -840, nil, var_6_1, var_6_0, true, true)

	shiftPanel = var_1_10003

	var_1_10003(arg_6_0._right, 470, nil, var_6_1, var_6_0, true, true)

	shiftPanel = var_1_10003

	var_1_10003(arg_6_0.topPanel, nil, arg_6_0.topPanel.rect.height, var_6_1, var_6_0, true, true, nil, nil)

	return
end

function var_0_1.didEnter(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0._backBtn

	local function var_7_2()
		GetOrAddComponent = var_2_10000

		local var_8_0 = arg_7_0._tf

		typeof = var_2_10003
		CanvasGroup = var_2_10005
		var_2_10000(var_8_0, var_2_10003(var_2_10005)).interactable = false

		local var_8_1 = arg_7_0

		var_1.uiExitAnimating(var_8_1)

		LeanTween = var_1

		local var_8_2 = var_1.delayedCall
		local var_8_3 = 0.3

		System = var_2_10004

		var_8_2(var_8_3, var_2_10004.Action(function()
			local var_9_0 = arg_7_0

			var_0.emit(var_9_0, var_0_1.ON_CLOSE)

			return
		end))

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10006)

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0._startBtn

	local function var_7_5()
		local var_10_0 = arg_7_0
		local var_10_1 = var_0.emit

		ChapterPreCombatMediator = var_2_10003

		var_10_1(var_10_0, var_2_10003.ON_START)

		return
	end

	SFX_UI_WEIGHANCHOR = var_1_10006

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10006)

	onToggle = var_1_10001

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0._autoToggle

	local function var_7_8(arg_11_0)
		local var_11_0 = arg_7_0
		local var_11_1 = var_1.emit

		ChapterPreCombatMediator = var_2_10004

		var_11_1(var_11_0, var_2_10004.ON_AUTO, {
			isOn = not arg_11_0,
			toggle = arg_7_0._autoToggle
		})

		if arg_11_0 and arg_7_0.subUseable == true then
			setActive = var_11_1

			var_11_1(arg_7_0._autoSubToggle, true)

			onToggle = var_11_1

			local var_11_2 = arg_7_0
			local var_11_3 = arg_7_0._autoSubToggle

			local function var_11_4(arg_12_0)
				local var_12_0 = arg_7_0
				local var_12_1 = var_1.emit

				ChapterPreCombatMediator = var_3_10004

				var_12_1(var_12_0, var_3_10004.ON_SUB_AUTO, {
					isOn = not arg_12_0,
					toggle = arg_7_0._autoSubToggle
				})

				return
			end

			SFX_PANEL = var_6
			SFX_PANEL = var_2_10007

			var_11_1(var_11_2, var_11_3, var_11_4, var_6, var_2_10007)

			triggerToggle = var_11_1

			local var_11_5 = arg_7_0._autoSubToggle

			ys = var_11_3

			var_11_1(var_11_5, var_11_3.Battle.BattleState.IsAutoSubActive())
		else
			setActive = var_11_1

			var_11_1(arg_7_0._autoSubToggle, false)
		end

		return
	end

	SFX_PANEL = var_1_10006
	SFX_PANEL = var_1_10007

	var_1_10001(var_7_6, var_7_7, var_7_8, var_1_10006, var_1_10007)

	pg = var_1_10001

	local var_7_9 = var_1_10001.UIMgr.GetInstance()

	var_1.OverlayPanel(var_7_9, arg_7_0._tf)

	onNextTick = var_1

	var_1(function()
		if arg_7_0.exited then
			return
		end

		triggerToggle = var_0

		local var_13_0 = arg_7_0._autoToggle

		ys = var_2_10003

		var_0(var_13_0, var_2_10003.Battle.BattleState.IsAutoBotActive())

		return
	end)

	setAnchoredPosition = var_1

	var_1(arg_7_0.topPanel, {
		y = arg_7_0.topPanel.rect.height
	})

	onNextTick = var_1

	var_1(function()
		local var_14_0 = arg_7_0

		var_0.uiStartAnimating(var_14_0)

		return
	end)

	onButton = var_1

	local var_7_10 = arg_7_0
	local var_7_11 = arg_7_0.rtAdapt
	local var_7_12 = var_4.Find(var_7_11, "middle/gear_score/vanguard/SonarTip")

	local function var_7_13()
		pg = var_2_10000

		local var_15_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_15_1 = var_0.ShowMsgBox
		local var_15_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_15_2.type = var_2_10004
		pg = var_2_10004
		var_15_2.helps = var_2_10004.gametip.fleet_antisub_range_tip.tip

		var_15_1(var_15_0, var_15_2)

		return
	end

	SFX_PANEL = var_7_11

	var_1(var_7_10, var_7_12, var_7_13, var_7_11)

	onButton = var_1

	var_1(arg_7_0, arg_7_0._costTip, function()
		local var_16_0 = arg_7_0.chapter.fleet
		local var_16_1 = arg_7_0.chapter
		local var_16_2 = var_1.getStageId(var_16_1, var_16_0.line.row, var_16_0.line.column)
		local var_16_3 = arg_7_0.chapter
		local var_16_4, var_16_5, var_16_6 = var_2.isOverFleetCost(var_16_3, var_16_0, var_16_2)

		pg = var_5

		local var_16_7 = var_5.MsgboxMgr.GetInstance()
		local var_16_8 = var_5.ShowMsgBox
		local var_16_9 = {
			hideNo = true
		}

		i18n = var_2_10009
		var_16_9.content = var_2_10009("use_oil_limit_help", var_16_6, var_16_5)

		var_16_8(var_16_7, var_16_9)

		return
	end)

	return
end

function var_0_1.Register(arg_17_0)
	local var_17_0 = arg_17_0._formationLogic

	var_1.AddHeroInfoModify(var_17_0, function(arg_18_0, arg_18_1, arg_18_2)
		setAnchoredPosition = var_2_10003

		var_2_10003(arg_18_0, {
			x = 0,
			y = 0
		})

		SetActive = var_2_10003

		var_2_10003(arg_18_0, true)

		arg_18_0.name = "info"

		local var_18_0 = arg_18_0:Find("info")
		local var_18_1 = var_3.Find(var_18_0, "stars")
		local var_18_2 = arg_18_1
		local var_18_3 = arg_18_1.getEnergy(var_18_2)

		Ship = var_18_0

		local var_18_4 = var_18_3 <= var_18_0.ENERGY_MID
		local var_18_5 = var_3:Find("energy")

		if var_18_4 then
			local var_18_6 = arg_18_1
			local var_18_7

			var_18_2, var_18_7 = arg_18_1.getEnergyPrint(var_18_6)
			GetSpriteFromAtlas = var_18_6

			if not var_18_6("energy", var_18_2) then
				warning = var_2_10010

				var_2_10010("找不到疲劳")
			end

			setImageSprite = var_2_10010

			var_2_10010(var_18_5, var_9)
		end

		setActive = var_18_2

		var_18_2(var_18_5, var_18_4)

		local var_18_8 = arg_18_1:getStar()

		for iter_18_0 = 1, var_18_8 do
			cloneTplTo = var_2_10012

			var_2_10012(arg_17_0._starTpl, var_18_1)
		end

		GetSpriteFromAtlas = var_8

		local var_18_9 = "shiptype"

		shipType2print = iter_18_0

		if not var_8(var_18_9, iter_18_0(arg_18_1:getShipType())) then
			warning = var_9

			var_9("找不到船形, shipConfigId: " .. arg_18_1.configId)
		end

		setImageSprite = var_9

		var_9(var_3:Find("type"), var_8, true)

		setText = var_9

		var_9(var_3:Find("frame/lv_contain/lv"), arg_18_1.level)

		local var_18_10 = var_3:Find("blood")
		local var_18_11 = var_9.Find(var_18_10, "fillarea/green")
		local var_18_12 = var_9
		local var_18_13 = var_9.Find(var_18_12, "fillarea/red")

		setActive = var_18_10

		local var_18_14 = var_18_11
		local var_18_15 = arg_18_1.hpRant

		ChapterConst = var_2_10016

		var_18_10(var_18_14, var_2_10016.HpGreen <= var_18_15)

		setActive = var_18_10

		local var_18_16 = var_18_13
		local var_18_17 = arg_18_1.hpRant

		ChapterConst = var_16

		var_18_10(var_18_16, var_18_17 < var_16.HpGreen)

		local var_18_18 = arg_18_1.hpRant

		ChapterConst = var_18_12

		local var_18_19 = var_18_18 >= var_18_12.HpGreen and var_18_11 or var_18_13

		var_12.GetComponent(var_18_19, "Image").fillAmount = arg_18_1.hpRant * 0.0001

		arg_18_2:SetVisible(arg_18_1.hpRant > 0)

		SetActive = var_13

		var_13(arg_18_0, arg_18_1.hpRant > 0)

		getProxy = var_13
		ActivityProxy = var_15

		local var_18_20 = var_13(var_15)
		local var_18_21 = var_13.getBuffShipList(var_18_20)
		local var_18_22 = arg_18_1
		local var_18_23 = var_18_21[arg_18_1.getGroupId(var_18_22)]
		local var_18_24 = var_3:Find("expbuff")

		setActive = var_18_22

		var_18_22(var_18_24, var_18_23 ~= nil)

		if var_18_23 then
			local var_18_25 = var_18_23 / 100
			local var_18_26 = var_18_23 % 100

			tostring = var_18

			local var_18_27 = var_18(var_18_25)
			local var_18_28

			if 0 < var_18_26 then
				var_18_28 = var_18_27

				local var_18_29 = "."

				tostring = var_2_10021
				var_18_27 = var_18_28 .. var_18_29 .. var_2_10021(var_18_26)
			end

			setText = var_18_28

			local var_18_30 = var_18_24:Find("text")

			string = var_2_10022

			var_18_28(var_18_30, var_2_10022.format("EXP +%s%%", var_18_27))
		end

		return
	end)

	local var_17_1 = arg_17_0._formationLogic

	var_1.AddShiftOnly(var_17_1, function(arg_19_0)
		local var_19_0 = arg_17_0

		var_1.updateView(var_19_0, false)

		return
	end)

	local var_17_2 = arg_17_0._formationLogic

	var_1.AddEndDrag(var_17_2, function()
		local var_20_0 = arg_17_0
		local var_20_1 = var_0.emit

		ChapterPreCombatMediator = var_2_10003

		var_20_1(var_20_0, var_2_10003.ON_SWITCH_SHIP, arg_17_0.chapter.fleet)

		return
	end)

	local var_17_3 = arg_17_0._formationLogic

	var_1.AddCheckRemove(var_17_3, function(arg_21_0, arg_21_1)
		arg_21_0()

		return
	end)

	local var_17_4 = arg_17_0._formationLogic

	var_1.AddCheckSwitch(var_17_4, function(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
		local var_22_0 = arg_22_3:getTeamByName(arg_22_4)

		if arg_22_3.ships[var_22_0[arg_22_2]].hpRant == 0 then
			return
		end

		arg_22_0()

		return
	end)

	local var_17_5 = arg_17_0._formationLogic

	var_1.AddCheckBeginDrag(var_17_5, function(arg_23_0, arg_23_1, arg_23_2)
		return arg_23_0.hpRant > 0
	end)

	return
end

function var_0_1.setPlayerInfo(arg_24_0, arg_24_1)
	return
end

function var_0_1.updateChapter(arg_25_0, arg_25_1)
	arg_25_0.chapter = arg_25_1

	local var_25_0 = arg_25_0.chapter.fleet
	local var_25_1 = arg_25_0._formationLogic

	var_3.SetFleetVO(var_25_1, var_25_0)

	local var_25_2 = var_25_0.ships
	local var_25_3 = arg_25_0._formationLogic

	var_4.SetShipVOs(var_25_3, var_25_2)
	arg_25_0:updateView(true)

	return
end

function var_0_1.setSubFlag(arg_26_0, arg_26_1)
	arg_26_0.subUseable = arg_26_1 or false

	return
end

function var_0_1.updateView(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0._formationLogic
	local var_27_1 = var_2.ResetGrid

	TeamType = var_1_10005

	var_27_1(var_27_0, var_1_10005.Vanguard, true)

	local var_27_2 = arg_27_0._formationLogic
	local var_27_3 = var_2.ResetGrid

	TeamType = var_5

	var_27_3(var_27_2, var_5.Main, true)

	SetActive = var_27_3

	local var_27_4 = arg_27_0._gridTFs

	TeamType = var_5

	local var_27_5 = var_27_4[var_5.Main][1]

	var_27_3(var_4.Find(var_27_5, "flag"), true)

	if arg_27_1 then
		local var_27_6 = arg_27_0.chapter.fleet
		local var_27_7 = arg_27_0.chapter
		local var_27_8 = var_3.getStageId(var_27_7, var_27_6.line.row, var_27_6.line.column)

		arg_27_0:updateStageView(var_27_8)

		local var_27_9 = arg_27_0._formationLogic

		var_4.LoadAllCharacter(var_27_9)
	else
		local var_27_10 = arg_27_0._formationLogic

		var_2.SetAllCharacterPos(var_27_10)
	end

	arg_27_0:updateBattleFleetView()
	arg_27_0:updateStrategyIcon()
	arg_27_0:displayFleetInfo()

	return
end

function var_0_1.updateStageView(arg_28_0, arg_28_1)
	pg = var_1_10002

	local var_28_0 = var_1_10002.expedition_data_template[arg_28_1]

	assert = var_1_10003

	var_1_10003(var_28_0, "expedition_data_template not exist: " .. arg_28_1)

	local var_28_1 = var_28_0.limit_type
	local var_28_2 = var_28_0.time_limit
	local var_28_3 = var_28_0.sink_limit

	Clone = var_6

	local var_28_4 = var_6(var_28_0.award_display)

	checkExist = var_7
	pg = var_1_10009

	local var_28_5

	if var_7(var_1_10009.expedition_activity_template[arg_28_1], {
		"pt_drop_display"
	}) then
		type = var_28_5

		if var_28_5(var_7) == "table" then
			getProxy = var_28_5
			ActivityProxy = var_10
			var_28_5 = var_28_5(var_10)

			for iter_28_0 = #var_7, 1, -1 do
				if var_28_5:getActivityById(var_7[iter_28_0][1]) and not var_13:isEnd() then
					table = var_14

					local var_28_6 = var_14.insert
					local var_28_7 = var_28_4
					local var_28_8 = 1

					var_1_10018 = {
						2
					}
					id2ItemId = var_1_10019
					var_1_10018[2] = var_1_10019(var_7[iter_28_0][2])

					var_28_6(var_28_7, var_28_8, var_1_10018)
				end
			end
		end
	end

	UIItemList = var_28_5

	local var_28_9 = var_28_5.New(arg_28_0._spoilsContainer, arg_28_0._item)

	var_8.make(var_28_9, function(arg_29_0, arg_29_1, arg_29_2)
		local var_29_0 = arg_29_2
		local var_29_1 = var_28_4[arg_29_1 + 1]
		local var_29_2 = {
			type = var_29_1[1],
			id = var_29_1[2]
		}

		updateDrop = var_6

		var_6(var_29_0, var_29_2)

		onButton = var_6

		local var_29_3 = arg_28_0
		local var_29_4 = var_29_0

		local function var_29_5()
			Item = var_3_10000

			if var_3_10000.getConfigData(var_29_1[2]) and var_0_3[var_0.type] then
				local function var_30_0(arg_31_0)
					local var_31_0 = var_0.display_icon
					local var_31_1 = {}

					ipairs = var_4_10003

					for iter_31_0, iter_31_1 in var_4_10003(var_31_0) do
						local var_31_2 = iter_31_1[1]
						local var_31_3 = iter_31_1[2]

						DROP_TYPE_SHIP = var_4_10010

						if var_31_2 == var_4_10010 then
							table = var_4_10010
							var_4_10010 = not var_4_10010.contains(arg_31_0, var_31_3)
						else
							var_4_10010 = false
						end

						if false then
							var_4_10010 = true
						end

						var_31_1[#var_31_1 + 1] = {
							type = var_31_2,
							id = var_31_3,
							anonymous = var_4_10010
						}
					end

					local var_31_4 = arg_28_0

					var_3.emit(var_31_4, var_0_1.ON_DROP_LIST, {
						item2Row = true,
						itemList = var_31_1,
						content = var_0.display
					})

					return
				end

				local var_30_1 = arg_28_0
				local var_30_2 = var_2.emit

				ChapterPreCombatMediator = var_3_10005

				var_30_2(var_30_1, var_3_10005.GET_CHAPTER_DROP_SHIP_LIST, arg_28_0.chapter.id, var_30_0)
			else
				local var_30_3 = arg_28_0

				var_1.emit(var_30_3, var_0_1.ON_DROP, var_29_2)
			end

			return
		end

		SFX_PANEL = var_2_10011

		var_6(var_29_3, var_29_4, var_29_5, var_2_10011)

		return
	end)

	local var_28_10 = var_8
	local var_28_11 = var_8.align

	math = var_12

	var_28_11(var_28_10, var_12.min(#var_28_4, 6))

	local function var_28_12(arg_32_0, arg_32_1)
		type = var_2_10002

		local var_32_0

		if var_2_10002(arg_32_0) == "table" then
			setActive = var_32_0

			var_32_0(arg_32_1, true)

			i18n = var_32_0
			PreCombatLayer = var_4
			var_32_0 = var_32_0(var_4.ObjectiveList[arg_32_0[1]], arg_32_0[2])
			setWidgetText = var_2_10003

			var_2_10003(arg_32_1, var_32_0)
		else
			setActive = var_32_0

			var_32_0(arg_32_1, false)
		end

		return
	end

	local var_28_13 = {}
	local var_28_14 = arg_28_0._goals

	var_28_13[1] = var_11.Find(var_28_14, "goal_tpl")

	local var_28_15 = arg_28_0._goals

	var_28_13[2] = var_11.Find(var_28_15, "goal_sink")

	local var_28_16 = arg_28_0._goals

	var_28_13[3] = var_11.Find(var_28_16, "goal_time")

	local var_28_17 = {
		var_28_0.objective_1,
		var_28_0.objective_2,
		var_28_0.objective_3
	}
	local var_28_18 = 1

	ipairs = var_28_16

	for iter_28_1, iter_28_2 in var_28_16(var_28_17) do
		type = var_1_10018

		if var_1_10018(iter_28_2) ~= "string" then
			var_28_12(iter_28_2, var_28_13[var_28_18])

			var_28_18 = var_28_18 + 1
		end
	end

	for iter_28_3 = var_28_18, #var_28_13 do
		var_28_12("", var_28_13[iter_28_3])
	end

	return
end

function var_0_1.updateBattleFleetView(arg_33_0)
	local function var_33_0(arg_34_0, arg_34_1)
		removeAllChildren = var_2_10002

		var_2_10002(arg_34_0)

		for iter_34_0 = 1, 3 do
			if arg_34_1[iter_34_0] then
				cloneTplTo = var_6

				local var_34_0 = var_6(arg_33_0._ship_tpl, arg_34_0)

				updateShip = var_2_10007

				var_2_10007(var_34_0, arg_34_1[iter_34_0])

				var_2_10007 = arg_34_1[iter_34_0].hpRant

				local var_34_1 = var_34_0:Find("blood")
				local var_34_2 = var_34_0
				local var_34_3 = var_34_0.Find(var_34_2, "blood/fillarea/green")
				local var_34_4 = var_34_0:Find("blood/fillarea/red")

				setActive = var_34_2

				local var_34_5 = var_34_3

				ChapterConst = var_2_10014
				var_2_10014 = var_2_10014.HpGreen <= var_2_10007

				var_34_2(var_34_5, var_2_10014)

				setActive = var_34_2

				local var_34_6 = var_34_4

				ChapterConst = var_2_10014
				var_2_10014 = var_2_10007 < var_2_10014.HpGreen

				var_34_2(var_34_6, var_2_10014)

				ChapterConst = var_34_2
				var_2_10014 = var_2_10007 >= var_34_2.HpGreen and var_34_3 or var_34_4

				local var_34_7 = var_11.GetComponent(var_2_10014, "Image")

				var_34_7.fillAmount = var_2_10007 * 0.0001
				setActive = var_34_7

				var_34_7(var_34_0:Find("broken"), var_2_10007 == 0)
			end
		end

		return
	end

	local var_33_1 = arg_33_0.chapter.fleet
	local var_33_2 = var_33_0
	local var_33_3 = arg_33_0._fleet
	local var_33_4 = var_5.Find(var_33_3, "main")
	local var_33_5 = var_33_1
	local var_33_6 = var_33_1.getShipsByTeam

	TeamType = var_1_10009

	var_33_2(var_33_4, var_33_6(var_33_5, var_1_10009.Main, true))

	local var_33_7 = var_33_0
	local var_33_8 = arg_33_0._fleet
	local var_33_9 = var_5.Find(var_33_8, "vanguard")
	local var_33_10 = var_33_1
	local var_33_11 = var_33_1.getShipsByTeam

	TeamType = var_9

	var_33_7(var_33_9, var_33_11(var_33_10, var_9.Vanguard, true))

	return
end

function var_0_1.displayFleetInfo(arg_35_0)
	local var_35_0 = arg_35_0.chapter.fleet
	local var_35_1 = arg_35_0.chapter
	local var_35_2 = var_2.getStageId(var_35_1, var_35_0.line.row, var_35_0.line.column)
	local var_35_3 = var_35_0
	local var_35_4 = var_35_0.getCommanders(var_35_3)

	_ = var_35_1

	local var_35_5 = var_35_1.reduce
	local var_35_6 = var_35_0
	local var_35_7 = var_35_0.getShipsByTeam

	TeamType = var_1_10009

	local var_35_8 = var_35_5(var_35_7(var_35_6, var_1_10009.Vanguard, false), 0, function(arg_36_0, arg_36_1)
		return arg_36_0 + arg_36_1:getShipCombatPower(var_35_4)
	end)

	_ = var_35_3

	local var_35_9 = var_35_3.reduce
	local var_35_10 = var_35_0
	local var_35_11 = var_35_0.getShipsByTeam

	TeamType = var_10

	local var_35_12 = var_35_9(var_35_11(var_35_10, var_10.Main, false), 0, function(arg_37_0, arg_37_1)
		return arg_37_0 + arg_37_1:getShipCombatPower(var_35_4)
	end)
	local var_35_13 = 0

	ipairs = var_7

	local var_35_14 = {}
	local var_35_15 = arg_35_0.chapter

	var_35_14[1] = var_10.getFleetCost(var_35_15, var_35_0, var_35_2)

	for iter_35_0, iter_35_1 in var_7(var_35_14) do
		var_35_13 = var_35_13 + iter_35_1.oil
	end

	local var_35_16 = arg_35_0.chapter
	local var_35_17 = var_7.isOverFleetCost(var_35_16, var_35_0, var_35_2)

	setActive = var_8

	var_8(arg_35_0._popup, true)

	setActive = var_8

	var_8(arg_35_0._costTip, var_35_17)

	setTextColor = var_8

	local var_35_18 = arg_35_0._costText

	if var_35_17 then
		Color = var_35_19

		local var_35_19

		if not var_35_19(0.9803921568627451, 0.39215686274509803, 0.39215686274509803) then
			Color = var_35_19
			var_35_19 = var_35_19.white
		end

		var_8(var_35_18, var_35_19)
		var_0_2.tweenNumText(arg_35_0._costText, var_35_13)
		var_0_2.tweenNumText(arg_35_0._vanguardGS, var_35_8)
		var_0_2.tweenNumText(arg_35_0._mainGS, var_35_12)

		local var_35_20 = arg_35_0.chapter
		local var_35_21, var_35_22 = var_8.GetExtraCostRate(var_35_20)

		setActive = var_35_20

		var_35_20(arg_35_0._extraCostBuffIcon, #var_35_22 > 0)

		ipairs = var_35_20

		for iter_35_2, iter_35_3 in var_35_20(var_35_22) do
			local var_35_23 = iter_35_3.benefit_type

			Chapter = var_1_10016

			if var_35_23 == var_1_10016.OPERATION_BUFF_TYPE_COST then
				setText = var_35_23

				local var_35_24 = arg_35_0._extraCostBuffIcon
				local var_35_25 = var_17.Find(var_35_24, "text_cost")

				tonumber = var_1_10018

				var_35_23(var_35_25, var_1_10018(iter_35_3.benefit_effect) * 0.01 + 1)
			else
				local var_35_26 = iter_35_3.benefit_type

				Chapter = var_1_10016

				if var_35_26 == var_1_10016.OPERATION_BUFF_TYPE_EXP then
					setText = var_35_26

					local var_35_27 = arg_35_0._extraCostBuffIcon
					local var_35_28 = var_17.Find(var_35_27, "text_reward")

					tonumber = var_1_10018

					var_35_26(var_35_28, var_1_10018(iter_35_3.benefit_effect) * 0.01 + 1)
				else
					local var_35_29 = iter_35_3.benefit_type

					Chapter = var_1_10016

					if var_35_29 == var_1_10016.OPERATION_BUFF_TYPE_DESC then
						onButton = var_35_29

						var_35_29(arg_35_0, arg_35_0._extraCostBuffIcon, function()
							ActivityBuff = var_2_10000

							local var_38_0 = var_2_10000.GetBenefitCondition(iter_35_3.benefit_condition)

							assert = var_2_10001

							var_2_10001(var_38_0[1] == "item")

							local var_38_1 = var_38_0[2]

							pg = var_2

							local var_38_2 = var_2.strategy_data_template[iter_35_3.id]

							pg = var_3

							local var_38_3 = var_3.MsgboxMgr.GetInstance()
							local var_38_4 = var_3.ShowMsgBox
							local var_38_5 = {
								hideNo = true
							}

							MSGBOX_TYPE_SINGLE_ITEM = var_2_10007
							var_38_5.type = var_2_10007

							local var_38_6 = {
								count = 1
							}

							DROP_TYPE_ITEM = var_2_10008
							var_38_6.type = var_2_10008
							var_38_6.id = var_38_1
							var_38_5.drop = var_38_6
							var_38_5.intro = var_38_2.desc

							var_38_4(var_38_3, var_38_5)

							return
						end)
					end
				end
			end
		end

		local var_35_30 = arg_35_0.rtAdapt
		local var_35_31 = var_10.Find(var_35_30, "middle/gear_score/vanguard")

		ChapterFleet = var_11

		local var_35_32 = var_11.StaticTransformChapterFleet2Fleet(var_35_0)
		local var_35_33 = var_11.GetFleetSonarRange(var_35_32)

		setActive = var_13

		var_13(var_35_31:Find("SonarActive"), var_35_33 > 0)

		setActive = var_13

		var_13(var_35_31:Find("SonarInactive"), var_35_33 <= 0)

		if 0 < var_35_33 then
			setText = var_13

			local var_35_34 = var_35_31:Find("SonarActive/Text")

			math = var_16

			var_13(var_35_34, var_16.floor(var_35_33))
		end

		return
	end
end

function var_0_1.updateStrategyIcon(arg_39_0)
	local var_39_0 = arg_39_0.chapter.fleet
	local var_39_1 = var_1.getStrategies(var_39_0)

	_ = var_1_10002

	local var_39_2 = var_1_10002.detect(var_39_1, function(arg_40_0)
		local var_40_0 = arg_40_0.id

		ChapterConst = var_2_10002

		return var_40_0 == var_2_10002.StrategyRepair
	end)

	pg = var_39_0

	local var_39_3 = var_39_0.strategy_data_template[var_39_2.id]

	GetImageSpriteFromAtlasAsync = var_4

	local var_39_4 = "strategyicon/" .. var_39_3.icon
	local var_39_5 = ""
	local var_39_6 = arg_39_0._strategy

	var_4(var_39_4, var_39_5, var_8.Find(var_39_6, "icon"))

	onButton = var_4

	local var_39_7 = arg_39_0
	local var_39_8 = arg_39_0._strategy

	local function var_39_9()
		local var_41_0 = arg_39_0

		var_0.displayStrategyInfo(var_41_0, var_39_2)

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_39_7, var_39_8, var_39_9, var_1_10009)

	setText = var_4

	local var_39_10 = arg_39_0._strategy

	var_4(var_6.Find(var_39_10, "nums"), var_39_2.count)

	setActive = var_4

	local var_39_11 = arg_39_0._strategy

	var_4(var_6.Find(var_39_11, "mask"), var_39_2.count == 0)

	setActive = var_4

	local var_39_12 = arg_39_0._strategy

	var_4(var_6.Find(var_39_12, "selected"), false)

	local var_39_13 = arg_39_0.rtAdapt
	local var_39_14 = var_4.Find(var_39_13, "middle/formation_list")
	local var_39_15 = var_4.Find(var_39_14, "formation")

	setActive = var_39_13

	var_39_13(var_39_15, false)

	ChapterConst = var_39_13

	local var_39_16 = var_39_13.StrategyForms
	local var_39_17 = {}
	local var_39_18 = arg_39_0.chapter.fleet
	local var_39_19 = var_8.getFormationStg(var_39_18)

	table = var_9

	var_9.insert(var_39_17, 1, {
		id = var_39_19
	})

	UIItemList = var_9

	local var_39_20 = var_9.New(var_4, var_39_15)

	var_9.make(var_39_20, function(arg_42_0, arg_42_1, arg_42_2)
		UIItemList = var_2_10003

		if arg_42_0 == var_2_10003.EventUpdate then
			local var_42_0 = var_39_17[arg_42_1 + 1]

			pg = var_4

			local var_42_1 = var_4.strategy_data_template[var_42_0.id].type

			ChapterConst = var_2_10006

			if var_42_1 ~= var_2_10006.StgTypeForm then
				return
			end

			GetImageSpriteFromAtlasAsync = var_42_1

			var_42_1("strategyicon/" .. var_4.icon, "", arg_42_2:Find("icon"))

			onButton = var_42_1

			local var_42_2 = arg_39_0
			local var_42_3 = arg_42_2

			local function var_42_4()
				local var_43_0 = var_0.type

				ChapterConst = var_3_10001

				if var_43_0 == var_3_10001.StgTypeForm then
					local var_43_1 = arg_39_0.chapter.fleet
					local var_43_2 = var_0.getNextStgUser(var_43_1, var_42_0.id)

					table = var_1

					local var_43_3 = var_1.indexof(var_39_16, var_42_0.id)
					local var_43_4 = arg_39_0
					local var_43_5 = var_2.emit

					ChapterPreCombatMediator = var_3_10005

					local var_43_6 = var_3_10005.ON_OP
					local var_43_7 = {}

					ChapterConst = var_3_10007
					var_43_7.type = var_3_10007.OpStrategy
					var_43_7.id = var_43_2
					var_43_7.arg1 = var_39_16[var_43_3 % #var_39_16 + 1]

					var_43_5(var_43_4, var_43_6, var_43_7)
				end

				return
			end

			SFX_PANEL = var_2_10010

			var_42_1(var_42_2, var_42_3, var_42_4, var_2_10010)

			setText = var_42_1

			var_42_1(arg_42_2:Find("nums"), "")

			setActive = var_42_1

			var_42_1(arg_42_2:Find("mask"), false)

			setActive = var_42_1

			var_42_1(arg_42_2:Find("selected"), false)
		end

		return
	end)
	var_9:align(#var_39_17)

	return
end

function var_0_1.displayStrategyInfo(arg_44_0, arg_44_1)
	local var_44_0

	if not arg_44_0.strategyPanel then
		StrategyPanel = var_44_0
		var_44_0 = var_44_0.New(arg_44_0.strategyInfo)
	end

	arg_44_0.strategyPanel = var_44_0

	local var_44_1 = arg_44_0.strategyPanel

	var_2.attach(var_44_1, arg_44_0)

	local var_44_2 = arg_44_0.strategyPanel

	var_2.set(var_44_2, arg_44_1)

	pg = var_2

	local var_44_3 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_44_3, arg_44_0.strategyPanel._tf)

	function arg_44_0.strategyPanel.onConfirm()
		local var_45_0 = arg_44_0.chapter.fleet

		pg = var_2_10002

		local var_45_1 = var_2_10002.strategy_data_template[arg_44_1.id]

		if not var_45_0:canUseStrategy(arg_44_1) then
			return
		end

		local var_45_2 = var_45_0:getNextStgUser(arg_44_1.id)
		local var_45_3 = arg_44_0
		local var_45_4 = var_4.emit

		ChapterPreCombatMediator = var_2_10007

		local var_45_5 = var_2_10007.ON_OP
		local var_45_6 = {}

		ChapterConst = var_2_10009
		var_45_6.type = var_2_10009.OpStrategy
		var_45_6.id = var_45_2
		var_45_6.arg1 = arg_44_1.id

		var_45_4(var_45_3, var_45_5, var_45_6)

		local var_45_7 = arg_44_0

		var_4.hideStrategyInfo(var_45_7)

		return
	end

	function arg_44_0.strategyPanel.onCancel()
		local var_46_0 = arg_44_0

		var_0.hideStrategyInfo(var_46_0)

		return
	end

	return
end

function var_0_1.hideStrategyInfo(arg_47_0)
	if arg_47_0.strategyPanel then
		pg = var_1

		local var_47_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_47_0, arg_47_0.strategyPanel._tf)

		local var_47_1 = arg_47_0.strategyPanel

		var_1.detach(var_47_1)
	end

	return
end

function var_0_1.onBackPressed(arg_48_0)
	local var_48_1

	if arg_48_0.strategyPanel and arg_48_0.strategyPanel._go then
		isActive = var_48_1

		if var_48_1(arg_48_0.strategyPanel._go) then
			pg = var_48_1

			local var_48_0 = var_48_1.CriMgr.GetInstance()

			var_48_1 = var_48_1.PlaySoundEffect_V3
			SFX_CANCEL = var_1_10004

			var_48_1(var_48_0, var_1_10004)
			arg_48_0:hideStrategyInfo()

			goto label_48_0
		end
	end

	pg = var_48_1

	do
		local var_48_2 = var_48_1.CriMgr.GetInstance()
		local var_48_3 = var_1.PlaySoundEffect_V3

		SFX_CANCEL = var_1_10004

		var_48_3(var_48_2, var_1_10004)

		triggerButton = var_48_3

		var_48_3(arg_48_0._backBtn)
	end

	::label_48_0::

	return
end

function var_0_1.willExit(arg_49_0)
	if arg_49_0.strategyPanel and arg_49_0.strategyPanel._go then
		isActive = var_1

		if var_1(arg_49_0.strategyPanel._go) then
			arg_49_0:hideStrategyInfo()
		end
	end

	local var_49_0 = arg_49_0._formationLogic

	var_1.Destroy(var_49_0)

	arg_49_0._formationLogic = nil
	pg = var_1

	local var_49_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_49_1, arg_49_0._tf)

	return
end

return var_0_1
