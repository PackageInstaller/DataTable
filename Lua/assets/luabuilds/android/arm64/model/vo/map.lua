local var_0_0 = class("Map", import(".BaseVO"))

var_0_0.INVALID = 0
var_0_0.SCENARIO = 1
var_0_0.ELITE = 2
var_0_0.EVENT = 3
var_0_0.ACTIVITY_EASY = 4
var_0_0.ACTIVITY_HARD = 5
var_0_0.ACT_EXTRA = 8
var_0_0.ESCORT = 9
var_0_0.SKIRMISH = 10
var_0_0.NORMAL_MAP = {
	var_0_0.INVALID,
	var_0_0.SCENARIO,
	var_0_0.ELITE,
	var_0_0.EVENT,
	var_0_0.ACTIVITY_EASY,
	var_0_0.ACTIVITY_HARD,
	var_0_0.ACT_EXTRA
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.configId = arg_1_1.id
	arg_1_0.id = arg_1_0.configId
	arg_1_0.chapterIds = arg_1_1.chapterIds

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.expedition_data_by_map
end

function var_0_0.isUnlock(arg_3_0)
	if getProxy(PlayerProxy):getRawData().level < arg_3_0:getConfig("level_limit") then
		local var_3_1 = i18n("levelScene_chapter_unlock_tip", arg_3_0:getConfig("level_limit"))

		return
	elseif arg_3_0:isActivity() then
		if arg_3_0:isRemaster() then
			if arg_3_0:isAnyChapterUnlocked() then
				return true
			else
				local var_3_3 = i18n("battle_levelScene_lock")

				return
			end
		else
			local var_3_4 = getProxy(ActivityProxy):getActivityById(arg_3_0:getConfig("on_activity"))

			if not var_3_4 or var_3_4:isEnd() then
				local var_3_6 = i18n("common_activity_end")

				return
			else
				local var_3_7, var_3_8 = arg_3_0:isAnyChapterUnlocked(true)

				if var_3_7 then
					return true
				elseif var_3_8 then
					local var_3_10 = i18n("battle_levelScene_close")

					return
				elseif ChapterConst.IsAtelierMap(arg_3_0) and arg_3_0:isHardMap() then
					local var_3_12 = i18n("battle_levelScene_ryza_lock")

					return
				else
					local var_3_14 = i18n("battle_levelScene_lock")

					return
				end
			end
		end
	elseif arg_3_0:getMapType() == Map.SCENARIO then
		if arg_3_0:isAnyChapterUnlocked(false) then
			return true
		else
			local var_3_16 = i18n("battle_levelScene_lock")

			return
		end
	elseif arg_3_0:getMapType() == Map.ELITE then
		if arg_3_0:isEliteEnabled() then
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

function var_0_0.setRemaster(arg_4_0, arg_4_1)
	arg_4_0.remasterId = arg_4_1

	return
end

function var_0_0.isRemaster(arg_5_0)
	return arg_5_0.remasterId ~= nil
end

function var_0_0.getRemaster(arg_6_0)
	return arg_6_0.remasterId
end

function var_0_0.getMapType(arg_7_0)
	return arg_7_0:getConfig("type")
end

function var_0_0.getMapTitleNumber(arg_8_0)
	return arg_8_0:getConfig("title")
end

function var_0_0.getBindMapId(arg_9_0)
	return arg_9_0:getConfig("bind_map")
end

function var_0_0.getBindMap(arg_10_0)
	return getProxy(ChapterProxy):getMapById(arg_10_0:getBindMapId())
end

function var_0_0.getChapters(arg_11_0)
	return _.filter(arg_11_0:GetChapterItems(), function(arg_12_0)
		return isa(arg_12_0, Chapter)
	end)
end

function var_0_0.GetChapterItems(arg_13_0)
	local var_13_0 = getProxy(ChapterProxy)

	return _.map(arg_13_0:GetChapterList(), function(arg_14_0)
		return var_13_0:GetChapterItemById(arg_14_0)
	end)
end

function var_0_0.getEscortConfig(arg_15_0)
	if arg_15_0:isEscort() then
		return pg.escort_map_template[arg_15_0.id]
	end

	return
end

function var_0_0.getChapterTimeLimit(arg_16_0)
	if not arg_16_0:isActivity() or arg_16_0:isRemaster() then
		return 0
	end

	local var_16_0 = pg.TimeMgr.GetInstance()
	local var_16_1 = 0

	for iter_16_0, iter_16_1 in ipairs(arg_16_0:getChapters()) do
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

function var_0_0.isClear(arg_17_0)
	if arg_17_0:getMapType() == var_0_0.SCENARIO then
		return arg_17_0:isAllChaptersClear()
	elseif arg_17_0:isActivity() then
		return arg_17_0:isClearForActivity()
	else
		return true
	end

	return
end

function var_0_0.isClearForActivity(arg_18_0)
	local var_18_0 = arg_18_0:GetChapterItems()

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		if iter_18_0 > 1 and iter_18_1.id - var_18_0[iter_18_0 - 1].id > 1 then
			break
		elseif not iter_18_1:isClear() then
			return false
		end
	end

	return true
end

function var_0_0.isEliteEnabled(arg_19_0)
	local var_19_0 = arg_19_0:getMapType() == var_0_0.ELITE and getProxy(ChapterProxy):getMapById(arg_19_0:getBindMapId()) or arg_19_0

	return var_19_0:isAllChaptersClear() and var_19_0:isAllChaptersAchieve()
end

function var_0_0.isAnyChapterUnlocked(arg_20_0, arg_20_1)
	local var_20_0 = false

	for iter_20_0, iter_20_1 in ipairs(arg_20_0:GetChapterItems()) do
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

function var_0_0.isAnyChapterClear(arg_21_0)
	return underscore.any(arg_21_0:GetChapterItems(), function(arg_22_0)
		return arg_22_0:isClear()
	end)
end

function var_0_0.isAllChaptersClear(arg_23_0)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0:GetChapterItems()) do
		if not iter_23_1:isClear() then
			return false
		end
	end

	return true
end

function var_0_0.isAllChaptersAchieve(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0:getChapters()) do
		if not iter_24_1:isAllAchieve() then
			return false
		end
	end

	return true
end

function var_0_0.getLastUnlockChapterName(arg_25_0)
	local var_25_0

	for iter_25_0, iter_25_1 in ipairs(arg_25_0:getChapters()) do
		if not iter_25_1:isUnlock() then
			break
		end

		var_25_0 = iter_25_1
	end

	return var_25_0:getConfig("chapter_name")
end

function var_0_0.GetChapterInProgress(arg_26_0)
	return underscore.detect(arg_26_0:GetChapterItems(), function(arg_27_0)
		return arg_27_0:isUnlock() and not arg_27_0:isClear()
	end)
end

function var_0_0.GetChapterList(arg_28_0)
	return arg_28_0.chapterIds
end

var_0_0.NOT_REAR_CHAPTERS = {
	2100328,
	2100338,
	2100327,
	2100337,
	2100588,
	2100598,
	2100587,
	2100597
}

function var_0_0.GetRearChaptersOfRemaster(arg_29_0)
	if not arg_29_0 or arg_29_0 == 0 then
		return
	end

	local var_29_0 = getProxy(ChapterProxy)
	local var_29_1 = {}

	table.Foreach(_.reduce(BossRushChapterRemasterHelper.GetChapterIds(arg_29_0), {}, function(arg_30_0, arg_30_1)
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
			return not var_31_0[arg_33_0] and not table.contains(var_0_0.NOT_REAR_CHAPTERS, arg_33_0)
		end))))

		return
	end)

	return {}
end

function var_0_0.isActivity(arg_34_0)
	local var_34_0 = arg_34_0:getMapType()

	if var_34_0 == Map.EVENT then
		return true, false
	elseif var_34_0 == Map.ACTIVITY_EASY or var_34_0 == Map.ACTIVITY_HARD or var_34_0 == Map.ACT_EXTRA then
		return true, true
	else
		return false
	end

	return
end

function var_0_0.isHardMap(arg_35_0)
	local var_35_0 = arg_35_0:getMapType()

	return var_35_0 == Map.ELITE or var_35_0 == Map.ACTIVITY_HARD
end

function var_0_0.isActExtra(arg_36_0)
	return arg_36_0:getMapType() == Map.ACT_EXTRA
end

function var_0_0.isEscort(arg_37_0)
	return arg_37_0:getMapType() == Map.ESCORT
end

function var_0_0.isSkirmish(arg_38_0)
	return arg_38_0:getMapType() == Map.SKIRMISH
end

function var_0_0.isNormalMap(arg_39_0)
	return table.contains(Map.NORMAL_MAP, arg_39_0:getMapType())
end

function var_0_0.NeedRecordMap(arg_40_0)
	local var_40_0 = arg_40_0:getMapType()

	return var_40_0 == var_0_0.INVALID or var_40_0 == var_0_0.SCENARIO or var_40_0 == var_0_0.ELITE
end

return var_0_0
