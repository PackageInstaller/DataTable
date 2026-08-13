class = var_0_10000

local var_0_0 = "WorldDetailLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

import = var_0_0

local var_0_2 = var_0_0("..ship.FormationUI")

function var_0_1.getUIName(arg_1_0)
	return "WorldDetailUI"
end

var_0_1.TOGGLE_DETAIL = "detailToggle"
var_0_1.TOGGLE_FORMATION = "formationToggle"

function var_0_1.init(arg_2_0)
	arg_2_0.eventTriggers = {}

	local var_2_0 = arg_2_0._tf

	arg_2_0.rtMain = var_1.Find(var_2_0, "main")

	local var_2_1 = arg_2_0.rtMain

	arg_2_0.bgFleet = var_1.Find(var_2_1, "bg_fleet")

	local var_2_2 = arg_2_0.rtMain

	arg_2_0.bgSub = var_1.Find(var_2_2, "bg_sub")

	local var_2_3 = arg_2_0.rtMain

	arg_2_0.vanguardGS = var_1.Find(var_2_3, "gear_score/vanguard")

	local var_2_4 = arg_2_0.vanguardGS

	arg_2_0.vanguardUpGS = var_1.Find(var_2_4, "up")

	local var_2_5 = arg_2_0.vanguardGS

	arg_2_0.vanguardDownGS = var_1.Find(var_2_5, "down")

	local var_2_6 = arg_2_0.rtMain

	arg_2_0.mainGS = var_1.Find(var_2_6, "gear_score/main")

	local var_2_7 = arg_2_0.mainGS

	arg_2_0.mainUpGS = var_1.Find(var_2_7, "up")

	local var_2_8 = arg_2_0.mainGS

	arg_2_0.mainDownGS = var_1.Find(var_2_8, "down")

	local var_2_9 = arg_2_0.rtMain

	arg_2_0.subGS = var_1.Find(var_2_9, "gear_score/submarine")

	local var_2_10 = arg_2_0.subGS

	arg_2_0.subUpGS = var_1.Find(var_2_10, "up")

	local var_2_11 = arg_2_0.subGS

	arg_2_0.subDownGS = var_1.Find(var_2_11, "down")
	setText = var_1

	local var_2_12 = arg_2_0.mainGS
	local var_2_13 = var_2.Find(var_2_12, "Text")
	local var_2_14

	if not arg_2_0.contextData.mainGS then
		var_2_14 = 0
	end

	var_1(var_2_13, var_2_14)

	setText = var_1

	local var_2_15 = arg_2_0.vanguardGS
	local var_2_16 = var_2.Find(var_2_15, "Text")
	local var_2_17

	if not arg_2_0.contextData.vanGS then
		var_2_17 = 0
	end

	var_1(var_2_16, var_2_17)

	setText = var_1

	local var_2_18 = arg_2_0.subGS
	local var_2_19 = var_2.Find(var_2_18, "Text")
	local var_2_20

	if not arg_2_0.contextData.subGS then
		var_2_20 = 0
	end

	var_1(var_2_19, var_2_20)

	local var_2_21 = {}

	TeamType = var_2_19
	var_2_21[var_2_19.Vanguard] = {}
	TeamType = var_2
	var_2_21[var_2.Main] = {}
	TeamType = var_2
	var_2_21[var_2.Submarine] = {}
	arg_2_0.gridTFs = var_2_21

	local var_2_22 = arg_2_0.rtMain

	arg_2_0.gridFrame = var_1.Find(var_2_22, "GridFrame")

	for iter_2_0 = 1, 3 do
		local var_2_23 = arg_2_0.gridTFs

		TeamType = var_1_10006

		local var_2_24 = var_2_23[var_1_10006.Vanguard]
		local var_2_25 = arg_2_0.gridFrame

		var_2_24[iter_2_0] = var_1_10006.Find(var_2_25, "vanguard_" .. iter_2_0)

		local var_2_26 = arg_2_0.gridTFs

		TeamType = var_1_10006

		local var_2_27 = var_2_26[var_1_10006.Main]
		local var_2_28 = arg_2_0.gridFrame

		var_2_27[iter_2_0] = var_1_10006.Find(var_2_28, "main_" .. iter_2_0)

		local var_2_29 = arg_2_0.gridTFs

		TeamType = var_1_10006

		local var_2_30 = var_2_29[var_1_10006.Submarine]
		local var_2_31 = arg_2_0.gridFrame

		var_2_30[iter_2_0] = var_1_10006.Find(var_2_31, "submarine_" .. iter_2_0)
	end

	local var_2_32 = arg_2_0.rtMain

	arg_2_0.nextPage = var_1.Find(var_2_32, "nextPage")

	local var_2_33 = arg_2_0.rtMain

	arg_2_0.prevPage = var_1.Find(var_2_33, "prevPage")

	local var_2_34 = arg_2_0.rtMain

	arg_2_0.heroContainer = var_1.Find(var_2_34, "HeroContainer")

	local var_2_35 = arg_2_0._tf

	arg_2_0.blurLayer = var_1.Find(var_2_35, "blur_container")

	local var_2_36 = arg_2_0.blurLayer

	arg_2_0.top = var_1.Find(var_2_36, "top")

	local var_2_37 = arg_2_0.top

	arg_2_0.backBtn = var_1.Find(var_2_37, "back_btn")

	local var_2_38 = arg_2_0.top

	arg_2_0.playerResOb = var_1.Find(var_2_38, "res")
	WorldResource = var_1
	arg_2_0.resPanel = var_1.New()
	tf = var_1

	local var_2_39 = var_1(arg_2_0.resPanel._go)
	local var_2_40 = var_1.SetParent

	tf = var_3

	var_2_40(var_2_39, var_3(arg_2_0.playerResOb), false)

	local var_2_41 = arg_2_0.blurLayer

	arg_2_0.fleetToggleList = var_1.Find(var_2_41, "bottom/fleet_select/panel")

	local var_2_42 = arg_2_0.blurLayer

	arg_2_0.detailToggle = var_1.Find(var_2_42, "bottom/toggle_list/detail_toggle")

	local var_2_43 = arg_2_0.blurLayer

	arg_2_0.formationToggle = var_1.Find(var_2_43, "bottom/toggle_list/formation_toggle")

	local var_2_44 = arg_2_0.blurLayer

	arg_2_0.attrFrame = var_1.Find(var_2_44, "attr_frame")

	local var_2_45 = arg_2_0._tf

	arg_2_0.cardTpl = var_1.Find(var_2_45, "RectShipCardTpl")
	arg_2_0.cards = {}

	local var_2_46 = arg_2_0.cards

	TeamType = var_2_45
	var_2_46[var_2_45.Main] = {}

	local var_2_47 = arg_2_0.cards

	TeamType = var_2
	var_2_47[var_2.Vanguard] = {}

	local var_2_48 = arg_2_0.cards

	TeamType = var_2
	var_2_48[var_2.Submarine] = {}
	setActive = var_2_48

	var_2_48(arg_2_0.attrFrame, false)

	setActive = var_2_48

	var_2_48(arg_2_0.cardTpl, false)

	local var_2_49 = arg_2_0._tf

	arg_2_0.heroInfo = var_1.Find(var_2_49, "heroInfo")

	local var_2_50 = arg_2_0._tf

	arg_2_0.starTpl = var_1.Find(var_2_50, "star_tpl")
	WorldCommanderFormationPage = var_1
	arg_2_0.commanderFormationPanel = var_1.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)
	arg_2_0.fleetIndex = 1
	BaseFormation = var_1
	arg_2_0.formationLogic = var_1.New(arg_2_0._tf, arg_2_0.heroContainer, arg_2_0.heroInfo, arg_2_0.gridTFs)

	local var_2_51 = arg_2_0.formationLogic

	var_1.DisableTip(var_2_51)
	arg_2_0:Register()

	return
end

function var_0_1.Register(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)
	local var_3_1 = var_1.getBuffShipList(var_3_0)
	local var_3_2 = arg_3_0.formationLogic

	var_2.AddLoadComplete(var_3_2, function()
		local var_4_0 = arg_3_0

		var_0.displayFleetInfo(var_4_0)

		pg = var_0

		local var_4_1 = var_0.UIMgr.GetInstance()

		var_0.LoadingOff(var_4_1)

		return
	end)

	local var_3_3 = arg_3_0.formationLogic

	var_2.AddHeroInfoModify(var_3_3, function(arg_5_0, arg_5_1, arg_5_2)
		WorldConst = var_2_10003

		local var_5_0 = var_2_10003.FetchWorldShip(arg_5_1.id)
		local var_5_1 = arg_5_1
		local var_5_2 = arg_5_1.getConfigTable(var_5_1)

		pg = var_5_1

		local var_5_3 = var_5_1.ship_data_template[arg_5_1.configId]

		findTF = var_6

		local var_5_4 = var_6(arg_5_0, "info")

		findTF = var_7

		local var_5_5 = var_7(var_5_4, "stars")

		findTF = var_8

		local var_5_6 = var_8(var_5_4, "energy")
		local var_5_7 = arg_5_1:getStar()

		for iter_5_0 = 1, var_5_7 do
			cloneTplTo = var_2_10014

			var_2_10014(arg_3_0.starTpl, var_5_5)
		end

		local var_5_8 = arg_5_1
		local var_5_9 = arg_5_1.getEnergy(var_5_8)

		Ship = var_5_8

		local var_5_10 = var_5_9 <= var_5_8.ENERGY_MID

		findTF = var_11

		local var_5_11 = var_11(var_5_4, "energy")
		local var_5_12

		if var_5_10 then
			local var_5_13

			var_5_12, var_5_13 = arg_5_1:getEnergyPrint()
			GetSpriteFromAtlas = var_2_10014

			if not var_2_10014("energy", var_5_12) then
				warning = var_15

				var_15("找不到疲劳")
			end

			setImageSprite = var_15

			var_15(var_5_11, var_14)
		end

		setActive = var_5_12

		var_5_12(var_5_11, var_5_10)

		local var_5_14 = var_3_1[arg_5_1:getGroupId()]
		local var_5_15 = var_5_4
		local var_5_16 = var_5_4.Find(var_5_15, "expbuff")

		setActive = var_5_15

		var_5_15(var_5_16, var_5_14 ~= nil)

		local var_5_18

		if var_5_14 then
			var_5_15 = var_5_14 / 100

			local var_5_17 = var_5_14 % 100

			tostring = var_5_18
			var_5_18 = var_5_18(var_5_15)

			local var_5_19

			if 0 < var_5_17 then
				var_5_19 = var_5_18

				local var_5_20 = "."

				tostring = var_2_10019
				var_5_18 = var_5_19 .. var_5_20 .. var_2_10019(var_5_17)
			end

			setText = var_5_19

			local var_5_21 = var_5_16
			local var_5_22 = var_5_16.Find(var_5_21, "text")

			string = var_5_21

			var_5_19(var_5_22, var_5_21.format("EXP +%s%%", var_5_18))
		end

		GetSpriteFromAtlas = var_5_15

		local var_5_23 = "shiptype"

		shipType2print = var_5_18

		if not var_5_15(var_5_23, var_5_18(arg_5_1:getShipType())) then
			warning = var_5_23

			var_5_23("找不到船形, shipConfigId: " .. arg_5_1.configId)
		end

		setImageSprite = var_5_23
		findTF = var_16

		var_5_23(var_16(var_5_4, "type"), var_14, true)

		setText = var_5_23
		findTF = var_16

		var_5_23(var_16(var_5_4, "frame/lv_contain/lv"), arg_5_1.level)

		local var_5_24 = var_5_0
		local var_5_25 = var_5_0.IsHpSafe(var_5_24)

		findTF = var_5_24

		local var_5_26 = var_5_24(var_5_4, "blood")

		findTF = var_17

		local var_5_27 = var_17(var_5_26, "fillarea/green")

		findTF = var_18

		local var_5_28 = var_18(var_5_26, "fillarea/red")

		setActive = var_19

		var_19(var_5_27, var_5_25)

		setActive = var_19

		var_19(var_5_28, not var_5_25)

		local var_5_29 = var_5_26
		local var_5_30 = var_5_26.GetComponent

		typeof = var_21
		Slider = var_2_10022

		local var_5_31 = var_5_30(var_5_29, var_21(var_2_10022))

		var_5_31.fillRect = var_5_25 and var_5_27 or var_5_28
		setSlider = var_5_31

		var_5_31(var_5_26, 0, 10000, var_5_0.hpRant)

		setActive = var_5_31

		var_5_31(var_5_26:Find("broken"), var_5_0:IsBroken())

		return
	end)

	local var_3_4 = arg_3_0.formationLogic

	var_2.AddCheckRemove(var_3_4, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		arg_6_0()

		return
	end)

	local var_3_5 = arg_3_0.formationLogic

	var_2.AddLongPress(var_3_5, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_3_0
		local var_7_1 = var_3.emit

		WorldDetailMediator = var_2_10005

		var_7_1(var_7_0, var_2_10005.OnShipInfo, arg_7_1.id)

		pg = var_7_1

		local var_7_2 = var_7_1.CriMgr.GetInstance()
		local var_7_3 = var_3.PlaySoundEffect_V3

		SFX_PANEL = var_5

		var_7_3(var_7_2, var_5)

		return
	end)

	local var_3_6 = arg_3_0.formationLogic

	var_2.AddBeginDrag(var_3_6, function(arg_8_0)
		findTF = var_2_10001

		local var_8_0 = var_2_10001(arg_8_0, "info")

		SetActive = var_2

		var_2(var_8_0, false)

		return
	end)

	local var_3_7 = arg_3_0.formationLogic

	var_2.AddEndDrag(var_3_7, function(arg_9_0)
		findTF = var_2_10001

		local var_9_0 = var_2_10001(arg_9_0, "info")

		SetActive = var_2

		var_2(var_9_0, true)

		return
	end)

	return
end

function var_0_1.didEnter(arg_10_0)
	arg_10_0:OverlayPanel(arg_10_0._tf)

	onButton = var_1

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.backBtn

	local function var_10_2()
		local var_11_0 = arg_10_0

		var_0.onBackPressed(var_11_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1(var_10_0, var_10_1, var_10_2, var_1_10005)

	onToggle = var_1

	local var_10_3 = arg_10_0
	local var_10_4 = arg_10_0.detailToggle

	local function var_10_5(arg_12_0)
		if arg_12_0 then
			isActive = var_2_10001

			if not var_2_10001(arg_10_0.attrFrame) then
				local var_12_0 = arg_10_0

				var_1.displayAttrFrame(var_12_0)
			end
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_10_3, var_10_4, var_10_5, var_1_10005)

	onToggle = var_1

	local var_10_6 = arg_10_0
	local var_10_7 = arg_10_0.formationToggle

	local function var_10_8(arg_13_0)
		if arg_13_0 then
			isActive = var_2_10001

			if var_2_10001(arg_10_0.attrFrame) then
				local var_13_0 = arg_10_0

				var_1.hideAttrFrame(var_13_0)
			end
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_10_6, var_10_7, var_10_8, var_1_10005)

	onButton = var_1

	local var_10_9 = arg_10_0
	local var_10_10 = arg_10_0.attrFrame

	local function var_10_11()
		triggerToggle = var_2_10000

		var_2_10000(arg_10_0.formationToggle, true)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_10_9, var_10_10, var_10_11, var_1_10005)

	onButton = var_1

	local var_10_12 = arg_10_0
	local var_10_13 = arg_10_0.prevPage

	local function var_10_14()
		local var_15_0 = arg_10_0

		if not var_0.SelectFleetByStep(var_15_0, -1) then
			return
		end

		triggerToggle = var_15_0

		local var_15_1 = arg_10_0.fleetToggleList

		var_15_0(var_2.GetChild(var_15_1, var_0 - 1), true)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_10_12, var_10_13, var_10_14, var_1_10005)

	onButton = var_1

	local var_10_15 = arg_10_0
	local var_10_16 = arg_10_0.nextPage

	local function var_10_17()
		local var_16_0 = arg_10_0

		if not var_0.SelectFleetByStep(var_16_0, 1) then
			return
		end

		triggerToggle = var_16_0

		local var_16_1 = arg_10_0.fleetToggleList

		var_16_0(var_2.GetChild(var_16_1, var_0 - 1), true)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_10_15, var_10_16, var_10_17, var_1_10005)
	arg_10_0:updateFleetIndex(arg_10_0.fleetIndex)
	arg_10_0:updateToggleList()

	local var_10_18 = arg_10_0.commanderFormationPanel

	var_1.ActionInvoke(var_10_18, "Show")

	triggerToggle = var_1

	local var_10_19

	if not arg_10_0.contextData.toggle then
		var_10_19 = var_0_1.TOGGLE_FORMATION
	end

	var_1(arg_10_0[var_10_19], true)

	return
end

function var_0_1.SelectFleetByStep(arg_17_0, arg_17_1)
	return arg_17_0.fleetIndex + arg_17_1 >= 1 and var_2 <= #arg_17_0.fleets and arg_17_0.fleets[var_2].id
end

function var_0_1.onBackPressed(arg_18_0)
	isActive = var_1_10001

	if var_1_10001(arg_18_0.attrFrame) then
		triggerToggle = var_1

		var_1(arg_18_0.formationToggle, true)

		return
	end

	arg_18_0:closeView()

	return
end

function var_0_1.updateFleetBg(arg_19_0)
	local var_19_0 = arg_19_0:getCurrentFleet()
	local var_19_1 = var_1.GetFleetType(var_19_0)

	setActive = var_19_0

	local var_19_2 = arg_19_0.bgFleet

	FleetType = var_1_10004

	var_19_0(var_19_2, var_19_1 == var_1_10004.Normal)

	setActive = var_19_0

	local var_19_3 = arg_19_0.bgSub

	FleetType = var_4

	var_19_0(var_19_3, var_19_1 == var_4.Submarine)

	return
end

function var_0_1.updateToggleList(arg_20_0)
	local var_20_0

	for iter_20_0 = 1, arg_20_0.fleetToggleList.childCount do
		local var_20_1 = arg_20_0.fleetToggleList
		local var_20_2 = var_6.GetChild(var_20_1, iter_20_0 - 1)

		nowWorld = var_20_1

		local var_20_3 = var_20_1()
		local var_20_4, var_20_5, var_20_6 = var_7.BuildFormationIds(var_20_3)

		setActive = var_1_10010

		var_1_10010(var_20_2, iter_20_0 <= var_20_6)

		var_1_10010 = nil

		local var_20_8

		if iter_20_0 == arg_20_0.fleetToggleList.childCount then
			if arg_20_0.fleets[#arg_20_0.fleets] then
				local var_20_7 = var_1_10010

				var_20_8 = var_1_10010.GetFleetType(var_20_7)
				FleetType = var_20_7

				if var_20_8 ~= var_20_7.Submarine then
					var_1_10010 = nil
				end
			end
		elseif arg_20_0.fleets[iter_20_0] then
			local var_20_9 = var_1_10010

			var_20_8 = var_1_10010.GetFleetType(var_20_9)
			FleetType = var_20_9

			if var_20_8 ~= var_20_9.Normal then
				var_1_10010 = nil
			end
		end

		tobool = var_20_8

		local var_20_10 = var_20_8(var_1_10010)

		setToggleEnabled = var_12

		var_12(var_20_2, var_20_10)

		setActive = var_12

		var_12(var_20_2:Find("lock"), not var_20_10)

		if var_20_10 then
			onToggle = var_12

			local var_20_11 = arg_20_0
			local var_20_12 = var_20_2

			local function var_20_13(arg_21_0)
				if arg_21_0 and var_1_10010.id ~= arg_20_0.fleetIndex then
					local var_21_0 = arg_20_0

					var_1.updateFleetIndex(var_21_0, var_1_10010.id)
				end

				return
			end

			SFX_UI_TAG = var_1_10016

			var_12(var_20_11, var_20_12, var_20_13, var_1_10016)

			if var_1_10010.id == arg_20_0.fleetIndex then
				var_20_0 = var_20_2
			end
		else
			onButton = var_12

			var_12(arg_20_0, var_20_2:Find("lock"), function()
				pg = var_2_10000

				local var_22_0 = var_2_10000.TipsMgr.GetInstance()
				local var_22_1 = var_0.ShowTips

				i18n = var_2_10002

				var_22_1(var_22_0, var_2_10002("world_redeploy_tip"))

				return
			end)
		end
	end

	triggerToggle = var_2

	var_2(var_20_0, true)

	return
end

function var_0_1.setPlayerInfo(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.resPanel

	var_2.setPlayer(var_23_0, arg_23_1)

	setActive = var_2

	local var_23_1 = arg_23_0.resPanel._tf

	nowWorld = var_4

	local var_23_2 = var_4()
	local var_23_3 = var_4.IsSystemOpen

	WorldConst = var_1_10006

	var_2(var_23_1, var_23_3(var_23_2, var_1_10006.SystemResource))

	return
end

function var_0_1.setFleets(arg_24_0, arg_24_1)
	arg_24_0.fleets = arg_24_1
	ipairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(arg_24_0.fleets) do
		if iter_24_1.id == arg_24_0.contextData.fleetId then
			arg_24_0.fleetIndex = iter_24_0
		end
	end

	return
end

function var_0_1.getCurrentFleet(arg_25_0)
	return arg_25_0.fleets[arg_25_0.fleetIndex]
end

function var_0_1.updateFleetIndex(arg_26_0, arg_26_1)
	arg_26_0.fleetIndex = arg_26_1

	arg_26_0:updateFormationData()
	arg_26_0:updateFleetBg()
	arg_26_0:updateCharacters()
	arg_26_0:updatePageBtn()
	arg_26_0:updateCommanderFormation()

	return
end

function var_0_1.updateFormationData(arg_27_0)
	local var_27_0 = {}
	local var_27_1 = arg_27_0:getCurrentFleet()
	local var_27_2 = arg_27_0.formationLogic

	var_3.SetShipVOs(var_27_2, var_27_1:getShipVOsDic())

	local var_27_3 = arg_27_0.formationLogic

	var_3.SetFleetVO(var_27_3, arg_27_0:getCurrentFleet())

	return
end

function var_0_1.updateCommanderFormation(arg_28_0)
	local var_28_0 = arg_28_0.commanderFormationPanel

	var_1.Load(var_28_0)

	local var_28_1 = arg_28_0.commanderFormationPanel

	var_1.ActionInvoke(var_28_1, "Update", arg_28_0:getCurrentFleet())

	return
end

function var_0_1.updateCharacters(arg_29_0)
	pg = var_1_10001

	local var_29_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOn(var_29_0)

	local var_29_1 = arg_29_0.formationLogic
	local var_29_2 = var_1.ResetGrid

	TeamType = var_1_10003

	var_29_2(var_29_1, var_1_10003.Vanguard, true)

	local var_29_3 = arg_29_0.formationLogic
	local var_29_4 = var_1.ResetGrid

	TeamType = var_3

	var_29_4(var_29_3, var_3.Main, true)

	local var_29_5 = arg_29_0.formationLogic
	local var_29_6 = var_1.ResetGrid

	TeamType = var_3

	var_29_6(var_29_5, var_3.Submarine, true)
	arg_29_0:updateAttrFrame()

	local var_29_7 = arg_29_0.formationLogic

	var_1.LoadAllCharacter(var_29_7)

	return
end

function var_0_1.updatePageBtn(arg_30_0)
	setActive = var_1_10001

	var_1_10001(arg_30_0.prevPage, arg_30_0:SelectFleetByStep(-1))

	setActive = var_1_10001

	var_1_10001(arg_30_0.nextPage, arg_30_0:SelectFleetByStep(1))

	return
end

function var_0_1.shiftCard(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if #arg_31_0.cards[arg_31_3] > 0 then
		var_4[arg_31_1], var_4[arg_31_2] = var_4[arg_31_2], var_4[arg_31_1]
	end

	arg_31_0.shiftIndex = arg_31_2

	arg_31_0:sortCardSiblingIndex()

	return
end

function var_0_1.sortCardSiblingIndex(arg_32_0)
	local var_32_0 = {}

	TeamType = var_1_10002
	var_32_0[1] = var_1_10002.Main
	TeamType = var_2
	var_32_0[2] = var_2.Vanguard
	TeamType = var_2
	var_32_0[3] = var_2.Submarine
	_ = var_2

	var_2.each(var_32_0, function(arg_33_0)
		if #arg_32_0.cards[arg_33_0] > 0 then
			for iter_33_0 = 1, #var_1 do
				local var_33_0 = var_1[iter_33_0].tr

				var_6.SetSiblingIndex(var_33_0, iter_33_0 - 1)
			end
		end

		return
	end)

	return
end

function var_0_1.displayFleetInfo(arg_34_0)
	local var_34_0 = arg_34_0
	local var_34_1 = arg_34_0.getCurrentFleet(var_34_0)

	setActive = var_34_0

	var_34_0(arg_34_0.vanguardGS, false)

	setActive = var_34_0

	var_34_0(arg_34_0.mainGS, false)

	setActive = var_34_0

	var_34_0(arg_34_0.subGS, false)

	local var_34_2 = var_34_1
	local var_34_3 = var_34_1.GetFleetType(var_34_2)

	_ = var_34_2

	local var_34_4 = var_34_2.reduce
	local var_34_5 = var_34_1
	local var_34_6 = var_34_1.GetTeamShipVOs

	TeamType = var_1_10006

	local var_34_7 = var_34_4(var_34_6(var_34_5, var_1_10006.Vanguard, false), 0, function(arg_35_0, arg_35_1)
		return arg_35_0 + arg_35_1:getShipCombatPower()
	end)

	_ = var_4

	local var_34_8 = var_4.reduce
	local var_34_9 = var_34_1
	local var_34_10 = var_34_1.GetTeamShipVOs

	TeamType = var_7

	local var_34_11 = var_34_8(var_34_10(var_34_9, var_7.Main, false), 0, function(arg_36_0, arg_36_1)
		return arg_36_0 + arg_36_1:getShipCombatPower()
	end)

	_ = var_5

	local var_34_12 = var_5.reduce
	local var_34_13 = var_34_1
	local var_34_14 = var_34_1.GetTeamShipVOs

	TeamType = var_8

	local var_34_15 = var_34_12(var_34_14(var_34_13, var_8.Submarine, false), 0, function(arg_37_0, arg_37_1)
		return arg_37_0 + arg_37_1:getShipCombatPower()
	end)

	FleetType = var_6

	local var_34_16

	if var_34_3 == var_6.Normal then
		setActive = var_34_16

		var_34_16(arg_34_0.vanguardGS, true)

		setActive = var_34_16

		var_34_16(arg_34_0.vanguardUpGS, false)

		setActive = var_34_16

		var_34_16(arg_34_0.vanguardDownGS, false)

		setActive = var_34_16

		var_34_16(arg_34_0.mainGS, true)

		setActive = var_34_16

		var_34_16(arg_34_0.mainUpGS, false)

		setActive = var_34_16

		var_34_16(arg_34_0.mainDownGS, false)

		if arg_34_0.contextData.vanGS then
			setActive = var_34_16

			var_34_16(arg_34_0.vanguardUpGS, var_34_7 > arg_34_0.contextData.vanGS)

			setActive = var_34_16

			var_34_16(arg_34_0.vanguardDownGS, var_34_7 < arg_34_0.contextData.vanGS)
		end

		var_34_16 = var_0_2.tweenNumText

		local var_34_17 = arg_34_0.vanguardGS

		var_34_16(var_7.Find(var_34_17, "Text"), var_34_7)

		if arg_34_0.contextData.mainGS then
			setActive = var_34_16

			var_34_16(arg_34_0.mainUpGS, var_34_11 > arg_34_0.contextData.mainGS)

			setActive = var_34_16

			var_34_16(arg_34_0.mainDownGS, var_34_11 < arg_34_0.contextData.mainGS)
		end

		var_34_16 = var_0_2.tweenNumText

		local var_34_18 = arg_34_0.mainGS

		var_34_16(var_7.Find(var_34_18, "Text"), var_34_11)

		var_34_16 = arg_34_0.contextData
		var_34_16.vanGS = var_34_7
		var_34_16 = arg_34_0.contextData
		var_34_16.mainGS = var_34_11
	else
		FleetType = var_34_16

		if var_34_3 == var_34_16.Submarine then
			setActive = var_6

			var_6(arg_34_0.subGS, true)

			setActive = var_6

			var_6(arg_34_0.subUpGS, false)

			setActive = var_6

			var_6(arg_34_0.subDownGS, false)

			if arg_34_0.contextData.subGS then
				setActive = var_6

				var_6(arg_34_0.subUpGS, var_34_15 > arg_34_0.contextData.subGS)

				setActive = var_6

				var_6(arg_34_0.subDownGS, var_34_15 < arg_34_0.contextData.subGS)
			end

			local var_34_19 = var_0_2.tweenNumText
			local var_34_20 = arg_34_0.subGS

			var_34_19(var_7.Find(var_34_20, "Text"), var_34_15)

			arg_34_0.contextData.subGS = var_34_15
		end
	end

	return
end

function var_0_1.displayAttrFrame(arg_38_0)
	pg = var_1_10001

	local var_38_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_38_0, arg_38_0.blurLayer, {
		staticBlur = true
	})

	SetActive = var_1

	var_1(arg_38_0.attrFrame, true)
	arg_38_0:initAttrFrame()

	return
end

function var_0_1.hideAttrFrame(arg_39_0)
	SetActive = var_1_10001

	var_1_10001(arg_39_0.attrFrame, false)

	pg = var_1_10001

	local var_39_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_39_0, arg_39_0.blurLayer, arg_39_0._tf)

	return
end

function var_0_1.initAttrFrame(arg_40_0)
	local var_40_0 = {}
	local var_40_1 = arg_40_0
	local var_40_2 = arg_40_0.getCurrentFleet(var_40_1)

	TeamType = var_40_1

	local var_40_3 = var_40_1.Main

	TeamType = var_1_10004
	var_40_0[var_40_3] = var_40_2[var_1_10004.Main]
	TeamType = var_40_3

	local var_40_4 = var_40_3.Vanguard

	TeamType = var_4
	var_40_0[var_40_4] = var_40_2[var_4.Vanguard]
	TeamType = var_40_4

	local var_40_5 = var_40_4.Submarine

	TeamType = var_4
	var_40_0[var_40_5] = var_40_2[var_4.Submarine]

	local var_40_6 = false

	pairs = var_4

	for iter_40_0, iter_40_1 in var_4(var_40_0) do
		if #arg_40_0.cards[iter_40_0] == 0 then
			local var_40_7 = arg_40_0.attrFrame
			local var_40_8 = var_10.Find(var_40_7, iter_40_0 .. "/list")

			for iter_40_2 = 1, 3 do
				cloneTplTo = var_1_10015
				var_1_10015 = var_1_10015(arg_40_0.cardTpl, var_40_8).gameObject
				table = var_16

				local var_40_9 = var_16.insert
				local var_40_10 = var_9

				FormationDetailCard = var_1_10018

				var_40_9(var_40_10, var_1_10018.New(var_1_10015))
			end

			var_40_6 = true
		end
	end

	if var_40_6 then
		arg_40_0:updateAttrFrame()
	end

	return
end

function var_0_1.updateAttrFrame(arg_41_0)
	local var_41_0 = {}
	local var_41_1 = arg_41_0
	local var_41_2 = arg_41_0.getCurrentFleet(var_41_1)

	TeamType = var_41_1

	local var_41_3 = var_41_1.Main

	TeamType = var_1_10004
	var_41_0[var_41_3] = var_41_2[var_1_10004.Main]
	TeamType = var_41_3

	local var_41_4 = var_41_3.Vanguard

	TeamType = var_4
	var_41_0[var_41_4] = var_41_2[var_4.Vanguard]
	TeamType = var_41_4

	local var_41_5 = var_41_4.Submarine

	TeamType = var_4
	var_41_0[var_41_5] = var_41_2[var_4.Submarine]

	local var_41_6 = var_41_2
	local var_41_7 = var_41_2.GetFleetType(var_41_6)

	pairs = var_41_6

	for iter_41_0, iter_41_1 in var_41_6(var_41_0) do
		if #arg_41_0.cards[iter_41_0] > 0 then
			FleetType = var_10

			if var_41_7 == var_10.Submarine then
				TeamType = var_10

				local var_41_8

				if iter_41_0 ~= var_10.Vanguard then
					var_41_8 = false
				else
					var_41_8 = true
				end

				for iter_41_2 = 1, 3 do
					if iter_41_2 <= #iter_41_1 then
						WorldConst = var_15

						local var_41_9 = var_15.FetchShipVO(iter_41_1[iter_41_2].id)
						local var_41_10 = var_9[iter_41_2]

						var_16.update(var_41_10, var_41_9, var_41_8)

						local var_41_11 = var_9[iter_41_2]

						var_16.updateProps(var_41_11, arg_41_0:getCardAttrProps(var_41_9))
					else
						local var_41_12 = var_9[iter_41_2]

						var_15.update(var_41_12, nil, var_41_8)
					end

					arg_41_0:detachOnCardButton(var_9[iter_41_2])

					if not var_41_8 then
						arg_41_0:attachOnCardButton(var_9[iter_41_2], iter_41_0)
					end
				end
			end
		end
	end

	setActive = var_4

	local var_41_13 = arg_41_0.attrFrame
	local var_41_14 = var_5.Find

	TeamType = iter_41_0

	local var_41_15 = var_41_14(var_41_13, iter_41_0.Main)

	FleetType = var_41_13

	var_4(var_41_15, var_41_7 == var_41_13.Normal)

	setActive = var_4

	local var_41_16 = arg_41_0.attrFrame
	local var_41_17 = var_5.Find

	TeamType = var_7

	local var_41_18 = var_41_17(var_41_16, var_7.Submarine)

	FleetType = var_41_16

	var_4(var_41_18, var_41_7 == var_41_16.Submarine)

	setActive = var_4

	local var_41_19 = arg_41_0.attrFrame
	local var_41_20 = var_5.Find

	TeamType = var_7

	local var_41_21 = var_41_20(var_41_19, var_7.Vanguard .. "/vanguard")

	FleetType = var_41_19

	var_4(var_41_21, var_41_7 ~= var_41_19.Submarine)
	arg_41_0:updateUltimateTitle()

	return
end

function var_0_1.updateUltimateTitle(arg_42_0)
	local var_42_0 = arg_42_0.cards

	TeamType = var_1_10002

	if #var_42_0[var_1_10002.Main] > 0 then
		for iter_42_0 = 1, #var_1 do
			go = var_1_10006

			local var_42_1 = var_1_10006(var_1[iter_42_0].shipState)

			var_1_10006.SetActive(var_42_1, iter_42_0 == 1)
		end
	end

	return
end

function var_0_1.getCardAttrProps(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_1:getProperties()
	local var_43_1 = arg_43_1:getShipCombatPower()
	local var_43_2 = arg_43_1:getBattleTotalExpend()
	local var_43_3 = {}
	local var_43_4 = {}

	i18n = var_1_10007
	var_43_4[1] = var_1_10007("word_attr_durability")
	tostring = var_7
	math = var_8
	var_43_4[2] = var_7(var_8.floor(var_43_0.durability))
	var_43_3[1] = var_43_4

	local var_43_5 = {}

	i18n = var_7
	var_43_5[1] = var_7("word_attr_luck")

	local var_43_6 = ""

	tostring = var_8
	math = var_9
	var_43_5[2] = var_43_6 .. var_8(var_9.floor(var_43_2))
	var_43_3[2] = var_43_5

	local var_43_7 = {}

	i18n = var_7
	var_43_7[1] = var_7("word_synthesize_power")

	local var_43_8 = "<color=#ffff00>"

	math = var_8
	var_43_7[2] = var_43_8 .. var_8.floor(var_43_1) .. "</color>"
	var_43_3[3] = var_43_7

	return var_43_3
end

function var_0_1.detachOnCardButton(arg_44_0, arg_44_1)
	GetOrAddComponent = var_1_10002

	local var_44_0 = var_1_10002(arg_44_1.go, "EventTriggerListener")

	var_2.RemovePointDownFunc(var_44_0)
	var_2:RemovePointUpFunc()
	var_2:RemoveBeginDragFunc()
	var_2:RemoveDragFunc()
	var_2:RemoveDragEndFunc()

	return
end

function var_0_1.attachOnCardButton(arg_45_0, arg_45_1, arg_45_2)
	GetOrAddComponent = var_1_10003

	local var_45_0 = var_1_10003(arg_45_1.go, "EventTriggerListener")

	arg_45_0.eventTriggers[var_45_0] = true

	var_45_0:AddPointClickFunc(function(arg_46_0, arg_46_1)
		if not arg_45_0.carddrag and arg_46_0 == arg_45_1.go then
			if arg_45_1.shipVO then
				local var_46_0 = arg_45_0
				local var_46_1 = var_46_1.emit

				WorldDetailMediator = var_2_10004

				var_46_1(var_46_0, var_2_10004.OnShipInfo, arg_45_1.shipVO.id, var_0_1.TOGGLE_DETAIL)
			end

			pg = var_46_1

			local var_46_2 = var_46_1.CriMgr.GetInstance()
			local var_46_3 = var_2.PlaySoundEffect_V3

			SFX_PANEL = var_2_10004

			var_46_3(var_46_2, var_2_10004)
		end

		return
	end)

	if arg_45_1.shipVO then
		local var_45_1 = arg_45_0.cards[arg_45_2]
		local var_45_2 = arg_45_1.tr.parent
		local var_45_3 = var_5.GetComponent(var_45_2, "ContentSizeFitter")
		local var_45_4 = arg_45_1.tr.parent
		local var_45_5 = var_6.GetComponent(var_45_4, "HorizontalLayoutGroup")
		local var_45_6 = arg_45_1.tr.rect.width * 0.5
		local var_45_7 = {}

		var_45_0:AddBeginDragFunc(function()
			if arg_45_0.carddrag then
				return
			end

			arg_45_0.carddrag = arg_45_1
			var_45_3.enabled = false
			var_45_5.enabled = false

			local var_47_0 = arg_45_1.tr

			var_0.SetSiblingIndex(var_47_0, #var_45_1)

			for iter_47_0 = 1, #var_45_1 do
				if var_45_1[iter_47_0] == arg_45_1 then
					arg_45_0.shiftIndex = iter_47_0
				end

				var_45_7[iter_47_0] = var_45_1[iter_47_0].tr.anchoredPosition
			end

			LeanTween = var_0

			local var_47_1 = var_0.scale
			local var_47_2 = arg_45_1.paintingTr

			Vector3 = var_2

			var_47_1(var_47_2, var_2(1.1, 1.1, 0), 0.3)

			return
		end)
		var_45_0:AddDragFunc(function(arg_48_0, arg_48_1)
			if arg_45_0.carddrag ~= arg_45_1 then
				return
			end

			local var_48_0 = arg_45_1.tr.localPosition
			local var_48_1 = arg_45_0

			var_48_0.x = var_3.change2ScrPos(var_48_1, arg_45_1.tr.parent, arg_48_1.position).x
			arg_45_1.tr.localPosition = var_48_0

			local var_48_2 = 1

			for iter_48_0 = 1, #var_45_1 do
				if var_45_1[iter_48_0] ~= arg_45_1 and var_45_1[iter_48_0].shipVO and arg_45_1.tr.localPosition.x > var_45_1[iter_48_0].tr.localPosition.x + (var_48_2 < arg_45_0.shiftIndex and 1.1 or -1.1) * var_45_6 then
					var_48_2 = var_48_2 + 1
				end
			end

			if arg_45_0.shiftIndex ~= var_48_2 then
				local var_48_3 = arg_45_0.formationLogic

				var_4.Shift(var_48_3, arg_45_0.shiftIndex, var_48_2, arg_45_2)

				local var_48_4 = arg_45_0

				var_4.shiftCard(var_48_4, arg_45_0.shiftIndex, var_48_2, arg_45_2)

				for iter_48_1 = 1, #var_45_1 do
					if var_45_1[iter_48_1] and var_45_1[iter_48_1] ~= arg_45_1 then
						var_45_1[iter_48_1].tr.anchoredPosition = var_45_7[iter_48_1]
					end
				end
			end

			return
		end)
		var_45_0:AddDragEndFunc(function(arg_49_0, arg_49_1)
			if arg_45_0.carddrag ~= arg_45_1 then
				return
			end

			math = var_2

			local var_49_0 = var_2.min

			math = var_3

			local var_49_1 = var_49_0(var_3.abs(arg_45_1.tr.anchoredPosition.x - var_45_7[arg_45_0.shiftIndex].x) / 200, 1) * 0.3

			LeanTween = var_3

			local var_49_2 = var_3.value(arg_45_1.go, arg_45_1.tr.anchoredPosition.x, var_45_7[arg_45_0.shiftIndex].x, var_49_1)
			local var_49_3 = var_3.setEase

			LeanTweenType = var_5

			local var_49_4 = var_49_3(var_49_2, var_5.easeOutCubic)
			local var_49_5 = var_3.setOnUpdate

			System = var_5

			local var_49_6 = var_49_5(var_49_4, var_5.Action_float(function(arg_50_0)
				local var_50_0 = arg_45_1.tr.anchoredPosition

				var_50_0.x = arg_50_0
				arg_45_1.tr.anchoredPosition = var_50_0

				return
			end))
			local var_49_7 = var_3.setOnComplete

			System = var_5

			var_49_7(var_49_6, var_5.Action(function()
				var_45_3.enabled = true
				var_45_5.enabled = true
				arg_45_0.shiftIndex = nil

				local var_51_0 = arg_45_0

				var_0.updateUltimateTitle(var_51_0)

				local var_51_1 = arg_45_0.formationLogic

				var_0.SwitchToDisplayMode(var_51_1)

				local var_51_2 = arg_45_0.formationLogic

				var_0.SortSiblingIndex(var_51_2)

				local var_51_3 = arg_45_0

				var_0.sortCardSiblingIndex(var_51_3)

				local var_51_4 = arg_45_0

				var_51_4.carddrag = nil
				LeanTween = var_51_4

				local var_51_5 = var_51_4.scale
				local var_51_6 = arg_45_1.paintingTr

				Vector3 = var_3_10002

				var_51_5(var_51_6, var_3_10002(1, 1, 0), 0.3)

				return
			end))

			return
		end)
	end

	return
end

function var_0_1.change2ScrPos(arg_52_0, arg_52_1, arg_52_2)
	GameObject = var_1_10003

	local var_52_0 = var_1_10003.Find("OverlayCamera")
	local var_52_1 = var_3.GetComponent(var_52_0, "Camera")

	LuaHelper = var_52_0

	return (var_52_0.ScreenToLocal(arg_52_1, arg_52_2, var_52_1))
end

function var_0_1.recyclePainting(arg_53_0)
	pairs = var_1_10001

	for iter_53_0, iter_53_1 in var_1_10001(arg_53_0.cards) do
		ipairs = var_1_10006

		for iter_53_2, iter_53_3 in var_1_10006(iter_53_1) do
			iter_53_3:clear()
		end
	end

	return
end

function var_0_1.willExit(arg_54_0)
	local var_54_0 = arg_54_0.commanderFormationPanel

	var_1.Destroy(var_54_0)

	isActive = var_1

	if var_1(arg_54_0.attrFrame) then
		pg = var_1

		local var_54_1 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_54_1, arg_54_0.blurLayer, arg_54_0._tf)
	end

	arg_54_0:UnOverlayPanel(arg_54_0._tf)

	if arg_54_0.resPanel then
		local var_54_2 = arg_54_0.resPanel

		var_1.exit(var_54_2)

		arg_54_0.resPanel = nil
	end

	if arg_54_0.eventTriggers then
		pairs = var_1

		for iter_54_0, iter_54_1 in var_1(arg_54_0.eventTriggers) do
			ClearEventTrigger = var_1_10006

			var_1_10006(iter_54_0)
		end

		arg_54_0.eventTriggers = nil
	end

	local var_54_3 = arg_54_0:getCurrentFleet()
	local var_54_4 = arg_54_0.formationLogic

	var_2.Destroy(var_54_4)
	arg_54_0:recyclePainting()

	return
end

return var_0_1
