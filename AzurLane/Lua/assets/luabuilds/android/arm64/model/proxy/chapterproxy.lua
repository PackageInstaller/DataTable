local var_0_0 = class("ChapterProxy", import(".NetProxy"))

var_0_0.CHAPTER_UPDATED = "ChapterProxy:CHAPTER_UPDATED"
var_0_0.CHAPTER_TIMESUP = "ChapterProxy:CHAPTER_TIMESUP"
var_0_0.CHAPTER_CELL_UPDATED = "ChapterProxy:CHAPTER_CELL_UPDATED"
var_0_0.CHAPTER_AUTO_FIGHT_FLAG_UPDATED = "CHAPTERPROXY:CHAPTER_AUTO_FIGHT_FLAG_UPDATED"
var_0_0.CHAPTER_SKIP_PRECOMBAT_UPDATED = "CHAPTERPROXY:CHAPTER_SKIP_PRECOMBAT_UPDATED"
var_0_0.CHAPTER_REMASTER_INFO_UPDATED = "CHAPTERPROXY:CHAPTER_REMASTER_INFO_UPDATED"
var_0_0.LAST_MAP_FOR_ACTIVITY = "last_map_for_activity"
var_0_0.LAST_MAP = "last_map"

function var_0_0.register(arg_1_0)
	arg_1_0:on(13001, function(arg_2_0)
		arg_1_0.mapEliteFleetCache = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.fleet_list) do
			arg_1_0.mapEliteFleetCache[iter_2_1.id] = Chapter.BuildEliteFleetInfo(iter_2_1)
		end

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.chapter_list) do
			if not pg.chapter_template[iter_2_3.id] then
				errorMsg("chapter_template not exist: " .. iter_2_3.id)
			else
				local var_2_0 = Chapter.New(iter_2_3)

				var_2_0:setEliteFleetList(Clone(arg_1_0.mapEliteFleetCache[var_2_0:getConfig("formation")]))
				arg_1_0:updateChapter(var_2_0)
			end
		end

		if arg_2_0.react_chapter then
			arg_1_0.remasterTickets = arg_2_0.react_chapter.count
			arg_1_0.remasterDailyCount = arg_2_0.react_chapter.daily_count
			arg_1_0.remasterTip = arg_1_0.remasterDailyCount <= 0
		end

		return
	end)
	arg_1_0:on(13000, function(arg_3_0)
		arg_1_0.repairTimes = arg_3_0.daily_repair_count

		if arg_3_0.current_chapter then
			if arg_3_0.current_chapter.id > 0 then
				local var_3_0 = arg_1_0:getChapterById(arg_3_0.current_chapter.id, true)

				var_3_0:update(arg_3_0.current_chapter)
				arg_1_0:updateChapter(var_3_0)
			end
		end

		Map.lastMap = arg_1_0:getLastMap(var_0_0.LAST_MAP)
		Map.lastMapForActivity = arg_1_0:getLastMap(var_0_0.LAST_MAP_FOR_ACTIVITY)

		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inChapter")
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inElite")
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inSupport")

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

function var_0_0.timeCall(arg_4_0)
	return {
		[ProxyRegister.DayCall] = function(arg_5_0)
			arg_4_0:resetRepairTimes()
			arg_4_0:resetEscortChallengeTimes()

			for iter_5_0, iter_5_1 in pairs((arg_4_0:getData())) do
				if iter_5_1.todayDefeatCount > 0 then
					iter_5_1.todayDefeatCount = 0

					arg_4_0:updateChapter(iter_5_1)
				end
			end

			arg_4_0:resetDailyCount()

			return
		end
	}
end

function var_0_0.OnBattleFinished(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getActiveChapter()

	if var_6_0 then
		local var_6_1 = 0

		if _.any(arg_6_1.ai_list, function(arg_8_0)
			return arg_8_0.item_type == ChapterConst.AttachOni
		end) then
			var_6_0:onOniEnter()
			;(function()
				local var_7_0 = getProxy(ContextProxy)

				if not var_7_0 then
					return
				end

				if var_7_0:getCurrentContext().mediator == LevelMediator2 then
					var_6_1 = bit.bor(var_6_1, ChapterConst.DirtyAttachment, ChapterConst.DirtyStrategy)

					arg_6_0:SetChapterAutoFlag(var_6_0.id, false)

					return
				end

				local var_7_1 = var_7_0:getContextByMediator(LevelMediator2)

				if not var_7_1 then
					return
				end

				var_7_1.data.StopAutoFightFlag = true

				return
			end)()
		end

		if _.any(arg_6_1.map_update, function(arg_9_0)
			return arg_9_0.item_type == ChapterConst.AttachBomb_Enemy
		end) then
			var_6_0:onBombEnemyEnter()
			;(function()
				local var_7_0 = getProxy(ContextProxy)

				if not var_7_0 then
					return
				end

				if var_7_0:getCurrentContext().mediator == LevelMediator2 then
					var_6_1 = bit.bor(var_6_1, ChapterConst.DirtyAttachment, ChapterConst.DirtyStrategy)

					arg_6_0:SetChapterAutoFlag(var_6_0.id, false)

					return
				end

				local var_7_1 = var_7_0:getContextByMediator(LevelMediator2)

				if not var_7_1 then
					return
				end

				var_7_1.data.StopAutoFightFlag = true

				return
			end)()
		end

		if #arg_6_1.map_update > 0 then
			_.each(arg_6_1.map_update, function(arg_10_0)
				if arg_10_0.item_type == ChapterConst.AttachStory and arg_10_0.item_data == ChapterConst.StoryTrigger then
					local var_10_0 = ChapterCell.Line2Name(arg_10_0.pos.row, arg_10_0.pos.column)
					local var_10_1 = var_6_0:GetChapterCellAttachemnts()

					if var_10_1[var_10_0] then
						if var_10_1[var_10_0].flag == ChapterConst.CellFlagTriggerActive and arg_10_0.item_flag == ChapterConst.CellFlagTriggerDisabled then
							if pg.map_event_template[var_10_1[var_10_0].attachmentId].gametip ~= "" then
								pg.TipsMgr.GetInstance():ShowTips(i18n(pg.map_event_template[var_10_1[var_10_0].attachmentId].gametip))
							end
						end

						var_10_1[var_10_0].attachment = arg_10_0.item_type
						var_10_1[var_10_0].attachmentId = arg_10_0.item_id
						var_10_1[var_10_0].flag = arg_10_0.item_flag
						var_10_1[var_10_0].data = arg_10_0.item_data
					else
						var_10_1[var_10_0] = ChapterCell.New(arg_10_0)
					end
				elseif arg_10_0.item_type ~= ChapterConst.AttachNone and arg_10_0.item_type ~= ChapterConst.AttachBorn and arg_10_0.item_type ~= ChapterConst.AttachBorn_Sub and arg_10_0.item_type ~= ChapterConst.AttachOni_Target and arg_10_0.item_type ~= ChapterConst.AttachOni then
					var_6_0:mergeChapterCell((ChapterCell.New(arg_10_0)))
				end

				return
			end)

			var_6_1 = bit.bor(var_6_1, ChapterConst.DirtyAttachment, ChapterConst.DirtyAutoAction)
		end

		if #arg_6_1.ai_list > 0 then
			_.each(arg_6_1.ai_list, function(arg_11_0)
				var_6_0:mergeChampion((ChapterChampionPackage.New(arg_11_0)))

				return
			end)

			var_6_1 = bit.bor(var_6_1, ChapterConst.DirtyChampion, ChapterConst.DirtyAutoAction)
		end

		if #arg_6_1.add_flag_list > 0 or #arg_6_1.del_flag_list > 0 then
			var_6_1 = bit.bor(var_6_1, ChapterConst.DirtyFleet, ChapterConst.DirtyStrategy, ChapterConst.DirtyCellFlag, ChapterConst.DirtyFloatItems, ChapterConst.DirtyAttachment, ChapterConst.DirtyWeather)

			arg_6_0:updateExtraFlag(var_6_0, arg_6_1.add_flag_list, arg_6_1.del_flag_list)
		end

		if #arg_6_1.buff_list > 0 then
			var_6_0:UpdateBuffList(arg_6_1.buff_list)
		end

		if #arg_6_1.cell_flag_list > 0 then
			_.each(arg_6_1.cell_flag_list, function(arg_12_0)
				local var_12_0 = var_6_0:getChapterCell(arg_12_0.pos.row, arg_12_0.pos.column)

				if var_12_0 then
					var_12_0:updateFlagList(arg_12_0)
				else
					var_12_0 = ChapterCell.New(arg_12_0)
				end

				var_6_0:updateChapterCell(var_12_0)

				return
			end)

			var_6_1 = bit.bor(var_6_1, ChapterConst.DirtyCellFlag, ChapterConst.DirtyWeather)
		end

		arg_6_0:updateChapter(var_6_0, var_6_1)

		if arg_6_2 then
			arg_6_0:sendNotification(GAME.CHAPTER_OP_DONE, {
				type = ChapterConst.OpSkipBattle
			})
		end
	end

	return
end

function var_0_0.setEliteCache(arg_13_0, arg_13_1)
	arg_13_0.mapEliteFleetCache = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		arg_13_0.mapEliteFleetCache[iter_13_1.id] = Chapter.BuildEliteFleetInfo(iter_13_1)
	end

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inElite")
	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inSupport")

	for iter_13_2, iter_13_3 in pairs(arg_13_0.data) do
		iter_13_3:setEliteFleetList(Clone(arg_13_0.mapEliteFleetCache[iter_13_3:getConfig("formation")]))
		arg_13_0:updateChapter(iter_13_3)
	end

	return
end

function var_0_0.buildMaps(arg_14_0)
	arg_14_0:initChapters()
	arg_14_0:buildBaseMaps()
	arg_14_0:buildRemasterMaps()

	return
end

function var_0_0.initChapters(arg_15_0)
	var_0_0.MapToChapters = table.shallowCopy(pg.chapter_template.get_id_list_by_map)

	for iter_15_0, iter_15_1 in pairs(pg.story_group.get_id_list_by_map) do
		var_0_0.MapToChapters[iter_15_0] = var_0_0.MapToChapters[iter_15_0] or {}

		table.insertto(var_0_0.MapToChapters[iter_15_0], iter_15_1)
	end

	var_0_0.FormationToChapters = pg.chapter_template.get_id_list_by_formation

	return
end

function var_0_0.buildBaseMaps(arg_16_0)
	var_0_0.ActToMaps = {}
	var_0_0.TypeToMaps = {}

	for iter_16_0, iter_16_1 in ipairs(pg.expedition_data_by_map.all) do
		local var_16_0 = Map.New({
			id = iter_16_1,
			chapterIds = var_0_0.MapToChapters[iter_16_1]
		})

		;({})[iter_16_1] = var_16_0

		local var_16_1 = var_16_0:getConfig("on_activity")

		if var_16_1 ~= 0 then
			var_0_0.ActToMaps[var_16_1] = var_0_0.ActToMaps[var_16_1] or {}

			table.insert(var_0_0.ActToMaps[var_16_1], var_16_0.id)
		end

		local var_16_2 = var_16_0:getMapType()

		var_0_0.TypeToMaps[var_16_2] = var_0_0.TypeToMaps[var_16_2] or {}

		table.insert(var_0_0.TypeToMaps[var_16_2], var_16_0.id)
	end

	arg_16_0.baseMaps = {}

	return
end

function var_0_0.buildRemasterMaps(arg_17_0)
	var_0_0.RemasterToMaps = {}

	local var_17_0 = {}

	_.each(BossRushChapterRemasterHelper.GetAllNonActivityIds(), function(arg_18_0)
		_.each(pg.re_map_template[arg_18_0].config_data, function(arg_19_0)
			local var_19_0 = arg_17_0.baseMaps[pg.chapter_template[arg_19_0].map]

			assert(not var_17_0[arg_17_0.baseMaps[pg.chapter_template[arg_19_0].map].id] or var_17_0[var_19_0.id] == arg_18_0, "remaster chapter error:" .. arg_19_0)

			if not var_17_0[var_19_0.id] then
				var_17_0[var_19_0.id] = arg_18_0

				var_19_0:setRemaster(arg_18_0)

				var_0_0.RemasterToMaps[arg_18_0] = var_0_0.RemasterToMaps[arg_18_0] or {}

				table.insert(var_0_0.RemasterToMaps[arg_18_0], var_19_0.id)
			end

			return
		end)

		return
	end)

	return
end

function var_0_0.IsChapterInRemaster(arg_20_0, arg_20_1)
	return _.detect(BossRushChapterRemasterHelper.GetAllNonActivityIds(), function(arg_21_0)
		return _.any(pg.re_map_template[arg_21_0].config_data, function(arg_22_0)
			return arg_22_0 == arg_20_1
		end)
	end)
end

function var_0_0.getMaxEscortChallengeTimes(arg_23_0)
	local var_23_0 = getProxy(ActivityProxy):getActivityParameter("escort_daily_count")

	var_23_0 = var_23_0 or 0

	return var_23_0
end

function var_0_0.getEscortChapterIds(arg_24_0)
	local var_24_0 = getProxy(ActivityProxy):getActivityParameter("escort_exp_id")

	var_24_0 = var_24_0 or {}

	return var_24_0
end

function var_0_0.resetEscortChallengeTimes(arg_25_0)
	arg_25_0.escortChallengeTimes = 0

	return
end

function var_0_0.addChapterListener(arg_26_0, arg_26_1)
	if not arg_26_1.dueTime or not arg_26_0.timers then
		return
	end

	if arg_26_0.timers[arg_26_1.id] then
		arg_26_0.timers[arg_26_1.id]:Stop()

		arg_26_0.timers[arg_26_1.id] = nil
	end

	local var_26_0 = arg_26_1.dueTime - pg.TimeMgr.GetInstance():GetServerTime()

	local function var_26_1()
		arg_26_0.data[arg_26_1.id].dueTime = nil

		arg_26_0.data[arg_26_1.id]:display("times'up")
		arg_26_0:sendNotification(var_0_0.CHAPTER_UPDATED, {
			dirty = 0,
			chapter = arg_26_0.data[arg_26_1.id]:clone()
		})
		arg_26_0:sendNotification(var_0_0.CHAPTER_TIMESUP)

		return
	end

	if var_26_0 > 0 then
		arg_26_0.timers[arg_26_1.id] = Timer.New(function()
			var_26_1()
			arg_26_0.timers[arg_26_1.id]:Stop()

			arg_26_0.timers[arg_26_1.id] = nil

			return
		end, var_26_0, 1)

		arg_26_0.timers[arg_26_1.id]:Start()
	else
		(function()
			arg_26_0.data[arg_26_1.id].dueTime = nil

			arg_26_0.data[arg_26_1.id]:display("times'up")
			arg_26_0:sendNotification(var_0_0.CHAPTER_UPDATED, {
				dirty = 0,
				chapter = arg_26_0.data[arg_26_1.id]:clone()
			})
			arg_26_0:sendNotification(var_0_0.CHAPTER_TIMESUP)

			return
		end)()
	end

	return
end

function var_0_0.removeChapterListener(arg_29_0, arg_29_1)
	if arg_29_0.timers[arg_29_1] then
		arg_29_0.timers[arg_29_1]:Stop()

		arg_29_0.timers[arg_29_1] = nil
	end

	return
end

function var_0_0.remove(arg_30_0)
	for iter_30_0, iter_30_1 in pairs(arg_30_0.timers) do
		iter_30_1:Stop()
	end

	arg_30_0.timers = nil

	return
end

function var_0_0.GetRawChapterById(arg_31_0, arg_31_1)
	return arg_31_0.data[arg_31_1]
end

function var_0_0.getChapterById(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0.data[arg_32_1]

	if not arg_32_0.data[arg_32_1] then
		assert(pg.chapter_template[arg_32_1], "Not Exist Chapter ID: " .. (arg_32_1 or "NIL"))

		var_32_0 = Chapter.New({
			id = arg_32_1
		})

		if var_32_0:getConfig("type") == Chapter.CustomFleet or var_32_0:GetSupportFleetMaxCount() > 0 then
			var_32_0:setEliteFleetList(Clone(arg_32_0.mapEliteFleetCache[var_32_0:getConfig("formation")]))
		end

		arg_32_0.data[arg_32_1] = var_32_0
	end

	return arg_32_2 and var_32_0 or var_32_0:clone()
end

function var_0_0.GetChapterItemById(arg_33_0, arg_33_1)
	if Chapter:bindConfigTable()[arg_33_1] then
		return arg_33_0:getChapterById(arg_33_1, true)
	elseif ChapterStoryGroup:bindConfigTable()[arg_33_1] then
		local var_33_0 = arg_33_0.chapterStoryGroups[arg_33_1]

		if not arg_33_0.chapterStoryGroups[arg_33_1] then
			var_33_0 = ChapterStoryGroup.New({
				configId = arg_33_1
			})
			arg_33_0.chapterStoryGroups[arg_33_1] = var_33_0
		end

		return var_33_0
	end

	return
end

function var_0_0.updateChapter(arg_34_0, arg_34_1, arg_34_2)
	assert(isa(arg_34_1, Chapter), "should be an instance of Chapter")

	arg_34_0.data[arg_34_1.id] = arg_34_1

	if arg_34_0.data[arg_34_1.id] then
		arg_34_0:removeChapterListener(arg_34_0.data[arg_34_1.id].id)
	end

	arg_34_0:addChapterListener(arg_34_1)

	if getProxy(PlayerProxy):getInited() then
		arg_34_0.facade:sendNotification(var_0_0.CHAPTER_UPDATED, {
			chapter = arg_34_1:clone(),
			dirty = defaultValue(arg_34_2, 0)
		})
	end

	if arg_34_1.active and arg_34_1.fleet then
		arg_34_1.fleet:clearShipHpChange()
	end

	if tobool(checkExist(arg_34_0.data[arg_34_1.id], {
		"active"
	})) ~= tobool(arg_34_1.active) then
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inChapter")
	end

	return
end

function var_0_0.getMapById(arg_35_0, arg_35_1)
	return arg_35_0.baseMaps[arg_35_1]
end

function var_0_0.getNormalMaps(arg_36_0)
	for iter_36_0, iter_36_1 in ipairs(arg_36_0.baseMaps) do
		table.insert({}, iter_36_1)
	end

	return {}
end

function var_0_0.getMapsByType(arg_37_0, arg_37_1)
	if var_0_0.TypeToMaps[arg_37_1] then
		return _.map(var_0_0.TypeToMaps[arg_37_1], function(arg_38_0)
			return arg_37_0:getMapById(arg_38_0)
		end)
	else
		return {}
	end

	return
end

function var_0_0.getMapsByActId(arg_39_0, arg_39_1)
	if var_0_0.ActToMaps[arg_39_1] then
		return underscore.map(var_0_0.ActToMaps[arg_39_1], function(arg_40_0)
			return arg_39_0:getMapById(arg_40_0)
		end)
	else
		return {}
	end

	return
end

function var_0_0.getRemasterMaps(arg_41_0, arg_41_1)
	if var_0_0.RemasterToMaps[arg_41_1] then
		return underscore.map(var_0_0.RemasterToMaps[arg_41_1], function(arg_42_0)
			return arg_41_0:getMapById(arg_42_0)
		end)
	else
		return {}
	end

	return
end

function var_0_0.getMapsByActivities(arg_43_0, arg_43_1)
	local var_43_0 = getProxy(ActivityProxy)
	local var_43_1

	if arg_43_1 then
		var_43_1 = var_43_0:getActivityById(arg_43_1)
	else
		local var_43_2 = var_43_0:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_ZPROJECT)

		table.sort(var_43_2, CompareFuncs({
			function(arg_44_0)
				return defaultValue(arg_44_0:GetConfigClientSetting("order"), 1)
			end
		}))

		var_43_1 = var_43_2[1]
	end

	if not var_43_1 then
		return {}
	end

	local var_43_3 = pg.expedition_data_by_map[pg.chapter_template[var_43_1:getConfig("config_data")[1]].map].on_activity

	if getProxy(ActivityProxy):IsActivityNotEnd(var_43_3) then
		return arg_43_0:getMapsByActId(var_43_3)
	else
		return {}
	end

	return
end

function var_0_0.getLastUnlockMap(arg_45_0)
	local var_45_0

	for iter_45_0, iter_45_1 in ipairs(arg_45_0:getNormalMaps()) do
		if not iter_45_1:isUnlock() then
			break
		end

		var_45_0 = iter_45_1
	end

	return var_45_0
end

function var_0_0.updateExtraFlag(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	local var_46_0 = underscore.to_array(arg_46_1:getExtraFlags())

	if not arg_46_4 and not arg_46_1:updateExtraFlags(arg_46_2, arg_46_3) then
		return
	end

	local var_46_1 = {}

	for iter_46_0, iter_46_1 in ipairs(arg_46_1:getExtraFlags()) do
		if not table.contains(var_46_0, iter_46_1) then
			table.insert(var_46_1, iter_46_1)
		end
	end

	arg_46_0:SetExtendChapterData(arg_46_1.id, "extraFlagUpdate", var_46_1)

	return true
end

function var_0_0.extraFlagUpdated(arg_47_0, arg_47_1)
	arg_47_0:RemoveExtendChapterData(arg_47_1, "extraFlagUpdate")

	return
end

function var_0_0.getUpdatedExtraFlags(arg_48_0, arg_48_1)
	return arg_48_0:GetExtendChapterData(arg_48_1, "extraFlagUpdate")
end

function var_0_0.SetExtendChapterData(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	assert(arg_49_1, "Missing Chapter ID")

	arg_49_0.chaptersExtend[arg_49_1] = arg_49_0.chaptersExtend[arg_49_1] or {}
	arg_49_0.chaptersExtend[arg_49_1][arg_49_2] = arg_49_3

	return
end

function var_0_0.AddExtendChapterDataArray(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4)
	assert(arg_50_1, "Missing Chapter ID")

	arg_50_0.chaptersExtend[arg_50_1] = arg_50_0.chaptersExtend[arg_50_1] or {}

	if type(arg_50_0.chaptersExtend[arg_50_1][arg_50_2]) ~= "table" then
		assert(arg_50_0.chaptersExtend[arg_50_1][arg_50_2] == nil, "Changing NonEmpty ExtendData " .. arg_50_2 .. " to Table ID: " .. arg_50_1)

		arg_50_0.chaptersExtend[arg_50_1][arg_50_2] = {}
	end

	arg_50_4 = arg_50_4 or #arg_50_0.chaptersExtend[arg_50_1][arg_50_2] + 1
	arg_50_0.chaptersExtend[arg_50_1][arg_50_2][arg_50_4] = arg_50_3

	return
end

function var_0_0.AddExtendChapterDataTable(arg_51_0, arg_51_1, arg_51_2, arg_51_3, arg_51_4)
	assert(arg_51_1, "Missing Chapter ID")

	arg_51_0.chaptersExtend[arg_51_1] = arg_51_0.chaptersExtend[arg_51_1] or {}

	if type(arg_51_0.chaptersExtend[arg_51_1][arg_51_2]) ~= "table" then
		assert(arg_51_0.chaptersExtend[arg_51_1][arg_51_2] == nil, "Changing NonEmpty ExtendData " .. arg_51_2 .. " to Table ID: " .. arg_51_1)

		arg_51_0.chaptersExtend[arg_51_1][arg_51_2] = {}
	end

	assert(arg_51_3, "Missing Index on Set HashData")

	arg_51_0.chaptersExtend[arg_51_1][arg_51_2][arg_51_3] = arg_51_4

	return
end

function var_0_0.GetExtendChapterData(arg_52_0, arg_52_1, arg_52_2)
	assert(arg_52_1, "Missing Chapter ID")
	assert(arg_52_2, "Requesting Empty key")

	if not arg_52_2 or not arg_52_0.chaptersExtend[arg_52_1] then
		return
	end

	return arg_52_0.chaptersExtend[arg_52_1][arg_52_2]
end

function var_0_0.RemoveExtendChapterData(arg_53_0, arg_53_1, arg_53_2)
	assert(arg_53_1, "Missing Chapter ID")

	if not arg_53_2 or not arg_53_0.chaptersExtend[arg_53_1] then
		return
	end

	arg_53_0.chaptersExtend[arg_53_1][arg_53_2] = nil

	if next(arg_53_0.chaptersExtend[arg_53_1]) then
		return
	end

	arg_53_0:RemoveExtendChapter(arg_53_1)

	return
end

function var_0_0.GetExtendChapter(arg_54_0, arg_54_1)
	assert(arg_54_1, "Missing Chapter ID")

	return arg_54_0.chaptersExtend[arg_54_1]
end

function var_0_0.RemoveExtendChapter(arg_55_0, arg_55_1)
	assert(arg_55_1, "Missing Chapter ID")

	if not arg_55_0.chaptersExtend[arg_55_1] then
		return
	end

	arg_55_0.chaptersExtend[arg_55_1] = nil

	return
end

function var_0_0.duplicateEliteFleet(arg_56_0, arg_56_1)
	if arg_56_1:getConfig("type") ~= Chapter.CustomFleet and arg_56_1:GetSupportFleetMaxCount() == 0 then
		return
	end

	local var_56_0 = arg_56_1:getConfig("formation")

	arg_56_0.mapEliteFleetCache[var_56_0] = Clone(arg_56_1.eliteFleetList)

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inElite")
	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inSupport")

	for iter_56_0, iter_56_1 in ipairs(var_0_0.FormationToChapters[var_56_0]) do
		local var_56_1 = arg_56_0:getChapterById(iter_56_1, true)

		if var_56_1.configId ~= arg_56_1.configId then
			var_56_1:setEliteFleetList(Clone(arg_56_1.eliteFleetList))
			arg_56_0:updateChapter(var_56_1)
		end
	end

	return
end

function var_0_0.RemoveUnitFromSupportFleet(arg_57_0, arg_57_1)
	arg_57_0:sendNotification(GAME.REMOVE_ELITE_TARGET_SHIP, {
		shipId = arg_57_1.id
	})

	return
end

function var_0_0.getActiveChapter(arg_58_0, arg_58_1)
	for iter_58_0, iter_58_1 in pairs(arg_58_0.data) do
		if iter_58_1.active then
			return arg_58_1 and iter_58_1 or iter_58_1:clone()
		end
	end

	return
end

function var_0_0.GetLastNormalMap(arg_59_0)
	local var_59_0 = Map.lastMap and arg_59_0:getMapById(Map.lastMap)

	if var_59_0 and var_59_0:isUnlock() and var_59_0:getMapType() == Map.SCENARIO then
		return Map.lastMap
	end

	return arg_59_0:getLastUnlockMap().id
end

function var_0_0.getLastMapForActivity(arg_60_0, arg_60_1)
	local var_60_1 = arg_60_0:getActiveChapter()

	if nil then
		local var_60_2 = arg_60_0:getMapById((nil):getConfig("map"))

		if var_60_2:isActivity() and not var_60_2:isRemaster() then
			return var_60_2.id, (nil).id
		end
	end

	local var_60_3 = Map.lastMapForActivity and arg_60_0:getMapById(Map.lastMapForActivity)

	if var_60_3 and not var_60_3:isRemaster() and var_60_3:isUnlock() and (not arg_60_1 or var_60_3:getConfig("on_activity") == arg_60_1) then
		return Map.lastMapForActivity
	end

	if Map.lastMapForActivity then
		arg_60_0:recordLastMap(var_0_0.LAST_MAP_FOR_ACTIVITY, 0)
	end

	return arg_60_0:getActivityLastUnlockMap(arg_60_1)
end

function var_0_0.getActivityLastUnlockMap(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0:getMapsByActivities(arg_61_1)

	if not _.all(var_61_0, function(arg_62_0)
		return arg_62_0:getConfig("type") == Map.EVENT
	end) then
		for iter_61_0, iter_61_1 in ipairs({
			Map.ACTIVITY_EASY,
			Map.ACTIVITY_HARD
		}) do
			local var_61_1 = underscore.filter(var_61_0, function(arg_63_0)
				return arg_63_0:getMapType() == iter_61_1
			end)

			if #var_61_1 > 0 and underscore.any(var_61_1, function(arg_64_0)
				return not arg_64_0:isClearForActivity()
			end) then
				var_61_0 = var_61_1

				break
			end
		end
	end

	for iter_61_2 = #var_61_0, 1, -1 do
		if var_61_0[iter_61_2]:isUnlock() then
			return var_61_0[iter_61_2].id
		end
	end

	if #var_61_0 > 0 then
		return var_61_0[1].id
	end

	return
end

function var_0_0.updateActiveChapterShips(arg_65_0)
	local var_65_0 = arg_65_0:getActiveChapter(true)

	if var_65_0 then
		_.each(var_65_0.fleets, function(arg_66_0)
			arg_66_0:flushShips()

			return
		end)
		arg_65_0:updateChapter(var_65_0, ChapterConst.DirtyFleet)
	end

	return
end

function var_0_0.resetRepairTimes(arg_67_0)
	arg_67_0.repairTimes = 0

	return
end

function var_0_0.getUseableEliteMap(arg_68_0)
	for iter_68_0, iter_68_1 in ipairs(arg_68_0:getMapsByType(Map.ELITE)) do
		if iter_68_1:isEliteEnabled() then
			({})[#{} + 1] = iter_68_1
		end
	end

	return {}
end

function var_0_0.getUseableMaxEliteMap(arg_69_0)
	local var_69_0 = arg_69_0:getUseableEliteMap()

	if #var_69_0 == 0 then
		return false
	else
		local var_69_1

		for iter_69_0, iter_69_1 in ipairs(var_69_0) do
			if not var_69_1 or var_69_1.id < iter_69_1.id then
				var_69_1 = iter_69_1
			end
		end

		return var_69_1
	end

	return
end

function var_0_0.getHigestClearChapterAndMap(arg_70_0)
	local var_70_0 = arg_70_0.baseMaps[1]

	for iter_70_0, iter_70_1 in ipairs(arg_70_0:getNormalMaps()) do
		if not iter_70_1:isAnyChapterClear() then
			break
		end

		var_70_0 = iter_70_1
	end

	local var_70_1 = arg_70_0:getChapterById(var_70_0.chapterIds[1])

	for iter_70_2, iter_70_3 in ipairs(var_70_0:getChapters()) do
		if not iter_70_3:isClear() then
			break
		end

		var_70_1 = iter_70_3
	end

	return var_70_1, var_70_0
end

function var_0_0.SortRecommendLimitation(arg_71_0)
	table.sort(arg_71_0, CompareFuncs({
		function(arg_72_0)
			if type(arg_72_0) == "number" then
				if arg_72_0 == 0 then
					return 1
				else
					return -arg_72_0
				end
			elseif type(arg_72_0) == "string" then
				return 0
			else
				assert(false)
			end

			return
		end
	}))

	return
end

function var_0_0.eliteFleetRecommend(arg_73_0, arg_73_1, arg_73_2)
	local var_73_0 = {}

	for iter_73_0, iter_73_1 in ipairs(arg_73_1:getEliteFleetList()) do
		for iter_73_2, iter_73_3 in ipairs(iter_73_1) do
			({})[#{} + 1] = iter_73_3
		end
	end

	local function var_73_1(arg_74_0, arg_74_1, arg_74_2, arg_74_3)
		arg_74_3 = arg_74_3 or "inElite"

		return arg_73_0:FleetRecommend(arg_74_0, var_73_0, arg_74_2, arg_74_1, function(arg_75_0)
			return ShipStatus.ShipStatusCheck(arg_74_3, arg_75_0, nil, {
				[arg_74_3] = arg_73_1:getConfig("formation")
			})
		end)
	end

	local var_73_2, var_73_3 = arg_73_1:getEliteTeamByIndex(arg_73_2)

	table.insertto(var_73_2[TeamType.FormShips], switch(var_73_3, {
		[FleetType.Normal] = function()
			local var_76_0 = arg_73_1:getConfig("limitation")[arg_73_2]
			local var_76_1 = var_76_0 and Clone(var_76_0[1]) or {
				0,
				0,
				0
			}
			local var_76_2 = var_76_0 and Clone(var_76_0[2]) or {
				0,
				0,
				0
			}

			var_0_0.SortRecommendLimitation(var_76_1)
			var_0_0.SortRecommendLimitation(var_76_2)

			local var_76_3 = getProxy(BayProxy):getRawData()

			for iter_76_0, iter_76_1 in pairs({
				[TeamType.Main] = {
					var_76_1,
					ShipType.MainShipType
				},
				[TeamType.Vanguard] = {
					var_76_2,
					ShipType.VanguardShipType
				}
			}) do
				local var_76_4, var_76_5 = unpack(iter_76_1)

				table.insertto({}, var_73_1(underscore.filter(var_73_2[TeamType.FormShips], function(arg_77_0)
					return var_76_3[arg_77_0] and var_76_3[arg_77_0]:getTeamType() == iter_76_0
				end), var_76_4, var_76_5))
			end

			return {}
		end,
		[FleetType.Submarine] = function()
			return var_73_1(var_73_2[TeamType.FormShips], {
				0,
				0,
				0
			}, ShipType.SubShipType)
		end,
		[FleetType.Support] = function()
			if arg_73_1:getConfigMiscArg("submarine_support") then
				local var_79_0 = {
					"qian",
					"qian",
					"qian"
				}

				if not {
					"qian",
					"qian",
					"qian"
				} then
					var_79_0 = {
						"hang",
						"hang",
						"hang"
					}
				end

				return var_73_1(var_73_2[TeamType.FormShips], var_79_0, ShipType.AllShipType, "inSupport")
			end
		end
	}))

	return
end

function var_0_0.FleetRecommend(arg_80_0, arg_80_1, arg_80_2, arg_80_3, arg_80_4, arg_80_5)
	arg_80_2 = table.shallowCopy(arg_80_2)

	local var_80_0 = getProxy(BayProxy)
	local var_80_1 = getProxy(BayProxy):getRawData()

	for iter_80_0, iter_80_1 in ipairs(arg_80_1) do
		local var_80_2 = var_80_1[iter_80_1]:getShipType()

		for iter_80_2, iter_80_3 in ipairs(arg_80_4) do
			if ShipType.ContainInLimitBundle(iter_80_3, var_80_2) then
				table.remove(arg_80_4, iter_80_2)

				break
			end
		end
	end

	local var_80_3 = {}

	for iter_80_4, iter_80_5 in ipairs(arg_80_4) do
		(function(arg_81_0)
			local var_81_0 = var_80_0:GetRecommendShip(underscore.filter(arg_80_3, function(arg_82_0)
				return ShipType.ContainInLimitBundle(arg_81_0, arg_82_0)
			end), arg_80_2, arg_80_5)

			if var_81_0 then
				arg_80_2[#arg_80_2 + 1] = var_81_0.id

				table.insert(var_80_3, var_81_0.id)
			end

			return
		end)(iter_80_5)
	end

	return {}
end

function var_0_0.isClear(arg_83_0, arg_83_1)
	local var_83_0 = arg_83_0:GetChapterItemById(arg_83_1)

	if not var_83_0 then
		return false
	end

	return var_83_0:isClear()
end

function var_0_0.recordLastMap(arg_84_0, arg_84_1, arg_84_2)
	local var_84_0 = false

	if arg_84_1 == var_0_0.LAST_MAP_FOR_ACTIVITY and arg_84_2 ~= Map.lastMapForActivity then
		Map.lastMapForActivity = arg_84_2
		var_84_0 = true
	elseif arg_84_1 == var_0_0.LAST_MAP and arg_84_2 ~= Map.lastMap then
		Map.lastMap = arg_84_2
		var_84_0 = true
	end

	if var_84_0 then
		PlayerPrefs.SetInt(arg_84_1 .. getProxy(PlayerProxy):getRawData().id, arg_84_2)
		PlayerPrefs.Save()
	end

	return
end

function var_0_0.getLastMap(arg_85_0, arg_85_1)
	local var_85_0 = PlayerPrefs.GetInt(arg_85_1 .. getProxy(PlayerProxy):getRawData().id)

	if var_85_0 ~= 0 then
		return var_85_0
	end

	return
end

function var_0_0.IsActivitySPChapterActive(arg_86_0, arg_86_1)
	return _.any(_.reduce(arg_86_0:getMapsByActivities(arg_86_1), {}, function(arg_87_0, arg_87_1)
		table.insertto(arg_87_0, _.select(arg_87_1:getChapters(), function(arg_88_0)
			return arg_88_0:IsSpChapter()
		end))

		return arg_87_0
	end), function(arg_89_0)
		return arg_89_0:isUnlock() and arg_89_0:isPlayerLVUnlock() and arg_89_0:enoughTimes2Start()
	end)
end

function var_0_0.getSubAidFlag(arg_90_0, arg_90_1)
	local var_90_0 = false
	local var_90_1 = _.detect(arg_90_0.fleets, function(arg_91_0)
		return arg_91_0:getFleetType() == FleetType.Submarine and arg_91_0:isValid()
	end)

	if var_90_1 then
		if var_90_1:inHuntingRange(arg_90_0.fleet.line.row, arg_90_0.fleet.line.column) then
			var_90_0 = true
		else
			local var_90_2 = _.detect(var_90_1:getStrategies(), function(arg_92_0)
				return arg_92_0.id == ChapterConst.StrategyCallSubOutofRange
			end)

			if var_90_2 and var_90_2.count > 0 then
				var_90_0 = true
			end
		end
	end

	if var_90_0 then
		local var_90_3, var_90_4 = arg_90_0:getFleetCost(arg_90_0.fleet, arg_90_1)
		local var_90_5, var_90_6 = arg_90_0:getFleetAmmo(var_90_1)
		local var_90_7 = 0

		for iter_90_0, iter_90_1 in ipairs({
			arg_90_0:getFleetCost(var_90_1, arg_90_1)
		}) do
			var_90_7 = var_90_7 + iter_90_1.oil
		end

		if var_90_6 <= 0 then
			return ys.Battle.BattleConst.SubAidFlag.AMMO_EMPTY
		elseif var_90_7 + var_90_4.oil >= getProxy(PlayerProxy):getRawData().oil then
			return ys.Battle.BattleConst.SubAidFlag.OIL_EMPTY
		else
			return true, var_90_1
		end
	else
		return ys.Battle.BattleConst.SubAidFlag.AID_EMPTY
	end

	return
end

function var_0_0.GetChapterAuraBuffs(arg_93_0)
	for iter_93_0, iter_93_1 in ipairs(arg_93_0.fleets) do
		if iter_93_1:getFleetType() ~= FleetType.Support then
			for iter_93_2, iter_93_3 in ipairs((iter_93_1:getMapAura())) do
				table.insert({}, iter_93_3)
			end
		end
	end

	return {}
end

function var_0_0.GetChapterAidBuffs(arg_94_0)
	for iter_94_0, iter_94_1 in ipairs(arg_94_0.fleets) do
		if iter_94_1 ~= arg_94_0.fleet and iter_94_1:getFleetType() ~= FleetType.Support then
			for iter_94_2, iter_94_3 in pairs((iter_94_1:getMapAid())) do
				({})[iter_94_2] = iter_94_3
			end
		end
	end

	return {}
end

function var_0_0.RecordComboHistory(arg_95_0, arg_95_1, arg_95_2)
	if arg_95_2 ~= nil then
		arg_95_0:SetExtendChapterData(arg_95_1, "comboHistoryBuffer", arg_95_2)
	else
		arg_95_0:RemoveExtendChapterData(arg_95_1, "comboHistoryBuffer")
	end

	return
end

function var_0_0.GetComboHistory(arg_96_0, arg_96_1)
	return arg_96_0:GetExtendChapterData(arg_96_1, "comboHistoryBuffer")
end

function var_0_0.RecordJustClearChapters(arg_97_0, arg_97_1, arg_97_2)
	if arg_97_2 ~= nil then
		arg_97_0:SetExtendChapterData(arg_97_1, "justClearChapters", arg_97_2)
	else
		arg_97_0:RemoveExtendChapterData(arg_97_1, "justClearChapters")
	end

	return
end

function var_0_0.GetJustClearChapters(arg_98_0, arg_98_1)
	return arg_98_0:GetExtendChapterData(arg_98_1, "justClearChapters")
end

function var_0_0.RecordLastDefeatedEnemy(arg_99_0, arg_99_1, arg_99_2)
	if arg_99_2 ~= nil then
		arg_99_0:SetExtendChapterData(arg_99_1, "defeatedEnemiesBuffer", arg_99_2)
	else
		arg_99_0:RemoveExtendChapterData(arg_99_1, "defeatedEnemiesBuffer")
	end

	return
end

function var_0_0.GetLastDefeatedEnemy(arg_100_0, arg_100_1)
	return arg_100_0:GetExtendChapterData(arg_100_1, "defeatedEnemiesBuffer")
end

function var_0_0.ifShowRemasterTip(arg_101_0)
	return arg_101_0.remasterTip
end

function var_0_0.setRemasterTip(arg_102_0, arg_102_1)
	arg_102_0.remasterTip = arg_102_1

	return
end

function var_0_0.updateRemasterTicketsNum(arg_103_0, arg_103_1)
	arg_103_0.remasterTickets = arg_103_1

	return
end

function var_0_0.getRemasterTicketCost(arg_104_0)
	return 5
end

function var_0_0.resetDailyCount(arg_105_0)
	arg_105_0.remasterDailyCount = 0

	return
end

function var_0_0.updateDailyCount(arg_106_0)
	arg_106_0.remasterDailyCount = arg_106_0.remasterDailyCount + pg.gameset.reactivity_ticket_daily.key_value

	return
end

function var_0_0.GetSkipPrecombat(arg_107_0)
	if arg_107_0.skipPrecombat == nil then
		arg_107_0.skipPrecombat = PlayerPrefs.GetInt("chapter_skip_precombat", 0)
	end

	return arg_107_0.skipPrecombat > 0
end

function var_0_0.UpdateSkipPrecombat(arg_108_0, arg_108_1)
	arg_108_1 = tobool(arg_108_1) and 1 or 0

	if arg_108_1 ~= arg_108_0:GetSkipPrecombat() then
		PlayerPrefs.SetInt("chapter_skip_precombat", arg_108_1)

		arg_108_0.skipPrecombat = arg_108_1

		arg_108_0:sendNotification(var_0_0.CHAPTER_SKIP_PRECOMBAT_UPDATED, arg_108_1)
	end

	return
end

function var_0_0.GetChapterAutoFlag(arg_109_0, arg_109_1)
	return arg_109_0:GetExtendChapterData(arg_109_1, "AutoFightFlag")
end

function var_0_0.SetChapterAutoFlag(arg_110_0, arg_110_1, arg_110_2, arg_110_3)
	arg_110_2 = tobool(arg_110_2)

	if arg_110_2 == (arg_110_0:GetChapterAutoFlag(arg_110_1) == 1) then
		return
	end

	arg_110_0:SetExtendChapterData(arg_110_1, "AutoFightFlag", arg_110_2 and 1 or 0)

	if arg_110_2 then
		arg_110_0:UpdateSkipPrecombat(true)

		if AutoBotCommand.autoBotSatisfied() then
			PlayerPrefs.SetInt("autoBotIsAcitve" .. AutoBotCommand.GetAutoBotMark(), 1)
		end

		getProxy(MetaCharacterProxy):setMetaTacticsInfoOnStart()
		pg.BrightnessMgr.GetInstance():SetScreenNeverSleep(true)

		if not LOCK_BATTERY_SAVEMODE and PlayerPrefs.GetInt(AUTOFIGHT_BATTERY_SAVEMODE, 0) == 1 then
			if pg.BrightnessMgr.GetInstance():IsPermissionGranted() then
				pg.BrightnessMgr.GetInstance():EnterManualMode()

				if PlayerPrefs.GetInt(AUTOFIGHT_DOWN_FRAME, 0) == 1 then
					getProxy(SettingsProxy):RecordFrameRate()

					Application.targetFrameRate = 30
				end
			end
		end
	else
		arg_110_0:StopContinuousOperation(SYSTEM_SCENARIO, arg_110_3)
		pg.BrightnessMgr.GetInstance():SetScreenNeverSleep(false)

		if not LOCK_BATTERY_SAVEMODE then
			pg.BrightnessMgr.GetInstance():ExitManualMode()
			getProxy(SettingsProxy):RestoreFrameRate()
		end
	end

	arg_110_0.facade:sendNotification(var_0_0.CHAPTER_AUTO_FIGHT_FLAG_UPDATED, arg_110_2 and 1 or 0)
	arg_110_0.facade:sendNotification(PlayerResUI.CHANGE_TOUCH_ABLE, not arg_110_2)

	return
end

function var_0_0.StopAutoFight(arg_111_0, arg_111_1)
	local var_111_0 = arg_111_0:getActiveChapter(true)

	if not var_111_0 then
		return
	end

	arg_111_0:SetChapterAutoFlag(var_111_0.id, false, arg_111_1)

	return
end

function var_0_0.FinishAutoFight(arg_112_0, arg_112_1)
	if arg_112_0:GetChapterAutoFlag(arg_112_1) == 1 then
		pg.BrightnessMgr.GetInstance():SetScreenNeverSleep(false)

		if not LOCK_BATTERY_SAVEMODE then
			pg.BrightnessMgr.GetInstance():ExitManualMode()
			getProxy(SettingsProxy):RestoreFrameRate()
		end

		arg_112_0.facade:sendNotification(PlayerResUI.CHANGE_TOUCH_ABLE, true)
	end

	local var_112_0 = arg_112_0:GetExtendChapter(arg_112_1)

	arg_112_0:RemoveExtendChapter(arg_112_1)

	return var_112_0
end

function var_0_0.buildRemasterInfo(arg_113_0)
	arg_113_0.remasterInfo = {}

	for iter_113_0, iter_113_1 in ipairs(pg.re_map_template.all) do
		local var_113_0 = pg.re_map_template[iter_113_1].activity_id or 0

		for iter_113_2, iter_113_3 in ipairs(pg.re_map_template[iter_113_1].drop_gain) do
			if #iter_113_3 > 0 then
				local var_113_1, var_113_2, var_113_3, var_113_4 = unpack(iter_113_3)

				arg_113_0.remasterInfo[var_113_0] = defaultValue(arg_113_0.remasterInfo[var_113_0], {})
				arg_113_0.remasterInfo[var_113_0][var_113_1] = defaultValue(arg_113_0.remasterInfo[var_113_0][var_113_1], {})
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

function var_0_0.checkRemasterInfomation(arg_114_0)
	if not arg_114_0.checkRemaster then
		arg_114_0.checkRemaster = true

		arg_114_0:sendNotification(GAME.CHAPTER_REMASTER_INFO_REQUEST)
	end

	return
end

function var_0_0.getRemasterInfo(arg_115_0, arg_115_1, arg_115_2, arg_115_3)
	arg_115_1 = arg_115_1 or 0

	local var_115_0 = arg_115_0.remasterInfo and arg_115_0.remasterInfo[arg_115_1]

	if not var_115_0 then
		return nil
	end

	local var_115_1 = var_115_0[arg_115_2]

	if not var_115_0[arg_115_2] then
		return nil
	end

	if arg_115_3 then
		return var_115_1[arg_115_3]
	end

	return var_115_1
end

function var_0_0.addRemasterPassCount(arg_116_0, arg_116_1, arg_116_2)
	local var_116_0 = arg_116_0:getRemasterInfo(arg_116_2, arg_116_1)

	if not var_116_0 then
		return
	end

	local var_116_1

	for iter_116_0, iter_116_1 in pairs(var_116_0) do
		if iter_116_1.count < iter_116_1.max then
			iter_116_1.count = iter_116_1.count + 1
			var_116_1 = true
		end
	end

	if var_116_1 then
		arg_116_0:sendNotification(var_0_0.CHAPTER_REMASTER_INFO_UPDATED)
	end

	return
end

function var_0_0.markRemasterPassReceive(arg_117_0, arg_117_1, arg_117_2, arg_117_3)
	local var_117_0 = arg_117_0:getRemasterInfo(arg_117_3, arg_117_1, arg_117_2)

	if not var_117_0 then
		return
	end

	if not var_117_0.receive then
		var_117_0.receive = true

		arg_117_0:sendNotification(var_0_0.CHAPTER_REMASTER_INFO_UPDATED)
	end

	return
end

function var_0_0.anyRemasterAwardCanReceive(arg_118_0)
	for iter_118_0, iter_118_1 in pairs(arg_118_0.remasterInfo) do
		for iter_118_2, iter_118_3 in pairs(iter_118_1) do
			for iter_118_4, iter_118_5 in pairs(iter_118_3) do
				if not iter_118_5.receive and iter_118_5.count >= iter_118_5.max then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.AddActBossRewards(arg_119_0, arg_119_1)
	arg_119_0.actBossItems = arg_119_0.actBossItems or {}

	table.insertto(arg_119_0.actBossItems, arg_119_1)

	return
end

function var_0_0.PopActBossRewards(arg_120_0)
	local var_120_0 = arg_120_0.actBossItems or {}

	arg_120_0.actBossItems = nil

	return var_120_0
end

function var_0_0.AddBossSingleRewards(arg_121_0, arg_121_1)
	arg_121_0.bossSingleItems = arg_121_0.bossSingleItems or {}

	table.insertto(arg_121_0.bossSingleItems, arg_121_1)

	return
end

function var_0_0.PopBossSingleRewards(arg_122_0)
	local var_122_0 = arg_122_0.bossSingleItems or {}

	arg_122_0.bossSingleItems = nil

	return var_122_0
end

function var_0_0.WriteBackOnExitBattleResult(arg_123_0)
	local var_123_0 = arg_123_0:getActiveChapter()

	if var_123_0 then
		if var_123_0:existOni() then
			var_123_0:clearSubmarineFleet()
			arg_123_0:updateChapter(var_123_0)
		elseif var_123_0:isPlayingWithBombEnemy() then
			var_123_0.fleets = {
				var_123_0.fleet
			}
			var_123_0.findex = 1

			arg_123_0:updateChapter(var_123_0)
		end
	end

	return
end

function var_0_0.GetContinuousData(arg_124_0, arg_124_1)
	return arg_124_0.continuousData[arg_124_1]
end

function var_0_0.InitContinuousTime(arg_125_0, arg_125_1, arg_125_2)
	arg_125_0.continuousData[arg_125_1] = ContinuousOperationRuntimeData.New({
		system = arg_125_1,
		totalBattleTime = arg_125_2,
		battleTime = arg_125_2
	})

	return
end

function var_0_0.StopContinuousOperation(arg_126_0, arg_126_1, arg_126_2)
	local var_126_0 = arg_126_0:GetContinuousData(arg_126_1)

	if not var_126_0 or not var_126_0:IsActive() then
		return
	end

	if arg_126_2 == ChapterConst.AUTOFIGHT_STOP_REASON.MANUAL and arg_126_1 == SYSTEM_SCENARIO then
		pg.TipsMgr.GetInstance():ShowTips(i18n("multiple_sorties_stop"))
	end

	var_126_0:Stop(arg_126_2)

	return
end

function var_0_0.PopContinuousData(arg_127_0, arg_127_1)
	arg_127_0.continuousData[arg_127_1] = nil

	return arg_127_0.continuousData[arg_127_1]
end

function var_0_0.SetLastFleetIndex(arg_128_0, arg_128_1, arg_128_2)
	if arg_128_2 and arg_128_0.lastFleetIndex then
		return
	end

	arg_128_0.lastFleetIndex = arg_128_1

	return
end

function var_0_0.GetLastFleetIndex(arg_129_0)
	return arg_129_0.lastFleetIndex
end

function var_0_0.RemoveEliteFleetCommander(arg_130_0, arg_130_1)
	for iter_130_0, iter_130_1 in ipairs(arg_130_1) do
		({})[iter_130_1] = true
	end

	for iter_130_2, iter_130_3 in pairs(arg_130_0.mapEliteFleetCache) do
		for iter_130_4, iter_130_5 in pairs(iter_130_3) do
			for iter_130_6, iter_130_7 in ipairs(iter_130_5) do
				for iter_130_8, iter_130_9 in ipairs(iter_130_7[TeamType.FormCommander]) do
					if ({})[iter_130_9] then
						iter_130_7[TeamType.FormCommander][iter_130_8] = 0
						;({})[iter_130_2] = true
					end
				end
			end
		end
	end

	for iter_130_10, iter_130_11 in pairs(arg_130_0.data) do
		local var_130_0 = iter_130_11:getConfig("formation")

		if ({})[var_130_0] then
			iter_130_11:setEliteFleetList(Clone(arg_130_0.mapEliteFleetCache[var_130_0]))
			arg_130_0:updateChapter(iter_130_11)
		end
	end

	return
end

return var_0_0
