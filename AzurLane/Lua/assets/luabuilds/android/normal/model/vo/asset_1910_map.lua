class = var_0_10000

local var_0_0 = "Map"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

var_0_1.INVALID = 0
var_0_1.SCENARIO = 1
var_0_1.ELITE = 2
var_0_1.EVENT = 3
var_0_1.ACTIVITY_EASY = 4
var_0_1.ACTIVITY_HARD = 5
var_0_1.ACT_EXTRA = 8
var_0_1.ESCORT = 9
var_0_1.SKIRMISH = 10
var_0_1.NORMAL_MAP = {
	var_0_1.INVALID,
	var_0_1.SCENARIO,
	var_0_1.ELITE,
	var_0_1.EVENT,
	var_0_1.ACTIVITY_EASY,
	var_0_1.ACTIVITY_HARD,
	var_0_1.ACT_EXTRA
}

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.configId = arg_1_1.id
	arg_1_0.id = arg_1_0.configId
	arg_1_0.chapterIds = arg_1_1.chapterIds

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.expedition_data_by_map
end

function var_0_1.isUnlock(arg_3_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)

	if var_1.getRawData(var_3_0).level < arg_3_0:getConfig("level_limit") then
		local var_3_1 = false

		i18n = var_3

		local var_3_2 = var_3("levelScene_chapter_unlock_tip", arg_3_0:getConfig("level_limit"))

		do return end

		goto label_3_0
	end

	if arg_3_0:isActivity() then
		local var_3_3 = arg_3_0
		local var_3_4

		if arg_3_0.isRemaster(var_3_3) then
			var_3_3 = arg_3_0

			if arg_3_0.isAnyChapterUnlocked(var_3_3) then
				return true
			else
				var_3_4 = false
				i18n = var_3_3
				var_3_3 = var_3_3("battle_levelScene_lock")

				return
			end

			goto label_3_0
		end

		getProxy = var_3_4
		ActivityProxy = var_3_3

		local var_3_5 = var_3_4(var_3_3)

		if var_2.getActivityById(var_3_5, arg_3_0:getConfig("on_activity")) then
			do
				local var_3_6 = var_2

				if var_2.isEnd(var_3_6) then
					local var_3_7 = false

					i18n = var_3_6

					local var_3_8 = var_3_6("common_activity_end")

					return
				else
					local var_3_9, var_3_10 = arg_3_0:isAnyChapterUnlocked(true)

					if var_3_9 then
						return true
					else
						local var_3_11

						if var_3_10 then
							var_3_11 = false
							i18n = var_6

							local var_3_12 = var_6("battle_levelScene_close")

							return
						else
							ChapterConst = var_3_11

							local var_3_13

							if var_3_11.IsAtelierMap(arg_3_0) then
								var_3_13 = arg_3_0

								if arg_3_0.isHardMap(var_3_13) then
									local var_3_14 = false

									i18n = var_3_13
									var_3_13 = var_3_13("battle_levelScene_ryza_lock")

									do return end

									goto label_3_0
								end
							end

							local var_3_15 = false

							i18n = var_3_13

							local var_3_16 = var_3_13("battle_levelScene_lock")

							return
						end
					end
				end

				if false then
					local var_3_17 = arg_3_0
					local var_3_18 = arg_3_0.getMapType(var_3_17)

					Map = var_3_17

					if var_3_18 == var_3_17.SCENARIO then
						local var_3_19 = arg_3_0

						if arg_3_0.isAnyChapterUnlocked(var_3_19, false) then
							return true
						else
							local var_3_20 = false

							i18n = var_3_19

							local var_3_21 = var_3_19("battle_levelScene_lock")

							return
						end
					else
						local var_3_22 = arg_3_0
						local var_3_23 = arg_3_0.getMapType(var_3_22)

						Map = var_3_22

						if var_3_23 == var_3_22.ELITE then
							local var_3_24 = arg_3_0

							if arg_3_0.isEliteEnabled(var_3_24) then
								return true
							else
								local var_3_25 = false

								i18n = var_3_24

								local var_3_26 = var_3_24("battle_levelScene_hard_lock")

								return
							end
						else
							return true
						end
					end
				end
			end

			::label_3_0::

			return
		end
	end
end

function var_0_1.setRemaster(arg_4_0, arg_4_1)
	arg_4_0.remasterId = arg_4_1

	return
end

function var_0_1.isRemaster(arg_5_0)
	return arg_5_0.remasterId ~= nil
end

function var_0_1.getRemaster(arg_6_0)
	return arg_6_0.remasterId
end

function var_0_1.getMapType(arg_7_0)
	return arg_7_0:getConfig("type")
end

function var_0_1.getMapTitleNumber(arg_8_0)
	return arg_8_0:getConfig("title")
end

function var_0_1.getBindMapId(arg_9_0)
	return arg_9_0:getConfig("bind_map")
end

function var_0_1.getBindMap(arg_10_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10002

	local var_10_0 = var_1_10001(var_1_10002)

	return var_1.getMapById(var_10_0, arg_10_0:getBindMapId())
end

function var_0_1.getChapters(arg_11_0)
	_ = var_1_10001

	return var_1_10001.filter(arg_11_0:GetChapterItems(), function(arg_12_0)
		isa = var_2_10001

		local var_12_0 = arg_12_0

		Chapter = var_2_10003

		return var_2_10001(var_12_0, var_2_10003)
	end)
end

function var_0_1.GetChapterItems(arg_13_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10002

	local var_13_0 = var_1_10001(var_1_10002)

	_ = var_1_10002

	return var_1_10002.map(arg_13_0:GetChapterList(), function(arg_14_0)
		local var_14_0 = var_13_0

		return var_1.GetChapterItemById(var_14_0, arg_14_0)
	end)
end

function var_0_1.getEscortConfig(arg_15_0)
	if arg_15_0:isEscort() then
		pg = var_1

		return var_1.escort_map_template[arg_15_0.id]
	end

	return
end

function var_0_1.getChapterTimeLimit(arg_16_0)
	if not arg_16_0:isActivity() or arg_16_0:isRemaster() then
		return 0
	end

	pg = var_1

	local var_16_0 = var_1.TimeMgr.GetInstance()
	local var_16_1 = 0

	ipairs = var_1_10003

	for iter_16_0, iter_16_1 in var_1_10003(arg_16_0:getChapters()) do
		pg = var_1_10008

		if var_1_10008.activity_template[iter_16_1:GetBindActID()] and var_1_10008.time and #var_1_10008.time == 3 then
			local var_16_2 = var_16_0:parseTimeFromConfig(var_1_10008.time[2]) - var_16_0:GetServerTime()

			if 0 < var_16_2 then
				if var_16_1 == 0 then
					var_16_1 = var_16_2
				else
					math = var_10
					var_16_1 = var_10.min(var_16_1, var_16_2)
				end
			end
		end
	end

	return var_16_1
end

function var_0_1.isClear(arg_17_0)
	if arg_17_0:getMapType() == var_0_1.SCENARIO then
		return arg_17_0:isAllChaptersClear()
	elseif arg_17_0:isActivity() then
		return arg_17_0:isClearForActivity()
	else
		return true
	end

	return
end

function var_0_1.isClearForActivity(arg_18_0)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.GetChapterItems(var_18_0)

	ipairs = var_18_0

	for iter_18_0, iter_18_1 in var_18_0(var_18_1) do
		if iter_18_0 > 1 and iter_18_1.id - var_18_1[iter_18_0 - 1].id > 1 then
			break
		elseif not iter_18_1:isClear() then
			return false
		end
	end

	return true
end

function var_0_1.isEliteEnabled(arg_19_0)
	local var_19_0

	if arg_19_0:getMapType() == var_0_1.ELITE then
		getProxy = var_2
		ChapterProxy = var_3

		local var_19_1 = var_2(var_3)

		var_19_0 = var_2.getMapById(var_19_1, arg_19_0:getBindMapId())
	else
		var_19_0 = arg_19_0
	end

	local var_19_2

	if var_19_0:isAllChaptersClear() then
		var_19_2 = var_19_0:isAllChaptersAchieve()
	end

	return var_19_2
end

function var_0_1.isAnyChapterUnlocked(arg_20_0, arg_20_1)
	local var_20_0 = false

	ipairs = var_1_10003

	for iter_20_0, iter_20_1 in var_1_10003(arg_20_0:GetChapterItems()) do
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

function var_0_1.isAnyChapterClear(arg_21_0)
	underscore = var_1_10001

	return var_1_10001.any(arg_21_0:GetChapterItems(), function(arg_22_0)
		return arg_22_0:isClear()
	end)
end

function var_0_1.isAllChaptersClear(arg_23_0)
	ipairs = var_1_10001

	for iter_23_0, iter_23_1 in var_1_10001(arg_23_0:GetChapterItems()) do
		if not iter_23_1:isClear() then
			return false
		end
	end

	return true
end

function var_0_1.isAllChaptersAchieve(arg_24_0)
	ipairs = var_1_10001

	for iter_24_0, iter_24_1 in var_1_10001(arg_24_0:getChapters()) do
		if not iter_24_1:isAllAchieve() then
			return false
		end
	end

	return true
end

function var_0_1.getLastUnlockChapterName(arg_25_0)
	local var_25_0

	ipairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_0:getChapters()) do
		if not iter_25_1:isUnlock() then
			break
		end

		var_25_0 = iter_25_1
	end

	return var_25_0:getConfig("chapter_name")
end

function var_0_1.GetChapterInProgress(arg_26_0)
	underscore = var_1_10001

	return var_1_10001.detect(arg_26_0:GetChapterItems(), function(arg_27_0)
		local var_27_0

		if arg_27_0:isUnlock() then
			var_27_0 = not arg_27_0:isClear()
		end

		return var_27_0
	end)
end

function var_0_1.GetChapterList(arg_28_0)
	return arg_28_0.chapterIds
end

var_0_1.NOT_REAR_CHAPTERS = {
	2100328,
	2100338,
	2100327,
	2100337,
	2100588,
	2100598,
	2100587,
	2100597
}

function var_0_1.GetRearChaptersOfRemaster(arg_29_0)
	if not arg_29_0 or arg_29_0 == 0 then
		return
	end

	getProxy = var_1_10001
	ChapterProxy = var_1_10002

	local var_29_0 = var_1_10001(var_1_10002)

	_ = var_1_10002

	local var_29_1 = var_1_10002.reduce

	BossRushChapterRemasterHelper = var_1_10003

	local var_29_2 = var_29_1(var_1_10003.GetChapterIds(arg_29_0), {}, function(arg_30_0, arg_30_1)
		local var_30_0 = var_29_0
		local var_30_1 = var_2.getChapterById(var_30_0, arg_30_1, true)
		local var_30_2 = var_2.getConfig(var_30_1, "map")
		local var_30_3 = var_29_0
		local var_30_4 = var_4.getMapById(var_30_3, var_30_2)
		local var_30_5

		if not arg_30_0[var_4.getConfig(var_30_4, "type")] then
			var_30_5 = {}
		end

		arg_30_0[var_5] = var_30_5
		table = var_30_5

		var_30_5.insert(arg_30_0[var_5], arg_30_1)

		return arg_30_0
	end)
	local var_29_3 = {}

	table = var_4

	var_4.Foreach(var_29_2, function(arg_31_0, arg_31_1)
		_ = var_2_10002

		local var_31_0 = var_2_10002.reduce(arg_31_1, {}, function(arg_32_0, arg_32_1)
			local var_32_0 = var_29_0
			local var_32_1 = var_2.getChapterById(var_32_0, arg_32_1, true)

			arg_32_0[var_2.getConfig(var_32_1, "pre_chapter")] = arg_32_1

			return arg_32_0
		end)

		_ = var_3

		local var_31_1 = var_3.filter(arg_31_1, function(arg_33_0)
			local var_33_0

			if not var_31_0[arg_33_0] then
				table = var_1
				var_33_0 = not var_1.contains(var_0_1.NOT_REAR_CHAPTERS, arg_33_0)
			else
				var_33_0 = false
			end

			if false then
				var_33_0 = true
			end

			return var_33_0
		end)

		table = var_4

		local var_31_2 = var_4.insert
		local var_31_3 = var_29_3

		_ = var_2_10006

		var_31_2(var_31_3, var_2_10006.max(var_31_1))

		return
	end)

	return var_29_3
end

function var_0_1.isActivity(arg_34_0)
	local var_34_0 = arg_34_0
	local var_34_1 = arg_34_0.getMapType(var_34_0)

	Map = var_34_0

	if var_34_1 == var_34_0.EVENT then
		do return true, false end

		goto label_34_0
	end

	Map = var_2

	if var_34_1 ~= var_2.ACTIVITY_EASY then
		Map = var_2

		if var_34_1 ~= var_2.ACTIVITY_HARD then
			Map = var_2

			if var_34_1 == var_2.ACT_EXTRA then
				return true, true
			else
				return false
			end

			::label_34_0::

			return
		end
	end
end

function var_0_1.isHardMap(arg_35_0)
	local var_35_0 = arg_35_0
	local var_35_1 = arg_35_0.getMapType(var_35_0)

	Map = var_35_0

	local var_35_2

	if var_35_1 ~= var_35_0.ELITE then
		Map = var_2

		if var_35_1 ~= var_2.ACTIVITY_HARD then
			var_35_2 = false

			goto label_35_0
		end
	end

	var_35_2 = true

	::label_35_0::

	return var_35_2
end

function var_0_1.isActExtra(arg_36_0)
	local var_36_0 = arg_36_0
	local var_36_1 = arg_36_0.getMapType(var_36_0)

	Map = var_36_0

	return var_36_1 == var_36_0.ACT_EXTRA
end

function var_0_1.isEscort(arg_37_0)
	local var_37_0 = arg_37_0
	local var_37_1 = arg_37_0.getMapType(var_37_0)

	Map = var_37_0

	return var_37_1 == var_37_0.ESCORT
end

function var_0_1.isSkirmish(arg_38_0)
	local var_38_0 = arg_38_0
	local var_38_1 = arg_38_0.getMapType(var_38_0)

	Map = var_38_0

	return var_38_1 == var_38_0.SKIRMISH
end

function var_0_1.isNormalMap(arg_39_0)
	table = var_1_10001

	local var_39_0 = var_1_10001.contains

	Map = var_1_10002

	return var_39_0(var_1_10002.NORMAL_MAP, arg_39_0:getMapType())
end

function var_0_1.NeedRecordMap(arg_40_0)
	return arg_40_0:getMapType() == var_0_1.INVALID or var_1 == var_0_1.SCENARIO or var_1 == var_0_1.ELITE
end

return var_0_1
