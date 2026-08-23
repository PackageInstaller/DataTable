local KsMath = require("app.core.utils.KsMath")
local var_0_1 = g.core.model.User.activityDataManager
local var_0_2 = g.core.const.ConstMgr.ActivityConst
local var_0_3 = g.core.common.ModuleUnlock
local var_0_4 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_5 = g.core.const.ConstMgr
local var_0_6 = g.core.const.ConstMgr.ThemeConst
local var_0_7 = g.core.model.User.shopData
local var_0_8 = g.core.const.ConstMgr.SoundConst
local var_0_9 = g.core.common.Goods
local ThemeEntranceActivityData = require("app.view.module.summerTheme.model.ThemeEntranceActivityData")
local ThemeDataMgr = class("ThemeDataMgr")

function ThemeDataMgr:ctor()
	self:initData()
end

function ThemeDataMgr:initData()
	self._uiRefActiveData = nil
	self._themeDataDict = {}
	self._checkBossTimeDict = {}
	self._refRedPointData = nil
	self._isStartUp = nil
	self._openExtraDropTypes = nil
	self._moduleDropGoodsDict = nil
end

function ThemeDataMgr:startAllOpenTheme(arg_3_1)
	self._isStartUp = true

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		local var_3_0 = iter_3_1:getConfigActivityValue()

		self:_registerThemeActiveData(iter_3_1:getActivityType(), var_3_0)

		local var_3_1 = self:getThemeData(var_3_0)

		if var_3_1 then
			var_3_1:startThemeData(iter_3_1)
		end
	end

	if self._refRedPointData then
		self:_mergeRedPoint2ThemeData(self._refRedPointData)

		self._refRedPointData = nil
	end

	self:_calcAllThemeDropInfo(arg_3_1)
end

function ThemeDataMgr:getThemeData(arg_4_1)
	return self._themeDataDict[arg_4_1]
end

function ThemeDataMgr:updatePassCardTaskData(arg_5_1)
	for iter_5_0, iter_5_1 in pairs(self._themeDataDict) do
		local var_5_0 = iter_5_1:getPassCardData()

		if var_5_0 then
			var_5_0:updateActions(arg_5_1)
		end
	end
end

function ThemeDataMgr:getUIRefActiveData()
	return self._uiRefActiveData
end

function ThemeDataMgr:getThemeDropByModule(arg_7_1)
	return self._moduleDropGoodsDict and self._moduleDropGoodsDict[arg_7_1]
end

function ThemeDataMgr:isActivityItem(arg_8_1)
	if self._activityItemMap then
		return self._activityItemMap[arg_8_1]
	end

	self._activityItemMap = {}

	for iter_8_0 = 1, g.core.config.extra_drop_info.getLength() do
		self._activityItemMap[g.core.config.extra_drop_info.indexOf(iter_8_0).reward_value] = true
	end

	return self._activityItemMap[arg_8_1]
end

function ThemeDataMgr:isMetUnlockAdditionalConditions()
	if g.core.common.ServerTime:getOpenDays() >= g.core.config.parameter_info.get(var_0_6.UNLOCK_OPEN_DAY_KEY).parameter then
		return var_0_3:isModuleShow(var_0_4.SUMMER_ACTIVITY)
	end
end

function ThemeDataMgr:getThemeActivityDataList()
	local var_10_1 = var_0_1:getActivityDataListByFilter(function(arg_11_0)
		if arg_11_0:getActivityType() == var_0_2.ACTIVITY_TYPE.SUMMER_ACTIVITY and var_0_3:isModuleShow(var_0_4.SUMMER_ACTIVITY) then
			local var_11_0 = arg_11_0:getInfo()

			return arg_11_0:isShow() and not g.core.model.User.homeData:isCensorTheme(var_11_0.sub_activity_id or var_11_0.activity_value)
		end
	end)

	if #var_10_1 > 1 then
		table.sort(var_10_1, function(arg_12_0, arg_12_1)
			local var_12_0 = arg_12_0:getConfigActivityValue()
			local var_12_1 = arg_12_1:getConfigActivityValue()

			if var_12_0 ~= var_12_1 then
				return var_12_0 < var_12_1
			end

			return false
		end)
	end

	return var_10_1
end

function ThemeDataMgr:getThemeMergeBaseValue(arg_13_1)
	return (var_0_6.THEME_RES_KEY_ALIAS or {})[arg_13_1] or arg_13_1
end

function ThemeDataMgr:getThemeMergeConfigValueList(arg_14_1)
	local var_14_0 = self:getThemeMergeBaseValue(arg_14_1)
	local var_14_1 = {
		var_14_0
	}

	for iter_14_0, iter_14_1 in ipairs(var_0_6.THEME_RES_ALIAS_GROUP[var_14_0] or {}) do
		table.insert(var_14_1, iter_14_1)
	end

	table.sort(var_14_1)

	return var_14_1
end

function ThemeDataMgr:getThemeMergeConfigValuesByThreeActivity(arg_15_1)
	if not arg_15_1 or arg_15_1 == 0 then
		return {}
	end

	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(self._themeDataDict) do
		local var_15_1 = iter_15_1:getTaskData()

		if var_15_1 and var_15_1:getThreeActivityId() == arg_15_1 then
			table.insert(var_15_0, iter_15_0)
		end
	end

	return var_15_0
end

function ThemeDataMgr:_buildThemeMergeGroup(arg_16_1)
	local var_16_0 = {}
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1 or {}) do
		local var_16_2 = self:getThemeMergeBaseValue((iter_16_1:getConfigActivityValue()))
		local var_16_3 = var_16_0[var_16_2]

		if not var_16_0[var_16_2] then
			var_16_3 = {}
			var_16_0[var_16_2] = var_16_3

			table.insert(var_16_1, var_16_2)
		end

		table.insert(var_16_3, iter_16_1)
	end

	for iter_16_2, iter_16_3 in ipairs(var_16_1) do
		table.sort(var_16_0[iter_16_3], function(arg_17_0, arg_17_1)
			local var_17_0 = arg_17_0:getStartTime() or 0
			local var_17_1 = arg_17_1:getStartTime() or 0

			if var_17_0 ~= var_17_1 then
				return var_17_0 < var_17_1
			end

			return arg_17_0:getConfigActivityValue() < arg_17_1:getConfigActivityValue()
		end)
	end

	return var_16_0, var_16_1
end

function ThemeDataMgr:getThemeMergeActivityDataList(arg_18_1)
	return self:_buildThemeMergeGroup((self:getThemeActivityDataList()))[self:getThemeMergeBaseValue(arg_18_1)] or {}
end

function ThemeDataMgr:_getAllConfigActivityDataArr(arg_19_1)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs((self:getThemeMergeConfigValueList(arg_19_1))) do
		local var_19_1 = var_0_1:getActivityData(var_0_2.ACTIVITY_TYPE.SUMMER_ACTIVITY, iter_19_1)

		if var_19_1 then
			table.insert(var_19_0, var_19_1)
		end
	end

	return var_19_0
end

function ThemeDataMgr:getThemeMergeEntranceActivityData(arg_20_1)
	local var_20_0 = self:getThemeMergeBaseValue(arg_20_1)
	local var_20_1 = self:_getAllConfigActivityDataArr(var_20_0)

	if #var_20_1 == 0 then
		var_20_1 = self:getThemeMergeActivityDataList(var_20_0)
	end

	return ThemeEntranceActivityData.new(var_20_0, var_20_1)
end

function ThemeDataMgr:getThemeEntranceActivityDataList()
	local var_21_0, var_21_1 = self:_buildThemeMergeGroup((self:getThemeActivityDataList()))
	local var_21_2 = {}

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		local var_21_3 = self:_getAllConfigActivityDataArr(iter_21_1)

		if #var_21_3 == 0 then
			var_21_3 = var_21_0[iter_21_1]
		end

		table.insert(var_21_2, ThemeEntranceActivityData.new(iter_21_1, var_21_3))
	end

	table.sort(var_21_2, function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0:getStartTime() or 0
		local var_22_1 = arg_22_1:getStartTime() or 0

		if var_22_0 ~= var_22_1 then
			return var_22_0 < var_22_1
		end

		return arg_22_0:getConfigActivityValue() < arg_22_1:getConfigActivityValue()
	end)

	return var_21_2
end

function ThemeDataMgr:checkBossChallengeTime()
	local var_23_0 = table.concat({
		...
	}, "_")
	local var_23_1 = self._checkBossTimeDict[var_23_0] or 0
	local var_23_2 = g.core.common.ServerTime:getTime()

	if var_23_1 <= var_23_2 then
		self._checkBossTimeDict[var_23_0] = var_23_2 + 1
	else
		return false
	end

	return true
end

function ThemeDataMgr:_registerThemeActiveData(arg_24_1, arg_24_2)
	if self._themeDataDict[arg_24_2] then
		return
	end

	if g.core.model.User.homeData:isCensorTheme(arg_24_2) then
		return
	end

	self._themeDataDict[arg_24_2] = require("app.view.module.summerTheme.model.SummerThemeData").new(arg_24_1, arg_24_2)
end

function ThemeDataMgr:startOpenUIByActiveData(arg_25_1)
	self._uiRefActiveData = arg_25_1
end

function ThemeDataMgr:getActivityData(arg_26_1)
	for iter_26_0, iter_26_1 in ipairs((self:getThemeActivityDataList())) do
		if iter_26_1:getConfigActivityValue() == arg_26_1 then
			return iter_26_1
		end
	end

	return nil
end

function ThemeDataMgr:onS2CFlushRedPoint(arg_27_1)
	self:_mergeRedPoint2ThemeData(arg_27_1.theme_hint or {})
end

function ThemeDataMgr:_mergeRedPoint2ThemeData(arg_28_1)
	if not self._isStartUp and next(arg_28_1) then
		self._refRedPointData = arg_28_1

		return
	end

	for iter_28_0, iter_28_1 in pairs(arg_28_1) do
		local var_28_0 = self:getThemeData(iter_28_1.activity_id)

		if var_28_0 then
			var_28_0:refreshRedPointData(iter_28_1)
		end
	end
end

function ThemeDataMgr:hasNewChapterOpen(arg_29_1)
	if arg_29_1.activityValues and #arg_29_1.activityValues > 1 then
		for iter_29_0, iter_29_1 in ipairs(arg_29_1.activityValues) do
			local var_29_0 = self:getActivityData(iter_29_1)

			if var_29_0 and var_29_0:getActivityState() == var_0_2.ACTIVITY_STATE.START then
				local var_29_1 = self:getThemeData(iter_29_1)

				if var_29_1 and var_29_1:isThemeActiveOpen() then
					if var_29_1:getDungeonData():redCheckNewChapterOpen(arg_29_1) then
						return true
					end
				end
			end
		end

		return false
	end

	local var_29_2 = self:getThemeData(arg_29_1.themeValue)

	if not var_29_2 or not var_29_2:isThemeActiveOpen() then
		return false
	end

	return var_29_2:getDungeonData():redCheckNewChapterOpen(arg_29_1)
end

function ThemeDataMgr:hasNewShopCanBuy(arg_30_1)
	if arg_30_1.scoreInfo then
		if arg_30_1.scoreInfo.shop_type ~= var_0_6.THEME_TYPE then
			return false
		end

		if arg_30_1.scoreInfo.buy_ban_type > 1 or arg_30_1.scoreInfo.buy_ban_value > 1 then
			local var_30_0 = var_0_7:getBuyLimitLeft(arg_30_1.scoreInfo)

			if var_30_0 and var_30_0 == 0 then
				return false
			end

			if self:_checkShopScoreNewOpen(arg_30_1.scoreInfo) then
				return true
			end
		end
	else
		if (arg_30_1.shopType or 0) ~= var_0_6.THEME_TYPE then
			return false
		end

		for iter_30_0, iter_30_1 in ipairs((arg_30_1.activityValues and #arg_30_1.activityValues > 1 or nil) and (arg_30_1.activityValues or {
			arg_30_1.themeValue
		})) do
			local var_30_2 = self:getActivityData(iter_30_1)

			if var_30_2 and var_30_2:getActivityState() == var_0_2.ACTIVITY_STATE.START then
				local var_30_3 = var_0_7:getUnSortInfo(var_0_6.THEME_TYPE, iter_30_1)

				if var_30_3 then
					for iter_30_2, iter_30_3 in pairs(var_30_3) do
						if (iter_30_3.buy_ban_type > 1 or iter_30_3.buy_ban_value > 1) and self:_checkShopScoreNewOpen(iter_30_3) then
							return true
						end
					end
				end
			end
		end
	end

	return false
end

function ThemeDataMgr:_checkShopScoreNewOpen(arg_31_1)
	if var_0_7:checkBuyBan(arg_31_1) then
		return false
	end

	if KsMath.transitionNeedPlayOnce("theme_shop_score_open_" .. arg_31_1.id) then
		return true
	end

	return false
end

function ThemeDataMgr:redDoNewShopScoreOpen(arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = var_0_7:getUnSortInfo(arg_32_1, arg_32_2)

	if not var_32_0 then
		return false
	end

	for iter_32_0, iter_32_1 in pairs(var_32_0) do
		if (iter_32_1.buy_ban_type > 1 or iter_32_1.buy_ban_value > 1) and self:_checkShopScoreNewOpen(iter_32_1) then
			KsMath.transitionPlayOnceSet("theme_shop_score_open_" .. iter_32_1.id)
		end
	end
end

function ThemeDataMgr:hasNewThemeShopOpen(arg_33_1)
	for iter_33_0, iter_33_1 in ipairs((arg_33_1.activityValues and #arg_33_1.activityValues > 1 or nil) and (arg_33_1.activityValues or {
		arg_33_1.themeValue
	})) do
		local var_33_0 = self:getActivityData(iter_33_1)

		if var_33_0 and var_33_0:getActivityState() == var_0_2.ACTIVITY_STATE.START and KsMath.transitionNeedPlayOnce("theme_shop_open_" .. var_0_6.THEME_TYPE .. "_" .. iter_33_1) then
			return true
		end
	end

	return false
end

function ThemeDataMgr:redDoNewThemeShopOpen(arg_34_1)
	if KsMath.transitionNeedPlayOnce("theme_shop_open_" .. var_0_6.THEME_TYPE .. "_" .. arg_34_1) then
		KsMath.transitionPlayOnceSet("theme_shop_open_" .. var_0_6.THEME_TYPE .. "_" .. arg_34_1)
	end
end

function ThemeDataMgr:hasNewBossPhaseOpen(arg_35_1)
	if arg_35_1.activityValues and #arg_35_1.activityValues >= 1 then
		for iter_35_0, iter_35_1 in ipairs(arg_35_1.activityValues) do
			local var_35_0 = self:getActivityData(iter_35_1)

			if var_35_0 and var_35_0:getActivityState() == var_0_2.ACTIVITY_STATE.START then
				local var_35_1 = self:getThemeData(iter_35_1)

				if var_35_1 then
					if var_35_1:getBossData():redCheckBossNewPhase() then
						return true
					end
				end
			end
		end

		return false
	end

	local var_35_2 = self:getThemeData(arg_35_1.themeValue)

	if not var_35_2 then
		return false
	end

	return var_35_2:getBossData():redCheckBossNewPhase()
end

function ThemeDataMgr:bossChallengeCountIsFull(arg_36_1)
	if arg_36_1.activityValues and #arg_36_1.activityValues >= 1 then
		for iter_36_0, iter_36_1 in ipairs(arg_36_1.activityValues) do
			local var_36_0 = self:getActivityData(iter_36_1)

			if var_36_0 and var_36_0:getActivityState() == var_0_2.ACTIVITY_STATE.START then
				local var_36_1 = self:getThemeData(iter_36_1)

				if var_36_1 then
					if var_36_1:getBossData():redCheckBossChallengeCount() then
						return true
					end
				end
			end
		end

		return false
	end

	local var_36_2 = self:getThemeData(arg_36_1.themeValue)

	if not var_36_2 then
		return false
	end

	return var_36_2:getBossData():redCheckBossChallengeCount()
end

function ThemeDataMgr:hasBossScoreAward(arg_37_1)
	if arg_37_1.activityValues and #arg_37_1.activityValues >= 1 then
		for iter_37_0, iter_37_1 in ipairs(arg_37_1.activityValues) do
			local var_37_0 = self:getActivityData(iter_37_1)

			if var_37_0 and var_37_0:getActivityState() == var_0_2.ACTIVITY_STATE.START then
				local var_37_1 = self:getThemeData(iter_37_1)

				if var_37_1 then
					if var_37_1:getBossData():redCheckBossHasAwardCanGet(arg_37_1) then
						return true
					end
				end
			end
		end

		return false
	end

	local var_37_2 = self:getThemeData(arg_37_1.themeValue)

	if not var_37_2 then
		return false
	end

	return var_37_2:getBossData():redCheckBossHasAwardCanGet(arg_37_1)
end

function ThemeDataMgr:hasNewTaskHonourCanGet(arg_38_1)
	if arg_38_1.activityValues and #arg_38_1.activityValues > 1 then
		for iter_38_0, iter_38_1 in ipairs(arg_38_1.activityValues) do
			local var_38_0 = self:getActivityData(iter_38_1)

			if var_38_0 and var_38_0:getActivityState() == var_0_2.ACTIVITY_STATE.START then
				local var_38_1 = self:getThemeData(iter_38_1)

				if var_38_1 and var_38_1:isThemeActiveOpen() then
					if var_38_1:getTaskData():redCheckHonourTaskCanGet() then
						return true
					end
				end
			end
		end

		return false
	end

	local var_38_2 = self:getThemeData(arg_38_1.themeValue)

	if not var_38_2 or not var_38_2:isThemeActiveOpen() then
		return false
	end

	return var_38_2:getTaskData():redCheckHonourTaskCanGet()
end

function ThemeDataMgr:hasNewTaskDayCanGet(arg_39_1)
	local var_39_0 = arg_39_1.themeValue

	if arg_39_1.activityValues and #arg_39_1.activityValues > 1 then
		for iter_39_0, iter_39_1 in ipairs(arg_39_1.activityValues) do
			local var_39_1 = self:getActivityData(iter_39_1)

			if var_39_1 and var_39_1:getActivityState() == var_0_2.ACTIVITY_STATE.START then
				var_39_0 = iter_39_1
			end
		end
	end

	local var_39_2 = self:getThemeData(var_39_0)

	if not var_39_2 or not var_39_2:isThemeActiveOpen() then
		return false
	end

	return var_39_2:getTaskData():redCheckDayTaskCanGet()
end

function ThemeDataMgr:hasNewBoxCanGet(arg_40_1)
	if arg_40_1.activityValues and #arg_40_1.activityValues > 1 then
		for iter_40_0, iter_40_1 in ipairs(arg_40_1.activityValues) do
			local var_40_0 = self:getActivityData(iter_40_1)

			if var_40_0 and var_40_0:getActivityState() == var_0_2.ACTIVITY_STATE.START then
				local var_40_1 = self:getThemeData(iter_40_1)

				if var_40_1 and var_40_1:isThemeActiveOpen() then
					if var_40_1:getDungeonData():checkDungeonBoxCanGet(arg_40_1) then
						return true
					end
				end
			end
		end

		return false
	end

	local var_40_2 = self:getThemeData(arg_40_1.themeValue)

	if not var_40_2 or not var_40_2:isThemeActiveOpen() then
		return false
	end

	return var_40_2:getDungeonData():checkDungeonBoxCanGet(arg_40_1)
end

function ThemeDataMgr:hasTurnCardAwardCanGet(arg_41_1)
	local var_41_0 = self:getThemeData(arg_41_1.themeValue)

	if not var_41_0 or not var_41_0:isThemeActiveOpen() then
		return false
	end

	local var_41_1 = var_41_0:getTurnCardData()
	local var_41_2 = g.core.common.ServerTime:getTime()

	if var_41_2 < var_41_1:getTurnCardStartTime() then
		return false
	elseif var_41_1:getTurnCardEndTime() < var_41_2 then
		return false
	end

	return not var_41_0:getTurnCardData():isGetTurnCardAwards(arg_41_1)
end

function ThemeDataMgr:hasTurnCardNewPhase(arg_42_1)
	local var_42_0 = self:getThemeData(arg_42_1.themeValue)

	if not var_42_0 or not var_42_0:isThemeActiveOpen() then
		return false
	end

	local var_42_1 = var_42_0:getTurnCardData()
	local var_42_2 = g.core.common.ServerTime:getTime()

	if var_42_2 < var_42_1:getTurnCardStartTime() then
		return false
	elseif var_42_1:getTurnCardEndTime() < var_42_2 then
		return false
	end

	return var_42_1:isHaveTurnCardNewPhase(arg_42_1)
end

function ThemeDataMgr:hasGemEliminateAwardCanGet(arg_43_1)
	local var_43_0 = self:getThemeData(arg_43_1.themeValue)

	if not var_43_0 or not var_43_0:isThemeActiveOpen() then
		return false
	end

	local var_43_1 = var_43_0:getGemEliminateData()
	local var_43_2 = g.core.common.ServerTime:getTime()

	if var_43_2 < var_43_1:getGemEliminateStartTime() then
		return false
	elseif var_43_1:getGemEliminateEndTime() < var_43_2 then
		return false
	end

	return not var_43_1:isGetTodayReward()
end

function ThemeDataMgr:hasGemEliminateNewPhase(arg_44_1)
	local var_44_0 = self:getThemeData(arg_44_1.themeValue)

	if not var_44_0 or not var_44_0:isThemeActiveOpen() then
		return false
	end

	local var_44_1 = var_44_0:getGemEliminateData()
	local var_44_2 = g.core.common.ServerTime:getTime()

	if var_44_2 < var_44_1:getGemEliminateStartTime() then
		return false
	elseif var_44_1:getGemEliminateEndTime() < var_44_2 then
		return false
	end

	return var_44_1:isHaveGemEliminateNewPhase(arg_44_1)
end

function ThemeDataMgr:hasNewExploreChapter(arg_45_1)
	local var_45_0 = self:getThemeData(arg_45_1.themeValue)

	if not var_45_0 or not var_45_0:isThemeActiveOpen() then
		return false
	end

	return var_45_0:getExploreData():checkHasNewChapter(arg_45_1)
end

function ThemeDataMgr:isHaveProgAwardCanGet(arg_46_1)
	local var_46_0 = self:getThemeData(arg_46_1.themeValue)

	if not var_46_0 then
		return false
	end

	return var_46_0:getTurnTableData():isHaveProgAwardCanGet()
end

function ThemeDataMgr:isHaveFiveTurnRes(arg_47_1)
	local var_47_0 = self:getThemeData(arg_47_1.themeValue)

	if not var_47_0 then
		return false
	end

	return var_47_0:getTurnTableData():isHaveFiveTurnRes()
end

function ThemeDataMgr:hasNewGuessPhase(arg_48_1)
	local var_48_0 = self:getThemeData(arg_48_1.themeValue)

	if not var_48_0 or not var_48_0:isThemeActiveOpen() then
		return false
	end

	local var_48_1 = var_48_0:getThemeGuessData()
	local var_48_2 = g.core.common.ServerTime:getTime()

	if var_48_2 < var_48_1:getGuessStartTime() then
		return false
	elseif var_48_1:getGuessEndTime() < var_48_2 then
		return false
	end

	return var_48_1:hasNewPhase()
end

function ThemeDataMgr:hasGuessPhaseDailyReward(arg_49_1)
	local var_49_0 = self:getThemeData(arg_49_1.themeValue)

	if not var_49_0 or not var_49_0:isThemeActiveOpen() then
		return false
	end

	local var_49_1 = var_49_0:getThemeGuessData()
	local var_49_2 = g.core.common.ServerTime:getTime()

	if var_49_2 < var_49_1:getGuessStartTime() then
		return false
	elseif var_49_1:getGuessEndTime() < var_49_2 then
		return false
	end

	return not var_49_1:hasGotAwards()
end

function ThemeDataMgr:hasPuzzleNewPhase(arg_50_1)
	local var_50_0 = self:getThemeData(arg_50_1.themeValue)

	if not var_50_0 or not var_50_0:isThemeActiveOpen() then
		return false
	end

	local var_50_1 = var_50_0:getThemePuzzleData()
	local var_50_2 = g.core.common.ServerTime:getTime()

	if var_50_2 < var_50_1:getPuzzleStartTime() then
		return false
	elseif var_50_1:getPuzzleEndTime() < var_50_2 then
		return false
	end

	return var_50_1:hasNewPhase(arg_50_1)
end

function ThemeDataMgr:hasPuzzleAwardCanGet(arg_51_1)
	local var_51_0 = self:getThemeData(arg_51_1.themeValue)

	if not var_51_0 or not var_51_0:isThemeActiveOpen() then
		return false
	end

	local var_51_1 = var_51_0:getThemePuzzleData()
	local var_51_2 = g.core.common.ServerTime:getTime()

	if var_51_2 < var_51_1:getPuzzleStartTime() then
		return false
	elseif var_51_1:getPuzzleEndTime() < var_51_2 then
		return false
	end

	return not var_51_1:hasGotAwards()
end

function ThemeDataMgr:hasNewThemeBioChapter(arg_52_1)
	local var_52_0 = self:getThemeData(arg_52_1.themeValue)

	if not var_52_0 or not var_52_0:isThemeActiveOpen() then
		return false
	end

	local var_52_1 = var_52_0:getThemeBioData()
	local var_52_2 = false

	for iter_52_0, iter_52_1 in ipairs(arg_52_1.ids or var_52_1:getChapterIds() or {}) do
		var_52_2 = var_52_1:isThemeBioChapterNew({
			id = iter_52_1
		})

		if var_52_2 then
			break
		end
	end

	return var_52_2
end

function ThemeDataMgr:hasNewThemeBioItem(arg_53_1)
	if not arg_53_1 or not arg_53_1.themeValue then
		return false
	end

	local var_53_0 = self:getThemeData(arg_53_1.themeValue)

	if not var_53_0 or not var_53_0:isThemeActiveOpen() then
		return false
	end

	return (var_53_0:getThemeBioData():hasNewBioItem(arg_53_1))
end

function ThemeDataMgr:hasGiftCanReceive(arg_54_1)
	if arg_54_1 and arg_54_1.themeValue then
		local var_54_0 = self:getThemeData(arg_54_1.themeValue)
		local var_54_1, var_54_2

		if not var_54_0 or not var_54_0:isThemeActiveOpen() then
			do return false end

			var_54_1, var_54_2 = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.GIFT, function(arg_55_0)
				return arg_54_1.themeValue == arg_55_0.activity_id
			end
		end

		local var_54_3 = g.core.model.User.giftData:getGiftListByShopTypeValue(var_54_1, g.core.const.ConstMgr.ShopConst.SHOP_GIFT_VALUE.THEME_GIFT, var_54_2)

		var_54_3 = var_54_3 or {}

		for iter_54_0, iter_54_1 in ipairs(var_54_3) do
			if g.core.model.User.giftData:isCanReceiveFreeGift({
				id = iter_54_1.id
			}) then
				return true
			end
		end
	elseif arg_54_1.id then
		return g.core.model.User.giftData:isCanReceiveFreeGift({
			id = arg_54_1.id
		})
	end

	return false
end

function ThemeDataMgr:hasFreePassCardAward(arg_56_1)
	if arg_56_1 and arg_56_1.activityValues and #arg_56_1.activityValues > 1 then
		local var_56_0 = g.core.common.ServerTime:getTime()

		for iter_56_0, iter_56_1 in ipairs(arg_56_1.activityValues) do
			local var_56_1 = self:getThemeData(iter_56_1)
			local var_56_2 = self:getActivityData(iter_56_1)

			if var_56_1 and var_56_2 and var_56_0 < var_56_2:getExpireTime() then
				local var_56_3 = var_56_1:getPassCardData()

				if var_56_3 and var_56_3:canGetAward(arg_56_1.id) then
					return true
				end
			end
		end

		return false
	end

	if arg_56_1 and arg_56_1.themeValue then
		local var_56_4 = self:getThemeData(arg_56_1.themeValue)
		local var_56_5 = self:getActivityData(arg_56_1.themeValue)

		if not var_56_4 or not var_56_5 or g.core.common.ServerTime:getTime() >= var_56_5:getExpireTime() then
			return false
		end

		if not var_56_4:getPassCardData() then
			return false
		end

		return var_56_4:getPassCardData():canGetAward(arg_56_1.id)
	end

	return false
end

function ThemeDataMgr:hasTalentNewRed(arg_57_1)
	if arg_57_1 and arg_57_1.activityValues and #arg_57_1.activityValues >= 1 then
		for iter_57_0, iter_57_1 in ipairs(arg_57_1.activityValues) do
			local var_57_0 = self:getActivityData(iter_57_1)

			if var_57_0 and var_57_0:getActivityState() == var_0_2.ACTIVITY_STATE.START then
				local var_57_1 = self:getThemeData(iter_57_1)

				if var_57_1 then
					local var_57_2 = var_57_1:getBossData()

					if var_57_2.isThirdBoss and var_57_2:isThirdBoss() and not var_57_2:isTalentRedTodayRecord() then
						return true
					end
				end
			end
		end

		return false
	end

	if arg_57_1 and arg_57_1.themeValue and self:getThemeData(arg_57_1.themeValue) then
		local var_57_3 = self:getThemeData(arg_57_1.themeValue):getBossData()

		if var_57_3.isThirdBoss then
			return var_57_3:isThirdBoss() and not var_57_3:isTalentRedTodayRecord()
		end
	end

	return false
end

function ThemeDataMgr:hasTalentRed(arg_58_1)
	if arg_58_1 and arg_58_1.activityValues and #arg_58_1.activityValues >= 1 then
		for iter_58_0, iter_58_1 in ipairs(arg_58_1.activityValues) do
			local var_58_0 = self:getActivityData(iter_58_1)

			if var_58_0 and var_58_0:getActivityState() == var_0_2.ACTIVITY_STATE.START then
				local var_58_1 = self:getThemeData(iter_58_1)

				if var_58_1 then
					local var_58_2 = var_58_1:getBossData()

					if var_58_2:isThirdBoss() and var_58_2:getBossOpenState() == var_0_6.THEME_STATE_TYPE.OPENING and var_58_2:hasTalentRed() then
						return true
					end
				end
			end
		end

		return false
	end

	if arg_58_1 and arg_58_1.themeValue and self:getThemeData(arg_58_1.themeValue) then
		local var_58_3 = self:getThemeData(arg_58_1.themeValue):getBossData()

		if var_58_3:isThirdBoss() and var_58_3:getBossOpenState() == var_0_6.THEME_STATE_TYPE.OPENING then
			return var_58_3:hasTalentRed()
		end
	end

	return false
end

function ThemeDataMgr:_calcAllThemeDropInfo(arg_59_1)
	self._moduleDropGoodsDict = {}

	self:_calcAllOpenDrop(arg_59_1)

	for iter_59_0 = 1, g.core.config.extra_drop_info.getLength() do
		local var_59_0 = g.core.config.extra_drop_info.indexOf(iter_59_0)

		if self:_isThemeDropTypeOpen(var_59_0.extra_type) then
			self:_addOneExtraDropInfo(var_59_0)
		end
	end

	for iter_59_1, iter_59_2 in pairs(self._moduleDropGoodsDict) do
		table.sort(iter_59_2, function(arg_60_0, arg_60_1)
			return arg_60_0.sort_base > arg_60_1.sort_base
		end)
	end
end

function ThemeDataMgr:_addOneExtraDropInfo(arg_61_1)
	local var_61_0 = var_0_9:convert({
		type = arg_61_1.reward_type,
		value = arg_61_1.reward_value,
		size = arg_61_1.reward_number
	})

	if not var_61_0 then
		return
	end

	var_61_0.iconTagType = var_0_5.BASE_CONST.ICON_TAG_TYPE.PROB
	var_61_0.sort_base = arg_61_1.sort

	local var_61_1 = self._moduleDropGoodsDict[arg_61_1.module_id]

	if not self._moduleDropGoodsDict[arg_61_1.module_id] then
		var_61_1 = {}
		self._moduleDropGoodsDict[arg_61_1.module_id] = var_61_1
	end

	for iter_61_0, iter_61_1 in ipairs(var_61_1) do
		if iter_61_1.type == var_61_0.type and iter_61_1.value == var_61_0.value then
			return
		end
	end

	table.insert(var_61_1, var_61_0)
end

function ThemeDataMgr:_calcAllOpenDrop(arg_62_1)
	self._openExtraDropTypes = {}

	for iter_62_0, iter_62_1 in pairs(arg_62_1) do
		if iter_62_1:getActivityState() == var_0_2.ACTIVITY_STATE.START then
			self._openExtraDropTypes[g.core.config.activity_theme_info.get((iter_62_1:getConfigActivityValue())).extra_drop] = true
		end
	end
end

function ThemeDataMgr:_isThemeDropTypeOpen(arg_63_1)
	return self._openExtraDropTypes[arg_63_1]
end

function ThemeDataMgr:setTurnCardResetGame(arg_64_1)
	self._isResetGame = arg_64_1
end

function ThemeDataMgr:setGemEliminateResetGame(arg_65_1)
	self._isResetGemEliminateGame = arg_65_1
end

function ThemeDataMgr:setGuessResetGame(arg_66_1)
	self._isResetGuessGame = arg_66_1
end

function ThemeDataMgr:getGuessResetGame()
	return self._isResetGuessGame
end

function ThemeDataMgr:getTurnCardResetGame()
	return self._isResetGame
end

function ThemeDataMgr:getGemEliminateResetGame()
	return self._isResetGemEliminateGame
end

function ThemeDataMgr:setThemePuzzleResetGame(arg_70_1)
	self._isResetPuzzleGame = arg_70_1
end

function ThemeDataMgr:getThemePuzzleResetGame()
	return self._isResetPuzzleGame
end

function ThemeDataMgr:getThemeMergeMiniGameInfo(arg_72_1)
	local var_72_0 = self:getThemeMergeConfigValueList(arg_72_1)
	local var_72_1 = 0
	local var_72_2 = false
	local var_72_3 = 0

	for iter_72_0 = 1, #var_72_0 do
		local var_72_5 = g.core.config.activity_theme_info.get(var_72_0[iter_72_0])

		if var_72_5.minigame_type > 0 then
			var_72_1 = var_72_0[iter_72_0]
			var_72_2 = true
			var_72_3 = var_72_5.minigame_type

			break
		end
	end

	return {
		miniGameThemeValue = var_72_1,
		entryVisible = var_72_2,
		miniGameType = var_72_3,
		displayInfo = (var_72_1 > 0 or nil) and g.core.config.activity_theme_display_info.get(var_72_1)
	}
end

function ThemeDataMgr:changeThemeBGM(arg_73_1)
	if arg_73_1 == var_0_6.THEME_VALUE.SUMMER then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SUMMERTHEME_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.GRYPH then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.HORUS then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_HORUS_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.MOLLY then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.LEVIA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.NEWYEAR then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_NEWYEARTHEME_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.MAHATMA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MAHATMATHEME_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.LUMIN then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MAHATMATHEME_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.AKIRA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_AKIRA_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.IFURITO then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_HORUS_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.GOLDENDANCE then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_GOLDENDANCE_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.NUE then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MAHATMATHEME_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.BROWN then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MAHATMATHEME_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.FANTASY then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_HORUS_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.Cerberus then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.CHIRAHA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MAHATMATHEME_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.YORA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.LINEDELL then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MENU_2024NEWYEAR)
	elseif arg_73_1 == var_0_6.THEME_VALUE.THOTH then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_HORUS_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.VEDFOLNIR then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.BRIGHT then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.CAROLINE then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.FIRE then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.LILITH then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_HALLOWEEN_MENU)
	elseif arg_73_1 == var_0_6.THEME_VALUE.HERA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_HALLOWEEN_MENU)
	elseif arg_73_1 == var_0_6.THEME_VALUE.ANUBIS then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_EXPLORE)
	elseif arg_73_1 == var_0_6.THEME_VALUE.RIE then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.DIESS then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SUMMERTHEME_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.BANSHEE then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.LIUDMILA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.WIND then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MAHATMATHEME_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.RHAINA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_AKIRA_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.LERAPUS then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.KNOX then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.NOTE then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.METEOR then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.NVSHE then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_HORUS_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.DAIMONIKA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_ALICETHEMEMENU)
	elseif arg_73_1 == var_0_6.THEME_VALUE.SHUANGDAN then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_WENQUAN_MENU)
	elseif arg_73_1 == var_0_6.THEME_VALUE.SPHINX then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_HORUS_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.TASTE then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MAHATMATHEME_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.ITUNG then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.NARWAL then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.KLITA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.HATTOR then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_HORUS_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.SHEETS then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.PRAY then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_WENQUAN_MENU)
	elseif arg_73_1 == var_0_6.THEME_VALUE.LINK then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_UR_MENU)
	elseif arg_73_1 == var_0_6.THEME_VALUE.LING then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_UR_MENU02)
	elseif arg_73_1 == var_0_6.THEME_VALUE.SPRING then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_2025NEWYEAR_ACTIVITY)
	elseif arg_73_1 == var_0_6.THEME_VALUE.CHARLOTTE then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_AKIRA_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.CHRISTIE then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.PLINY then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.SAMOVIRA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.VV_UR then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.ISIS then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_HORUS_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.CLOUDS then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.Music_ActivityMenu_02)
	elseif arg_73_1 == var_0_6.THEME_VALUE.LUJIU then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.VICAT then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.ALINA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.NOREN then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.MYRIADS then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.ANNA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.Music_2025616_ActivityMenu)
	elseif arg_73_1 == var_0_6.THEME_VALUE.PEARLDOG then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MAHATMATHEME_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.MAKOTO then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MAHATMATHEME_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.NATALIA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.FEIFEI then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_FEIFEI_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.LYDIA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.MIRA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.MEL then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_HORUS_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.KALINKA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.CLEONA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.QILUO then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MAHATMATHEME_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.SHIRLEY then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.CARLA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.Music_Anniversary_Event)
	elseif arg_73_1 == var_0_6.THEME_VALUE.BLADE then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MAHATMATHEME_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.NANA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.MARTHA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.SHU then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MAHATMATHEME_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.YUANDAN then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_NEWYEAR2026)
	elseif arg_73_1 == var_0_6.THEME_VALUE.ROSA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.ASLI then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.LEOLA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.PENGPENG then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_PENGPENG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.JULIET then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_JULIET_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.ZOYA then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MOLLY_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.LI then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MAHATMATHEME_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.MIRAGE then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_NEWYEAR2026)
	elseif arg_73_1 == var_0_6.THEME_VALUE.YU then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_MAHATMATHEME_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.BAIYU then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_BAIYU_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.WEIYANG then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_BAIYU_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.LILIAN then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.MUSIC_SHENGQIANG_MAIN)
	elseif arg_73_1 == var_0_6.THEME_VALUE.ILIYI or arg_73_1 == var_0_6.THEME_VALUE.REUSE_97 or arg_73_1 == var_0_6.THEME_VALUE.REUSE_98 then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.Music_2026_616Activity)
	elseif arg_73_1 == var_0_6.THEME_VALUE.JOSEPHINE or arg_73_1 == var_0_6.THEME_VALUE.REUSE_100 or arg_73_1 == var_0_6.THEME_VALUE.REUSE_101 then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.Music_2026_07_summer_main)
	elseif arg_73_1 == var_0_6.THEME_VALUE.ELISA or arg_73_1 == var_0_6.THEME_VALUE.REUSE_103 or arg_73_1 == var_0_6.THEME_VALUE.REUSE_104 then
		g.core.sound.SoundManager:playMusic(var_0_8.BGM.Music_2026_08_summer_main)
	end
end

function ThemeDataMgr:changeClickBtnSound(arg_74_1)
	if arg_74_1 == var_0_6.THEME_VALUE.LUMIN then
		g.core.sound.SoundManager:playSound(var_0_8.Sound.SOUND_LUMIN_ENTRANCE)
	elseif arg_74_1 == var_0_6.THEME_VALUE.AKIRA then
		g.core.sound.SoundManager:playSound(var_0_8.Sound.SOUND_LUMIN_ENTRANCE)
	elseif arg_74_1 == var_0_6.THEME_VALUE.GOLDENDANCE then
		g.core.sound.SoundManager:playSound(var_0_8.Sound.SOUND_GOLDENDANCE_ENTRANCE)
	end
end

function ThemeDataMgr:changeSmallGameBGM(arg_75_1)
	if arg_75_1 == var_0_6.THEME_VALUE.AKIRA then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.GEM_ELI_BGM)
	elseif arg_75_1 == var_0_6.THEME_VALUE.ANUBIS then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.GEM_ELI_BGM)
	end
end

return ThemeDataMgr
