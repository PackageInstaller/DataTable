local ChapterV2MapTrackView = class("ChapterV2MapTrackView", ReduxView)

function ChapterV2MapTrackView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.eventList_ = LuaList.New(handler(self, self.IndexItem), self.taskUiList_, ChapterV2MapEventItem)
	self.trackCon_ = self.trackConEx_:GetController("pathfindingBnt")
	self.timelineCon_ = self.timelineConEx_:GetController("track")
	self.emptyTrackBtnView_ = ChapterV2MapEmptyTrackItemView.New(self.emptyTrackBtnGo_)
end

function ChapterV2MapTrackView:AddListeners()
	self:AddBtnListener(self.timelineBtn_, nil, function()
		if not ChapterV2MapTools.IsMapTimelineEnabled(self.mapId_) and self.timelineBtn_.name ~= "btn_tracktest" then
			return
		end

		gameContext:Go("chapterV2MapTimeline", {})
		manager.notify:Invoke(CHAPTER_MAP_TIMELINE_BTN_CLICK)
	end)
	self:AddBtnListener(self.trackBtn_, nil, function()
		self:SwitchTrack()
	end)
	self:AddBtnListener(self.timelineCancelBtn_, nil, function()
		ChapterV2MapAction.QuitTracking(self.mapId_)
	end)

	self.tempClickHandler_ = handler(self, self.TempClickEvent)
end

function ChapterV2MapTrackView:TempClickEvent(arg_6_1)
	return
end

function ChapterV2MapTrackView:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(self.eventIdList_[arg_7_1], true)
end

function ChapterV2MapTrackView:OnTop()
	self:RefreshUI(self.mapId_)
end

function ChapterV2MapTrackView:OnEnter()
	manager.notify:RegistListener(CHAPTER_MAP_TRACK_EVENT_CLICK, self.tempClickHandler_)
end

function ChapterV2MapTrackView:OnExit()
	manager.notify:RemoveListener(CHAPTER_MAP_TRACK_EVENT_CLICK, self.tempClickHandler_)
end

function ChapterV2MapTrackView:SwitchTrack()
	local var_11_0 = not ChapterV2MapData:IsAutoTrack()

	ChapterV2MapData:SetAutoTrack(var_11_0)
	self.trackCon_:SetSelectedState(var_11_0 and "on" or "off")
end

function ChapterV2MapTrackView:RefreshUI(arg_12_1)
	self.mapId_ = arg_12_1

	self.trackCon_:SetSelectedState(ChapterV2MapData:IsAutoTrack() and "on" or "off")

	local var_12_0 = ChapterV2MapTools.GetNextEvent(self.mapId_, nil, nil, true)
	local var_12_1 = ChapterV2MapTools.GetNextEvent(self.mapId_)

	if var_12_1 == var_12_0 then
		var_12_1 = ChapterV2MapTools.GetNextEvent(self.mapId_, var_12_0 ~= 0 and var_12_0 or nil)
	end

	if var_12_0 ~= 0 and not ChapterV2MapTools.IsEventUnlock(var_12_0) then
		local var_12_2 = ChapterV2MapTools.GetNextMapEvent(self.mapId_)

		if var_12_2 ~= 0 then
			var_12_0 = var_12_2
		end
	end

	self.eventIdList_ = {}

	if var_12_1 ~= 0 then
		table.insert(self.eventIdList_, var_12_1)

		if ChapterV2MapEventCfg[var_12_1].type == ChapterV2MapConst.MapEventType.SIDE then
			for iter_12_0, iter_12_1 in ipairs(ChapterV2MapEventCfg.get_id_list_by_time_stamp[ChapterV2MapEventCfg[var_12_1].time_stamp]) do
				if iter_12_1 ~= var_12_1 and ChapterV2MapTools.IsEventConflict(var_12_1, iter_12_1) then
					table.insert(self.eventIdList_, iter_12_1)
				end
			end
		end
	end

	if var_12_0 == 0 then
		var_12_1 = ChapterV2MapTools.GetNextMapEvent(self.mapId_)

		if var_12_1 ~= 0 then
			if ChapterV2MapEventCfg[var_12_1].type == ChapterV2MapConst.MapEventType.MAIN then
				table.insert(self.eventIdList_, 1, var_12_1)
			else
				table.insert(self.eventIdList_, var_12_1)
			end
		else
			self.emptyTrackBtnView_:SetData(self.mapId_)
		end
	end

	if var_12_0 ~= var_12_1 and var_12_0 ~= 0 then
		table.insert(self.eventIdList_, 1, var_12_0)
	end

	self.eventList_:StartScroll(#self.eventIdList_)

	if ChapterV2MapTools.IsMapTimelineEnabled(self.mapId_) then
		if not ChapterV2MapData:TimelineGetTime() then
			self.timelineCon_:SetSelectedState("open")
			SetActive(self.timelineCancelBtn_.gameObject, false)

			self.timelineText_.text = GetTips("CHAPTER_V2_BACKDATE_DEFAULT_TEXT")
		else
			self.timelineCon_:SetSelectedState("backtrack")
			SetActive(self.timelineCancelBtn_.gameObject, true)

			self.timelineText_.text = GetTips("CHAPTER_V2_BACKDATE_VALID_TEXT")
		end
	else
		SetActive(self.timelineCancelBtn_.gameObject, false)
		self.timelineCon_:SetSelectedState("lock")
	end
end

function ChapterV2MapTrackView:GetNextMapEventId()
	if not self.eventIdList_ then
		return nil
	end

	for iter_13_0, iter_13_1 in ipairs(self.eventIdList_) do
		if ChapterV2MapTools.GetMapIdByEvent(iter_13_1) ~= self.mapId_ then
			return iter_13_1
		end
	end

	return nil
end

function ChapterV2MapTrackView:Dispose()
	if self.eventList_ then
		self.eventList_:Dispose()

		self.eventList_ = nil
	end

	if self.emptyTrackBtnView_ then
		self.emptyTrackBtnView_:Dispose()

		self.emptyTrackBtnView_ = nil
	end

	ChapterV2MapTrackView.super.Dispose(self)
end

return ChapterV2MapTrackView
