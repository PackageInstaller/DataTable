class = var_0_10000

local var_0_0 = "ChapterProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.CHAPTER_UPDATED = "ChapterProxy:CHAPTER_UPDATED"
var_0_1.CHAPTER_TIMESUP = "ChapterProxy:CHAPTER_TIMESUP"
var_0_1.CHAPTER_CELL_UPDATED = "ChapterProxy:CHAPTER_CELL_UPDATED"
var_0_1.CHAPTER_AUTO_FIGHT_FLAG_UPDATED = "CHAPTERPROXY:CHAPTER_AUTO_FIGHT_FLAG_UPDATED"
var_0_1.CHAPTER_SKIP_PRECOMBAT_UPDATED = "CHAPTERPROXY:CHAPTER_SKIP_PRECOMBAT_UPDATED"
var_0_1.CHAPTER_REMASTER_INFO_UPDATED = "CHAPTERPROXY:CHAPTER_REMASTER_INFO_UPDATED"
var_0_1.LAST_MAP_FOR_ACTIVITY = "last_map_for_activity"
var_0_1.LAST_MAP = "last_map"

function var_0_1.register(arg_1_0)
	arg_1_0:on(13001, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_2_0.mapEliteFleetCache = {}
		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(arg_2_0.fleet_list) do
			var_2_10006 = iter_2_1.id

			local var_2_1 = arg_1_0.mapEliteFleetCache

			Chapter = var_2_10008
			var_2_1[var_2_10006] = var_2_10008.BuildEliteFleetInfo(iter_2_1)
		end

		ipairs = var_1

		for iter_2_2, iter_2_3 in var_1(arg_2_0.chapter_list) do
			pg = var_2_10006

			if not var_2_10006.chapter_template[iter_2_3.id] then
				errorMsg = var_2_10006

				var_2_10006("chapter_template not exist: " .. iter_2_3.id)
			else
				Chapter = var_2_10006

				local var_2_2 = var_2_10006.New(iter_2_3)
				local var_2_3 = var_2_10006.getConfig(var_2_2, "formation")
				local var_2_4 = var_2_10006
				local var_2_5 = var_2_10006.setEliteFleetList

				Clone = var_2_10011

				var_2_5(var_2_4, var_2_10011(arg_1_0.mapEliteFleetCache[var_2_3]))

				local var_2_6 = arg_1_0

				var_8.updateChapter(var_2_6, var_2_10006)
			end
		end

		if arg_2_0.react_chapter then
			arg_1_0.remasterTickets = arg_2_0.react_chapter.count
			arg_1_0.remasterDailyCount = arg_2_0.react_chapter.daily_count
			arg_1_0.remasterTip = not (arg_1_0.remasterDailyCount > 0)
		end

		return
	end)
	arg_1_0:on(13000, function(arg_3_0)
		arg_1_0.repairTimes = arg_3_0.daily_repair_count

		if arg_3_0.current_chapter and arg_3_0.current_chapter.id > 0 then
			local var_3_0 = arg_1_0
			local var_3_1 = var_2.getChapterById(var_3_0, var_1, true)

			var_2.update(var_3_1, arg_3_0.current_chapter)

			local var_3_2 = arg_1_0

			var_3.updateChapter(var_3_2, var_2)
		end

		Map = var_1

		local var_3_3 = arg_1_0

		var_1.lastMap = var_2.getLastMap(var_3_3, var_0_1.LAST_MAP)
		Map = var_1

		local var_3_4 = arg_1_0

		var_1.lastMapForActivity = var_2.getLastMap(var_3_4, var_0_1.LAST_MAP_FOR_ACTIVITY)
		pg = var_1

		local var_3_5 = var_1.ShipFlagMgr.GetInstance()

		var_1.UpdateFlagShips(var_3_5, "inChapter")

		pg = var_1

		local var_3_6 = var_1.ShipFlagMgr.GetInstance()

		var_1.UpdateFlagShips(var_3_6, "inElite")

		pg = var_1

		local var_3_7 = var_1.ShipFlagMgr.GetInstance()

		var_1.UpdateFlagShips(var_3_7, "inSupport")

		return
	end)

	arg_1_0.timers = {}
	arg_1_0.escortChallengeTimes = 0
	arg_1_0.chaptersExtend = {}
	arg_1_0.chapterStoryGroups = {}
	arg_1_0.continuousData = {}

	arg_1_0:buildMaps()
	arg_1_0:buildRemasterInfo()

	return
end

function var_0_1.timeCall(arg_4_0)
	local var_4_0 = {}

	ProxyRegister = var_1_10002
	var_4_0[var_1_10002.DayCall] = function(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.resetRepairTimes(var_5_0)

		local var_5_1 = arg_4_0

		var_1.resetEscortChallengeTimes(var_5_1)

		local var_5_2 = arg_4_0
		local var_5_3 = var_1.getData(var_5_2)

		pairs = var_2_10002

		for iter_5_0, iter_5_1 in var_2_10002(var_5_3) do
			if iter_5_1.todayDefeatCount > 0 then
				iter_5_1.todayDefeatCount = 0

				local var_5_4 = arg_4_0

				var_7.updateChapter(var_5_4, iter_5_1)
			end
		end

		local var_5_5 = arg_4_0

		var_2.resetDailyCount(var_5_5)

		return
	end

	return var_4_0
end

function var_0_1.OnBattleFinished(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0:getActiveChapter() then
		local var_6_0 = 0

		local function var_6_1()
			getProxy = var_2_10000
			ContextProxy = var_2_10002

			if not var_2_10000(var_2_10002) then
				return
			end

			local var_7_0 = var_0
			local var_7_1 = var_0.getCurrentContext(var_7_0).mediator

			LevelMediator2 = var_7_0

			if var_7_1 == var_7_0 then
				bit = var_7_1

				local var_7_2 = var_7_1.bor
				local var_7_3 = var_6_0

				ChapterConst = var_2_10005
				var_2_10005 = var_2_10005.DirtyAttachment
				ChapterConst = var_2_10006
				var_6_0 = var_7_2(var_7_3, var_2_10005, var_2_10006.DirtyStrategy)

				local var_7_4 = arg_6_0

				var_2.SetChapterAutoFlag(var_7_4, var_0.id, false)

				return
			end

			local var_7_5 = var_0
			local var_7_6 = var_0.getContextByMediator

			LevelMediator2 = var_2_10005

			if not var_7_6(var_7_5, var_2_10005) then
				return
			end

			var_2.data.StopAutoFightFlag = true

			return
		end

		_ = var_1_10006

		if var_1_10006.any(arg_6_1.ai_list, function(arg_8_0)
			local var_8_0 = arg_8_0.item_type

			ChapterConst = var_2_10002

			return var_8_0 == var_2_10002.AttachOni
		end) then
			var_3:onOniEnter()
			var_6_1()
		end

		_ = var_6

		if var_6.any(arg_6_1.map_update, function(arg_9_0)
			local var_9_0 = arg_9_0.item_type

			ChapterConst = var_2_10002

			return var_9_0 == var_2_10002.AttachBomb_Enemy
		end) then
			var_3:onBombEnemyEnter()
			var_6_1()
		end

		local var_6_4

		if #arg_6_1.map_update > 0 then
			_ = var_6

			var_6.each(arg_6_1.map_update, function(arg_10_0)
				local var_10_0 = arg_10_0.item_type

				ChapterConst = var_2_10002

				if var_10_0 == var_2_10002.AttachStory then
					local var_10_1 = arg_10_0.item_data

					ChapterConst = var_2

					if var_10_1 == var_2.StoryTrigger then
						ChapterCell = var_10_1

						local var_10_2 = var_10_1.Line2Name(arg_10_0.pos.row, arg_10_0.pos.column)
						local var_10_3 = var_0

						if var_2.GetChapterCellAttachemnts(var_10_3)[var_10_2] then
							var_10_3 = var_3.flag
							ChapterConst = var_2_10005

							if var_10_3 == var_2_10005.CellFlagTriggerActive then
								var_10_3 = arg_10_0.item_flag
								ChapterConst = var_5

								if var_10_3 == var_5.CellFlagTriggerDisabled then
									pg = var_10_3

									if var_10_3.map_event_template[var_3.attachmentId].gametip ~= "" then
										pg = var_5

										local var_10_4 = var_5.TipsMgr.GetInstance()
										local var_10_5 = var_5.ShowTips

										i18n = var_2_10008

										var_10_5(var_10_4, var_2_10008(var_10_3))
									end
								end
							end

							var_3.attachment = arg_10_0.item_type
							var_3.attachmentId = arg_10_0.item_id
							var_3.flag = arg_10_0.item_flag
							var_3.data = arg_10_0.item_data
						else
							ChapterCell = var_10_3
							var_2[var_10_2] = var_10_3.New(arg_10_0)
						end

						goto label_10_0
					end
				end

				do
					local var_10_6 = arg_10_0.item_type

					ChapterConst = var_2

					if var_10_6 ~= var_2.AttachNone then
						local var_10_7 = arg_10_0.item_type

						ChapterConst = var_2

						if var_10_7 ~= var_2.AttachBorn then
							local var_10_8 = arg_10_0.item_type

							ChapterConst = var_2

							if var_10_8 ~= var_2.AttachBorn_Sub then
								local var_10_9 = arg_10_0.item_type

								ChapterConst = var_2

								if var_10_9 ~= var_2.AttachOni_Target then
									local var_10_10 = arg_10_0.item_type

									ChapterConst = var_2

									if var_10_10 ~= var_2.AttachOni then
										ChapterCell = var_10_10

										local var_10_11 = var_10_10.New(arg_10_0)
										local var_10_12 = var_0

										var_2.mergeChapterCell(var_10_12, var_10_11)
									end
								end
							end
						end
					end
				end

				::label_10_0::

				return
			end)

			bit = var_6

			local var_6_2 = var_6.bor
			local var_6_3 = var_6_0

			ChapterConst = var_6_4
			var_6_4 = var_6_4.DirtyAttachment
			ChapterConst = var_1_10010
			var_6_0 = var_6_2(var_6_3, var_6_4, var_1_10010.DirtyAutoAction)
		end

		if #arg_6_1.ai_list > 0 then
			_ = var_6

			var_6.each(arg_6_1.ai_list, function(arg_11_0)
				ChapterChampionPackage = var_2_10001

				local var_11_0 = var_2_10001.New(arg_11_0)
				local var_11_1 = var_0

				var_2.mergeChampion(var_11_1, var_11_0)

				return
			end)

			bit = var_6

			local var_6_5 = var_6.bor
			local var_6_6 = var_6_0

			ChapterConst = var_6_4
			var_6_4 = var_6_4.DirtyChampion
			ChapterConst = var_1_10010
			var_6_0 = var_6_5(var_6_6, var_6_4, var_1_10010.DirtyAutoAction)
		end

		if #arg_6_1.add_flag_list > 0 or #arg_6_1.del_flag_list > 0 then
			bit = var_6

			local var_6_7 = var_6.bor
			local var_6_8 = var_6_0

			ChapterConst = var_6_4

			local var_6_9 = var_6_4.DirtyFleet

			ChapterConst = var_1_10010
			var_1_10010 = var_1_10010.DirtyStrategy
			ChapterConst = var_1_10011
			var_1_10011 = var_1_10011.DirtyCellFlag
			ChapterConst = var_1_10012

			local var_6_10 = var_1_10012.DirtyFloatItems

			ChapterConst = var_1_10013

			local var_6_11 = var_1_10013.DirtyAttachment

			ChapterConst = var_1_10014
			var_6_0 = var_6_7(var_6_8, var_6_9, var_1_10010, var_1_10011, var_6_10, var_6_11, var_1_10014.DirtyWeather)

			arg_6_0:updateExtraFlag(var_3, arg_6_1.add_flag_list, arg_6_1.del_flag_list)
		end

		if #arg_6_1.buff_list > 0 then
			var_3:UpdateBuffList(arg_6_1.buff_list)
		end

		if #arg_6_1.cell_flag_list > 0 then
			_ = var_6

			var_6.each(arg_6_1.cell_flag_list, function(arg_12_0)
				local var_12_0 = var_0
				local var_12_1

				if var_1.getChapterCell(var_12_0, arg_12_0.pos.row, arg_12_0.pos.column) then
					var_12_1:updateFlagList(arg_12_0)
				else
					ChapterCell = var_2_10002
					var_12_1 = var_2_10002.New(arg_12_0)
				end

				local var_12_2 = var_0

				var_2.updateChapterCell(var_12_2, var_12_1)

				return
			end)

			bit = var_6

			local var_6_12 = var_6.bor
			local var_6_13 = var_6_0

			ChapterConst = var_9

			local var_6_14 = var_9.DirtyCellFlag

			ChapterConst = var_1_10010
			var_6_0 = var_6_12(var_6_13, var_6_14, var_1_10010.DirtyWeather)
		end

		arg_6_0:updateChapter(var_3, var_6_0)

		if arg_6_2 then
			local var_6_15 = arg_6_0
			local var_6_16 = arg_6_0.sendNotification

			GAME = var_9

			local var_6_17 = var_9.CHAPTER_OP_DONE
			local var_6_18 = {}

			ChapterConst = var_1_10011
			var_6_18.type = var_1_10011.OpSkipBattle

			var_6_16(var_6_15, var_6_17, var_6_18)
		end
	end

	return
end

function var_0_1.setEliteCache(arg_13_0, arg_13_1)
	arg_13_0.mapEliteFleetCache = {}
	ipairs = var_2

	for iter_13_0, iter_13_1 in var_2(arg_13_1) do
		local var_13_0 = iter_13_1.id
		local var_13_1 = arg_13_0.mapEliteFleetCache

		Chapter = var_1_10009
		var_13_1[var_13_0] = var_1_10009.BuildEliteFleetInfo(iter_13_1)
	end

	pg = var_2

	local var_13_2 = var_2.ShipFlagMgr.GetInstance()

	var_2.UpdateFlagShips(var_13_2, "inElite")

	pg = var_2

	local var_13_3 = var_2.ShipFlagMgr.GetInstance()

	var_2.UpdateFlagShips(var_13_3, "inSupport")

	pairs = var_2

	for iter_13_2, iter_13_3 in var_2(arg_13_0.data) do
		local var_13_4 = iter_13_3:getConfig("formation")
		local var_13_5 = iter_13_3
		local var_13_6 = iter_13_3.setEliteFleetList

		Clone = var_1_10011

		var_13_6(var_13_5, var_1_10011(arg_13_0.mapEliteFleetCache[var_13_4]))
		arg_13_0:updateChapter(iter_13_3)
	end

	return
end

function var_0_1.buildMaps(arg_14_0)
	arg_14_0:initChapters()
	arg_14_0:buildBaseMaps()
	arg_14_0:buildRemasterMaps()

	return
end

function var_0_1.initChapters(arg_15_0)
	local var_15_0 = var_0_1

	table = var_1_10002

	local var_15_1 = var_1_10002.shallowCopy

	pg = var_1_10004
	var_15_0.MapToChapters = var_15_1(var_1_10004.chapter_template.get_id_list_by_map)
	pairs = var_15_0
	pg = var_1_10003

	for iter_15_0, iter_15_1 in var_15_0(var_1_10003.story_group.get_id_list_by_map) do
		local var_15_2 = var_0_1.MapToChapters
		local var_15_3

		if not var_0_1.MapToChapters[iter_15_0] then
			var_15_3 = {}
		end

		var_15_2[iter_15_0] = var_15_3
		table = var_15_2

		var_15_2.insertto(var_0_1.MapToChapters[iter_15_0], iter_15_1)
	end

	local var_15_4 = var_0_1

	pg = var_2
	var_15_4.FormationToChapters = var_2.chapter_template.get_id_list_by_formation

	return
end

function var_0_1.buildBaseMaps(arg_16_0)
	var_0_1.ActToMaps = {}
	var_0_1.TypeToMaps = {}

	local var_16_0 = {}

	ipairs = var_2
	pg = var_1_10004

	for iter_16_0, iter_16_1 in var_2(var_1_10004.expedition_data_by_map.all) do
		Map = var_1_10007
		var_16_0[iter_16_1] = var_1_10007.New({
			id = iter_16_1,
			chapterIds = var_0_1.MapToChapters[iter_16_1]
		})

		if var_1_10007:getConfig("on_activity") ~= 0 then
			local var_16_1 = var_0_1.ActToMaps
			local var_16_2

			if not var_0_1.ActToMaps[var_8] then
				var_16_2 = {}
			end

			var_16_1[var_8] = var_16_2
			table = var_16_1

			var_16_1.insert(var_0_1.ActToMaps[var_8], var_1_10007.id)
		end

		local var_16_3 = var_1_10007:getMapType()
		local var_16_4 = var_0_1.TypeToMaps
		local var_16_5

		if not var_0_1.TypeToMaps[var_16_3] then
			var_16_5 = {}
		end

		var_16_4[var_16_3] = var_16_5
		table = var_16_4

		var_16_4.insert(var_0_1.TypeToMaps[var_16_3], var_1_10007.id)
	end

	arg_16_0.baseMaps = var_16_0

	return
end

function var_0_1.buildRemasterMaps(arg_17_0)
	var_0_1.RemasterToMaps = {}

	local var_17_0 = {}

	_ = var_2

	local var_17_1 = var_2.each

	BossRushChapterRemasterHelper = var_1_10004

	var_17_1(var_1_10004.GetAllNonActivityIds(), function(arg_18_0)
		pg = var_2_10001

		local var_18_0 = var_2_10001.re_map_template[arg_18_0]

		_ = var_2_10002

		var_2_10002.each(var_18_0.config_data, function(arg_19_0)
			local var_19_0 = arg_17_0.baseMaps

			pg = var_3_10002

			local var_19_1 = var_19_0[var_3_10002.chapter_template[arg_19_0].map]

			assert = var_2

			var_2(not var_17_0[var_19_1.id] or var_17_0[var_19_1.id] == arg_18_0, "remaster chapter error:" .. arg_19_0)

			if not var_17_0[var_19_1.id] then
				var_17_0[var_19_1.id] = arg_18_0

				var_19_1:setRemaster(arg_18_0)

				local var_19_2 = var_0_1.RemasterToMaps
				local var_19_3 = arg_18_0
				local var_19_4

				if not var_0_1.RemasterToMaps[arg_18_0] then
					var_19_4 = {}
				end

				var_19_2[var_19_3] = var_19_4
				table = var_19_2

				var_19_2.insert(var_0_1.RemasterToMaps[arg_18_0], var_19_1.id)
			end

			return
		end)

		return
	end)

	return
end

function var_0_1.IsChapterInRemaster(arg_20_0, arg_20_1)
	_ = var_1_10002

	local var_20_0 = var_1_10002.detect

	BossRushChapterRemasterHelper = var_1_10004

	return var_20_0(var_1_10004.GetAllNonActivityIds(), function(arg_21_0)
		pg = var_2_10001

		local var_21_0 = var_2_10001.re_map_template[arg_21_0]

		_ = var_2_10002

		return var_2_10002.any(var_21_0.config_data, function(arg_22_0)
			return arg_22_0 == arg_20_1
		end)
	end)
end

function var_0_1.getMaxEscortChallengeTimes(arg_23_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_23_0 = var_1_10001(var_1_10003)
	local var_23_1

	if not var_1.getActivityParameter(var_23_0, "escort_daily_count") then
		var_23_1 = 0
	end

	return var_23_1
end

function var_0_1.getEscortChapterIds(arg_24_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_24_0 = var_1_10001(var_1_10003)
	local var_24_1

	if not var_1.getActivityParameter(var_24_0, "escort_exp_id") then
		var_24_1 = {}
	end

	return var_24_1
end

function var_0_1.resetEscortChallengeTimes(arg_25_0)
	arg_25_0.escortChallengeTimes = 0

	return
end

function var_0_1.addChapterListener(arg_26_0, arg_26_1)
	if not arg_26_1.dueTime or not arg_26_0.timers then
		return
	end

	if arg_26_0.timers[arg_26_1.id] then
		local var_26_0 = arg_26_0.timers[arg_26_1.id]

		var_2.Stop(var_26_0)

		arg_26_0.timers[arg_26_1.id] = nil
	end

	local var_26_1 = arg_26_1.dueTime

	pg = var_3

	local var_26_2 = var_3.TimeMgr.GetInstance()
	local var_26_3 = var_26_1 - var_3.GetServerTime(var_26_2)

	local function var_26_4()
		arg_26_0.data[arg_26_1.id].dueTime = nil

		local var_27_0 = arg_26_0.data[arg_26_1.id]

		var_0.display(var_27_0, "times'up")

		local var_27_1 = arg_26_0
		local var_27_2 = var_0.sendNotification
		local var_27_3 = var_0_1.CHAPTER_UPDATED
		local var_27_4 = {
			dirty = 0
		}
		local var_27_5 = arg_26_0.data[arg_26_1.id]

		var_27_4.chapter = var_5.clone(var_27_5)

		var_27_2(var_27_1, var_27_3, var_27_4)

		local var_27_6 = arg_26_0

		var_0.sendNotification(var_27_6, var_0_1.CHAPTER_TIMESUP)

		return
	end

	if var_26_3 > 0 then
		local var_26_5 = arg_26_0.timers
		local var_26_6 = arg_26_1.id

		Timer = var_1_10006
		var_26_5[var_26_6] = var_1_10006.New(function()
			var_26_4()

			local var_28_0 = arg_26_0.timers[arg_26_1.id]

			var_0.Stop(var_28_0)

			arg_26_0.timers[arg_26_1.id] = nil

			return
		end, var_26_3, 1)

		local var_26_7 = arg_26_0.timers[arg_26_1.id]

		var_4.Start(var_26_7)
	else
		var_26_4()
	end

	return
end

function var_0_1.removeChapterListener(arg_29_0, arg_29_1)
	if arg_29_0.timers[arg_29_1] then
		local var_29_0 = arg_29_0.timers[arg_29_1]

		var_2.Stop(var_29_0)

		arg_29_0.timers[arg_29_1] = nil
	end

	return
end

function var_0_1.remove(arg_30_0)
	pairs = var_1_10001

	for iter_30_0, iter_30_1 in var_1_10001(arg_30_0.timers) do
		iter_30_1:Stop()
	end

	arg_30_0.timers = nil

	return
end

function var_0_1.GetRawChapterById(arg_31_0, arg_31_1)
	return arg_31_0.data[arg_31_1]
end

function var_0_1.getChapterById(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_0.data[arg_32_1] then
		assert = var_1_10004
		pg = var_1_10006

		var_1_10004(var_1_10006.chapter_template[arg_32_1], "Not Exist Chapter ID: " .. (arg_32_1 or "NIL"))

		Chapter = var_1_10004

		local var_32_0 = var_1_10004.New({
			id = arg_32_1
		})
		local var_32_1 = var_3.getConfig(var_32_0, "formation")
		local var_32_2 = var_3:getConfig("type")

		Chapter = var_32_0

		if var_32_2 == var_32_0.CustomFleet or var_3:GetSupportFleetMaxCount() > 0 then
			local var_32_3 = var_3
			local var_32_4 = var_3.setEliteFleetList

			Clone = var_8

			var_32_4(var_32_3, var_8(arg_32_0.mapEliteFleetCache[var_32_1]))
		end

		arg_32_0.data[arg_32_1] = var_3
	end

	return arg_32_2 and var_3 or var_3:clone()
end

function var_0_1.GetChapterItemById(arg_33_0, arg_33_1)
	Chapter = var_1_10002

	if var_1_10002:bindConfigTable()[arg_33_1] then
		return arg_33_0:getChapterById(arg_33_1, true)
	else
		ChapterStoryGroup = var_2

		if var_2:bindConfigTable()[arg_33_1] then
			local var_33_0

			if not arg_33_0.chapterStoryGroups[arg_33_1] then
				ChapterStoryGroup = var_1_10003
				var_33_0 = var_1_10003.New({
					configId = arg_33_1
				})
				arg_33_0.chapterStoryGroups[arg_33_1] = var_33_0
			end

			return var_33_0
		end
	end

	return
end

function var_0_1.updateChapter(arg_34_0, arg_34_1, arg_34_2)
	assert = var_1_10003
	isa = var_1_10005

	local var_34_0 = arg_34_1

	Chapter = var_1_10008

	var_1_10003(var_1_10005(var_34_0, var_1_10008), "should be an instance of Chapter")

	local var_34_1 = arg_34_0.data[arg_34_1.id]
	local var_34_2 = arg_34_1

	arg_34_0.data[arg_34_1.id] = var_34_2

	if var_34_1 then
		arg_34_0:removeChapterListener(var_34_1.id)
	end

	local var_34_3 = arg_34_0

	arg_34_0.addChapterListener(var_34_3, var_34_2)

	getProxy = var_5
	PlayerProxy = var_34_3

	local var_34_4 = var_5(var_34_3)

	if var_5.getInited(var_34_4) then
		var_34_4 = arg_34_0.facade

		local var_34_5 = var_5.sendNotification
		local var_34_6 = var_0_1.CHAPTER_UPDATED
		local var_34_7 = {
			chapter = var_34_2:clone()
		}

		defaultValue = var_10
		var_34_7.dirty = var_10(arg_34_2, 0)

		var_34_5(var_34_4, var_34_6, var_34_7)
	end

	if var_34_2.active and var_34_2.fleet then
		var_34_4 = var_34_2.fleet

		var_5.clearShipHpChange(var_34_4)
	end

	tobool = var_5
	checkExist = var_34_4

	local var_34_8 = var_5(var_34_4(var_34_1, {
		"active"
	}))

	tobool = var_6

	if var_34_8 ~= var_6(var_34_2.active) then
		pg = var_34_8

		local var_34_9 = var_34_8.ShipFlagMgr.GetInstance()

		var_5.UpdateFlagShips(var_34_9, "inChapter")
	end

	return
end

function var_0_1.getMapById(arg_35_0, arg_35_1)
	return arg_35_0.baseMaps[arg_35_1]
end

function var_0_1.getNormalMaps(arg_36_0)
	local var_36_0 = {}

	ipairs = var_1_10002

	for iter_36_0, iter_36_1 in var_1_10002(arg_36_0.baseMaps) do
		table = var_1_10007

		var_1_10007.insert(var_36_0, iter_36_1)
	end

	return var_36_0
end

function var_0_1.getMapsByType(arg_37_0, arg_37_1)
	if var_0_1.TypeToMaps[arg_37_1] then
		_ = var_2

		return var_2.map(var_0_1.TypeToMaps[arg_37_1], function(arg_38_0)
			local var_38_0 = arg_37_0

			return var_1.getMapById(var_38_0, arg_38_0)
		end)
	else
		return {}
	end

	return
end

function var_0_1.getMapsByActId(arg_39_0, arg_39_1)
	if var_0_1.ActToMaps[arg_39_1] then
		underscore = var_2

		return var_2.map(var_0_1.ActToMaps[arg_39_1], function(arg_40_0)
			local var_40_0 = arg_39_0

			return var_1.getMapById(var_40_0, arg_40_0)
		end)
	else
		return {}
	end

	return
end

function var_0_1.getRemasterMaps(arg_41_0, arg_41_1)
	if var_0_1.RemasterToMaps[arg_41_1] then
		underscore = var_2

		return var_2.map(var_0_1.RemasterToMaps[arg_41_1], function(arg_42_0)
			local var_42_0 = arg_41_0

			return var_1.getMapById(var_42_0, arg_42_0)
		end)
	else
		return {}
	end

	return
end

function var_0_1.getMapsByActivities(arg_43_0, arg_43_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_43_0 = var_1_10002(var_1_10004)
	local var_43_1

	if arg_43_1 then
		var_1_10006 = var_43_0
		var_43_1 = var_43_0.getActivityById(var_1_10006, arg_43_1)
	else
		var_1_10006 = var_43_0
		var_1_10004 = var_43_0.getActivitiesByType
		ActivityConst = var_1_10007
		var_1_10004 = var_1_10004(var_1_10006, var_1_10007.ACTIVITY_TYPE_ZPROJECT)
		table = var_1_10005

		local var_43_2 = var_1_10005.sort
		local var_43_3 = var_1_10004

		CompareFuncs = var_1_10008

		var_43_2(var_43_3, var_1_10008({
			function(arg_44_0)
				defaultValue = var_2_10001

				return var_2_10001(arg_44_0:GetConfigClientSetting("order"), 1)
			end
		}))

		var_43_1 = var_1_10004[1]
	end

	if not var_43_1 then
		return {}
	end

	pg = var_1_10004

	local var_43_4 = var_1_10004.chapter_template[var_43_1:getConfig("config_data")[1]].map

	pg = var_5

	local var_43_5 = var_5.expedition_data_by_map[var_43_4].on_activity

	getProxy = var_1_10006
	ActivityProxy = var_8

	local var_43_6 = var_1_10006(var_8)

	if var_6.IsActivityNotEnd(var_43_6, var_43_5) then
		return arg_43_0:getMapsByActId(var_43_5)
	else
		return {}
	end

	return
end

function var_0_1.getLastUnlockMap(arg_45_0)
	local var_45_0

	ipairs = var_1_10002

	for iter_45_0, iter_45_1 in var_1_10002(arg_45_0:getNormalMaps()) do
		if not iter_45_1:isUnlock() then
			break
		end

		var_45_0 = iter_45_1
	end

	return var_45_0
end

function var_0_1.updateExtraFlag(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	underscore = var_1_10005

	local var_46_0 = var_1_10005.to_array(arg_46_1:getExtraFlags())
	local var_46_1 = arg_46_1
	local var_46_2 = arg_46_1.updateExtraFlags(var_46_1, arg_46_2, arg_46_3)

	if not arg_46_4 and not var_46_2 then
		return
	end

	local var_46_3 = {}

	ipairs = var_46_1

	for iter_46_0, iter_46_1 in var_46_1(arg_46_1:getExtraFlags()) do
		table = var_1_10013

		if not var_1_10013.contains(var_46_0, iter_46_1) then
			table = var_1_10013

			var_1_10013.insert(var_46_3, iter_46_1)
		end
	end

	arg_46_0:SetExtendChapterData(arg_46_1.id, "extraFlagUpdate", var_46_3)

	return true
end

function var_0_1.extraFlagUpdated(arg_47_0, arg_47_1)
	arg_47_0:RemoveExtendChapterData(arg_47_1, "extraFlagUpdate")

	return
end

function var_0_1.getUpdatedExtraFlags(arg_48_0, arg_48_1)
	return arg_48_0:GetExtendChapterData(arg_48_1, "extraFlagUpdate")
end

function var_0_1.SetExtendChapterData(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	assert = var_1_10004

	var_1_10004(arg_49_1, "Missing Chapter ID")

	local var_49_0 = arg_49_0.chaptersExtend
	local var_49_1

	if not arg_49_0.chaptersExtend[arg_49_1] then
		var_49_1 = {}
	end

	var_49_0[arg_49_1] = var_49_1
	arg_49_0.chaptersExtend[arg_49_1][arg_49_2] = arg_49_3

	return
end

function var_0_1.AddExtendChapterDataArray(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4)
	assert = var_1_10005

	var_1_10005(arg_50_1, "Missing Chapter ID")

	local var_50_0 = arg_50_0.chaptersExtend
	local var_50_1

	if not arg_50_0.chaptersExtend[arg_50_1] then
		var_50_1 = {}
	end

	var_50_0[arg_50_1] = var_50_1
	type = var_50_0

	if var_50_0(arg_50_0.chaptersExtend[arg_50_1][arg_50_2]) ~= "table" then
		assert = var_5

		var_5(arg_50_0.chaptersExtend[arg_50_1][arg_50_2] == nil, "Changing NonEmpty ExtendData " .. arg_50_2 .. " to Table ID: " .. arg_50_1)

		arg_50_0.chaptersExtend[arg_50_1][arg_50_2] = {}
	end

	arg_50_4 = arg_50_4 or #arg_50_0.chaptersExtend[arg_50_1][arg_50_2] + 1
	arg_50_0.chaptersExtend[arg_50_1][arg_50_2][arg_50_4] = arg_50_3

	return
end

function var_0_1.AddExtendChapterDataTable(arg_51_0, arg_51_1, arg_51_2, arg_51_3, arg_51_4)
	assert = var_1_10005

	var_1_10005(arg_51_1, "Missing Chapter ID")

	local var_51_0 = arg_51_0.chaptersExtend
	local var_51_1

	if not arg_51_0.chaptersExtend[arg_51_1] then
		var_51_1 = {}
	end

	var_51_0[arg_51_1] = var_51_1
	type = var_51_0

	local var_51_2

	if var_51_0(arg_51_0.chaptersExtend[arg_51_1][arg_51_2]) ~= "table" then
		assert = var_51_2

		var_51_2(arg_51_0.chaptersExtend[arg_51_1][arg_51_2] == nil, "Changing NonEmpty ExtendData " .. arg_51_2 .. " to Table ID: " .. arg_51_1)

		var_51_2 = arg_51_0.chaptersExtend[arg_51_1]
		var_51_2[arg_51_2] = {}
	end

	assert = var_51_2

	var_51_2(arg_51_3, "Missing Index on Set HashData")

	arg_51_0.chaptersExtend[arg_51_1][arg_51_2][arg_51_3] = arg_51_4

	return
end

function var_0_1.GetExtendChapterData(arg_52_0, arg_52_1, arg_52_2)
	assert = var_1_10003

	var_1_10003(arg_52_1, "Missing Chapter ID")

	assert = var_1_10003

	var_1_10003(arg_52_2, "Requesting Empty key")

	if not arg_52_2 or not arg_52_0.chaptersExtend[arg_52_1] then
		return
	end

	return arg_52_0.chaptersExtend[arg_52_1][arg_52_2]
end

function var_0_1.RemoveExtendChapterData(arg_53_0, arg_53_1, arg_53_2)
	assert = var_1_10003

	var_1_10003(arg_53_1, "Missing Chapter ID")

	if not arg_53_2 or not arg_53_0.chaptersExtend[arg_53_1] then
		return
	end

	local var_53_0 = arg_53_0.chaptersExtend[arg_53_1]

	var_53_0[arg_53_2] = nil
	next = var_53_0

	if var_53_0(arg_53_0.chaptersExtend[arg_53_1]) then
		return
	end

	arg_53_0:RemoveExtendChapter(arg_53_1)

	return
end

function var_0_1.GetExtendChapter(arg_54_0, arg_54_1)
	assert = var_1_10002

	var_1_10002(arg_54_1, "Missing Chapter ID")

	return arg_54_0.chaptersExtend[arg_54_1]
end

function var_0_1.RemoveExtendChapter(arg_55_0, arg_55_1)
	assert = var_1_10002

	var_1_10002(arg_55_1, "Missing Chapter ID")

	if not arg_55_0.chaptersExtend[arg_55_1] then
		return
	end

	arg_55_0.chaptersExtend[arg_55_1] = nil

	return
end

function var_0_1.duplicateEliteFleet(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_1:getConfig("type")

	Chapter = var_1_10003

	if var_56_0 ~= var_1_10003.CustomFleet and arg_56_1:GetSupportFleetMaxCount() == 0 then
		return
	end

	local var_56_1 = arg_56_1
	local var_56_2 = arg_56_1.getConfig(var_56_1, "formation")
	local var_56_3 = arg_56_0.mapEliteFleetCache

	Clone = var_56_1
	var_56_3[var_56_2] = var_56_1(arg_56_1.eliteFleetList)
	pg = var_56_3

	local var_56_4 = var_56_3.ShipFlagMgr.GetInstance()

	var_3.UpdateFlagShips(var_56_4, "inElite")

	pg = var_3

	local var_56_5 = var_3.ShipFlagMgr.GetInstance()

	var_3.UpdateFlagShips(var_56_5, "inSupport")

	ipairs = var_3

	for iter_56_0, iter_56_1 in var_3(var_0_1.FormationToChapters[var_56_2]) do
		if arg_56_0:getChapterById(iter_56_1, true).configId ~= arg_56_1.configId then
			local var_56_6 = var_8
			local var_56_7 = var_8.setEliteFleetList

			Clone = var_12

			var_56_7(var_56_6, var_12(arg_56_1.eliteFleetList))
			arg_56_0:updateChapter(var_8)
		end
	end

	return
end

function var_0_1.RemoveUnitFromSupportFleet(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0
	local var_57_1 = arg_57_0.sendNotification

	GAME = var_1_10005

	var_57_1(var_57_0, var_1_10005.REMOVE_ELITE_TARGET_SHIP, {
		shipId = arg_57_1.id
	})

	return
end

function var_0_1.getActiveChapter(arg_58_0, arg_58_1)
	pairs = var_1_10002

	for iter_58_0, iter_58_1 in var_1_10002(arg_58_0.data) do
		if iter_58_1.active then
			return arg_58_1 and iter_58_1 or iter_58_1:clone()
		end
	end

	return
end

function var_0_1.GetLastNormalMap(arg_59_0)
	Map = var_1_10001

	local var_59_0

	if var_1_10001.lastMap then
		var_1_10003 = arg_59_0
		var_59_0 = arg_59_0.getMapById
		Map = var_1_10004
		var_59_0 = var_59_0(var_1_10003, var_1_10004.lastMap)
	end

	if var_59_0 and var_59_0:isUnlock() then
		local var_59_1 = var_59_0:getMapType()

		Map = var_1_10003

		if var_59_1 == var_1_10003.SCENARIO then
			Map = var_59_1

			return var_59_1.lastMap
		end
	end

	return arg_59_0:getLastUnlockMap().id
end

function var_0_1.getLastMapForActivity(arg_60_0, arg_60_1)
	local var_60_0
	local var_60_1

	if arg_60_0:getActiveChapter() then
		local var_60_2 = arg_60_0:getMapById(var_3:getConfig("map"))

		if var_60_0.isActivity(var_60_2) and not var_60_0:isRemaster() then
			return var_60_0.id, var_3.id
		end
	end

	Map = var_4

	local var_60_4

	if var_4.lastMapForActivity then
		::label_60_0::

		local var_60_3 = arg_60_0

		var_60_4 = arg_60_0.getMapById
		Map = var_1_10007
		var_60_0 = var_60_4(var_60_3, var_1_10007.lastMapForActivity)
	end

	if var_60_0 and not var_60_0:isRemaster() and var_60_0:isUnlock() and (not arg_60_1 or var_60_0:getConfig("on_activity") == arg_60_1) then
		Map = var_60_4

		return var_60_4.lastMapForActivity
	end

	Map = var_60_4

	if var_60_4.lastMapForActivity then
		arg_60_0:recordLastMap(var_0_1.LAST_MAP_FOR_ACTIVITY, 0)
	end

	return arg_60_0:getActivityLastUnlockMap(arg_60_1)
end

function var_0_1.getActivityLastUnlockMap(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0:getMapsByActivities(arg_61_1)

	_ = var_1_10003

	if not var_1_10003.all(var_61_0, function(arg_62_0)
		local var_62_0 = arg_62_0:getConfig("type")

		Map = var_2_10002

		return var_62_0 == var_2_10002.EVENT
	end) then
		ipairs = var_3

		local var_61_1 = {}

		Map = var_6
		var_61_1[1] = var_6.ACTIVITY_EASY
		Map = var_6
		var_61_1[2] = var_6.ACTIVITY_HARD

		for iter_61_0, iter_61_1 in var_3(var_61_1) do
			underscore = var_1_10008

			if #var_1_10008.filter(var_61_0, function(arg_63_0)
				return arg_63_0:getMapType() == iter_61_1
			end) > 0 then
				underscore = var_9

				if var_9.any(var_1_10008, function(arg_64_0)
					return not arg_64_0:isClearForActivity()
				end) then
					var_61_0 = var_1_10008

					break
				end
			end
		end
	end

	for iter_61_2 = #var_61_0, 1, -1 do
		local var_61_2 = var_61_0[iter_61_2]

		if var_7.isUnlock(var_61_2) then
			return var_7.id
		end
	end

	if #var_61_0 > 0 then
		return var_61_0[1].id
	end

	return
end

function var_0_1.updateActiveChapterShips(arg_65_0)
	if arg_65_0:getActiveChapter(true) then
		_ = var_1_10002

		var_1_10002.each(var_1.fleets, function(arg_66_0)
			arg_66_0:flushShips()

			return
		end)

		local var_65_0 = arg_65_0
		local var_65_1 = arg_65_0.updateChapter
		local var_65_2 = var_1

		ChapterConst = var_1_10006

		var_65_1(var_65_0, var_65_2, var_1_10006.DirtyFleet)
	end

	return
end

function var_0_1.resetRepairTimes(arg_67_0)
	arg_67_0.repairTimes = 0

	return
end

function var_0_1.getUseableEliteMap(arg_68_0)
	local var_68_0 = {}

	ipairs = var_1_10002

	local var_68_1 = arg_68_0
	local var_68_2 = arg_68_0.getMapsByType

	Map = var_1_10007

	for iter_68_0, iter_68_1 in var_1_10002(var_68_2(var_68_1, var_1_10007.ELITE)) do
		if iter_68_1:isEliteEnabled() then
			var_68_0[#var_68_0 + 1] = iter_68_1
		end
	end

	return var_68_0
end

function var_0_1.getUseableMaxEliteMap(arg_69_0)
	local var_69_0 = arg_69_0

	if #arg_69_0.getUseableEliteMap(var_69_0) == 0 then
		return false
	else
		local var_69_1

		ipairs = var_69_0

		for iter_69_0, iter_69_1 in var_69_0(var_1) do
			if not var_69_1 or var_69_1.id < iter_69_1.id then
				var_69_1 = iter_69_1
			end
		end

		return var_69_1
	end

	return
end

function var_0_1.getHigestClearChapterAndMap(arg_70_0)
	local var_70_0 = arg_70_0.baseMaps[1]

	ipairs = var_1_10002

	for iter_70_0, iter_70_1 in var_1_10002(arg_70_0:getNormalMaps()) do
		if not iter_70_1:isAnyChapterClear() then
			break
		end

		var_70_0 = iter_70_1
	end

	local var_70_1 = arg_70_0:getChapterById(var_70_0.chapterIds[1])

	ipairs = var_3

	for iter_70_2, iter_70_3 in var_3(var_70_0:getChapters()) do
		if not iter_70_3:isClear() then
			break
		end

		var_70_1 = iter_70_3
	end

	return var_70_1, var_70_0
end

function var_0_1.SortRecommendLimitation(arg_71_0)
	table = var_1_10001

	local var_71_0 = var_1_10001.sort
	local var_71_1 = arg_71_0

	CompareFuncs = var_1_10004

	var_71_0(var_71_1, var_1_10004({
		function(arg_72_0)
			type = var_2_10001

			if var_2_10001(arg_72_0) == "number" then
				if arg_72_0 == 0 then
					return 1
				else
					return -arg_72_0
				end
			else
				type = var_1

				if var_1(arg_72_0) == "string" then
					return 0
				else
					assert = var_1

					var_1(false)
				end
			end

			return
		end
	}))

	return
end

function var_0_1.eliteFleetRecommend(arg_73_0, arg_73_1, arg_73_2)
	local var_73_0 = {}

	ipairs = var_1_10004

	for iter_73_0, iter_73_1 in var_1_10004(arg_73_1:getEliteFleetList()) do
		ipairs = var_1_10009

		for iter_73_2, iter_73_3 in var_1_10009(iter_73_1) do
			var_73_0[#var_73_0 + 1] = iter_73_3
		end
	end

	local function var_73_1(arg_74_0, arg_74_1, arg_74_2, arg_74_3)
		arg_74_3 = arg_74_3 or "inElite"

		local var_74_0 = arg_73_0

		return var_4.FleetRecommend(var_74_0, arg_74_0, var_73_0, arg_74_2, arg_74_1, function(arg_75_0)
			ShipStatus = var_3_10001

			local var_75_0 = var_3_10001.ShipStatusCheck
			local var_75_1 = arg_74_3
			local var_75_2 = arg_75_0
			local var_75_3
			local var_75_4 = {}
			local var_75_5 = arg_74_3
			local var_75_6 = arg_73_1

			var_75_4[var_75_5] = var_8.getConfig(var_75_6, "formation")

			return var_75_0(var_75_1, var_75_2, var_75_3, var_75_4)
		end)
	end

	local var_73_2 = arg_73_1
	local var_73_3, var_73_4 = arg_73_1.getEliteTeamByIndex(var_73_2, arg_73_2)

	table = var_73_2

	local var_73_5 = var_73_2.insertto

	TeamType = var_1_10009

	local var_73_6 = var_73_3[var_1_10009.FormShips]

	switch = var_1_10010

	local var_73_7 = var_73_4
	local var_73_8 = {}

	FleetType = var_1_10014
	var_73_8[var_1_10014.Normal] = function()
		local var_76_0 = arg_73_1

		if var_0.getConfig(var_76_0, "limitation")[arg_73_2] then
			Clone = var_1

			local var_76_1

			if not var_1(var_0[1]) then
				var_76_1 = {
					0,
					0,
					0
				}
			end

			if var_0 then
				Clone = var_76_0

				local var_76_2

				if not var_76_0(var_0[2]) then
					var_76_2 = {
						0,
						0,
						0
					}
				end

				var_0_1.SortRecommendLimitation(var_76_1)
				var_0_1.SortRecommendLimitation(var_76_2)

				local var_76_3 = {}

				getProxy = var_2_10004
				BayProxy = var_2_10006

				local var_76_4 = var_2_10004(var_2_10006)
				local var_76_5 = var_4.getRawData(var_76_4)

				pairs = var_5

				local var_76_6 = {}

				TeamType = var_2_10008

				local var_76_7 = var_2_10008.Main
				local var_76_8 = {
					var_76_1
				}

				ShipType = var_2_10010
				var_76_8[2] = var_2_10010.MainShipType
				var_76_6[var_76_7] = var_76_8
				TeamType = var_76_7

				local var_76_9 = var_76_7.Vanguard
				local var_76_10 = {
					var_76_2
				}

				ShipType = var_10
				var_76_10[2] = var_10.VanguardShipType
				var_76_6[var_76_9] = var_76_10

				for iter_76_0, iter_76_1 in var_5(var_76_6) do
					unpack = var_76_11

					local var_76_11, var_76_12 = var_76_11(iter_76_1)

					table = var_12

					local var_76_13 = var_12.insertto
					local var_76_14 = var_76_3
					local var_76_15 = var_73_1

					underscore = var_2_10017
					var_2_10017 = var_2_10017.filter

					local var_76_16 = var_73_3

					TeamType = var_2_10020

					var_76_13(var_76_14, var_76_15(var_2_10017(var_76_16[var_2_10020.FormShips], function(arg_77_0)
						local var_77_1

						if var_76_5[arg_77_0] then
							local var_77_0 = var_76_5[arg_77_0]

							var_77_1 = var_1.getTeamType(var_77_0) == iter_76_0
						end

						return var_77_1
					end), var_76_11, var_76_12))
				end

				return var_76_3
			end
		end
	end
	FleetType = var_14
	var_73_8[var_14.Submarine] = function()
		local var_78_0 = {
			0,
			0,
			0
		}
		local var_78_1 = var_73_1
		local var_78_2 = var_73_3

		TeamType = var_2_10004

		local var_78_3 = var_78_2[var_2_10004.FormShips]
		local var_78_4 = var_78_0

		ShipType = var_2_10005

		return var_78_1(var_78_3, var_78_4, var_2_10005.SubShipType)
	end
	FleetType = var_14
	var_73_8[var_14.Support] = function()
		local var_79_0 = arg_73_1
		local var_79_1

		if not var_0.getConfigMiscArg(var_79_0, "submarine_support") or not {
			"qian",
			"qian",
			"qian"
		} then
			var_79_1 = {
				"hang",
				"hang",
				"hang"
			}
		end

		local var_79_2 = var_73_1
		local var_79_3 = var_73_3

		TeamType = var_2_10004

		local var_79_4 = var_79_3[var_2_10004.FormShips]
		local var_79_5 = var_79_1

		ShipType = var_2_10005

		return var_79_2(var_79_4, var_79_5, var_2_10005.AllShipType, "inSupport")
	end

	var_73_5(var_73_6, var_1_10010(var_73_7, var_73_8))

	return
end

function var_0_1.FleetRecommend(arg_80_0, arg_80_1, arg_80_2, arg_80_3, arg_80_4, arg_80_5)
	table = var_1_10006
	arg_80_2 = var_1_10006.shallowCopy(arg_80_2)
	getProxy = var_6
	BayProxy = var_8

	local var_80_0 = var_6(var_8)

	getProxy = var_1_10007
	BayProxy = var_1_10009

	local var_80_1 = var_1_10007(var_1_10009)
	local var_80_2 = var_7.getRawData(var_80_1)

	ipairs = var_8

	for iter_80_0, iter_80_1 in var_8(arg_80_1) do
		local var_80_3 = var_80_2[iter_80_1]
		local var_80_4 = var_13.getShipType(var_80_3)

		ipairs = var_1_10014

		for iter_80_2, iter_80_3 in var_1_10014(arg_80_4) do
			ShipType = var_1_10019

			if var_1_10019.ContainInLimitBundle(iter_80_3, var_80_4) then
				table = var_1_10019

				var_1_10019.remove(arg_80_4, iter_80_2)

				break
			end
		end
	end

	local var_80_5 = {}

	local function var_80_6(arg_81_0)
		underscore = var_2_10001

		local var_81_0 = var_2_10001.filter(arg_80_3, function(arg_82_0)
			ShipType = var_3_10001

			return var_3_10001.ContainInLimitBundle(arg_81_0, arg_82_0)
		end)
		local var_81_1 = var_80_0

		if var_2.GetRecommendShip(var_81_1, var_81_0, arg_80_2, arg_80_5) then
			local var_81_2 = var_2.id
			local var_81_3 = arg_80_2

			var_81_3[#arg_80_2 + 1] = var_81_2
			table = var_81_3

			var_81_3.insert(var_80_5, var_81_2)
		end

		return
	end

	ipairs = var_10

	for iter_80_4, iter_80_5 in var_10(arg_80_4) do
		var_80_6(iter_80_5)
	end

	return var_80_5
end

function var_0_1.isClear(arg_83_0, arg_83_1)
	if not arg_83_0:GetChapterItemById(arg_83_1) then
		return false
	end

	return var_2:isClear()
end

function var_0_1.recordLastMap(arg_84_0, arg_84_1, arg_84_2)
	local var_84_0 = false

	if arg_84_1 == var_0_1.LAST_MAP_FOR_ACTIVITY then
		Map = var_4

		if arg_84_2 ~= var_4.lastMapForActivity then
			Map = var_4
			var_4.lastMapForActivity = arg_84_2
			var_84_0 = true

			goto label_84_0
		end
	end

	if arg_84_1 == var_0_1.LAST_MAP then
		Map = var_4

		if arg_84_2 ~= var_4.lastMap then
			Map = var_4
			var_4.lastMap = arg_84_2
			var_84_0 = true
		end
	end

	::label_84_0::

	if var_84_0 then
		getProxy = var_4
		PlayerProxy = var_1_10006

		local var_84_1 = var_4(var_1_10006)
		local var_84_2 = var_4.getRawData(var_84_1)

		PlayerPrefs = var_1_10005

		var_1_10005.SetInt(arg_84_1 .. var_84_2.id, arg_84_2)

		PlayerPrefs = var_5

		var_5.Save()
	end

	return
end

function var_0_1.getLastMap(arg_85_0, arg_85_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_85_0 = var_1_10002(var_1_10004)
	local var_85_1 = var_2.getRawData(var_85_0)

	PlayerPrefs = var_1_10003

	if var_1_10003.GetInt(arg_85_1 .. var_85_1.id) ~= 0 then
		return var_3
	end

	return
end

function var_0_1.IsActivitySPChapterActive(arg_86_0, arg_86_1)
	local var_86_0 = arg_86_0
	local var_86_1 = arg_86_0.getMapsByActivities(var_86_0, arg_86_1)

	_ = var_1_10003

	local var_86_2 = var_1_10003.reduce(var_86_1, {}, function(arg_87_0, arg_87_1)
		table = var_2_10002

		local var_87_0 = var_2_10002.insertto
		local var_87_1 = arg_87_0

		_ = var_2_10005

		var_87_0(var_87_1, var_2_10005.select(arg_87_1:getChapters(), function(arg_88_0)
			return arg_88_0:IsSpChapter()
		end))

		return arg_87_0
	end)

	_ = var_86_0

	return var_86_0.any(var_86_2, function(arg_89_0)
		local var_89_0

		if arg_89_0:isUnlock() and arg_89_0:isPlayerLVUnlock() then
			var_89_0 = arg_89_0:enoughTimes2Start()
		end

		return var_89_0
	end)
end

function var_0_1.getSubAidFlag(arg_90_0, arg_90_1)
	ys = var_1_10002

	local var_90_0 = var_1_10002.Battle.BattleConst.SubAidFlag
	local var_90_1 = arg_90_0.fleet
	local var_90_2 = false

	_ = var_1_10005

	local var_90_3

	if var_1_10005.detect(arg_90_0.fleets, function(arg_91_0)
		local var_91_0 = arg_91_0:getFleetType()

		FleetType = var_2_10002

		return var_91_0 == var_2_10002.Submarine and arg_91_0:isValid()
	end) then
		var_90_3 = var_5

		if var_5.inHuntingRange(var_90_3, var_90_1.line.row, var_90_1.line.column) then
			var_90_2 = true
		else
			var_90_3 = var_5
			var_1_10006 = var_5.getStrategies(var_90_3)
			_ = var_7

			if var_7.detect(var_1_10006, function(arg_92_0)
				local var_92_0 = arg_92_0.id

				ChapterConst = var_2_10002

				return var_92_0 == var_2_10002.StrategyCallSubOutofRange
			end) and var_7.count > 0 then
				var_90_2 = true
			end
		end
	end

	if var_90_2 then
		getProxy = var_1_10006
		PlayerProxy = var_90_3

		local var_90_4 = var_1_10006(var_90_3)
		local var_90_5 = var_6.getRawData(var_90_4)
		local var_90_6, var_90_7 = arg_90_0:getFleetCost(var_90_1, arg_90_1)
		local var_90_8, var_90_9 = arg_90_0:getFleetAmmo(var_5)
		local var_90_10 = 0

		ipairs = var_13

		for iter_90_0, iter_90_1 in var_13({
			arg_90_0:getFleetCost(var_5, arg_90_1)
		}) do
			var_90_10 = var_90_10 + iter_90_1.oil
		end

		if var_90_9 <= 0 then
			return var_90_0.AMMO_EMPTY
		elseif var_90_10 + var_90_7.oil >= var_90_5.oil then
			return var_90_0.OIL_EMPTY
		else
			return true, var_5
		end
	else
		return var_90_0.AID_EMPTY
	end

	return
end

function var_0_1.GetChapterAuraBuffs(arg_93_0)
	local var_93_0 = {}

	ipairs = var_1_10002

	for iter_93_0, iter_93_1 in var_1_10002(arg_93_0.fleets) do
		local var_93_1 = iter_93_1:getFleetType()

		FleetType = var_1_10008

		if var_93_1 ~= var_1_10008.Support then
			local var_93_2 = iter_93_1:getMapAura()

			ipairs = var_1_10008

			for iter_93_2, iter_93_3 in var_1_10008(var_93_2) do
				table = var_1_10013

				var_1_10013.insert(var_93_0, iter_93_3)
			end
		end
	end

	return var_93_0
end

function var_0_1.GetChapterAidBuffs(arg_94_0)
	local var_94_0 = {}

	ipairs = var_1_10002

	for iter_94_0, iter_94_1 in var_1_10002(arg_94_0.fleets) do
		if iter_94_1 ~= arg_94_0.fleet then
			local var_94_1 = iter_94_1:getFleetType()

			FleetType = var_1_10008

			if var_94_1 ~= var_1_10008.Support then
				local var_94_2 = iter_94_1:getMapAid()

				pairs = var_1_10008

				for iter_94_2, iter_94_3 in var_1_10008(var_94_2) do
					var_94_0[iter_94_2] = iter_94_3
				end
			end
		end
	end

	return var_94_0
end

function var_0_1.RecordComboHistory(arg_95_0, arg_95_1, arg_95_2)
	if arg_95_2 ~= nil then
		arg_95_0:SetExtendChapterData(arg_95_1, "comboHistoryBuffer", arg_95_2)
	else
		arg_95_0:RemoveExtendChapterData(arg_95_1, "comboHistoryBuffer")
	end

	return
end

function var_0_1.GetComboHistory(arg_96_0, arg_96_1)
	return arg_96_0:GetExtendChapterData(arg_96_1, "comboHistoryBuffer")
end

function var_0_1.RecordJustClearChapters(arg_97_0, arg_97_1, arg_97_2)
	if arg_97_2 ~= nil then
		arg_97_0:SetExtendChapterData(arg_97_1, "justClearChapters", arg_97_2)
	else
		arg_97_0:RemoveExtendChapterData(arg_97_1, "justClearChapters")
	end

	return
end

function var_0_1.GetJustClearChapters(arg_98_0, arg_98_1)
	return arg_98_0:GetExtendChapterData(arg_98_1, "justClearChapters")
end

function var_0_1.RecordLastDefeatedEnemy(arg_99_0, arg_99_1, arg_99_2)
	if arg_99_2 ~= nil then
		arg_99_0:SetExtendChapterData(arg_99_1, "defeatedEnemiesBuffer", arg_99_2)
	else
		arg_99_0:RemoveExtendChapterData(arg_99_1, "defeatedEnemiesBuffer")
	end

	return
end

function var_0_1.GetLastDefeatedEnemy(arg_100_0, arg_100_1)
	return arg_100_0:GetExtendChapterData(arg_100_1, "defeatedEnemiesBuffer")
end

function var_0_1.ifShowRemasterTip(arg_101_0)
	return arg_101_0.remasterTip
end

function var_0_1.setRemasterTip(arg_102_0, arg_102_1)
	arg_102_0.remasterTip = arg_102_1

	return
end

function var_0_1.updateRemasterTicketsNum(arg_103_0, arg_103_1)
	arg_103_0.remasterTickets = arg_103_1

	return
end

function var_0_1.getRemasterTicketCost(arg_104_0)
	return 5
end

function var_0_1.resetDailyCount(arg_105_0)
	arg_105_0.remasterDailyCount = 0

	return
end

function var_0_1.updateDailyCount(arg_106_0)
	local var_106_0 = arg_106_0.remasterDailyCount

	pg = var_1_10002
	arg_106_0.remasterDailyCount = var_106_0 + var_1_10002.gameset.reactivity_ticket_daily.key_value

	return
end

function var_0_1.GetSkipPrecombat(arg_107_0)
	if arg_107_0.skipPrecombat == nil then
		PlayerPrefs = var_1
		arg_107_0.skipPrecombat = var_1.GetInt("chapter_skip_precombat", 0)
	end

	return arg_107_0.skipPrecombat > 0
end

function var_0_1.UpdateSkipPrecombat(arg_108_0, arg_108_1)
	tobool = var_1_10002
	arg_108_1 = var_1_10002(arg_108_1) and 1 or 0

	if arg_108_1 ~= arg_108_0:GetSkipPrecombat() then
		PlayerPrefs = var_1_10003

		var_1_10003.SetInt("chapter_skip_precombat", arg_108_1)

		arg_108_0.skipPrecombat = arg_108_1

		arg_108_0:sendNotification(var_0_1.CHAPTER_SKIP_PRECOMBAT_UPDATED, arg_108_1)
	end

	return
end

function var_0_1.GetChapterAutoFlag(arg_109_0, arg_109_1)
	return arg_109_0:GetExtendChapterData(arg_109_1, "AutoFightFlag")
end

function var_0_1.SetChapterAutoFlag(arg_110_0, arg_110_1, arg_110_2, arg_110_3)
	tobool = var_1_10004

	if var_1_10004(arg_110_2) == (arg_110_0:GetChapterAutoFlag(arg_110_1) == 1) then
		return
	end

	arg_110_0:SetExtendChapterData(arg_110_1, "AutoFightFlag", arg_110_2 and 1 or 0)

	if arg_110_2 then
		local var_110_0 = arg_110_0

		arg_110_0.UpdateSkipPrecombat(var_110_0, true)

		AutoBotCommand = var_5

		local var_110_1

		if var_5.autoBotSatisfied() then
			PlayerPrefs = var_110_1
			var_110_1 = var_110_1.SetInt
			var_110_0 = "autoBotIsAcitve"
			AutoBotCommand = var_8

			var_110_1(var_110_0 .. var_8.GetAutoBotMark(), 1)
		end

		getProxy = var_110_1
		MetaCharacterProxy = var_110_0

		local var_110_2 = var_110_1(var_110_0)

		var_5.setMetaTacticsInfoOnStart(var_110_2)

		pg = var_5

		local var_110_3 = var_5.BrightnessMgr.GetInstance()

		var_5.SetScreenNeverSleep(var_110_3, true)

		LOCK_BATTERY_SAVEMODE = var_5

		if not var_5 then
			PlayerPrefs = var_5

			local var_110_4 = var_5.GetInt

			AUTOFIGHT_BATTERY_SAVEMODE = var_110_3

			if var_110_4(var_110_3, 0) == 1 then
				pg = var_5

				local var_110_5 = var_5.BrightnessMgr.GetInstance()

				if var_5.IsPermissionGranted(var_110_5) then
					pg = var_5

					local var_110_6 = var_5.BrightnessMgr.GetInstance()

					var_5.EnterManualMode(var_110_6)

					PlayerPrefs = var_5

					local var_110_7 = var_5.GetInt

					AUTOFIGHT_DOWN_FRAME = var_110_6

					if var_110_7(var_110_6, 0) == 1 then
						getProxy = var_5
						SettingsProxy = var_110_6

						local var_110_8 = var_5(var_110_6)

						var_5.RecordFrameRate(var_110_8)

						Application = var_5
						var_5.targetFrameRate = 30
					end
				end
			end
		end
	else
		local var_110_9 = arg_110_0
		local var_110_10 = arg_110_0.StopContinuousOperation

		SYSTEM_SCENARIO = var_8

		var_110_10(var_110_9, var_8, arg_110_3)

		pg = var_110_10

		local var_110_11 = var_110_10.BrightnessMgr.GetInstance()

		var_5.SetScreenNeverSleep(var_110_11, false)

		LOCK_BATTERY_SAVEMODE = var_5

		if not var_5 then
			pg = var_5

			local var_110_12 = var_5.BrightnessMgr.GetInstance()

			var_5.ExitManualMode(var_110_12)

			getProxy = var_5
			SettingsProxy = var_110_12

			local var_110_13 = var_5(var_110_12)

			var_5.RestoreFrameRate(var_110_13)
		end
	end

	local var_110_14 = arg_110_0.facade

	var_5.sendNotification(var_110_14, var_0_1.CHAPTER_AUTO_FIGHT_FLAG_UPDATED, arg_110_2 and 1 or 0)

	local var_110_15 = arg_110_0.facade
	local var_110_16 = var_5.sendNotification

	PlayerResUI = var_8

	var_110_16(var_110_15, var_8.CHANGE_TOUCH_ABLE, not arg_110_2)

	return
end

function var_0_1.StopAutoFight(arg_111_0, arg_111_1)
	if not arg_111_0:getActiveChapter(true) then
		return
	end

	arg_111_0:SetChapterAutoFlag(var_2.id, false, arg_111_1)

	return
end

function var_0_1.FinishAutoFight(arg_112_0, arg_112_1)
	if arg_112_0:GetChapterAutoFlag(arg_112_1) == 1 then
		pg = var_1_10003

		local var_112_0 = var_1_10003.BrightnessMgr.GetInstance()

		var_3.SetScreenNeverSleep(var_112_0, false)

		LOCK_BATTERY_SAVEMODE = var_3

		if not var_3 then
			pg = var_3

			local var_112_1 = var_3.BrightnessMgr.GetInstance()

			var_3.ExitManualMode(var_112_1)

			getProxy = var_3
			SettingsProxy = var_112_1

			local var_112_2 = var_3(var_112_1)

			var_3.RestoreFrameRate(var_112_2)
		end

		local var_112_3 = arg_112_0.facade
		local var_112_4 = var_3.sendNotification

		PlayerResUI = var_6

		var_112_4(var_112_3, var_6.CHANGE_TOUCH_ABLE, true)
	end

	local var_112_5 = arg_112_0:GetExtendChapter(arg_112_1)

	arg_112_0:RemoveExtendChapter(arg_112_1)

	return var_112_5
end

function var_0_1.buildRemasterInfo(arg_113_0)
	arg_113_0.remasterInfo = {}
	ipairs = var_1
	pg = var_1_10003

	for iter_113_0, iter_113_1 in var_1(var_1_10003.re_map_template.all) do
		pg = var_1_10006

		local var_113_0

		if not var_1_10006.re_map_template[iter_113_1].activity_id then
			var_113_0 = 0
		end

		ipairs = var_1_10008

		for iter_113_2, iter_113_3 in var_1_10008(var_1_10006.drop_gain) do
			if #iter_113_3 > 0 then
				unpack = var_13

				local var_113_1, var_113_2, var_113_3, var_113_4 = var_13(iter_113_3)
				local var_113_5 = arg_113_0.remasterInfo

				defaultValue = var_1_10018
				var_113_5[var_113_0] = var_1_10018(arg_113_0.remasterInfo[var_113_0], {})

				local var_113_6 = arg_113_0.remasterInfo[var_113_0]

				defaultValue = var_1_10018
				var_113_6[var_113_1] = var_1_10018(arg_113_0.remasterInfo[var_113_0][var_113_1], {})
				arg_113_0.remasterInfo[var_113_0][var_113_1][iter_113_2] = {
					count = 0,
					receive = false,
					max = var_113_4
				}
			end
		end
	end

	return
end

function var_0_1.checkRemasterInfomation(arg_114_0)
	if not arg_114_0.checkRemaster then
		arg_114_0.checkRemaster = true

		local var_114_0 = arg_114_0
		local var_114_1 = arg_114_0.sendNotification

		GAME = var_1_10004

		var_114_1(var_114_0, var_1_10004.CHAPTER_REMASTER_INFO_REQUEST)
	end

	return
end

function var_0_1.getRemasterInfo(arg_115_0, arg_115_1, arg_115_2, arg_115_3)
	arg_115_1 = arg_115_1 or 0

	local var_115_0

	if arg_115_0.remasterInfo then
		var_115_0 = arg_115_0.remasterInfo[arg_115_1]
	end

	if not var_115_0 then
		return nil
	end

	if not var_115_0[arg_115_2] then
		return nil
	end

	if arg_115_3 then
		return var_5[arg_115_3]
	end

	return var_5
end

function var_0_1.addRemasterPassCount(arg_116_0, arg_116_1, arg_116_2)
	local var_116_0 = arg_116_0

	if not arg_116_0.getRemasterInfo(var_116_0, arg_116_2, arg_116_1) then
		return
	end

	local var_116_1

	pairs = var_116_0

	for iter_116_0, iter_116_1 in var_116_0(var_3) do
		if iter_116_1.count < iter_116_1.max then
			iter_116_1.count = iter_116_1.count + 1
			var_116_1 = true
		end
	end

	if var_116_1 then
		arg_116_0:sendNotification(var_0_1.CHAPTER_REMASTER_INFO_UPDATED)
	end

	return
end

function var_0_1.markRemasterPassReceive(arg_117_0, arg_117_1, arg_117_2, arg_117_3)
	if not arg_117_0:getRemasterInfo(arg_117_3, arg_117_1, arg_117_2) then
		return
	end

	if not var_4.receive then
		var_4.receive = true

		arg_117_0:sendNotification(var_0_1.CHAPTER_REMASTER_INFO_UPDATED)
	end

	return
end

function var_0_1.anyRemasterAwardCanReceive(arg_118_0)
	pairs = var_1_10001

	for iter_118_0, iter_118_1 in var_1_10001(arg_118_0.remasterInfo) do
		pairs = var_1_10006

		for iter_118_2, iter_118_3 in var_1_10006(iter_118_1) do
			pairs = var_1_10011

			for iter_118_4, iter_118_5 in var_1_10011(iter_118_3) do
				if not iter_118_5.receive and iter_118_5.count >= iter_118_5.max then
					return true
				end
			end
		end
	end

	return false
end

function var_0_1.AddActBossRewards(arg_119_0, arg_119_1)
	local var_119_0

	if not arg_119_0.actBossItems then
		var_119_0 = {}
	end

	arg_119_0.actBossItems = var_119_0
	table = var_119_0

	var_119_0.insertto(arg_119_0.actBossItems, arg_119_1)

	return
end

function var_0_1.PopActBossRewards(arg_120_0)
	local var_120_0

	if not arg_120_0.actBossItems then
		var_120_0 = {}
	end

	arg_120_0.actBossItems = nil

	return var_120_0
end

function var_0_1.AddBossSingleRewards(arg_121_0, arg_121_1)
	local var_121_0

	if not arg_121_0.bossSingleItems then
		var_121_0 = {}
	end

	arg_121_0.bossSingleItems = var_121_0
	table = var_121_0

	var_121_0.insertto(arg_121_0.bossSingleItems, arg_121_1)

	return
end

function var_0_1.PopBossSingleRewards(arg_122_0)
	local var_122_0

	if not arg_122_0.bossSingleItems then
		var_122_0 = {}
	end

	arg_122_0.bossSingleItems = nil

	return var_122_0
end

function var_0_1.WriteBackOnExitBattleResult(arg_123_0)
	if arg_123_0:getActiveChapter() then
		if var_1:existOni() then
			var_1:clearSubmarineFleet()
			arg_123_0:updateChapter(var_1)
		elseif var_1:isPlayingWithBombEnemy() then
			var_1.fleets = {
				var_1.fleet
			}
			var_1.findex = 1

			arg_123_0:updateChapter(var_1)
		end
	end

	return
end

function var_0_1.GetContinuousData(arg_124_0, arg_124_1)
	return arg_124_0.continuousData[arg_124_1]
end

function var_0_1.InitContinuousTime(arg_125_0, arg_125_1, arg_125_2)
	ContinuousOperationRuntimeData = var_1_10003

	local var_125_0 = var_1_10003.New({
		system = arg_125_1,
		totalBattleTime = arg_125_2,
		battleTime = arg_125_2
	})

	arg_125_0.continuousData[arg_125_1] = var_125_0

	return
end

function var_0_1.StopContinuousOperation(arg_126_0, arg_126_1, arg_126_2)
	if not arg_126_0:GetContinuousData(arg_126_1) or not var_3:IsActive() then
		return
	end

	ChapterConst = var_1_10004

	if arg_126_2 == var_1_10004.AUTOFIGHT_STOP_REASON.MANUAL then
		SYSTEM_SCENARIO = var_4

		if arg_126_1 == var_4 then
			pg = var_4

			local var_126_0 = var_4.TipsMgr.GetInstance()
			local var_126_1 = var_4.ShowTips

			i18n = var_1_10007

			var_126_1(var_126_0, var_1_10007("multiple_sorties_stop"))
		end
	end

	var_3:Stop(arg_126_2)

	return
end

function var_0_1.PopContinuousData(arg_127_0, arg_127_1)
	local var_127_0 = arg_127_0.continuousData[arg_127_1]

	arg_127_0.continuousData[arg_127_1] = nil

	return var_127_0
end

function var_0_1.SetLastFleetIndex(arg_128_0, arg_128_1, arg_128_2)
	if arg_128_2 and arg_128_0.lastFleetIndex then
		return
	end

	arg_128_0.lastFleetIndex = arg_128_1

	return
end

function var_0_1.GetLastFleetIndex(arg_129_0)
	return arg_129_0.lastFleetIndex
end

function var_0_1.RemoveEliteFleetCommander(arg_130_0, arg_130_1)
	local var_130_0 = {}

	ipairs = var_1_10003

	for iter_130_0, iter_130_1 in var_1_10003(arg_130_1) do
		var_130_0[iter_130_1] = true
	end

	local var_130_1 = {}

	pairs = var_4

	for iter_130_2, iter_130_3 in var_4(arg_130_0.mapEliteFleetCache) do
		pairs = var_1_10009

		for iter_130_4, iter_130_5 in var_1_10009(iter_130_3) do
			ipairs = var_1_10014

			for iter_130_6, iter_130_7 in var_1_10014(iter_130_5) do
				ipairs = var_1_10019
				TeamType = var_1_10021

				for iter_130_8, iter_130_9 in var_1_10019(iter_130_7[var_1_10021.FormCommander]) do
					if var_130_0[iter_130_9] then
						TeamType = var_24
						iter_130_7[var_24.FormCommander][iter_130_8] = 0
						var_130_1[iter_130_2] = true
					end
				end
			end
		end
	end

	pairs = var_4

	for iter_130_10, iter_130_11 in var_4(arg_130_0.data) do
		if var_130_1[iter_130_11:getConfig("formation")] then
			local var_130_2 = iter_130_11
			local var_130_3 = iter_130_11.setEliteFleetList

			Clone = iter_130_5

			var_130_3(var_130_2, iter_130_5(arg_130_0.mapEliteFleetCache[var_9]))
			arg_130_0:updateChapter(iter_130_11)
		end
	end

	return
end

return var_0_1
