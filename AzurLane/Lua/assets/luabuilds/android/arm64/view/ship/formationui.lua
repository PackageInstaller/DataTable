class = var_0_10000

local var_0_0 = "FormationUI"

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
var_0_1.TeamNum = {
	"FIRST",
	"SECOND",
	"THIRD",
	"FOURTH",
	"FIFTH",
	"SIXTH"
}

function var_0_1.getUIName(arg_1_0)
	return "FormationUI"
end

function var_0_1.preloadUIList(arg_2_0)
	return {
		arg_2_0:getUIName(),
		"CommanderFormationUI"
	}
end

function var_0_1.setPlayer(arg_3_0, arg_3_1)
	arg_3_0.player = arg_3_1

	return
end

function var_0_1.setCommanderPrefabFleet(arg_4_0, arg_4_1)
	arg_4_0.commanderPrefabFleets = arg_4_1

	return
end

function var_0_1.init(arg_5_0)
	arg_5_0.eventTriggers = {}

	local var_5_0 = arg_5_0._blurLayer

	arg_5_0.backBtn = var_1.Find(var_5_0, "top/back_btn")

	local var_5_1 = arg_5_0._adapt

	arg_5_0._bgFleet = var_1.Find(var_5_1, "bg_fleet")

	local var_5_2 = arg_5_0._adapt

	arg_5_0._bgSub = var_1.Find(var_5_2, "bg_sub")

	local var_5_3 = arg_5_0._blurLayer

	arg_5_0._bottomPanel = var_1.Find(var_5_3, "bottom")

	local var_5_4 = arg_5_0._bottomPanel

	arg_5_0._detailToggle = var_1.Find(var_5_4, "toggle_list/detail_toggle")

	local var_5_5 = arg_5_0._bottomPanel

	arg_5_0._formationToggle = var_1.Find(var_5_5, "toggle_list/formation_toggle")

	local var_5_6 = arg_5_0._adapt

	arg_5_0._nextPage = var_1.Find(var_5_6, "nextPage")

	local var_5_7 = arg_5_0._adapt

	arg_5_0._prevPage = var_1.Find(var_5_7, "prevPage")

	local var_5_8 = arg_5_0._tf

	arg_5_0._starTpl = var_1.Find(var_5_8, "star_tpl")

	local var_5_9 = arg_5_0._tf

	arg_5_0._heroInfoTpl = var_1.Find(var_5_9, "heroInfo")

	local var_5_10 = arg_5_0._blurLayer

	arg_5_0.topPanel = var_1.Find(var_5_10, "top")

	local var_5_11 = {}

	TeamType = var_1_10002
	var_5_11[var_1_10002.Vanguard] = {}
	TeamType = var_2
	var_5_11[var_2.Main] = {}
	TeamType = var_2
	var_5_11[var_2.Submarine] = {}
	arg_5_0._gridTFs = var_5_11

	local var_5_12 = arg_5_0._adapt

	arg_5_0._gridFrame = var_1.Find(var_5_12, "GridFrame")

	for iter_5_0 = 1, 3 do
		local var_5_13 = arg_5_0._gridTFs

		TeamType = var_1_10006

		local var_5_14 = var_5_13[var_1_10006.Main]
		local var_5_15 = arg_5_0._gridFrame

		var_5_14[iter_5_0] = var_1_10006.Find(var_5_15, "main_" .. iter_5_0)

		local var_5_16 = arg_5_0._gridTFs

		TeamType = var_1_10006

		local var_5_17 = var_5_16[var_1_10006.Vanguard]
		local var_5_18 = arg_5_0._gridFrame

		var_5_17[iter_5_0] = var_1_10006.Find(var_5_18, "vanguard_" .. iter_5_0)

		local var_5_19 = arg_5_0._gridTFs

		TeamType = var_1_10006

		local var_5_20 = var_5_19[var_1_10006.Submarine]
		local var_5_21 = arg_5_0._gridFrame

		var_5_20[iter_5_0] = var_1_10006.Find(var_5_21, "submarine_" .. iter_5_0)
	end

	local var_5_22 = arg_5_0._adapt

	arg_5_0._heroContainer = var_1.Find(var_5_22, "HeroContainer")
	BaseFormation = var_1
	arg_5_0._formationLogic = var_1.New(arg_5_0._tf, arg_5_0._heroContainer, arg_5_0._heroInfoTpl, arg_5_0._gridTFs)

	local var_5_23 = arg_5_0._blurLayer

	arg_5_0._fleetInfo = var_1.Find(var_5_23, "fleet_info")

	local var_5_24 = arg_5_0._fleetInfo

	arg_5_0._fleetNumText = var_1.Find(var_5_24, "fleet_number")

	local var_5_25 = arg_5_0._fleetInfo

	arg_5_0._fleetNameText = var_1.Find(var_5_25, "fleet_name/Text")

	local var_5_26 = arg_5_0._fleetInfo

	arg_5_0._fleetNameEditBtn = var_1.Find(var_5_26, "edit_btn")

	local var_5_27 = arg_5_0._tf

	arg_5_0._renamePanel = var_1.Find(var_5_27, "changeName_panel")

	local var_5_28 = arg_5_0._renamePanel

	arg_5_0._renameConfirmBtn = var_1.Find(var_5_28, "frame/queren")

	local var_5_29 = arg_5_0._renamePanel

	arg_5_0._renameCancelBtn = var_1.Find(var_5_29, "frame/cancel")
	setLocalPosition = var_1

	var_1(arg_5_0._renamePanel, {
		z = -45
	})

	local var_5_30 = arg_5_0._blurLayer

	arg_5_0._propertyFrame = var_1.Find(var_5_30, "property_frame")

	local var_5_31 = arg_5_0._propertyFrame

	arg_5_0._cannonPower = var_1.Find(var_5_31, "cannon/Text")

	local var_5_32 = arg_5_0._propertyFrame

	arg_5_0._torpedoPower = var_1.Find(var_5_32, "torpedo/Text")

	local var_5_33 = arg_5_0._propertyFrame

	arg_5_0._AAPower = var_1.Find(var_5_33, "antiaircraft/Text")

	local var_5_34 = arg_5_0._propertyFrame

	arg_5_0._airPower = var_1.Find(var_5_34, "air/Text")

	local var_5_35 = arg_5_0._propertyFrame

	arg_5_0._airDominance = var_1.Find(var_5_35, "ac/Text")

	local var_5_36 = arg_5_0._propertyFrame

	arg_5_0._cost = var_1.Find(var_5_36, "cost/Text")

	local var_5_37 = arg_5_0._adapt

	arg_5_0._mainGS = var_1.Find(var_5_37, "gear_score/main")

	local var_5_38 = arg_5_0._adapt

	arg_5_0._vanguardGS = var_1.Find(var_5_38, "gear_score/vanguard")

	local var_5_39 = arg_5_0._adapt

	arg_5_0._subGS = var_1.Find(var_5_39, "gear_score/submarine")

	local var_5_40 = arg_5_0._vanguardGS

	arg_5_0._arrUpVan = var_1.Find(var_5_40, "up")

	local var_5_41 = arg_5_0._vanguardGS

	arg_5_0._arrDownVan = var_1.Find(var_5_41, "down")

	local var_5_42 = arg_5_0._mainGS

	arg_5_0._arrUpMain = var_1.Find(var_5_42, "up")

	local var_5_43 = arg_5_0._mainGS

	arg_5_0._arrDownMain = var_1.Find(var_5_43, "down")

	local var_5_44 = arg_5_0._subGS

	arg_5_0._arrUpSub = var_1.Find(var_5_44, "up")

	local var_5_45 = arg_5_0._subGS

	arg_5_0._arrDownSub = var_1.Find(var_5_45, "down")

	local var_5_46 = arg_5_0._blurLayer

	arg_5_0._attrFrame = var_1.Find(var_5_46, "attr_frame")

	local var_5_47 = arg_5_0._tf

	arg_5_0._cardTpl = var_1.Find(var_5_47, "RectShipCardTpl")
	arg_5_0._cards = {}

	local var_5_48 = arg_5_0._cards

	TeamType = var_2
	var_5_48[var_2.Main] = {}

	local var_5_49 = arg_5_0._cards

	TeamType = var_2
	var_5_49[var_2.Vanguard] = {}

	local var_5_50 = arg_5_0._cards

	TeamType = var_2
	var_5_50[var_2.Submarine] = {}
	setActive = var_5_50

	var_5_50(arg_5_0._attrFrame, false)

	setActive = var_5_50

	var_5_50(arg_5_0._cardTpl, false)

	local var_5_51 = arg_5_0._bottomPanel

	arg_5_0.btnRegular = var_1.Find(var_5_51, "fleet_select/regular")

	local var_5_52 = arg_5_0.btnRegular

	arg_5_0._regularEnFllet = var_1.Find(var_5_52, "fleet/enFleet")

	local var_5_53 = arg_5_0.btnRegular

	arg_5_0._regularNum = var_1.Find(var_5_53, "fleet/num")

	local var_5_54 = arg_5_0.btnRegular

	arg_5_0._regualrCnFleet = var_1.Find(var_5_54, "fleet/CnFleet")

	local var_5_55 = arg_5_0._bottomPanel

	arg_5_0.btnSub = var_1.Find(var_5_55, "fleet_select/sub")

	local var_5_56 = arg_5_0.btnSub

	arg_5_0._subEnFllet = var_1.Find(var_5_56, "fleet/enFleet")

	local var_5_57 = arg_5_0.btnSub

	arg_5_0._subNum = var_1.Find(var_5_57, "fleet/num")

	local var_5_58 = arg_5_0.btnSub

	arg_5_0._subCnFleet = var_1.Find(var_5_58, "fleet/CnFleet")

	local var_5_59 = arg_5_0._tf

	arg_5_0.fleetToggleMask = var_1.Find(var_5_59, "blur_panel/list_mask")

	local var_5_60 = arg_5_0.fleetToggleMask

	arg_5_0.fleetToggleList = var_1.Find(var_5_60, "list")
	arg_5_0.fleetToggles = {}

	for iter_5_1 = 1, var_0_1.MAX_FLEET_NUM do
		local var_5_61 = arg_5_0.fleetToggles
		local var_5_62 = arg_5_0.fleetToggleList

		var_5_61[iter_5_1] = var_6.Find(var_5_62, "item" .. iter_5_1)
	end

	local var_5_63 = arg_5_0._vanguardGS
	local var_5_64 = var_1.Find(var_5_63, "Text")

	arg_5_0._vanGSTxt = var_1.GetComponent(var_5_64, "Text")

	local var_5_65 = arg_5_0._mainGS
	local var_5_66 = var_1.Find(var_5_65, "Text")

	arg_5_0._mainGSTxt = var_1.GetComponent(var_5_66, "Text")

	local var_5_67 = arg_5_0._subGS
	local var_5_68 = var_1.Find(var_5_67, "Text")

	arg_5_0._subGSTxt = var_1.GetComponent(var_5_68, "Text")
	arg_5_0.prevMainGS = arg_5_0.contextData.mainGS
	arg_5_0.prevVanGS = arg_5_0.contextData.vanGS
	arg_5_0.prevSubGS = arg_5_0.contextData.subGS
	arg_5_0.mainGSInited = arg_5_0.contextData.mainGS and true or false
	arg_5_0.VanGSInited = arg_5_0.contextData.vanGS and true or false
	arg_5_0.SubGSInited = arg_5_0.contextData.subGS and true or false

	local var_5_69 = arg_5_0._vanGSTxt
	local var_5_70

	if not arg_5_0.prevVanGS then
		var_5_70 = 0
	end

	var_5_69.text = var_5_70

	local var_5_71 = arg_5_0._mainGSTxt
	local var_5_72

	if not arg_5_0.prevMainGS then
		var_5_72 = 0
	end

	var_5_71.text = var_5_72

	local var_5_73 = arg_5_0._subGSTxt
	local var_5_74

	if not arg_5_0.prevSubGS then
		var_5_74 = 0
	end

	var_5_73.text = var_5_74
	CommanderFormationPage = var_5_73
	arg_5_0.commanderFormationPanel = var_5_73.New(arg_5_0._tf, arg_5_0.event, arg_5_0.contextData)

	local var_5_75 = {}

	FleetType = var_5_74
	var_5_75[var_5_74.Normal] = 1
	FleetType = var_2
	var_5_75[var_2.Submarine] = 1
	arg_5_0.index = var_5_75
	setText = var_5_75

	local var_5_76 = arg_5_0._adapt
	local var_5_77 = var_3.Find(var_5_76, "gear_score/main/line/Image/text1")

	i18n = var_4

	var_5_75(var_5_77, var_4("pre_combat_main"))

	setText = var_5_75

	local var_5_78 = arg_5_0._adapt
	local var_5_79 = var_3.Find(var_5_78, "gear_score/vanguard/line/Image/text1")

	i18n = var_4

	var_5_75(var_5_79, var_4("pre_combat_vanguard"))

	setText = var_5_75

	local var_5_80 = arg_5_0._adapt
	local var_5_81 = var_3.Find(var_5_80, "gear_score/submarine/line/Image/text1")

	i18n = var_4

	var_5_75(var_5_81, var_4("pre_combat_submarine"))

	return
end

function var_0_1.setShips(arg_6_0, arg_6_1)
	arg_6_0.shipVOs = arg_6_1

	local var_6_0 = arg_6_0._formationLogic

	var_2.SetShipVOs(var_6_0, arg_6_0.shipVOs)

	return
end

function var_0_1.SetFleets(arg_7_0, arg_7_1)
	_ = var_1_10002

	local var_7_0 = var_1_10002(arg_7_1)
	local var_7_1 = var_2.chain(var_7_0)
	local var_7_2 = var_2.values(var_7_1)
	local var_7_3 = var_2.filter(var_7_2, function(arg_8_0)
		return arg_8_0:isRegularFleet()
	end)
	local var_7_4 = var_2.sort(var_7_3, function(arg_9_0, arg_9_1)
		return arg_9_0.id < arg_9_1.id
	end)

	arg_7_0._fleetVOs = var_2.value(var_7_4)

	if arg_7_0._currentFleetVO then
		arg_7_0._currentFleetVO = arg_7_0:getFleetById(arg_7_0._currentFleetVO.id)

		local var_7_5 = arg_7_0._formationLogic

		var_3.SetFleetVO(var_7_5, arg_7_0._currentFleetVO)
	end

	return
end

function var_0_1.getFleetById(arg_10_0, arg_10_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_10_0._fleetVOs, function(arg_11_0)
		return arg_11_0.id == arg_10_1
	end)
end

function var_0_1.UpdateFleetView(arg_12_0, arg_12_1)
	arg_12_0:displayFleetInfo()
	arg_12_0:updateFleetBg()

	local var_12_0 = arg_12_0._formationLogic

	var_2.UpdateGridVisibility(var_12_0)

	local var_12_1 = arg_12_0._formationLogic
	local var_12_2 = var_2.ResetGrid

	TeamType = var_1_10005

	var_12_2(var_12_1, var_1_10005.Vanguard)

	local var_12_3 = arg_12_0._formationLogic
	local var_12_4 = var_2.ResetGrid

	TeamType = var_5

	var_12_4(var_12_3, var_5.Main)

	local var_12_5 = arg_12_0._formationLogic
	local var_12_6 = var_2.ResetGrid

	TeamType = var_5

	var_12_6(var_12_5, var_5.Submarine)
	arg_12_0:resetFormationComponent()
	arg_12_0:updateAttrFrame()
	arg_12_0:updateFleetButton()

	if arg_12_1 then
		local var_12_7 = arg_12_0._formationLogic

		var_2.LoadAllCharacter(var_12_7)
	else
		local var_12_8 = arg_12_0._formationLogic

		var_2.SetAllCharacterPos(var_12_8)
	end

	return
end

function var_0_1.updateFleetBg(arg_13_0)
	local var_13_0 = arg_13_0._currentFleetVO
	local var_13_1 = var_1.getFleetType(var_13_0)

	setActive = var_1_10002

	local var_13_2 = arg_13_0._bgFleet

	FleetType = var_1_10005

	var_1_10002(var_13_2, var_13_1 == var_1_10005.Normal)

	setActive = var_1_10002

	local var_13_3 = arg_13_0._bgSub

	FleetType = var_5

	var_1_10002(var_13_3, var_13_1 == var_5.Submarine)

	return
end

function var_0_1.updateFleetButton(arg_14_0)
	local var_14_0
	local var_14_1 = arg_14_0._currentFleetVO
	local var_14_2 = var_2.getFleetType(var_14_1)
	local var_14_3 = arg_14_0.index
	local var_14_4 = arg_14_0._currentFleetVO

	var_14_3[var_14_2] = var_4.getIndex(var_14_4)

	local var_14_5 = arg_14_0.index

	FleetType = var_4

	local var_14_6 = var_14_5[var_4.Normal]

	setText = var_14_5

	var_14_5(arg_14_0._regularEnFllet, var_0_1.TeamNum[var_14_6] .. " FLEET")

	setText = var_14_5

	local var_14_7 = arg_14_0._regualrCnFleet

	Fleet = var_6

	var_14_5(var_14_7, var_6.DEFAULT_NAME[var_14_6])

	setText = var_14_5

	var_14_5(arg_14_0._regularNum, var_14_6)

	local var_14_8 = arg_14_0.index

	FleetType = var_4

	local var_14_9 = var_14_8[var_4.Submarine]

	setText = var_14_8

	var_14_8(arg_14_0._subEnFllet, var_0_1.TeamNum[var_14_9] .. " FLEET")

	setText = var_14_8

	local var_14_10 = arg_14_0._subCnFleet

	Fleet = var_6

	var_14_8(var_14_10, var_6.DEFAULT_NAME[var_14_9])

	setText = var_14_8

	var_14_8(arg_14_0._subNum, var_14_9)

	setActive = var_14_8

	local var_14_11 = arg_14_0.btnRegular
	local var_14_12 = var_5.Find(var_14_11, "on")

	FleetType = var_6

	var_14_8(var_14_12, var_14_2 == var_6.Normal)

	setActive = var_14_8

	local var_14_13 = arg_14_0.btnRegular
	local var_14_14 = var_5.Find(var_14_13, "off")

	FleetType = var_6

	var_14_8(var_14_14, var_14_2 ~= var_6.Normal)

	setActive = var_14_8

	local var_14_15 = arg_14_0.btnSub
	local var_14_16 = var_5.Find(var_14_15, "on")

	FleetType = var_6

	var_14_8(var_14_16, var_14_2 == var_6.Submarine)

	setActive = var_14_8

	local var_14_17 = arg_14_0.btnSub
	local var_14_18 = var_5.Find(var_14_17, "off")

	FleetType = var_6

	var_14_8(var_14_18, var_14_2 ~= var_6.Submarine)

	return
end

function var_0_1.SetFleetNameLabel(arg_15_0)
	setText = var_1_10001

	var_1_10001(arg_15_0._fleetNameText, arg_15_0.defaultFleetName(arg_15_0._currentFleetVO))

	return
end

function var_0_1.ForceDropChar(arg_16_0)
	local var_16_0 = arg_16_0._formationLogic

	var_1.ForceDropChar(var_16_0)

	if arg_16_0._currentDragDelegate then
		arg_16_0._forceDropCharacter = true
		LuaHelper = var_1

		var_1.triggerEndDrag(arg_16_0._currentDragDelegate)
	end

	return
end

function var_0_1.quickExitFunc(arg_17_0)
	arg_17_0:ForceDropChar()

	local function var_17_0()
		GetOrAddComponent = var_2_10000

		local var_18_0 = arg_17_0._tf

		typeof = var_2_10003
		CanvasGroup = var_2_10005
		var_2_10000(var_18_0, var_2_10003(var_2_10005)).interactable = false

		local var_18_1 = arg_17_0

		var_1.emit(var_18_1, var_0_1.ON_HOME)

		return
	end

	local var_17_1 = arg_17_0
	local var_17_2 = arg_17_0.emit

	FormationMediator = var_1_10005

	var_17_2(var_17_1, var_1_10005.COMMIT_FLEET, var_17_0)

	return
end

function var_0_1.didEnter(arg_19_0)
	pg = var_1_10001

	local var_19_0 = var_1_10001.SystemOpenMgr.GetInstance()
	local var_19_1

	if var_1.isOpenSystem(var_19_0, arg_19_0.player.level, "CommanderCatMediator") then
		LOCK_COMMANDER = var_19_1
		var_19_1 = not var_19_1
	end

	arg_19_0.isOpenCommander = var_19_1
	getProxy = var_19_1
	ActivityProxy = var_19_0

	local var_19_2 = var_19_1(var_19_0)
	local var_19_3 = var_1.getBuffShipList(var_19_2)
	local var_19_4 = arg_19_0._formationLogic

	var_2.AddHeroInfoModify(var_19_4, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_1:getConfigTable()

		pg = var_2_10003

		local var_20_1 = var_2_10003.ship_data_template[arg_20_1.configId]

		findTF = var_4

		local var_20_2 = var_4(arg_20_0, "info")

		findTF = var_2_10005

		local var_20_3 = var_2_10005(var_20_2, "stars")

		findTF = var_6

		local var_20_4 = var_6(var_20_2, "energy")
		local var_20_5 = arg_20_1:getStar()

		for iter_20_0 = 1, var_20_5 do
			cloneTplTo = var_2_10012

			var_2_10012(arg_19_0._starTpl, var_20_3)
		end

		GetSpriteFromAtlas = var_8

		local var_20_6 = "shiptype"

		shipType2print = iter_20_0

		if not var_8(var_20_6, iter_20_0(arg_20_1:getShipType())) then
			warning = var_9

			var_9("找不到船形, shipConfigId: " .. arg_20_1.configId)
		end

		setImageSprite = var_9
		findTF = var_11

		var_9(var_11(var_20_2, "type"), var_8, true)

		setText = var_9
		findTF = var_11

		var_9(var_11(var_20_2, "frame/lv_contain/lv"), arg_20_1.level)

		local var_20_7 = arg_20_1.energy

		Ship = var_20_6

		if var_20_7 <= var_20_6.ENERGY_MID then
			GetSpriteFromAtlas = var_20_7

			local var_20_8 = var_20_7("energy", arg_20_1:getEnergyPrint())

			setImageSprite = var_10

			var_10(var_20_4, var_20_8)

			setActive = var_10

			var_10(var_20_4, true)
		end

		local var_20_9 = var_19_3[arg_20_1:getGroupId()]
		local var_20_10 = var_20_2:Find("expbuff")

		setActive = var_11

		var_11(var_20_10, var_20_9 ~= nil)

		if var_20_9 then
			local var_20_11 = var_20_9 / 100
			local var_20_12 = var_20_9 % 100

			tostring = var_13

			local var_20_13 = var_13(var_20_11)
			local var_20_14

			if 0 < var_20_12 then
				var_20_14 = var_20_13

				local var_20_15 = "."

				tostring = var_2_10016
				var_20_13 = var_20_14 .. var_20_15 .. var_2_10016(var_20_12)
			end

			setText = var_20_14

			local var_20_16 = var_20_10:Find("text")

			string = var_2_10017

			var_20_14(var_20_16, var_2_10017.format("EXP +%s%%", var_20_13))
		end

		return
	end)

	local var_19_5 = arg_19_0._formationLogic

	var_2.AddLongPress(var_19_5, function(arg_21_0, arg_21_1, arg_21_2)
		local var_21_0 = arg_19_0
		local var_21_1 = var_3.emit

		FormationMediator = var_2_10006

		var_21_1(var_21_0, var_2_10006.OPEN_SHIP_INFO, arg_21_1.id, arg_19_0._currentFleetVO, var_0_1.TOGGLE_FORMATION)

		pg = var_21_1

		local var_21_2 = var_21_1.CriMgr.GetInstance()
		local var_21_3 = var_3.PlaySoundEffect_V3

		SFX_PANEL = var_6

		var_21_3(var_21_2, var_6)

		return
	end)

	local var_19_6 = arg_19_0._formationLogic

	var_2.AddClick(var_19_6, function(arg_22_0, arg_22_1)
		local var_22_0 = arg_19_0
		local var_22_1 = var_2.emit

		FormationMediator = var_2_10005

		var_22_1(var_22_0, var_2_10005.CHANGE_FLEET_SHIP, arg_22_0, arg_19_0._currentFleetVO, var_0_1.TOGGLE_FORMATION, arg_22_1)

		pg = var_22_1

		local var_22_2 = var_22_1.CriMgr.GetInstance()
		local var_22_3 = var_2.PlaySoundEffect_V3

		SFX_PANEL = var_5

		var_22_3(var_22_2, var_5)

		return
	end)

	local var_19_7 = arg_19_0._formationLogic

	var_2.AddBeginDrag(var_19_7, function(arg_23_0)
		findTF = var_2_10001

		local var_23_0 = var_2_10001(arg_23_0, "info")

		SetActive = var_2_10002

		var_2_10002(var_23_0, false)

		return
	end)

	local var_19_8 = arg_19_0._formationLogic

	var_2.AddEndDrag(var_19_8, function(arg_24_0)
		findTF = var_2_10001

		local var_24_0 = var_2_10001(arg_24_0, "info")

		SetActive = var_2_10002

		var_2_10002(var_24_0, true)

		return
	end)

	local var_19_9 = arg_19_0._formationLogic

	var_2.AddShiftOnly(var_19_9, function(arg_25_0)
		local var_25_0 = arg_19_0
		local var_25_1 = var_1.emit

		FormationMediator = var_2_10004

		var_25_1(var_25_0, var_2_10004.CHANGE_FLEET_SHIPS_ORDER, arg_25_0)

		return
	end)

	local var_19_10 = arg_19_0._formationLogic

	var_2.AddRemoveShip(var_19_10, function(arg_26_0, arg_26_1)
		local var_26_0 = arg_19_0
		local var_26_1 = var_2.emit

		FormationMediator = var_2_10005

		var_26_1(var_26_0, var_2_10005.REMOVE_SHIP, arg_26_0, arg_26_1)

		return
	end)

	local var_19_11 = arg_19_0._formationLogic

	var_2.AddCheckRemove(var_19_11, function(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
		local var_27_1

		if not arg_27_3:canRemove(arg_27_2) then
			local var_27_0 = arg_27_3
			local var_27_2

			var_27_1, var_27_2 = arg_27_3.getShipPos(var_27_0, arg_27_2)
			pg = var_27_0
			var_2_10009 = var_27_0.TipsMgr.GetInstance()

			local var_27_3 = var_7.ShowTips

			i18n = var_2_10010

			local var_27_4 = "ship_formationUI_removeError_onlyShip"
			local var_27_5 = arg_27_2
			local var_27_6 = arg_27_2.getConfigTable(var_27_5).name
			local var_27_7 = arg_27_3.name

			Fleet = var_27_5

			var_27_3(var_2_10009, var_2_10010(var_27_4, var_27_6, var_27_7, var_27_5.C_TEAM_NAME[var_27_2]))
			arg_27_0()
		else
			pg = var_27_1

			local var_27_8 = var_27_1.MsgboxMgr.GetInstance()
			local var_27_9 = var_5.ShowMsgBox
			local var_27_10 = {
				hideNo = false,
				zIndex = -30
			}

			i18n = var_2_10009
			var_27_10.content = var_2_10009("ship_formationUI_quest_remove", arg_27_2:getName())
			var_27_10.onYes = arg_27_1
			var_27_10.onNo = arg_27_0

			var_27_9(var_27_8, var_27_10)
		end

		return
	end)

	local var_19_12 = arg_19_0._formationLogic

	var_2.AddGridTipClick(var_19_12, function(arg_28_0, arg_28_1)
		local var_28_0 = arg_19_0
		local var_28_1 = var_2.emit

		FormationMediator = var_2_10005

		var_28_1(var_28_0, var_2_10005.CHANGE_FLEET_SHIP, nil, arg_28_1, var_0_1.TOGGLE_FORMATION, arg_28_0)

		return
	end)

	onButton = var_2

	local var_19_13 = arg_19_0
	local var_19_14 = arg_19_0.backBtn

	local function var_19_15()
		local var_29_0 = arg_19_0

		var_0.ForceDropChar(var_29_0)

		if arg_19_0._attrFrame.gameObject.activeSelf then
			triggerToggle = var_0

			var_0(arg_19_0._formationToggle, true)
		else
			local function var_29_1()
				GetOrAddComponent = var_3_10000

				local var_30_0 = arg_19_0._tf

				typeof = var_3_10003
				CanvasGroup = var_3_10005
				var_3_10000(var_30_0, var_3_10003(var_3_10005)).interactable = false

				local var_30_1 = arg_19_0

				var_1.emit(var_30_1, var_0_1.ON_BACK)

				return
			end

			local var_29_2 = arg_19_0
			local var_29_3 = var_1.emit

			FormationMediator = var_2_10004

			var_29_3(var_29_2, var_2_10004.COMMIT_FLEET, var_29_1)
		end

		return
	end

	SOUND_BACK = var_1_10007

	var_2(var_19_13, var_19_14, var_19_15, var_1_10007)

	local var_19_16 = arg_19_0._adapt

	arg_19_0._stamp = var_2.Find(var_19_16, "stamp")
	setActive = var_2

	local var_19_17 = arg_19_0._stamp

	LOCK_CLICK_MINGSHI = var_19_18

	local var_19_18

	if not var_19_18 then
		BATTLE_DEBUG = var_19_18

		if not var_19_18 then
			getProxy = var_19_18
			TaskProxy = var_1_10007
			var_1_10007 = var_19_18(var_1_10007)
			var_19_18 = var_19_18.mingshiTouchFlagEnabled(var_1_10007)
		end
	else
		var_19_18 = false
	end

	if false then
		var_19_18 = true
	end

	var_2(var_19_17, var_19_18)

	onButton = var_2

	local var_19_19 = arg_19_0
	local var_19_20 = arg_19_0._stamp

	local function var_19_21()
		BATTLE_DEBUG = var_2_10000

		if var_2_10000 then
			print = var_2_10000

			local var_31_0 = arg_19_0._currentFleetVO

			var_2_10000(var_2_10002.genRobotDataString(var_31_0))
		end

		getProxy = var_2_10000
		TaskProxy = var_2_10002

		local var_31_1 = var_2_10000(var_2_10002)

		var_0.dealMingshiTouchFlag(var_31_1, 6)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_2(var_19_19, var_19_20, var_19_21, var_1_10007)

	onButton = var_2

	local var_19_22 = arg_19_0
	local var_19_23 = arg_19_0._fleetNameEditBtn

	local function var_19_24()
		local var_32_0 = arg_19_0

		var_0.DisplayRenamePanel(var_32_0, true)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_19_22, var_19_23, var_19_24, var_1_10007)

	onButton = var_2

	local var_19_25 = arg_19_0
	local var_19_26 = arg_19_0._renameConfirmBtn

	local function var_19_27()
		getInputText = var_2_10000
		findTF = var_2_10002

		local var_33_0 = var_2_10000(var_2_10002(arg_19_0._renamePanel, "frame/name_field"))
		local var_33_1 = arg_19_0
		local var_33_2 = var_1.emit

		FormationMediator = var_4

		var_33_2(var_33_1, var_4.CHANGE_FLEET_NAME, arg_19_0._currentFleetVO.id, var_33_0)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_2(var_19_25, var_19_26, var_19_27, var_1_10007)

	onButton = var_2

	local var_19_28 = arg_19_0
	local var_19_29 = arg_19_0._renameCancelBtn

	local function var_19_30()
		local var_34_0 = arg_19_0

		var_0.DisplayRenamePanel(var_34_0, false)

		return
	end

	SFX_CANCEL = var_1_10007

	var_2(var_19_28, var_19_29, var_19_30, var_1_10007)

	onToggle = var_2

	local var_19_31 = arg_19_0
	local var_19_32 = arg_19_0._detailToggle

	local function var_19_33(arg_35_0)
		local var_35_0 = arg_19_0

		var_1.ForceDropChar(var_35_0)

		if arg_35_0 then
			local var_35_1 = arg_19_0

			var_1.displayAttrFrame(var_35_1)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_19_31, var_19_32, var_19_33, var_1_10007)

	onToggle = var_2

	local var_19_34 = arg_19_0
	local var_19_35 = arg_19_0._formationToggle

	local function var_19_36(arg_36_0)
		local var_36_0 = arg_19_0

		var_1.ForceDropChar(var_36_0)

		if arg_36_0 then
			local var_36_1 = arg_19_0

			var_1.hideAttrFrame(var_36_1)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_19_34, var_19_35, var_19_36, var_1_10007)

	onButton = var_2

	local var_19_37 = arg_19_0
	local var_19_38 = arg_19_0._attrFrame

	local function var_19_39()
		triggerToggle = var_2_10000

		var_2_10000(arg_19_0._formationToggle, true)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_19_37, var_19_38, var_19_39, var_1_10007)

	onButton = var_2

	local var_19_40 = arg_19_0
	local var_19_41 = arg_19_0.fleetToggleMask

	local function var_19_42()
		setActive = var_2_10000

		var_2_10000(arg_19_0.fleetToggleMask, false)

		local var_38_0 = arg_19_0

		var_0.tweenTabArrow(var_38_0, true)

		return
	end

	SFX_CANCEL = var_1_10007

	var_2(var_19_40, var_19_41, var_19_42, var_1_10007)

	onButton = var_2

	local var_19_43 = arg_19_0
	local var_19_44 = arg_19_0.btnRegular

	local function var_19_45()
		local var_39_0 = arg_19_0
		local var_39_1 = var_0.updateToggleList

		_ = var_2_10003

		var_39_1(var_39_0, var_2_10003.filter(arg_19_0._fleetVOs, function(arg_40_0)
			local var_40_0 = arg_40_0:getFleetType()

			FleetType = var_3_10002

			return var_40_0 == var_3_10002.Normal
		end))

		local var_39_2 = arg_19_0._currentFleetVO
		local var_39_3 = var_0.getFleetType(var_39_2)

		FleetType = var_2_10001

		local var_39_4 = var_39_3 == var_2_10001.Normal
		local var_39_5 = arg_19_0.index

		FleetType = var_39_2

		local var_39_6 = var_39_5[var_39_2.Normal]

		triggerToggle = var_2

		var_2(arg_19_0.fleetToggles[var_39_6], true)

		if var_39_4 then
			setActive = var_2

			var_2(arg_19_0.fleetToggleMask, true)

			local var_39_7 = arg_19_0

			var_2.tweenTabArrow(var_39_7, false)

			setAnchoredPosition = var_2

			local var_39_8 = arg_19_0.fleetToggleList

			Vector3 = var_5

			var_2(var_39_8, var_5.New(209, 129))
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_19_43, var_19_44, var_19_45, var_1_10007)

	onButton = var_2

	local var_19_46 = arg_19_0
	local var_19_47 = arg_19_0.btnSub

	local function var_19_48()
		local var_41_0 = arg_19_0
		local var_41_1 = var_0.updateToggleList

		_ = var_2_10003

		var_41_1(var_41_0, var_2_10003.filter(arg_19_0._fleetVOs, function(arg_42_0)
			local var_42_0 = arg_42_0:getFleetType()

			FleetType = var_3_10002

			return var_42_0 == var_3_10002.Submarine
		end))

		local var_41_2 = arg_19_0._currentFleetVO
		local var_41_3 = var_0.getFleetType(var_41_2)

		FleetType = var_2_10001

		local var_41_4 = var_41_3 == var_2_10001.Submarine
		local var_41_5 = arg_19_0.index

		FleetType = var_41_2

		local var_41_6 = var_41_5[var_41_2.Submarine]

		triggerToggle = var_2

		var_2(arg_19_0.fleetToggles[var_41_6], true)

		if var_41_4 then
			setActive = var_2

			var_2(arg_19_0.fleetToggleMask, true)

			local var_41_7 = arg_19_0

			var_2.tweenTabArrow(var_41_7, false)

			setAnchoredPosition = var_2

			local var_41_8 = arg_19_0.fleetToggleList

			Vector3 = var_5

			var_2(var_41_8, var_5.New(755, 129))
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_19_46, var_19_47, var_19_48, var_1_10007)

	onButton = var_2

	local var_19_49 = arg_19_0
	local var_19_50 = arg_19_0._prevPage

	local function var_19_51()
		local var_43_0 = arg_19_0
		local var_43_1 = var_0.selectFleetByStep(var_43_0, -1)
		local var_43_2 = arg_19_0

		var_1.ForceDropChar(var_43_2)

		local var_43_3 = arg_19_0
		local var_43_4 = var_1.emit

		FormationMediator = var_2_10004

		var_43_4(var_43_3, var_2_10004.ON_CHANGE_FLEET, var_43_1)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_19_49, var_19_50, var_19_51, var_1_10007)

	onButton = var_2

	local var_19_52 = arg_19_0
	local var_19_53 = arg_19_0._nextPage

	local function var_19_54()
		local var_44_0 = arg_19_0
		local var_44_1 = var_0.selectFleetByStep(var_44_0, 1)
		local var_44_2 = arg_19_0

		var_1.ForceDropChar(var_44_2)

		local var_44_3 = arg_19_0
		local var_44_4 = var_1.emit

		FormationMediator = var_2_10004

		var_44_4(var_44_3, var_2_10004.ON_CHANGE_FLEET, var_44_1)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_19_52, var_19_53, var_19_54, var_1_10007)

	defaultValue = var_2

	local var_19_55 = var_2(arg_19_0.contextData.number, 1)

	arg_19_0:SetCurrentFleetID(var_19_55)

	if arg_19_0.isOpenCommander then
		local var_19_56 = arg_19_0.commanderFormationPanel

		var_3.ActionInvoke(var_19_56, "Show")
	end

	arg_19_0:UpdateFleetView(true)

	triggerToggle = var_3

	local var_19_57

	if not arg_19_0.contextData.toggle then
		var_19_57 = var_0_1.TOGGLE_FORMATION
	end

	var_3(arg_19_0[var_19_57], true)
	arg_19_0:tweenTabArrow(true)

	onButton = var_3

	local var_19_58 = arg_19_0
	local var_19_59 = arg_19_0._vanguardGS
	local var_19_60 = var_6.Find(var_19_59, "SonarTip")

	local function var_19_61()
		pg = var_2_10000

		local var_45_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_45_1 = var_0.ShowMsgBox
		local var_45_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_45_2.type = var_2_10004
		pg = var_2_10004
		var_45_2.helps = var_2_10004.gametip.fleet_antisub_range_tip.tip

		var_45_1(var_45_0, var_45_2)

		return
	end

	SFX_PANEL = var_19_59

	var_3(var_19_58, var_19_60, var_19_61, var_19_59)

	return
end

function var_0_1.SetCurrentFleetID(arg_46_0, arg_46_1)
	arg_46_0._currentFleetVO = arg_46_0:getFleetById(arg_46_1)

	local var_46_0 = arg_46_0._formationLogic

	var_2.SetFleetVO(var_46_0, arg_46_0._currentFleetVO)
	arg_46_0:updateCommanderFormation()

	return
end

function var_0_1.updateCommanderFormation(arg_47_0)
	if arg_47_0.isOpenCommander then
		local var_47_0 = arg_47_0.commanderFormationPanel

		var_1.Load(var_47_0)

		local var_47_1 = arg_47_0.commanderFormationPanel

		var_1.ActionInvoke(var_47_1, "Update", arg_47_0._currentFleetVO, arg_47_0.commanderPrefabFleets)
	end

	return
end

function var_0_1.selectFleetByStep(arg_48_0, arg_48_1)
	table = var_1_10002

	local var_48_0 = var_1_10002.indexof(arg_48_0._fleetVOs, arg_48_0._currentFleetVO)

	while true do
		if var_48_0 + arg_48_1 < 1 or var_48_0 > #arg_48_0._fleetVOs then
			break
		end

		local var_48_1 = arg_48_0._fleetVOs[var_48_0]

		if var_3.isUnlock(var_48_1) then
			return var_3.id
		end
	end

	return
end

function var_0_1.updateToggleList(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_0.fleetToggleList
	local var_49_1 = var_2.GetComponent

	typeof = var_1_10005
	ToggleGroup = var_1_10007

	local var_49_2 = var_49_1(var_49_0, var_1_10005(var_1_10007))

	var_49_2.allowSwitchOff = true

	local var_49_3 = arg_49_0._currentFleetVO.id

	for iter_49_0 = 1, #arg_49_0.fleetToggles do
		local var_49_4 = arg_49_0.fleetToggles[iter_49_0]
		local var_49_5 = arg_49_1[iter_49_0]

		setActive = var_1_10010

		var_1_10010(var_49_4, var_49_5)

		if var_49_5 then
			local var_49_6 = var_49_4

			var_1_10010 = var_49_4.GetComponent
			typeof = var_13
			Toggle = var_1_10015
			var_1_10010 = var_1_10010(var_49_6, var_13(var_1_10015))

			local var_49_7 = var_49_4:Find("lock")
			local var_49_8 = var_49_5
			local var_49_9, var_49_10 = var_49_5.isUnlock(var_49_8)

			setToggleEnabled = var_49_8

			var_49_8(var_49_4, var_49_9)

			setActive = var_49_8

			var_49_8(var_49_7, not var_49_9)

			setActive = var_49_8

			var_49_8(var_49_4:Find("on"), var_49_9 and var_49_3 == var_49_5.id)

			setActive = var_49_8

			var_49_8(var_49_4:Find("off"), var_49_9 and var_49_3 ~= var_49_5.id)

			if var_49_9 then
				var_49_8 = var_49_5.id == var_49_3
				var_1_10010.isOn = var_49_8
				onToggle = var_49_8

				local var_49_11 = arg_49_0
				local var_49_12 = var_49_4

				local function var_49_13(arg_50_0)
					if arg_50_0 then
						setActive = var_2_10001

						var_2_10001(arg_49_0.fleetToggleMask, false)

						local var_50_0 = arg_49_0

						var_1.tweenTabArrow(var_50_0, true)

						if var_49_5.id ~= var_49_3 then
							local var_50_1 = arg_49_0

							var_1.ForceDropChar(var_50_1)

							local var_50_2 = arg_49_0
							local var_50_3 = var_1.emit

							FormationMediator = var_4

							var_50_3(var_50_2, var_4.ON_CHANGE_FLEET, var_49_5.id)
						end
					end

					return
				end

				SFX_UI_TAG = var_19

				var_49_8(var_49_11, var_49_12, var_49_13, var_19)
			else
				onButton = var_49_8

				local var_49_14 = arg_49_0
				local var_49_15 = var_49_7

				local function var_49_16()
					pg = var_2_10000

					local var_51_0 = var_2_10000.TipsMgr.GetInstance()

					var_0.ShowTips(var_51_0, var_49_10)

					return
				end

				SFX_UI_CLICK = var_19

				var_49_8(var_49_14, var_49_15, var_49_16, var_19)
			end
		end
	end

	var_49_2.allowSwitchOff = false

	return
end

function var_0_1.resetFormationComponent(arg_52_0)
	SetActive = var_1_10001

	local var_52_0 = arg_52_0._gridTFs.main[1]
	local var_52_1 = var_3.Find(var_52_0, "flag")
	local var_52_2 = arg_52_0._currentFleetVO
	local var_52_3 = var_4.getTeamByName

	TeamType = var_1_10007

	var_1_10001(var_52_1, #var_52_3(var_52_2, var_1_10007.Main) ~= 0)

	SetActive = var_1_10001

	local var_52_4 = arg_52_0._gridTFs.submarine[1]
	local var_52_5 = var_3.Find(var_52_4, "flag")
	local var_52_6 = arg_52_0._currentFleetVO
	local var_52_7 = var_4.getTeamByName

	TeamType = var_7

	var_1_10001(var_52_5, #var_52_7(var_52_6, var_7.Submarine) ~= 0)

	return
end

function var_0_1.sortCardSiblingIndex(arg_53_0)
	local var_53_0 = {}

	TeamType = var_1_10002
	var_53_0[1] = var_1_10002.Main
	TeamType = var_2
	var_53_0[2] = var_2.Vanguard
	TeamType = var_2
	var_53_0[3] = var_2.Submarine
	_ = var_2

	var_2.each(var_53_0, function(arg_54_0)
		if #arg_53_0._cards[arg_54_0] > 0 then
			for iter_54_0 = 1, #var_1 do
				local var_54_0 = var_1[iter_54_0].tr

				var_6.SetSiblingIndex(var_54_0, iter_54_0 - 1)
			end
		end

		return
	end)

	return
end

function var_0_1.displayFleetInfo(arg_55_0)
	SetActive = var_1_10001

	var_1_10001(arg_55_0._prevPage, arg_55_0:selectFleetByStep(-1))

	SetActive = var_1_10001

	var_1_10001(arg_55_0._nextPage, arg_55_0:selectFleetByStep(1))

	setActive = var_1_10001

	local var_55_0 = arg_55_0._adapt

	var_1_10001(var_3.Find(var_55_0, "gear_score"), true)

	setActive = var_1_10001

	var_1_10001(arg_55_0._vanguardGS, false)

	setActive = var_1_10001

	var_1_10001(arg_55_0._mainGS, false)

	setActive = var_1_10001

	var_1_10001(arg_55_0._subGS, false)

	local var_55_1 = arg_55_0._currentFleetVO
	local var_55_2 = var_1.GetPropertiesSum(var_55_1)

	math = var_1_10002

	local var_55_3 = var_1_10002.floor
	local var_55_4 = arg_55_0._currentFleetVO
	local var_55_5 = var_4.GetGearScoreSum

	TeamType = var_7

	local var_55_6 = var_55_3(var_55_5(var_55_4, var_7.Vanguard))

	math = var_55_1

	local var_55_7 = var_55_1.floor
	local var_55_8 = arg_55_0._currentFleetVO
	local var_55_9 = var_5.GetGearScoreSum

	TeamType = var_1_10008

	local var_55_10 = var_55_7(var_55_9(var_55_8, var_1_10008.Main))

	math = var_4

	local var_55_11 = var_4.floor
	local var_55_12 = arg_55_0._currentFleetVO
	local var_55_13 = var_6.GetGearScoreSum

	TeamType = var_1_10009

	local var_55_14 = var_55_11(var_55_13(var_55_12, var_1_10009.Submarine))
	local var_55_15 = arg_55_0._currentFleetVO
	local var_55_16 = var_5.GetCostSum(var_55_15)

	arg_55_0.tweenNumText(arg_55_0._cannonPower, var_55_2.cannon)
	arg_55_0.tweenNumText(arg_55_0._torpedoPower, var_55_2.torpedo)
	arg_55_0.tweenNumText(arg_55_0._AAPower, var_55_2.antiAir)
	arg_55_0.tweenNumText(arg_55_0._airPower, var_55_2.air)
	arg_55_0.tweenNumText(arg_55_0._cost, var_55_16.oil)

	OPEN_AIR_DOMINANCE = var_55_17

	local var_55_17

	if var_55_17 then
		setActive = var_55_17

		var_55_17(arg_55_0._airDominance.parent, true)

		var_55_17 = arg_55_0.tweenNumText

		local var_55_18 = arg_55_0._airDominance
		local var_55_19 = arg_55_0._currentFleetVO

		var_55_17(var_55_18, var_9.getFleetAirDominanceValue(var_55_19))
	else
		setActive = var_55_17

		var_55_17(arg_55_0._airDominance.parent, false)
	end

	local var_55_20 = arg_55_0._currentFleetVO
	local var_55_21 = var_6.getFleetType(var_55_20)

	FleetType = var_55_15

	local var_55_22

	if var_55_21 == var_55_15.Normal then
		setActive = var_55_22

		var_55_22(arg_55_0._vanguardGS, true)

		setActive = var_55_22

		var_55_22(arg_55_0._mainGS, true)

		setActive = var_55_22

		var_55_22(arg_55_0._arrUpVan, false)

		setActive = var_55_22

		var_55_22(arg_55_0._arrDownVan, false)

		setActive = var_55_22

		var_55_22(arg_55_0._arrUpMain, false)

		setActive = var_55_22

		var_55_22(arg_55_0._arrDownMain, false)

		tonumber = var_55_22
		arg_55_0.prevVanGS = var_55_22(arg_55_0._vanGSTxt.text)
		var_55_22 = arg_55_0.tweenNumText

		local var_55_23 = arg_55_0._vanguardGS

		var_55_22(var_9.Find(var_55_23, "Text"), var_55_6)

		if arg_55_0.VanGSInited then
			setActive = var_55_22

			var_55_22(arg_55_0._arrUpVan, var_55_6 > arg_55_0.prevVanGS)

			setActive = var_55_22

			var_55_22(arg_55_0._arrDownVan, var_55_6 < arg_55_0.prevVanGS)
		end

		tonumber = var_55_22
		arg_55_0.prevMainGS = var_55_22(arg_55_0._mainGSTxt.text)
		var_55_22 = arg_55_0.tweenNumText

		local var_55_24 = arg_55_0._mainGS

		var_55_22(var_9.Find(var_55_24, "Text"), var_55_10)

		if arg_55_0.mainGSInited then
			setActive = var_55_22

			var_55_22(arg_55_0._arrUpMain, var_55_10 > arg_55_0.prevMainGS)

			setActive = var_55_22

			var_55_22(arg_55_0._arrDownMain, var_55_10 < arg_55_0.prevMainGS)
		end

		var_55_22 = arg_55_0.contextData
		var_55_22.mainGS = var_55_10
		var_55_22 = arg_55_0.contextData
		var_55_22.vanGS = var_55_6
		arg_55_0.mainGSInited = true
		arg_55_0.VanGSInited = true

		local var_55_25 = arg_55_0._currentFleetVO

		var_55_22 = var_55_22.GetFleetSonarRange(var_55_25)
		setActive = var_55_20

		local var_55_26 = arg_55_0._vanguardGS

		var_55_20(var_10.Find(var_55_26, "SonarActive"), var_55_22 > 0)

		setActive = var_55_20

		local var_55_27 = arg_55_0._vanguardGS

		var_55_20(var_10.Find(var_55_27, "SonarInactive"), var_55_22 <= 0)

		local function var_55_28()
			pg = var_2_10000

			local var_56_0 = var_2_10000.MsgboxMgr.GetInstance()
			local var_56_1 = var_0.ShowMsgBox
			local var_56_2 = {}

			MSGBOX_TYPE_HELP = var_2_10004
			var_56_2.type = var_2_10004
			pg = var_2_10004
			var_56_2.helps = var_2_10004.gametip.fleet_antisub_range_tip.tip

			var_56_1(var_56_0, var_56_2)

			return
		end

		if 0 < var_55_22 then
			setText = var_9

			local var_55_29 = arg_55_0._vanguardGS
			local var_55_30 = var_11.Find(var_55_29, "SonarActive/Text")

			math = var_55_27

			var_9(var_55_30, var_55_27.floor(var_55_22))

			onButton = var_9

			local var_55_31 = arg_55_0
			local var_55_32 = arg_55_0._vanguardGS
			local var_55_33 = var_12.Find(var_55_32, "SonarActive")
			local var_55_34 = var_55_28

			SFX_PANEL = var_55_32

			var_9(var_55_31, var_55_33, var_55_34, var_55_32)
		else
			onButton = var_9

			local var_55_35 = arg_55_0
			local var_55_36 = arg_55_0._vanguardGS
			local var_55_37 = var_12.Find(var_55_36, "SonarInactive")
			local var_55_38 = var_55_28

			SFX_PANEL = var_55_36

			var_9(var_55_35, var_55_37, var_55_38, var_55_36)
		end
	else
		FleetType = var_55_22

		if var_55_21 == var_55_22.Submarine then
			setActive = var_7

			var_7(arg_55_0._arrUpSub, false)

			setActive = var_7

			var_7(arg_55_0._arrDownSub, false)

			setActive = var_7

			var_7(arg_55_0._subGS, true)

			tonumber = var_7
			arg_55_0.prevSubGS = var_7(arg_55_0._subGSTxt.text)

			local var_55_39 = arg_55_0.tweenNumText
			local var_55_40 = arg_55_0._subGS

			var_55_39(var_9.Find(var_55_40, "Text"), var_55_14)

			if arg_55_0.SubGSInited then
				setActive = var_7

				var_7(arg_55_0._arrUpSub, var_55_14 > arg_55_0.prevSubGS)

				setActive = var_7

				var_7(arg_55_0._arrDownSub, var_55_14 < arg_55_0.prevSubGS)
			end

			arg_55_0.contextData.subGS = var_55_14
			arg_55_0.SubGSInited = true
		end
	end

	arg_55_0:SetFleetNameLabel()

	setText = var_7

	local var_55_41 = arg_55_0._fleetNumText
	local var_55_42 = arg_55_0._currentFleetVO

	var_7(var_55_41, var_10.getIndex(var_55_42))

	return
end

function var_0_1.DisplayRenamePanel(arg_57_0, arg_57_1)
	SetActive = var_1_10002

	var_1_10002(arg_57_0._renamePanel, arg_57_1)

	if arg_57_1 then
		pg = var_1_10002

		local var_57_0 = var_1_10002.UIMgr.GetInstance()

		var_1_10002.BlurPanel(var_57_0, arg_57_0._renamePanel)

		getText = var_1_10002
		var_1_10002 = var_1_10002(arg_57_0._fleetNameText)
		setInputText = var_1_10003
		findTF = var_5

		var_1_10003(var_5(arg_57_0._renamePanel, "frame/name_field"), var_1_10002)
	else
		pg = var_1_10002

		local var_57_1 = var_1_10002.UIMgr.GetInstance()

		var_2.UnOverlayPanel(var_57_1, arg_57_0._renamePanel, arg_57_0._tf)
	end

	return
end

function var_0_1.hideAttrFrame(arg_58_0)
	SetActive = var_1_10001

	var_1_10001(arg_58_0._attrFrame, false)

	pg = var_1_10001

	local var_58_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_58_0, arg_58_0._blurLayer, arg_58_0._tf)

	return
end

function var_0_1.displayAttrFrame(arg_59_0)
	pg = var_1_10001

	local var_59_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_59_0, arg_59_0._blurLayer)

	SetActive = var_1

	var_1(arg_59_0._attrFrame, true)
	arg_59_0:initAttrFrame()

	return
end

function var_0_1.initAttrFrame(arg_60_0)
	local var_60_0 = {}

	TeamType = var_1_10002
	var_60_0[var_1_10002.Main] = arg_60_0._currentFleetVO.mainShips
	TeamType = var_2
	var_60_0[var_2.Vanguard] = arg_60_0._currentFleetVO.vanguardShips
	TeamType = var_2
	var_60_0[var_2.Submarine] = arg_60_0._currentFleetVO.subShips

	local var_60_1 = false

	pairs = var_3

	for iter_60_0, iter_60_1 in var_3(var_60_0) do
		if #arg_60_0._cards[iter_60_0] == 0 then
			local var_60_2 = arg_60_0._attrFrame
			local var_60_3 = var_9.Find(var_60_2, iter_60_0 .. "/list")

			for iter_60_2 = 1, 3 do
				cloneTplTo = var_1_10014
				var_1_10014 = var_1_10014(arg_60_0._cardTpl, var_60_3).gameObject
				table = var_1_10015
				var_1_10015 = var_1_10015.insert

				local var_60_4 = var_8

				FormationDetailCard = var_1_10018

				var_1_10015(var_60_4, var_1_10018.New(var_1_10014))
			end

			var_60_1 = true
		end
	end

	if var_60_1 then
		arg_60_0:updateAttrFrame()
	end

	return
end

function var_0_1.updateAttrFrame(arg_61_0)
	local var_61_0 = {}

	TeamType = var_1_10002
	var_61_0[var_1_10002.Main] = arg_61_0._currentFleetVO.mainShips
	TeamType = var_2
	var_61_0[var_2.Vanguard] = arg_61_0._currentFleetVO.vanguardShips
	TeamType = var_2
	var_61_0[var_2.Submarine] = arg_61_0._currentFleetVO.subShips

	local var_61_1 = arg_61_0._currentFleetVO
	local var_61_2 = var_2.getFleetType(var_61_1)

	pairs = var_3

	for iter_61_0, iter_61_1 in var_3(var_61_0) do
		if #arg_61_0._cards[iter_61_0] > 0 then
			FleetType = var_9

			if var_61_2 == var_9.Submarine then
				TeamType = var_9

				local var_61_3

				if iter_61_0 ~= var_9.Vanguard then
					var_61_3 = false
				else
					var_61_3 = true
				end

				for iter_61_2 = 1, 3 do
					if iter_61_2 <= #iter_61_1 then
						local var_61_4 = arg_61_0.shipVOs[iter_61_1[iter_61_2]]
						local var_61_5 = var_1_10008[iter_61_2]

						var_15.update(var_61_5, var_61_4, var_61_3)

						local var_61_6 = var_1_10008[iter_61_2]

						var_15.updateProps(var_61_6, arg_61_0:getCardAttrProps(var_61_4))
					else
						local var_61_7 = var_1_10008[iter_61_2]

						var_14.update(var_61_7, nil, var_61_3)
					end

					arg_61_0:detachOnCardButton(var_1_10008[iter_61_2])

					if not var_61_3 then
						arg_61_0:attachOnCardButton(var_1_10008[iter_61_2], iter_61_0)
					end
				end
			end
		end
	end

	setActive = var_3

	local var_61_8 = arg_61_0._attrFrame
	local var_61_9 = var_5.Find

	TeamType = var_1_10008

	local var_61_10 = var_61_9(var_61_8, var_1_10008.Main)

	FleetType = iter_61_0

	var_3(var_61_10, var_61_2 == iter_61_0.Normal)

	setActive = var_3

	local var_61_11 = arg_61_0._attrFrame
	local var_61_12 = var_5.Find

	TeamType = var_8

	local var_61_13 = var_61_12(var_61_11, var_8.Submarine)

	FleetType = var_6

	var_3(var_61_13, var_61_2 == var_6.Submarine)

	setActive = var_3

	local var_61_14 = arg_61_0._attrFrame
	local var_61_15 = var_5.Find

	TeamType = var_8

	local var_61_16 = var_61_15(var_61_14, var_8.Vanguard .. "/vanguard")

	FleetType = var_6

	var_3(var_61_16, var_61_2 ~= var_6.Submarine)
	arg_61_0:updateUltimateTitle()

	return
end

function var_0_1.updateUltimateTitle(arg_62_0)
	local var_62_0 = arg_62_0._cards

	TeamType = var_1_10002

	local var_62_1 = var_62_0[var_1_10002.Main]
	local var_62_2 = arg_62_0._currentFleetVO.mainShips

	if #var_62_1 > 0 then
		for iter_62_0 = 1, #var_62_1 do
			go = var_1_10007

			local var_62_3 = var_1_10007(var_62_1[iter_62_0].shipState)

			var_1_10007.SetActive(var_62_3, iter_62_0 == 1)
		end
	end

	return
end

function var_0_1.getCardAttrProps(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_1:getProperties()
	local var_63_1 = arg_63_1:getShipCombatPower()
	local var_63_2 = arg_63_1:getBattleTotalExpend()
	local var_63_3 = {}
	local var_63_4 = {}

	i18n = var_1_10007
	var_63_4[1] = var_1_10007("word_attr_durability")
	tostring = var_7
	math = var_9
	var_63_4[2] = var_7(var_9.floor(var_63_0.durability))
	var_63_3[1] = var_63_4

	local var_63_5 = {}

	i18n = var_7
	var_63_5[1] = var_7("word_attr_luck")

	local var_63_6 = ""

	tostring = var_1_10008
	math = var_1_10010
	var_63_5[2] = var_63_6 .. var_1_10008(var_1_10010.floor(var_63_2))
	var_63_3[2] = var_63_5

	local var_63_7 = {}

	i18n = var_7
	var_63_7[1] = var_7("word_synthesize_power")
	var_63_7[2] = "<color=#ffff00>" .. var_63_1 .. "</color>"
	var_63_3[3] = var_63_7

	return var_63_3
end

function var_0_1.detachOnCardButton(arg_64_0, arg_64_1)
	GetOrAddComponent = var_1_10002

	local var_64_0 = var_1_10002(arg_64_1.go, "EventTriggerListener")

	var_2.RemovePointClickFunc(var_64_0)
	var_2:RemoveBeginDragFunc()
	var_2:RemoveDragFunc()
	var_2:RemoveDragEndFunc()

	return
end

function var_0_1.attachOnCardButton(arg_65_0, arg_65_1, arg_65_2)
	GetOrAddComponent = var_1_10003

	local var_65_0 = var_1_10003(arg_65_1.go, "EventTriggerListener")

	arg_65_0.eventTriggers[var_65_0] = true

	var_65_0:AddPointClickFunc(function(arg_66_0, arg_66_1)
		if not arg_65_0.carddrag and arg_66_0 == arg_65_1.go then
			local var_66_1

			if arg_65_1.shipVO then
				local var_66_0 = arg_65_0

				var_66_1 = var_66_1.emit
				FormationMediator = var_2_10005

				var_66_1(var_66_0, var_2_10005.OPEN_SHIP_INFO, arg_65_1.shipVO.id, arg_65_0._currentFleetVO, var_0_1.TOGGLE_DETAIL)
			else
				local var_66_2 = arg_65_0

				var_66_1 = var_66_1.emit
				FormationMediator = var_2_10005

				var_66_1(var_66_2, var_2_10005.CHANGE_FLEET_SHIP, arg_65_1.shipVO, arg_65_0._currentFleetVO, var_0_1.TOGGLE_DETAIL, arg_65_2)
			end

			pg = var_66_1

			local var_66_3 = var_66_1.CriMgr.GetInstance()
			local var_66_4 = var_2.PlaySoundEffect_V3

			SFX_PANEL = var_2_10005

			var_66_4(var_66_3, var_2_10005)
		end

		return
	end)

	if arg_65_1.shipVO then
		local var_65_1 = arg_65_0._cards[arg_65_2]
		local var_65_2 = arg_65_1.tr.parent
		local var_65_3 = var_5.GetComponent(var_65_2, "ContentSizeFitter")
		local var_65_4 = arg_65_1.tr.parent
		local var_65_5 = var_6.GetComponent(var_65_4, "HorizontalLayoutGroup")
		local var_65_6 = arg_65_1.tr.rect.width * 0.5
		local var_65_7 = {}

		var_65_0:AddBeginDragFunc(function()
			if arg_65_0.carddrag then
				return
			end

			arg_65_0._currentDragDelegate = var_65_0
			arg_65_0.carddrag = arg_65_1
			var_65_3.enabled = false
			var_65_5.enabled = false

			local var_67_0 = arg_65_1.tr

			var_0.SetSiblingIndex(var_67_0, #var_65_1)

			for iter_67_0 = 1, #var_65_1 do
				if var_65_1[iter_67_0] == arg_65_1 then
					arg_65_0._shiftIndex = iter_67_0
				end

				var_65_7[iter_67_0] = var_65_1[iter_67_0].tr.anchoredPosition
			end

			LeanTween = var_0

			local var_67_1 = var_0.scale
			local var_67_2 = arg_65_1.paintingTr

			Vector3 = iter_67_0

			var_67_1(var_67_2, iter_67_0(1.1, 1.1, 0), 0.3)

			return
		end)
		var_65_0:AddDragFunc(function(arg_68_0, arg_68_1)
			if arg_65_0.carddrag ~= arg_65_1 then
				return
			end

			local var_68_0 = arg_65_1.tr.localPosition
			local var_68_1 = arg_65_0

			var_68_0.x = var_3.change2ScrPos(var_68_1, arg_65_1.tr.parent, arg_68_1.position).x
			arg_65_1.tr.localPosition = var_68_0

			local var_68_2 = 1

			for iter_68_0 = 1, #var_65_1 do
				if var_65_1[iter_68_0] ~= arg_65_1 and var_65_1[iter_68_0].shipVO and arg_65_1.tr.localPosition.x > var_65_1[iter_68_0].tr.localPosition.x + (var_68_2 < arg_65_0._shiftIndex and 1.1 or -1.1) * var_65_6 then
					var_68_2 = var_68_2 + 1
				end
			end

			if arg_65_0._shiftIndex ~= var_68_2 then
				local var_68_3 = arg_65_0._formationLogic

				var_4.Shift(var_68_3, arg_65_0._shiftIndex, var_68_2, arg_65_2)

				local var_68_4 = arg_65_0

				var_4.shiftCard(var_68_4, arg_65_0._shiftIndex, var_68_2, arg_65_2)

				for iter_68_1 = 1, #var_65_1 do
					if var_65_1[iter_68_1] and var_65_1[iter_68_1] ~= arg_65_1 then
						var_65_1[iter_68_1].tr.anchoredPosition = var_65_7[iter_68_1]
					end
				end
			end

			return
		end)
		var_65_0:AddDragEndFunc(function(arg_69_0, arg_69_1)
			if arg_65_0.carddrag ~= arg_65_1 then
				return
			end

			local function var_69_0()
				for iter_70_0 = 1, #var_65_1 do
					var_65_1[iter_70_0].tr.anchoredPosition = var_65_7[iter_70_0]
				end

				var_65_3.enabled = true
				var_65_5.enabled = true
				arg_65_0._shiftIndex = nil

				local var_70_0 = arg_65_0

				var_0.updateUltimateTitle(var_70_0)

				local var_70_1 = arg_65_0._formationLogic

				var_0.SortSiblingIndex(var_70_1)

				local var_70_2 = arg_65_0

				var_0.sortCardSiblingIndex(var_70_2)

				local var_70_3 = arg_65_0
				local var_70_4 = var_0.emit

				FormationMediator = iter_70_0

				var_70_4(var_70_3, iter_70_0.CHANGE_FLEET_SHIPS_ORDER, arg_65_0._currentFleetVO)

				var_65_0.enabled = true
				arg_65_0.carddrag = nil

				return
			end

			local var_69_1 = resetCard
			local var_69_2 = arg_65_0._forceDropCharacter

			arg_65_0._forceDropCharacter = nil
			arg_65_0._currentDragDelegate = nil

			local var_69_3 = var_65_0

			var_69_3.enabled = false

			if var_69_2 then
				resetCard = var_69_3

				var_69_3()

				var_69_3 = arg_65_1.paintingTr
				Vector3 = var_4
				var_69_3.localScale = var_4(1, 1, 0)
			else
				math = var_69_3

				local var_69_4 = var_69_3.min

				math = var_2_10005

				local var_69_5 = var_69_4(var_2_10005.abs(arg_65_1.tr.anchoredPosition.x - var_65_7[arg_65_0._shiftIndex].x) / 200, 1) * 0.3

				LeanTween = var_4

				local var_69_6 = var_4.value(arg_65_1.go, arg_65_1.tr.anchoredPosition.x, var_65_7[arg_65_0._shiftIndex].x, var_69_5)
				local var_69_7 = var_4.setEase

				LeanTweenType = var_7

				local var_69_8 = var_69_7(var_69_6, var_7.easeOutCubic)
				local var_69_9 = var_4.setOnUpdate

				System = var_7

				local var_69_10 = var_69_9(var_69_8, var_7.Action_float(function(arg_71_0)
					local var_71_0 = arg_65_1.tr.anchoredPosition

					var_71_0.x = arg_71_0
					arg_65_1.tr.anchoredPosition = var_71_0

					return
				end))
				local var_69_11 = var_4.setOnComplete

				System = var_7

				var_69_11(var_69_10, var_7.Action(function()
					resetCard = var_3_10000

					var_3_10000()

					LeanTween = var_3_10000

					local var_72_0 = var_3_10000.scale
					local var_72_1 = arg_65_1.paintingTr

					Vector3 = var_3_10003

					var_72_0(var_72_1, var_3_10003(1, 1, 0), 0.3)

					return
				end))
			end

			return
		end)
	end

	return
end

function var_0_1.shiftCard(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
	if #arg_73_0._cards[arg_73_3] > 0 then
		var_4[arg_73_1], var_4[arg_73_2] = var_4[arg_73_2], var_4[arg_73_1]
	end

	arg_73_0._shiftIndex = arg_73_2

	return
end

function var_0_1.change2ScrPos(arg_74_0, arg_74_1, arg_74_2)
	pg = var_1_10003

	local var_74_0 = var_1_10003.UIMgr.GetInstance().overlayCameraComp

	LuaHelper = var_1_10004

	return (var_1_10004.ScreenToLocal(arg_74_1, arg_74_2, var_74_0))
end

function var_0_1.tweenNumText(arg_75_0, arg_75_1, arg_75_2, arg_75_3, arg_75_4)
	LeanTween = var_1_10005

	local var_75_0 = var_1_10005.value

	go = var_1_10007

	local var_75_1 = var_1_10007(arg_75_0)
	local var_75_2 = arg_75_4 or 0

	math = var_9

	local var_75_3 = var_75_0(var_75_1, var_75_2, var_9.floor(arg_75_1), arg_75_2 or 0.7)
	local var_75_4 = var_5.setOnUpdate

	System = var_75_2

	local var_75_5 = var_75_4(var_75_3, var_75_2.Action_float(function(arg_76_0)
		setText = var_2_10001

		local var_76_0 = arg_75_0

		math = var_2_10004

		var_2_10001(var_76_0, var_2_10004.floor(arg_76_0))

		return
	end))
	local var_75_6 = var_5.setOnComplete

	System = var_8

	var_75_6(var_75_5, var_8.Action(function()
		if arg_75_3 then
			arg_75_3()
		end

		return
	end))

	return
end

function var_0_1.defaultFleetName(arg_78_0)
	if arg_78_0.name == "" or arg_78_0.name == nil then
		Fleet = var_1

		return var_1.DEFAULT_NAME[arg_78_0.id]
	else
		return arg_78_0.name
	end

	return
end

function var_0_1.GetFleetCount(arg_79_0)
	local var_79_0 = 0

	pairs = var_1_10002

	for iter_79_0, iter_79_1 in var_1_10002(arg_79_0._fleetVOs) do
		var_79_0 = var_79_0 + 1
	end

	return var_79_0
end

function var_0_1.tweenTabArrow(arg_80_0, arg_80_1)
	local var_80_0 = arg_80_0.btnRegular
	local var_80_1 = var_2.Find(var_80_0, "arr")
	local var_80_2 = arg_80_0.btnSub
	local var_80_3 = var_3.Find(var_80_2, "arr")

	setActive = var_80_0

	var_80_0(var_80_1, arg_80_1)

	setActive = var_80_0

	var_80_0(var_80_3, arg_80_1)

	local var_80_4

	if arg_80_1 then
		LeanTween = var_80_0
		var_80_0 = var_80_0.moveLocalY
		go = var_80_4
		var_80_4 = var_80_0(var_80_4(var_80_1), var_80_1.localPosition.y + 8, 0.8)
		var_80_0 = var_80_0.setEase
		LeanTweenType = var_7
		var_80_4 = var_80_0(var_80_4, var_7.easeInOutSine)

		var_80_0.setLoopPingPong(var_80_4, -1)

		LeanTween = var_80_0
		var_80_0 = var_80_0.moveLocalY
		go = var_80_4
		var_80_4 = var_80_0(var_80_4(var_80_3), var_80_3.localPosition.y + 8, 0.8)
		var_80_0 = var_80_0.setEase
		LeanTweenType = var_7
		var_80_4 = var_80_0(var_80_4, var_7.easeInOutSine)

		var_80_0.setLoopPingPong(var_80_4, -1)
	else
		LeanTween = var_80_0

		local var_80_5 = var_80_0.cancel

		go = var_80_4

		var_80_5(var_80_4(var_80_1))

		LeanTween = var_80_5

		local var_80_6 = var_80_5.cancel

		go = var_6

		var_80_6(var_6(var_80_3))

		local var_80_7 = var_80_1.localPosition

		var_80_7.y = 80
		var_80_1.localPosition = var_80_7

		local var_80_8 = var_80_3.localPosition

		var_80_8.y = 80
		var_80_3.localPosition = var_80_8
	end

	return
end

function var_0_1.recyclePainting(arg_81_0)
	pairs = var_1_10001

	for iter_81_0, iter_81_1 in var_1_10001(arg_81_0._cards) do
		ipairs = var_1_10006

		for iter_81_2, iter_81_3 in var_1_10006(iter_81_1) do
			iter_81_3:clear()
		end
	end

	return
end

function var_0_1.onBackPressed(arg_82_0)
	pg = var_1_10001

	local var_82_0 = var_1_10001.CriMgr.GetInstance()
	local var_82_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_82_1(var_82_0, var_1_10004)

	isActive = var_82_1

	if var_82_1(arg_82_0._renamePanel) then
		arg_82_0:DisplayRenamePanel(false)
	else
		triggerButton = var_1

		var_1(arg_82_0.backBtn)
	end

	return
end

function var_0_1.willExit(arg_83_0)
	local var_83_0 = arg_83_0.commanderFormationPanel

	var_1.Destroy(var_83_0)

	if arg_83_0._attrFrame.gameObject.activeSelf then
		pg = var_1

		local var_83_1 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_83_1, arg_83_0._blurLayer, arg_83_0._tf)
	end

	local var_83_2 = arg_83_0._formationLogic

	var_1.Destroy(var_83_2)
	arg_83_0:recyclePainting()
	arg_83_0:DisplayRenamePanel(false)
	arg_83_0:tweenTabArrow(false)

	if arg_83_0.tweens then
		cancelTweens = var_1

		var_1(arg_83_0.tweens)
	end

	if arg_83_0.eventTriggers then
		pairs = var_1

		for iter_83_0, iter_83_1 in var_1(arg_83_0.eventTriggers) do
			ClearEventTrigger = var_1_10006

			var_1_10006(iter_83_0)
		end

		arg_83_0.eventTriggers = nil
	end

	return
end

return var_0_1
