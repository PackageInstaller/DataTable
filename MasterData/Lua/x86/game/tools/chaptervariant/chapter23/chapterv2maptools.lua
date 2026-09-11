local var_0_0 = {
	GetMapEvents = function(arg_1_0)
		local var_1_0 = {}

		for iter_1_0, iter_1_1 in ipairs(ChapterV2MapLocationCfg.get_id_list_by_map[arg_1_0] or {}) do
			table.insertto(var_1_0, ChapterV2MapEventCfg.get_id_list_by_location[iter_1_1] or {})
		end

		return var_1_0
	end,
	SortEvents = function(arg_2_0)
		table.sort(arg_2_0, function(arg_3_0, arg_3_1)
			if ChapterV2MapEventCfg[arg_3_0].time_stamp ~= ChapterV2MapEventCfg[arg_3_1].time_stamp then
				return ChapterV2MapEventCfg[arg_3_0].time_stamp < ChapterV2MapEventCfg[arg_3_1].time_stamp
			else
				return arg_3_0 < arg_3_1
			end
		end)
	end
}

function var_0_0.GetCachedMapSortedEvents(arg_4_0)
	var_0_0.cachedMapSortedEvents_ = var_0_0.cachedMapSortedEvents_ or {}

	if var_0_0.cachedMapSortedEvents_[arg_4_0] then
		return var_0_0.cachedMapSortedEvents_[arg_4_0]
	end

	local var_4_0 = var_0_0.GetMapEvents(arg_4_0)

	ChapterV2MapTools.SortEvents(var_4_0)

	var_0_0.cachedMapSortedEvents_[arg_4_0] = var_4_0

	return var_4_0
end

function var_0_0.ClearCache()
	var_0_0.cachedMapSortedEvents_ = nil
end

function var_0_0.GetMapLocations(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(ChapterV2MapLocationCfg.get_id_list_by_map[arg_6_0] or {}) do
		if ChapterV2MapTools.IsLocationUnlock(iter_6_1) and ChapterV2MapLocationCfg[iter_6_1].type ~= ChapterV2MapConst.MAPLOCATIONTYPE.SUBLOCALTION then
			table.insert(var_6_0, iter_6_1)
		end
	end

	return var_6_0
end

function var_0_0.GetMapLocationUnlock(arg_7_0)
	if ChapterV2MapLocationCfg[arg_7_0] then
		for iter_7_0, iter_7_1 in ipairs(ChapterV2MapLocationCfg[arg_7_0].first_unlock_condition) do
			if not IsConditionAchieved(iter_7_1) then
				return false
			end
		end
	else
		Debug.LogError("检查地点解锁时传入了不存在配置的地点ID: " .. arg_7_0)

		return false
	end

	return true
end

function var_0_0.GetLocationEvents(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(ChapterV2MapEventCfg.get_id_list_by_location[arg_8_0] or {}) do
		if ChapterV2MapTools.IsEventVisible(iter_8_1) and not ChapterV2MapTools.IsEventMeetFinishConditions(iter_8_1) then
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function var_0_0.IsLocationUnlock(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(ChapterV2MapLocationCfg[arg_9_0].first_unlock_condition) do
		if not IsConditionAchieved(iter_9_1) then
			return false
		end
	end

	return true
end

function var_0_0.GetCurrentMapMainLocation(arg_10_0)
	return var_0_0.GetCurrentMainLocation((ChapterV2MapData:GetCurrentLocationId() and ChapterV2MapData:GetCurrentLocationId() ~= 0 or nil) and ChapterV2MapData:GetCurrentLocationId())
end

function var_0_0.GetCurrentMainLocation(arg_11_0)
	if ChapterV2MapLocationCfg[arg_11_0] and ChapterV2MapLocationCfg[arg_11_0].type == ChapterV2MapConst.MAPLOCATIONTYPE.SUBLOCALTION then
		if ChapterV2MapLocationCfg.get_id_list_by_sub_location_id[arg_11_0] then
			locationId = ChapterV2MapLocationCfg.get_id_list_by_sub_location_id[arg_11_0]
		end
	elseif arg_11_0 and arg_11_0 ~= 0 then
		locationId = arg_11_0
	end

	return locationId
end

function var_0_0.IsChapterUnlock(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(ChapterV2ChapterCfg[locationId].unlock_condition) do
		if not IsConditionAchieved(iter_12_1) then
			return false
		end
	end

	return true
end

function var_0_0.IsEventCompleted(arg_13_0)
	if ChapterV2MapData:TimelineGetTime() then
		return ChapterV2MapData:IsEventCompletedTemp(arg_13_0)
	else
		return ChapterV2MapData:IsEventCompleted(arg_13_0)
	end
end

function var_0_0.IsEventUnlock(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(ChapterV2MapEventCfg[arg_14_0].unlock_condition) do
		if not IsConditionAchieved(iter_14_1) then
			return false, iter_14_1
		end
	end

	return true
end

function var_0_0.IsEventVisible(arg_15_0)
	if ChapterV2MapData:IsEventVisible(arg_15_0) then
		return true
	end

	if ChapterV2MapTools.IsEventMeetDisplayConditions(arg_15_0) then
		return true
	end

	return false
end

function var_0_0.IsEventMeetDisplayConditions(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(ChapterV2MapEventCfg[arg_16_0].display_condition) do
		if not IsConditionAchieved(iter_16_1) then
			return false, iter_16_1
		end
	end

	return true
end

function var_0_0.IsEventMeetFinishConditions(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(ChapterV2MapEventCfg[arg_17_0].finish_condition) do
		if not IsConditionAchieved(iter_17_1) then
			return false, iter_17_1
		end
	end

	return true
end

function var_0_0.IsEventInteractable(arg_18_0)
	if ChapterV2MapTools.IsEventVisible(arg_18_0) then
		return true
	end

	local var_18_0, var_18_1 = ChapterV2MapTools.IsEventUnlock(arg_18_0)

	return var_18_0, var_18_1
end

function var_0_0.CanEnterEvent(arg_19_0)
	if not ChapterV2MapTools.IsEventVisible(arg_19_0) then
		return false
	end

	local var_19_0, var_19_1 = ChapterV2MapTools.IsEventUnlock(arg_19_0)

	return var_19_0, var_19_1
end

function var_0_0.IsEventDisplayInTimeline(arg_20_0)
	local var_20_0
	local var_20_1 = ChapterV2MapData:TimelineGetTime()

	ChapterV2MapData:TimelineSetTime(nil)

	var_20_0 = ChapterV2MapEventCfg[arg_20_0].type == ChapterV2MapConst.MapEventType.MAIN and (ChapterV2MapData:IsEventCompleted(arg_20_0) or ChapterV2MapTools.IsEventVisible(arg_20_0)) or ChapterV2MapEventCfg[arg_20_0].type == ChapterV2MapConst.MapEventType.SIDE and (ChapterV2MapData:IsEventCompleted(arg_20_0) or ChapterV2MapTools.IsEventVisible(arg_20_0) and ChapterV2MapTools.IsEventDisplayInTimeline((ChapterV2MapTools.GetMainEventByEvent(arg_20_0)))) or ChapterV2MapTools.IsEventDisplayInTimeline((ChapterV2MapTools.GetMainEventByEvent(arg_20_0)))

	if var_20_1 then
		ChapterV2MapData:TimelineSetTime(var_20_1)
	end

	return var_20_0
end

function var_0_0.IsEventConflict(arg_21_0, arg_21_1)
	return ChapterV2MapEventCfg[arg_21_0].time_stamp == ChapterV2MapEventCfg[arg_21_1].time_stamp and table.equal(ChapterV2MapEventCfg[arg_21_0].display_condition, ChapterV2MapEventCfg[arg_21_1].display_condition, "all")
end

function var_0_0.GetMapIdByEvent(arg_22_0)
	if not ChapterV2MapEventCfg[arg_22_0] then
		return 0
	end

	return ChapterV2MapTools.GetMapIdByLocation(ChapterV2MapEventCfg[arg_22_0].location)
end

function var_0_0.GetMapIdByLocation(arg_23_0)
	if not ChapterV2MapLocationCfg[arg_23_0] then
		return 0
	end

	return ChapterV2MapLocationCfg[arg_23_0].map
end

function var_0_0.GetNextEvent(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_1
	local var_24_2

	if arg_24_2 then
		local var_24_0 = ChapterV2MapData:TimelineGetTime()

		ChapterV2MapData:TimelineSetTime(nil)

		if var_24_0 then
			ChapterV2MapData:TimelineSetTime(var_24_0)
		end

		do return (ChapterV2MapTools.GetNextEvent(arg_24_0, arg_24_1, false, arg_24_3)) end

		var_24_1 = arg_24_1 == nil
		var_24_2 = ipairs
	end

	for iter_24_0, iter_24_1 in var_24_2((ChapterV2MapTools.GetCachedMapSortedEvents(arg_24_0))) do
		if var_24_1 then
			if (ChapterV2MapEventCfg[iter_24_1].type == ChapterV2MapConst.MapEventType.MAIN or not arg_24_3 and ChapterV2MapEventCfg[iter_24_1].type == ChapterV2MapConst.MapEventType.SIDE) and not ChapterV2MapTools.IsEventCompleted(iter_24_1) and ChapterV2MapTools.IsEventVisible(iter_24_1) and not ChapterV2MapTools.IsEventMeetFinishConditions(iter_24_1) then
				return iter_24_1
			end
		elseif iter_24_1 == arg_24_1 then
			var_24_1 = true
		end
	end

	return 0
end

function var_0_0.GetNextMapEvent(arg_25_0)
	local var_25_0, var_25_1 = ChapterV2MapTools.GetCurrentMapCanUseTeleportTagList(arg_25_0)

	for iter_25_0, iter_25_1 in ipairs(var_25_1) do
		local var_25_2 = ChapterV2MapTools.GetNextEvent(iter_25_1, nil, nil, true)

		if var_25_2 ~= 0 then
			return var_25_2
		end
	end

	for iter_25_2, iter_25_3 in ipairs((ChapterV2MapTools.GetMapIDListByChapterClientID((ChapterV2MapTools.GetChapterClientIDByMap(arg_25_0))))) do
		local var_25_3 = ChapterV2MapTools.GetNextEvent(iter_25_3, nil, nil, true)

		if var_25_3 ~= 0 then
			return var_25_3
		end
	end

	return 0
end

function var_0_0.HasNextChapterClient(arg_26_0)
	if not ChapterClientCfg[arg_26_0] then
		return false
	end

	local var_26_0 = ChapterV2ChapterCfg.all or {}
	local var_26_1 = ChapterV2ChapterCfg.get_id_list_by_chapter_id[ChapterClientCfg[arg_26_0].chapter_list[#ChapterClientCfg[arg_26_0].chapter_list]][1]

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		if iter_26_1 == var_26_1 and iter_26_0 < #var_26_0 then
			return true, ChapterV2ChapterCfg[var_26_0[iter_26_0 + 1]].chapter_client_id
		end
	end

	return false
end

function var_0_0.GetMainEventByEvent(arg_27_0)
	local var_27_0 = ChapterV2MapTools.GetCachedMapSortedEvents((ChapterV2MapTools.GetMapIdByEvent(arg_27_0)))

	for iter_27_0 = table.indexof(var_27_0, arg_27_0) or 0, 1, -1 do
		if ChapterV2MapEventCfg[var_27_0[iter_27_0]].type == ChapterV2MapConst.MapEventType.MAIN then
			return var_27_0[iter_27_0]
		end
	end

	Debug.LogError(string.format("支线事件无法找到所属主线事件! event id=%d", arg_27_0))

	return 0
end

function var_0_0.GetSupplementEventOwner(arg_28_0)
	local var_28_0 = ChapterV2MapTools.GetCachedMapSortedEvents((ChapterV2MapTools.GetMapIdByEvent(arg_28_0)))

	for iter_28_0 = table.indexof(var_28_0, arg_28_0) or 0, 1, -1 do
		if ChapterV2MapEventCfg[var_28_0[iter_28_0]].type == ChapterV2MapConst.MapEventType.MAIN or ChapterV2MapEventCfg[var_28_0[iter_28_0]].type == ChapterV2MapConst.MapEventType.SIDE then
			return var_28_0[iter_28_0]
		end
	end

	Debug.LogError(string.format("补充事件无法找到所属主线事件! event id=%d", arg_28_0))

	return 0
end

function var_0_0.GetMapTimestamp(arg_29_0)
	local var_29_0 = ChapterV2MapTools.GetNextEvent(arg_29_0)

	if var_29_0 == 0 then
		local var_29_1 = ChapterV2MapTools.GetCachedMapSortedEvents(arg_29_0)

		var_29_0 = var_29_1[#var_29_1] or 0
	end

	return ChapterV2MapTools.GetEventTimestamp(var_29_0)
end

function var_0_0.GetEventTimestamp(arg_30_0)
	arg_30_0 = ChapterV2MapTools.GetMainEventByEvent(arg_30_0)

	return (ChapterV2MapEventCfg[arg_30_0] or nil) and (ChapterV2MapEventCfg[arg_30_0].time_stamp or 0)
end

function var_0_0.IsMapTimelineEnabled(arg_31_0)
	if ChapterV2MapCfg[arg_31_0].timeline_unlock_condition == 0 then
		return true
	end

	return IsConditionAchieved(ChapterV2MapCfg[arg_31_0].timeline_unlock_condition)
end

function var_0_0.IsMapInTracking(arg_32_0)
	return ChapterV2MapData:IsMapInTracking(arg_32_0)
end

function var_0_0.IsMapFinish(arg_33_0)
	local var_33_0 = ChapterV2MapTools.GetMapEvents(arg_33_0)
	local var_33_1 = 0

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		if ChapterV2MapData:IsEventCompleted(iter_33_1) then
			var_33_1 = var_33_1 + 1
		end
	end

	return var_33_1 >= #var_33_0
end

function var_0_0.OpenEvent(arg_34_0)
	if gameContext:GetLastOpenPage() == "chapterV2MapTimeline" then
		JumpTools.Back()
	end

	local var_34_0 = ChapterV2MapEventCfg[arg_34_0]

	if ChapterV2MapEventCfg[arg_34_0].type == ChapterV2MapConst.MapEventType.MAIN or var_34_0.type == ChapterV2MapConst.MapEventType.SIDE then
		local var_34_1 = var_34_0.params[1]
		local var_34_2 = getChapterIDByStageID(var_34_0.params[1])

		if not var_34_2 or var_34_2 == 0 then
			Debug.LogError(string.format("无法通过关卡ID获取章节ID! event id=%d, stage id=%d", arg_34_0, var_34_1))

			return
		end

		if not RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_MAP_V2_EVENT_RANGE + arg_34_0) then
			RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_MAP_V2_EVENT_RANGE + arg_34_0)
			ChapterV2MapAction.UpdateRedPoint()
		end

		local var_34_3 = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT

		local function var_34_4()
			local var_35_1 = BattleStageFactory.Produce(var_34_3, var_34_1)
			local var_35_2 = BattleStageData:GetStageData()[var_34_1]

			if var_35_1:GetCost() > ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) and (not var_35_2 or var_35_2 and var_35_2.clear_times < 1) then
				if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
					JumpTools.OpenPopUp("currencyBuyFatigue", {}, ViewConst.SYSTEM_ID.BUY_FATIGUE)
				else
					ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
				end
			else
				if BattleStageTools.SkipSectionSelectHero(var_34_3, var_34_1) then
					if BattleConst.BATTLE_TAG.STORY == BattleStageTools.GetStageCfg(var_34_3, var_34_1).tag then
						BattleController.GetInstance():LaunchStoryBattle(var_34_3, var_34_1, 0)
					else
						BattleController.GetInstance():LaunchBattle(var_35_1)
					end

					return
				end

				if StageTools.NeedShowContinueBattleWindow(var_34_3, var_34_1) then
					JumpTools.OpenPopUp("continueBattleCostPop", {
						stageType = var_34_3,
						stageID = var_34_1,
						callback = function()
							ChapterTools.DoReadyBattle(var_34_3, var_34_1)
						end
					})
				else
					ChapterTools.DoReadyBattle(var_34_3, var_34_1)
				end
			end
		end

		if BattleStageTools.CheckPopTrailStage(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, var_34_1, function()
			var_34_4()
		end) then
			-- block empty
		else
			var_34_4()
		end
	elseif var_34_0.type == ChapterV2MapConst.MapEventType.SUPPLEMENT then
		JumpTools.OpenPageByJump("stageArchive", {
			isClue = true,
			archiveID = var_34_0.params[1]
		})
		ChapterV2MapAction.ReadEvent(arg_34_0)
	elseif var_34_0.type == ChapterV2MapConst.MapEventType.DIALOGUE then
		ShowTips(var_34_0.params[1])
	end
end

function var_0_0.GoMap(arg_38_0)
	if ChapterV2MapData:GetCurrentMapId() == arg_38_0 then
		return
	end

	ChapterV2MapAction.QuitTracking(ChapterV2MapData:GetCurrentMapId())
	manager.notify:CallUpdateFunc(CHAPTER_MAP_CHANGE_MAP, arg_38_0)
	ChapterV2MapData:SetCurrentMapId(arg_38_0)
	ChapterV2MapData:UpdateTrackData()
	ChapterV2MapAction.UpdateRedPoint()
	ChapterV2MapAction.MoveLocation(ChapterV2MapCfg[arg_38_0].default_location)
end

function var_0_0.GetIconPrefabPath()
	return "Widget/System/Xuheng_PlotMap/XuhengPlotMapMainUI/"
end

function var_0_0.UpdateAllLocationDynamicTags()
	for iter_40_0, iter_40_1 in ipairs(ChapterV2MapCfg.all) do
		for iter_40_2, iter_40_3 in ipairs(ChapterV2MapLocationCfg.get_id_list_by_map[iter_40_1] or {}) do
			var_0_0.UpdateLocationDynamicTags(iter_40_3)
		end
	end
end

function var_0_0.UpdateLocationDynamicTags(arg_41_0)
	if not ChapterV2MapLocationCfg[arg_41_0] then
		return
	end

	local var_41_0 = ChapterV2MapLocationCfg[arg_41_0].interact_tag or {}
	local var_41_1 = var_0_0.GetDynamicTagsForLocation(arg_41_0)
	local var_41_2 = {}

	table.insertto(var_41_2, var_41_0)
	table.insertto(var_41_2, var_41_1)
	ChapterV2MapData:SetLocationActiveTagList(arg_41_0, var_41_2)
end

function var_0_0.GetDynamicTagsForLocation(arg_42_0)
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in ipairs(ChapterV2MapTagCfg.get_id_list_by_tag_behaviour[ChapterV2MapConst.MAPTAGTYPE.EVENT]) do
		if var_0_0.ShouldMountEventTagToLocation(iter_42_1, arg_42_0) then
			table.insert(var_42_0, iter_42_1)
		end
	end

	return var_42_0
end

function var_0_0.ShouldMountEventTagToLocation(arg_43_0, arg_43_1)
	if not ChapterV2MapTagCfg[arg_43_0] or ChapterV2MapTagCfg[arg_43_0].tag_behaviour ~= ChapterV2MapConst.MAPTAGTYPE.EVENT or not ChapterV2MapTagCfg[arg_43_0].behaviour_parameters or #ChapterV2MapTagCfg[arg_43_0].behaviour_parameters == 0 then
		return false
	end

	local var_43_0 = ChapterV2MapTagCfg[arg_43_0].behaviour_parameters[1]

	if not ChapterV2MapEventCfg[ChapterV2MapTagCfg[arg_43_0].behaviour_parameters[1]] or ChapterV2MapEventCfg[ChapterV2MapTagCfg[arg_43_0].behaviour_parameters[1]].location ~= arg_43_1 then
		return false
	end

	if not ChapterV2MapTools.IsEventVisible(var_43_0) then
		return false
	end

	for iter_43_0, iter_43_1 in ipairs(ChapterV2MapEventCfg[ChapterV2MapTagCfg[arg_43_0].behaviour_parameters[1]].finish_condition) do
		if IsConditionAchieved(iter_43_1) then
			return false
		end
	end

	return true
end

function var_0_0.ShouldUnmountEventTag(arg_44_0)
	if not ChapterV2MapTagCfg[arg_44_0] or ChapterV2MapTagCfg[arg_44_0].tag_behaviour ~= ChapterV2MapConst.MAPTAGTYPE.EVENT or not ChapterV2MapTagCfg[arg_44_0].behaviour_parameters or #ChapterV2MapTagCfg[arg_44_0].behaviour_parameters == 0 then
		return false
	end

	local var_44_0 = ChapterV2MapEventCfg[ChapterV2MapTagCfg[arg_44_0].behaviour_parameters[1]]

	if not ChapterV2MapEventCfg[ChapterV2MapTagCfg[arg_44_0].behaviour_parameters[1]] then
		return true
	end

	for iter_44_0, iter_44_1 in ipairs(var_44_0.finish_condition) do
		if IsConditionAchieved(iter_44_1) then
			return true
		end
	end

	return false
end

function var_0_0.OnEventCompleted(arg_45_0)
	for iter_45_0, iter_45_1 in ipairs(ChapterV2MapTagCfg.all) do
		if ChapterV2MapTagCfg[iter_45_1].tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.EVENT and ChapterV2MapTagCfg[iter_45_1].behaviour_parameters and #ChapterV2MapTagCfg[iter_45_1].behaviour_parameters > 0 and ChapterV2MapTagCfg[iter_45_1].behaviour_parameters[1] == arg_45_0 then
			if ChapterV2MapEventCfg[arg_45_0] then
				var_0_0.UpdateLocationDynamicTags(ChapterV2MapEventCfg[arg_45_0].location)
			end
		end
	end
end

function var_0_0.OnConditionChanged(arg_46_0)
	var_0_0.UpdateAllLocationDynamicTags()
end

function var_0_0.GetLocationActiveTagList(arg_47_0)
	if not ChapterV2MapLocationCfg[arg_47_0] then
		return {}
	end

	local var_47_0 = {}

	for iter_47_0, iter_47_1 in ipairs(ChapterV2MapLocationCfg[arg_47_0].interact_tag or {}) do
		table.insert(var_47_0, iter_47_1)
	end

	for iter_47_2, iter_47_3 in ipairs(ChapterV2MapData:GetLocationActiveTagList(arg_47_0) or {}) do
		table.insert(var_47_0, iter_47_3)
	end

	return var_47_0
end

function var_0_0.TigerTag(arg_48_0, arg_48_1)
	if ChapterV2MapTagCfg[arg_48_0] then
		-- block empty
	end
end

function var_0_0.GetChapterClientIDByMap(arg_49_0)
	return ChapterV2MapCfg[arg_49_0].chapter_client_id
end

function var_0_0.GetMapIDListByChapterClientID(arg_50_0)
	return ChapterV2MapCfg.get_id_list_by_chapter_client_id[arg_50_0] or {}
end

function var_0_0.GetChapterClientWorkingMap(arg_51_0)
	local var_51_0 = ChapterV2MapData:GetLastMapId()

	if var_51_0 and var_51_0 ~= 0 and ChapterV2MapTools.GetChapterClientIDByMap(var_51_0) == arg_51_0 then
		return var_51_0
	end

	local var_51_1 = ChapterV2MapTools.GetMapIDListByChapterClientID(arg_51_0)

	for iter_51_0, iter_51_1 in ipairs(var_51_1) do
		if not ChapterV2MapTools.IsMapFinish(iter_51_1) then
			return iter_51_1
		end
	end

	return var_51_1[#var_51_1] or 0
end

function var_0_0.GetCurrentMapCanUseTeleportTagList(arg_52_0)
	local var_52_0 = {}
	local var_52_1 = {}

	for iter_52_0, iter_52_1 in ipairs(ChapterV2MapLocationCfg.get_id_list_by_map[arg_52_0] or {}) do
		for iter_52_2, iter_52_3 in ipairs(ChapterV2MapTools.GetLocationActiveTagList(iter_52_1) or {}) do
			if ChapterV2MapTagCfg[iter_52_3].tag_behaviour == ChapterV2MapConst.MAPTAGTYPE.TELEPORT then
				table.insert(var_52_0, iter_52_3)
				table.insert(var_52_1, ChapterV2MapTagCfg[iter_52_3].behaviour_parameters[1])
			end
		end
	end

	return var_52_0, var_52_1
end

function var_0_0.GetChapterTaskType(arg_53_0)
	if GameSetting.chapter_v2_task_type then
		for iter_53_0, iter_53_1 in ipairs(GameSetting.chapter_v2_task_type.value) do
			if iter_53_1[1] == arg_53_0 then
				return iter_53_1[2]
			end
		end
	end

	return TaskConst.TASK_TYPE.CHAPTER_PLOT_23
end

function var_0_0.GetChapterTotalStarCnt(arg_54_0)
	return #(AssignmentCfg.get_id_list_by_type[ChapterV2MapTools.GetChapterTaskType(arg_54_0)] or {})
end

function var_0_0.GetChapterStarCnt(arg_55_0)
	local var_55_0 = 0

	for iter_55_0, iter_55_1 in ipairs(AssignmentCfg.get_id_list_by_type[ChapterV2MapTools.GetChapterTaskType(arg_55_0)] or {}) do
		local var_55_1 = TaskData2:GetTask(iter_55_1)

		if var_55_1 and var_55_1.progress >= AssignmentCfg[iter_55_1].need then
			var_55_0 = var_55_0 + 1
		end
	end

	return var_55_0
end

return var_0_0
