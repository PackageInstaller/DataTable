class = var_0_10000

local var_0_0 = "BossRushPreCombatMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_UPDATE_CUSTOM_FLEET = "BossRushPreCombatMediator:ON_UPDATE_CUSTOM_FLEET"
var_0_1.ON_START = "BossRushPreCombatMediator:ON_START"
var_0_1.BEGIN_STAGE = "BossRushPreCombatMediator:BEGIN_STAGE"
var_0_1.SHOW_CONTINUOUS_OPERATION_WINDOW = "BossRushPreCombatMediator:SHOW_CONTINUOUS_OPERATION_WINDOW"
var_0_1.CONTINUOUS_OPERATION = "BossRushPreCombatMediator:CONTINUOUS_OPERATION"
var_0_1.OPEN_SHIP_INFO = "BossRushPreCombatMediator:OPEN_SHIP_INFO"
var_0_1.CHANGE_FLEET_SHIP = "BossRushPreCombatMediator:CHANGE_FLEET_SHIP"
var_0_1.CHANGE_FLEET_SHIPS_ORDER = "BossRushPreCombatMediator:CHANGE_FLEET_SHIPS_ORDER"
var_0_1.REMOVE_SHIP = "BossRushPreCombatMediator:REMOVE_SHIP"
var_0_1.ON_AUTO = "BossRushPreCombatMediator:ON_AUTO"
var_0_1.ON_SUB_AUTO = "BossRushPreCombatMediator:ON_SUB_AUTO"
var_0_1.ON_FLEET_REFRESHED = "BossRushPreCombatMediator:ON_FLEET_REFRESHED"
var_0_1.ON_CHANGE_FLEET = "BossRushPreCombatMediator:ON_CHANGE_FLEET"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.bindEvent(var_1_0)

	getProxy = var_1
	BayProxy = var_1_0

	local var_1_1 = var_1(var_1_0)

	arg_1_0.ships = var_1.getRawData(var_1_1)

	local var_1_2 = arg_1_0.viewComponent

	var_2.SetShips(var_1_2, arg_1_0.ships)

	arg_1_0.fleets = arg_1_0.contextData.fleets

	local var_1_3 = arg_1_0.viewComponent

	var_3.SetFleets(var_1_3, var_2)

	local var_1_4 = var_2[arg_1_0.contextData.fleetIndex]
	local var_1_5 = arg_1_0.viewComponent

	var_4.SetCurrentFleet(var_1_5, var_1_4.id)

	local var_1_6 = arg_1_0.contextData.fleets
	local var_1_7 = arg_1_0.viewComponent
	local var_1_8 = var_5.SetSubFlag
	local var_1_9 = var_1_6[#var_1_6]

	var_1_8(var_1_7, var_7.isLegalToFight(var_1_9) == true)

	return
end

function var_0_1.bindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.ON_CHANGE_FLEET, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.changeFleet(var_3_0, arg_3_1)

		return
	end)
	arg_2_0:bind(var_0_1.ON_AUTO, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.onAutoBtn(var_4_0, arg_4_1)

		return
	end)
	arg_2_0:bind(var_0_1.ON_SUB_AUTO, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_2_0

		var_2.onAutoSubBtn(var_5_0, arg_5_1)

		return
	end)
	arg_2_0:bind(var_0_1.CHANGE_FLEET_SHIPS_ORDER, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_2_0

		var_2.refreshEdit(var_6_0, arg_6_1)

		return
	end)
	arg_2_0:bind(var_0_1.REMOVE_SHIP, function(arg_7_0, arg_7_1, arg_7_2)
		(function(arg_8_0, arg_8_1)
			if not arg_8_0:canRemove(arg_8_1) then
				local var_8_0, var_8_1 = arg_8_0:getShipPos(arg_8_1)

				pg = var_4

				local var_8_2 = var_4.TipsMgr.GetInstance()
				local var_8_3 = var_4.ShowTips

				i18n = var_3_10006

				local var_8_4 = "ship_formationUI_removeError_onlyShip"
				local var_8_5 = arg_8_1:getConfigTable().name
				local var_8_6 = arg_8_0.name

				Fleet = var_3_10010

				var_8_3(var_8_2, var_3_10006(var_8_4, var_8_5, var_8_6, var_3_10010.C_TEAM_NAME[var_8_1]))

				return false
			end

			arg_8_0:removeShip(arg_8_1)

			return true
		end)(arg_7_2, arg_7_1)

		local var_7_0 = arg_2_0

		var_4.refreshEdit(var_7_0, arg_7_2)

		return
	end)
	arg_2_0:bind(var_0_1.OPEN_SHIP_INFO, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = {}

		ipairs = var_2_10004

		for iter_9_0, iter_9_1 in var_2_10004(arg_9_2:getShipIds()) do
			table = var_2_10009

			var_2_10009.insert(var_9_0, arg_2_0.ships[iter_9_1])
		end

		local var_9_1 = arg_2_0
		local var_9_2 = var_4.sendNotification

		GAME = var_6

		local var_9_3 = var_6.GO_SCENE

		SCENE = iter_9_0

		var_9_2(var_9_1, var_9_3, iter_9_0.SHIPINFO, {
			shipId = arg_9_1,
			shipVOs = var_9_0
		})

		return
	end)
	arg_2_0:bind(var_0_1.CHANGE_FLEET_SHIP, function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		local var_10_0

		_ = var_2_10005

		local var_10_1 = var_2_10005.flatten

		_ = var_2_10006

		local var_10_2 = var_10_1(var_2_10006.map(arg_2_0.contextData.fleets, function(arg_11_0)
			return arg_11_0:GetRawShipIds()
		end))

		BossRushFleetSelectMediator = var_6

		local var_10_3, var_10_4, var_10_5 = var_6.getDockCallbackFuncs(arg_10_1, arg_10_2, arg_10_3, var_10_2, arg_2_0.contextData.actId)
		local var_10_6 = arg_2_0
		local var_10_7 = var_9.sendNotification

		GAME = var_11

		local var_10_8 = var_11.GO_SCENE

		SCENE = var_2_10012

		local var_10_9 = var_2_10012.DOCKYARD
		local var_10_10 = {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1,
			energyDisplay = true
		}

		i18n = var_2_10014
		var_10_10.leastLimitMsg = var_2_10014("battle_preCombatMediator_leastLimit")
		var_10_10.quitTeam = arg_10_1 ~= nil
		var_10_10.teamFilter = arg_10_3
		var_10_10.onShip = var_10_3
		var_10_10.confirmSelect = var_10_4
		var_10_10.onSelected = var_10_5
		setmetatable = var_14

		local var_10_11 = {
			inActivity = arg_2_0.contextData.actId
		}
		local var_10_12 = {}

		ShipStatus = var_2_10017
		var_10_12.__index = var_2_10017.TAG_HIDE_ACTIVITY_BOSS
		var_10_10.hideTagFlags = var_14(var_10_11, var_10_12)
		var_10_10.blockTagFlags = var_10_0
		var_10_10.otherSelectedIds = var_10_2

		var_10_7(var_10_6, var_10_8, var_10_9, var_10_10)

		return
	end)
	arg_2_0:bind(var_0_1.ON_UPDATE_CUSTOM_FLEET, function(arg_12_0)
		_ = var_2_10001

		var_2_10001.each(arg_2_0.contextData.fleets, function(arg_13_0)
			getProxy = var_3_10001
			FleetProxy = var_3_10002

			local var_13_0 = var_3_10001(var_3_10002)

			var_1.updateActivityFleet(var_13_0, arg_2_0.contextData.actId, arg_13_0.id, arg_13_0)

			return
		end)

		local var_12_0 = {}

		_ = var_2

		var_2.each(arg_2_0.contextData.fleets, function(arg_14_0)
			var_12_0[arg_14_0.id] = arg_14_0

			return
		end)

		local var_12_1 = arg_2_0
		local var_12_2 = var_2.sendNotification

		GAME = var_4

		var_12_2(var_12_1, var_4.EDIT_ACTIVITY_FLEET, {
			actID = arg_2_0.contextData.actId,
			fleets = var_12_0
		})

		return
	end)
	arg_2_0:bind(var_0_1.ON_START, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_2_0.viewComponent

		var_2.emit(var_15_0, var_0_1.ON_UPDATE_CUSTOM_FLEET)

		seriesAsync = var_2

		var_2({
			function(arg_16_0)
				for iter_16_0 = 1, #arg_2_0.contextData.fleets - 1 do
					local var_16_0 = arg_2_0.contextData.fleets[iter_16_0]

					if var_5.isLegalToFight(var_16_0) ~= true then
						pg = var_6

						local var_16_1 = var_6.TipsMgr.GetInstance()
						local var_16_2 = var_6.ShowTips

						i18n = var_3_10008

						var_16_2(var_16_1, var_3_10008("series_enemy_team_notenough"))

						return
					end
				end

				local var_16_3 = {}

				_ = var_2

				if var_2.any(arg_2_0.contextData.fleets, function(arg_17_0)
					_ = var_4_10001

					return var_4_10001.any(arg_17_0:GetRawShipIds(), function(arg_18_0)
						getProxy = var_5_10001
						BayProxy = var_5_10002

						local var_18_0 = var_5_10001(var_5_10002)
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

					i18n = var_4

					var_16_5(var_16_4, var_4("guild_event_exist_same_kind_ship"))

					return
				end

				arg_16_0()

				return
			end,
			function(arg_19_0)
				table = var_3_10001

				var_3_10001.SerialIpairsAsync(arg_2_0.contextData.fleets, function(arg_20_0, arg_20_1, arg_20_2)
					local var_20_0, var_20_1 = arg_20_1:HaveShipsInEvent()

					if var_20_0 then
						pg = var_4_10005
						var_4_10006 = var_4_10005.TipsMgr.GetInstance()

						var_5.ShowTips(var_4_10006, var_20_1)

						return
					end

					local var_20_2 = arg_2_0.contextData.actId

					_ = var_4_10006

					if var_4_10006.any(arg_20_1:getShipIds(), function(arg_21_0)
						getProxy = var_5_10001
						BayProxy = var_5_10002

						local var_21_0 = var_5_10001(var_5_10002)

						if not var_1.RawGetShipById(var_21_0, arg_21_0) then
							return
						end

						ShipStatus = var_21_0

						local var_21_1, var_21_2 = var_21_0.ShipStatusCheck("inActivity", var_1, nil, {
							inActivity = var_20_2
						})

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
				local var_22_0 = arg_2_0.contextData.mode

				BossRushSeriesData = var_3_10002

				if var_22_0 == var_3_10002.MODE.SINGLE then
					_ = var_22_0

					if var_22_0.any(arg_2_0.contextData.fleets, function(arg_23_0)
						_ = var_4_10001

						return var_4_10001.any(arg_23_0:GetRawShipIds(), function(arg_24_0)
							getProxy = var_5_10001
							BayProxy = var_5_10002

							local var_24_0 = var_5_10001(var_5_10002)
							local var_24_1 = var_1.RawGetShipById(var_24_0, arg_24_0)
							local var_24_2 = var_1.getEnergy(var_24_1)

							pg = var_24_1

							return var_24_2 <= var_24_1.gameset.series_enemy_mood_limit.key_value
						end)
					end) then
						pg = var_22_0

						local var_22_1 = var_22_0.TipsMgr.GetInstance()

						var_22_0 = var_22_0.ShowTips
						i18n = var_3

						var_22_0(var_22_1, var_3("series_enemy_mood_error"))

						return
					else
						arg_22_0()
					end
				else
					table = var_22_0

					var_22_0.SerialIpairsAsync(arg_2_0.contextData.fleets, function(arg_25_0, arg_25_1, arg_25_2)
						Fleet = var_4_10003

						local var_25_0 = var_4_10003.EnergyCheck

						_ = var_4_10004

						local var_25_1 = var_4_10004.map

						_ = var_4_10005

						local var_25_2 = var_25_1(var_4_10005.values(arg_25_1.ships), function(arg_26_0)
							getProxy = var_5_10001
							BayProxy = var_5_10002

							local var_26_0 = var_5_10001(var_5_10002)

							return var_1.getShipById(var_26_0, arg_26_0)
						end)

						Fleet = var_5

						var_25_0(var_25_2, var_5.DEFAULT_NAME[arg_25_0], function(arg_27_0)
							if arg_27_0 then
								arg_25_2()
							end

							return
						end)

						return
					end, arg_22_0)
				end

				return
			end,
			function(arg_28_0)
				getProxy = var_3_10001
				PlayerProxy = var_3_10002

				local var_28_0 = var_3_10001(var_3_10002)
				local var_28_1 = var_1.getRawData(var_28_0)

				if var_1.GoldMax(var_28_1, 1) then
					i18n = var_2

					local var_28_2 = var_2("gold_max_tip_title")

					i18n = var_3

					local var_28_3 = var_28_2 .. var_3("resource_max_tip_battle")

					getProxy = var_3
					ChapterProxy = var_4

					local var_28_4 = var_3(var_4)
					local var_28_5 = var_3.StopAutoFight

					ChapterConst = var_3_10005

					var_28_5(var_28_4, var_3_10005.AUTOFIGHT_STOP_REASON.GOLD_MAX)

					pg = var_28_5

					local var_28_6 = var_28_5.MsgboxMgr.GetInstance()

					var_3.ShowMsgBox(var_28_6, {
						content = var_28_3,
						onYes = arg_28_0
					})
				else
					arg_28_0()
				end

				return
			end,
			function(arg_29_0)
				BossRushChapterRemasterHelper = var_3_10001

				if var_3_10001.GetPermanentActivityTicketCost(arg_2_0.contextData.actId, arg_2_0.contextData.seriesData.id) <= 0 then
					arg_29_0()

					return
				end

				getProxy = var_2
				ChapterProxy = var_3

				local var_29_1

				if var_2(var_3).remasterTickets < var_1 then
					pg = var_29_1

					local var_29_0 = var_29_1.TipsMgr.GetInstance()

					var_29_1 = var_29_1.ShowTips
					i18n = var_3_10005

					var_29_1(var_29_0, var_3_10005("levelScene_remaster_tickets_not_enough"))

					return
				end

				pg = var_29_1

				local var_29_2 = var_29_1.MsgboxMgr.GetInstance()
				local var_29_3 = var_3.ShowMsgBox
				local var_29_4 = {}

				i18n = var_3_10006
				var_29_4.content = var_3_10006("levelScene_activate_remaster_1", var_1)
				var_29_4.onYes = arg_29_0

				var_29_3(var_29_2, var_29_4)

				return
			end,
			function(arg_30_0)
				BossRushChapterRemasterHelper = var_3_10001

				local var_30_0 = var_3_10001.GetPermanentActivityTicketCost(arg_2_0.contextData.actId, arg_2_0.contextData.seriesData.id)

				getProxy = var_2
				ActivityProxy = var_3

				local var_30_1 = var_2(var_3)

				var_2.InitContinuousTime(var_30_1, arg_15_1)

				local var_30_2 = arg_2_0
				local var_30_3 = var_2.sendNotification

				GAME = var_4

				var_30_3(var_30_2, var_4.BOSSRUSH_TRACE, {
					actId = arg_2_0.contextData.actId,
					seriesId = arg_2_0.contextData.seriesData.id,
					mode = arg_2_0.contextData.mode,
					remasterTicketCost = var_30_0
				})

				return
			end
		})

		return
	end)
	arg_2_0:bind(var_0_1.SHOW_CONTINUOUS_OPERATION_WINDOW, function(arg_31_0)
		local var_31_0 = arg_2_0.contextData.seriesData.mode

		underscore = var_2_10003

		local var_31_1 = var_2_10003.to_array(arg_2_0.contextData.fleets)

		table = var_4

		local var_31_2 = var_4.remove(var_31_1)

		local function var_31_3()
			local var_32_0 = 0
			local var_32_1
			local var_32_3

			if var_0.__cname == "CollabrateBossRushSeriesData" then
				SYSTEM_BOSS_RUSH_COLLABRATE = var_32_1
			else
				local var_32_2 = var_0

				var_32_3 = var_32_3.GetType(var_32_2)
				BossRushSeriesData = var_32_2

				if var_32_3 == var_32_2.TYPE.EXTRA then
					SYSTEM_BOSS_RUSH_EX = var_32_1
				else
					SYSTEM_BOSS_RUSH = var_32_1
				end
			end

			pg = var_32_3

			local var_32_4 = var_32_3.battle_cost_template[var_32_1]
			local var_32_5 = var_0
			local var_32_6 = var_3.GetOilLimit(var_32_5)
			local var_32_7 = var_32_4.oil_cost > 0

			local function var_32_8(arg_33_0, arg_33_1)
				local var_33_0 = 0

				if var_32_7 then
					var_33_0 = arg_33_0:GetCostSum().oil

					if 0 < arg_33_1 then
						math = var_3
						var_33_0 = var_3.min(arg_33_1, var_33_0)
					end
				end

				return var_33_0
			end

			local var_32_9 = var_0
			local var_32_10 = #var_6.GetExpeditionIds(var_32_9)
			local var_32_11 = var_32_8(var_31_2, var_32_6[2]) * var_32_10

			for iter_32_0 = 1, var_32_10 do
				local var_32_12 = var_32_8
				local var_32_13

				if not var_31_1[iter_32_0] then
					var_32_13 = var_31_1[1]
				end

				var_32_11 = var_32_11 + var_32_12(var_32_13, var_32_6[1])
			end

			return var_32_11
		end

		local var_31_4 = arg_2_0
		local var_31_5 = var_6.addSubLayers

		Context = var_2_10008

		local var_31_6 = var_2_10008.New
		local var_31_7 = {}

		BossRushContinuousOperationWindowMediator = var_2_10010
		var_31_7.mediator = var_2_10010
		BossRushContinuousOperationWindow = var_2_10010
		var_31_7.viewComponent = var_2_10010

		local var_31_8 = {
			system = arg_2_0.contextData.system
		}

		pg = var_11
		var_31_8.maxCount = var_11.gameset.series_enemy_multiple_limit.key_value
		var_31_8.oilCost = var_31_3()
		var_31_7.data = var_31_8

		var_31_5(var_31_4, var_31_6(var_31_7))

		return
	end)
	arg_2_0:bind(var_0_1.BEGIN_STAGE, function(arg_34_0)
		getProxy = var_2_10001
		ActivityProxy = var_2_10002

		local var_34_0 = var_2_10001(var_2_10002)
		local var_34_1 = var_1.GetContinuousTime(var_34_0)
		local var_34_2 = arg_2_0
		local var_34_3 = var_2.sendNotification

		GAME = var_2_10004

		var_34_3(var_34_2, var_2_10004.BEGIN_STAGE, {
			system = arg_2_0.contextData.system,
			actId = arg_2_0.contextData.actId,
			continuousBattleTimes = var_34_1,
			totalBattleTimes = var_34_1
		})

		return
	end)

	return
end

function var_0_1.onAutoBtn(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_1.isOn
	local var_35_1 = arg_35_1.toggle
	local var_35_2 = arg_35_0
	local var_35_3 = arg_35_0.sendNotification

	GAME = var_1_10006

	var_35_3(var_35_2, var_1_10006.AUTO_BOT, {
		isActiveBot = var_35_0,
		toggle = var_35_1,
		system = arg_35_0.contextData.system
	})

	return
end

function var_0_1.onAutoSubBtn(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1.isOn
	local var_36_1 = arg_36_1.toggle
	local var_36_2 = arg_36_0
	local var_36_3 = arg_36_0.sendNotification

	GAME = var_1_10006

	var_36_3(var_36_2, var_1_10006.AUTO_SUB, {
		isActiveSub = var_36_0,
		toggle = var_36_1,
		system = arg_36_0.contextData.system
	})

	return
end

function var_0_1.changeFleet(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.viewComponent

	var_2.SetCurrentFleet(var_37_0, arg_37_1)

	local var_37_1 = arg_37_0.viewComponent

	var_2.UpdateFleetView(var_37_1, true)

	local var_37_2 = arg_37_0.viewComponent

	var_2.SetFleetStepper(var_37_2)

	return
end

function var_0_1.refreshEdit(arg_38_0, arg_38_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10003

	local var_38_0 = var_1_10002(var_1_10003)
	local var_38_1 = arg_38_0.contextData.actId

	var_38_0:updateActivityFleet(var_38_1, arg_38_1.id, arg_38_1)

	local var_38_2 = arg_38_0.viewComponent

	var_4.UpdateFleetView(var_38_2, false)
	arg_38_0:sendNotification(var_0_1.ON_FLEET_REFRESHED)

	return
end

function var_0_1.commitEdit(arg_39_0)
	_ = var_1_10001

	var_1_10001.each(arg_39_0.contextData.fleets, function(arg_40_0)
		getProxy = var_2_10001
		FleetProxy = var_2_10002

		local var_40_0 = var_2_10001(var_2_10002)

		var_1.updateActivityFleet(var_40_0, arg_39_0.contextData.actId, arg_40_0.id, arg_40_0)

		return
	end)

	local var_39_0 = {}

	_ = var_2

	var_2.each(arg_39_0.contextData.fleets, function(arg_41_0)
		var_39_0[arg_41_0.id] = arg_41_0

		return
	end)

	local var_39_1 = arg_39_0
	local var_39_2 = arg_39_0.sendNotification

	GAME = var_4

	var_39_2(var_39_1, var_4.EDIT_ACTIVITY_FLEET, {
		actID = arg_39_0.contextData.actId,
		fleets = var_39_0
	})

	return
end

function var_0_1.listNotificationInterests(arg_42_0)
	local var_42_0 = {}

	GAME = var_1_10002
	var_42_0[1] = var_1_10002.BOSSRUSH_TRACE_DONE
	GAME = var_2
	var_42_0[2] = var_2.BOSSRUSH_TRACE_ERROR
	GAME = var_2
	var_42_0[3] = var_2.BEGIN_STAGE_DONE
	GAME = var_2
	var_42_0[4] = var_2.BEGIN_STAGE_ERRO
	var_42_0[5] = var_0_1.CONTINUOUS_OPERATION

	return var_42_0
end

function var_0_1.handleNotification(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_1:getName()
	local var_43_1 = arg_43_1
	local var_43_2 = arg_43_1.getBody(var_43_1)

	GAME = var_43_1

	local var_43_4

	if var_43_0 == var_43_1.BEGIN_STAGE_DONE then
		local var_43_3 = arg_43_0

		var_43_4 = arg_43_0.sendNotification
		GAME = var_1_10006
		var_1_10006 = var_1_10006.GO_SCENE
		SCENE = var_1_10007

		var_43_4(var_43_3, var_1_10006, var_1_10007.COMBATLOAD, var_43_2)
	else
		GAME = var_43_4

		if var_43_0 == var_43_4.BEGIN_STAGE_ERRO then
			if var_43_2 == 3 then
				pg = var_4

				local var_43_5 = var_4.MsgboxMgr.GetInstance()
				local var_43_6 = var_4.ShowMsgBox

				var_1_10006 = {
					hideNo = true
				}
				i18n = var_1_10007
				var_1_10006.content = var_1_10007("battle_preCombatMediator_timeout")

				function var_1_10006.onYes()
					local var_44_0 = arg_43_0.viewComponent
					local var_44_1 = var_0.emit

					BaseUI = var_2_10002

					var_44_1(var_44_0, var_2_10002.ON_CLOSE)

					return
				end

				var_43_6(var_43_5, var_1_10006)
			end
		else
			local var_43_8

			if var_43_0 == var_0_1.CONTINUOUS_OPERATION then
				local var_43_7 = arg_43_0.viewComponent

				var_43_8 = var_43_8.emit
				BossRushPreCombatMediator = var_1_10006

				var_43_8(var_43_7, var_1_10006.ON_START, var_43_2.battleTimes)
			else
				GAME = var_43_8

				if var_43_0 == var_43_8.BOSSRUSH_TRACE_DONE then
					local var_43_9 = arg_43_0.viewComponent

					var_4.emit(var_43_9, var_0_1.BEGIN_STAGE)
				else
					GAME = var_4

					if var_43_0 == var_4.BOSSRUSH_TRACE_ERROR then
						return
					end
				end
			end
		end
	end

	return
end

return var_0_1
