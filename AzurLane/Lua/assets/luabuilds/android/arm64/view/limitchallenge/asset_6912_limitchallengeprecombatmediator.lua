class = var_0_10000

local var_0_0 = "LimitChallengePreCombatMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_UPDATE_CUSTOM_FLEET = "LimitChallengePreCombatMediator:ON_UPDATE_CUSTOM_FLEET"
var_0_1.ON_START = "LimitChallengePreCombatMediator:ON_START"
var_0_1.BEGIN_STAGE = "LimitChallengePreCombatMediator:BEGIN_STAGE"
var_0_1.OPEN_SHIP_INFO = "LimitChallengePreCombatMediator:OPEN_SHIP_INFO"
var_0_1.CHANGE_FLEET_SHIP = "LimitChallengePreCombatMediator:CHANGE_FLEET_SHIP"
var_0_1.CHANGE_FLEET_SHIPS_ORDER = "LimitChallengePreCombatMediator:CHANGE_FLEET_SHIPS_ORDER"
var_0_1.REMOVE_SHIP = "LimitChallengePreCombatMediator:REMOVE_SHIP"
var_0_1.ON_AUTO = "LimitChallengePreCombatMediator:ON_AUTO"
var_0_1.ON_SUB_AUTO = "LimitChallengePreCombatMediator:ON_SUB_AUTO"
var_0_1.ON_CHANGE_FLEET = "LimitChallengePreCombatMediator:ON_CHANGE_FLEET"
var_0_1.ON_CMD_SKILL = "LimitChallengePreCombatMediator:ON_CMD_SKILL"
var_0_1.ON_SELECT_COMMANDER = "LimitChallengePreCombatMediator:ON_SELECT_COMMANDER"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.bindEvent(var_1_0)

	getProxy = var_1
	BayProxy = var_1_0

	local var_1_1 = var_1(var_1_0)

	arg_1_0.ships = var_1.getRawData(var_1_1)

	local var_1_2 = arg_1_0.viewComponent

	var_2.SetShips(var_1_2, arg_1_0.ships)

	pg = var_2

	local var_1_3 = var_2.SystemOpenMgr.GetInstance()
	local var_1_4 = var_2.isOpenSystem

	getProxy = var_5
	PlayerProxy = var_1_10007

	local var_1_5 = var_5(var_1_10007)
	local var_1_6

	if var_1_4(var_1_3, var_5.getRawData(var_1_5).level, "CommanderCatMediator") then
		LOCK_COMMANDER = var_1_6
		var_1_6 = not var_1_6
	end

	local var_1_7 = arg_1_0.viewComponent

	var_3.SetOpenCommander(var_1_7, var_1_6)

	_ = var_3

	local var_1_8 = var_3.map
	local var_1_9 = {}

	FleetProxy = var_6
	var_1_9[1] = var_6.CHALLENGE_FLEET_ID
	FleetProxy = var_6
	var_1_9[2] = var_6.CHALLENGE_SUB_FLEET_ID
	arg_1_0.fleets = var_1_8(var_1_9, function(arg_2_0)
		getProxy = var_2_10001
		FleetProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)

		return var_1.getFleetById(var_2_0, arg_2_0)
	end)
	arg_1_0.contextData.fleets = var_3

	local var_1_10 = arg_1_0.viewComponent

	var_4.SetFleets(var_1_10, var_3)

	local var_1_11 = arg_1_0.contextData
	local var_1_12

	if not arg_1_0.contextData.fleetIndex then
		var_1_12 = 1
	end

	var_1_11.fleetIndex = var_1_12

	local var_1_13 = var_3[arg_1_0.contextData.fleetIndex]
	local var_1_14 = arg_1_0.viewComponent

	var_5.SetCurrentFleet(var_1_14, var_1_13.id)

	local var_1_15 = arg_1_0.viewComponent
	local var_1_16 = var_5.SetSubFlag
	local var_1_17 = var_3[#var_3]

	var_1_16(var_1_15, var_8.isLegalToFight(var_1_17) == true)

	local var_1_18 = arg_1_0.viewComponent

	var_5.SetStageID(var_1_18, arg_1_0.contextData.stageId)

	return
end

function var_0_1.bindEvent(arg_3_0)
	arg_3_0:bind(var_0_1.ON_CHANGE_FLEET, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_3_0

		var_2.changeFleet(var_4_0, arg_4_1)

		return
	end)
	arg_3_0:bind(var_0_1.ON_AUTO, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_3_0

		var_2.onAutoBtn(var_5_0, arg_5_1)

		return
	end)
	arg_3_0:bind(var_0_1.ON_SUB_AUTO, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_3_0

		var_2.onAutoSubBtn(var_6_0, arg_6_1)

		return
	end)
	arg_3_0:bind(var_0_1.CHANGE_FLEET_SHIPS_ORDER, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_3_0

		var_2.refreshEdit(var_7_0, arg_7_1)

		return
	end)
	arg_3_0:bind(var_0_1.REMOVE_SHIP, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_3_0

		var_3.removeShipFromFleet(var_8_0, arg_8_2, arg_8_1)

		local var_8_1 = arg_3_0

		var_3.refreshEdit(var_8_1, arg_8_2)

		return
	end)
	arg_3_0:bind(var_0_1.OPEN_SHIP_INFO, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = {}

		ipairs = var_2_10004

		for iter_9_0, iter_9_1 in var_2_10004(arg_9_2:getShipIds()) do
			table = var_2_10009

			var_2_10009.insert(var_9_0, arg_3_0.ships[iter_9_1])
		end

		local var_9_1 = arg_3_0
		local var_9_2 = var_4.sendNotification

		GAME = iter_9_0

		local var_9_3 = iter_9_0.GO_SCENE

		SCENE = iter_9_1

		var_9_2(var_9_1, var_9_3, iter_9_1.SHIPINFO, {
			shipId = arg_9_1,
			shipVOs = var_9_0
		})

		return
	end)
	arg_3_0:bind(var_0_1.CHANGE_FLEET_SHIP, function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		_ = var_2_10004

		local var_10_0 = var_2_10004.flatten

		_ = var_2_10006

		local var_10_1 = var_10_0(var_2_10006.map(arg_3_0.contextData.fleets, function(arg_11_0)
			return arg_11_0:GetRawShipIds()
		end))
		local var_10_2, var_10_3, var_10_4 = var_0_1.getDockCallbackFuncs(arg_10_1, arg_10_2, arg_10_3, var_10_1, arg_3_0.contextData.actId)
		local var_10_5 = arg_3_0
		local var_10_6 = var_8.sendNotification

		GAME = var_11

		local var_10_7 = var_11.GO_SCENE

		SCENE = var_2_10012

		local var_10_8 = var_2_10012.DOCKYARD
		local var_10_9 = {
			selectedMin = 0,
			skipSelect = true,
			useBlackBlock = true,
			selectedMax = 1,
			energyDisplay = false
		}

		i18n = var_2_10014
		var_10_9.leastLimitMsg = var_2_10014("battle_preCombatMediator_leastLimit")
		var_10_9.quitTeam = arg_10_1 ~= nil
		var_10_9.teamFilter = arg_10_3
		var_10_9.onShip = var_10_2
		var_10_9.confirmSelect = var_10_3
		var_10_9.onSelected = var_10_4
		ShipStatus = var_14
		var_10_9.hideTagFlags = var_14.TAG_HIDE_CHALLENGE
		var_10_9.blockTagFlags = {
			inEvent = true
		}
		var_10_9.otherSelectedIds = var_10_1
		pg = var_14

		local var_10_10 = var_14.ShipFlagMgr.GetInstance()

		var_10_9.ignoredIds = var_14.FilterShips(var_10_10, {
			isActivityNpc = true
		})

		var_10_6(var_10_5, var_10_7, var_10_8, var_10_9)

		return
	end)
	arg_3_0:bind(var_0_1.ON_UPDATE_CUSTOM_FLEET, function(arg_12_0)
		_ = var_2_10001

		var_2_10001.each(arg_3_0.contextData.fleets, function(arg_13_0)
			local var_13_0 = arg_3_0
			local var_13_1 = var_1.sendNotification

			GAME = var_3_10004

			var_13_1(var_13_0, var_3_10004.UPDATE_FLEET, {
				fleet = arg_13_0
			})

			local var_13_2 = arg_13_0:GetRawCommanderIds()

			_ = var_3_10002

			var_3_10002.each({
				1,
				2
			}, function(arg_14_0)
				local var_14_0 = arg_3_0
				local var_14_1 = var_1.sendNotification

				GAME = var_4_10004

				local var_14_2 = var_4_10004.COOMMANDER_EQUIP_TO_FLEET
				local var_14_3 = {
					fleetId = arg_13_0.id,
					pos = arg_14_0
				}
				local var_14_4

				if not var_13_2[arg_14_0] then
					var_14_4 = 0
				end

				var_14_3.commanderId = var_14_4

				var_14_1(var_14_0, var_14_2, var_14_3)

				return
			end)

			return
		end)

		return
	end)
	arg_3_0:bind(var_0_1.ON_START, function(arg_15_0)
		local var_15_0 = arg_3_0.viewComponent

		var_1.emit(var_15_0, var_0_1.ON_UPDATE_CUSTOM_FLEET)

		seriesAsync = var_1

		var_1({
			function(arg_16_0)
				for iter_16_0 = 1, #arg_3_0.contextData.fleets - 1 do
					local var_16_0 = arg_3_0.contextData.fleets[iter_16_0]

					if var_5.isLegalToFight(var_16_0) ~= true then
						pg = var_6

						local var_16_1 = var_6.TipsMgr.GetInstance()
						local var_16_2 = var_6.ShowTips

						i18n = var_3_10009

						var_16_2(var_16_1, var_3_10009("elite_disable_formation_unsatisfied"))

						return
					end
				end

				local var_16_3 = {}

				_ = var_2

				if var_2.any(arg_3_0.contextData.fleets, function(arg_17_0)
					_ = var_4_10001

					return var_4_10001.any(arg_17_0:GetRawShipIds(), function(arg_18_0)
						getProxy = var_5_10001
						BayProxy = var_5_10003

						local var_18_0 = var_5_10001(var_5_10003)
						local var_18_1 = var_1.RawGetShipById(var_18_0, arg_18_0)

						if var_16_3[var_18_1:getGroupId()] then
							return true
						end

						var_16_3[var_18_1:getGroupId()] = true

						return
					end)
				end) then
					pg = var_2

					local var_16_4 = var_2.TipsMgr.GetInstance()
					local var_16_5 = var_2.ShowTips

					i18n = var_5

					var_16_5(var_16_4, var_5("guild_event_exist_same_kind_ship"))

					return
				end

				arg_16_0()

				return
			end,
			function(arg_19_0)
				table = var_3_10001

				var_3_10001.SerialIpairsAsync(arg_3_0.contextData.fleets, function(arg_20_0, arg_20_1, arg_20_2)
					local var_20_0 = arg_20_1
					local var_20_1, var_20_2 = arg_20_1.HaveShipsInEvent(var_20_0)

					if var_20_1 then
						pg = var_20_0

						local var_20_3 = var_20_0.TipsMgr.GetInstance()

						var_5.ShowTips(var_20_3, var_20_2)

						return
					end

					local var_20_4 = arg_3_0.contextData.actId

					_ = var_4_10006

					if var_4_10006.any(arg_20_1:getShipIds(), function(arg_21_0)
						getProxy = var_5_10001
						BayProxy = var_5_10003

						local var_21_0 = var_5_10001(var_5_10003)

						if not var_1.RawGetShipById(var_21_0, arg_21_0) then
							return
						end

						ShipStatus = var_5_10002

						local var_21_1, var_21_2 = var_5_10002.ShipStatusCheck("inChallenge", var_1)

						if not var_21_1 then
							pg = var_4

							local var_21_3 = var_4.TipsMgr.GetInstance()

							var_4.ShowTips(var_21_3, var_21_2)

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
				local var_22_0 = arg_3_0.viewComponent

				var_1.emit(var_22_0, var_0_1.BEGIN_STAGE)

				return
			end
		})

		return
	end)
	arg_3_0:bind(var_0_1.BEGIN_STAGE, function(arg_23_0)
		local var_23_0 = arg_3_0
		local var_23_1 = var_1.sendNotification

		GAME = var_2_10004

		var_23_1(var_23_0, var_2_10004.BEGIN_STAGE, {
			stageId = arg_3_0.contextData.stageId,
			system = arg_3_0.contextData.system,
			actId = arg_3_0.contextData.actId
		})

		return
	end)
	arg_3_0:bind(var_0_1.ON_CMD_SKILL, function(arg_24_0, arg_24_1)
		local var_24_0 = arg_3_0
		local var_24_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_24_2 = var_2_10005.New
		local var_24_3 = {}

		CommanderSkillMediator = var_2_10008
		var_24_3.mediator = var_2_10008
		CommanderSkillLayer = var_2_10008
		var_24_3.viewComponent = var_2_10008
		var_24_3.data = {
			skill = arg_24_1
		}

		var_24_1(var_24_0, var_24_2(var_24_3))

		return
	end)
	arg_3_0:bind(var_0_1.ON_SELECT_COMMANDER, function(arg_25_0, arg_25_1, arg_25_2)
		_ = var_2_10003

		local var_25_0 = var_2_10003.map
		local var_25_1 = {}

		FleetProxy = var_2_10006
		var_25_1[1] = var_2_10006.CHALLENGE_FLEET_ID
		FleetProxy = var_6
		var_25_1[2] = var_6.CHALLENGE_SUB_FLEET_ID

		local var_25_2 = var_25_0(var_25_1, function(arg_26_0)
			getProxy = var_3_10001
			FleetProxy = var_3_10003

			local var_26_0 = var_3_10001(var_3_10003)

			return var_1.getFleetById(var_26_0, arg_26_0)
		end)

		var_0_1.onSelectCommander(var_25_2, arg_25_1, arg_25_2)

		return
	end)

	return
end

function var_0_1.onAutoBtn(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1.isOn
	local var_27_1 = arg_27_1.toggle
	local var_27_2 = arg_27_0
	local var_27_3 = arg_27_0.sendNotification

	GAME = var_1_10007

	var_27_3(var_27_2, var_1_10007.AUTO_BOT, {
		isActiveBot = var_27_0,
		toggle = var_27_1,
		system = arg_27_0.contextData.system
	})

	return
end

function var_0_1.onAutoSubBtn(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1.isOn
	local var_28_1 = arg_28_1.toggle
	local var_28_2 = arg_28_0
	local var_28_3 = arg_28_0.sendNotification

	GAME = var_1_10007

	var_28_3(var_28_2, var_1_10007.AUTO_SUB, {
		isActiveSub = var_28_0,
		toggle = var_28_1,
		system = arg_28_0.contextData.system
	})

	return
end

function var_0_1.changeFleet(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.contextData

	table = var_1_10003

	local var_29_1 = var_1_10003.indexof
	local var_29_2 = arg_29_0.contextData.fleets

	_ = var_1_10006
	var_29_0.fleetIndex = var_29_1(var_29_2, var_1_10006.detect(arg_29_0.contextData.fleets, function(arg_30_0)
		return arg_30_0.id == arg_29_1
	end))

	local var_29_3 = arg_29_0.viewComponent

	var_2.SetCurrentFleet(var_29_3, arg_29_1)

	local var_29_4 = arg_29_0.viewComponent

	var_2.UpdateFleetView(var_29_4, true)

	local var_29_5 = arg_29_0.viewComponent

	var_2.SetFleetStepper(var_29_5)

	return
end

function var_0_1.refreshEdit(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.viewComponent

	var_2.UpdateFleetView(var_31_0, false)

	local var_31_1 = arg_31_0.contextData.fleets
	local var_31_2 = arg_31_0.viewComponent
	local var_31_3 = var_3.SetSubFlag
	local var_31_4 = var_31_1[#var_31_1]

	var_31_3(var_31_2, var_6.isLegalToFight(var_31_4) == true)

	getProxy = var_31_3
	FleetProxy = var_31_2

	local var_31_5 = var_31_3(var_31_2)

	var_3.updateFleet(var_31_5, arg_31_1)

	return
end

function var_0_1.removeShipFromFleet(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_1:canRemove(arg_32_2) then
		local var_32_0 = arg_32_1
		local var_32_1, var_32_2 = arg_32_1.getShipPos(var_32_0, arg_32_2)

		pg = var_32_0

		local var_32_3 = var_32_0.TipsMgr.GetInstance()
		local var_32_4 = var_5.ShowTips

		i18n = var_1_10008

		local var_32_5 = "ship_formationUI_removeError_onlyShip"
		local var_32_6 = arg_32_2
		local var_32_7 = arg_32_2.getConfigTable(var_32_6).name
		local var_32_8 = arg_32_1.name

		Fleet = var_32_6

		var_32_4(var_32_3, var_1_10008(var_32_5, var_32_7, var_32_8, var_32_6.C_TEAM_NAME[var_32_2]))

		return false
	end

	arg_32_1:removeShip(arg_32_2)

	return true
end

function var_0_1.listNotificationInterests(arg_33_0)
	local var_33_0 = {}

	GAME = var_1_10002
	var_33_0[1] = var_1_10002.BEGIN_STAGE_DONE
	GAME = var_2
	var_33_0[2] = var_2.BEGIN_STAGE_ERRO

	return var_33_0
end

function var_0_1.handleNotification(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1
	local var_34_1 = arg_34_1.getName(var_34_0)
	local var_34_2 = arg_34_1:getBody()

	GAME = var_34_0

	local var_34_4

	if var_34_1 == var_34_0.BEGIN_STAGE_DONE then
		local var_34_3 = arg_34_0

		var_34_4 = arg_34_0.sendNotification
		GAME = var_1_10007

		local var_34_5 = var_1_10007.GO_SCENE

		SCENE = var_1_10008

		var_34_4(var_34_3, var_34_5, var_1_10008.COMBATLOAD, var_34_2)
	else
		GAME = var_34_4

		if var_34_1 == var_34_4.BEGIN_STAGE_ERRO and var_34_2 == 3 then
			pg = var_4

			local var_34_6 = var_4.MsgboxMgr.GetInstance()
			local var_34_7 = var_4.ShowMsgBox
			local var_34_8 = {
				hideNo = true
			}

			i18n = var_1_10008
			var_34_8.content = var_1_10008("battle_preCombatMediator_timeout")

			function var_34_8.onYes()
				local var_35_0 = arg_34_0.viewComponent
				local var_35_1 = var_0.emit

				BaseUI = var_2_10003

				var_35_1(var_35_0, var_2_10003.ON_CLOSE)

				return
			end

			var_34_7(var_34_6, var_34_8)
		end
	end

	return
end

function var_0_1.remove(arg_36_0)
	var_0_1.super.remove(arg_36_0)

	return
end

function var_0_1.getDockCallbackFuncs(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	getProxy = var_1_10005
	BayProxy = var_1_10007

	local var_37_0 = var_1_10005(var_1_10007)

	local function var_37_1(arg_38_0, arg_38_1)
		ShipStatus = var_2_10002

		local var_38_0, var_38_1 = var_2_10002.ShipStatusCheck("inChallenge", arg_38_0, arg_38_1)

		if not var_38_0 then
			return var_38_0, var_38_1
		end

		if arg_37_0 then
			local var_38_2 = arg_37_0

			if var_4.isSameKind(var_38_2, arg_38_0) then
				return true
			end
		end

		ipairs = var_4

		for iter_38_0, iter_38_1 in var_4(arg_37_3) do
			local var_38_3 = arg_38_0
			local var_38_4 = arg_38_0.isSameKind
			local var_38_5 = var_37_0

			if var_38_4(var_38_3, var_12.getShipById(var_38_5, iter_38_1)) then
				local var_38_6 = false

				i18n = var_2_10010
				var_2_10010 = var_2_10010("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end

	local function var_37_2(arg_39_0, arg_39_1, arg_39_2)
		arg_39_1()

		return
	end

	local function var_37_3(arg_40_0)
		local var_40_0

		if #arg_40_0 == 0 then
			if arg_37_0 then
				var_2_10003 = arg_37_1

				var_40_0.removeShip(var_2_10003, arg_37_0)
			end
		elseif #arg_40_0 > 0 then
			var_2_10003 = arg_37_1
			var_40_0 = var_40_0.getShipPos(var_2_10003, arg_37_0)

			local var_40_1 = var_37_0
			local var_40_2 = var_2.getShipById(var_40_1, arg_40_0[1])

			if var_40_0 then
				local var_40_3 = arg_37_1

				var_2_10003.removeShip(var_40_3, arg_37_0)

				if var_40_2.id == arg_37_0.id then
					var_40_0 = nil
				end
			end

			local var_40_4 = arg_37_1

			var_2_10003.insertShip(var_40_4, var_40_2, var_40_0, arg_37_2)

			local var_40_5 = arg_37_1

			var_2_10003.RemoveUnusedItems(var_40_5)
		end

		getProxy = var_40_0
		FleetProxy = var_2_10003

		local var_40_6 = var_40_0(var_2_10003)

		var_1.updateFleet(var_40_6, arg_37_1)

		return
	end

	return var_37_1, var_37_2, var_37_3
end

function var_0_1.onSelectCommander(arg_41_0, arg_41_1, arg_41_2)
	_ = var_1_10003

	local var_41_0 = var_1_10003.detect(arg_41_0, function(arg_42_0)
		return arg_42_0.id == arg_41_2
	end)

	assert = var_1_10004

	var_1_10004(var_41_0)

	local var_41_1 = var_41_0:getCommanderByPos(arg_41_1)

	pg = var_5

	local var_41_2 = var_5.m02
	local var_41_3 = var_5.sendNotification

	GAME = var_1_10008

	local var_41_4 = var_1_10008.GO_SCENE

	SCENE = var_1_10009

	local var_41_5 = var_1_10009.COMMANDERCAT
	local var_41_6 = {
		maxCount = 1
	}

	CommanderCatScene = var_1_10011
	var_41_6.mode = var_1_10011.MODE_SELECT
	CommanderCatScene = var_11
	var_41_6.fleetType = var_11.FLEET_TYPE_LIMIT_CHALLENGE
	var_41_6.activeCommander = var_41_1
	var_41_6.ignoredIds = {}

	function var_41_6.onCommander(arg_43_0)
		return true
	end

	function var_41_6.onSelected(arg_44_0, arg_44_1)
		local var_44_0 = arg_44_0[1]

		getProxy = var_2_10003
		CommanderProxy = var_2_10005

		local var_44_1 = var_2_10003(var_2_10005)
		local var_44_2 = var_3.getCommanderById(var_44_1, var_44_0)

		pairs = var_2_10004

		for iter_44_0, iter_44_1 in var_2_10004(arg_41_0) do
			if iter_44_1.id == arg_41_2 then
				local var_44_3 = iter_44_1:getCommanders()

				pairs = var_10

				for iter_44_2, iter_44_3 in var_10(var_44_3) do
					if iter_44_3.groupId == var_44_2.groupId and iter_44_2 ~= arg_41_1 then
						pg = var_15

						local var_44_4 = var_15.TipsMgr.GetInstance()
						local var_44_5 = var_15.ShowTips

						i18n = var_2_10018

						var_44_5(var_44_4, var_2_10018("commander_can_not_select_same_group"))

						return
					end
				end
			else
				local var_44_6 = iter_44_1:getCommanders()

				pairs = var_10

				for iter_44_4, iter_44_5 in var_10(var_44_6) do
					if var_44_0 == iter_44_5.id then
						pg = var_15

						local var_44_7 = var_15.TipsMgr.GetInstance()
						local var_44_8 = var_15.ShowTips

						i18n = var_2_10018

						var_44_8(var_44_7, var_2_10018("commander_is_in_fleet_already"))

						return
					end
				end
			end
		end

		local var_44_9 = var_41_0

		var_4.updateCommanderByPos(var_44_9, arg_41_1, var_44_2)

		getProxy = var_4
		FleetProxy = var_44_9

		local var_44_10 = var_4(var_44_9)

		var_4.updateFleet(var_44_10, var_41_0)
		arg_44_1()

		return
	end

	function var_41_6.onQuit(arg_45_0)
		local var_45_0 = var_41_0

		var_1.updateCommanderByPos(var_45_0, arg_41_1, nil)

		getProxy = var_1
		FleetProxy = var_45_0

		local var_45_1 = var_1(var_45_0)

		var_1.updateFleet(var_45_1, var_41_0)
		arg_45_0()

		return
	end

	var_41_3(var_41_2, var_41_4, var_41_5, var_41_6)

	return
end

return var_0_1
