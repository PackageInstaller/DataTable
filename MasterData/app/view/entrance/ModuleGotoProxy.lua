local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.ThemeConst
local ModuleEntrance = import(".ModuleEntrance")
local var_0_3 = g.core.common.ModuleUnlock
local var_0_4 = g.core.common.Goods
local ModuleGotoProxy = class("ModuleGotoProxy")

function ModuleGotoProxy:ctor()
	self._moduleRouteIndex = {}

	for iter_1_0, iter_1_1 in pairs(ModuleEntrance) do
		if iter_1_1 ~= ModuleEntrance.FULL_SCREEN and iter_1_1 ~= ModuleEntrance.POPUP and iter_1_1.routeType then
			if type(iter_1_1.routeType) == "table" then
				for iter_1_2, iter_1_3 in ipairs(iter_1_1.routeType) do
					self._moduleRouteIndex[tostring(iter_1_3)] = iter_1_1
				end
			else
				self._moduleRouteIndex[tostring(iter_1_1.routeType)] = iter_1_1
			end
		end
	end
end

function ModuleGotoProxy:checkSource(arg_2_1)
	self:gotoModuleBySource(arg_2_1)
end

function ModuleGotoProxy:gotoModuleBySource(arg_3_1, arg_3_2)
	if arg_3_1.type and arg_3_1.value and arg_3_1.type == 999 and arg_3_1.value == 1 then
		arg_3_1.needSize = arg_3_1.needSize or 0
		arg_3_1.curSize = arg_3_1.curSize or 0

		self:gotoRechargeQuickPop({
			type = 1,
			needSize = arg_3_1.needSize - arg_3_1.curSize,
			func = arg_3_1.func,
			funcParams = arg_3_1.funcParams,
			addFree = arg_3_1.addFree
		})
	elseif arg_3_1.type and arg_3_1.value and arg_3_1.type == 999 and arg_3_1.value == 0 then
		arg_3_1.needSize = arg_3_1.needSize or 0
		arg_3_1.curSize = arg_3_1.curSize or 0

		local var_3_1 = 409600

		if arg_3_1.needSize > 0 then
			var_3_1 = 409601
		end

		if arg_3_2 and arg_3_2.ignoreConfirm then
			if arg_3_1.needSize > 0 then
				if arg_3_1.needSize <= arg_3_1.curSize + g.core.model.User:getGold() then
					self:gotoDiamondExchange()
				else
					self:gotoRechargeQuickPop({
						type = 0,
						needSize = arg_3_1.needSize - (arg_3_1.curSize + g.core.model.User:getGold())
					})
				end
			elseif g.core.model.User:getGold() > 0 then
				self:gotoDiamondExchange()
			else
				g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
					value = 1,
					type = 999
				})
			end
		else
			local var_3_3 = {
				title = g.core.lang:get(111026)
			}
			local var_3_4 = {
				num = arg_3_1.needSize - arg_3_1.curSize
			}

			var_3_4.name = var_0_4:convert({
				value = 1,
				type = 999
			}).name
			var_3_3.desc1 = g.core.lang:get(var_3_1, var_3_4)
			var_3_3.onCancel = handler(self, function()
				self:gotoModuleBySource2(arg_3_1)
			end)
			var_3_3.onConfirm = handler(self, function()
				if arg_3_1.needSize > 0 then
					if arg_3_1.needSize <= arg_3_1.curSize + g.core.model.User:getGold() then
						g.core.network.GameNetProxy:send_C2S_Gold_Exchange({
							gold = arg_3_1.needSize - arg_3_1.curSize
						})
					else
						self:gotoRechargeQuickPop({
							type = 0,
							needSize = arg_3_1.needSize - (arg_3_1.curSize + g.core.model.User:getGold())
						})
					end
				elseif g.core.model.User:getGold() > 0 then
					self:gotoDiamondExchange()
				else
					g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
						value = 1,
						type = 999
					})
				end
			end)

			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new(var_3_3))
		end
	else
		self:gotoModuleBySource2(arg_3_1, arg_3_2)
	end
end

function ModuleGotoProxy:gotoRechargeQuickPop(arg_6_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.recharge.view.RechargeQuickPop").new(arg_6_1))
end

function ModuleGotoProxy:gotoDiamondExchange(arg_7_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.diamondExchange.DiamondExchangePop").new())
end

function ModuleGotoProxy:gotoModuleBySource2(arg_8_1, arg_8_2)
	if arg_8_2 and arg_8_2.component then
		local var_8_0 = cc.p(0, 0)
		local var_8_1 = cc.p(0, 0)
		local var_8_2 = cc.p(0, 0)
		local var_8_3 = arg_8_2.component:getSize()
		local var_8_4 = arg_8_2.component:getScale()

		var_8_3.width = var_8_3.width * var_8_4.x
		var_8_3.height = var_8_3.height + var_8_4.y
		var_8_0.y = var_8_0.y + var_8_3.height
		var_8_1.x = var_8_1.x + var_8_3.width / 2
		var_8_1.y = var_8_1.y + var_8_3.height / 2
		var_8_2.x = var_8_2.x + var_8_3.width
		var_8_2.y = var_8_2.y + var_8_3.height
		arg_8_2.positionR = arg_8_2.component:displayObject():convertToWorldSpace(var_8_2)
		arg_8_2.positionR.y = display.height - arg_8_2.positionR.y
		arg_8_2.positionC = arg_8_2.component:displayObject():convertToWorldSpace(var_8_1)
		arg_8_2.positionC.y = display.height - arg_8_2.positionC.y
		arg_8_2.positionL = arg_8_2.component:displayObject():convertToWorldSpace(var_8_0)
		arg_8_2.positionL.y = display.height - arg_8_2.positionL.y
	end

	local var_8_5 = self:getSrcRoute(arg_8_1)

	if arg_8_2 and arg_8_2.component then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.goto.view.GoToPop"):new(arg_8_2), {
			isUpdateBlack = false
		})
	else
		g.core.module.ModuleManager:pushPopup(require("app.view.module.goto.view.GoToAndUseBoxPop"):new(arg_8_2))
	end
end

function ModuleGotoProxy:gotoModule(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	self:gotoModuleByConfig(g.core.config.source_route_info.get(arg_9_1):toObject(), arg_9_2, arg_9_3, arg_9_4, arg_9_5)
end

function ModuleGotoProxy:gotoModuleByParams(arg_10_1)
	self:_gotoModule({
		routeInfo = g.core.config.source_route_info.get(arg_10_1.srcRouteId),
		replace = arg_10_1.replace,
		replaceRoot = arg_10_1.replaceRoot,
		popToRoot = arg_10_1.popToRoot,
		good = arg_10_1.good
	})
end

function ModuleGotoProxy:gotoModuleByConfig(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	self:_gotoModule({
		routeInfo = arg_11_1,
		replace = arg_11_2,
		replaceRoot = arg_11_3,
		good = arg_11_4,
		errorStr = arg_11_5
	})
end

function ModuleGotoProxy:_gotoModule(arg_12_1)
	local var_12_0 = arg_12_1.replace
	local var_12_1 = arg_12_1.replaceRoot
	local var_12_2 = arg_12_1.popToRoot
	local var_12_3 = arg_12_1.good
	local var_12_4 = arg_12_1.routeInfo.route_type
	local var_12_5 = not not (self:_isOpenAfterJoinGuild(arg_12_1.routeInfo.route_type) and not g.core.model.User.guildData:hasGuild() and var_0_3:isModuleUnlock(var_0_0.FUNCTION_TYPE.GUILD))

	if not ((var_12_4 == 101 or var_12_4 == 1001 and arg_12_1.routeInfo.function_id ~= var_0_0.FUNCTION_TYPE.RETURN_RECRUIT_ARTIFACT or nil) and true) and not self:checkModuleByRouteConfig(arg_12_1.routeInfo, arg_12_1.errorStr) then
		return
	end

	local var_12_6, var_12_7, var_12_8 = self:getModuleByRouteConfig(arg_12_1.routeInfo)
	local var_12_9 = g.core.module.ModuleManager:getCurModule()

	if var_12_9 and var_12_9.module == var_12_6 then
		g.core.module.ModuleManager:tip(g.core.lang:get(1101))

		return
	end

	if not var_12_6 then
		if var_12_7 then
			g.core.module.ModuleManager:tip(var_12_7)
		end

		return
	end

	if config.OPEN_RECHARGE_SHOP == false and var_12_6 == ModuleEntrance.RECHARGE then
		return
	end

	local var_12_10, var_12_11, var_12_12

	if arg_12_1.routeInfo.route_value_1 ~= 0 then
		var_12_10 = arg_12_1.routeInfo.route_value_1 or nil

		if arg_12_1.routeInfo.route_value_2 ~= 0 then
			var_12_11 = arg_12_1.routeInfo.route_value_2 or nil

			if arg_12_1.routeInfo.route_value_3 ~= 0 then
				var_12_12 = arg_12_1.routeInfo.route_value_3 or nil
			end
		end
	end

	local var_12_13 = {
		route = var_12_4,
		route1 = var_12_10,
		route2 = var_12_11,
		route3 = var_12_12,
		goods = var_12_3
	}

	if var_12_4 == 1027 then
		if var_12_8 then
			var_12_13 = {
				type = var_0_0.ShopConst.SHOP_TYPE.TROOP,
				activityGroup = g.core.config.equipment_extract_info.get((g.core.model.User.troopData:getSubId((g.core.model.User.troopData:getActId(var_12_8))))).shop_group
			}
		end
	elseif var_12_4 == 1028 then
		if var_12_8 then
			var_12_13 = {
				type = var_0_0.ShopConst.SHOP_TYPE.RICH,
				activityGroup = g.core.config.equipment_extract_info.get((g.core.model.User.richData:getSubId((g.core.model.User.richData:getActId(var_12_8))))).shop_group
			}
		end
	elseif var_12_4 == 2012 then
		if var_12_8 then
			var_12_13 = {
				type = var_0_0.ShopConst.SHOP_TYPE.PHANTOM,
				activityGroup = g.core.config.transformation_extract_info.get((g.core.model.User.phantomData:getSubId((g.core.model.User.phantomData:getActId(var_12_8))))).shop_group
			}
		end
	elseif var_12_4 == 23 then
		local var_12_14, var_12_15 = next((g.core.model.User.equipmentData:getLineUpEquipList()))

		if var_12_15 then
			g.core.module.ModuleManager:pushModule(var_12_6, var_12_10 > 0 and var_12_10 or var_0_0.ETConst.DEV_TYPE.STRENGTH, var_12_15:getServerData().id)

			return
		else
			g.core.module.ModuleManager:pushModule(ModuleEntrance.EQUIP_AND_TREASURE, {
				knightIndex = 1
			})

			return
		end
	elseif var_12_4 == 101 then
		local var_12_16, var_12_17 = self:getModuleStateByRouteConfig(arg_12_1.routeInfo)

		if not var_12_16 then
			g.core.module.ModuleManager:tip(var_12_17)
		end
	elseif var_12_4 == 2030 then
		if not g.core.model.User.GuildFightData:isInOpenTime() then
			g.core.module.ModuleManager:tip(g.core.lang:get(109817))

			return
		end
	elseif var_12_4 == 1012 then
		if var_12_10 == var_0_0.ActivityConst.ACTIVITY_ROUTE_VALUE_1.DAILY_WISH then
			var_12_13 = {
				activityValue = 1,
				activityType = var_0_0.ActivityConst.ACTIVITY_TYPE.DAILY_WISH
			}
		elseif var_12_10 == var_0_0.ActivityConst.ACTIVITY_ROUTE_VALUE_1.LEVEL_UP_GIFT then
			var_12_13 = {
				activityValue = 0,
				activityType = var_0_0.ActivityConst.ACTIVITY_TYPE.LEVEL_UP_GIFT
			}
		elseif var_12_10 == var_0_0.ActivityConst.ACTIVITY_ROUTE_VALUE_1.DAILY_RECHARGE then
			var_12_13 = {
				activityValue = 0,
				activityType = var_0_0.ActivityConst.ACTIVITY_TYPE.DAILY_RECHARGE
			}
		elseif var_12_10 == var_0_0.ActivityConst.ACTIVITY_ROUTE_VALUE_1.CELEBRATION_LOGIN then
			var_12_13 = {
				activityType = var_0_0.ActivityConst.ACTIVITY_TYPE.CELEBRATION_LOGIN,
				activityValue = var_12_11
			}
		elseif var_12_10 == var_0_0.ActivityConst.ACTIVITY_ROUTE_VALUE_1.CELEBRATION_WITCH then
			var_12_13 = {
				activityType = var_0_0.ActivityConst.ACTIVITY_TYPE.CELEBRATION_WITCH,
				activityValue = var_12_11
			}
		elseif var_12_10 == var_0_0.ActivityConst.ACTIVITY_ROUTE_VALUE_1.INVITE_FRIEND then
			var_12_13 = {
				activityValue = 0,
				activityType = var_0_0.ActivityConst.ACTIVITY_TYPE.INVITE_FRIEND
			}
		end
	elseif var_12_4 == 2084 then
		if var_12_10 == 2 then
			var_12_13 = {
				activityType = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.MONTH_GACHA,
				activityValue = g.core.model.User.activityMonthGachaData:getActId()
			}
		elseif var_12_10 == 1 then
			var_12_13 = {
				shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.GIFT,
				shopValue = g.core.const.ConstMgr.ShopConst.RECHARGE_HOT_VALUE.HOT_GACHA
			}
		end
	elseif var_12_4 == 1001 and var_12_10 == 6 and var_12_11 == 22 then
		if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.DAILY_RECRUIT) then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				forciblyClose = true,
				title = g.core.lang:get(302006),
				desc = g.core.lang:get(410008, {
					chapter = g.core.config.function_info.get(var_0_0.FUNCTION_TYPE.DAILY_RECRUIT).show_level
				}),
				confirmText = g.core.lang:get(302005),
				cancelText = g.core.lang:get(302004),
				onConfirm = function()
					g.core.module.ModuleManager:pushModule(g.view.entrance.DUNGEON)
				end
			}))

			return
		end
	elseif var_12_4 == 3404 then
		local var_12_19 = g.core.model.User.newSlgData:getCommonPassCardActId()
		local var_12_20 = g.core.model.User.commonPassCardDataMgr:getPassCardData(var_12_19)

		if var_12_20 then
			if not var_12_20:isInOpenTime() then
				g.core.module.ModuleManager:tip(g.core.lang:get(405720))

				return
			end

			var_12_13 = {
				activityId = var_12_19
			}
		end
	end

	if (var_12_4 < 2052 or var_12_4 > 2061 or var_12_4 == 2058 or var_12_4 == 2059) and var_12_4 ~= 2064 and var_12_4 ~= 2074 and var_12_4 ~= 2082 then
		if var_12_4 == 2088 then
			local var_12_21

			if #g.core.model.User.themeData:getThemeMergeConfigValueList(var_12_10) > 1 then
				local var_12_22 = g.core.model.User.themeData:getThemeMergeEntranceActivityData(var_12_10)

				if var_12_22 then
					local var_12_23 = var_12_22:getOpenActivityData()

					if var_12_23 then
						var_12_10 = var_12_23:getConfigActivityValue()
						var_12_21 = var_12_23
					end
				end
			end

			local var_12_24 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(var_0_1.THEME_TYPE, var_12_10) or var_12_21 and var_12_21

			if not var_12_24 or not var_12_24:isAwardPeriod() then
				g.core.module.ModuleManager:tip(g.core.lang:get(405720))

				return
			end

			if (var_12_4 == 2053 or var_12_4 == 2054 or var_12_4 == 2055 or var_12_4 == 2057 or var_12_4 == 2082) and var_12_24:getActivityState() == g.core.const.ConstMgr.ActivityConst.ACTIVITY_STATE.END then
				g.core.module.ModuleManager:tip(g.core.lang:get(1005))

				return
			end

			if var_12_4 == 2054 then
				local var_12_25 = g.core.model.User.themeData:getThemeMergeConfigValueList(var_12_10)

				if #var_12_25 > 1 then
					g.core.module.ModuleManager:pushPopup((require("app.view.module.summerTheme.view.mergeTheme.SummerThemeBossSelectLayer").new({
						activityValues = var_12_25,
						activeThemeValue = var_12_10
					})))

					return
				end

				local var_12_26 = g.core.model.User.themeData:getThemeData(var_12_10)

				if not var_12_26 then
					return
				end

				if var_12_26:getBossData():getCurPhase() <= 0 then
					g.core.module.ModuleManager:tip(g.core.lang:get(1008))

					return
				end
			end

			if var_12_4 == 2060 then
				local var_12_27 = g.core.model.User.themeData:getThemeData(var_12_10)

				if not var_12_27 then
					return
				end

				local var_12_28 = g.core.common.ServerTime:getTime()
				local var_12_29 = var_12_27:getTurnCardData()

				if var_12_28 < var_12_29:getTurnCardStartTime() then
					g.core.module.ModuleManager:tip((g.core.lang:get(1008)))

					return
				elseif var_12_29:getTurnCardEndTime() < var_12_28 then
					g.core.module.ModuleManager:tip((g.core.lang:get(1005)))

					return
				end
			end

			if var_12_4 == 2064 then
				local var_12_30 = g.core.model.User.themeData:getThemeData(var_12_10)

				if not var_12_30 then
					return
				end

				local var_12_31 = g.core.common.ServerTime:getTime()
				local var_12_32 = var_12_30:getGemEliminateData()

				if var_12_31 < var_12_32:getGemEliminateStartTime() then
					g.core.module.ModuleManager:tip((g.core.lang:get(1008)))

					return
				elseif var_12_32:getGemEliminateEndTime() < var_12_31 then
					g.core.module.ModuleManager:tip((g.core.lang:get(1005)))

					return
				end
			end

			if var_12_4 == 2074 then
				local var_12_33 = g.core.model.User.themeData:getThemeData(var_12_10)

				if not var_12_33 then
					return
				end

				local var_12_34 = g.core.common.ServerTime:getTime()
				local var_12_35 = var_12_33:getThemePuzzleData()

				if var_12_34 < var_12_35:getPuzzleStartTime() then
					g.core.module.ModuleManager:tip((g.core.lang:get(1008)))

					return
				elseif var_12_35:getPuzzleEndTime() < var_12_34 then
					g.core.module.ModuleManager:tip((g.core.lang:get(1005)))

					return
				end
			end

			if var_12_4 == 2088 then
				local var_12_36 = g.core.model.User.themeData:getThemeData(var_12_10)

				if not var_12_36 then
					return
				end

				local var_12_37 = g.core.common.ServerTime:getTime()
				local var_12_38 = var_12_36:getThemeGuessData()

				if var_12_37 < var_12_38:getGuessStartTime() then
					g.core.module.ModuleManager:tip((g.core.lang:get(1008)))

					return
				elseif var_12_38:getGuessEndTime() < var_12_37 then
					g.core.module.ModuleManager:tip((g.core.lang:get(1005)))

					return
				end
			end

			var_12_13.themeValue = var_12_10

			local var_12_39 = g.core.module.ModuleManager:getFirstFullModule()

			if var_12_39.module and var_12_39.module.routeType then
				if type(var_12_39.module.routeType) == "number" and var_12_39.module.routeType >= 2052 and var_12_39.module.routeType <= 2057 then
					var_12_0 = false
					var_12_1 = true
				end
			end
		elseif var_12_4 == 21 then
			if arg_12_1.routeInfo.route_value_2 == 0 then
				local var_12_40 = 0

				if arg_12_1.routeInfo.route_value_1 == 4 then
					local var_12_41 = g.core.model.User.knightsData:getOwnerList()

					table.sort(var_12_41, function(arg_14_0, arg_14_1)
						local var_14_0 = arg_14_0:isLineup() and 1 or 0
						local var_14_1 = arg_14_1:isLineup() and 1 or 0

						if var_14_0 ~= var_14_1 then
							return var_14_1 < var_14_0
						end

						return arg_14_0:getAdvanceId() > arg_14_1:getAdvanceId()
					end)

					for iter_12_0, iter_12_1 in ipairs(var_12_41) do
						if g.core.model.User.weddingData:isWeddingVowByKnightId(iter_12_1:getAdvanceId()) then
							var_12_40 = iter_12_1:getServerId()

							break
						end
					end
				end

				if var_12_40 > 0 then
					var_12_13.knightSid = var_12_40
				else
					var_12_6 = ModuleEntrance.KNIGHT
				end
			end
		elseif var_12_4 == 2300 then
			if not g.core.model.User.recruitData:getSpringRecruitData() then
				g.core.module.ModuleManager:tip(g.core.lang:get(108705))

				return
			end
		elseif var_12_4 == 3401 then
			if not g.core.model.User.allianceData:hasAlliance() then
				g.core.module.ModuleManager:tip(g.core.lang:get(429027))

				return
			elseif not g.core.model.User.newSlgData:isOpen() then
				g.core.module.ModuleManager:tip(g.core.lang:get(307536))

				return
			end

			local var_12_42 = g.core.model.User.newSlgData

			if g.core.model.User.newSlgData:isForecasting() then
				var_12_6 = ModuleEntrance.NEW_SLG_PREVIEW_LAYER
			elseif var_12_42:isEnding() then
				var_12_6 = ModuleEntrance.NEW_SLG_END_SHOW_LAYER
			end

			if arg_12_1.routeInfo.route_value_1 == 1 then
				if g.core.module.ModuleManager:isCurModule(g.view.entrance.NEW_SLG_MAIN) then
					g.core.event.EventManager:dispatchEvent(g.core.const.ConstMgr.NewSlgConst.OPEN_SEARCH)

					return
				else
					g.core.model.User.newSlgData:setOpenSearch()
				end
			elseif arg_12_1.routeInfo.route_value_1 == 2 then
				if g.core.module.ModuleManager:isCurModule(g.view.entrance.NEW_SLG_MAIN) then
					g.core.event.EventManager:dispatchEvent(g.core.const.ConstMgr.NewSlgConst.OPEN_TEAM_BATTLE)

					return
				else
					g.core.model.User.newSlgData:setOpenTeamBattle()
				end
			end

			local var_12_43 = g.core.module.ModuleManager:getFirstFullModule()

			if var_12_43.module and var_12_43.module.routeType then
				if type(var_12_43.module.routeType) == "number" and (var_12_43.module.routeType == 3404 or var_12_43.module.routeType == 3402 or var_12_43.module.routeType == 3405 or var_12_43.module.routeType == 3401) then
					g.core.module.ModuleManager:popComponent()

					return
				end
			end
		elseif var_12_4 == 3405 then
			if not g.core.model.User.allianceData:hasAlliance() then
				g.core.module.ModuleManager:tip(g.core.lang:get(429027))

				return
			elseif not g.core.model.User.newSlgData:isOpen() then
				g.core.module.ModuleManager:tip(g.core.lang:get(307536))

				return
			end

			if var_12_9.module == ModuleEntrance.NEW_SLG_DEVELOP_MAIN_LAYER then
				if var_12_10 == 1 then
					var_12_6 = ModuleEntrance.NEW_SLG_EMBRYO_LINEUP_POP
				elseif var_12_10 == 2 then
					var_12_6 = ModuleEntrance.NEW_SLG_SUPPLY_POP
				elseif var_12_10 == 7 then
					var_12_6 = ModuleEntrance.NEW_SLG_SKILL_TREE
				else
					local var_12_44 = g.core.const.ConstMgr.NewSlgConst
					local var_12_45 = g.core.const.ConstMgr.NewSlgConst.SLG_BUILD_TYPE.BARRACK
					local var_12_46 = g.core.const.ConstMgr.NewSlgConst.ARMY_TYPE.QI

					if var_12_10 == 4 then
						var_12_46 = var_12_44.ARMY_TYPE.DUN
					elseif var_12_10 == 5 then
						var_12_46 = var_12_44.ARMY_TYPE.GONG
					elseif var_12_10 == 6 then
						var_12_45 = var_12_44.SLG_BUILD_TYPE.COMMAND
					end

					var_12_13 = {
						buildType = var_12_45,
						armyType = var_12_46
					}
					var_12_6 = ModuleEntrance.New_SLG_BARRACK_POP
				end
			else
				var_12_13 = {
					route1 = var_12_10
				}
				var_12_6 = ModuleEntrance.NEW_SLG_DEVELOP_MAIN_LAYER
			end
		elseif var_12_4 == 2103 then
			local RoleSkinDevConfig = require("app.view.module.roleSkin.const.RoleSkinDevConfig")

			if var_12_10 == 0 then
				var_12_13 = {
					part = g.core.const.ConstMgr.RoleSkinConst.PART.CLOTH,
					devType = RoleSkinDevConfig.DEV_TYPE.LEVEL
				}
			elseif var_12_10 == 1 then
				var_12_13 = {
					part = g.core.const.ConstMgr.RoleSkinConst.PART.CLOTH,
					devType = RoleSkinDevConfig.DEV_TYPE.STAGE
				}
			elseif var_12_10 == 2 then
				var_12_13 = {
					part = g.core.const.ConstMgr.RoleSkinConst.PART.WEAPON,
					devType = RoleSkinDevConfig.DEV_TYPE.STAGE
				}
			elseif var_12_10 == 3 then
				var_12_13 = {
					part = g.core.const.ConstMgr.RoleSkinConst.PART.BACK,
					devType = RoleSkinDevConfig.DEV_TYPE.STAGE
				}
			end
		elseif var_12_4 == 3611 then
			if not g.core.model.User.pubgData:isActivityOpen() then
				g.core.module.ModuleManager:tip(g.core.lang:get(307536))

				return
			end
		elseif var_12_4 == 2110 or var_12_4 == 2111 then
			if not g.core.model.User.releaseActivityData:isActivityOpen() then
				g.core.module.ModuleManager:tip(g.core.lang:get(307536))

				return
			end
		elseif var_12_4 == 6601 then
			if not var_12_10 then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_JUMP_TO_POS, false, 0, {
					pos = cc.p(var_12_11, var_12_12)
				})

				var_12_13.pos = cc.p(var_12_11, var_12_12)
			else
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_JUMP_TO_BUILD, false, 0, {
					buildType = var_12_10
				})

				var_12_13.buildType = var_12_10
			end

			local var_12_48 = g.core.module.ModuleManager:getCurRootModule()

			if var_12_48 and var_12_48 == g.view.entrance.OUT_POST_STAGE then
				g.core.module.ModuleManager:popAllPopup()

				return
			end
		elseif var_12_4 == 6602 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_OPEN_KNIGHT_COMP)
		elseif var_12_4 == 6603 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_TIPS_ITEM)
		elseif var_12_4 == 6607 then
			if not g.core.model.User.ancientsData:isTimeToOpen() then
				g.core.module.ModuleManager:tip(g.core.lang:get(307536))

				return
			end
		elseif var_12_4 == 10001 then
			g.core.service.ServiceManager:getServiceByName("GuideService"):enterOldGuideState()

			return
		end

		if var_12_6.showPassCloud then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_CHANGE_PLAY_TRANSITION, false, {
				callback = handler(self, self.passCloudCallBack),
				callbackParams = {
					module = var_12_6,
					replace = var_12_0,
					params = var_12_13,
					replaceRoot = var_12_1,
					popToRoot = var_12_2
				}
			})
		elseif var_12_0 then
			g.core.module.ModuleManager:replaceModule(var_12_6, var_12_13)
		elseif var_12_1 then
			g.core.module.ModuleManager:replaceModuleRoot(var_12_6, var_12_13)
		elseif var_12_2 then
			g.core.module.ModuleManager:popToRootAndPush(var_12_6, var_12_13)
		end
	end

	g.core.module.ModuleManager:pushModule(var_12_6, var_12_13)
end

function ModuleGotoProxy:passCloudCallBack(arg_15_1)
	if arg_15_1.replace then
		g.core.module.ModuleManager:replaceModule(arg_15_1.module, arg_15_1.params)
	elseif arg_15_1.replaceRoot then
		g.core.module.ModuleManager:replaceModuleRoot(arg_15_1.module, arg_15_1.params)
	elseif arg_15_1.popToRoot then
		g.core.module.ModuleManager:popToRootAndPush(arg_15_1.module, arg_15_1.params)
	else
		g.core.module.ModuleManager:pushModule(arg_15_1.module, arg_15_1.params)
	end
end

function ModuleGotoProxy:getSrcRoute(arg_16_1)
	local var_16_0 = g.core.config.source_type_info.fetch(arg_16_1.type, arg_16_1.value)

	if not var_16_0 then
		return {
			source = arg_16_1,
			routes = {}
		}
	end

	local var_16_1 = 0
	local var_16_2 = 1

	repeat
		if var_16_0[table.concat({
			"source_id_",
			var_16_2
		})] ~= 0 then
			var_16_1 = var_16_1 + 1
		end

		var_16_2 = var_16_2 + 1
	until not g.core.config.source_type_info.hasKey(table.concat({
		"source_id_",
		var_16_2
	}))

	local var_16_3 = {}

	for iter_16_0 = 1, var_16_1 do
		local var_16_4 = var_16_0[table.concat({
			"source_id_",
			iter_16_0
		})]

		if var_16_4 ~= 0 then
			local var_16_5 = g.core.config.source_info.fetch(var_16_4)

			if var_16_5 then
				local var_16_6 = var_16_5.toObject()
				local var_16_7 = g.core.config.source_route_info.get(var_16_6.route_id)
				local var_16_8, var_16_9 = self:getModuleStateByRouteId(var_16_6.route_id)

				table.insert(var_16_3, {
					route = var_16_6,
					isOpened = var_16_8,
					errDesc = var_16_9,
					routType = var_16_7.route_type,
					chapterId = var_16_7.route_value_1,
					routeMark = var_16_7.route_mark,
					index = iter_16_0
				})
			end
		end
	end

	if arg_16_1.type == 3 and arg_16_1.value == 201 then
		local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")

		var_16_3 = {}

		for iter_16_1 = 1, g.core.config.cultivate_activity_info.getLength() do
			local var_16_11 = g.core.config.cultivate_activity_info.indexOf(iter_16_1)

			if var_16_11.recruit_route > 0 and var_16_11.type ~= CultivateConst.ACTIVITY_TYPE.WITCH then
				if (g.core.config.source_route_info.get(var_16_11.recruit_route).route_value_3 ~= 0 or nil) and g.core.model.User.cultivateDataMgr:isActOpen(var_16_11.id) then
					local var_16_13 = 1
					local var_16_14 = {
						"recruit_source_id"
					}

					var_16_14[2] = 1

					local var_16_15 = table.concat(var_16_14, "_")

					while g.core.config.cultivate_activity_info.hasKey(var_16_15) do
						if var_16_11[var_16_15] ~= 0 then
							local var_16_16 = g.core.config.source_info.fetch(var_16_11[var_16_15])

							if var_16_16 then
								local var_16_17 = var_16_16.toObject()
								local var_16_18 = g.core.config.source_route_info.get(var_16_17.route_id)

								table.insert(var_16_3, {
									isOpened = true,
									errDesc = "",
									route = var_16_17,
									routType = var_16_18.route_type,
									chapterId = var_16_18.route_value_1,
									routeMark = var_16_18.route_mark,
									index = var_16_13
								})
							end
						end

						var_16_13 = var_16_13 + 1
						var_16_15 = table.concat({
							"recruit_source_id",
							var_16_13
						}, "_")
					end
				end
			end
		end
	end

	table.sort(var_16_3, function(arg_17_0, arg_17_1)
		if arg_17_0.isOpened == arg_17_1.isOpened then
			return arg_17_0.index < arg_17_1.index
		end

		return arg_17_0.isOpened and not arg_17_1.isOpened
	end)

	return {
		source = arg_16_1,
		routes = var_16_3
	}
end

function ModuleGotoProxy:getModuleStateByRouteId(arg_18_1)
	assert(type(arg_18_1) == "number", "Invalid source_route_info id: " .. tostring(arg_18_1))

	return self:getModuleStateByRouteConfig((g.core.config.source_route_info.get(arg_18_1)))
end

function ModuleGotoProxy:getModuleStateByRouteConfig(arg_19_1)
	return self:_getModuleStateByRouteId(arg_19_1)
end

function ModuleGotoProxy:_getModuleStateByRouteId(arg_20_1)
	if g.core.model.User.refundData:isClosed() then
		return false, g.core.lang:get(102409)
	end

	local var_20_0 = g.core.model.User

	if arg_20_1.route_type == 101 then
		if arg_20_1.route_value_1 ~= 0 and not var_20_0.dungeonData:isChapterUnlocked(arg_20_1.route_value_1) then
			return false, g.core.lang:get(1075, {
				chapter = arg_20_1.route_value_1
			})
		end
	elseif arg_20_1.route_type == 102 then
		if arg_20_1.route_value_1 ~= 0 and not var_20_0.dungeonData:isStageUnlocked(arg_20_1.route_value_1) then
			return false, g.core.lang:get(1080)
		end
	elseif arg_20_1.route_type == 103 then
		if arg_20_1.route_value_1 > 0 then
			local var_20_1 = var_20_0.bioData:getChapter(arg_20_1.route_value_1)

			if var_20_1 and not var_20_1.fighting and not var_20_1.finish then
				return false, g.core.lang:get(1074)
			end
		end
	elseif arg_20_1.route_type == 104 then
		if arg_20_1.route_value_1 > 0 then
			local var_20_2 = var_20_0.bioData:getMission(arg_20_1.route_value_1)

			if var_20_2 and not var_20_2.fighting and not var_20_2.finish then
				return false, g.core.lang:get(1080)
			end
		end
	elseif arg_20_1.route_type == 105 then
		if arg_20_1.route_value_1 > 0 and not var_20_0.bioData:isCampainOpen(arg_20_1.route_value_1) then
			return false, g.core.lang:get(1022)
		end
	elseif self:_isOpenAfterJoinGuild(arg_20_1.route_type) then
		if not var_20_0.guildData:hasGuild() then
			return false, g.core.lang:get(1012)
		elseif arg_20_1.route_type == ModuleEntrance.GUILD_DUNGEON.routeType then
			local var_20_3 = g.core.config.function_info.get(var_0_0.FUNCTION_TYPE.GUILD_DUNGEON)

			if var_20_3.level_type == 3 and var_20_0.guildData:getGuildLevel() < var_20_3.level then
				return false, var_20_3.lock_direction
			end
		elseif arg_20_1.route_type == ModuleEntrance.GUILD_WAR.routeType then
			return var_20_0.guildWarData:isOpen()
		end
	elseif arg_20_1.route_type == ModuleEntrance.SHOP.routeType and arg_20_1.route_value_1 == 3 and arg_20_1.route_value_2 == 6 then
		if not var_20_0.guildData:hasGuild() then
			return false, g.core.lang:get(1012)
		end
	elseif arg_20_1.route_type == 2005 and (arg_20_1.route_value_1 == 2 or arg_20_1.route_value_1 == 3) then
		if not var_20_0.guildData:hasGuild() then
			return false, g.core.lang:get(1012)
		end
	elseif arg_20_1.route_type == 2015 then
		if not var_0_3:isModuleUnlock(var_0_0.FUNCTION_TYPE.COMMANDER_WORLD) then
			return false, g.core.lang:get(1049)
		end
	elseif arg_20_1.route_type == 116 then
		local var_20_4 = arg_20_1.route_value_1

		if arg_20_1.route_value_1 == 0 then
			var_20_4 = var_20_0.stormData:getCurMiddleCityId()
		end

		if var_20_4 and var_20_4 > 0 then
			local var_20_5 = g.core.config.storm_info.get(var_20_4)

			if var_20_0.stormData:isMiddleCityInOpenTime() then
				if var_20_0.stormData:isPresetUnlock(var_20_4) then
					return true
				else
					return false, g.core.lang:get(1202, {
						name = var_20_5.name
					})
				end
			else
				return false, g.core.lang:get(1203, {
					name = var_20_5.name
				})
			end
		else
			return false
		end
	elseif arg_20_1.route_type == 117 then
		local var_20_6 = arg_20_1.route_value_1

		if arg_20_1.route_value_1 == 0 then
			var_20_6 = var_20_0.stormData:getCurBigCityId()
		end

		if var_20_6 and var_20_6 > 0 then
			local var_20_7 = g.core.config.storm_info.get(var_20_6)

			if var_20_0.stormCityData:isProcess() then
				if var_20_0.stormData:isPresetUnlock(var_20_6) then
					return true
				else
					return false, g.core.lang:get(1202, {
						name = var_20_7.name
					})
				end
			else
				return false, g.core.lang:get(1203, {
					name = var_20_7.name
				})
			end
		else
			return false
		end
	elseif arg_20_1.route_type == ModuleEntrance.MINE.routeType then
		if not var_20_0.mineData:isInOpenTime() then
			return false, g.core.lang:get(307027)
		end
	elseif arg_20_1.route_type == ModuleEntrance.PEAK_ARENA.routeType then
		if not var_20_0.peakArenaData:isShowEntrance() then
			return false, g.core.lang:get(307027)
		end
	elseif arg_20_1.route_type == ModuleEntrance.GVE_GAME_STAGE.routeType then
		if not var_20_0.gveDataMgr:isGveModuleOpen() then
			return false, g.core.lang:get(1049)
		elseif not g.core.model.User.allianceData:isInAlliance() then
			return false, g.core.lang:get(309198)
		end
	elseif arg_20_1.route_type == ModuleEntrance.AUCTION.routeType then
		if var_20_0.AuctionData:getAuctionTime() == 0 then
			return false, g.core.lang:get(307027)
		end
	elseif arg_20_1.route_type == ModuleEntrance.CULTIVATE_MAIN.routeType then
		if arg_20_1.route_value_1 == 2 and arg_20_1.route_value_2 == 4 and arg_20_1.route_value_3 == 0 then
			local var_20_8, var_20_9, var_20_10 = var_20_0.cultivateDataMgr:getOpenCultivateDataAndId(2)

			return var_20_8 ~= nil and var_20_10, g.core.lang:get(307027)
		end

		local var_20_11 = var_20_0.cultivateDataMgr:getCultivateData(arg_20_1.route_value_1)

		if not var_20_11 or not var_20_11:isInActivityShowTime() then
			if var_20_11 and arg_20_1.route_value_2 ~= 0 and not var_20_11:isInNormalOpenTime() then
				return false, g.core.lang:get(307027)
			end

			return false, g.core.lang:get(307027)
		end

		if (arg_20_1.route_value_2 == 2 or arg_20_1.route_value_2 == 3 or arg_20_1.route_value_2 == 4 or arg_20_1.route_value_2 == 5) and not var_20_11:isInNormalOpenTime() then
			return false, g.core.lang:get(307027)
		end
	elseif arg_20_1.route_type == ModuleEntrance.ACTIVITY_RETURN.routeType then
		return g.core.model.User.activityReturnData:isActivityOpen((g.core.model.User.activityReturnData:getCurId())), g.core.lang:get(307027)
	elseif arg_20_1.route_type == ModuleEntrance.TEAM_BATTLE_READY_LAYER.routeType then
		return g.core.model.User.teamBattleData:isActivityOpen(), g.core.lang:get(307027)
	elseif arg_20_1.route_type == ModuleEntrance.SUCUBA_MAIN_LAYER.routeType then
		local var_20_12 = var_0_3:isModuleUnlock(arg_20_1.function_id)

		if not var_20_12 then
			return var_20_12, g.core.lang:get(431046)
		end

		return true
	elseif arg_20_1.route_type == ModuleEntrance.SPIRE_MAIN_LAYER.routeType then
		local var_20_13 = var_0_3:isFunctionUnlock(arg_20_1.function_id)

		if not var_20_13 then
			return var_20_13, g.core.config.function_info.get(arg_20_1.function_id).lock_direction
		elseif not g.core.model.User.spireData:isInActivityTime() then
			return false, g.core.lang:get(432033)
		end
	elseif (arg_20_1.route_type == ModuleEntrance.RELEASE_ACTIVITY_MAIN_LAYER.routeType or arg_20_1.route_type == ModuleEntrance.RELEASE_ACTIVITY_GIFT_POP) and not g.core.model.User.releaseActivityData:isActivityOpen() then
		return false, g.core.lang:get(307536)
	end

	if arg_20_1.function_id == 0 then
		return true
	end

	local var_20_14 = g.core.config.function_info.get(arg_20_1.function_id)
	local var_20_15 = var_0_3:isModuleUnlock(arg_20_1.function_id)

	if not var_20_15 then
		return var_20_15, var_20_14.lock_direction
	end

	return true
end

function ModuleGotoProxy:checkModuleByRouteId(arg_21_1)
	local var_21_0, var_21_1 = self:getModuleStateByRouteId(arg_21_1)

	if not var_21_0 then
		g.core.module.ModuleManager:tip(var_21_1)

		return false
	end

	return true
end

function ModuleGotoProxy:checkModuleByRouteConfig(arg_22_1, arg_22_2)
	local var_22_0, var_22_1 = self:getModuleStateByRouteConfig(arg_22_1)

	if not var_22_0 then
		g.core.module.ModuleManager:tip((arg_22_2 or nil) and arg_22_2)
	end

	return var_22_0
end

function ModuleGotoProxy:checkModule(arg_23_1)
	assert(arg_23_1, "Invalid module: " .. tostring(arg_23_1))

	if arg_23_1.routeId then
		return self:checkModuleByRouteId(arg_23_1.routeId)
	end

	return true
end

function ModuleGotoProxy:getModule(arg_24_1)
	return self:getModuleByRouteConfig((g.core.config.source_route_info.get(arg_24_1)))
end

function ModuleGotoProxy:getModuleByRouteConfig(arg_25_1)
	return self:_getModule(arg_25_1)
end

function ModuleGotoProxy:_getModule(arg_26_1)
	local var_26_0 = self._moduleRouteIndex[tostring(arg_26_1.route_type)]

	if self:_isOpenAfterJoinGuild(arg_26_1.route_type) then
		if arg_26_1.route_type == ModuleEntrance.GUILD_BOSS.routeType then
			if g.core.model.User.guildCampaignData:isOpenDayFinish(g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_BOSS) then
				var_26_0 = g.core.model.User.guildData:hasGuild() and ModuleEntrance.GUILD_BOSS or ModuleEntrance.GUILD_JOIN
			else
				return nil, g.core.lang:get(100528)
			end
		elseif not g.core.model.User.guildData:hasGuild() then
			var_26_0 = ModuleEntrance.GUILD_JOIN
		end
	elseif arg_26_1.route_type == 1023 then
		if var_0_3:isModuleShow(var_0_0.FUNCTION_TYPE.GOLD_RECRUIT) then
			if g.core.model.User.goldRecruitData:isProcess(g.core.const.GoldRecruitConst.TYPE_BY_OPEN) then
				return ModuleEntrance.GOLD_RECRUIT, nil
			elseif g.core.model.User.goldRecruitData:isProcess(g.core.const.GoldRecruitConst.TYPE_BY_CUSTOM) then
				return ModuleEntrance.GOLD_RECRUIT_CUSTOM
			else
				return nil, g.core.lang:get(1100)
			end
		else
			return nil, g.core.lang:get(1100)
		end
	elseif arg_26_1.route_type == 3000002 then
		if var_0_3:isModuleShow(var_0_0.FUNCTION_TYPE.SPACE_TIME_RECRUIT) then
			if g.core.model.User.spaceTimeRecruitData:isProcess() then
				return ModuleEntrance.SPACE_TIME_RECRUIT, nil
			else
				return nil, g.core.lang:get(1198)
			end
		else
			return nil, g.core.lang:get(1198)
		end
	elseif arg_26_1.route_type == 1026 then
		if var_0_3:isModuleShow(var_0_0.FUNCTION_TYPE.TROOP) then
			if g.core.model.User.troopData:isProcess(g.core.const.TroopConst.TYPE_BY_OPEN) then
				return ModuleEntrance.TROOP
			elseif g.core.model.User.troopData:isProcess(g.core.const.TroopConst.TYPE_BY_CUSTOM) then
				return ModuleEntrance.TROOP_CUSTOM
			else
				return nil, g.core.lang:get(1216)
			end
		else
			return nil, g.core.lang:get(1216)
		end
	elseif arg_26_1.route_type == 1027 then
		if var_0_3:isModuleShow(var_0_0.FUNCTION_TYPE.TROOP) then
			if g.core.model.User.troopData:isProcess(g.core.const.TroopConst.TYPE_BY_OPEN) then
				return var_26_0, "", g.core.const.TroopConst.TYPE_BY_OPEN
			elseif g.core.model.User.troopData:isProcess(g.core.const.TroopConst.TYPE_BY_CUSTOM) then
				return var_26_0, "", g.core.const.TroopConst.TYPE_BY_CUSTOM
			else
				return nil, g.core.lang:get(1216)
			end
		else
			return nil, g.core.lang:get(1216)
		end
	elseif arg_26_1.route_type == 2024 then
		if var_0_3:isModuleShow(var_0_0.FUNCTION_TYPE.RICH) then
			if g.core.model.User.richData:isProcess(g.core.const.RichConst.TYPE_BY_OPEN) or g.core.model.User.richData:isShowEntrance(g.core.const.RichConst.TYPE_BY_OPEN) then
				return ModuleEntrance.RICH
			elseif g.core.model.User.richData:isProcess(g.core.const.RichConst.TYPE_BY_CUSTOM) or g.core.model.User.richData:isShowEntrance(g.core.const.RichConst.TYPE_BY_CUSTOM) then
				return ModuleEntrance.RICH_CUSTOM
			else
				return nil, g.core.lang:get(1177)
			end
		else
			return nil, g.core.lang:get(1177)
		end
	elseif arg_26_1.route_type == 2011 then
		local var_26_1, var_26_2 = var_0_3:getModuleUnlockLevelAndComment(var_0_0.FUNCTION_TYPE.PHANTOM_RECRUIT)

		if var_0_3:isModuleShow(var_0_0.FUNCTION_TYPE.PHANTOM_RECRUIT) then
			if g.core.model.User.phantomData:isProcess(g.core.const.PhantomConst.TYPE_BY_OPEN) then
				return ModuleEntrance.PHANTOM_RECRUIT
			elseif g.core.model.User.phantomData:isProcess(g.core.const.PhantomConst.TYPE_BY_CUSTOM) then
				return ModuleEntrance.PHANTOM_RECRUIT_CUSTOM
			else
				return nil, var_26_2
			end
		else
			return nil, var_26_2
		end
	elseif arg_26_1.route_type == 2012 then
		local var_26_3, var_26_4 = var_0_3:getModuleUnlockLevelAndComment(var_0_0.FUNCTION_TYPE.PHANTOM_RECRUIT)

		if var_0_3:isModuleShow(var_0_0.FUNCTION_TYPE.PHANTOM_RECRUIT) then
			if g.core.model.User.phantomData:isProcess(g.core.const.PhantomConst.TYPE_BY_OPEN) then
				return var_26_0, nil, g.core.const.PhantomConst.TYPE_BY_OPEN
			elseif g.core.model.User.phantomData:isProcess(g.core.const.PhantomConst.TYPE_BY_CUSTOM) then
				return var_26_0, nil, g.core.const.PhantomConst.TYPE_BY_CUSTOM
			else
				return nil, var_26_4
			end
		else
			return nil, var_26_4
		end
	elseif arg_26_1.route_type == 1002 and arg_26_1.route_value_1 == 3 then
		-- block empty
	elseif arg_26_1.route_type == ModuleEntrance.GUILD_BOSS.routeType then
		var_26_0 = g.core.model.User.guildData:hasGuild() and ModuleEntrance.GUILD_BOSS or ModuleEntrance.GUILD_JOIN
	elseif arg_26_1.route_type == 2008 then
		-- block empty
	elseif arg_26_1.route_type == 115 then
		var_26_0 = ModuleEntrance.STORM_BIG_WORLD
	elseif arg_26_1.route_type == 2009 then
		var_26_0 = g.core.model.User.mineData:isInWarTime() and ModuleEntrance.MINE or ModuleEntrance.MINE_RESULT
	elseif arg_26_1.route_type == 2010 then
		local var_26_5 = g.core.common.GlobalFunc.getExchangeRoute({
			type = arg_26_1.route_value_1,
			value = arg_26_1.route_value_2
		})

		if var_26_5 then
			var_26_0 = ModuleEntrance.ACTIVITY
			arg_26_1.route_value_1 = var_26_5
		else
			return nil, g.core.lang:get(1130)
		end
	elseif arg_26_1.route_type == 2070 then
		local var_26_6 = g.core.module.ModuleManager:getCurModule().module

		if var_26_6.previous then
			if var_26_6.previous.routeType == 2070 then
				return nil, g.core.lang:get(1143)
			end
		else
			local var_26_7 = g.core.module.ModuleManager:getCurRootModule() or {}

			if var_26_7.previous and var_26_7.previous.routeType == 2070 then
				return nil, g.core.lang:get(1143)
			end
		end

		local var_26_8 = g.core.model.User.fogNightmareData

		if not g.core.model.User.fogNightmareData:isOpen() then
			return nil, g.core.lang:get(1049)
		end

		local var_26_9 = g.core.const.ConstMgr.FogNightmareConst
		local var_26_10 = var_26_8:getFogStageType()

		if var_26_10 == g.core.const.ConstMgr.FogNightmareConst.ACTIVITY_STATE.OPEN then
			var_26_0 = ModuleEntrance.FOG_NIGHTMARE_MAIN
		elseif var_26_10 == var_26_9.ACTIVITY_STATE.END then
			var_26_0 = ModuleEntrance.FOG_NIGHTMARE_RESULT_LAYER
		end
	elseif arg_26_1.route_type == ModuleEntrance.SEVEN_DAYS_SIGN_IN.routeType then
		var_26_0 = ModuleEntrance.SEVEN_DAYS_SIGN_IN
	elseif arg_26_1.route_type == ModuleEntrance.TEAM_BATTLE_READY_LAYER.routeType then
		if g.core.model.User.teamBattleData:isActivityOpen() then
			if g.core.module.ModuleManager:isExistModule(ModuleEntrance.TEAM_BATTLE_FORMATION_LAYER) or g.core.module.ModuleManager:isExistModule(ModuleEntrance.TEAM_BATTLE_MAP_LAYER) or g.core.module.ModuleManager:isExistModule(ModuleEntrance.TEAM_BATTLE_KNIGHT_BAG_LAYER) then
				return nil, g.core.module.ModuleManager:tip(g.core.lang:get(427157))
			end

			local var_26_11 = g.core.model.User.teamBattleData:getFormationData()
			local var_26_12 = g.core.model.User.teamBattleData:getTeamUpData().getMyTeam(var_26_11)

			if var_26_12 and var_26_12.ready and #var_26_11:getAllKnightList() > 0 and g.core.model.User.teamBattleData:getCurStage() == 2 then
				return ModuleEntrance.TEAM_BATTLE_MAP_LAYER
			end

			return ModuleEntrance.TEAM_BATTLE_READY_LAYER
		end
	elseif arg_26_1.route_type == 2080 then
		if not g.core.model.User.gveDataMgr:isOpen() then
			return nil, g.core.lang:get(1049)
		end

		if arg_26_1.route_value_1 == 0 then
			local var_26_13 = g.core.model.User.gveDataMgr:getGveTimeState()

			if var_26_13 == var_0_0.GveConst.GVE_TIME_STATE.SIGNUP then
				var_26_0 = ModuleEntrance.GVE_SIGNUP_LAYER
			elseif var_26_13 == var_0_0.GveConst.GVE_TIME_STATE.FORMAL then
				var_26_0 = ModuleEntrance.GVE_GAME_STAGE
			elseif var_26_13 == var_0_0.GveConst.GVE_TIME_STATE.RESULT then
				var_26_0 = ModuleEntrance.GVE_RESULT_LAYER
			end
		elseif arg_26_1.route_value_1 == 1 then
			if not g.core.model.User.gveDataMgr:isInFormalStage() then
				return nil, g.core.lang:get(1049)
			end

			var_26_0 = ModuleEntrance.GVE_HALIDOM_LAYER
		elseif arg_26_1.route_value_1 == 2 then
			if not g.core.model.User.gveDataMgr:isInFormalStage() then
				return nil, g.core.lang:get(1049)
			end

			var_26_0 = ModuleEntrance.GVE_FORMATION_SELECT_KNIGHT
		elseif arg_26_1.route_value_1 == 3 then
			if not g.core.model.User.gveDataMgr:isInFormalStage() then
				return nil, g.core.lang:get(1049)
			end

			var_26_0 = ModuleEntrance.GVE_TASK
		elseif arg_26_1.route_value_1 == 4 then
			var_26_0 = ModuleEntrance.GVE_SHOP
		elseif arg_26_1.route_value_1 == 5 then
			if not g.core.model.User.gveDataMgr:isInFormalStage() then
				return nil, g.core.lang:get(1049)
			end

			var_26_0 = ModuleEntrance.GVE_RESEARCH
		end
	elseif arg_26_1.route_type == ModuleEntrance.PET_DEVELOP.routeType then
		if not g.core.model.User.petsData:isTherePetLineup() then
			var_26_0 = ModuleEntrance.LINE_UP_PET
		end
	elseif arg_26_1.route_type == 2084 then
		if not g.core.model.User.activityMonthGachaData:isActOpen() then
			return g.core.module.ModuleManager:tip(g.core.lang:get(408105))
		end

		var_26_0 = arg_26_1.route_value_1 == 1 and g.view.entrance.RECHARGE or arg_26_1.route_value_1 == 2 and g.view.entrance.ACTIVITY or g.view.entrance.ACTIVITY
	elseif arg_26_1.route_type == ModuleEntrance.HALF_ANNIVERSARY.routeType then
		if not g.core.model.User.halfAnniversaryData:isActivityOpen() then
			return nil, g.core.lang:get(1049)
		end
	elseif arg_26_1.route_type == ModuleEntrance.EXPLORATION.routeType then
		if not g.core.model.User.explorationData:isInActiveTime() then
			g.core.module.ModuleManager:tip(g.core.lang:get(420450))

			return
		end
	elseif arg_26_1.route_type == 2501 then
		if not g.core.model.User.teamPvpData:isActivityOpen() then
			g.core.module.ModuleManager:tip(g.core.lang:get(420450))

			return
		end
	elseif arg_26_1.route_type == 5200004 then
		if not g.core.model.User.crossServerArenaData:isCrossServerArenaCanRoute() then
			return nil, g.core.lang:get(411014)
		end
	elseif arg_26_1.route_type == ModuleEntrance.COMMANDER_WORLD.routeType then
		if not g.core.model.User.commanderWorldData:checkActivityOpen() then
			return nil, g.core.lang:get(410322)
		end
	elseif arg_26_1.route_type == ModuleEntrance.RED_CLIFF_MAIN_LAYER.routeType then
		if not g.core.model.User.redCliffData:isActivityOpen() then
			return nil, g.core.lang:get(421118)
		end
	elseif arg_26_1.route_type == 2035 then
		if arg_26_1.route_value_1 == 4 then
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.BIO_MAIN) then
				return g.view.entrance.GAME_ENTERTAINMENT
			else
				return nil
			end
		end
	elseif arg_26_1.route_type == 72 then
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return nil
	elseif arg_26_1.route_type == 2093 then
		if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.WEEKLY_COMPETITION) then
			return g.view.entrance.WEEKLY_COMPETITION
		else
			return nil
		end
	elseif arg_26_1.route_type == ModuleEntrance.CULTIVATE_MAIN.routeType then
		local var_26_14 = g.core.model.User.cultivateDataMgr:getCultivateData(arg_26_1.route_value_1)

		if not var_26_14 or not var_26_14:isInActivityShowTime() then
			if arg_26_1.route_value_1 == 2 and arg_26_1.route_value_2 == 4 and arg_26_1.route_value_3 == 0 then
				return ModuleEntrance.RECRUIT_ACT_UNITE_TOKEN
			elseif arg_26_1.route_value_2 ~= 0 and not var_26_14:isInNormalOpenTime() then
				return nil
			else
				return nil
			end
		end

		if arg_26_1.route_value_2 == 0 then
			return ModuleEntrance.CULTIVATE_MAIN
		elseif arg_26_1.route_value_2 == 1 then
			if not var_26_14:isWitchActivity() then
				return ModuleEntrance.CULTIVATE_SHOP
			else
				return ModuleEntrance.CULTIVATE_WITCH_SHOP
			end
		elseif arg_26_1.route_value_2 == 2 then
			if not var_26_14:isWitchActivity() then
				return ModuleEntrance.CULTIVATE_TASK
			else
				return ModuleEntrance.CULTIVATE_WITCH_TASK
			end
		elseif arg_26_1.route_value_2 == 3 then
			if var_26_14:isPassCardOpen() then
				if not var_26_14:isWitchActivity() then
					return ModuleEntrance.CULTIVATE_PASSCARD
				else
					return ModuleEntrance.CULTIVATE_WITCH_PASSCARD
				end
			elseif not var_26_14:isWitchActivity() then
				return ModuleEntrance.CULTIVATE_PASSCARD_PREVIEW
			else
				return ModuleEntrance.CULTIVATE_WITCH_PASSCARD_PREVIEW
			end
		elseif arg_26_1.route_value_2 == 4 then
			if not var_26_14:isInNormalOpenTime() then
				return nil
			end

			return ModuleEntrance.RECRUIT_ACT_UNITE_TOKEN
		elseif arg_26_1.route_value_2 == 5 then
			return ModuleEntrance.CULTIVATE_GIFT
		elseif arg_26_1.route_value_2 == 6 then
			g.core.model.User.monopolyDataMgr:setCurOpenActId(arg_26_1.route_value_1)

			return ModuleEntrance.MONOPOLY_STAGE
		end
	elseif arg_26_1.route_type == ModuleEntrance.ACTIVITY_RETURN.routeType then
		if arg_26_1.route_value_1 == 0 then
			return ModuleEntrance.ACTIVITY_RETURN
		elseif arg_26_1.route_value_1 == 1 then
			return ModuleEntrance.ACTIVITY_RETURN
		end
	elseif arg_26_1.route_type == ModuleEntrance.BOUNTY_MAIN.routeType then
		if g.core.model.User.bountyData:getCurStage() == g.core.const.ConstMgr.BountyConst.ACTIVITY_STATE.RESULT then
			return ModuleEntrance.BOUNTY_PERIOD
		else
			return ModuleEntrance.BOUNTY_MAIN
		end
	elseif arg_26_1.route_type == ModuleEntrance.ALLIANCE.routeType then
		if not g.core.model.User.guildData:hasGuild() then
			return nil, g.core.lang:get(428509)
		end
	elseif arg_26_1.route_type == ModuleEntrance.ANNIVERSARY_MAIN_LAYER.routeType then
		local var_26_15 = g.core.module.ModuleManager:getCurModule().module

		if var_26_15.previous then
			if var_26_15.previous.routeType == 3801 then
				return nil, g.core.lang:get(1143)
			end
		else
			local var_26_16 = g.core.module.ModuleManager:getCurRootModule() or {}

			if var_26_16.previous and var_26_16.previous.routeType == 3801 then
				return nil, g.core.lang:get(1143)
			end
		end

		if not g.core.model.User.anniversaryData:isActivityOpen() then
			return nil, g.core.lang:get(1049)
		end
	elseif arg_26_1.route_type == ModuleEntrance.ELDERBOSS_MAIN_LAYER.routeType then
		if g.core.model.User.elderBossData:getCurStage() == g.core.const.ConstMgr.ElderBossConst.STAGE.GAME then
			if not (g.core.model.User.elderBossData:isChooseBuff() or false) then
				return ModuleEntrance.ELDERBOSS_CHOOSE_BUFF_LAYER
			else
				return ModuleEntrance.ELDERBOSS_MAIN_LAYER
			end
		else
			return ModuleEntrance.ELDERBOSS_RESULT_LAYER
		end
	elseif arg_26_1.route_type == 6601 then
		if arg_26_1.route_value_1 == 0 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_JUMP_TO_POS, false, 0, {
				pos = cc.p(arg_26_1.route_value_2, arg_26_1.route_value_3)
			})
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_JUMP_TO_BUILD, false, 0, {
				buildType = arg_26_1.route_value_1
			})
		end

		local var_26_17 = g.core.module.ModuleManager:getCurModule()

		if var_26_17 and var_26_17.module == g.view.entrance.OUT_POST_STAGE then
			g.core.module.ModuleManager:popAllPopup()
		else
			return ModuleEntrance.OUT_POST_STAGE
		end

		return nil
	elseif arg_26_1.route_type == 6602 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_OPEN_KNIGHT_COMP)

		return nil
	elseif arg_26_1.route_type == 6603 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_TIPS_ITEM)

		return nil
	elseif arg_26_1.route_type == 6607 then
		if not g.core.model.User.ancientsData:isTimeToOpen() then
			g.core.module.ModuleManager:tip(g.core.lang:get(307536))

			return
		end

		return g.core.utils.Tools.ancientsFunc.getNeedOpenModule()
	elseif arg_26_1.route_type == 10001 then
		g.core.service.ServiceManager:getServiceByName("GuideService"):enterOldGuideState()

		return nil
	end

	assert(var_26_0, "Invalid routeType id: " .. tostring(arg_26_1.route_type) .. ",please check routeType first")

	return var_26_0
end

function ModuleGotoProxy:_isOpenAfterJoinGuild(arg_27_1)
	return arg_27_1 == ModuleEntrance.GUILD_MAIN.routeType or arg_27_1 == ModuleEntrance.GUILD_DUNGEON.routeType or arg_27_1 == ModuleEntrance.GUILD_TASK.routeType or arg_27_1 == ModuleEntrance.GUILD_RED_PACKET.routeType or arg_27_1 == ModuleEntrance.GUILD_BOSS.routeType or arg_27_1 == ModuleEntrance.GUILD_WAR.routeType
end

return ModuleGotoProxy
