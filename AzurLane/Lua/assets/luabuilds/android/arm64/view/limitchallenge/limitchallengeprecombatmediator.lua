local var_0_0 = class("LimitChallengePreCombatMediator", import("view.base.ContextMediator"))

var_0_0.ON_UPDATE_CUSTOM_FLEET = "LimitChallengePreCombatMediator:ON_UPDATE_CUSTOM_FLEET"
var_0_0.ON_START = "LimitChallengePreCombatMediator:ON_START"
var_0_0.BEGIN_STAGE = "LimitChallengePreCombatMediator:BEGIN_STAGE"
var_0_0.OPEN_SHIP_INFO = "LimitChallengePreCombatMediator:OPEN_SHIP_INFO"
var_0_0.CHANGE_FLEET_SHIP = "LimitChallengePreCombatMediator:CHANGE_FLEET_SHIP"
var_0_0.CHANGE_FLEET_SHIPS_ORDER = "LimitChallengePreCombatMediator:CHANGE_FLEET_SHIPS_ORDER"
var_0_0.REMOVE_SHIP = "LimitChallengePreCombatMediator:REMOVE_SHIP"
var_0_0.ON_AUTO = "LimitChallengePreCombatMediator:ON_AUTO"
var_0_0.ON_SUB_AUTO = "LimitChallengePreCombatMediator:ON_SUB_AUTO"
var_0_0.ON_CHANGE_FLEET = "LimitChallengePreCombatMediator:ON_CHANGE_FLEET"
var_0_0.ON_CMD_SKILL = "LimitChallengePreCombatMediator:ON_CMD_SKILL"
var_0_0.ON_SELECT_COMMANDER = "LimitChallengePreCombatMediator:ON_SELECT_COMMANDER"

function var_0_0.register(arg_1_0)
	arg_1_0:bindEvent()

	arg_1_0.ships = getProxy(BayProxy):getRawData()

	arg_1_0.viewComponent:SetShips(arg_1_0.ships)

	local var_1_0 = pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "CommanderCatMediator")

	var_1_0 = var_1_0 and not LOCK_COMMANDER

	arg_1_0.viewComponent:SetOpenCommander(var_1_0)

	local var_1_1 = _.map({
		FleetProxy.CHALLENGE_FLEET_ID,
		FleetProxy.CHALLENGE_SUB_FLEET_ID
	}, function(arg_2_0)
		return getProxy(FleetProxy):getFleetById(arg_2_0)
	end)

	arg_1_0.fleets = var_1_1
	arg_1_0.contextData.fleets = var_1_1

	arg_1_0.viewComponent:SetFleets(var_1_1)

	arg_1_0.contextData.fleetIndex = arg_1_0.contextData.fleetIndex or 1

	arg_1_0.viewComponent:SetCurrentFleet(var_1_1[arg_1_0.contextData.fleetIndex].id)
	arg_1_0.viewComponent:SetSubFlag(var_1_1[#var_1_1]:isLegalToFight() == true)
	arg_1_0.viewComponent:SetStageID(arg_1_0.contextData.stageId)

	return
end

function var_0_0.bindEvent(arg_3_0)
	arg_3_0:bind(var_0_0.ON_CHANGE_FLEET, function(arg_4_0, arg_4_1)
		arg_3_0:changeFleet(arg_4_1)

		return
	end)
	arg_3_0:bind(var_0_0.ON_AUTO, function(arg_5_0, arg_5_1)
		arg_3_0:onAutoBtn(arg_5_1)

		return
	end)
	arg_3_0:bind(var_0_0.ON_SUB_AUTO, function(arg_6_0, arg_6_1)
		arg_3_0:onAutoSubBtn(arg_6_1)

		return
	end)
	arg_3_0:bind(var_0_0.CHANGE_FLEET_SHIPS_ORDER, function(arg_7_0, arg_7_1)
		arg_3_0:refreshEdit(arg_7_1)

		return
	end)
	arg_3_0:bind(var_0_0.REMOVE_SHIP, function(arg_8_0, arg_8_1, arg_8_2)
		arg_3_0:removeShipFromFleet(arg_8_2, arg_8_1)
		arg_3_0:refreshEdit(arg_8_2)

		return
	end)
	arg_3_0:bind(var_0_0.OPEN_SHIP_INFO, function(arg_9_0, arg_9_1, arg_9_2)
		for iter_9_0, iter_9_1 in ipairs(arg_9_2:getShipIds()) do
			table.insert({}, arg_3_0.ships[iter_9_1])
		end

		arg_3_0:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_9_1,
			shipVOs = {}
		})

		return
	end)
	arg_3_0:bind(var_0_0.CHANGE_FLEET_SHIP, function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		local var_10_0 = _.flatten(_.map(arg_3_0.contextData.fleets, function(arg_11_0)
			return arg_11_0:GetRawShipIds()
		end))
		local var_10_1, var_10_2, var_10_3 = var_0_0.getDockCallbackFuncs(arg_10_1, arg_10_2, arg_10_3, var_10_0, arg_3_0.contextData.actId)
		local var_10_4 = arg_3_0
		local var_10_6 = GAME.GO_SCENE
		local var_10_7 = SCENE.DOCKYARD
		local var_10_8 = {
			selectedMin = 0,
			skipSelect = true,
			useBlackBlock = true,
			selectedMax = 1,
			energyDisplay = false,
			leastLimitMsg = i18n("battle_preCombatMediator_leastLimit"),
			quitTeam = arg_10_1 ~= nil,
			teamFilter = arg_10_3,
			onShip = var_10_1,
			confirmSelect = var_10_2,
			onSelected = var_10_3,
			hideTagFlags = ShipStatus.TAG_HIDE_CHALLENGE,
			blockTagFlags = {
				inEvent = true
			},
			otherSelectedIds = var_10_0
		}

		var_10_8.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
			isActivityNpc = true
		})

		var_10_5(var_10_4, var_10_6, var_10_7, var_10_8)

		return
	end)
	arg_3_0:bind(var_0_0.ON_UPDATE_CUSTOM_FLEET, function(arg_12_0)
		_.each(arg_3_0.contextData.fleets, function(arg_13_0)
			arg_3_0:sendNotification(GAME.UPDATE_FLEET, {
				fleet = arg_13_0
			})

			local var_13_0 = arg_13_0:GetRawCommanderIds()

			_.each({
				1,
				2
			}, function(arg_14_0)
				({
					fleetId = arg_13_0.id,
					pos = arg_14_0
				}).commanderId = var_13_0[arg_14_0] or 0

				arg_3_0:sendNotification(GAME.COOMMANDER_EQUIP_TO_FLEET, {
					fleetId = arg_13_0.id,
					pos = arg_14_0
				})

				return
			end)

			return
		end)

		return
	end)
	arg_3_0:bind(var_0_0.ON_START, function(arg_15_0)
		arg_3_0.viewComponent:emit(var_0_0.ON_UPDATE_CUSTOM_FLEET)
		seriesAsync({
			function(arg_16_0)
				for iter_16_0 = 1, #arg_3_0.contextData.fleets - 1 do
					if arg_3_0.contextData.fleets[iter_16_0]:isLegalToFight() ~= true then
						pg.TipsMgr.GetInstance():ShowTips(i18n("elite_disable_formation_unsatisfied"))

						return
					end
				end

				local var_16_0 = {}

				if _.any(arg_3_0.contextData.fleets, function(arg_17_0)
					return _.any(arg_17_0:GetRawShipIds(), function(arg_18_0)
						local var_18_0 = getProxy(BayProxy):RawGetShipById(arg_18_0)

						if var_16_0[var_18_0:getGroupId()] then
							return true
						end

						var_16_0[var_18_0:getGroupId()] = true

						return
					end)
				end) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("guild_event_exist_same_kind_ship"))

					return
				end

				arg_16_0()

				return
			end,
			function(arg_19_0)
				table.SerialIpairsAsync(arg_3_0.contextData.fleets, function(arg_20_0, arg_20_1, arg_20_2)
					local var_20_0, var_20_1 = arg_20_1:HaveShipsInEvent()

					if var_20_0 then
						pg.TipsMgr.GetInstance():ShowTips(var_20_1)

						return
					end

					if _.any(arg_20_1:getShipIds(), function(arg_21_0)
						local var_21_0 = getProxy(BayProxy):RawGetShipById(arg_21_0)

						if not var_21_0 then
							return
						end

						local var_21_1, var_21_2 = ShipStatus.ShipStatusCheck("inChallenge", var_21_0)

						if not var_21_1 then
							pg.TipsMgr.GetInstance():ShowTips(var_21_2)

							return true
						end

						return
					end) then
						return
					end

					arg_20_2()

					return
				end, arg_19_0)

				return
			end,
			function(arg_22_0)
				arg_3_0.viewComponent:emit(var_0_0.BEGIN_STAGE)

				return
			end
		})

		return
	end)
	arg_3_0:bind(var_0_0.BEGIN_STAGE, function(arg_23_0)
		arg_3_0:sendNotification(GAME.BEGIN_STAGE, {
			stageId = arg_3_0.contextData.stageId,
			system = arg_3_0.contextData.system,
			actId = arg_3_0.contextData.actId
		})

		return
	end)
	arg_3_0:bind(var_0_0.ON_CMD_SKILL, function(arg_24_0, arg_24_1)
		arg_3_0:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				skill = arg_24_1
			}
		}))

		return
	end)
	arg_3_0:bind(var_0_0.ON_SELECT_COMMANDER, function(arg_25_0, arg_25_1, arg_25_2)
		var_0_0.onSelectCommander(_.map({
			FleetProxy.CHALLENGE_FLEET_ID,
			FleetProxy.CHALLENGE_SUB_FLEET_ID
		}, function(arg_26_0)
			return getProxy(FleetProxy):getFleetById(arg_26_0)
		end), arg_25_1, arg_25_2)

		return
	end)

	return
end

function var_0_0.onAutoBtn(arg_27_0, arg_27_1)
	arg_27_0:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_27_1.isOn,
		toggle = arg_27_1.toggle,
		system = arg_27_0.contextData.system
	})

	return
end

function var_0_0.onAutoSubBtn(arg_28_0, arg_28_1)
	arg_28_0:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = arg_28_1.isOn,
		toggle = arg_28_1.toggle,
		system = arg_28_0.contextData.system
	})

	return
end

function var_0_0.changeFleet(arg_29_0, arg_29_1)
	arg_29_0.contextData.fleetIndex = table.indexof(arg_29_0.contextData.fleets, _.detect(arg_29_0.contextData.fleets, function(arg_30_0)
		return arg_30_0.id == arg_29_1
	end))

	arg_29_0.viewComponent:SetCurrentFleet(arg_29_1)
	arg_29_0.viewComponent:UpdateFleetView(true)
	arg_29_0.viewComponent:SetFleetStepper()

	return
end

function var_0_0.refreshEdit(arg_31_0, arg_31_1)
	arg_31_0.viewComponent:UpdateFleetView(false)
	arg_31_0.viewComponent:SetSubFlag(arg_31_0.contextData.fleets[#arg_31_0.contextData.fleets]:isLegalToFight() == true)
	getProxy(FleetProxy):updateFleet(arg_31_1)

	return
end

function var_0_0.removeShipFromFleet(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_1:canRemove(arg_32_2) then
		local var_32_0, var_32_1 = arg_32_1:getShipPos(arg_32_2)

		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_formationUI_removeError_onlyShip", arg_32_2:getConfigTable().name, arg_32_1.name, Fleet.C_TEAM_NAME[var_32_1]))

		return false
	end

	arg_32_1:removeShip(arg_32_2)

	return true
end

function var_0_0.listNotificationInterests(arg_33_0)
	return {
		GAME.BEGIN_STAGE_DONE,
		GAME.BEGIN_STAGE_ERRO
	}
end

function var_0_0.handleNotification(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1:getName()
	local var_34_1 = arg_34_1:getBody()

	if var_34_0 == GAME.BEGIN_STAGE_DONE then
		arg_34_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_34_1)
	elseif var_34_0 == GAME.BEGIN_STAGE_ERRO and var_34_1 == 3 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = i18n("battle_preCombatMediator_timeout"),
			onYes = function()
				arg_34_0.viewComponent:emit(BaseUI.ON_CLOSE)

				return
			end
		})
	end

	return
end

function var_0_0.remove(arg_36_0)
	var_0_0.super.remove(arg_36_0)

	return
end

function var_0_0.getDockCallbackFuncs(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	local var_37_0 = getProxy(BayProxy)

	return function(arg_38_0, arg_38_1)
		local var_38_0, var_38_1 = ShipStatus.ShipStatusCheck("inChallenge", arg_38_0, arg_38_1)

		if not var_38_0 then
			return var_38_0, var_38_1
		end

		if arg_37_0 and arg_37_0:isSameKind(arg_38_0) then
			return true
		end

		for iter_38_0, iter_38_1 in ipairs(arg_37_3) do
			if arg_38_0:isSameKind(var_37_0:getShipById(iter_38_1)) then
				local var_38_3 = i18n("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end, function(arg_39_0, arg_39_1, arg_39_2)
		arg_39_1()

		return
	end, function(arg_40_0)
		if #arg_40_0 == 0 then
			if arg_37_0 then
				arg_37_1:removeShip(arg_37_0)
			end
		elseif #arg_40_0 > 0 then
			local var_40_0 = arg_37_1:getShipPos(arg_37_0)
			local var_40_1 = var_37_0:getShipById(arg_40_0[1])

			if var_40_0 then
				arg_37_1:removeShip(arg_37_0)

				if var_40_1.id == arg_37_0.id then
					var_40_0 = nil
				end
			end

			arg_37_1:insertShip(var_40_1, var_40_0, arg_37_2)
			arg_37_1:RemoveUnusedItems()
		end

		getProxy(FleetProxy):updateFleet(arg_37_1)

		return
	end
end

function var_0_0.onSelectCommander(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = _.detect(arg_41_0, function(arg_42_0)
		return arg_42_0.id == arg_41_2
	end)

	assert(var_41_0)
	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
		maxCount = 1,
		mode = CommanderCatScene.MODE_SELECT,
		fleetType = CommanderCatScene.FLEET_TYPE_LIMIT_CHALLENGE,
		activeCommander = var_41_0:getCommanderByPos(arg_41_1),
		ignoredIds = {},
		onCommander = function(arg_43_0)
			return true
		end,
		onSelected = function(arg_44_0, arg_44_1)
			local var_44_0 = getProxy(CommanderProxy):getCommanderById(arg_44_0[1])

			for iter_44_0, iter_44_1 in pairs(arg_41_0) do
				if iter_44_1.id == arg_41_2 then
					for iter_44_2, iter_44_3 in pairs((iter_44_1:getCommanders())) do
						if iter_44_3.groupId == var_44_0.groupId and iter_44_2 ~= arg_41_1 then
							pg.TipsMgr.GetInstance():ShowTips(i18n("commander_can_not_select_same_group"))

							return
						end
					end
				else
					for iter_44_4, iter_44_5 in pairs((iter_44_1:getCommanders())) do
						if arg_44_0[1] == iter_44_5.id then
							pg.TipsMgr.GetInstance():ShowTips(i18n("commander_is_in_fleet_already"))

							return
						end
					end
				end
			end

			var_41_0:updateCommanderByPos(arg_41_1, var_44_0)
			getProxy(FleetProxy):updateFleet(var_41_0)
			arg_44_1()

			return
		end,
		onQuit = function(arg_45_0)
			var_41_0:updateCommanderByPos(arg_41_1, nil)
			getProxy(FleetProxy):updateFleet(var_41_0)
			arg_45_0()

			return
		end
	})

	return
end

return var_0_0
