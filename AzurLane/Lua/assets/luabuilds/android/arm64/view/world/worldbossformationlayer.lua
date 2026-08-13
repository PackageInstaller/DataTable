class = var_0_10000

local var_0_0 = "WorldBossFormationLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

import = var_0_10001

local var_0_2 = var_0_10001("..ship.FormationUI")

var_0_1.FORM_EDIT = "EDIT"
var_0_1.FORM_PREVIEW = "PREVIEW"

function var_0_1.getUIName(arg_1_0)
	return "PreCombatUI"
end

function var_0_1.ResUISettings(arg_2_0)
	local var_2_0 = {
		anim = true,
		order = 5
	}

	PlayerResUI = var_1_10002
	var_2_0.showType = var_1_10002.TYPE_ALL

	return var_2_0
end

function var_0_1.SetBossProxy(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.boss = arg_3_1:GetBossById(arg_3_2)

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0.rtAdapt

	arg_4_0._startBtn = var_1.Find(var_4_0, "right/start")

	local var_4_1 = arg_4_0.rtAdapt

	arg_4_0._popup = var_1.Find(var_4_1, "right/start/cost_container/popup")

	local var_4_2 = arg_4_0.rtAdapt

	arg_4_0._costText = var_1.Find(var_4_2, "right/start/cost_container/popup/Text")

	local var_4_3 = arg_4_0._tf

	arg_4_0._backBtn = var_1.Find(var_4_3, "blur_panel/top/back_btn")

	local var_4_4 = arg_4_0._tf

	arg_4_0._moveLayer = var_1.Find(var_4_4, "moveLayer")

	local var_4_5 = arg_4_0.rtAdapt
	local var_4_6 = var_1.Find(var_4_5, "middle")
	local var_4_7 = arg_4_0.rtAdapt

	arg_4_0._autoToggle = var_2.Find(var_4_7, "auto_toggle")

	local var_4_8 = arg_4_0.rtAdapt

	arg_4_0.subToggle = var_2.Find(var_4_8, "sub_toggle_container")
	setActive = var_2

	var_2(arg_4_0.subToggle, false)

	local var_4_9 = arg_4_0.rtAdapt

	arg_4_0._buffContainer = var_2.Find(var_4_9, "BuffContainer")
	setActive = var_2

	var_2(arg_4_0._buffContainer, false)

	arg_4_0._fleetInfo = var_4_6:Find("fleet_info")
	arg_4_0._fleetNameText = var_4_6:Find("fleet_info/fleet_name/Text")
	arg_4_0._fleetNumText = var_4_6:Find("fleet_info/fleet_number")
	setActive = var_2

	local var_4_10 = arg_4_0._fleetInfo
	local var_4_11 = arg_4_0.contextData.system

	SYSTEM_DUEL = var_1_10006

	var_2(var_4_10, var_4_11 ~= var_1_10006)

	arg_4_0._mainGS = var_4_6:Find("gear_score/main/Text")
	arg_4_0._vanguardGS = var_4_6:Find("gear_score/vanguard/Text")
	arg_4_0._gridTFs = {
		vanguard = {},
		main = {}
	}
	arg_4_0._gridFrame = var_4_6:Find("mask/GridFrame")

	for iter_4_0 = 1, 3 do
		local var_4_12 = arg_4_0._gridTFs

		TeamType = var_1_10007

		local var_4_13 = var_4_12[var_1_10007.Vanguard]
		local var_4_14 = arg_4_0._gridFrame

		var_4_13[iter_4_0] = var_1_10007.Find(var_4_14, "vanguard_" .. iter_4_0)

		local var_4_15 = arg_4_0._gridTFs

		TeamType = var_1_10007

		local var_4_16 = var_4_15[var_1_10007.Main]
		local var_4_17 = arg_4_0._gridFrame

		var_4_16[iter_4_0] = var_1_10007.Find(var_4_17, "main_" .. iter_4_0)
	end

	local var_4_18 = arg_4_0.rtAdapt

	arg_4_0._nextPage = var_2.Find(var_4_18, "middle/nextPage")

	local var_4_19 = arg_4_0.rtAdapt

	arg_4_0._prevPage = var_2.Find(var_4_19, "middle/prevPage")

	arg_4_0:disableAllStepper()

	arg_4_0._heroContainer = var_4_6:Find("HeroContainer")
	arg_4_0._checkBtn = var_4_6:Find("checkBtn")

	local var_4_20 = arg_4_0.rtAdapt

	arg_4_0._spoilsContainer = var_2.Find(var_4_20, "right/infomation/atlasloot/spoils/items/items_container")
	arg_4_0._item = arg_4_0:getTpl("right/infomation/atlasloot/spoils/items/item_tpl", arg_4_0.rtAdapt)

	local var_4_21 = arg_4_0.rtAdapt

	arg_4_0._goals = var_2.Find(var_4_21, "right/infomation/target/goal")
	arg_4_0._heroInfo = arg_4_0:getTpl("heroInfo")
	arg_4_0._starTpl = arg_4_0:getTpl("star_tpl")

	local var_4_22 = arg_4_0.rtAdapt

	arg_4_0._middle = var_2.Find(var_4_22, "middle")

	local var_4_23 = arg_4_0.rtAdapt

	arg_4_0._right = var_2.Find(var_4_23, "right")

	local var_4_24 = arg_4_0._tf

	arg_4_0.topPanel = var_2.Find(var_4_24, "blur_panel/top")
	setAnchoredPosition = var_2

	var_2(arg_4_0._middle, {
		x = -840
	})

	setAnchoredPosition = var_2

	var_2(arg_4_0._right, {
		x = 470
	})

	local var_4_25 = arg_4_0._middle

	arg_4_0.guideDesc = var_2.Find(var_4_25, "guideDesc")

	if arg_4_0.contextData.stageId then
		arg_4_0:SetStageID(arg_4_0.contextData.stageId)
	end

	BaseFormation = var_2
	arg_4_0._formationLogic = var_2.New(arg_4_0._tf, arg_4_0._heroContainer, arg_4_0._heroInfo, arg_4_0._gridTFs)

	arg_4_0:Register()

	return
end

function var_0_1.Register(arg_5_0)
	local var_5_0 = arg_5_0._formationLogic

	var_1.AddLoadComplete(var_5_0, function()
		if arg_5_0._currentForm ~= var_0_1.FORM_EDIT then
			local var_6_0 = arg_5_0._formationLogic

			var_0.SwitchToPreviewMode(var_6_0)
		end

		return
	end)

	local var_5_1 = arg_5_0._formationLogic

	var_1.AddHeroInfoModify(var_5_1, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_7_2
		local var_7_1 = arg_7_2.SetLocalScale

		Vector3 = var_2_10006

		var_7_1(var_7_0, var_2_10006(0.65, 0.65, 1))

		SetActive = var_7_1

		var_7_1(arg_7_0, true)

		local var_7_2 = arg_7_0:Find("info")
		local var_7_3 = var_3.Find(var_7_2, "stars")
		local var_7_4 = arg_7_1.energy

		Ship = var_7_2

		local var_7_5 = var_7_4 <= var_7_2.ENERGY_MID
		local var_7_6 = var_3:Find("energy")
		local var_7_8

		if var_7_5 then
			local var_7_7 = arg_7_1
			local var_7_9

			var_7_8, var_7_9 = arg_7_1.getEnergyPrint(var_7_7)
			GetSpriteFromAtlas = var_7_7

			if not var_7_7("energy", var_7_8) then
				warning = var_10

				var_10("找不到疲劳")
			end

			setImageSprite = var_10

			var_10(var_7_6, var_9)
		end

		setActive = var_7_8

		var_7_8(var_7_6, false)

		setActive = var_7_8

		var_7_8(var_3:Find("expbuff"), false)

		local var_7_10 = arg_7_1:getStar()

		for iter_7_0 = 1, var_7_10 do
			cloneTplTo = var_12

			var_12(arg_5_0._starTpl, var_7_3)
		end

		GetSpriteFromAtlas = var_8

		local var_7_11 = "shiptype"

		shipType2print = iter_7_0

		if not var_8(var_7_11, iter_7_0(arg_7_1:getShipType())) then
			warning = var_9

			var_9("找不到船形, shipConfigId: " .. arg_7_1.configId)
		end

		setImageSprite = var_9

		var_9(var_3:Find("type"), var_8, true)

		setText = var_9

		var_9(var_3:Find("frame/lv_contain/lv"), arg_7_1.level)

		return
	end)

	local var_5_2 = arg_5_0._formationLogic

	var_1.AddLongPress(var_5_2, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_5_0
		local var_8_1 = var_3.emit

		WorldBossFormationMediator = var_2_10006

		var_8_1(var_8_0, var_2_10006.OPEN_SHIP_INFO, arg_8_1.id, arg_8_2)

		return
	end)

	local var_5_3 = arg_5_0._formationLogic

	var_1.AddClick(var_5_3, function(arg_9_0, arg_9_1, arg_9_2)
		pg = var_2_10003

		local var_9_0 = var_2_10003.CriMgr.GetInstance()
		local var_9_1 = var_3.PlaySoundEffect_V3

		SFX_UI_CLICK = var_2_10006

		var_9_1(var_9_0, var_2_10006)

		local var_9_2 = arg_5_0
		local var_9_3 = var_3.emit

		WorldBossFormationMediator = var_2_10006

		var_9_3(var_9_2, var_2_10006.CHANGE_FLEET_SHIP, arg_9_0, arg_9_2, arg_9_1)

		return
	end)

	local var_5_4 = arg_5_0._formationLogic

	var_1.AddBeginDrag(var_5_4, function(arg_10_0)
		local var_10_0 = arg_10_0:Find("info")

		SetActive = var_2_10002

		var_2_10002(var_10_0, false)

		return
	end)

	local var_5_5 = arg_5_0._formationLogic

	var_1.AddEndDrag(var_5_5, function(arg_11_0)
		local var_11_0 = arg_11_0:Find("info")

		SetActive = var_2_10002

		var_2_10002(var_11_0, true)

		return
	end)

	local var_5_6 = arg_5_0._formationLogic

	var_1.AddShiftOnly(var_5_6, function(arg_12_0)
		local var_12_0 = arg_5_0
		local var_12_1 = var_1.emit

		WorldBossFormationMediator = var_2_10004

		var_12_1(var_12_0, var_2_10004.CHANGE_FLEET_SHIPS_ORDER)

		return
	end)

	local var_5_7 = arg_5_0._formationLogic

	var_1.AddRemoveShip(var_5_7, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_5_0
		local var_13_1 = var_2.emit

		WorldBossFormationMediator = var_2_10005

		var_13_1(var_13_0, var_2_10005.REMOVE_SHIP, arg_13_0, arg_13_1)

		return
	end)

	local var_5_8 = arg_5_0._formationLogic

	var_1.AddCheckRemove(var_5_8, function(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		local var_14_1

		if not arg_14_3:canRemove(arg_14_2) then
			local var_14_0 = arg_14_3
			local var_14_2

			var_14_1, var_14_2 = arg_14_3.getShipPos(var_14_0, arg_14_2)
			pg = var_14_0
			var_2_10009 = var_14_0.TipsMgr.GetInstance()

			local var_14_3 = var_7.ShowTips

			i18n = var_2_10010

			local var_14_4 = "ship_formationUI_removeError_onlyShip"
			local var_14_5 = arg_14_2
			local var_14_6 = arg_14_2.getConfigTable(var_14_5).name
			local var_14_7 = arg_14_3.name

			Fleet = var_14_5

			var_14_3(var_2_10009, var_2_10010(var_14_4, var_14_6, var_14_7, var_14_5.C_TEAM_NAME[var_14_2]))
			arg_14_0()
		else
			pg = var_14_1

			local var_14_8 = var_14_1.MsgboxMgr.GetInstance()
			local var_14_9 = var_5.ShowMsgBox
			local var_14_10 = {
				hideNo = false,
				zIndex = -100
			}

			i18n = var_2_10009
			var_14_10.content = var_2_10009("battle_preCombatLayer_quest_leaveFleet", arg_14_2:getConfigTable().name)
			var_14_10.onYes = arg_14_1
			var_14_10.onNo = arg_14_0

			var_14_9(var_14_8, var_14_10)
		end

		return
	end)

	local var_5_9 = arg_5_0._formationLogic

	var_1.AddSwitchToDisplayMode(var_5_9, function()
		arg_5_0._currentForm = var_0_1.FORM_EDIT

		local var_15_0 = arg_5_0._checkBtn
		local var_15_1 = var_0.GetComponent(var_15_0, "Button")

		var_15_1.interactable = true
		setActive = var_15_1

		local var_15_2 = arg_5_0._checkBtn

		var_15_1(var_2.Find(var_15_2, "save"), true)

		setActive = var_15_1

		local var_15_3 = arg_5_0._checkBtn

		var_15_1(var_2.Find(var_15_3, "edit"), false)

		return
	end)

	local var_5_10 = arg_5_0._formationLogic

	var_1.AddSwitchToShiftMode(var_5_10, function()
		local var_16_0 = arg_5_0

		var_0.disableAllStepper(var_16_0)

		local var_16_1 = arg_5_0._checkBtn

		var_0.GetComponent(var_16_1, "Button").interactable = false

		return
	end)

	local var_5_11 = arg_5_0._formationLogic

	var_1.AddSwitchToPreviewMode(var_5_11, function()
		arg_5_0._currentForm = var_0_1.FORM_PREVIEW

		local var_17_0 = arg_5_0._checkBtn
		local var_17_1 = var_0.GetComponent(var_17_0, "Button")

		var_17_1.interactable = true
		setActive = var_17_1

		local var_17_2 = arg_5_0._checkBtn

		var_17_1(var_2.Find(var_17_2, "save"), false)

		setActive = var_17_1

		local var_17_3 = arg_5_0._checkBtn

		var_17_1(var_2.Find(var_17_3, "edit"), true)

		return
	end)

	local var_5_12 = arg_5_0._formationLogic

	var_1.AddGridTipClick(var_5_12, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_5_0
		local var_18_1 = var_2.emit

		WorldBossFormationMediator = var_2_10005

		var_18_1(var_18_0, var_2_10005.CHANGE_FLEET_SHIP, nil, arg_18_1, arg_18_0)

		return
	end)

	return
end

function var_0_1.SetPlayerInfo(arg_19_0, arg_19_1)
	return
end

function var_0_1.SetShips(arg_20_0, arg_20_1)
	arg_20_0._shipVOs = arg_20_1

	local var_20_0 = arg_20_0._formationLogic

	var_2.SetShipVOs(var_20_0, arg_20_0._shipVOs)

	return
end

function var_0_1.SetStageID(arg_21_0, arg_21_1)
	removeAllChildren = var_1_10002

	var_1_10002(arg_21_0._spoilsContainer)

	arg_21_0._stageID = arg_21_1
	pg = var_1_10002

	local var_21_0 = var_1_10002.expedition_data_template[arg_21_1].limit_type
	local var_21_1 = var_2.time_limit
	local var_21_2 = var_2.sink_limit
	local var_21_3 = var_2.award_display

	ipairs = var_1_10007

	for iter_21_0, iter_21_1 in var_1_10007(var_21_3) do
		cloneTplTo = var_1_10012
		var_1_10012 = var_1_10012(arg_21_0._item, arg_21_0._spoilsContainer)

		local var_21_4 = {
			id = iter_21_1[2],
			type = iter_21_1[1]
		}

		updateDrop = var_1_10014

		var_1_10014(var_1_10012, var_21_4)
	end

	local var_21_5 = arg_21_0._goals
	local var_21_6 = var_7.Find(var_21_5, "goal_tpl")
	local var_21_7 = arg_21_0._goals
	local var_21_8 = var_8.Find(var_21_7, "goal_sink")
	local var_21_9 = arg_21_0._goals
	local var_21_10 = var_9.Find(var_21_9, "goal_time")

	if var_21_0 == 1 then
		var_21_7 = nil

		if var_21_2 < 2 then
			i18n = var_21_9
			var_21_7 = var_21_9("battle_preCombatLayer_undefeated")
		else
			i18n = var_21_9
			var_21_7 = var_21_9("battle_preCombatLayer_sink_limit", var_21_2)
		end

		setWidgetText = var_21_9

		local var_21_11 = var_21_6

		i18n = var_1_10014

		var_21_9(var_21_11, var_1_10014("battle_preCombatLayer_victory"))

		setWidgetText = var_21_9

		var_21_9(var_21_8, var_21_7)

		setWidgetText = var_21_9

		local var_21_12 = var_21_10

		i18n = var_14

		var_21_9(var_21_12, var_14("battle_preCombatLayer_time_limit", var_21_1))
	elseif var_21_0 == 2 then
		setActive = var_21_7

		var_21_7(var_21_8, false)

		setActive = var_21_7

		var_21_7(var_21_10, false)

		setWidgetText = var_21_7

		local var_21_13 = var_21_6

		i18n = var_13

		var_21_7(var_21_13, var_13("battle_preCombatLayer_time_hold", var_21_1))
	elseif var_21_0 == 3 then
		setActive = var_21_7

		var_21_7(var_21_8, false)

		setActive = var_21_7

		var_21_7(var_21_10, false)

		setWidgetText = var_21_7

		local var_21_14 = var_21_6

		i18n = var_13

		var_21_7(var_21_14, var_13("battle_result_defeat_all_enemys", var_21_1))
	end

	local var_21_16

	if var_2.guide_desc then
		local var_21_15 = #var_2.guide_desc

		var_21_16 = 0 < var_21_15
	end

	setActive = var_21_9

	var_21_9(arg_21_0.guideDesc, var_21_16)

	if var_21_16 then
		setText = var_21_9

		var_21_9(arg_21_0.guideDesc, var_2.guide_desc)
	end

	return
end

function var_0_1.SetCurrentFleet(arg_22_0, arg_22_1)
	arg_22_0._currentFleetVO = arg_22_1

	local var_22_0 = arg_22_0._formationLogic

	var_2.SetFleetVO(var_22_0, arg_22_0._currentFleetVO)

	arg_22_0._legalFleetIdList = {
		arg_22_1
	}
	arg_22_0._curFleetIndex = 1

	return
end

function var_0_1.UpdateFleetView(arg_23_0, arg_23_1)
	arg_23_0:displayFleetInfo()

	local var_23_0 = arg_23_0._formationLogic
	local var_23_1 = var_2.ResetGrid

	TeamType = var_1_10005

	var_23_1(var_23_0, var_1_10005.Vanguard, arg_23_0._currentForm ~= var_0_1.FORM_EDIT)

	local var_23_2 = arg_23_0._formationLogic
	local var_23_3 = var_2.ResetGrid

	TeamType = var_5

	var_23_3(var_23_2, var_5.Main, arg_23_0._currentForm ~= var_0_1.FORM_EDIT)

	if arg_23_1 then
		local var_23_4 = arg_23_0._formationLogic

		var_2.LoadAllCharacter(var_23_4)
	else
		local var_23_5 = arg_23_0._formationLogic

		var_2.SetAllCharacterPos(var_23_5)
	end

	return
end

function var_0_1.uiStartAnimating(arg_24_0)
	local var_24_0 = 0
	local var_24_1 = 0.3

	setAnchoredPosition = var_1_10003

	var_1_10003(arg_24_0.topPanel, {
		y = 100
	})

	shiftPanel = var_1_10003

	var_1_10003(arg_24_0._middle, 0, nil, var_24_1, var_24_0, true, true)

	shiftPanel = var_1_10003

	var_1_10003(arg_24_0._right, 0, nil, var_24_1, var_24_0, true, true)

	shiftPanel = var_1_10003

	var_1_10003(arg_24_0.topPanel, nil, 0, var_24_1, var_24_0, true, true, nil)

	return
end

function var_0_1.uiExitAnimating(arg_25_0)
	shiftPanel = var_1_10001

	var_1_10001(arg_25_0._middle, -840, nil, nil, nil, true, true)

	shiftPanel = var_1_10001

	var_1_10001(arg_25_0._right, 470, nil, nil, nil, true, true)

	shiftPanel = var_1_10001

	var_1_10001(arg_25_0.topPanel, nil, arg_25_0.topPanel.rect.height, nil, nil, true, true, nil)

	return
end

function var_0_1.didEnter(arg_26_0)
	onButton = var_1_10001

	local var_26_0 = arg_26_0
	local var_26_1 = arg_26_0._backBtn

	local function var_26_2()
		local var_27_0 = {}

		if arg_26_0._currentForm == var_0_1.FORM_EDIT then
			table = var_1

			var_1.insert(var_27_0, function(arg_28_0)
				pg = var_3_10001

				local var_28_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_28_1 = var_1.ShowMsgBox
				local var_28_2 = {
					hideNo = false,
					zIndex = -100
				}

				i18n = var_3_10005
				var_28_2.content = var_3_10005("battle_preCombatLayer_save_confirm")

				function var_28_2.onYes()
					local var_29_0 = arg_26_0
					local var_29_1 = var_0.emit

					WorldBossFormationMediator = var_4_10003

					var_29_1(var_29_0, var_4_10003.ON_COMMIT_EDIT, function()
						pg = var_5_10000

						local var_30_0 = var_5_10000.TipsMgr.GetInstance()
						local var_30_1 = var_0.ShowTips

						i18n = var_5_10003

						var_30_1(var_30_0, var_5_10003("battle_preCombatLayer_save_success"))
						arg_28_0()

						return
					end)

					return
				end

				var_28_2.onNo = arg_28_0

				var_28_1(var_28_0, var_28_2)

				return
			end)
		end

		seriesAsync = var_1

		var_1(var_27_0, function()
			GetOrAddComponent = var_3_10000

			local var_31_0 = arg_26_0._tf

			typeof = var_3_10003
			CanvasGroup = var_3_10005
			var_3_10000(var_31_0, var_3_10003(var_3_10005)).interactable = false

			local var_31_1 = arg_26_0

			var_1.uiExitAnimating(var_31_1)

			LeanTween = var_1

			local var_31_2 = var_1.delayedCall
			local var_31_3 = 0.3

			System = var_3_10004

			var_31_2(var_31_3, var_3_10004.Action(function()
				nowWorld = var_4_10000

				local var_32_0 = var_4_10000()
				local var_32_1 = var_0.GetBossProxy(var_32_0)

				var_0.UnlockCacheBoss(var_32_1)

				local var_32_2 = arg_26_0

				var_0.emit(var_32_2, var_0_1.ON_CLOSE)

				return
			end))

			return
		end)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_26_0, var_26_1, var_26_2, var_1_10006)

	onButton = var_1_10001

	local var_26_3 = arg_26_0
	local var_26_4 = arg_26_0._startBtn

	local function var_26_5()
		local var_33_0 = {}

		if arg_26_0._currentForm == var_0_1.FORM_EDIT then
			table = var_1

			var_1.insert(var_33_0, function(arg_34_0)
				pg = var_3_10001

				local var_34_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_34_1 = var_1.ShowMsgBox
				local var_34_2 = {
					hideNo = false,
					zIndex = -100
				}

				i18n = var_3_10005
				var_34_2.content = var_3_10005("battle_preCombatLayer_save_march")

				function var_34_2.onYes()
					local var_35_0 = arg_26_0
					local var_35_1 = var_0.emit

					WorldBossFormationMediator = var_4_10003

					var_35_1(var_35_0, var_4_10003.ON_COMMIT_EDIT, function()
						pg = var_5_10000

						local var_36_0 = var_5_10000.TipsMgr.GetInstance()
						local var_36_1 = var_0.ShowTips

						i18n = var_5_10003

						var_36_1(var_36_0, var_5_10003("battle_preCombatLayer_save_success"))
						arg_34_0()

						return
					end)

					return
				end

				var_34_1(var_34_0, var_34_2)

				return
			end)
		end

		seriesAsync = var_1

		var_1(var_33_0, function()
			local var_37_0 = arg_26_0
			local var_37_1 = var_0.emit

			WorldBossFormationMediator = var_3_10003

			var_37_1(var_37_0, var_3_10003.ON_START, arg_26_0._currentFleetVO.id)

			return
		end)

		return
	end

	SFX_UI_WEIGHANCHOR = var_1_10006

	var_1_10001(var_26_3, var_26_4, var_26_5, var_1_10006)

	onButton = var_1_10001

	local var_26_6 = arg_26_0
	local var_26_7 = arg_26_0._checkBtn

	local function var_26_8()
		if arg_26_0._currentForm == var_0_1.FORM_EDIT then
			local var_38_0 = arg_26_0
			local var_38_1 = var_0.emit

			WorldBossFormationMediator = var_2_10003

			var_38_1(var_38_0, var_2_10003.ON_COMMIT_EDIT, function()
				pg = var_3_10000

				local var_39_0 = var_3_10000.TipsMgr.GetInstance()
				local var_39_1 = var_0.ShowTips

				i18n = var_3_10003

				var_39_1(var_39_0, var_3_10003("battle_preCombatLayer_save_success"))

				local var_39_2 = arg_26_0._formationLogic

				var_0.SwitchToPreviewMode(var_39_2)

				return
			end)
		elseif arg_26_0._currentForm == var_0_1.FORM_PREVIEW then
			local var_38_2 = arg_26_0._formationLogic

			var_0.SwitchToDisplayMode(var_38_2)
		else
			assert = var_0

			var_0("currentForm error")
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_26_6, var_26_7, var_26_8, var_1_10006)

	arg_26_0._currentForm = arg_26_0.contextData.form
	arg_26_0.contextData.form = nil

	arg_26_0:UpdateFleetView(true)

	if arg_26_0._currentForm == var_0_1.FORM_EDIT then
		local var_26_9 = arg_26_0._formationLogic

		var_1.SwitchToDisplayMode(var_26_9)
	else
		local var_26_10 = arg_26_0._formationLogic

		var_1.SwitchToPreviewMode(var_26_10)
	end

	pg = var_1

	local var_26_11 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_26_11, arg_26_0._tf)

	local var_26_12 = arg_26_0.contextData.system

	SYSTEM_DUEL = var_2

	if var_26_12 == var_2 then
		setActive = var_26_12

		var_26_12(arg_26_0._autoToggle, false)
	else
		setActive = var_26_12

		var_26_12(arg_26_0._autoToggle, true)

		onToggle = var_26_12

		local var_26_13 = arg_26_0
		local var_26_14 = arg_26_0._autoToggle

		local function var_26_15(arg_40_0)
			local var_40_0 = arg_26_0
			local var_40_1 = var_1.emit

			WorldBossFormationMediator = var_2_10004

			var_40_1(var_40_0, var_2_10004.ON_AUTO, {
				isOn = not arg_40_0,
				toggle = arg_26_0._autoToggle
			})

			return
		end

		SFX_PANEL = var_1_10006
		SFX_PANEL = var_1_10007

		var_26_12(var_26_13, var_26_14, var_26_15, var_1_10006, var_1_10007)

		triggerToggle = var_26_12

		local var_26_16 = arg_26_0._autoToggle

		ys = var_26_14

		local var_26_17 = var_26_14.Battle.BattleState.IsAutoBotActive

		SYSTEM_WORLD = var_1_10006

		var_26_12(var_26_16, var_26_17(var_1_10006))
	end

	setAnchoredPosition = var_26_12

	var_26_12(arg_26_0.topPanel, {
		y = arg_26_0.topPanel.rect.height
	})

	onNextTick = var_26_12

	var_26_12(function()
		local var_41_0 = arg_26_0

		var_0.uiStartAnimating(var_41_0)

		return
	end)

	if arg_26_0._currentForm == var_0_1.FORM_PREVIEW then
		local var_26_18 = arg_26_0._currentFleetVO

		if var_1.isLegalToFight(var_26_18) ~= true then
			triggerButton = var_1

			var_1(arg_26_0._checkBtn)
		end
	end

	arg_26_0:UpdateBuffContainer()
	arg_26_0:TryPlayGuide()

	return
end

function var_0_1.onBackPressed(arg_42_0)
	pg = var_1_10001

	local var_42_0 = var_1_10001.CriMgr.GetInstance()
	local var_42_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_42_1(var_42_0, var_1_10004)

	triggerButton = var_42_1

	var_42_1(arg_42_0._backBtn)

	return
end

function var_0_1.displayFleetInfo(arg_43_0)
	local var_43_0 = arg_43_0._currentFleetVO
	local var_43_1 = var_1.GetPropertiesSum(var_43_0)
	local var_43_2 = arg_43_0._currentFleetVO
	local var_43_3 = var_2.GetGearScoreSum

	TeamType = var_1_10005

	local var_43_4 = var_43_3(var_43_2, var_1_10005.Vanguard)
	local var_43_5 = arg_43_0._currentFleetVO
	local var_43_6 = var_3.GetGearScoreSum

	TeamType = var_1_10006

	local var_43_7 = var_43_6(var_43_5, var_1_10006.Main)
	local var_43_8 = 0

	if arg_43_0.boss then
		local var_43_9 = arg_43_0.boss

		if var_5.IsSelf(var_43_9) then
			local var_43_10 = arg_43_0.boss

			if var_5.GetSelfFightCnt(var_43_10) > 0 then
				local var_43_11 = arg_43_0.boss

				var_43_8 = var_5.GetOilConsume(var_43_11)
			end
		end
	end

	setActive = var_5

	local var_43_12 = arg_43_0._popup
	local var_43_13 = arg_43_0.contextData.system

	SYSTEM_DUEL = var_1_10009

	var_5(var_43_12, var_43_13 ~= var_1_10009)
	var_0_2.tweenNumText(arg_43_0._costText, var_43_8)
	var_0_2.tweenNumText(arg_43_0._vanguardGS, var_43_4)
	var_0_2.tweenNumText(arg_43_0._mainGS, var_43_7)

	setText = var_5

	var_5(arg_43_0._fleetNameText, var_0_2.defaultFleetName(arg_43_0._currentFleetVO))

	setText = var_5

	var_5(arg_43_0._fleetNumText, arg_43_0._currentFleetVO.id)

	return
end

function var_0_1.disableAllStepper(arg_44_0)
	SetActive = var_1_10001

	var_1_10001(arg_44_0._nextPage, false)

	SetActive = var_1_10001

	var_1_10001(arg_44_0._prevPage, false)

	return
end

function var_0_1.GetActiveStgs(arg_45_0)
	local var_45_0 = {}

	WorldBossProxy = var_1_10002

	local var_45_1, var_45_2, var_45_3 = var_1_10002.GetSupportValue()

	if var_45_1 and arg_45_0.boss then
		local var_45_4 = arg_45_0.boss

		if var_5.IsSelf(var_45_4) then
			table = var_5

			var_5.insert(var_45_0, var_45_3)
		end
	end

	return var_45_0
end

function var_0_1.UpdateBuffContainer(arg_46_0)
	local var_46_0 = #arg_46_0:GetActiveStgs()
	local var_46_1 = 0 < var_46_0

	setActive = var_3

	var_3(arg_46_0._buffContainer, var_46_1)

	if not var_46_1 then
		return
	end

	UIItemList = var_3

	local var_46_2 = var_3.StaticAlign
	local var_46_3 = arg_46_0._buffContainer
	local var_46_4 = arg_46_0._buffContainer

	var_46_2(var_46_3, var_6.GetChild(var_46_4, 0), #var_1, function(arg_47_0, arg_47_1, arg_47_2)
		UIItemList = var_2_10003

		if arg_47_0 ~= var_2_10003.EventUpdate then
			return
		end

		pg = var_3

		local var_47_0 = var_3.strategy_data_template[var_0[arg_47_1 + 1]]

		GetImageSpriteFromAtlasAsync = var_4

		var_4("strategyicon/" .. var_47_0.icon, "", arg_47_2)

		onButton = var_4

		local var_47_1 = arg_46_0
		local var_47_2 = arg_47_2

		local function var_47_3()
			pg = var_3_10000

			local var_48_0 = var_3_10000.MsgboxMgr.GetInstance()
			local var_48_1 = var_0.ShowMsgBox
			local var_48_2 = {
				yesText = "text_confirm",
				hideNo = true,
				content = ""
			}

			MSGBOX_TYPE_SINGLE_ITEM = var_3_10004
			var_48_2.type = var_3_10004

			local var_48_3 = {}

			DROP_TYPE_STRATEGY = var_3_10005
			var_48_3.type = var_3_10005
			var_48_3.id = var_47_0.id
			var_48_3.cfg = var_47_0
			var_48_2.drop = var_48_3

			var_48_1(var_48_0, var_48_2)

			return
		end

		SFX_PANEL = var_2_10009

		var_4(var_47_1, var_47_2, var_47_3, var_2_10009)

		return
	end)

	return
end

function var_0_1.TryPlayGuide(arg_49_0)
	if #arg_49_0:GetActiveStgs() > 0 then
		WorldGuider = var_1

		local var_49_0 = var_1.GetInstance()

		var_1.PlayGuide(var_49_0, "WorldG200")
	end

	return
end

function var_0_1.willExit(arg_50_0)
	if arg_50_0._currentForm == var_0_1.FORM_EDIT then
		arg_50_0.contextData.editingFleetVO = arg_50_0._currentFleetVO
	end

	local var_50_0 = arg_50_0._formationLogic

	var_1.Destroy(var_50_0)

	if arg_50_0.tweens then
		cancelTweens = var_1

		var_1(arg_50_0.tweens)
	end

	pg = var_1

	local var_50_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_50_1, arg_50_0._tf)

	return
end

return var_0_1
