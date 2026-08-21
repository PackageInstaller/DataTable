local var_0_0 = class("BossRushFleetSelectMediator", import("view.base.ContextMediator"))

var_0_0.ON_OPEN_DECK = "BossRushFleetSelectMediator:ON_OPEN_DECK"
var_0_0.ON_FLEET_SHIPINFO = "BossRushFleetSelectMediator:ON_FLEET_SHIPINFO"
var_0_0.ON_TRACE = "BossRushFleetSelectMediator:ON_TRACE"
var_0_0.ON_UPDATE_CUSTOM_FLEET = "BossRushFleetSelectMediator:ON_UPDATE_CUSTOM_FLEET"
var_0_0.ON_PRECOMBAT = "BossRushFleetSelectMediator:ON_PRECOMBAT"
var_0_0.ON_ELITE_RECOMMEND = "BossRushFleetSelectMediator:ON_ELITE_RECOMMEND"
var_0_0.ON_ELITE_CLEAR = "BossRushFleetSelectMediator:ON_ELITE_CLEAR"
var_0_0.OPEN_COMMANDER_PANEL = "BossRushFleetSelectMediator:OPEN_COMMANDER_PANEL"
var_0_0.ON_SELECT_COMMANDER = "BossRushFleetSelectMediator:ON_SELECT_COMMANDER"
var_0_0.ON_COMMANDER_SKILL = "BossRushFleetSelectMediator:ON_COMMANDER_SKILL"
var_0_0.ON_SWITCH_MODE = "BossRushFleetSelectMediator:ON_SWITCH_MODE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_OPEN_DECK, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_1.shipVO
		local var_2_1 = _.flatten(_.map(arg_1_0.contextData.fleets, function(arg_3_0)
			return arg_3_0:GetRawShipIds()
		end))
		local var_2_2 = arg_2_1.teamType
		local var_2_3, var_2_4, var_2_5 = arg_1_0.getDockCallbackFuncs(arg_2_1.shipVO, arg_1_0.contextData.fleets[arg_2_1.fleetIndex], arg_2_1.teamType, var_2_1, arg_1_0.contextData.actId)

		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1,
			energyDisplay = true,
			leastLimitMsg = i18n("ship_formationMediator_leastLimit"),
			quitTeam = var_2_0 ~= nil,
			teamFilter = var_2_2,
			leftTopInfo = i18n("word_formation"),
			onShip = var_2_3,
			confirmSelect = var_2_4,
			onSelected = var_2_5,
			hideTagFlags = setmetatable({
				inActivity = arg_1_0.contextData.actId
			}, {
				__index = ShipStatus.TAG_HIDE_ACTIVITY_BOSS
			}),
			otherSelectedIds = var_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_FLEET_SHIPINFO, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_4_1.shipId,
			shipVOs = arg_4_1.shipVOs
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_UPDATE_CUSTOM_FLEET, function(arg_5_0)
		_.each(arg_1_0.contextData.fullFleets, function(arg_6_0)
			getProxy(FleetProxy):updateActivityFleet(arg_1_0.contextData.actId, arg_6_0.id, arg_6_0)

			return
		end)

		local var_5_0 = {}

		_.each(arg_1_0.contextData.fullFleets, function(arg_7_0)
			var_5_0[arg_7_0.id] = arg_7_0

			return
		end)
		arg_1_0:sendNotification(GAME.EDIT_ACTIVITY_FLEET, {
			actID = arg_1_0.contextData.actId,
			fleets = {}
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_TRACE, function(arg_8_0)
		arg_1_0.viewComponent:emit(var_0_0.ON_UPDATE_CUSTOM_FLEET)
		arg_1_0:sendNotification(GAME.BOSSRUSH_TRACE, {
			actId = arg_1_0.contextData.actId,
			seriesId = arg_1_0.contextData.seriesData.id,
			mode = arg_1_0.contextData.mode
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_ELITE_RECOMMEND, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0.contextData.fleets[arg_9_1.index]
		local var_9_2 = table.shallowCopy(var_9_0:GetRawShipIds())
		local var_9_3 = underscore(arg_1_0.contextData.fleets):chain():map(function(arg_10_0)
			return arg_10_0:GetRawShipIds()
		end):flatten():value()
		local var_9_4 = getProxy(BayProxy):getRawData()

		if arg_9_1.index == #arg_1_0.contextData.fleets then
			(function(arg_11_0, arg_11_1)
				for iter_11_0, iter_11_1 in ipairs((getProxy(BayProxy):getActivityRecommendShips(arg_11_0, var_9_3, TeamType.GetTeamShipMax(arg_11_1) - #underscore.filter(var_9_0:GetRawShipIds(), function(arg_12_0)
					return var_9_4[arg_12_0]:getTeamType() == arg_11_1
				end), arg_1_0.contextData.actId))) do
					var_9_0:insertShip(iter_11_1, nil, iter_11_1:getTeamType())
					table.insert(var_9_2, iter_11_1.id)
					table.insert(var_9_3, iter_11_1.id)
				end

				return
			end)(ShipType.SubShipType, TeamType.Submarine)
		else
			(function(arg_11_0, arg_11_1)
				for iter_11_0, iter_11_1 in ipairs((getProxy(BayProxy):getActivityRecommendShips(arg_11_0, var_9_3, TeamType.GetTeamShipMax(arg_11_1) - #underscore.filter(var_9_0:GetRawShipIds(), function(arg_12_0)
					return var_9_4[arg_12_0]:getTeamType() == arg_11_1
				end), arg_1_0.contextData.actId))) do
					var_9_0:insertShip(iter_11_1, nil, iter_11_1:getTeamType())
					table.insert(var_9_2, iter_11_1.id)
					table.insert(var_9_3, iter_11_1.id)
				end

				return
			end)(ShipType.MainShipType, TeamType.Main)
			;(function(arg_11_0, arg_11_1)
				for iter_11_0, iter_11_1 in ipairs((getProxy(BayProxy):getActivityRecommendShips(arg_11_0, var_9_3, TeamType.GetTeamShipMax(arg_11_1) - #underscore.filter(var_9_0:GetRawShipIds(), function(arg_12_0)
					return var_9_4[arg_12_0]:getTeamType() == arg_11_1
				end), arg_1_0.contextData.actId))) do
					var_9_0:insertShip(iter_11_1, nil, iter_11_1:getTeamType())
					table.insert(var_9_2, iter_11_1.id)
					table.insert(var_9_3, iter_11_1.id)
				end

				return
			end)(ShipType.VanguardShipType, TeamType.Vanguard)
		end

		arg_1_0.viewComponent:updateEliteFleets()

		return
	end)
	arg_1_0:bind(var_0_0.ON_ELITE_CLEAR, function(arg_13_0, arg_13_1)
		arg_1_0.contextData.fleets[arg_13_1.index]:clearFleet()
		arg_1_0.viewComponent:updateEliteFleets()

		return
	end)
	arg_1_0:bind(var_0_0.ON_PRECOMBAT, function(arg_14_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = BossRushPreCombatMediator,
			viewComponent = BossRushPreCombatLayer,
			data = {
				seriesData = arg_1_0.contextData.seriesData,
				actId = arg_1_0.contextData.actId,
				system = arg_1_0.contextData.system,
				mode = arg_1_0.contextData.mode,
				stageIds = arg_1_0.contextData.stageIds,
				fleets = table.shallowCopy(arg_1_0.contextData.fleets),
				fleetIndex = arg_1_0.contextData.fleetIndex
			}
		}), true)

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_COMMANDER_PANEL, function(arg_15_0, arg_15_1)
		arg_1_0:openCommanderPanel(arg_15_1, arg_1_0.contextData.fleetIndex)

		return
	end)
	arg_1_0:bind(var_0_0.ON_SELECT_COMMANDER, function(arg_16_0, arg_16_1, arg_16_2)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.COMMANDERCAT, {
			maxCount = 1,
			mode = CommanderCatScene.MODE_SELECT,
			activeCommander = arg_1_0.contextData.fleets[arg_16_1]:getCommanders()[arg_16_2],
			fleetType = CommanderCatScene.FLEET_TYPE_BOSSRUSH,
			fleets = arg_1_0.contextData.fleets,
			ignoredIds = {},
			onCommander = function(arg_17_0)
				return true
			end,
			onSelected = function(arg_18_0, arg_18_1)
				local var_18_0 = getProxy(CommanderProxy):getCommanderById(arg_18_0[1])

				for iter_18_0, iter_18_1 in pairs(var_0) do
					if iter_18_0 == arg_16_1 then
						for iter_18_2, iter_18_3 in pairs(var_0) do
							if iter_18_3.groupId == var_18_0.groupId and iter_18_2 ~= arg_16_2 then
								pg.TipsMgr.GetInstance():ShowTips(i18n("commander_can_not_select_same_group"))

								return
							end
						end
					else
						for iter_18_4, iter_18_5 in pairs((iter_18_1:getCommanders())) do
							if arg_18_0[1] == iter_18_5.id then
								pg.TipsMgr.GetInstance():ShowTips(i18n("commander_is_in_fleet_already"))

								return
							end
						end
					end
				end

				var_0:updateCommanderByPos(arg_16_2, var_18_0)
				arg_18_1()

				return
			end,
			onQuit = function(arg_19_0)
				var_0:updateCommanderByPos(arg_16_2, nil)
				arg_19_0()

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_COMMANDER_SKILL, function(arg_20_0, arg_20_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = CommanderSkillMediator,
			viewComponent = CommanderSkillLayer,
			data = {
				skill = arg_20_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_SWITCH_MODE, function(arg_21_0, arg_21_1)
		arg_1_0:OnSwitchMode(arg_21_1)

		return
	end)

	local var_1_0 = arg_1_0.contextData.seriesData

	arg_1_0.contextData.stageIds = arg_1_0.contextData.seriesData:GetExpeditionIds()
	arg_1_0.contextData.fullFleets = var_1_0:GetFleets()

	if not arg_1_0.contextData.mode then
		local var_1_1 = PlayerPrefs.GetInt("series_mode_flag" .. var_1_0.id, -1)

		if var_1_1 ~= -1 then
			arg_1_0.contextData.mode = var_1_1
		end
	end

	local var_1_2 = arg_1_0.contextData

	var_1_2.mode = arg_1_0.contextData.mode or BossRushSeriesData.MODE.MULTIPLE

	if not var_1_0:IsSingleFight() then
		arg_1_0.contextData.mode = BossRushSeriesData.MODE.MULTIPLE
	end

	local var_1_3 = arg_1_0.contextData.fullFleets

	if arg_1_0.contextData.mode == BossRushSeriesData.MODE.SINGLE then
		arg_1_0.contextData.fleets = {
			var_1_3[1],
			var_1_3[#var_1_3]
		}
	else
		local var_1_4 = arg_1_0.contextData

		var_1_4.fleets = arg_1_0.contextData.fleets or underscore.rest(var_1_3)
	end

	local var_1_5 = arg_1_0.contextData

	var_1_5.fleetIndex = arg_1_0.contextData.fleetIndex or 1

	if arg_1_0.contextData.fleetIndex > #arg_1_0.contextData.fleets then
		arg_1_0.contextData.fleetIndex = 1
	end

	local var_1_6

	if var_1_0.__cname == "CollabrateBossRushSeriesData" then
		arg_1_0.contextData.system = SYSTEM_BOSS_RUSH_COLLABRATE

		goto label_1_0

		var_1_6 = arg_1_0.contextData
	end

	::label_1_0::

	if var_1_0:GetType() ~= BossRushSeriesData.TYPE.EXTRA then
		var_1_6.system = SYSTEM_BOSS_RUSH or SYSTEM_BOSS_RUSH_EX
		arg_1_0.contextData.actId = var_1_0.actId

		arg_1_0.viewComponent:setHardShipVOs(getProxy(BayProxy):getRawData())

		return
	end
end

function var_0_0.OnSwitchMode(arg_22_0, arg_22_1)
	assert(arg_22_1)

	arg_22_0.contextData.mode = arg_22_1

	if arg_22_0.contextData.mode == BossRushSeriesData.MODE.SINGLE then
		if arg_22_1 ~= arg_22_0.contextData.mode then
			arg_22_0.contextData.fleetIndex = arg_22_0.contextData.fleetIndex < #arg_22_0.contextData.fleets and 1 or 2
		end

		arg_22_0.contextData.fleets = {
			arg_22_0.contextData.fullFleets[1],
			arg_22_0.contextData.fullFleets[#arg_22_0.contextData.fullFleets]
		}
	else
		arg_22_0.contextData.fleets = underscore.rest(arg_22_0.contextData.fullFleets)

		if arg_22_1 ~= arg_22_0.contextData.mode and arg_22_0.contextData.fleetIndex == 2 then
			arg_22_0.contextData.fleetIndex = #arg_22_0.contextData.fleets
		end
	end

	PlayerPrefs.SetInt("series_mode_flag" .. arg_22_0.contextData.seriesData.id, arg_22_1)

	return
end

function var_0_0.openCommanderPanel(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.contextData.actId

	arg_23_0:addSubLayers(Context.New({
		mediator = BossRushCMDFormationMediator,
		viewComponent = BossRushCMDFormationView,
		data = {
			fleet = arg_23_1,
			callback = function(arg_24_0)
				if arg_24_0.type == LevelUIConst.COMMANDER_OP_SHOW_SKILL then
					arg_23_0.viewComponent:emit(var_0_0.ON_COMMANDER_SKILL, arg_24_0.skill)
				elseif arg_24_0.type == LevelUIConst.COMMANDER_OP_ADD then
					arg_23_0:closeCommanderPanel()
					arg_23_0.viewComponent:emit(var_0_0.ON_SELECT_COMMANDER, arg_23_2, arg_24_0.pos)
				else
					arg_23_0:sendNotification(GAME.COMMANDER_FORMATION_OP, {
						data = {
							FleetType = LevelUIConst.FLEET_TYPE_BOSSRUSH,
							data = arg_24_0,
							fleetId = arg_23_1.id,
							actId = var_23_0,
							fleets = arg_23_0.contextData.fleets
						}
					})
				end

				return
			end
		}
	}))

	return
end

function var_0_0.closeCommanderPanel(arg_25_0)
	local var_25_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(BossRushCMDFormationMediator)

	if var_25_0 then
		arg_25_0:sendNotification(GAME.REMOVE_LAYERS, {
			context = var_25_0
		})
	end

	return
end

function var_0_0.listNotificationInterests(arg_26_0)
	return {
		GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE,
		BossRushPreCombatMediator.ON_FLEET_REFRESHED
	}
end

function var_0_0.handleNotification(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1:getName()
	local var_27_1 = arg_27_1:getBody()

	if var_27_0 == nil then
		-- block empty
	elseif var_27_0 == GAME.COMMANDER_ACTIVITY_FORMATION_OP_DONE then
		arg_27_0.viewComponent:updateEliteFleets()
	elseif var_27_0 == BossRushPreCombatMediator.ON_FLEET_REFRESHED then
		arg_27_0.viewComponent:updateEliteFleets()
	end

	return
end

function var_0_0.remove(arg_28_0)
	return
end

function var_0_0.getDockCallbackFuncs(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	local var_29_0 = getProxy(BayProxy)

	return function(arg_30_0, arg_30_1)
		local var_30_0, var_30_1 = ShipStatus.ShipStatusCheck("inActivity", arg_30_0, arg_30_1, {
			inActivity = arg_29_4
		})

		if not var_30_0 then
			return var_30_0, var_30_1
		end

		if arg_29_0 and arg_29_0:isSameKind(arg_30_0) then
			return true
		end

		for iter_30_0, iter_30_1 in ipairs(arg_29_3) do
			if arg_30_0:isSameKind(var_29_0:getShipById(iter_30_1)) then
				local var_30_3 = i18n("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end, function(arg_31_0, arg_31_1, arg_31_2)
		arg_31_1()

		return
	end, function(arg_32_0)
		if arg_29_0 then
			arg_29_1:removeShip(arg_29_0)
		end

		if #arg_32_0 > 0 then
			local var_32_0 = var_29_0:getShipById(arg_32_0[1])

			if not arg_29_1:containShip(var_32_0) then
				arg_29_1:insertShip(var_32_0, nil, arg_29_2)
			elseif arg_29_0 then
				arg_29_1:insertShip(arg_29_0, nil, arg_29_2)
			end

			arg_29_1:RemoveUnusedItems()
		end

		getProxy(FleetProxy):updateActivityFleet(arg_29_4, arg_29_1.id, arg_29_1)

		return
	end
end

return var_0_0
