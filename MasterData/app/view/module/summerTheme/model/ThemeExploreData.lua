local var_0_0 = g.core.const.ConstMgr.ThemeConst
local var_0_1 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_SOURCE_TYPE
local ThemeExploreData = class("ThemeExploreData")

function ThemeExploreData:ctor()
	self:initData()
end

function ThemeExploreData:initData()
	self._activeStartTime = 0
	self._activeThemeType = nil
	self._activeThemeValue = nil
	self._activeThemeChapterObject = {}
	self._activeThemeRedPointCache = {}
	self._cloudServerMapCache = {}
	self._rewardBoxMap = {}
	self._allRewardBoxMap = {}
	self._timePowerBag = {}
	self._chapterHpMap = {}
	self._qualityItemMap = {}
	self._sourceType = var_0_1.CONFIG_TABLE

	self:initItemData()
end

function ThemeExploreData:startByActivityData(arg_3_1)
	self._activeThemeType = arg_3_1:getActivityType()
	self._activeThemeValue = arg_3_1:getConfigActivityValue()
	self._sourceType = arg_3_1:getActivitySourceType()
	self._activeStartTime = arg_3_1:getStartTime()
	self._activityInfo = arg_3_1:getInfo()

	self:_parseCfg()
end

function ThemeExploreData:_parseCfg()
	if self._exploreChapterInfo then
		return
	end

	self._exploreChapterInfo = {}
	self._chapterObjectMap = {}

	local var_4_0 = g.core.config.activity_theme_info.get(self._activeThemeValue)
	local var_4_1 = {}

	for iter_4_0 = 1, 3 do
		local var_4_2

		if var_4_0["explore_id_" .. iter_4_0] and var_4_0["explore_id_" .. iter_4_0] ~= 0 then
			var_4_1[var_4_0["explore_id_" .. iter_4_0]] = true

			table.insert(self._exploreChapterInfo, {
				id = var_4_0["explore_id_" .. iter_4_0],
				relativeOpenTime = self._activityInfo["explore_time" .. iter_4_0] or self._activeStartTime + var_4_0["explore_time_" .. iter_4_0],
				perChapterId = 0,
				info = g.core.config.activity_theme_explore_info.get(var_4_0["explore_id_" .. iter_4_0])
			})

			var_4_2 = var_4_0["explore_id_" .. iter_4_0]
		end
	end

	self:parseObjectData(var_4_1)
end

function ThemeExploreData:hasExplore()
	return next(self._exploreChapterInfo)
end

function ThemeExploreData:initItemData()
	for iter_6_0 = 1, g.core.config.activity_theme_explore_item.getLength() do
		local var_6_0 = g.core.config.activity_theme_explore_item.indexOf(iter_6_0)

		self._qualityItemMap[var_6_0.quality] = self._qualityItemMap[var_6_0.quality] or {}

		table.insert(self._qualityItemMap[var_6_0.quality], var_6_0.id)
	end

	for iter_6_1 = 1, g.core.config.activity_theme_explore_object.getLength() do
		local var_6_1 = g.core.config.activity_theme_explore_object.indexOf(iter_6_1)

		self._activeThemeChapterObject[var_6_1.chapter] = self._activeThemeChapterObject[var_6_1.chapter] or {}

		table.insert(self._activeThemeChapterObject[var_6_1.chapter], var_6_1)
	end
end

function ThemeExploreData:onNetThemeExploreGetInfo(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1.box or {}) do
		self._rewardBoxMap[iter_7_1.id] = self._rewardBoxMap[iter_7_1.id] or {}
		self._allRewardBoxMap[iter_7_1.num] = true
		self._rewardBoxMap[iter_7_1.id][iter_7_1.num] = true
	end
end

function ThemeExploreData:onGetExploreBox(arg_8_1)
	self._allRewardBoxMap[arg_8_1.object_id] = true
	self._rewardBoxMap[arg_8_1.chapter_id] = self._rewardBoxMap[arg_8_1.chapter_id] or {}
	self._rewardBoxMap[arg_8_1.chapter_id][arg_8_1.object_id] = true
end

function ThemeExploreData:onResetChapter(arg_9_1)
	if self._cloudServerMapCache[arg_9_1.chapter_id] then
		self._cloudServerMapCache[arg_9_1.chapter_id] = {}
		self._cloudServerMapCache[arg_9_1.chapter_id].pass_grids = self._cloudServerMapCache[arg_9_1.chapter_id].pass_grids
	end

	if self._chapterHpMap[arg_9_1.chapter_id] then
		for iter_9_0, iter_9_1 in ipairs(self._chapterHpMap[arg_9_1.chapter_id]) do
			self._chapterHpMap[arg_9_1.chapter_id][iter_9_0] = 1000
		end
	end

	self._timePowerBag[arg_9_1.chapter_id] = {}
end

function ThemeExploreData:onGetTimePower(arg_10_1)
	self._timePowerBag[arg_10_1.chapter_id] = self._timePowerBag[arg_10_1.chapter_id] or {}

	table.insert(self._timePowerBag[arg_10_1.chapter_id], arg_10_1.time_power_id)
end

function ThemeExploreData:onRecoverHpEvent(arg_11_1)
	self._chapterHpMap[arg_11_1.chapter_id] = self._chapterHpMap[arg_11_1.chapter_id] or {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.user_hp_list or {}) do
		self._chapterHpMap[arg_11_1.chapter_id][iter_11_0] = iter_11_1
	end
end

function ThemeExploreData:onBattleFinishUpdateHp(arg_12_1)
	self._chapterHpMap[arg_12_1.chapter_id] = self._chapterHpMap[arg_12_1.chapter_id] or {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.user_hp_list or {}) do
		self._chapterHpMap[arg_12_1.chapter_id][iter_12_0] = iter_12_1
	end
end

function ThemeExploreData:onSaveExploreData(arg_13_1)
	return
end

function ThemeExploreData:onGetExploreMapData(arg_14_1)
	self._timePowerBag[arg_14_1.chapter_id] = arg_14_1.time_power_list

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.user_hp_list) do
		self._chapterHpMap[arg_14_1.chapter_id] = self._chapterHpMap[arg_14_1.chapter_id] or {}
		self._chapterHpMap[arg_14_1.chapter_id][iter_14_0] = iter_14_1
	end

	self._cloudServerMapCache[arg_14_1.chapter_id] = arg_14_1.mapInfo
end

function ThemeExploreData:getExploreMapData(arg_15_1)
	return self._cloudServerMapCache[arg_15_1]
end

function ThemeExploreData:setExploreMapData(arg_16_1, arg_16_2)
	self._cloudServerMapCache[arg_16_1] = arg_16_2
end

function ThemeExploreData:parseObjectData(arg_17_1)
	for iter_17_0 = 1, g.core.config.activity_theme_explore_object.getLength() do
		local var_17_0 = g.core.config.activity_theme_explore_object.indexOf(iter_17_0)

		if arg_17_1[var_17_0.chapter] then
			self._chapterObjectMap[var_17_0.chapter] = self._chapterObjectMap[var_17_0.chapter] or {}

			table.insert(self._chapterObjectMap[var_17_0.chapter], {
				finish = false,
				info = var_17_0
			})
		end
	end
end

function ThemeExploreData:isHpMax(arg_18_1)
	if self._chapterHpMap[arg_18_1] then
		for iter_18_0, iter_18_1 in ipairs(self._chapterHpMap[arg_18_1]) do
			if iter_18_1 ~= 1000 then
				return false
			end
		end

		return true
	end

	return false
end

function ThemeExploreData:getRandomTimePower(arg_19_1)
	local var_19_0 = clone(self._qualityItemMap[arg_19_1])
	local var_19_1 = {}

	if not var_19_0 then
		var_19_1 = {
			1,
			1,
			1
		}
	elseif #var_19_0 < 3 then
		var_19_1 = {
			var_19_0[1],
			var_19_0[1],
			var_19_0[1]
		}
	else
		for iter_19_0 = 1, 3 do
			local var_19_2 = math.random(1, #var_19_0)

			table.insert(var_19_1, var_19_0[var_19_2])
			table.remove(var_19_0, var_19_2)
		end
	end

	local var_19_3 = g.core.config.activity_theme_explore_item
	local var_19_4 = {}

	for iter_19_1, iter_19_2 in ipairs(var_19_1) do
		table.insert(var_19_4, var_19_3.get(iter_19_2))
	end

	return var_19_4
end

function ThemeExploreData:getExploreChapterData()
	for iter_20_0, iter_20_1 in ipairs(self._exploreChapterInfo) do
		local var_20_0 = 0
		local var_20_1 = 0
		local var_20_2 = 0

		if self._activeThemeChapterObject[iter_20_1.id] then
			for iter_20_2, iter_20_3 in ipairs(self._activeThemeChapterObject[iter_20_1.id]) do
				if iter_20_3.type == var_0_0.THEME_EXPLORE_TYPE.REWARD then
					var_20_0 = var_20_0 + 1

					if iter_20_3.param_1 == 1 then
						var_20_1 = var_20_1 + 1
					elseif iter_20_3.param_1 == 2 then
						var_20_2 = var_20_2 + 1
					end
				end
			end
		end

		iter_20_1.allBoxNum = var_20_0
		iter_20_1.smallBoxNum = var_20_1
		iter_20_1.bigBoxNum = var_20_2

		if g.core.common.ServerTime:getTime() < iter_20_1.relativeOpenTime then
			iter_20_1.isTimeOpen = false
			iter_20_1.openTime = iter_20_1.relativeOpenTime
		else
			iter_20_1.isTimeOpen = true
		end

		if iter_20_1.perChapterId == 0 then
			iter_20_1.isOpen = true
		else
			local var_20_3 = iter_20_1.info.pre_reward
			local var_20_4 = 0

			for iter_20_4, iter_20_5 in ipairs(self._chapterObjectMap[iter_20_1.perChapterId]) do
				if iter_20_5.info.type == var_0_0.THEME_EXPLORE_TYPE.REWARD and self._allRewardBoxMap[iter_20_5.info.id] then
					var_20_4 = var_20_4 + 1
				end
			end

			iter_20_1.isOpen = var_20_3 <= var_20_4
		end
	end

	return self._exploreChapterInfo
end

function ThemeExploreData:getChapterRewardBox(arg_21_1)
	local var_21_0 = {}
	local var_21_1 = {}
	local var_21_2 = 0

	if not self._chapterObjectMap[arg_21_1] then
		return var_21_0, var_21_1, var_21_2
	end

	for iter_21_0, iter_21_1 in ipairs(self._chapterObjectMap[arg_21_1]) do
		if iter_21_1.info.type == var_0_0.THEME_EXPLORE_TYPE.REWARD then
			iter_21_1.finish = self._allRewardBoxMap[iter_21_1.info.id] or false

			if iter_21_1.finish then
				var_21_2 = var_21_2 + 1
			end

			if iter_21_1.info.param_1 == 1 then
				table.insert(var_21_1, iter_21_1)
			elseif iter_21_1.info.param_1 == 2 then
				table.insert(var_21_0, iter_21_1)
			end
		end
	end

	return var_21_0, var_21_1, var_21_2
end

function ThemeExploreData:getAllBoxRewards(arg_22_1)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		for iter_22_2, iter_22_3 in ipairs((g.core.common.Drops:getGoodsArray(iter_22_1.info.param_2))) do
			iter_22_3.isReward = iter_22_1.finish
			iter_22_3.sortId = iter_22_1.info.id

			table.insert(var_22_0, iter_22_3)
		end
	end

	table.sort(var_22_0, function(arg_23_0, arg_23_1)
		if arg_23_0.isReward ~= arg_23_1.isReward then
			return arg_23_1.isReward
		end

		if arg_23_0.sortId ~= arg_23_1.sortId then
			return arg_23_0.sortId < arg_23_1.sortId
		end

		return false
	end)

	return var_22_0
end

function ThemeExploreData:getTimerPowerBag(arg_24_1)
	if self._timePowerBag[arg_24_1] then
		local var_24_0 = g.core.config.activity_theme_explore_item

		table.sort(self._timePowerBag[arg_24_1], function(arg_25_0, arg_25_1)
			local var_25_0 = var_24_0.get(arg_25_0)
			local var_25_1 = var_24_0.get(arg_25_1)

			if var_25_0.quality ~= var_25_1.quality then
				return var_25_0.quality > var_25_1.quality
			end

			return arg_25_0 < arg_25_1
		end)
	end

	return self._timePowerBag[arg_24_1]
end

function ThemeExploreData:setLastFightState(arg_26_1)
	self._fightParam = arg_26_1
end

function ThemeExploreData:getLastFightState()
	self._fightParam = nil

	return self._fightParam
end

function ThemeExploreData:getChapterSelfHpPer(arg_28_1)
	return self._chapterHpMap[arg_28_1]
end

function ThemeExploreData:isBoxAwarded(arg_29_1)
	return self._allRewardBoxMap[arg_29_1]
end

function ThemeExploreData:getChapterBoxAward(arg_30_1)
	return self._rewardBoxMap[arg_30_1]
end

function ThemeExploreData:checkHasNewChapter(arg_31_1)
	local var_31_0 = self:getExploreChapterData()

	if arg_31_1.chapter then
		for iter_31_0, iter_31_1 in ipairs(var_31_0) do
			if iter_31_1.id == arg_31_1.chapter then
				return self:isChapterHasNewRedPoint(arg_31_1.themeValue, arg_31_1.chapter, iter_31_1)
			end
		end

		return false
	else
		for iter_31_2, iter_31_3 in ipairs(var_31_0) do
			if self:isChapterHasNewRedPoint(arg_31_1.themeValue, iter_31_3.id, iter_31_3) then
				return true
			end
		end

		return false
	end
end

function ThemeExploreData:isChapterHasNewRedPoint(arg_32_1, arg_32_2, arg_32_3)
	self._activeThemeRedPointCache = g.core.common.Storage:load("theme_explore_new_tag.json", true) or {}

	if self._activeThemeRedPointCache[arg_32_1 .. "_" .. arg_32_2] then
		return false
	end

	return arg_32_3.isOpen and arg_32_3.isTimeOpen
end

function ThemeExploreData:saveChapterNewCache(arg_33_1, arg_33_2)
	self._activeThemeRedPointCache[arg_33_1 .. "_" .. arg_33_2] = true

	g.core.common.Storage:save("theme_explore_new_tag.json", self._activeThemeRedPointCache, true)
end

function ThemeExploreData:getExploreStartTime()
	return self._activeStartTime
end

return ThemeExploreData
