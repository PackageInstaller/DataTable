local var_0_0 = class("ChapterV2MapTrackView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.eventList_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.taskUiList_, ChapterV2MapEventItem)
	arg_1_0.trackCon_ = arg_1_0.trackConEx_:GetController("pathfindingBnt")
	arg_1_0.timelineCon_ = arg_1_0.timelineConEx_:GetController("track")
	arg_1_0.emptyTrackBtnView_ = ChapterV2MapEmptyTrackItemView.New(arg_1_0.emptyTrackBtnGo_)
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.timelineBtn_, nil, function()
		if not ChapterV2MapTools.IsMapTimelineEnabled(arg_2_0.mapId_) and arg_2_0.timelineBtn_.name ~= "btn_tracktest" then
			return
		end

		gameContext:Go("chapterV2MapTimeline", {})
		manager.notify:Invoke(CHAPTER_MAP_TIMELINE_BTN_CLICK)
	end)
	arg_2_0:AddBtnListener(arg_2_0.trackBtn_, nil, function()
		arg_2_0:SwitchTrack()
	end)
	arg_2_0:AddBtnListener(arg_2_0.timelineCancelBtn_, nil, function()
		ChapterV2MapAction.QuitTracking(arg_2_0.mapId_)
	end)

	arg_2_0.tempClickHandler_ = handler(arg_2_0, arg_2_0.TempClickEvent)
end

function var_0_0.TempClickEvent(arg_6_0, arg_6_1)
	return
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_0.eventIdList_[arg_7_1], true)
end

function var_0_0.OnTop(arg_8_0)
	arg_8_0:RefreshUI(arg_8_0.mapId_)
end

function var_0_0.OnEnter(arg_9_0)
	manager.notify:RegistListener(CHAPTER_MAP_TRACK_EVENT_CLICK, arg_9_0.tempClickHandler_)
end

function var_0_0.OnExit(arg_10_0)
	manager.notify:RemoveListener(CHAPTER_MAP_TRACK_EVENT_CLICK, arg_10_0.tempClickHandler_)
end

function var_0_0.SwitchTrack(arg_11_0)
	local var_11_0 = not ChapterV2MapData:IsAutoTrack()

	ChapterV2MapData:SetAutoTrack(var_11_0)
	arg_11_0.trackCon_:SetSelectedState(var_11_0 and "on" or "off")
end

function var_0_0.RefreshUI(arg_12_0, arg_12_1)
	arg_12_0.mapId_ = arg_12_1

	local var_12_0 = ChapterV2MapData:IsAutoTrack()

	arg_12_0.trackCon_:SetSelectedState(var_12_0 and "on" or "off")

	local var_12_1 = ChapterV2MapTools.GetNextEvent(arg_12_0.mapId_, nil, nil, true)
	local var_12_2 = ChapterV2MapTools.GetNextEvent(arg_12_0.mapId_)

	if var_12_2 == var_12_1 then
		var_12_2 = ChapterV2MapTools.GetNextEvent(arg_12_0.mapId_, var_12_1 ~= 0 and var_12_1 or nil)
	end

	if var_12_1 ~= 0 and not ChapterV2MapTools.IsEventUnlock(var_12_1) then
		local var_12_3 = ChapterV2MapTools.GetNextMapEvent(arg_12_0.mapId_)

		if var_12_3 ~= 0 then
			var_12_1 = var_12_3
		end
	end

	arg_12_0.eventIdList_ = {}

	if var_12_2 ~= 0 then
		table.insert(arg_12_0.eventIdList_, var_12_2)

		local var_12_4 = ChapterV2MapEventCfg[var_12_2]

		if var_12_4.type == ChapterV2MapConst.MapEventType.SIDE then
			for iter_12_0, iter_12_1 in ipairs(ChapterV2MapEventCfg.get_id_list_by_time_stamp[var_12_4.time_stamp]) do
				if iter_12_1 ~= var_12_2 and ChapterV2MapTools.IsEventConflict(var_12_2, iter_12_1) then
					table.insert(arg_12_0.eventIdList_, iter_12_1)
				end
			end
		end
	end

	if var_12_1 == 0 then
		var_12_2 = ChapterV2MapTools.GetNextMapEvent(arg_12_0.mapId_)

		if var_12_2 ~= 0 then
			if ChapterV2MapEventCfg[var_12_2].type == ChapterV2MapConst.MapEventType.MAIN then
				table.insert(arg_12_0.eventIdList_, 1, var_12_2)
			else
				table.insert(arg_12_0.eventIdList_, var_12_2)
			end
		else
			arg_12_0.emptyTrackBtnView_:SetData(arg_12_0.mapId_)
		end
	end

	if var_12_1 ~= var_12_2 and var_12_1 ~= 0 then
		table.insert(arg_12_0.eventIdList_, 1, var_12_1)
	end

	arg_12_0.eventList_:StartScroll(#arg_12_0.eventIdList_)

	if ChapterV2MapTools.IsMapTimelineEnabled(arg_12_0.mapId_) then
		if not ChapterV2MapData:TimelineGetTime() then
			arg_12_0.timelineCon_:SetSelectedState("open")
			SetActive(arg_12_0.timelineCancelBtn_.gameObject, false)

			arg_12_0.timelineText_.text = GetTips("CHAPTER_V2_BACKDATE_DEFAULT_TEXT")
		else
			arg_12_0.timelineCon_:SetSelectedState("backtrack")
			SetActive(arg_12_0.timelineCancelBtn_.gameObject, true)

			arg_12_0.timelineText_.text = GetTips("CHAPTER_V2_BACKDATE_VALID_TEXT")
		end
	else
		SetActive(arg_12_0.timelineCancelBtn_.gameObject, false)
		arg_12_0.timelineCon_:SetSelectedState("lock")
	end
end

function var_0_0.GetNextMapEventId(arg_13_0)
	if not arg_13_0.eventIdList_ then
		return nil
	end

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.eventIdList_) do
		if ChapterV2MapTools.GetMapIdByEvent(iter_13_1) ~= arg_13_0.mapId_ then
			return iter_13_1
		end
	end

	return nil
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.eventList_ then
		arg_14_0.eventList_:Dispose()

		arg_14_0.eventList_ = nil
	end

	if arg_14_0.emptyTrackBtnView_ then
		arg_14_0.emptyTrackBtnView_:Dispose()

		arg_14_0.emptyTrackBtnView_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
