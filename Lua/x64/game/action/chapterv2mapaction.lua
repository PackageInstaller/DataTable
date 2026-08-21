local var_0_0 = {}

manager.net:Bind(24061, function(arg_1_0)
	ChapterV2MapData:InitData(arg_1_0)
	ChapterV2MapAction.UpdateRedPoint()
end)

function var_0_0.MoveLocation(arg_2_0, arg_2_1)
	local var_2_0 = ChapterV2MapTools.GetMapIdByLocation(arg_2_0)

	if ChapterV2MapData:GetCurrentLocationId(var_2_0) == arg_2_0 then
		return
	end

	local var_2_1 = {
		new_location = arg_2_0
	}

	manager.net:SendWithLoadingNew(24064, var_2_1, 24065, function(arg_3_0)
		if isSuccess(arg_3_0.result) then
			ChapterV2MapData:SetCurrentLocationId(arg_2_0)
			manager.notify:CallUpdateFunc(CHAPTER_MAP_MOVE_LOCATION, arg_2_0)

			if arg_2_1 then
				arg_2_1()
			end
		else
			ShowTips(arg_3_0.result)
		end
	end)
end

function var_0_0.ReadEvent(arg_4_0)
	if ChapterV2MapData:IsEventCompleted(arg_4_0) then
		return
	end

	local var_4_0 = {
		event_id = arg_4_0
	}

	manager.net:SendWithLoadingNew(24062, var_4_0, 24063, function(arg_5_0)
		if isSuccess(arg_5_0.result) then
			ChapterV2MapData:FinishEvent(arg_4_0)
			manager.notify:CallUpdateFunc(CHAPTER_MAP_EVENT_FINISH, arg_4_0)
		else
			ShowTips(arg_5_0.result)
		end
	end)
end

function var_0_0.TrackTimelineEvent(arg_6_0)
	if ChapterV2MapData:IsEventCompleted(arg_6_0) then
		local var_6_0 = {
			event_id = arg_6_0
		}

		manager.net:SendWithLoadingNew(24066, var_6_0, 24067, function(arg_7_0)
			if isSuccess(arg_7_0.result) then
				manager.notify:CallUpdateFunc(CHAPTER_MAP_TRACK_EVENT_RETURN, arg_6_0)
			else
				ShowTips(arg_7_0.result)
			end
		end)
	else
		local var_6_1 = ChapterV2MapData:GetCurrentMapId()

		if ChapterV2MapTools.IsMapInTracking(var_6_1) then
			ChapterV2MapAction.QuitTracking(var_6_1)
		end
	end
end

function var_0_0.QuitTracking(arg_8_0)
	local var_8_0 = ChapterV2MapData:GetCurrentMapId()

	if not ChapterV2MapTools.IsMapInTracking(var_8_0) then
		return
	end

	local var_8_1 = {
		map_id = var_8_0
	}

	manager.net:SendWithLoadingNew(24068, var_8_1, 24069, function(arg_9_0)
		if isSuccess(arg_9_0.result) then
			manager.notify:CallUpdateFunc(CHAPTER_MAP_TRACK_EVENT_RETURN, 0)
		else
			ShowTips(arg_9_0.result)
		end
	end)
end

function var_0_0.UpdateRedPoint()
	local var_10_0 = ChapterV2MapData:GetCurrentMapId()

	if var_10_0 == 0 then
		return
	end

	local var_10_1 = ChapterV2MapTools.GetCachedMapSortedEvents(var_10_0)
	local var_10_2 = ChapterV2MapLocationCfg.get_id_list_by_map[var_10_0]
	local var_10_3 = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_2) do
		local var_10_4 = ChapterV2MapLocationCfg.get_id_list_by_sub_location_id[iter_10_1]

		if var_10_4 then
			if not var_10_3[var_10_4] then
				var_10_3[var_10_4] = {}
			end

			table.insert(var_10_3[var_10_4], iter_10_1)
		end
	end

	for iter_10_2, iter_10_3 in ipairs(var_10_2) do
		local var_10_5 = {}

		for iter_10_4, iter_10_5 in ipairs(var_10_3[iter_10_3] or {}) do
			table.insert(var_10_5, string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_LOCATION, iter_10_5))
		end

		local var_10_6 = ChapterV2MapEventCfg.get_id_list_by_location[iter_10_3] or {}

		for iter_10_6, iter_10_7 in ipairs(var_10_6) do
			local var_10_7 = ChapterV2MapEventCfg[iter_10_7]
			local var_10_8 = string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_EVENT, iter_10_7)

			table.insert(var_10_5, var_10_8)

			if RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_MAP_V2_EVENT_RANGE + iter_10_7) or var_10_7.type == ChapterV2MapConst.MapEventType.SUPPLEMENT or var_10_7.type == ChapterV2MapConst.MapEventType.DIALOGUE or not ChapterV2MapTools.IsEventVisible(iter_10_7) or not not ChapterV2MapTools.IsEventMeetFinishConditions(iter_10_7) then
				manager.redPoint:setTip(var_10_8, 0)
			else
				manager.redPoint:setTip(var_10_8, 1)
			end
		end

		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.CHAPTER_MAP_V2_LOCATION, iter_10_3), var_10_5)
	end

	manager.redPoint:addGroup(RedPointConst.CHAPTER_MAP_V2_MAIN .. "_10123", {
		RedPointConst.CHAPTER_MAP_V2_TASK .. "_10123"
	})
	manager.redPoint:addGroup(RedPointConst.CHAPTER_MAP_V2_MAIN .. "_10124", {
		RedPointConst.CHAPTER_MAP_V2_TASK .. "_10124"
	})
	manager.redPoint:addGroup(RedPointConst.CHAPTER_MAP_V2_MAIN .. "_10125", {
		RedPointConst.CHAPTER_MAP_V2_TASK .. "_10125"
	})
	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT, ChapterConst.CHAPTER_CLIENT_23), {
		RedPointConst.CHAPTER_MAP_V2_MAIN .. "_10123"
	})
	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT, ChapterConst.CHAPTER_CLIENT_24), {
		RedPointConst.CHAPTER_MAP_V2_MAIN .. "_10124"
	})
	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT, ChapterConst.CHAPTER_CLIENT_25), {
		RedPointConst.CHAPTER_MAP_V2_MAIN .. "_10125"
	})
	manager.redPoint:addGroup(ActivityTools.GetRedPointKey(ActivityConst.ACTIVITY_CHAPTERV2_MAIN) .. ActivityConst.ACTIVITY_CHAPTERV2_MAIN, {
		RedPointConst.CHAPTER_MAP_V2_MAIN .. "_10123"
	})
	manager.redPoint:addGroup(ActivityTools.GetRedPointKey(ActivityConst.ACTIVITY_CHAPTERV2_MAIN_24) .. ActivityConst.ACTIVITY_CHAPTERV2_MAIN_24, {
		RedPointConst.CHAPTER_MAP_V2_MAIN .. "_10124"
	})
	manager.redPoint:addGroup(ActivityTools.GetRedPointKey(ActivityConst.ACTIVITY_CHAPTERV2_MAIN_25) .. ActivityConst.ACTIVITY_CHAPTERV2_MAIN_25, {
		RedPointConst.CHAPTER_MAP_V2_MAIN .. "_10125"
	})
	TaskRedPoint:UpdateChapterV2TaskRedTip()
end

return var_0_0
