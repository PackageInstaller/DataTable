local var_0_0 = class("FormationMediator", import("..base.ContextMediator"))

var_0_0.OPEN_SHIP_INFO = "FormationMediator:OPEN_SHIP_INFO"
var_0_0.ON_CHANGE_FLEET = "FormationMediator:ON_CHANGE_FLEET"
var_0_0.CHANGE_FLEET_NAME = "FormationMediator:CHANGE_FLEET_NAME"
var_0_0.CHANGE_FLEET_SHIP = "FormationMediator:CHANGE_FLEET_SHIP"
var_0_0.REMOVE_SHIP = "FormationMediator:REMOVE_SHIP"
var_0_0.CHANGE_FLEET_FORMATION = "FormationMediator:CHANGE_FLEET_FORMATION"
var_0_0.CHANGE_FLEET_SHIPS_ORDER = "FormationMediator:CHANGE_FLEET_SHIPS_ORDER"
var_0_0.COMMIT_FLEET = "FormationMediator:COMMIT_FLEET"
var_0_0.ON_SELECT_COMMANDER = "FormationMediator:ON_SELECT_COMMANDER"
var_0_0.ON_CMD_SKILL = "FormationMediator:ON_CMD_SKILL"
var_0_0.COMMANDER_FORMATION_OP = "FormationMediator:COMMANDER_FORMATION_OP"

function var_0_0.register(arg_1_0)
	arg_1_0.ships = getProxy(BayProxy):getRawData()

	arg_1_0.viewComponent:setShips(arg_1_0.ships)

	local var_1_0 = getProxy(FleetProxy)
	local var_1_1 = var_1_0:GetRegularFleets()

	if var_1_0.EdittingFleet ~= nil then
		var_1_1[var_1_0.EdittingFleet.id] = var_1_0.EdittingFleet
	end

	arg_1_0.viewComponent:SetFleets(var_1_1)
	arg_1_0.viewComponent:setCommanderPrefabFleet(getProxy(CommanderProxy):getPrefabFleet())
	arg_1_0:bind(var_0_0.ON_CMD_SKILL, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				skill = arg_2_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.COMMIT_FLEET, function(arg_3_0, arg_3_1)
		arg_1_0.commitEdit(arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_0.CHANGE_FLEET_NAME, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0.commitEdit(function()
			arg_1_0:sendNotification(GAME.RENAME_FLEET, {
				id = arg_4_1,
				name = arg_4_2
			})

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_SHIP_INFO, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		arg_1_0.commitEdit(function()
			arg_1_0.contextData.number = arg_6_2.id
			arg_1_0.contextData.toggle = arg_6_3

			for iter_7_0, iter_7_1 in ipairs(arg_6_2:getShipIds()) do
				table.insert({}, arg_1_0.ships[iter_7_1])
			end

			arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
				shipId = arg_6_1,
				shipVOs = {}
			})

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_0.ON_CHANGE_FLEET, function(arg_8_0, arg_8_1)
		arg_1_0.commitEdit(function()
			arg_1_0.viewComponent:SetFleets(var_1_0:GetRegularFleets())
			arg_1_0.viewComponent:SetCurrentFleetID(arg_8_1)
			arg_1_0.viewComponent:UpdateFleetView(true)

			return
		end)

		return
	end)
	arg_1_0:bind(var_0_0.CHANGE_FLEET_FORMATION, function(arg_10_0, arg_10_1, arg_10_2)
		arg_10_2.formation = arg_10_1

		arg_1_0:refreshEdit(arg_10_2)

		return
	end)
	arg_1_0:bind(var_0_0.CHANGE_FLEET_SHIPS_ORDER, function(arg_11_0, arg_11_1)
		arg_1_0:refreshEdit(arg_11_1)

		return
	end)
	arg_1_0:bind(var_0_0.REMOVE_SHIP, function(arg_12_0, arg_12_1, arg_12_2)
		var_0_0.removeShipFromFleet(arg_12_2, arg_12_1)
		arg_1_0:refreshEdit(arg_12_2)

		return
	end)
	arg_1_0:bind(var_0_0.CHANGE_FLEET_SHIP, function(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
		arg_1_0.contextData.number = arg_13_2.id
		arg_1_0.contextData.toggle = arg_13_3

		arg_1_0.saveEdit()

		local var_13_0 = 0

		if arg_13_2.id == 1 and #arg_13_2.ships <= 1 and arg_13_1 ~= nil then
			var_13_0 = 1
		end

		local var_13_1 = {}

		for iter_13_0, iter_13_1 in ipairs(arg_13_2.ships) do
			if not arg_13_1 or iter_13_1 ~= arg_13_1.id then
				table.insert(var_13_1, iter_13_1)
			end
		end

		local var_13_2, var_13_3, var_13_4 = var_0_0.getDockCallbackFuncs(arg_1_0, arg_13_1, arg_13_2, arg_13_4)

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			useBlackBlock = true,
			selectedMax = 1,
			energyDisplay = true,
			selectedMin = var_13_0,
			leastLimitMsg = i18n("ship_formationMediator_leastLimit"),
			quitTeam = arg_13_1 ~= nil,
			teamFilter = arg_13_4,
			leftTopInfo = i18n("word_formation"),
			onShip = var_13_2,
			confirmSelect = var_13_3,
			onSelected = var_13_4,
			onQuickHome = arg_1_0.commitEdit,
			hideTagFlags = ShipStatus.TAG_HIDE_FORMATION,
			otherSelectedIds = var_13_1,
			preView = arg_1_0.viewComponent.__cname
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECT_COMMANDER, function(arg_14_0, arg_14_1, arg_14_2)
		arg_1_0.contextData.toggle = FormationUI.TOGGLE_FORMATION
		arg_1_0.contextData.number = arg_14_2

		var_0_0.onSelectCommander(arg_14_1, arg_14_2)

		return
	end)
	arg_1_0:bind(var_0_0.COMMANDER_FORMATION_OP, function(arg_15_0, arg_15_1)
		arg_1_0:sendNotification(GAME.COMMANDER_FORMATION_OP, {
			data = arg_15_1
		})

		return
	end)
	arg_1_0.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))

	return
end

function var_0_0.onSelectCommander(arg_16_0, arg_16_1)
	local var_16_0 = getProxy(FleetProxy)
	local var_16_1 = getProxy(FleetProxy):getFleetById(arg_16_1):getCommanderByPos(arg_16_0)

	for iter_16_0, iter_16_1 in ipairs({}) do
		if var_16_1 and iter_16_1 == var_16_1.id then
			table.remove({}, iter_16_0)

			break
		end
	end

	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
		maxCount = 1,
		mode = CommanderCatScene.MODE_SELECT,
		fleetType = CommanderCatScene.FLEET_TYPE_COMMON,
		activeCommander = var_16_1,
		ignoredIds = {},
		onCommander = function(arg_17_0)
			return true
		end,
		onSelected = function(arg_18_0, arg_18_1)
			pg.m02:sendNotification(GAME.SELECT_FLEET_COMMANDER, {
				fleetId = arg_16_1,
				pos = arg_16_0,
				commanderId = arg_18_0[1],
				callback = function()
					if var_16_0.EdittingFleet then
						var_16_0.EdittingFleet.commanderIds = getProxy(FleetProxy):getFleetById(var_16_0.EdittingFleet.id).commanderIds
					end

					arg_18_1()

					return
				end
			})

			return
		end,
		onQuit = function(arg_20_0)
			pg.m02:sendNotification(GAME.COOMMANDER_EQUIP_TO_FLEET, {
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
	})

	return
end

function var_0_0.refreshEdit(arg_22_0, arg_22_1)
	local var_22_0 = getProxy(FleetProxy)

	var_22_0.EdittingFleet = arg_22_1

	local var_22_1 = var_22_0:GetRegularFleets()

	var_22_1[arg_22_1.id] = arg_22_1

	arg_22_0.viewComponent:SetFleets(var_22_1)
	arg_22_0.viewComponent:UpdateFleetView(false)

	return
end

function var_0_0.commitEdit(arg_23_0)
	local var_23_0 = getProxy(FleetProxy)
	local var_23_1 = var_23_0.EdittingFleet

	if var_23_0.EdittingFleet == nil or var_23_0.EdittingFleet:isFirstFleet() or var_23_0.EdittingFleet:isLegalToFight() == true or #var_23_0.EdittingFleet.ships == 0 then
		var_23_0:commitEdittingFleet(arg_23_0)
	else
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("ship_formationMediaror_trash_warning", var_23_0.EdittingFleet.defaultName),
			onYes = function()
				local var_24_0 = getProxy(BayProxy):getRawData()

				for iter_24_0 = #var_23_1.ships, 1, -1 do
					var_23_1:removeShip(var_24_0[var_23_1.ships[iter_24_0]])
				end

				var_23_0:commitEdittingFleet(arg_23_0)

				getProxy(PlayerProxy).combatFleetId = 1

				return
			end,
			onNo = function()
				return
			end
		})
	end

	return
end

function var_0_0.listNotificationInterests(arg_26_0)
	return {
		FleetProxy.FLEET_UPDATED,
		FleetProxy.FLEET_RENAMED,
		GAME.UPDATE_FLEET_DONE,
		PlayerProxy.UPDATED,
		CommanderProxy.PREFAB_FLEET_UPDATE,
		GAME.COOMMANDER_EQUIP_TO_FLEET_DONE
	}
end

function var_0_0.handleNotification(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1:getName()
	local var_27_1 = arg_27_1:getBody()

	if var_27_0 == FleetProxy.FLEET_UPDATED then
		arg_27_0.viewComponent:SetFleets((getProxy(FleetProxy):GetRegularFleets()))
	elseif var_27_0 == FleetProxy.FLEET_RENAMED then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_formationMediator_changeNameSuccess"))
		arg_27_0.viewComponent:SetFleets((getProxy(FleetProxy):GetRegularFleets()))
		arg_27_0.viewComponent:UpdateFleetView(true)
		arg_27_0.viewComponent:DisplayRenamePanel(false)
	elseif var_27_0 == CommanderProxy.PREFAB_FLEET_UPDATE then
		arg_27_0.viewComponent:setCommanderPrefabFleet(getProxy(CommanderProxy):getPrefabFleet())
		arg_27_0.viewComponent:updateCommanderFormation()
	elseif var_27_0 == GAME.COOMMANDER_EQUIP_TO_FLEET_DONE then
		arg_27_0.viewComponent:updateCommanderFormation()
	end

	return
end

function var_0_0.checkChangeShip(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = getProxy(BayProxy):getRawData()
	local var_28_2 = getProxy(FleetProxy):GetRegularFleetByShip(arg_28_2)

	if not (var_28_2 and var_28_2.id == arg_28_0.id) and (not arg_28_1 or not arg_28_1:isSameKind(arg_28_2)) then
		for iter_28_0, iter_28_1 in ipairs(arg_28_0.ships) do
			if var_28_0[iter_28_1]:isSameKind(arg_28_2) then
				local var_28_4 = i18n("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end
	end

	return true
end

function var_0_0.removeShipFromFleet(arg_29_0, arg_29_1)
	if not arg_29_0:canRemove(arg_29_1) then
		local var_29_0, var_29_1 = arg_29_0:getShipPos(arg_29_1)

		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_formationUI_removeError_onlyShip", arg_29_1:getConfigTable().name, arg_29_0.name, Fleet.C_TEAM_NAME[var_29_1]))

		return false
	end

	arg_29_0:removeShip(arg_29_1)

	getProxy(FleetProxy).EdittingFleet = arg_29_0

	return true
end

function var_0_0.saveEdit()
	getProxy(FleetProxy):saveEdittingFleet()

	return
end

function var_0_0.getDockCallbackFuncs(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = getProxy(FleetProxy)
	local var_31_1 = getProxy(BayProxy)
	local var_31_2 = getProxy(ChapterProxy)

	return function(arg_32_0, arg_32_1)
		local var_32_0, var_32_1 = ShipStatus.ShipStatusCheck("inFleet", arg_32_0, arg_32_1)

		if not var_32_0 then
			return var_32_0, var_32_1
		end

		local var_32_2, var_32_3 = var_0_0.checkChangeShip(arg_31_2, arg_31_1, arg_32_0)

		if not var_32_2 then
			return false, var_32_3
		end

		local var_32_4 = var_31_0:GetRegularFleetByShip(arg_32_0)

		if var_32_4 ~= nil and var_32_4.id ~= arg_31_2.id then
			if arg_31_1 == nil and not var_32_4:canRemove(arg_32_0) then
				local var_32_5, var_32_6 = var_32_4:getShipPos(arg_32_0)
				local var_32_8 = i18n("ship_formationMediator_replaceError_onlyShip", var_32_4.defaultName, Fleet.C_TEAM_NAME[var_32_6])

				return
			end

			if arg_31_1 == nil then
				return true
			else
				local var_32_9, var_32_10 = var_0_0.checkChangeShip(var_32_4, arg_32_0, arg_31_1)

				if not var_32_9 then
					return false, var_32_10
				end
			end
		end

		return true
	end, function(arg_33_0, arg_33_1, arg_33_2)
		local var_33_0 = var_31_1:getShipById(arg_33_0[1])

		if not var_33_0 then
			arg_33_1()

			return
		end

		local var_33_1 = var_31_0:GetRegularFleetByShip(var_33_0)

		if var_33_1 and var_33_1.id ~= arg_31_2.id then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = false,
				content = i18n("ship_formationMediator_quest_replace", var_33_1.defaultName),
				onYes = arg_33_1
			})
		else
			arg_33_1()

			return
		end

		return
	end, function(arg_34_0)
		if not var_31_1:getShipById(arg_34_0[1]) then
			if arg_31_1 == nil then
				return
			end

			var_0_0.removeShipFromFleet(arg_31_2, arg_31_1)

			return
		end

		;(function()
			local var_35_0 = var_31_0:GetRegularFleetByShip(var_0)
			local var_35_1 = arg_31_2:getShipPos(arg_31_1)

			if var_35_0 == nil then
				if arg_31_1 == nil then
					arg_31_2:insertShip(var_0, nil, arg_31_3)
				else
					arg_31_2:removeShip(arg_31_1)
					arg_31_2:insertShip(var_0, var_35_1, arg_31_3)
				end

				var_31_0.EdittingFleet = arg_31_2

				return
			end

			local var_35_2 = var_35_0:getShipPos(var_0)

			if var_35_0.id == arg_31_2.id then
				if arg_31_1 == nil then
					arg_31_2:removeShip(var_0)
					arg_31_2:insertShip(var_0, nil, arg_31_3)

					var_31_0.EdittingFleet = arg_31_2

					return
				end

				if arg_31_1.id == var_0.id then
					return
				end

				arg_31_2:removeShip(arg_31_1)
				arg_31_2:removeShip(var_0)

				if var_35_2 < var_35_1 then
					arg_31_2:insertShip(arg_31_1, var_35_2, arg_31_3)
					arg_31_2:insertShip(var_0, var_35_1, arg_31_3)
				else
					arg_31_2:insertShip(var_0, var_35_1, arg_31_3)
					arg_31_2:insertShip(arg_31_1, var_35_2, arg_31_3)
				end

				var_31_0.EdittingFleet = arg_31_2

				return
			end

			if not var_35_0:canRemove(var_0) and arg_31_1 == nil then
				local var_35_3, var_35_4 = var_35_0:getShipPos(var_0)

				pg.TipsMgr.GetInstance():ShowTips(i18n("ship_formationMediator_replaceError_onlyShip", var_35_0.defaultName, Fleet.C_TEAM_NAME[var_35_4]))
			else
				var_35_0:removeShip(var_0)

				if arg_31_1 then
					var_35_0:insertShip(arg_31_1, var_35_2, arg_31_3)
					arg_31_0:sendNotification(GAME.UPDATE_FLEET, {
						fleet = var_35_0
					})
					arg_31_2:removeShip(arg_31_1)
					arg_31_2:insertShip(var_0, var_35_1, arg_31_3)

					var_31_0.EdittingFleet = arg_31_2

					var_0_0.saveEdit()
					arg_31_0:sendNotification(GAME.UPDATE_FLEET, {
						fleet = arg_31_2
					})
				else
					arg_31_0:sendNotification(GAME.UPDATE_FLEET, {
						fleet = var_35_0
					})
					arg_31_2:insertShip(var_0, nil, arg_31_3)

					var_31_0.EdittingFleet = arg_31_2

					var_0_0.saveEdit()
					arg_31_0:sendNotification(GAME.UPDATE_FLEET, {
						fleet = arg_31_2
					})
				end
			end

			return
		end)()

		return
	end
end

return var_0_0
