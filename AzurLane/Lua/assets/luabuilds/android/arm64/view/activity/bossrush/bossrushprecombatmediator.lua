local var_0_0 = class("BossRushPreCombatMediator", import("view.base.ContextMediator"))

var_0_0.ON_UPDATE_CUSTOM_FLEET = "BossRushPreCombatMediator:ON_UPDATE_CUSTOM_FLEET"
var_0_0.ON_START = "BossRushPreCombatMediator:ON_START"
var_0_0.BEGIN_STAGE = "BossRushPreCombatMediator:BEGIN_STAGE"
var_0_0.SHOW_CONTINUOUS_OPERATION_WINDOW = "BossRushPreCombatMediator:SHOW_CONTINUOUS_OPERATION_WINDOW"
var_0_0.CONTINUOUS_OPERATION = "BossRushPreCombatMediator:CONTINUOUS_OPERATION"
var_0_0.OPEN_SHIP_INFO = "BossRushPreCombatMediator:OPEN_SHIP_INFO"
var_0_0.CHANGE_FLEET_SHIP = "BossRushPreCombatMediator:CHANGE_FLEET_SHIP"
var_0_0.CHANGE_FLEET_SHIPS_ORDER = "BossRushPreCombatMediator:CHANGE_FLEET_SHIPS_ORDER"
var_0_0.REMOVE_SHIP = "BossRushPreCombatMediator:REMOVE_SHIP"
var_0_0.ON_AUTO = "BossRushPreCombatMediator:ON_AUTO"
var_0_0.ON_SUB_AUTO = "BossRushPreCombatMediator:ON_SUB_AUTO"
var_0_0.ON_FLEET_REFRESHED = "BossRushPreCombatMediator:ON_FLEET_REFRESHED"
var_0_0.ON_CHANGE_FLEET = "BossRushPreCombatMediator:ON_CHANGE_FLEET"

function var_0_0.register(arg_1_0)
	arg_1_0:bindEvent()

	arg_1_0.ships = getProxy(BayProxy):getRawData()

	arg_1_0.viewComponent:SetShips(arg_1_0.ships)

	arg_1_0.fleets = arg_1_0.contextData.fleets

	arg_1_0.viewComponent:SetFleets(arg_1_0.contextData.fleets)
	arg_1_0.viewComponent:SetCurrentFleet(arg_1_0.contextData.fleets[arg_1_0.contextData.fleetIndex].id)
	arg_1_0.viewComponent:SetSubFlag(arg_1_0.contextData.fleets[#arg_1_0.contextData.fleets]:isLegalToFight() == true)

	return
end

function var_0_0.bindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.ON_CHANGE_FLEET, function(arg_3_0, arg_3_1)
		arg_2_0:changeFleet(arg_3_1)

		return
	end)
	arg_2_0:bind(var_0_0.ON_AUTO, function(arg_4_0, arg_4_1)
		arg_2_0:onAutoBtn(arg_4_1)

		return
	end)
	arg_2_0:bind(var_0_0.ON_SUB_AUTO, function(arg_5_0, arg_5_1)
		arg_2_0:onAutoSubBtn(arg_5_1)

		return
	end)
	arg_2_0:bind(var_0_0.CHANGE_FLEET_SHIPS_ORDER, function(arg_6_0, arg_6_1)
		arg_2_0:refreshEdit(arg_6_1)

		return
	end)
	arg_2_0:bind(var_0_0.REMOVE_SHIP, function(arg_7_0, arg_7_1, arg_7_2)
		(function(arg_8_0, arg_8_1)
			if not arg_8_0:canRemove(arg_8_1) then
				local var_8_0, var_8_1 = arg_8_0:getShipPos(arg_8_1)

				pg.TipsMgr.GetInstance():ShowTips(i18n("ship_formationUI_removeError_onlyShip", arg_8_1:getConfigTable().name, arg_8_0.name, Fleet.C_TEAM_NAME[var_8_1]))

				return false
			end

			arg_8_0:removeShip(arg_8_1)

			return true
		end)(arg_7_2, arg_7_1)
		arg_2_0:refreshEdit(arg_7_2)

		return
	end)
	arg_2_0:bind(var_0_0.OPEN_SHIP_INFO, function(arg_9_0, arg_9_1, arg_9_2)
		for iter_9_0, iter_9_1 in ipairs(arg_9_2:getShipIds()) do
			table.insert({}, arg_2_0.ships[iter_9_1])
		end

		arg_2_0:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_9_1,
			shipVOs = {}
		})

		return
	end)
	arg_2_0:bind(var_0_0.CHANGE_FLEET_SHIP, function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		local var_10_0 = _.flatten(_.map(arg_2_0.contextData.fleets, function(arg_11_0)
			return arg_11_0:GetRawShipIds()
		end))
		local var_10_1, var_10_2, var_10_3 = BossRushFleetSelectMediator.getDockCallbackFuncs(arg_10_1, arg_10_2, arg_10_3, var_10_0, arg_2_0.contextData.actId)

		arg_2_0:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			selectedMin = 0,
			useBlackBlock = true,
			selectedMax = 1,
			energyDisplay = true,
			leastLimitMsg = i18n("battle_preCombatMediator_leastLimit"),
			quitTeam = arg_10_1 ~= nil,
			teamFilter = arg_10_3,
			onShip = var_10_1,
			confirmSelect = var_10_2,
			onSelected = var_10_3,
			hideTagFlags = setmetatable({
				inActivity = arg_2_0.contextData.actId
			}, {
				__index = ShipStatus.TAG_HIDE_ACTIVITY_BOSS
			}),
			blockTagFlags = nil,
			otherSelectedIds = var_10_0
		})

		return
	end)
	arg_2_0:bind(var_0_0.ON_UPDATE_CUSTOM_FLEET, function(arg_12_0)
		_.each(arg_2_0.contextData.fleets, function(arg_13_0)
			getProxy(FleetProxy):updateActivityFleet(arg_2_0.contextData.actId, arg_13_0.id, arg_13_0)

			return
		end)

		local var_12_0 = {}

		_.each(arg_2_0.contextData.fleets, function(arg_14_0)
			var_12_0[arg_14_0.id] = arg_14_0

			return
		end)
		arg_2_0:sendNotification(GAME.EDIT_ACTIVITY_FLEET, {
			actID = arg_2_0.contextData.actId,
			fleets = {}
		})

		return
	end)
	arg_2_0:bind(var_0_0.ON_START, function(arg_15_0, arg_15_1)
		arg_2_0.viewComponent:emit(var_0_0.ON_UPDATE_CUSTOM_FLEET)
		seriesAsync({
			function(arg_16_0)
				for iter_16_0 = 1, #arg_2_0.contextData.fleets - 1 do
					if arg_2_0.contextData.fleets[iter_16_0]:isLegalToFight() ~= true then
						pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_team_notenough"))

						return
					end
				end

				local var_16_0 = {}

				if _.any(arg_2_0.contextData.fleets, function(arg_17_0)
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
				table.SerialIpairsAsync(arg_2_0.contextData.fleets, function(arg_20_0, arg_20_1, arg_20_2)
					local var_20_0, var_20_1 = arg_20_1:HaveShipsInEvent()

					if var_20_0 then
						pg.TipsMgr.GetInstance():ShowTips(var_20_1)

						return
					end

					local var_20_2 = arg_2_0.contextData.actId

					if _.any(arg_20_1:getShipIds(), function(arg_21_0)
						local var_21_0 = getProxy(BayProxy):RawGetShipById(arg_21_0)

						if not var_21_0 then
							return
						end

						local var_21_1, var_21_2 = ShipStatus.ShipStatusCheck("inActivity", var_21_0, nil, {
							inActivity = var_20_2
						})

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
				if arg_2_0.contextData.mode == BossRushSeriesData.MODE.SINGLE then
					if _.any(arg_2_0.contextData.fleets, function(arg_23_0)
						return _.any(arg_23_0:GetRawShipIds(), function(arg_24_0)
							local var_24_0 = getProxy(BayProxy):RawGetShipById(arg_24_0)

							return var_24_0:getEnergy() <= pg.gameset.series_enemy_mood_limit.key_value
						end)
					end) then
						pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_mood_error"))

						return
					else
						arg_22_0()
					end
				else
					table.SerialIpairsAsync(arg_2_0.contextData.fleets, function(arg_25_0, arg_25_1, arg_25_2)
						Fleet.EnergyCheck(_.map(_.values(arg_25_1.ships), function(arg_26_0)
							return getProxy(BayProxy):getShipById(arg_26_0)
						end), Fleet.DEFAULT_NAME[arg_25_0], function(arg_27_0)
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
				if getProxy(PlayerProxy):getRawData():GoldMax(1) then
					getProxy(ChapterProxy):StopAutoFight(ChapterConst.AUTOFIGHT_STOP_REASON.GOLD_MAX)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("gold_max_tip_title") .. i18n("resource_max_tip_battle"),
						onYes = arg_28_0
					})
				else
					arg_28_0()
				end

				return
			end,
			function(arg_29_0)
				local var_29_0 = BossRushChapterRemasterHelper.GetPermanentActivityTicketCost(arg_2_0.contextData.actId, arg_2_0.contextData.seriesData.id)

				if var_29_0 <= 0 then
					arg_29_0()

					return
				end

				if var_29_0 > getProxy(ChapterProxy).remasterTickets then
					pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_remaster_tickets_not_enough"))

					return
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("levelScene_activate_remaster_1", var_29_0),
					onYes = arg_29_0
				})

				return
			end,
			function(arg_30_0)
				getProxy(ActivityProxy):InitContinuousTime(arg_15_1)
				arg_2_0:sendNotification(GAME.BOSSRUSH_TRACE, {
					actId = arg_2_0.contextData.actId,
					seriesId = arg_2_0.contextData.seriesData.id,
					mode = arg_2_0.contextData.mode,
					remasterTicketCost = BossRushChapterRemasterHelper.GetPermanentActivityTicketCost(arg_2_0.contextData.actId, arg_2_0.contextData.seriesData.id)
				})

				return
			end
		})

		return
	end)
	arg_2_0:bind(var_0_0.SHOW_CONTINUOUS_OPERATION_WINDOW, function(arg_31_0)
		local var_31_1 = table.remove((underscore.to_array(arg_2_0.contextData.fleets)))

		arg_2_0:addSubLayers(Context.New({
			mediator = BossRushContinuousOperationWindowMediator,
			viewComponent = BossRushContinuousOperationWindow,
			data = {
				system = arg_2_0.contextData.system,
				maxCount = pg.gameset.series_enemy_multiple_limit.key_value,
				oilCost = (function()
					local var_32_1
					local var_32_2

					if var_0.__cname == "CollabrateBossRushSeriesData" then
						var_32_1 = SYSTEM_BOSS_RUSH_COLLABRATE
					elseif var_0:GetType() == BossRushSeriesData.TYPE.EXTRA then
						var_32_1 = SYSTEM_BOSS_RUSH_EX
					else
						var_32_1 = SYSTEM_BOSS_RUSH
						var_32_2 = var_0:GetOilLimit()
					end

					local var_32_3 = pg.battle_cost_template[var_32_1].oil_cost > 0
					local var_32_5 = #var_0:GetExpeditionIds()
					local var_32_6 = (function(arg_33_0, arg_33_1)
						local var_33_0 = 0

						if var_32_3 then
							var_33_0 = arg_33_0:GetCostSum().oil

							if arg_33_1 > 0 then
								var_33_0 = math.min(arg_33_1, var_33_0)
							end
						end

						return var_33_0
					end)(var_31_1, var_32_2[2]) * var_32_5

					for iter_32_0 = 1, var_32_5 do
						local var_32_8 = var_0[iter_32_0] or var_0[1]

						var_32_6 = var_32_6 + var_32_4(var_32_8, var_32_2[1])
					end

					return var_32_6
				end)()
			}
		}))

		return
	end)
	arg_2_0:bind(var_0_0.BEGIN_STAGE, function(arg_34_0)
		local var_34_0 = getProxy(ActivityProxy):GetContinuousTime()

		arg_2_0:sendNotification(GAME.BEGIN_STAGE, {
			system = arg_2_0.contextData.system,
			actId = arg_2_0.contextData.actId,
			continuousBattleTimes = var_34_0,
			totalBattleTimes = var_34_0
		})

		return
	end)

	return
end

function var_0_0.onAutoBtn(arg_35_0, arg_35_1)
	arg_35_0:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_35_1.isOn,
		toggle = arg_35_1.toggle,
		system = arg_35_0.contextData.system
	})

	return
end

function var_0_0.onAutoSubBtn(arg_36_0, arg_36_1)
	arg_36_0:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = arg_36_1.isOn,
		toggle = arg_36_1.toggle,
		system = arg_36_0.contextData.system
	})

	return
end

function var_0_0.changeFleet(arg_37_0, arg_37_1)
	arg_37_0.viewComponent:SetCurrentFleet(arg_37_1)
	arg_37_0.viewComponent:UpdateFleetView(true)
	arg_37_0.viewComponent:SetFleetStepper()

	return
end

function var_0_0.refreshEdit(arg_38_0, arg_38_1)
	getProxy(FleetProxy):updateActivityFleet(arg_38_0.contextData.actId, arg_38_1.id, arg_38_1)
	arg_38_0.viewComponent:UpdateFleetView(false)
	arg_38_0:sendNotification(var_0_0.ON_FLEET_REFRESHED)

	return
end

function var_0_0.commitEdit(arg_39_0)
	_.each(arg_39_0.contextData.fleets, function(arg_40_0)
		getProxy(FleetProxy):updateActivityFleet(arg_39_0.contextData.actId, arg_40_0.id, arg_40_0)

		return
	end)

	local var_39_0 = {}

	_.each(arg_39_0.contextData.fleets, function(arg_41_0)
		var_39_0[arg_41_0.id] = arg_41_0

		return
	end)
	arg_39_0:sendNotification(GAME.EDIT_ACTIVITY_FLEET, {
		actID = arg_39_0.contextData.actId,
		fleets = {}
	})

	return
end

function var_0_0.listNotificationInterests(arg_42_0)
	return {
		GAME.BOSSRUSH_TRACE_DONE,
		GAME.BOSSRUSH_TRACE_ERROR,
		GAME.BEGIN_STAGE_DONE,
		GAME.BEGIN_STAGE_ERRO,
		var_0_0.CONTINUOUS_OPERATION
	}
end

function var_0_0.handleNotification(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_1:getName()
	local var_43_1 = arg_43_1:getBody()

	if var_43_0 == GAME.BEGIN_STAGE_DONE then
		arg_43_0:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_43_1)
	elseif var_43_0 == GAME.BEGIN_STAGE_ERRO then
		if var_43_1 == 3 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("battle_preCombatMediator_timeout"),
				onYes = function()
					arg_43_0.viewComponent:emit(BaseUI.ON_CLOSE)

					return
				end
			})
		end
	elseif var_43_0 == var_0_0.CONTINUOUS_OPERATION then
		arg_43_0.viewComponent:emit(BossRushPreCombatMediator.ON_START, var_43_1.battleTimes)
	elseif var_43_0 == GAME.BOSSRUSH_TRACE_DONE then
		arg_43_0.viewComponent:emit(var_0_0.BEGIN_STAGE)
	elseif var_43_0 == GAME.BOSSRUSH_TRACE_ERROR then
		return
	end

	return
end

return var_0_0
