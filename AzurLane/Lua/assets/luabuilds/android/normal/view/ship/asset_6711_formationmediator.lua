class = var_0_10000

local var_0_0 = "FormationMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.OPEN_SHIP_INFO = "FormationMediator:OPEN_SHIP_INFO"
var_0_1.ON_CHANGE_FLEET = "FormationMediator:ON_CHANGE_FLEET"
var_0_1.CHANGE_FLEET_NAME = "FormationMediator:CHANGE_FLEET_NAME"
var_0_1.CHANGE_FLEET_SHIP = "FormationMediator:CHANGE_FLEET_SHIP"
var_0_1.REMOVE_SHIP = "FormationMediator:REMOVE_SHIP"
var_0_1.CHANGE_FLEET_FORMATION = "FormationMediator:CHANGE_FLEET_FORMATION"
var_0_1.CHANGE_FLEET_SHIPS_ORDER = "FormationMediator:CHANGE_FLEET_SHIPS_ORDER"
var_0_1.COMMIT_FLEET = "FormationMediator:COMMIT_FLEET"
var_0_1.ON_SELECT_COMMANDER = "FormationMediator:ON_SELECT_COMMANDER"
var_0_1.ON_CMD_SKILL = "FormationMediator:ON_CMD_SKILL"
var_0_1.COMMANDER_FORMATION_OP = "FormationMediator:COMMANDER_FORMATION_OP"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)

	arg_1_0.ships = var_1.getRawData(var_1_0)

	local var_1_1 = arg_1_0.viewComponent

	var_2.setShips(var_1_1, arg_1_0.ships)

	getProxy = var_2
	FleetProxy = var_1_1

	local var_1_2 = var_2(var_1_1)
	local var_1_3 = var_2.GetRegularFleets(var_1_2)

	if var_2.EdittingFleet ~= nil then
		var_1_3[var_2.EdittingFleet.id] = var_2.EdittingFleet
	end

	local var_1_4 = arg_1_0.viewComponent

	var_4.SetFleets(var_1_4, var_1_3)

	getProxy = var_4
	CommanderProxy = var_1_4

	local var_1_5 = var_4(var_1_4)
	local var_1_6 = arg_1_0.viewComponent

	var_5.setCommanderPrefabFleet(var_1_6, var_1_5:getPrefabFleet())
	arg_1_0:bind(var_0_1.ON_CMD_SKILL, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_2_2 = var_2_10004.New
		local var_2_3 = {}

		CommanderSkillMediator = var_2_10006
		var_2_3.mediator = var_2_10006
		CommanderSkillLayer = var_2_10006
		var_2_3.viewComponent = var_2_10006
		var_2_3.data = {
			skill = arg_2_1
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.COMMIT_FLEET, function(arg_3_0, arg_3_1)
		arg_1_0.commitEdit(arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_FLEET_NAME, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0.commitEdit(function()
			local var_5_0 = arg_1_0
			local var_5_1 = var_0.sendNotification

			GAME = var_3_10002

			var_5_1(var_5_0, var_3_10002.RENAME_FLEET, {
				id = arg_4_1,
				name = arg_4_2
			})

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SHIP_INFO, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		local function var_6_0()
			arg_1_0.contextData.number = arg_6_2.id
			arg_1_0.contextData.toggle = arg_6_3

			local var_7_0 = {}

			ipairs = var_1

			local var_7_1 = arg_6_2

			for iter_7_0, iter_7_1 in var_1(var_2.getShipIds(var_7_1)) do
				table = var_3_10006

				var_3_10006.insert(var_7_0, arg_1_0.ships[iter_7_1])
			end

			local var_7_2 = arg_1_0
			local var_7_3 = var_1.sendNotification

			GAME = var_3

			local var_7_4 = var_3.GO_SCENE

			SCENE = iter_7_0

			var_7_3(var_7_2, var_7_4, iter_7_0.SHIPINFO, {
				shipId = arg_6_1,
				shipVOs = var_7_0
			})

			return
		end

		arg_1_0.commitEdit(var_6_0)

		return
	end)
	arg_1_0:bind(var_0_1.ON_CHANGE_FLEET, function(arg_8_0, arg_8_1)
		arg_1_0.commitEdit(function()
			local var_9_0 = arg_1_0.viewComponent
			local var_9_1 = var_0.SetFleets
			local var_9_2 = var_0

			var_9_1(var_9_0, var_2.GetRegularFleets(var_9_2))

			local var_9_3 = arg_1_0.viewComponent

			var_0.SetCurrentFleetID(var_9_3, arg_8_1)

			local var_9_4 = arg_1_0.viewComponent

			var_0.UpdateFleetView(var_9_4, true)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_FLEET_FORMATION, function(arg_10_0, arg_10_1, arg_10_2)
		arg_10_2.formation = arg_10_1

		local var_10_0 = arg_1_0

		var_3.refreshEdit(var_10_0, arg_10_2)

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_FLEET_SHIPS_ORDER, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_1_0

		var_2.refreshEdit(var_11_0, arg_11_1)

		return
	end)
	arg_1_0:bind(var_0_1.REMOVE_SHIP, function(arg_12_0, arg_12_1, arg_12_2)
		var_0_1.removeShipFromFleet(arg_12_2, arg_12_1)

		local var_12_0 = arg_1_0

		var_3.refreshEdit(var_12_0, arg_12_2)

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_FLEET_SHIP, function(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
		arg_1_0.contextData.number = arg_13_2.id
		arg_1_0.contextData.toggle = arg_13_3

		arg_1_0.saveEdit()

		local var_13_0 = 0

		if arg_13_2.id == 1 and #arg_13_2.ships <= 1 and arg_13_1 ~= nil then
			var_13_0 = 1
		end

		local var_13_1 = {}

		ipairs = var_2_10007

		for iter_13_0, iter_13_1 in var_2_10007(arg_13_2.ships) do
			if not arg_13_1 or iter_13_1 ~= arg_13_1.id then
				table = var_2_10012

				var_2_10012.insert(var_13_1, iter_13_1)
			end
		end

		local var_13_2, var_13_3, var_13_4 = var_0_1.getDockCallbackFuncs(arg_1_0, arg_13_1, arg_13_2, arg_13_4)
		local var_13_5 = arg_1_0.commitEdit
		local var_13_6 = arg_1_0
		local var_13_7 = var_11.sendNotification

		GAME = var_2_10013

		local var_13_8 = var_2_10013.GO_SCENE

		SCENE = var_2_10014

		local var_13_9 = var_2_10014.DOCKYARD
		local var_13_10 = {
			useBlackBlock = true,
			selectedMax = 1,
			energyDisplay = true,
			selectedMin = var_13_0
		}

		i18n = var_2_10016
		var_13_10.leastLimitMsg = var_2_10016("ship_formationMediator_leastLimit")
		var_13_10.quitTeam = arg_13_1 ~= nil
		var_13_10.teamFilter = arg_13_4
		i18n = var_16
		var_13_10.leftTopInfo = var_16("word_formation")
		var_13_10.onShip = var_13_2
		var_13_10.confirmSelect = var_13_3
		var_13_10.onSelected = var_13_4
		var_13_10.onQuickHome = var_13_5
		ShipStatus = var_16
		var_13_10.hideTagFlags = var_16.TAG_HIDE_FORMATION
		var_13_10.otherSelectedIds = var_13_1
		var_13_10.preView = arg_1_0.viewComponent.__cname

		var_13_7(var_13_6, var_13_8, var_13_9, var_13_10)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECT_COMMANDER, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_1_0.contextData

		FormationUI = var_2_10004
		var_14_0.toggle = var_2_10004.TOGGLE_FORMATION
		arg_1_0.contextData.number = arg_14_2

		var_0_1.onSelectCommander(arg_14_1, arg_14_2)

		return
	end)

	local var_1_7 = arg_1_0

	arg_1_0.bind(var_1_7, var_0_1.COMMANDER_FORMATION_OP, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_1_0
		local var_15_1 = var_2.sendNotification

		GAME = var_2_10004

		var_15_1(var_15_0, var_2_10004.COMMANDER_FORMATION_OP, {
			data = arg_15_1
		})

		return
	end)

	getProxy = var_5
	PlayerProxy = var_1_7

	local var_1_8 = var_5(var_1_7)
	local var_1_9 = var_5.getData(var_1_8)
	local var_1_10 = arg_1_0.viewComponent

	var_6.setPlayer(var_1_10, var_1_9)

	return
end

function var_0_1.onSelectCommander(arg_16_0, arg_16_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10003

	local var_16_0 = var_1_10002(var_1_10003)

	getProxy = var_1_10003
	FleetProxy = var_1_10004

	local var_16_1 = var_1_10003(var_1_10004)
	local var_16_2 = var_3.getFleetById(var_16_1, arg_16_1)
	local var_16_3 = var_3.getCommanderByPos(var_16_2, arg_16_0)
	local var_16_4 = {}

	ipairs = var_6

	for iter_16_0, iter_16_1 in var_6(var_16_4) do
		if var_16_3 and iter_16_1 == var_16_3.id then
			table = var_1_10011

			var_1_10011.remove(var_16_4, iter_16_0)

			break
		end
	end

	pg = var_6

	local var_16_5 = var_6.m02
	local var_16_6 = var_6.sendNotification

	GAME = var_8

	local var_16_7 = var_8.GO_SCENE

	SCENE = iter_16_0

	local var_16_8 = iter_16_0.COMMANDERCAT
	local var_16_9 = {
		maxCount = 1
	}

	CommanderCatScene = var_1_10011
	var_16_9.mode = var_1_10011.MODE_SELECT
	CommanderCatScene = var_11
	var_16_9.fleetType = var_11.FLEET_TYPE_COMMON
	var_16_9.activeCommander = var_16_3
	var_16_9.ignoredIds = var_16_4

	function var_16_9.onCommander(arg_17_0)
		return true
	end

	function var_16_9.onSelected(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_0[1]

		pg = var_2_10003

		local var_18_1 = var_2_10003.m02
		local var_18_2 = var_3.sendNotification

		GAME = var_2_10005

		var_18_2(var_18_1, var_2_10005.SELECT_FLEET_COMMANDER, {
			fleetId = arg_16_1,
			pos = arg_16_0,
			commanderId = var_18_0,
			callback = function()
				if var_16_0.EdittingFleet then
					getProxy = var_0
					FleetProxy = var_3_10001

					local var_19_0 = var_0(var_3_10001)
					local var_19_1 = var_0.getFleetById(var_19_0, var_16_0.EdittingFleet.id)

					var_16_0.EdittingFleet.commanderIds = var_19_1.commanderIds
				end

				arg_18_1()

				return
			end
		})

		return
	end

	function var_16_9.onQuit(arg_20_0)
		pg = var_2_10001

		local var_20_0 = var_2_10001.m02
		local var_20_1 = var_1.sendNotification

		GAME = var_2_10003

		var_20_1(var_20_0, var_2_10003.COOMMANDER_EQUIP_TO_FLEET, {
			commanderId = 0,
			fleetId = arg_16_1,
			pos = arg_16_0,
			callback = function(arg_21_0)
				if var_16_0.EdittingFleet then
					var_16_0.EdittingFleet.commanderIds = arg_21_0.commanderIds
				end

				arg_20_0()

				return
			end
		})

		return
	end

	var_16_6(var_16_5, var_16_7, var_16_8, var_16_9)

	return
end

function var_0_1.refreshEdit(arg_22_0, arg_22_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10003

	local var_22_0 = var_1_10002(var_1_10003)

	var_22_0.EdittingFleet = arg_22_1

	local var_22_1 = var_22_0:GetRegularFleets()

	var_22_1[arg_22_1.id] = arg_22_1

	local var_22_2 = arg_22_0.viewComponent

	var_4.SetFleets(var_22_2, var_22_1)

	local var_22_3 = arg_22_0.viewComponent

	var_4.UpdateFleetView(var_22_3, false)

	return
end

function var_0_1.commitEdit(arg_23_0)
	getProxy = var_1_10001
	FleetProxy = var_1_10002

	if var_1_10001(var_1_10002).EdittingFleet == nil or var_2:isFirstFleet() or var_2:isLegalToFight() == true or #var_2.ships == 0 then
		var_1:commitEdittingFleet(arg_23_0)
	else
		pg = var_1_10003

		local var_23_0 = var_1_10003.MsgboxMgr.GetInstance()
		local var_23_1 = var_3.ShowMsgBox
		local var_23_2 = {}

		i18n = var_1_10006
		var_23_2.content = var_1_10006("ship_formationMediaror_trash_warning", var_2.defaultName)

		function var_23_2.onYes()
			getProxy = var_2_10000
			BayProxy = var_2_10001

			local var_24_0 = var_2_10000(var_2_10001)
			local var_24_1 = var_0.getRawData(var_24_0)
			local var_24_2 = #var_0.ships

			for iter_24_0 = #var_2, 1, -1 do
				local var_24_3 = var_0

				var_8.removeShip(var_24_3, var_24_1[var_2[iter_24_0]])
			end

			local var_24_4 = var_0

			var_4.commitEdittingFleet(var_24_4, arg_23_0)

			getProxy = var_4
			PlayerProxy = var_24_4
			var_4(var_24_4).combatFleetId = 1

			return
		end

		function var_23_2.onNo()
			return
		end

		var_23_1(var_23_0, var_23_2)
	end

	return
end

function var_0_1.listNotificationInterests(arg_26_0)
	local var_26_0 = {}

	FleetProxy = var_1_10002
	var_26_0[1] = var_1_10002.FLEET_UPDATED
	FleetProxy = var_2
	var_26_0[2] = var_2.FLEET_RENAMED
	GAME = var_2
	var_26_0[3] = var_2.UPDATE_FLEET_DONE
	PlayerProxy = var_2
	var_26_0[4] = var_2.UPDATED
	CommanderProxy = var_2
	var_26_0[5] = var_2.PREFAB_FLEET_UPDATE
	GAME = var_2
	var_26_0[6] = var_2.COOMMANDER_EQUIP_TO_FLEET_DONE

	return var_26_0
end

function var_0_1.handleNotification(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1:getName()
	local var_27_1 = arg_27_1
	local var_27_2 = arg_27_1.getBody(var_27_1)

	FleetProxy = var_27_1

	if var_27_0 == var_27_1.FLEET_UPDATED then
		getProxy = var_4
		FleetProxy = var_1_10005
		var_1_10006 = var_4(var_1_10005)
		var_1_10005 = var_4.GetRegularFleets(var_1_10006)

		local var_27_3 = arg_27_0.viewComponent

		var_1_10006.SetFleets(var_27_3, var_1_10005)
	else
		FleetProxy = var_4

		local var_27_4

		if var_27_0 == var_4.FLEET_RENAMED then
			pg = var_27_4
			var_1_10005 = var_27_4.TipsMgr.GetInstance()
			var_27_4 = var_27_4.ShowTips
			i18n = var_1_10006

			var_27_4(var_1_10005, var_1_10006("ship_formationMediator_changeNameSuccess"))

			getProxy = var_27_4
			FleetProxy = var_1_10005

			local var_27_5 = var_27_4(var_1_10005)

			var_1_10005 = var_27_4.GetRegularFleets(var_27_5)

			local var_27_6 = arg_27_0.viewComponent

			var_6.SetFleets(var_27_6, var_1_10005)

			local var_27_7 = arg_27_0.viewComponent

			var_6.UpdateFleetView(var_27_7, true)

			local var_27_8 = arg_27_0.viewComponent

			var_6.DisplayRenamePanel(var_27_8, false)
		else
			CommanderProxy = var_27_4

			local var_27_9

			if var_27_0 == var_27_4.PREFAB_FLEET_UPDATE then
				getProxy = var_27_9
				CommanderProxy = var_1_10005
				var_27_9 = var_27_9(var_1_10005)

				local var_27_10 = arg_27_0.viewComponent

				var_5.setCommanderPrefabFleet(var_27_10, var_27_9:getPrefabFleet())

				local var_27_11 = arg_27_0.viewComponent

				var_5.updateCommanderFormation(var_27_11)
			else
				GAME = var_27_9

				if var_27_0 == var_27_9.COOMMANDER_EQUIP_TO_FLEET_DONE then
					local var_27_12 = arg_27_0.viewComponent

					var_4.updateCommanderFormation(var_27_12)
				end
			end
		end
	end

	return
end

function var_0_1.checkChangeShip(arg_28_0, arg_28_1, arg_28_2)
	getProxy = var_1_10003
	BayProxy = var_1_10004

	local var_28_0 = var_1_10003(var_1_10004)

	getProxy = var_1_10004
	FleetProxy = var_1_10005

	local var_28_1 = var_1_10004(var_1_10005)
	local var_28_2 = var_28_0:getRawData()
	local var_28_3 = arg_28_2.configId

	if not (var_28_1:GetRegularFleetByShip(arg_28_2) and var_7.id == arg_28_0.id) and (not arg_28_1 or not arg_28_1:isSameKind(arg_28_2)) then
		ipairs = var_9

		for iter_28_0, iter_28_1 in var_9(arg_28_0.ships) do
			local var_28_4 = var_28_2[iter_28_1]

			if var_14.isSameKind(var_28_4, arg_28_2) then
				local var_28_5 = false

				i18n = var_28_4

				local var_28_6 = var_28_4("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end
	end

	return true
end

function var_0_1.removeShipFromFleet(arg_29_0, arg_29_1)
	if not arg_29_0:canRemove(arg_29_1) then
		local var_29_0, var_29_1 = arg_29_0:getShipPos(arg_29_1)

		pg = var_4

		local var_29_2 = var_4.TipsMgr.GetInstance()
		local var_29_3 = var_4.ShowTips

		i18n = var_1_10006

		local var_29_4 = "ship_formationUI_removeError_onlyShip"
		local var_29_5 = arg_29_1:getConfigTable().name
		local var_29_6 = arg_29_0.name

		Fleet = var_1_10010

		var_29_3(var_29_2, var_1_10006(var_29_4, var_29_5, var_29_6, var_1_10010.C_TEAM_NAME[var_29_1]))

		return false
	end

	local var_29_7 = arg_29_0

	arg_29_0.removeShip(var_29_7, arg_29_1)

	getProxy = var_2
	FleetProxy = var_29_7
	var_2(var_29_7).EdittingFleet = arg_29_0

	return true
end

function var_0_1.saveEdit()
	getProxy = var_1_10000
	FleetProxy = var_1_10001

	local var_30_0 = var_1_10000(var_1_10001)

	var_0.saveEdittingFleet(var_30_0)

	return
end

function var_0_1.getDockCallbackFuncs(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	getProxy = var_1_10004
	FleetProxy = var_1_10005

	local var_31_0 = var_1_10004(var_1_10005)

	getProxy = var_1_10005
	BayProxy = var_1_10006

	local var_31_1 = var_1_10005(var_1_10006)

	getProxy = var_1_10006
	ChapterProxy = var_1_10007

	local var_31_2 = var_1_10006(var_1_10007)

	local function var_31_3(arg_32_0, arg_32_1)
		ShipStatus = var_2_10002

		local var_32_0, var_32_1 = var_2_10002.ShipStatusCheck("inFleet", arg_32_0, arg_32_1)

		if not var_32_0 then
			return var_32_0, var_32_1
		end

		local var_32_2, var_32_3 = var_0_1.checkChangeShip(arg_31_2, arg_31_1, arg_32_0)

		if not var_32_2 then
			return false, var_32_3
		end

		local var_32_4 = var_31_0

		if var_6.GetRegularFleetByShip(var_32_4, arg_32_0) ~= nil and var_6.id ~= arg_31_2.id then
			if arg_31_1 == nil and not var_6:canRemove(arg_32_0) then
				local var_32_5, var_32_6 = var_6:getShipPos(arg_32_0)
				local var_32_7 = false

				i18n = var_2_10010

				local var_32_8 = "ship_formationMediator_replaceError_onlyShip"
				local var_32_9 = var_6.defaultName

				Fleet = var_2_10013

				local var_32_10 = var_2_10010(var_32_8, var_32_9, var_2_10013.C_TEAM_NAME[var_32_6])

				return
			end

			if arg_31_1 == nil then
				return true
			else
				local var_32_11, var_32_12 = var_0_1.checkChangeShip(var_6, arg_32_0, arg_31_1)
				local var_32_13 = var_32_12

				if not var_32_11 then
					return false, var_32_13
				end
			end
		end

		return true
	end

	local function var_31_4(arg_33_0, arg_33_1, arg_33_2)
		local var_33_0 = var_31_1

		if not var_3.getShipById(var_33_0, arg_33_0[1]) then
			arg_33_1()

			return
		end

		local var_33_1 = var_31_0

		if var_4.GetRegularFleetByShip(var_33_1, var_3) and var_4.id ~= arg_31_2.id then
			pg = var_5

			local var_33_2 = var_5.MsgboxMgr.GetInstance()
			local var_33_3 = var_5.ShowMsgBox
			local var_33_4 = {
				hideNo = false
			}

			i18n = var_2_10008
			var_33_4.content = var_2_10008("ship_formationMediator_quest_replace", var_4.defaultName)
			var_33_4.onYes = arg_33_1

			var_33_3(var_33_2, var_33_4)
		else
			arg_33_1()

			return
		end

		return
	end

	local function var_31_5(arg_34_0)
		local var_34_0 = var_31_1

		if not var_1.getShipById(var_34_0, arg_34_0[1]) then
			if arg_31_1 == nil then
				return
			end

			var_0_1.removeShipFromFleet(arg_31_2, arg_31_1)

			return
		end

		;(function()
			local var_35_0 = var_31_0
			local var_35_1 = var_0.GetRegularFleetByShip(var_35_0, var_0)
			local var_35_2 = arg_31_2
			local var_35_3 = var_1.getShipPos(var_35_2, arg_31_1)

			if var_35_1 == nil then
				if arg_31_1 == nil then
					local var_35_4 = arg_31_2

					var_2.insertShip(var_35_4, var_0, nil, arg_31_3)
				else
					local var_35_5 = arg_31_2

					var_2.removeShip(var_35_5, arg_31_1)

					local var_35_6 = arg_31_2

					var_2.insertShip(var_35_6, var_0, var_35_3, arg_31_3)
				end

				var_31_0.EdittingFleet = arg_31_2

				return
			end

			local var_35_7 = var_35_1:getShipPos(var_0)

			if var_35_1.id == arg_31_2.id then
				if arg_31_1 == nil then
					local var_35_8 = arg_31_2

					var_3.removeShip(var_35_8, var_0)

					local var_35_9 = arg_31_2

					var_3.insertShip(var_35_9, var_0, nil, arg_31_3)

					var_31_0.EdittingFleet = arg_31_2

					return
				end

				if arg_31_1.id == var_0.id then
					return
				end

				local var_35_10 = arg_31_2

				var_3.removeShip(var_35_10, arg_31_1)

				local var_35_11 = arg_31_2

				var_3.removeShip(var_35_11, var_0)

				if var_35_7 < var_35_3 then
					local var_35_12 = arg_31_2

					var_3.insertShip(var_35_12, arg_31_1, var_35_7, arg_31_3)

					local var_35_13 = arg_31_2

					var_3.insertShip(var_35_13, var_0, var_35_3, arg_31_3)
				else
					local var_35_14 = arg_31_2

					var_3.insertShip(var_35_14, var_0, var_35_3, arg_31_3)

					local var_35_15 = arg_31_2

					var_3.insertShip(var_35_15, arg_31_1, var_35_7, arg_31_3)
				end

				var_31_0.EdittingFleet = arg_31_2

				return
			end

			if not var_35_1:canRemove(var_0) and arg_31_1 == nil then
				local var_35_16, var_35_17 = var_35_1:getShipPos(var_0)

				pg = var_5

				local var_35_18 = var_5.TipsMgr.GetInstance()
				local var_35_19 = var_5.ShowTips

				i18n = var_3_10007

				local var_35_20 = "ship_formationMediator_replaceError_onlyShip"
				local var_35_21 = var_35_1.defaultName

				Fleet = var_3_10010

				var_35_19(var_35_18, var_3_10007(var_35_20, var_35_21, var_3_10010.C_TEAM_NAME[var_35_17]))
			else
				var_35_1:removeShip(var_0)

				if arg_31_1 then
					var_35_1:insertShip(arg_31_1, var_35_7, arg_31_3)

					local var_35_22 = arg_31_0
					local var_35_23 = var_3.sendNotification

					GAME = var_5

					var_35_23(var_35_22, var_5.UPDATE_FLEET, {
						fleet = var_35_1
					})

					local var_35_24 = arg_31_2

					var_3.removeShip(var_35_24, arg_31_1)

					local var_35_25 = arg_31_2

					var_3.insertShip(var_35_25, var_0, var_35_3, arg_31_3)

					var_31_0.EdittingFleet = arg_31_2

					var_0_1.saveEdit()

					local var_35_26 = arg_31_0
					local var_35_27 = var_3.sendNotification

					GAME = var_5

					var_35_27(var_35_26, var_5.UPDATE_FLEET, {
						fleet = arg_31_2
					})
				else
					local var_35_28 = arg_31_0
					local var_35_29 = var_3.sendNotification

					GAME = var_5

					var_35_29(var_35_28, var_5.UPDATE_FLEET, {
						fleet = var_35_1
					})

					local var_35_30 = arg_31_2

					var_3.insertShip(var_35_30, var_0, nil, arg_31_3)

					var_31_0.EdittingFleet = arg_31_2

					var_0_1.saveEdit()

					local var_35_31 = arg_31_0
					local var_35_32 = var_3.sendNotification

					GAME = var_5

					var_35_32(var_35_31, var_5.UPDATE_FLEET, {
						fleet = arg_31_2
					})
				end
			end

			return
		end)()

		return
	end

	return var_31_3, var_31_4, var_31_5
end

return var_0_1
