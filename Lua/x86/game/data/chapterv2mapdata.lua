local var_0_0 = singletonClass("ChapterV2MapData")

function var_0_0.Init(arg_1_0)
	arg_1_0.eventCompleted_ = {}
	arg_1_0.visibleEvents_ = {}
	arg_1_0.trackInfo_ = {}
	arg_1_0.locationActiveTag_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0.eventCompleted_ = {}
	arg_2_0.visibleEvents_ = {}
	arg_2_0.trackInfo_ = {}

	arg_2_0:UpdateData(arg_2_1)
end

function var_0_0.UpdateData(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1.event_list) do
		arg_3_0.eventCompleted_[iter_3_1] = true
	end

	arg_3_1.now_location = tonumber(arg_3_1.now_location)

	local var_3_0 = ChapterV2MapTools.GetMapIdByLocation(arg_3_1.now_location)

	arg_3_0:SetLastMapId(var_3_0)
	arg_3_0:SetCurrentMapId(var_3_0)
	arg_3_0:SetLastLocationId(arg_3_1.now_location)

	local var_3_1 = {}

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.backtrack_list) do
		local var_3_2 = iter_3_3.map_id
		local var_3_3 = iter_3_3.start_event
		local var_3_4 = ChapterV2MapEventCfg[var_3_3].time_stamp

		var_3_1[ChapterV2MapTools.GetChapterClientIDByMap(var_3_2)] = var_3_4
	end

	for iter_3_4, iter_3_5 in pairs(var_3_1) do
		local var_3_5 = ChapterV2MapTools.GetMapIDListByChapterClientID(iter_3_4)

		for iter_3_6, iter_3_7 in ipairs(var_3_5) do
			arg_3_0.trackInfo_[iter_3_7] = {
				location = 0,
				eventCompleted_ = {}
			}

			local var_3_6 = ChapterV2MapTools.GetCachedMapSortedEvents(iter_3_7)

			for iter_3_8, iter_3_9 in ipairs(var_3_6) do
				local var_3_7 = ChapterV2MapEventCfg[iter_3_9]

				if ChapterV2MapData:IsEventCompleted(iter_3_9) and iter_3_5 > var_3_7.time_stamp then
					arg_3_0.trackInfo_[iter_3_7].eventCompleted_[iter_3_9] = true
				end
			end
		end
	end

	local var_3_8 = ChapterV2MapTools.GetNextEvent(var_3_0)

	if var_3_8 ~= 0 then
		arg_3_0:SetCurrentLocationId(ChapterV2MapEventCfg[var_3_8].location)
	end

	arg_3_0:UpdateTrackData()
	ChapterV2MapTools.UpdateAllLocationDynamicTags()
end

function var_0_0.FinishEvent(arg_4_0, arg_4_1)
	arg_4_0.eventCompleted_[arg_4_1] = true

	ChapterV2MapTools.OnEventCompleted(arg_4_1)
end

function var_0_0.IsEventCompleted(arg_5_0, arg_5_1)
	return arg_5_0.eventCompleted_[arg_5_1]
end

function var_0_0.GetCurrentLocationId(arg_6_0, arg_6_1)
	arg_6_1 = arg_6_1 or arg_6_0.currentMapId_

	if not arg_6_0.trackInfo_[arg_6_1] then
		if arg_6_1 == arg_6_0:GetLastMapId() then
			return arg_6_0:GetLastLocationId()
		end

		return 0
	end

	return arg_6_0.trackInfo_[arg_6_1].location
end

function var_0_0.SetCurrentLocationId(arg_7_0, arg_7_1)
	if arg_7_1 == 0 then
		arg_7_1 = arg_7_0:GetLastLocationId()
	end

	local var_7_0 = ChapterV2MapTools.GetMapIdByLocation(arg_7_1)

	if var_7_0 == arg_7_0:GetLastMapId() then
		if arg_7_0.trackInfo_[var_7_0] then
			arg_7_0.trackInfo_[var_7_0].location = arg_7_0:GetLastLocationId()
		end

		return
	end

	arg_7_0.trackInfo_[var_7_0].location = arg_7_1
end

function var_0_0.GetLastMapId(arg_8_0)
	return arg_8_0.lastMapId_
end

function var_0_0.SetLastMapId(arg_9_0, arg_9_1)
	arg_9_0.lastMapId_ = arg_9_1
end

function var_0_0.GetMapCurrentRole(arg_10_0, arg_10_1)
	local var_10_0 = ChapterV2MapCfg[arg_10_1]
	local var_10_1 = var_10_0.default_chara

	if var_10_0.switch_chara[1] then
		local var_10_2 = var_10_0.switch_chara[1][1]

		if ChapterV2MapTools.IsEventCompleted(var_10_2) then
			var_10_1 = var_10_0.switch_chara[1][2]
		end
	end

	return var_10_1 or 0
end

function var_0_0.UpdateTrackData(arg_11_0)
	local var_11_0 = arg_11_0.currentMapId_

	if ChapterV2MapTools.IsMapInTracking(var_11_0) then
		local var_11_1 = ChapterV2MapTools.GetCachedMapSortedEvents(var_11_0)
		local var_11_2
		local var_11_3

		for iter_11_0, iter_11_1 in ipairs(var_11_1) do
			local var_11_4 = ChapterV2MapEventCfg[iter_11_1]

			if var_11_4.type == ChapterV2MapConst.MapEventType.MAIN or var_11_4.type == ChapterV2MapConst.MapEventType.SIDE then
				local var_11_5 = var_11_4.time_stamp

				if arg_11_0.trackInfo_[var_11_0].eventCompleted_[iter_11_1] then
					if not var_11_2 or var_11_2 < var_11_5 then
						var_11_2 = var_11_5
					end
				elseif not var_11_3 or var_11_5 < var_11_3 then
					var_11_3 = var_11_5
				end
			end
		end

		local var_11_6 = var_11_3 or var_11_2 or 0

		if var_11_6 ~= 0 then
			ChapterV2MapData:PrepareDataBeforeTrack(var_11_0, var_11_6)
		else
			arg_11_0:TimelineClear()
		end
	else
		arg_11_0:TimelineClear()
	end
end

function var_0_0.IsMapInTracking(arg_12_0, arg_12_1)
	return arg_12_0.trackInfo_[arg_12_1] ~= nil
end

function var_0_0.PrepareDataBeforeTrack(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.trackingTime_ = arg_13_2
end

function var_0_0.IsEventCompletedTemp(arg_14_0, arg_14_1)
	local var_14_0 = ChapterV2MapTools.GetMapIdByEvent(arg_14_1)

	if not arg_14_0.trackInfo_[var_14_0] then
		return false
	end

	return arg_14_0.trackInfo_[var_14_0].eventCompleted_[arg_14_1]
end

function var_0_0.IsEventVisible(arg_15_0, arg_15_1)
	return arg_15_0.visibleEvents_[arg_15_1]
end

function var_0_0.TimelineClear(arg_16_0)
	arg_16_0.trackingTime_ = nil
end

function var_0_0.TimelineGetTime(arg_17_0)
	return arg_17_0.trackingTime_
end

function var_0_0.TimelineSetTime(arg_18_0, arg_18_1)
	arg_18_0.trackingTime_ = arg_18_1
end

function var_0_0.SetAutoTrack(arg_19_0, arg_19_1)
	arg_19_0.autoTrack_ = arg_19_1
end

function var_0_0.IsAutoTrack(arg_20_0)
	return arg_20_0.autoTrack_
end

function var_0_0.GetCurrentMapId(arg_21_0)
	return arg_21_0.currentMapId_
end

function var_0_0.SetCurrentMapId(arg_22_0, arg_22_1)
	arg_22_0.currentMapId_ = arg_22_1
end

function var_0_0.GetLastLocationId(arg_23_0, arg_23_1)
	return arg_23_0.lastLocationId_
end

function var_0_0.SetLastLocationId(arg_24_0, arg_24_1)
	arg_24_0.lastLocationId_ = arg_24_1
end

function var_0_0.FinishBattleStage(arg_25_0, arg_25_1)
	return
end

function var_0_0.GetLocationActiveTagList(arg_26_0, arg_26_1)
	return arg_26_0.locationActiveTag_[arg_26_1] or {}
end

function var_0_0.SetLocationActiveTagList(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.locationActiveTag_[arg_27_1] = arg_27_2

	table.sort(arg_27_2, function(arg_28_0, arg_28_1)
		local var_28_0 = ChapterV2MapTagCfg[arg_28_0]
		local var_28_1 = ChapterV2MapTagCfg[arg_28_1]

		if not var_28_0 then
			Debug.LogError("4.8存在没有的TagID" .. arg_28_0)
		end

		if not var_28_1 then
			Debug.LogError("4.8存在没有的TagID " .. arg_28_1)
		end

		if var_28_0.tag_behaviour == var_28_1.tag_behaviour then
			return var_28_0.tag_id < var_28_1.tag_id
		end

		return var_28_0.tag_behaviour < var_28_1.tag_behaviour
	end)
end

return var_0_0
