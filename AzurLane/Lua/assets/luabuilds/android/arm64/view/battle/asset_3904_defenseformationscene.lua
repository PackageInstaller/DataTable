class = var_0_10000

local var_0_0 = "DefenseFormationScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.RADIUS = 60
var_0_1.LONGPRESS_Y = 30
math = var_1
var_0_1.INTERVAL = var_1.pi / 2 / 6
var_0_1.MAX_FLEET_NUM = 6
var_0_1.MAX_SHIPP_NUM = 5
var_0_1.TOGGLE_DETAIL = "_detailToggle"
var_0_1.TOGGLE_FORMATION = "_formationToggle"
var_0_1.BUFF_TYEP = {
	blue = "blue",
	pink = "pink",
	cyan = "cyan"
}

function var_0_1.getUIName(arg_1_0)
	return "ExerciseFormationUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0.eventTriggers = {}

	local var_2_0 = arg_2_0._tf

	arg_2_0._blurLayer = var_1.Find(var_2_0, "blur_panel")

	local var_2_1 = arg_2_0._blurLayer

	arg_2_0.backBtn = var_1.Find(var_2_1, "top/back_btn")

	local var_2_2 = arg_2_0._blurLayer

	arg_2_0._bottomPanel = var_1.Find(var_2_2, "bottom")

	local var_2_3 = arg_2_0._bottomPanel

	arg_2_0._detailToggle = var_1.Find(var_2_3, "toggle_list/detail_toggle")

	local var_2_4 = arg_2_0._bottomPanel

	arg_2_0._formationToggle = var_1.Find(var_2_4, "toggle_list/formation_toggle")

	local var_2_5 = arg_2_0._tf

	arg_2_0._starTpl = var_1.Find(var_2_5, "star_tpl")

	local var_2_6 = arg_2_0._tf

	arg_2_0._heroInfoTpl = var_1.Find(var_2_6, "heroInfo")
	arg_2_0._gridTFs = {
		vanguard = {},
		main = {}
	}

	local var_2_7 = arg_2_0.rtAdapr

	arg_2_0._gridFrame = var_1.Find(var_2_7, "GridFrame")

	for iter_2_0 = 1, 3 do
		local var_2_8 = arg_2_0._gridTFs

		TeamType = var_1_10006

		local var_2_9 = var_2_8[var_1_10006.Main]
		local var_2_10 = arg_2_0._gridFrame

		var_2_9[iter_2_0] = var_1_10006.Find(var_2_10, "main_" .. iter_2_0)

		local var_2_11 = arg_2_0._gridTFs

		TeamType = var_1_10006

		local var_2_12 = var_2_11[var_1_10006.Vanguard]
		local var_2_13 = arg_2_0._gridFrame

		var_2_12[iter_2_0] = var_1_10006.Find(var_2_13, "vanguard_" .. iter_2_0)
	end

	local var_2_14 = arg_2_0.rtAdapr

	arg_2_0._heroContainer = var_1.Find(var_2_14, "HeroContainer")

	local var_2_15 = arg_2_0._blurLayer

	arg_2_0._fleetInfo = var_1.Find(var_2_15, "fleet_info")

	local var_2_16 = arg_2_0._fleetInfo

	arg_2_0._fleetNameText = var_1.Find(var_2_16, "fleet_name/Text")

	local var_2_17 = arg_2_0.rtAdapr

	arg_2_0._buffPanel = var_1.Find(var_2_17, "buff_list")

	local var_2_18 = arg_2_0._buffPanel

	arg_2_0._buffGroup = var_1.Find(var_2_18, "buff_group")
	arg_2_0._buffModel = arg_2_0:getTpl("buff_model", arg_2_0._buffPanel)

	local var_2_19 = arg_2_0._blurLayer

	arg_2_0._propertyFrame = var_1.Find(var_2_19, "property_frame")

	local var_2_20 = arg_2_0._propertyFrame

	arg_2_0._cannonPower = var_1.Find(var_2_20, "cannon/Text")

	local var_2_21 = arg_2_0._propertyFrame

	arg_2_0._torpedoPower = var_1.Find(var_2_21, "torpedo/Text")

	local var_2_22 = arg_2_0._propertyFrame

	arg_2_0._AAPower = var_1.Find(var_2_22, "antiaircraft/Text")

	local var_2_23 = arg_2_0._propertyFrame

	arg_2_0._airPower = var_1.Find(var_2_23, "air/Text")

	local var_2_24 = arg_2_0._propertyFrame

	arg_2_0._cost = var_1.Find(var_2_24, "cost/Text")

	local var_2_25 = arg_2_0.rtAdapr

	arg_2_0._mainGS = var_1.Find(var_2_25, "gear_score/main/Text")

	local var_2_26 = arg_2_0.rtAdapr

	arg_2_0._vanguardGS = var_1.Find(var_2_26, "gear_score/vanguard/Text")

	local var_2_27 = arg_2_0._propertyFrame

	arg_2_0._airDominanceFrame = var_1.Find(var_2_27, "ac")

	if arg_2_0._airDominanceFrame then
		setActive = var_1

		var_1(arg_2_0._airDominanceFrame, false)
	end

	local var_2_28 = arg_2_0._blurLayer

	arg_2_0._attrFrame = var_1.Find(var_2_28, "attr_frame")

	local var_2_29 = arg_2_0._tf

	arg_2_0._cardTpl = var_1.Find(var_2_29, "RectShipCardTpl")
	arg_2_0._cards = {}

	local var_2_30 = arg_2_0._cards

	TeamType = var_2
	var_2_30[var_2.Main] = {}

	local var_2_31 = arg_2_0._cards

	TeamType = var_2
	var_2_31[var_2.Vanguard] = {}
	setActive = var_2_31

	var_2_31(arg_2_0._attrFrame, false)

	setActive = var_2_31

	var_2_31(arg_2_0._cardTpl, false)

	setAnchoredPosition = var_2_31

	var_2_31(arg_2_0._bottomPanel, {
		y = -90
	})

	BaseFormation = var_2_31
	arg_2_0._formationLogic = var_2_31.New(arg_2_0._tf, arg_2_0._heroContainer, arg_2_0._heroInfoTpl, arg_2_0._gridTFs)

	arg_2_0:Register()

	return
end

function var_0_1.Register(arg_3_0)
	local var_3_0 = arg_3_0._formationLogic

	var_1.AddHeroInfoModify(var_3_0, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_1:getConfigTable()

		pg = var_2_10003

		local var_4_1 = var_2_10003.ship_data_template[arg_4_1.configId]
		local var_4_2 = arg_4_0:Find("info")
		local var_4_3 = var_4.Find(var_4_2, "stars")
		local var_4_4 = arg_4_1:getStar()

		for iter_4_0 = 1, var_4_4 do
			cloneTplTo = var_2_10011

			var_2_10011(arg_3_0._starTpl, var_4_3)
		end

		GetSpriteFromAtlas = var_7

		local var_4_5 = "shiptype"

		shipType2print = iter_4_0

		if not var_7(var_4_5, iter_4_0(arg_4_1:getShipType())) then
			warning = var_8

			var_8("找不到船形, shipConfigId: " .. arg_4_1.configId)
		end

		setImageSprite = var_8

		var_8(var_4:Find("type"), var_7, true)

		setText = var_8

		var_8(var_4:Find("frame/lv_contain/lv"), arg_4_1.level)

		return
	end)

	local var_3_1 = arg_3_0._formationLogic

	var_1.AddLongPress(var_3_1, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_3_0
		local var_5_1 = var_3.emit

		DefenseFormationMedator = var_2_10006

		var_5_1(var_5_0, var_2_10006.OPEN_SHIP_INFO, arg_5_1.id, arg_5_2, var_0_1.TOGGLE_FORMATION)

		pg = var_5_1

		local var_5_2 = var_5_1.CriMgr.GetInstance()
		local var_5_3 = var_3.PlaySoundEffect_V3

		SFX_PANEL = var_6

		var_5_3(var_5_2, var_6)

		return
	end)

	local var_3_2 = arg_3_0._formationLogic

	var_1.AddClick(var_3_2, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_3_0
		local var_6_1 = var_2.emit

		DefenseFormationMedator = var_2_10005

		var_6_1(var_6_0, var_2_10005.CHANGE_FLEET_SHIP, arg_6_0, arg_6_1)

		pg = var_6_1

		local var_6_2 = var_6_1.CriMgr.GetInstance()
		local var_6_3 = var_2.PlaySoundEffect_V3

		SFX_PANEL = var_5

		var_6_3(var_6_2, var_5)

		return
	end)

	local var_3_3 = arg_3_0._formationLogic

	var_1.AddBeginDrag(var_3_3, function(arg_7_0)
		local var_7_0 = arg_7_0:Find("info")

		setButtonEnabled = var_2_10002

		var_2_10002(arg_3_0.backBtn, false)

		setToggleEnabled = var_2_10002

		var_2_10002(arg_3_0._detailToggle, false)

		SetActive = var_2_10002

		var_2_10002(var_7_0, false)

		return
	end)

	local var_3_4 = arg_3_0._formationLogic

	var_1.AddEndDrag(var_3_4, function(arg_8_0)
		local var_8_0 = arg_8_0:Find("info")

		setButtonEnabled = var_2_10002

		var_2_10002(arg_3_0.backBtn, true)

		setToggleEnabled = var_2_10002

		var_2_10002(arg_3_0._detailToggle, true)

		SetActive = var_2_10002

		var_2_10002(var_8_0, true)

		return
	end)

	local var_3_5 = arg_3_0._formationLogic

	var_1.AddShiftOnly(var_3_5, function(arg_9_0)
		local var_9_0 = arg_3_0
		local var_9_1 = var_1.emit

		DefenseFormationMedator = var_2_10004

		var_9_1(var_9_0, var_2_10004.CHANGE_FLEET_SHIPS_ORDER, arg_9_0)

		return
	end)

	local var_3_6 = arg_3_0._formationLogic

	var_1.AddRemoveShip(var_3_6, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_3_0
		local var_10_1 = var_2.emit

		DefenseFormationMedator = var_2_10005

		var_10_1(var_10_0, var_2_10005.REMOVE_SHIP, arg_10_0, arg_10_1)

		return
	end)

	local function var_3_7(arg_11_0)
		pg = var_2_10001

		local var_11_0 = var_2_10001.MsgboxMgr.GetInstance()
		local var_11_1 = var_1.ShowMsgBox
		local var_11_2 = {}

		i18n = var_2_10005
		var_11_2.content = var_2_10005("defense_formation_tip_npc")
		var_11_2.onYes = arg_11_0
		var_11_2.onNo = arg_11_0

		var_11_1(var_11_0, var_11_2)

		return
	end

	local var_3_8 = arg_3_0._formationLogic

	var_2.AddCheckRemove(var_3_8, function(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
		local var_12_1

		if not arg_12_3:canRemove(arg_12_2) then
			pg = var_12_1

			local var_12_0 = var_12_1.TipsMgr.GetInstance()

			var_12_1 = var_12_1.ShowTips
			i18n = var_8

			local var_12_2 = "ship_formationUI_removeError_onlyShip"
			local var_12_3 = arg_12_2
			local var_12_4 = arg_12_2.getName(var_12_3)
			local var_12_5 = ""

			Fleet = var_12_3

			var_12_1(var_12_0, var_8(var_12_2, var_12_4, var_12_5, var_12_3.C_TEAM_NAME[arg_12_4]))
			arg_12_0()

			goto label_12_0
		end

		table = var_12_1

		if var_12_1.getCount(arg_12_3.mainShips) == 1 then
			TeamType = var_12_7

			if arg_12_4 ~= var_12_7.Main then
				table = var_12_7

				do
					local var_12_7

					if var_12_7.getCount(arg_12_3.vanguardShips) == 1 then
						TeamType = var_12_7

						if arg_12_4 == var_12_7.Vanguard then
							pg = var_12_7

							local var_12_6 = var_12_7.MsgboxMgr.GetInstance()

							var_12_7 = var_12_7.ShowMsgBox

							local var_12_8 = {}

							i18n = var_2_10009
							var_12_8.content = var_2_10009("exercise_clear_fleet_tip")

							function var_12_8.onYes()
								getProxy = var_3_10000
								FleetProxy = var_3_10002

								local var_13_0 = var_3_10000(var_3_10002)
								local var_13_1 = var_0.getFleetById(var_13_0, 1)

								if not var_0.ExistActNpcShip(var_13_1) then
									arg_12_1()
								else
									var_3_7(arg_12_0)
								end

								return
							end

							var_12_8.onNo = arg_12_0

							var_12_7(var_12_6, var_12_8)

							goto label_12_0
						end
					end

					pg = var_12_7

					local var_12_9 = var_12_7.MsgboxMgr.GetInstance()
					local var_12_10 = var_5.ShowMsgBox
					local var_12_11 = {
						hideNo = false,
						zIndex = -30
					}

					i18n = var_2_10009
					var_12_11.content = var_2_10009("ship_formationUI_quest_remove", arg_12_2:getName())
					var_12_11.onYes = arg_12_1
					var_12_11.onNo = arg_12_0

					var_12_10(var_12_9, var_12_11)
				end

				::label_12_0::

				return
			end
		end
	end)

	local var_3_9 = arg_3_0._formationLogic

	var_2.AddGridTipClick(var_3_9, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_3_0
		local var_14_1 = var_2.emit

		DefenseFormationMedator = var_2_10005

		var_14_1(var_14_0, var_2_10005.CHANGE_FLEET_SHIP, nil, arg_14_0)

		return
	end)

	return
end

function var_0_1.setShips(arg_15_0, arg_15_1)
	arg_15_0.shipVOs = arg_15_1

	local var_15_0 = arg_15_0._formationLogic

	var_2.SetShipVOs(var_15_0, arg_15_1)

	return
end

function var_0_1.SetFleet(arg_16_0, arg_16_1)
	arg_16_0._currentFleetVO = arg_16_1

	local var_16_0 = arg_16_0._formationLogic

	var_2.SetFleetVO(var_16_0, arg_16_1)

	return
end

function var_0_1.UpdateFleetView(arg_17_0, arg_17_1)
	arg_17_0:displayFleetInfo()

	local var_17_0 = arg_17_0._formationLogic
	local var_17_1 = var_2.ResetGrid

	TeamType = var_1_10005

	var_17_1(var_17_0, var_1_10005.Vanguard)

	local var_17_2 = arg_17_0._formationLogic
	local var_17_3 = var_2.ResetGrid

	TeamType = var_5

	var_17_3(var_17_2, var_5.Main)
	arg_17_0:resetFormationComponent()
	arg_17_0:updateAttrFrame()

	if arg_17_1 then
		local var_17_4 = arg_17_0._formationLogic

		var_2.LoadAllCharacter(var_17_4)
	else
		local var_17_5 = arg_17_0._formationLogic

		var_2.SetAllCharacterPos(var_17_5)
	end

	return
end

function var_0_1.SetFleetNameLabel(arg_18_0)
	setText = var_1_10001

	local var_18_0 = arg_18_0._fleetNameText

	i18n = var_1_10004

	var_1_10001(var_18_0, var_1_10004("exercise_formation_title"))

	return
end

function var_0_1.didEnter(arg_19_0)
	onButton = var_1_10001

	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.backBtn

	local function var_19_2()
		if arg_19_0._currentDragDelegate then
			LuaHelper = var_0

			var_0.triggerEndDrag(arg_19_0._currentDragDelegate)
		end

		if arg_19_0._attrFrame.gameObject.activeSelf then
			triggerToggle = var_0

			var_0(arg_19_0._formationToggle, true)
		else
			local function var_20_0()
				local var_21_0 = arg_19_0

				var_0.emit(var_21_0, var_0_1.ON_BACK)

				return
			end

			local var_20_1 = arg_19_0
			local var_20_2 = var_1.emit

			DefenseFormationMedator = var_2_10004

			var_20_2(var_20_1, var_2_10004.COMMIT_FLEET, var_20_0)
		end

		return
	end

	SOUND_BACK = var_1_10006

	var_1_10001(var_19_0, var_19_1, var_19_2, var_1_10006)

	onToggle = var_1_10001

	local var_19_3 = arg_19_0
	local var_19_4 = arg_19_0._detailToggle

	local function var_19_5(arg_22_0)
		if arg_19_0._currentDragDelegate then
			LuaHelper = var_1

			var_1.triggerEndDrag(arg_19_0._currentDragDelegate)
		end

		if arg_22_0 then
			local var_22_0 = arg_19_0

			var_1.displayAttrFrame(var_22_0)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_19_3, var_19_4, var_19_5, var_1_10006)

	onToggle = var_1_10001

	local var_19_6 = arg_19_0
	local var_19_7 = arg_19_0._formationToggle

	local function var_19_8(arg_23_0)
		if arg_19_0._currentDragDelegate then
			LuaHelper = var_1

			var_1.triggerEndDrag(arg_19_0._currentDragDelegate)
		end

		if arg_23_0 then
			local var_23_0 = arg_19_0

			var_1.hideAttrFrame(var_23_0)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_19_6, var_19_7, var_19_8, var_1_10006)

	onButton = var_1_10001

	local var_19_9 = arg_19_0
	local var_19_10 = arg_19_0._attrFrame

	local function var_19_11()
		triggerToggle = var_2_10000

		var_2_10000(arg_19_0._formationToggle, true)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_19_9, var_19_10, var_19_11, var_1_10006)
	arg_19_0:UpdateFleetView(true)

	if arg_19_0.contextData.toggle ~= nil then
		triggerToggle = var_1

		var_1(arg_19_0[arg_19_0.contextData.toggle], true)
	end

	shiftPanel = var_1

	var_1(arg_19_0._bottomPanel, nil, 0, nil, 0.5, true, true)

	return
end

function var_0_1.resetFormationComponent(arg_25_0)
	local var_25_0 = {}

	removeAllChildren = var_1_10002

	var_1_10002(arg_25_0._buffGroup)

	ipairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(var_25_0) do
		cloneTplTo = var_1_10007
		var_1_10007 = var_1_10007(arg_25_0._buffModel, arg_25_0._buffGroup)
		tf = var_1_10008

		local var_25_1 = var_1_10008(var_1_10007)

		var_1_10008.SetAsFirstSibling(var_25_1)

		SetActive = var_1_10008

		var_1_10008(var_1_10007:Find("dot_list/" .. iter_25_1.type), true)

		local var_25_2 = var_1_10007:Find("buff_describe")

		var_1_10008 = var_1_10008.GetComponent
		typeof = var_11
		Text = var_13
		var_1_10008 = var_1_10008(var_25_2, var_11(var_13))
		var_1_10008.text = iter_25_1.describe
	end

	SetActive = var_2

	local var_25_3 = arg_25_0._gridTFs.main[1]
	local var_25_4 = var_4.Find(var_25_3, "flag")
	local var_25_5 = arg_25_0._currentFleetVO
	local var_25_6 = var_5.getTeamByName

	TeamType = var_1_10008

	var_2(var_25_4, #var_25_6(var_25_5, var_1_10008.Main) ~= 0)

	return
end

function var_0_1.shiftCard(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	if #arg_26_0._cards[arg_26_3] > 0 then
		var_4[arg_26_1], var_4[arg_26_2] = var_4[arg_26_2], var_4[arg_26_1]
	end

	arg_26_0._shiftIndex = arg_26_2

	return
end

function var_0_1.sortCardSiblingIndex(arg_27_0)
	local var_27_0 = arg_27_0._cards

	TeamType = var_1_10002

	local var_27_1 = var_27_0[var_1_10002.Main]
	local var_27_2 = arg_27_0._cards

	TeamType = var_1_10003

	local var_27_3 = var_27_2[var_1_10003.Vanguard]

	if #var_27_1 > 0 or #var_27_3 > 0 then
		for iter_27_0 = 1, #var_27_1 do
			local var_27_4 = var_27_1[iter_27_0].tr

			var_7.SetSiblingIndex(var_27_4, iter_27_0)
		end

		for iter_27_1 = 1, #var_27_3 do
			local var_27_5 = var_27_3[iter_27_1].tr

			var_7.SetSiblingIndex(var_27_5, iter_27_1)
		end
	end

	return
end

function var_0_1.displayFleetInfo(arg_28_0)
	local var_28_0 = arg_28_0._currentFleetVO
	local var_28_1 = var_1.GetPropertiesSum(var_28_0)
	local var_28_2 = arg_28_0._currentFleetVO
	local var_28_3 = var_2.GetGearScoreSum

	TeamType = var_1_10005

	local var_28_4 = var_28_3(var_28_2, var_1_10005.Vanguard)
	local var_28_5 = arg_28_0._currentFleetVO
	local var_28_6 = var_3.GetGearScoreSum

	TeamType = var_1_10006

	local var_28_7 = var_28_6(var_28_5, var_1_10006.Main)
	local var_28_8 = arg_28_0._currentFleetVO
	local var_28_9 = var_4.GetCostSum(var_28_8)

	arg_28_0.tweenNumText(arg_28_0._cannonPower, var_28_1.cannon)
	arg_28_0.tweenNumText(arg_28_0._torpedoPower, var_28_1.torpedo)
	arg_28_0.tweenNumText(arg_28_0._AAPower, var_28_1.antiAir)
	arg_28_0.tweenNumText(arg_28_0._airPower, var_28_1.air)
	arg_28_0.tweenNumText(arg_28_0._cost, var_28_9.oil)
	arg_28_0.tweenNumText(arg_28_0._vanguardGS, var_28_4)
	arg_28_0.tweenNumText(arg_28_0._mainGS, var_28_7)

	setActive = var_5

	local var_28_10 = arg_28_0.rtAdapr

	var_5(var_7.Find(var_28_10, "gear_score"), true)
	arg_28_0:SetFleetNameLabel()

	return
end

function var_0_1.hideAttrFrame(arg_29_0)
	SetActive = var_1_10001

	var_1_10001(arg_29_0._attrFrame, false)

	pg = var_1_10001

	local var_29_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_29_0, arg_29_0._blurLayer, arg_29_0._tf)

	return
end

function var_0_1.displayAttrFrame(arg_30_0)
	pg = var_1_10001

	local var_30_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_30_0, arg_30_0._blurLayer)

	SetActive = var_1

	var_1(arg_30_0._attrFrame, true)
	arg_30_0:initAttrFrame()

	return
end

function var_0_1.initAttrFrame(arg_31_0)
	local var_31_0 = {}

	TeamType = var_1_10002
	var_31_0[var_1_10002.Main] = "main"
	TeamType = var_2
	var_31_0[var_2.Vanguard] = "vanguard"

	local var_31_1 = {}

	TeamType = var_3
	var_31_1[var_3.Main] = arg_31_0._currentFleetVO.mainShips
	TeamType = var_3
	var_31_1[var_3.Vanguard] = arg_31_0._currentFleetVO.vanguardShips

	local var_31_2 = false

	pairs = var_4

	for iter_31_0, iter_31_1 in var_4(var_31_1) do
		if #arg_31_0._cards[iter_31_0] == 0 then
			local var_31_3 = arg_31_0._attrFrame
			local var_31_4 = var_10.Find(var_31_3, var_31_0[iter_31_0] .. "/list")

			for iter_31_2 = 1, 3 do
				cloneTplTo = var_1_10015
				var_1_10015 = var_1_10015(arg_31_0._cardTpl, var_31_4).gameObject
				table = var_1_10016
				var_1_10016 = var_1_10016.insert

				local var_31_5 = var_9

				FormationCard = var_1_10019

				var_1_10016(var_31_5, var_1_10019.New(var_1_10015))
			end

			var_31_2 = true
		end
	end

	if var_31_2 then
		arg_31_0:updateAttrFrame()
	end

	return
end

function var_0_1.updateAttrFrame(arg_32_0)
	local var_32_0 = {}

	TeamType = var_1_10002
	var_32_0[var_1_10002.Main] = arg_32_0._currentFleetVO.mainShips
	TeamType = var_2
	var_32_0[var_2.Vanguard] = arg_32_0._currentFleetVO.vanguardShips
	pairs = var_2

	for iter_32_0, iter_32_1 in var_2(var_32_0) do
		if #arg_32_0._cards[iter_32_0] > 0 then
			for iter_32_2 = 1, 3 do
				if iter_32_2 <= #iter_32_1 then
					local var_32_1 = arg_32_0.shipVOs[iter_32_1[iter_32_2]]
					local var_32_2 = var_1_10007[iter_32_2]

					var_13.update(var_32_2, var_32_1)

					local var_32_3 = var_1_10007[iter_32_2]

					var_13.updateProps(var_32_3, arg_32_0:getCardAttrProps(var_32_1))
				else
					local var_32_4 = var_1_10007[iter_32_2]

					var_12.update(var_32_4, nil)
				end

				arg_32_0:attachOnCardButton(var_1_10007[iter_32_2], iter_32_0)
			end
		end
	end

	arg_32_0:updateUltimateTitle()

	setActive = var_2

	local var_32_5 = arg_32_0._attrFrame
	local var_32_6 = var_4.Find

	TeamType = var_1_10007

	var_2(var_32_6(var_32_5, var_1_10007.Submarine), false)

	return
end

function var_0_1.updateUltimateTitle(arg_33_0)
	local var_33_0 = arg_33_0._cards

	TeamType = var_1_10002

	local var_33_1 = #var_33_0[var_1_10002.Main]

	if 0 < var_33_1 then
		for iter_33_0 = 1, #var_1 do
			setActive = var_1_10006

			var_1_10006(var_1[iter_33_0].shipState, iter_33_0 == 1)
		end
	end

	local var_33_2 = arg_33_0._cards

	TeamType = var_3

	if #var_33_2[var_3.Vanguard] > 0 then
		for iter_33_1 = 1, #var_2 do
			setActive = var_1_10007

			var_1_10007(var_2[iter_33_1].shipState, false)
		end
	end

	return
end

function var_0_1.getCardAttrProps(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1:getProperties()
	local var_34_1 = arg_34_1:getShipCombatPower()
	local var_34_2 = arg_34_1:getBattleTotalExpend()
	local var_34_3 = {}
	local var_34_4 = {}

	i18n = var_1_10007
	var_34_4[1] = var_1_10007("word_attr_durability")
	tostring = var_7
	math = var_9
	var_34_4[2] = var_7(var_9.floor(var_34_0.durability))
	var_34_3[1] = var_34_4

	local var_34_5 = {}

	i18n = var_7
	var_34_5[1] = var_7("word_attr_luck")

	local var_34_6 = ""

	tostring = var_1_10008
	math = var_1_10010
	var_34_5[2] = var_34_6 .. var_1_10008(var_1_10010.floor(var_34_2))
	var_34_3[2] = var_34_5

	local var_34_7 = {}

	i18n = var_7
	var_34_7[1] = var_7("word_synthesize_power")
	var_34_7[2] = "<color=#ffff00>" .. var_34_1 .. "</color>"
	var_34_3[3] = var_34_7

	return var_34_3
end

function var_0_1.attachOnCardButton(arg_35_0, arg_35_1, arg_35_2)
	GetOrAddComponent = var_1_10003

	local var_35_0 = var_1_10003(arg_35_1.go, "EventTriggerListener")

	arg_35_0.eventTriggers[var_35_0] = true

	var_35_0:RemovePointClickFunc()
	var_35_0:RemoveBeginDragFunc()
	var_35_0:RemoveDragFunc()
	var_35_0:RemoveDragEndFunc()
	var_35_0:AddPointClickFunc(function(arg_36_0, arg_36_1)
		if not arg_35_0.carddrag and arg_36_0 == arg_35_1.go then
			local var_36_1

			if arg_35_1.shipVO then
				local var_36_0 = arg_35_0

				var_36_1 = var_36_1.emit
				DefenseFormationMedator = var_2_10005

				var_36_1(var_36_0, var_2_10005.OPEN_SHIP_INFO, arg_35_1.shipVO.id, arg_35_0._currentFleetVO, var_0_1.TOGGLE_DETAIL)
			else
				local var_36_2 = arg_35_0

				var_36_1 = var_36_1.emit
				DefenseFormationMedator = var_2_10005

				var_36_1(var_36_2, var_2_10005.CHANGE_FLEET_SHIP, arg_35_1.shipVO, arg_35_2)
			end

			pg = var_36_1

			local var_36_3 = var_36_1.CriMgr.GetInstance()
			local var_36_4 = var_2.PlaySoundEffect_V3

			SFX_PANEL = var_2_10005

			var_36_4(var_36_3, var_2_10005)
		end

		return
	end)

	if arg_35_1.shipVO then
		local var_35_1 = arg_35_0._cards[arg_35_2]
		local var_35_2 = arg_35_1.tr.parent
		local var_35_3 = var_5.GetComponent(var_35_2, "ContentSizeFitter")
		local var_35_4 = arg_35_1.tr.parent
		local var_35_5 = var_6.GetComponent(var_35_4, "HorizontalLayoutGroup")
		local var_35_6 = arg_35_1.tr.rect.width * 0.5
		local var_35_7
		local var_35_8 = 0
		local var_35_9 = {}

		local function var_35_10()
			for iter_37_0 = 1, #var_35_1 do
				if var_35_1[iter_37_0] ~= arg_35_1 then
					local var_37_0 = var_35_1[iter_37_0].tr
					local var_37_1 = var_35_1[iter_37_0].tr.anchoredPosition * 0.5

					Vector2 = var_2_10006
					var_37_0.anchoredPosition = var_37_1 + var_2_10006(var_35_9[iter_37_0].x, var_35_9[iter_37_0].y) * 0.5
				end
			end

			if var_35_7 then
				local var_37_2 = var_35_8

				Time = var_1

				if var_37_2 <= var_1.realtimeSinceStartup then
					local var_37_3 = var_35_0

					var_0.OnDrag(var_37_3, var_35_7)

					var_35_7 = nil
				end
			end

			return
		end

		local function var_35_11()
			for iter_38_0 = 1, #var_35_1 do
				var_35_1[iter_38_0].tr.anchoredPosition = var_35_9[iter_38_0]
			end

			return
		end

		Timer = var_1_10013

		local var_35_12 = var_1_10013.New(var_35_10, 0.03333333333333333, -1)

		var_35_0:AddBeginDragFunc(function()
			if arg_35_0.carddrag then
				return
			end

			arg_35_0._currentDragDelegate = var_35_0
			arg_35_0.carddrag = arg_35_1
			var_35_3.enabled = false
			var_35_5.enabled = false

			local var_39_0 = arg_35_1.tr

			var_0.SetSiblingIndex(var_39_0, #var_35_1)

			for iter_39_0 = 1, #var_35_1 do
				if var_35_1[iter_39_0] == arg_35_1 then
					arg_35_0._shiftIndex = iter_39_0
				end

				var_35_9[iter_39_0] = var_35_1[iter_39_0].tr.anchoredPosition
			end

			local var_39_1 = var_35_12

			var_0.Start(var_39_1)

			LeanTween = var_0

			local var_39_2 = var_0.scale
			local var_39_3 = arg_35_1.paintingTr

			Vector3 = iter_39_0

			var_39_2(var_39_3, iter_39_0(1.1, 1.1, 0), 0.3)

			return
		end)
		var_35_0:AddDragFunc(function(arg_40_0, arg_40_1)
			if arg_35_0.carddrag ~= arg_35_1 then
				return
			end

			local var_40_0 = arg_35_1.tr.localPosition
			local var_40_1 = arg_35_0

			var_40_0.x = var_3.change2ScrPos(var_40_1, arg_35_1.tr.parent, arg_40_1.position).x
			arg_35_1.tr.localPosition = var_40_0

			local var_40_2 = var_35_8

			Time = var_2_10004

			if var_40_2 > var_2_10004.realtimeSinceStartup then
				var_35_7 = arg_40_1

				return
			end

			local var_40_3 = 1

			for iter_40_0 = 1, #var_35_1 do
				if var_35_1[iter_40_0] ~= arg_35_1 and var_35_1[iter_40_0].shipVO and arg_35_1.tr.localPosition.x > var_35_1[iter_40_0].tr.localPosition.x + (var_40_3 < arg_35_0._shiftIndex and 1.1 or -1.1) * var_35_6 then
					var_40_3 = var_40_3 + 1
				end
			end

			if arg_35_0._shiftIndex ~= var_40_3 then
				local var_40_4 = arg_35_0._formationLogic

				var_4.Shift(var_40_4, arg_35_0._shiftIndex, var_40_3, arg_35_2)

				local var_40_5 = arg_35_0

				var_4.shiftCard(var_40_5, arg_35_0._shiftIndex, var_40_3, arg_35_2)

				Time = var_4
				var_35_8 = var_4.realtimeSinceStartup + 0.15
			end

			return
		end)
		var_35_0:AddDragEndFunc(function(arg_41_0, arg_41_1)
			if arg_35_0.carddrag ~= arg_35_1 then
				return
			end

			arg_35_0._currentDragDelegate = nil

			local var_41_0 = var_35_0

			var_41_0.enabled = false
			math = var_41_0

			local var_41_1 = var_41_0.min

			math = var_2_10004

			local var_41_2 = var_41_1(var_2_10004.abs(arg_35_1.tr.anchoredPosition.x - var_35_9[arg_35_0._shiftIndex].x) / 200, 1) * 0.3

			LeanTween = var_3

			local var_41_3 = var_3.value(arg_35_1.go, arg_35_1.tr.anchoredPosition.x, var_35_9[arg_35_0._shiftIndex].x, var_41_2)
			local var_41_4 = var_3.setEase

			LeanTweenType = var_6

			local var_41_5 = var_41_4(var_41_3, var_6.easeOutCubic)
			local var_41_6 = var_3.setOnUpdate

			System = var_6

			local var_41_7 = var_41_6(var_41_5, var_6.Action_float(function(arg_42_0)
				local var_42_0 = arg_35_1.tr.anchoredPosition

				var_42_0.x = arg_42_0
				arg_35_1.tr.anchoredPosition = var_42_0

				return
			end))
			local var_41_8 = var_3.setOnComplete

			System = var_6

			var_41_8(var_41_7, var_6.Action(function()
				var_35_11()

				var_35_3.enabled = true
				var_35_5.enabled = true
				arg_35_0._shiftIndex = nil

				local var_43_0 = var_35_12

				var_0.Stop(var_43_0)

				local var_43_1 = arg_35_0

				var_0.updateUltimateTitle(var_43_1)

				local var_43_2 = arg_35_0._formationLogic

				var_0.SortSiblingIndex(var_43_2)

				local var_43_3 = arg_35_0

				var_0.sortCardSiblingIndex(var_43_3)

				local var_43_4 = arg_35_0
				local var_43_5 = var_0.emit

				DefenseFormationMedator = var_3_10003

				var_43_5(var_43_4, var_3_10003.CHANGE_FLEET_SHIPS_ORDER, arg_35_0._currentFleetVO)

				LeanTween = var_43_5

				local var_43_6 = var_43_5.scale
				local var_43_7 = arg_35_1.paintingTr

				Vector3 = var_3

				var_43_6(var_43_7, var_3(1, 1, 0), 0.3)

				var_35_0.enabled = true
				arg_35_0.carddrag = nil

				return
			end))

			return
		end)
	end

	return
end

function var_0_1.change2ScrPos(arg_44_0, arg_44_1, arg_44_2)
	GameObject = var_1_10003

	local var_44_0 = var_1_10003.Find("OverlayCamera")
	local var_44_1 = var_3.GetComponent(var_44_0, "Camera")

	LuaHelper = var_1_10004

	return (var_1_10004.ScreenToLocal(arg_44_1, arg_44_2, var_44_1))
end

function var_0_1.tweenNumText(arg_45_0, arg_45_1, arg_45_2)
	LeanTween = var_1_10003

	local var_45_0 = var_1_10003.value

	go = var_1_10005

	local var_45_1 = var_1_10005(arg_45_0)
	local var_45_2 = 0

	math = var_7

	local var_45_3 = var_45_0(var_45_1, var_45_2, var_7.floor(arg_45_1), arg_45_2 or 0.7)
	local var_45_4 = var_3.setOnUpdate

	System = var_45_2

	var_45_4(var_45_3, var_45_2.Action_float(function(arg_46_0)
		setText = var_2_10001

		local var_46_0 = arg_45_0

		math = var_2_10004

		var_2_10001(var_46_0, var_2_10004.floor(arg_46_0))

		return
	end))

	return
end

function var_0_1.GetFleetCount(arg_47_0)
	return 1
end

function var_0_1.recyclePainting(arg_48_0)
	pairs = var_1_10001

	for iter_48_0, iter_48_1 in var_1_10001(arg_48_0._cards) do
		ipairs = var_1_10006

		for iter_48_2, iter_48_3 in var_1_10006(iter_48_1) do
			iter_48_3:clear()
		end
	end

	return
end

function var_0_1.willExit(arg_49_0)
	if arg_49_0.eventTriggers then
		pairs = var_1

		for iter_49_0, iter_49_1 in var_1(arg_49_0.eventTriggers) do
			ClearEventTrigger = var_1_10006

			var_1_10006(iter_49_0)
		end

		arg_49_0.eventTriggers = nil
	end

	if arg_49_0._attrFrame.gameObject.activeSelf then
		pg = var_1

		local var_49_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_49_0, arg_49_0._blurLayer, arg_49_0._tf)
	end

	pg = var_1

	local var_49_1 = var_1.TimeMgr.GetInstance()

	var_1.RemoveTimer(var_49_1, arg_49_0.ActiveToggletimer1)

	arg_49_0.ActiveToggletimer1 = nil
	pg = var_1

	local var_49_2 = var_1.TimeMgr.GetInstance()

	var_1.RemoveTimer(var_49_2, arg_49_0.ActiveToggletimer)

	arg_49_0.ActiveToggletimer = nil

	local var_49_3 = arg_49_0._formationLogic

	var_1.Destroy(var_49_3)
	arg_49_0:recyclePainting()

	return
end

return var_0_1
