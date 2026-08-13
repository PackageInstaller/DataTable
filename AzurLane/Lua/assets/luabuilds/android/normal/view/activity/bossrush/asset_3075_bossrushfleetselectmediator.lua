class = var_0_10000

local var_0_0 = "BossRushFleetSelectMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_OPEN_DECK = "BossRushFleetSelectMediator:ON_OPEN_DECK"
var_0_1.ON_FLEET_SHIPINFO = "BossRushFleetSelectMediator:ON_FLEET_SHIPINFO"
var_0_1.ON_TRACE = "BossRushFleetSelectMediator:ON_TRACE"
var_0_1.ON_UPDATE_CUSTOM_FLEET = "BossRushFleetSelectMediator:ON_UPDATE_CUSTOM_FLEET"
var_0_1.ON_PRECOMBAT = "BossRushFleetSelectMediator:ON_PRECOMBAT"
var_0_1.ON_ELITE_RECOMMEND = "BossRushFleetSelectMediator:ON_ELITE_RECOMMEND"
var_0_1.ON_ELITE_CLEAR = "BossRushFleetSelectMediator:ON_ELITE_CLEAR"
var_0_1.OPEN_COMMANDER_PANEL = "BossRushFleetSelectMediator:OPEN_COMMANDER_PANEL"
var_0_1.ON_SELECT_COMMANDER = "BossRushFleetSelectMediator:ON_SELECT_COMMANDER"
var_0_1.ON_COMMANDER_SKILL = "BossRushFleetSelectMediator:ON_COMMANDER_SKILL"
var_0_1.ON_SWITCH_MODE = "BossRushFleetSelectMediator:ON_SWITCH_MODE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_OPEN_DECK, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_1.fleetIndex
		local var_2_1 = arg_2_1.shipVO

		_ = var_2_10004

		local var_2_2 = var_2_10004.flatten

		_ = var_2_10005

		local var_2_3 = var_2_2(var_2_10005.map(arg_1_0.contextData.fleets, function(arg_3_0)
			return arg_3_0:GetRawShipIds()
		end))
		local var_2_4 = arg_2_1.teamType
		local var_2_5, var_2_6, var_2_7 = arg_1_0.getDockCallbackFuncs(var_2_1, arg_1_0.contextData.fleets[var_2_0], var_2_4, var_2_3, arg_1_0.contextData.actId)
		local var_2_8 = arg_1_0
		local var_2_9 = var_9.sendNotification

		GAME = var_11

		local var_2_10 = var_11.GO_SCENE

		SCENE = var_2_10012

		local var_2_11 = var_2_10012.DOCKYARD
		local var_2_12 = {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1,
			energyDisplay = true
		}

		i18n = var_2_10014
		var_2_12.leastLimitMsg = var_2_10014("ship_formationMediator_leastLimit")
		var_2_12.quitTeam = var_2_1 ~= nil
		var_2_12.teamFilter = var_2_4
		i18n = var_14
		var_2_12.leftTopInfo = var_14("word_formation")
		var_2_12.onShip = var_2_5
		var_2_12.confirmSelect = var_2_6
		var_2_12.onSelected = var_2_7
		setmetatable = var_14

		local var_2_13 = {
			inActivity = arg_1_0.contextData.actId
		}
		local var_2_14 = {}

		ShipStatus = var_2_10017
		var_2_14.__index = var_2_10017.TAG_HIDE_ACTIVITY_BOSS
		var_2_12.hideTagFlags = var_14(var_2_13, var_2_14)
		var_2_12.otherSelectedIds = var_2_3

		var_2_9(var_2_8, var_2_10, var_2_11, var_2_12)

		return
	end)
	arg_1_0:bind(var_0_1.ON_FLEET_SHIPINFO, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0.contextData.fleet
		local var_4_1 = arg_1_0
		local var_4_2 = var_3.sendNotification

		GAME = var_2_10005

		local var_4_3 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_4_2(var_4_1, var_4_3, var_2_10006.SHIPINFO, {
			shipId = arg_4_1.shipId,
			shipVOs = arg_4_1.shipVOs
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_UPDATE_CUSTOM_FLEET, function(arg_5_0)
		_ = var_2_10001

		var_2_10001.each(arg_1_0.contextData.fullFleets, function(arg_6_0)
			getProxy = var_3_10001
			FleetProxy = var_3_10002

			local var_6_0 = var_3_10001(var_3_10002)

			var_1.updateActivityFleet(var_6_0, arg_1_0.contextData.actId, arg_6_0.id, arg_6_0)

			return
		end)

		local var_5_0 = {}

		_ = var_2

		var_2.each(arg_1_0.contextData.fullFleets, function(arg_7_0)
			var_5_0[arg_7_0.id] = arg_7_0

			return
		end)

		local var_5_1 = arg_1_0
		local var_5_2 = var_2.sendNotification

		GAME = var_4

		var_5_2(var_5_1, var_4.EDIT_ACTIVITY_FLEET, {
			actID = arg_1_0.contextData.actId,
			fleets = var_5_0
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_TRACE, function(arg_8_0)
		local var_8_0 = arg_1_0.viewComponent

		var_1.emit(var_8_0, var_0_1.ON_UPDATE_CUSTOM_FLEET)

		local var_8_1 = arg_1_0
		local var_8_2 = var_1.sendNotification

		GAME = var_3

		var_8_2(var_8_1, var_3.BOSSRUSH_TRACE, {
			actId = arg_1_0.contextData.actId,
			seriesId = arg_1_0.contextData.seriesData.id,
			mode = arg_1_0.contextData.mode
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_ELITE_RECOMMEND, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_1.index
		local var_9_1 = arg_1_0.contextData.fleets[var_9_0]
		local var_9_2

		var_9_2 = var_9_0 == #arg_1_0.contextData.fleets
		table = var_2_10005

		local var_9_3 = var_2_10005.shallowCopy(var_9_1:GetRawShipIds())

		underscore = var_6

		local var_9_4 = var_6(arg_1_0.contextData.fleets)
		local var_9_5 = var_6.chain(var_9_4)
		local var_9_6 = var_6.map(var_9_5, function(arg_10_0)
			return arg_10_0:GetRawShipIds()
		end)
		local var_9_7 = var_6.flatten(var_9_6)
		local var_9_8 = var_6.value(var_9_7)

		getProxy = var_9_7
		BayProxy = var_8

		local var_9_9 = var_9_7(var_8)
		local var_9_10 = var_7.getRawData(var_9_9)

		local function var_9_11(arg_11_0, arg_11_1)
			TeamType = var_3_10002

			local var_11_0 = var_3_10002.GetTeamShipMax(arg_11_1)

			underscore = var_3

			local var_11_1 = var_3.filter
			local var_11_2 = var_9_1
			local var_11_3 = var_11_0 - #var_11_1(var_4.GetRawShipIds(var_11_2), function(arg_12_0)
				local var_12_0 = var_9_10[arg_12_0]

				return var_1.getTeamType(var_12_0) == arg_11_1
			end)

			getProxy = var_3
			BayProxy = var_4

			local var_11_4 = var_3(var_4)
			local var_11_5 = var_3.getActivityRecommendShips(var_11_4, arg_11_0, var_9_8, var_11_3, arg_1_0.contextData.actId)

			ipairs = var_11_4

			for iter_11_0, iter_11_1 in var_11_4(var_11_5) do
				local var_11_6 = var_9_1

				var_9.insertShip(var_11_6, iter_11_1, nil, iter_11_1:getTeamType())

				table = var_9

				var_9.insert(var_9_3, iter_11_1.id)

				table = var_9

				var_9.insert(var_9_8, iter_11_1.id)
			end

			return
		end

		local var_9_12

		if var_9_0 == #arg_1_0.contextData.fleets then
			local var_9_13 = var_9_11

			ShipType = var_2_10011
			var_2_10011 = var_2_10011.SubShipType
			TeamType = var_2_10012

			var_9_13(var_2_10011, var_2_10012.Submarine)
		else
			local var_9_14 = var_9_11

			ShipType = var_2_10011

			local var_9_15 = var_2_10011.MainShipType

			TeamType = var_2_10012

			var_9_14(var_9_15, var_2_10012.Main)

			local var_9_16 = var_9_11

			ShipType = var_9_15

			local var_9_17 = var_9_15.VanguardShipType

			TeamType = var_12

			var_9_16(var_9_17, var_12.Vanguard)
		end

		local var_9_18 = arg_1_0.viewComponent

		var_10.updateEliteFleets(var_9_18)

		return
	end)
	arg_1_0:bind(var_0_1.ON_ELITE_CLEAR, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_1_0.contextData.fleets[arg_13_1.index]

		var_2.clearFleet(var_13_0)

		local var_13_1 = arg_1_0.viewComponent

		var_3.updateEliteFleets(var_13_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_PRECOMBAT, function(arg_14_0)
		table = var_2_10001

		local var_14_0 = var_2_10001.shallowCopy(arg_1_0.contextData.fleets)
		local var_14_1 = arg_1_0
		local var_14_2 = var_2.addSubLayers

		Context = var_2_10004

		local var_14_3 = var_2_10004.New
		local var_14_4 = {}

		BossRushPreCombatMediator = var_2_10006
		var_14_4.mediator = var_2_10006
		BossRushPreCombatLayer = var_2_10006
		var_14_4.viewComponent = var_2_10006
		var_14_4.data = {
			seriesData = arg_1_0.contextData.seriesData,
			actId = arg_1_0.contextData.actId,
			system = arg_1_0.contextData.system,
			mode = arg_1_0.contextData.mode,
			stageIds = arg_1_0.contextData.stageIds,
			fleets = var_14_0,
			fleetIndex = arg_1_0.contextData.fleetIndex
		}

		var_14_2(var_14_1, var_14_3(var_14_4), true)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_COMMANDER_PANEL, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_1_0

		var_2.openCommanderPanel(var_15_0, arg_15_1, arg_1_0.contextData.fleetIndex)

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECT_COMMANDER, function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_1_0.contextData.fleets[arg_16_1]
		local var_16_1 = var_4.getCommanders(var_16_0)
		local var_16_2 = arg_1_0
		local var_16_3 = var_6.sendNotification

		GAME = var_2_10008

		local var_16_4 = var_2_10008.GO_SCENE

		SCENE = var_2_10009

		local var_16_5 = var_2_10009.COMMANDERCAT
		local var_16_6 = {
			maxCount = 1
		}

		CommanderCatScene = var_2_10011
		var_16_6.mode = var_2_10011.MODE_SELECT
		var_16_6.activeCommander = var_16_1[arg_16_2]
		CommanderCatScene = var_11
		var_16_6.fleetType = var_11.FLEET_TYPE_BOSSRUSH
		var_16_6.fleets = var_3
		var_16_6.ignoredIds = {}

		function var_16_6.onCommander(arg_17_0)
			return true
		end

		function var_16_6.onSelected(arg_18_0, arg_18_1)
			local var_18_0 = arg_18_0[1]

			getProxy = var_3_10003
			CommanderProxy = var_3_10004

			local var_18_1 = var_3_10003(var_3_10004)
			local var_18_2 = var_3.getCommanderById(var_18_1, var_18_0)

			pairs = var_18_1

			for iter_18_0, iter_18_1 in var_18_1(var_0) do
				if iter_18_0 == arg_16_1 then
					pairs = var_10

					for iter_18_2, iter_18_3 in var_10(var_16_1) do
						if iter_18_3.groupId == var_18_2.groupId and iter_18_2 ~= arg_16_2 then
							pg = var_15

							local var_18_3 = var_15.TipsMgr.GetInstance()
							local var_18_4 = var_15.ShowTips

							i18n = var_3_10017

							var_18_4(var_18_3, var_3_10017("commander_can_not_select_same_group"))

							return
						end
					end
				else
					local var_18_5 = iter_18_1
					local var_18_6 = iter_18_1.getCommanders(var_18_5)

					pairs = var_18_5

					for iter_18_4, iter_18_5 in var_18_5(var_18_6) do
						if var_18_0 == iter_18_5.id then
							pg = var_16
							var_3_10017 = var_16.TipsMgr.GetInstance()

							local var_18_7 = var_16.ShowTips

							i18n = var_3_10018

							var_18_7(var_3_10017, var_3_10018("commander_is_in_fleet_already"))

							return
						end
					end
				end
			end

			local var_18_8 = var_0

			var_5.updateCommanderByPos(var_18_8, arg_16_2, var_18_2)
			arg_18_1()

			return
		end

		function var_16_6.onQuit(arg_19_0)
			local var_19_0 = var_0

			var_1.updateCommanderByPos(var_19_0, arg_16_2, nil)
			arg_19_0()

			return
		end

		var_16_3(var_16_2, var_16_4, var_16_5, var_16_6)

		return
	end)
	arg_1_0:bind(var_0_1.ON_COMMANDER_SKILL, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_1_0
		local var_20_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_20_2 = var_2_10004.New
		local var_20_3 = {}

		CommanderSkillMediator = var_2_10006
		var_20_3.mediator = var_2_10006
		CommanderSkillLayer = var_2_10006
		var_20_3.viewComponent = var_2_10006
		var_20_3.data = {
			skill = arg_20_1
		}

		var_20_1(var_20_0, var_20_2(var_20_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_SWITCH_MODE, function(arg_21_0, arg_21_1)
		local var_21_0 = arg_1_0

		var_2.OnSwitchMode(var_21_0, arg_21_1)

		return
	end)

	local var_1_0 = arg_1_0.contextData.seriesData

	arg_1_0.contextData.stageIds = var_1_0:GetExpeditionIds()

	local var_1_1 = arg_1_0.contextData
	local var_1_2 = var_1_0

	var_1_1.fullFleets = var_1_0.GetFleets(var_1_2)

	if not arg_1_0.contextData.mode then
		local var_1_3 = "series_mode_flag" .. var_1_0.id

		PlayerPrefs = var_3

		if var_3.GetInt(var_1_3, -1) ~= -1 then
			var_1_2 = arg_1_0.contextData
			var_1_2.mode = var_3
		end
	end

	local var_1_4 = arg_1_0.contextData
	local var_1_5

	if not arg_1_0.contextData.mode then
		BossRushSeriesData = var_1_5
		var_1_5 = var_1_5.MODE.MULTIPLE
	end

	var_1_4.mode = var_1_5

	local var_1_6 = var_1_0

	if not var_1_0.IsSingleFight(var_1_6) then
		local var_1_7 = arg_1_0.contextData

		BossRushSeriesData = var_1_6
		var_1_7.mode = var_1_6.MODE.MULTIPLE
	end

	local var_1_8 = arg_1_0.contextData.fullFleets
	local var_1_9 = arg_1_0.contextData.mode

	BossRushSeriesData = var_1_2

	if var_1_9 == var_1_2.MODE.SINGLE then
		arg_1_0.contextData.fleets = {
			var_1_8[1],
			var_1_8[#var_1_8]
		}
	else
		local var_1_10 = arg_1_0.contextData
		local var_1_11

		if not arg_1_0.contextData.fleets then
			underscore = var_1_11
			var_1_11 = var_1_11.rest(var_1_8)
		end

		var_1_10.fleets = var_1_11
	end

	local var_1_12 = arg_1_0.contextData
	local var_1_13

	if not arg_1_0.contextData.fleetIndex then
		var_1_13 = 1
	end

	var_1_12.fleetIndex = var_1_13

	local var_1_14 = arg_1_0.contextData.fleetIndex

	if #arg_1_0.contextData.fleets < var_1_14 then
		arg_1_0.contextData.fleetIndex = 1
	end

	if var_1_0.__cname == "CollabrateBossRushSeriesData" then
		local var_1_15 = arg_1_0.contextData

		SYSTEM_BOSS_RUSH_COLLABRATE = var_4
		var_1_15.system = var_4

		goto label_1_0
	end

	local var_1_16 = var_1_0
	local var_1_17 = var_1_0.GetType(var_1_16)

	BossRushSeriesData = var_1_16

	local var_1_18 = var_1_17 == var_1_16.TYPE.EXTRA
	local var_1_19 = arg_1_0.contextData

	if not var_1_18 then
		SYSTEM_BOSS_RUSH = var_1_10005

		if not var_1_10005 then
			SYSTEM_BOSS_RUSH_EX = var_1_10005
		end

		var_1_19.system = var_1_10005

		::label_1_0::

		arg_1_0.contextData.actId = var_1_0.actId

		local var_1_20 = arg_1_0.viewComponent
		local var_1_21 = var_3.setHardShipVOs

		getProxy = var_1_10005
		BayProxy = var_1_10006

		local var_1_22 = var_1_10005(var_1_10006)

		var_1_21(var_1_20, var_5.getRawData(var_1_22))

		return
	end
end

function var_0_1.OnSwitchMode(arg_22_0, arg_22_1)
	assert = var_1_10002

	var_1_10002(arg_22_1)

	local var_22_0 = arg_22_0.contextData.mode

	arg_22_0.contextData.mode = arg_22_1

	local var_22_1 = arg_22_0.contextData.fullFleets
	local var_22_2 = arg_22_0.contextData.mode

	BossRushSeriesData = var_1_10005

	if var_22_2 == var_1_10005.MODE.SINGLE then
		if arg_22_1 ~= var_22_0 then
			if arg_22_0.contextData.fleetIndex < #arg_22_0.contextData.fleets then
				arg_22_0.contextData.fleetIndex = 1
			else
				arg_22_0.contextData.fleetIndex = 2
			end
		end

		arg_22_0.contextData.fleets = {
			var_22_1[1],
			var_22_1[#var_22_1]
		}
	else
		local var_22_3 = arg_22_0.contextData

		underscore = var_5
		var_22_3.fleets = var_5.rest(var_22_1)

		if arg_22_1 ~= var_22_0 and arg_22_0.contextData.fleetIndex == 2 then
			arg_22_0.contextData.fleetIndex = #arg_22_0.contextData.fleets
		end
	end

	local var_22_4 = "series_mode_flag" .. arg_22_0.contextData.seriesData.id

	PlayerPrefs = var_5

	var_5.SetInt(var_22_4, arg_22_1)

	return
end

function var_0_1.openCommanderPanel(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.contextData.actId
	local var_23_1 = arg_23_0
	local var_23_2 = arg_23_0.addSubLayers

	Context = var_1_10006

	local var_23_3 = var_1_10006.New
	local var_23_4 = {}

	BossRushCMDFormationMediator = var_1_10008
	var_23_4.mediator = var_1_10008
	BossRushCMDFormationView = var_1_10008
	var_23_4.viewComponent = var_1_10008
	var_23_4.data = {
		fleet = arg_23_1,
		callback = function(arg_24_0)
			local var_24_0 = arg_24_0.type

			LevelUIConst = var_2_10002

			local var_24_1

			if var_24_0 == var_2_10002.COMMANDER_OP_SHOW_SKILL then
				var_24_1 = arg_23_0.viewComponent

				var_1.emit(var_24_1, var_0_1.ON_COMMANDER_SKILL, arg_24_0.skill)
			else
				local var_24_2 = arg_24_0.type

				LevelUIConst = var_24_1

				if var_24_2 == var_24_1.COMMANDER_OP_ADD then
					local var_24_3 = arg_23_0

					var_1.closeCommanderPanel(var_24_3)

					local var_24_4 = arg_23_0.viewComponent

					var_1.emit(var_24_4, var_0_1.ON_SELECT_COMMANDER, arg_23_2, arg_24_0.pos)
				else
					local var_24_5 = arg_23_0
					local var_24_6 = var_1.sendNotification

					GAME = var_2_10003

					local var_24_7 = var_2_10003.COMMANDER_FORMATION_OP
					local var_24_8 = {}
					local var_24_9 = {}

					LevelUIConst = var_2_10006
					var_24_9.FleetType = var_2_10006.FLEET_TYPE_BOSSRUSH
					var_24_9.data = arg_24_0
					var_24_9.fleetId = arg_23_1.id
					var_24_9.actId = var_23_0
					var_24_9.fleets = arg_23_0.contextData.fleets
					var_24_8.data = var_24_9

					var_24_6(var_24_5, var_24_7, var_24_8)
				end
			end

			return
		end
	}

	var_23_2(var_23_1, var_23_3(var_23_4))

	return
end

function var_0_1.closeCommanderPanel(arg_25_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10002

	local var_25_0 = var_1_10001(var_1_10002)
	local var_25_1 = var_1.getCurrentContext(var_25_0)
	local var_25_2 = var_2.getContextByMediator

	BossRushCMDFormationMediator = var_1_10005

	if var_25_2(var_25_1, var_1_10005) then
		local var_25_3 = arg_25_0
		local var_25_4 = arg_25_0.sendNotification

		GAME = var_1_10006

		var_25_4(var_25_3, var_1_10006.REMOVE_LAYERS, {
			context = var_3
		})
	end

	return
end

function var_0_1.listNotificationInterests(arg_26_0)
	local var_26_0 = {}

	GAME = var_1_10002
	var_26_0[1] = var_1_10002.COMMANDER_ACTIVITY_FORMATION_OP_DONE
	BossRushPreCombatMediator = var_2
	var_26_0[2] = var_2.ON_FLEET_REFRESHED

	return var_26_0
end

function var_0_1.handleNotification(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1:getName()
	local var_27_1 = arg_27_1
	local var_27_2 = arg_27_1.getBody(var_27_1)

	if var_27_0 == nil then
		-- block empty
	else
		GAME = var_27_1

		if var_27_0 == var_27_1.COMMANDER_ACTIVITY_FORMATION_OP_DONE then
			local var_27_3 = arg_27_0.viewComponent

			var_4.updateEliteFleets(var_27_3)
		else
			BossRushPreCombatMediator = var_4

			if var_27_0 == var_4.ON_FLEET_REFRESHED then
				local var_27_4 = arg_27_0.viewComponent

				var_4.updateEliteFleets(var_27_4)
			end
		end
	end

	return
end

function var_0_1.remove(arg_28_0)
	return
end

function var_0_1.getDockCallbackFuncs(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	getProxy = var_1_10005
	BayProxy = var_1_10006

	local var_29_0 = var_1_10005(var_1_10006)

	local function var_29_1(arg_30_0, arg_30_1)
		ShipStatus = var_2_10002

		local var_30_0, var_30_1 = var_2_10002.ShipStatusCheck("inActivity", arg_30_0, arg_30_1, {
			inActivity = arg_29_4
		})

		if not var_30_0 then
			return var_30_0, var_30_1
		end

		if arg_29_0 then
			local var_30_2 = arg_29_0

			if var_4.isSameKind(var_30_2, arg_30_0) then
				return true
			end
		end

		ipairs = var_4

		for iter_30_0, iter_30_1 in var_4(arg_29_3) do
			local var_30_3 = arg_30_0
			local var_30_4 = arg_30_0.isSameKind
			local var_30_5 = var_29_0

			if var_30_4(var_30_3, var_11.getShipById(var_30_5, iter_30_1)) then
				local var_30_6 = false

				i18n = var_30_3

				local var_30_7 = var_30_3("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end

	local function var_29_2(arg_31_0, arg_31_1, arg_31_2)
		arg_31_1()

		return
	end

	local function var_29_3(arg_32_0)
		if arg_29_0 then
			local var_32_0 = arg_29_1

			var_1.removeShip(var_32_0, arg_29_0)
		end

		local var_32_1 = #arg_32_0
		local var_32_2

		if 0 < var_32_1 then
			var_32_2 = var_29_0
			var_32_1 = var_32_1.getShipById(var_32_2, arg_32_0[1])

			local var_32_3 = arg_29_1

			if not var_32_2.containShip(var_32_3, var_32_1) then
				local var_32_4 = arg_29_1

				var_32_2.insertShip(var_32_4, var_32_1, nil, arg_29_2)
			elseif arg_29_0 then
				local var_32_5 = arg_29_1

				var_32_2.insertShip(var_32_5, arg_29_0, nil, arg_29_2)
			end

			local var_32_6 = arg_29_1

			var_32_2.RemoveUnusedItems(var_32_6)
		end

		getProxy = var_32_1
		FleetProxy = var_32_2

		local var_32_7 = var_32_1(var_32_2)

		var_1.updateActivityFleet(var_32_7, arg_29_4, arg_29_1.id, arg_29_1)

		return
	end

	return var_29_1, var_29_2, var_29_3
end

return var_0_1
