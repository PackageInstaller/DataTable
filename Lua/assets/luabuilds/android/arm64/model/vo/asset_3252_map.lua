local Map = class("Map", import(".BaseVO"))

Map.INVALID = 0
Map.SCENARIO = 1
Map.ELITE = 2
Map.EVENT = 3
Map.ACTIVITY_EASY = 4
Map.ACTIVITY_HARD = 5
Map.ACT_EXTRA = 8
Map.ESCORT = 9
Map.SKIRMISH = 10
Map.NORMAL_MAP = {
	Map.INVALID,
	Map.SCENARIO,
	Map.ELITE,
	Map.EVENT,
	Map.ACTIVITY_EASY,
	Map.ACTIVITY_HARD,
	Map.ACT_EXTRA
}

function Map:Ctor(arg_1_1)
	self.configId = arg_1_1.id
	self.id = self.configId
	self.chapterIds = arg_1_1.chapterIds

	return
end

function Map:bindConfigTable()
	return pg.expedition_data_by_map
end

function Map:isUnlock()
	if getProxy(PlayerProxy):getRawData().level < self:getConfig("level_limit") then
		local var_3_1 = i18n("levelScene_chapter_unlock_tip", self:getConfig("level_limit"))

		return
	elseif self:isActivity() then
		if self:isRemaster() then
			if self:isAnyChapterUnlocked() then
				return true
			else
				local var_3_3 = i18n("battle_levelScene_lock")

				return
			end
		else
			local var_3_4 = getProxy(ActivityProxy):getActivityById(self:getConfig("on_activity"))

			if not var_3_4 or var_3_4:isEnd() then
				local var_3_6 = i18n("common_activity_end")

				return
			else
				local var_3_7, var_3_8 = self:isAnyChapterUnlocked(true)

				if var_3_7 then
					return true
				elseif var_3_8 then
					local var_3_10 = i18n("battle_levelScene_close")

					return
				elseif ChapterConst.IsAtelierMap(self) and self:isHardMap() then
					local var_3_12 = i18n("battle_levelScene_ryza_lock")

					return
				else
					local var_3_14 = i18n("battle_levelScene_lock")

					return
				end
			end
		end
	elseif self:getMapType() == Map.SCENARIO then
		if self:isAnyChapterUnlocked(false) then
			return true
		else
			local var_3_16 = i18n("battle_levelScene_lock")

			return
		end
	elseif self:getMapType() == Map.ELITE then
		if self:isEliteEnabled() then
			return true
		else
			local var_3_18 = i18n("battle_levelScene_hard_lock")

			return
		end
	else
		return true
	end

	return
end

function Map:setRemaster(arg_4_1)
	self.remasterId = arg_4_1

	return
end

function Map:isRemaster()
	return self.remasterId ~= nil
end

function Map:getRemaster()
	return self.remasterId
end

function Map:getMapType()
	return self:getConfig("type")
end

function Map:getMapTitleNumber()
	return self:getConfig("title")
end

function Map:getBindMapId()
	return self:getConfig("bind_map")
end

function Map:getBindMap()
	return getProxy(ChapterProxy):getMapById(self:getBindMapId())
end

function Map:getChapters()
	return _.filter(self:GetChapterItems(), function(arg_12_0)
		return isa(arg_12_0, Chapter)
	end)
end

function Map:GetChapterItems()
	local var_13_0 = getProxy(ChapterProxy)

	return _.map(self:GetChapterList(), function(arg_14_0)
		return var_13_0:GetChapterItemById(arg_14_0)
	end)
end

function Map:getEscortConfig()
	if self:isEscort() then
		return pg.escort_map_template[self.id]
	end

	return
end

function Map:getChapterTimeLimit()
	if not self:isActivity() or self:isRemaster() then
		return 0
	end

	local var_16_0 = pg.TimeMgr.GetInstance()
	local var_16_1 = 0

	for iter_16_0, iter_16_1 in ipairs(self:getChapters()) do
		local var_16_2 = pg.activity_template[iter_16_1:GetBindActID()]

		if var_16_2 and var_16_2.time and #var_16_2.time == 3 then
			local var_16_3 = var_16_0:parseTimeFromConfig(var_16_2.time[2]) - var_16_0:GetServerTime()

			if var_16_3 > 0 then
				var_16_1 = var_16_1 == 0 and var_16_3 or math.min(var_16_1, var_16_3)
			end
		end
	end

	return var_16_1
end

function Map:isClear()
	if self:getMapType() == Map.SCENARIO then
		return self:isAllChaptersClear()
	elseif self:isActivity() then
		return self:isClearForActivity()
	else
		return true
	end

	return
end

function Map:isClearForActivity()
	local var_18_0 = self:GetChapterItems()

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		if iter_18_0 > 1 and iter_18_1.id - var_18_0[iter_18_0 - 1].id > 1 then
			break
		elseif not iter_18_1:isClear() then
			return false
		end
	end

	return true
end

function Map:isEliteEnabled()
	local var_19_0 = self:getMapType() == Map.ELITE and getProxy(ChapterProxy):getMapById(self:getBindMapId()) or self

	return var_19_0:isAllChaptersClear() and var_19_0:isAllChaptersAchieve()
end

function Map:isAnyChapterUnlocked(arg_20_1)
	local var_20_0 = false

	for iter_20_0, iter_20_1 in ipairs(self:GetChapterItems()) do
		if iter_20_1:isUnlock() then
			if not arg_20_1 or iter_20_1:inActTime() then
				return true
			else
				var_20_0 = true
			end
		end
	end

	return false, var_20_0
end

function Map:isAnyChapterClear()
	return underscore.any(self:GetChapterItems(), function(arg_22_0)
		return arg_22_0:isClear()
	end)
end

function Map:isAllChaptersClear()
	for iter_23_0, iter_23_1 in ipairs(self:GetChapterItems()) do
		if not iter_23_1:isClear() then
			return false
		end
	end

	return true
end

function Map:isAllChaptersAchieve()
	for iter_24_0, iter_24_1 in ipairs(self:getChapters()) do
		if not iter_24_1:isAllAchieve() then
			return false
		end
	end

	return true
end

function Map:getLastUnlockChapterName()
	local var_25_0

	for iter_25_0, iter_25_1 in ipairs(self:getChapters()) do
		if not iter_25_1:isUnlock() then
			break
		end

		var_25_0 = iter_25_1
	end

	return var_25_0:getConfig("chapter_name")
end

function Map:GetChapterInProgress()
	return underscore.detect(self:GetChapterItems(), function(arg_27_0)
		return arg_27_0:isUnlock() and not arg_27_0:isClear()
	end)
end

function Map:GetChapterList()
	return self.chapterIds
end

Map.NOT_REAR_CHAPTERS = {
	2100328,
	2100338,
	2100327,
	2100337,
	2100588,
	2100598,
	2100587,
	2100597
}

function Map:GetRearChaptersOfRemaster()
	if not self or self == 0 then
		return
	end

	local var_29_0 = getProxy(ChapterProxy)
	local var_29_1 = {}

	table.Foreach(_.reduce(BossRushChapterRemasterHelper.GetChapterIds(self), {}, function(arg_30_0, arg_30_1)
		local var_30_0 = var_29_0:getMapById((var_29_0:getChapterById(arg_30_1, true):getConfig("map"))):getConfig("type")

		arg_30_0[var_30_0] = arg_30_0[var_30_0] or {}

		table.insert(arg_30_0[var_30_0], arg_30_1)

		return arg_30_0
	end), function(arg_31_0, arg_31_1)
		local var_31_0 = _.reduce(arg_31_1, {}, function(arg_32_0, arg_32_1)
			arg_32_0[var_29_0:getChapterById(arg_32_1, true):getConfig("pre_chapter")] = arg_32_1

			return arg_32_0
		end)

		table.insert(var_29_1, _.max((_.filter(arg_31_1, function(arg_33_0)
			return not var_31_0[arg_33_0] and not table.contains(Map.NOT_REAR_CHAPTERS, arg_33_0)
		end))))

		return
	end)

	return var_29_1
end

function Map:isActivity()
	local var_34_0 = self:getMapType()

	if var_34_0 == Map.EVENT then
		return true, false
	elseif var_34_0 == Map.ACTIVITY_EASY or var_34_0 == Map.ACTIVITY_HARD or var_34_0 == Map.ACT_EXTRA then
		return true, true
	else
		return false
	end

	return
end

function Map:isHardMap()
	local var_35_0 = self:getMapType()

	return var_35_0 == Map.ELITE or var_35_0 == Map.ACTIVITY_HARD
end

function Map:isActExtra()
	return self:getMapType() == Map.ACT_EXTRA
end

function Map:isEscort()
	return self:getMapType() == Map.ESCORT
end

function Map:isSkirmish()
	return self:getMapType() == Map.SKIRMISH
end

function Map:isNormalMap()
	return table.contains(Map.NORMAL_MAP, self:getMapType())
end

function Map:NeedRecordMap()
	local var_40_0 = self:getMapType()

	return var_40_0 == Map.INVALID or var_40_0 == Map.SCENARIO or var_40_0 == Map.ELITE
end

return Map
