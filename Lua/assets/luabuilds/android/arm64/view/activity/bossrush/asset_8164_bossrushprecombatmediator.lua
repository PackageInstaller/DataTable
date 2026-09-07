local BossRushPreCombatMediator = class("BossRushPreCombatMediator", import("view.base.ContextMediator"))

BossRushPreCombatMediator.ON_UPDATE_CUSTOM_FLEET = "BossRushPreCombatMediator:ON_UPDATE_CUSTOM_FLEET"
BossRushPreCombatMediator.ON_START = "BossRushPreCombatMediator:ON_START"
BossRushPreCombatMediator.BEGIN_STAGE = "BossRushPreCombatMediator:BEGIN_STAGE"
BossRushPreCombatMediator.SHOW_CONTINUOUS_OPERATION_WINDOW = "BossRushPreCombatMediator:SHOW_CONTINUOUS_OPERATION_WINDOW"
BossRushPreCombatMediator.CONTINUOUS_OPERATION = "BossRushPreCombatMediator:CONTINUOUS_OPERATION"
BossRushPreCombatMediator.OPEN_SHIP_INFO = "BossRushPreCombatMediator:OPEN_SHIP_INFO"
BossRushPreCombatMediator.CHANGE_FLEET_SHIP = "BossRushPreCombatMediator:CHANGE_FLEET_SHIP"
BossRushPreCombatMediator.CHANGE_FLEET_SHIPS_ORDER = "BossRushPreCombatMediator:CHANGE_FLEET_SHIPS_ORDER"
BossRushPreCombatMediator.REMOVE_SHIP = "BossRushPreCombatMediator:REMOVE_SHIP"
BossRushPreCombatMediator.ON_AUTO = "BossRushPreCombatMediator:ON_AUTO"
BossRushPreCombatMediator.ON_SUB_AUTO = "BossRushPreCombatMediator:ON_SUB_AUTO"
BossRushPreCombatMediator.ON_FLEET_REFRESHED = "BossRushPreCombatMediator:ON_FLEET_REFRESHED"
BossRushPreCombatMediator.ON_CHANGE_FLEET = "BossRushPreCombatMediator:ON_CHANGE_FLEET"

function BossRushPreCombatMediator:register()
	self:bindEvent()

	self.ships = getProxy(BayProxy):getRawData()

	self.viewComponent:SetShips(self.ships)

	self.fleets = self.contextData.fleets

	self.viewComponent:SetFleets(self.contextData.fleets)
	self.viewComponent:SetCurrentFleet(self.contextData.fleets[self.contextData.fleetIndex].id)
	self.viewComponent:SetSubFlag(self.contextData.fleets[#self.contextData.fleets]:isLegalToFight() == true)

	return
end

function BossRushPreCombatMediator:bindEvent()
	self:bind(BossRushPreCombatMediator.ON_CHANGE_FLEET, function(arg_3_0, arg_3_1)
		self:changeFleet(arg_3_1)

		return
	end)
	self:bind(BossRushPreCombatMediator.ON_AUTO, function(arg_4_0, arg_4_1)
		self:onAutoBtn(arg_4_1)

		return
	end)
	self:bind(BossRushPreCombatMediator.ON_SUB_AUTO, function(arg_5_0, arg_5_1)
		self:onAutoSubBtn(arg_5_1)

		return
	end)
	self:bind(BossRushPreCombatMediator.CHANGE_FLEET_SHIPS_ORDER, function(arg_6_0, arg_6_1)
		self:refreshEdit(arg_6_1)

		return
	end)
	self:bind(BossRushPreCombatMediator.REMOVE_SHIP, function(arg_7_0, arg_7_1, arg_7_2)
		(function(arg_8_0, arg_8_1)
			if not arg_8_0:canRemove(arg_8_1) then
				local var_8_0, var_8_1 = arg_8_0:getShipPos(arg_8_1)

				pg.TipsMgr.GetInstance():ShowTips(i18n("ship_formationUI_removeError_onlyShip", arg_8_1:getConfigTable().name, arg_8_0.name, Fleet.C_TEAM_NAME[var_8_1]))

				return false
			end

			arg_8_0:removeShip(arg_8_1)

			return true
		end)(arg_7_2, arg_7_1)
		self:refreshEdit(arg_7_2)

		return
	end)
	self:bind(BossRushPreCombatMediator.OPEN_SHIP_INFO, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in ipairs(arg_9_2:getShipIds()) do
			table.insert(var_9_0, self.ships[iter_9_1])
		end

		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_9_1,
			shipVOs = var_9_0
		})

		return
	end)
	self:bind(BossRushPreCombatMediator.CHANGE_FLEET_SHIP, function(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
		local var_10_0 = _.flatten(_.map(self.contextData.fleets, function(arg_11_0)
			return arg_11_0:GetRawShipIds()
		end))
		local var_10_1, var_10_2, var_10_3 = BossRushFleetSelectMediator.getDockCallbackFuncs(arg_10_1, arg_10_2, arg_10_3, var_10_0, self.contextData.actId)

		self:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
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
				inActivity = self.contextData.actId
			}, {
				__index = ShipStatus.TAG_HIDE_ACTIVITY_BOSS
			}),
			blockTagFlags = nil,
			otherSelectedIds = var_10_0
		})

		return
	end)
	self:bind(BossRushPreCombatMediator.ON_UPDATE_CUSTOM_FLEET, function(arg_12_0)
		_.each(self.contextData.fleets, function(arg_13_0)
			getProxy(FleetProxy):updateActivityFleet(self.contextData.actId, arg_13_0.id, arg_13_0)

			return
		end)

		local var_12_0 = {}

		_.each(self.contextData.fleets, function(arg_14_0)
			var_12_0[arg_14_0.id] = arg_14_0

			return
		end)
		self:sendNotification(GAME.EDIT_ACTIVITY_FLEET, {
			actID = self.contextData.actId,
			fleets = var_12_0
		})

		return
	end)
	self:bind(BossRushPreCombatMediator.ON_START, function(arg_15_0, arg_15_1)
		self.viewComponent:emit(BossRushPreCombatMediator.ON_UPDATE_CUSTOM_FLEET)
		seriesAsync({
			function(arg_16_0)
				for iter_16_0 = 1, #self.contextData.fleets - 1 do
					if self.contextData.fleets[iter_16_0]:isLegalToFight() ~= true then
						pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_team_notenough"))

						return
					end
				end

				local var_16_0 = {}

				if _.any(self.contextData.fleets, function(arg_17_0)
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
				table.SerialIpairsAsync(self.contextData.fleets, function(arg_20_0, arg_20_1, arg_20_2)
					local var_20_0, var_20_1 = arg_20_1:HaveShipsInEvent()

					if var_20_0 then
						pg.TipsMgr.GetInstance():ShowTips(var_20_1)

						return
					end

					local var_20_2 = self.contextData.actId

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
				if self.contextData.mode == BossRushSeriesData.MODE.SINGLE then
					if _.any(self.contextData.fleets, function(arg_23_0)
						return _.any(arg_23_0:GetRawShipIds(), function(arg_24_0)
							return getProxy(BayProxy):RawGetShipById(arg_24_0):getEnergy() <= pg.gameset.series_enemy_mood_limit.key_value
						end)
					end) then
						pg.TipsMgr.GetInstance():ShowTips(i18n("series_enemy_mood_error"))

						return
					else
						arg_22_0()
					end
				else
					table.SerialIpairsAsync(self.contextData.fleets, function(arg_25_0, arg_25_1, arg_25_2)
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
				local var_29_0 = BossRushChapterRemasterHelper.GetPermanentActivityTicketCost(self.contextData.actId, self.contextData.seriesData.id)

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
				self:sendNotification(GAME.BOSSRUSH_TRACE, {
					actId = self.contextData.actId,
					seriesId = self.contextData.seriesData.id,
					mode = self.contextData.mode,
					remasterTicketCost = BossRushChapterRemasterHelper.GetPermanentActivityTicketCost(self.contextData.actId, self.contextData.seriesData.id)
				})

				return
			end
		})

		return
	end)
	self:bind(BossRushPreCombatMediator.SHOW_CONTINUOUS_OPERATION_WINDOW, function(arg_31_0)
		local var_31_0 = self.contextData.seriesData
		local var_31_2 = underscore.to_array(self.contextData.fleets)
		local var_31_3 = table.remove(var_31_2)

		self:addSubLayers(Context.New({
			mediator = BossRushContinuousOperationWindowMediator,
			viewComponent = BossRushContinuousOperationWindow,
			data = {
				system = self.contextData.system,
				maxCount = pg.gameset.series_enemy_multiple_limit.key_value,
				oilCost = (function()
					local var_32_1

					if var_31_0.__cname == "CollabrateBossRushSeriesData" then
						var_32_1 = SYSTEM_BOSS_RUSH_COLLABRATE
					else
						if var_31_0:GetType() == BossRushSeriesData.TYPE.EXTRA then
							var_32_1 = SYSTEM_BOSS_RUSH_EX
						end

						local var_32_2

						do
							var_32_1 = SYSTEM_BOSS_RUSH
							var_32_2 = var_31_0:GetOilLimit()
						end
					end

					local var_32_3 = pg.battle_cost_template[var_32_1].oil_cost > 0

					local function var_32_4(arg_33_0, arg_33_1)
						local var_33_0 = 0

						if var_32_3 then
							var_33_0 = arg_33_0:GetCostSum().oil

							if arg_33_1 > 0 then
								var_33_0 = math.min(arg_33_1, var_33_0)
							end
						end

						return var_33_0
					end

					local var_32_5 = #var_31_0:GetExpeditionIds()
					local var_32_6 = var_32_4(var_31_3, var_32_2[2]) * var_32_5

					for iter_32_0 = 1, var_32_5 do
						var_32_6 = var_32_6 + var_32_4(var_31_2[iter_32_0] or var_31_2[1], var_32_2[1])
					end

					return var_32_6
				end)()
			}
		}))

		return
	end)
	self:bind(BossRushPreCombatMediator.BEGIN_STAGE, function(arg_34_0)
		local var_34_0 = getProxy(ActivityProxy):GetContinuousTime()

		self:sendNotification(GAME.BEGIN_STAGE, {
			system = self.contextData.system,
			actId = self.contextData.actId,
			continuousBattleTimes = var_34_0,
			totalBattleTimes = var_34_0
		})

		return
	end)

	return
end

function BossRushPreCombatMediator:onAutoBtn(arg_35_1)
	self:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_35_1.isOn,
		toggle = arg_35_1.toggle,
		system = self.contextData.system
	})

	return
end

function BossRushPreCombatMediator:onAutoSubBtn(arg_36_1)
	self:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = arg_36_1.isOn,
		toggle = arg_36_1.toggle,
		system = self.contextData.system
	})

	return
end

function BossRushPreCombatMediator:changeFleet(arg_37_1)
	self.viewComponent:SetCurrentFleet(arg_37_1)
	self.viewComponent:UpdateFleetView(true)
	self.viewComponent:SetFleetStepper()

	return
end

function BossRushPreCombatMediator:refreshEdit(arg_38_1)
	getProxy(FleetProxy):updateActivityFleet(self.contextData.actId, arg_38_1.id, arg_38_1)
	self.viewComponent:UpdateFleetView(false)
	self:sendNotification(BossRushPreCombatMediator.ON_FLEET_REFRESHED)

	return
end

function BossRushPreCombatMediator:commitEdit()
	_.each(self.contextData.fleets, function(arg_40_0)
		getProxy(FleetProxy):updateActivityFleet(self.contextData.actId, arg_40_0.id, arg_40_0)

		return
	end)

	local var_39_0 = {}

	_.each(self.contextData.fleets, function(arg_41_0)
		var_39_0[arg_41_0.id] = arg_41_0

		return
	end)
	self:sendNotification(GAME.EDIT_ACTIVITY_FLEET, {
		actID = self.contextData.actId,
		fleets = var_39_0
	})

	return
end

function BossRushPreCombatMediator:listNotificationInterests()
	return {
		GAME.BOSSRUSH_TRACE_DONE,
		GAME.BOSSRUSH_TRACE_ERROR,
		GAME.BEGIN_STAGE_DONE,
		GAME.BEGIN_STAGE_ERRO,
		BossRushPreCombatMediator.CONTINUOUS_OPERATION
	}
end

function BossRushPreCombatMediator:handleNotification(arg_43_1)
	local var_43_0 = arg_43_1:getName()
	local var_43_1 = arg_43_1:getBody()

	if var_43_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_43_1)
	elseif var_43_0 == GAME.BEGIN_STAGE_ERRO then
		if var_43_1 == 3 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideNo = true,
				content = i18n("battle_preCombatMediator_timeout"),
				onYes = function()
					self.viewComponent:emit(BaseUI.ON_CLOSE)

					return
				end
			})
		end
	elseif var_43_0 == BossRushPreCombatMediator.CONTINUOUS_OPERATION then
		self.viewComponent:emit(BossRushPreCombatMediator.ON_START, var_43_1.battleTimes)
	elseif var_43_0 == GAME.BOSSRUSH_TRACE_DONE then
		self.viewComponent:emit(BossRushPreCombatMediator.BEGIN_STAGE)
	elseif var_43_0 == GAME.BOSSRUSH_TRACE_ERROR then
		return
	end

	return
end

return BossRushPreCombatMediator
