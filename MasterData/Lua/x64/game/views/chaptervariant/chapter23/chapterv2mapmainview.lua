local ChapterV2MapMainView = class("ChapterV2MapMainView", ReduxView)

function ChapterV2MapMainView:UIName()
	return "Widget/System/Xuheng_PlotMap/XuhengPlotMapMainUI"
end

function ChapterV2MapMainView:UIParent()
	return manager.ui.uiMain.transform
end

function ChapterV2MapMainView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.trackView_ = ChapterV2MapTrackView.New(self.trackGo_, self)

	if self.test_test_ then
		self.testMapView_ = ChapterV2MapTestMapView.New(self.tmpMapGo_)

		SetActive(self.tmpMapGo_, true)
	end

	self.baseMapView_ = ChapterV2MapBaseMapView.New(self, self.baseMapGo_)
end

function ChapterV2MapMainView:AddListeners()
	self:AddBtnListener(self.archiveCollectBtn_, nil, function()
		JumpTools.OpenPageByJump("chapterV2MapArchiveCollect", {
			chapterClientID = ChapterV2MapTools.GetChapterClientIDByMap(self.mapId_)
		})
	end)
	self:AddBtnListener(self.collectBtn_, nil, function()
		JumpTools.OpenPageByJump("chapterV2MapReward", {
			chapterClientID = ChapterV2MapTools.GetChapterClientIDByMap(self.mapId_)
		})
	end)

	self.eventClickHandler_ = handler(self, self.OnClickTrackEvent)
	self.timelineBtnClickHandler_ = handler(self, self.OnMapTimelineEventReturn)
end

function ChapterV2MapMainView:OnMapEventFinish(arg_7_1)
	self:RefreshUI()
	self.baseMapView_:RefreshMisUnlockingMap(eventID)
	self:PopChapterEndView()
end

function ChapterV2MapMainView:OnMapMoveLocation(arg_8_1)
	if self.isChangeMap_ then
		return
	end

	self:RefreshUI()
end

function ChapterV2MapMainView:OnClickTrackEvent(arg_9_1)
	local var_9_0 = ChapterV2MapTools.GetMapIdByEvent(arg_9_1)

	if var_9_0 ~= self.mapId_ then
		ChapterV2MapTools.GoMap(var_9_0)

		self.eventIdTracked_ = arg_9_1

		return
	end

	local var_9_1, var_9_2 = ChapterV2MapTools.IsEventUnlock(arg_9_1)

	if var_9_1 then
		self.baseMapView_:OnClickTrackEvent(arg_9_1)
	else
		ShowTips(ConditionCfg[var_9_2].desc)
	end
end

function ChapterV2MapMainView:OnMapChangeMap(arg_10_1)
	self.isChangeMap_ = true

	self.swichMapAni_:Play("UI_SwitchScenesUI", -1, 0)

	if self.changeMapTimer_ then
		self.changeMapTimer_:Stop()

		self.changeMapTimer_ = nil
	end

	self.changeMapTimer_ = Timer.New(function()
		self.mapId_ = ChapterV2MapData:GetCurrentMapId()

		self:CheckMapAutoEvent()
		self:RefreshUI()
		self.baseMapView_:OnMapChangeMap(arg_10_1)
		self:PopChapterView()

		self.isChangeMap_ = false

		if self.eventIdTracked_ then
			self.baseMapView_:OnClickTrackEvent(self.eventIdTracked_)

			self.eventIdTracked_ = nil
		end
	end, 1, 1)

	self.changeMapTimer_:Start()
end

function ChapterV2MapMainView:OnMapTimelineEventReturn(arg_12_1)
	self.baseMapView_:ClearAllLocationItem()
	self:RefreshUI()

	if arg_12_1 and ChapterV2MapEventCfg[arg_12_1] then
		ChapterV2MapAction.MoveLocation(ChapterV2MapEventCfg[arg_12_1].location, function()
			self.baseMapView_:SetInitialMapCenter()
		end)
	else
		self.baseMapView_:SetInitialMapCenter()
	end
end

function ChapterV2MapMainView:OnEnter()
	manager.notify:RegistListener(CHAPTER_MAP_TRACK_EVENT_CLICK, self.eventClickHandler_)
	manager.notify:RegistListener(CHAPTER_MAP_TIMELINE_BTN_CLICK, self.timelineBtnClickHandler_)

	self.chapterClientID_ = self.params_.chapterClientID

	print("ChapterV2章节客户端ID: " .. tostring(self.chapterClientID_))

	local var_14_0 = ChapterV2MapTools.GetChapterClientWorkingMap(self.chapterClientID_)

	if var_14_0 ~= ChapterV2MapData:GetCurrentMapId(var_14_0) then
		ChapterV2MapData:SetCurrentMapId(var_14_0)
		ChapterV2MapAction.QuitTracking(ChapterV2MapData:GetCurrentMapId())
		ChapterV2MapData:UpdateTrackData()
		ChapterV2MapAction.UpdateRedPoint()
		ChapterV2MapAction.MoveLocation(ChapterV2MapCfg[var_14_0].default_location)
	end

	self.mapId_ = ChapterV2MapData:GetCurrentMapId()

	print("ChapterV2当前地图ID: " .. tostring(self.mapId_))
	self.trackView_:OnEnter()

	self.isChangeMap_ = false

	if self.test_test_ then
		self.testMapView_:OnEnter()
	end

	self.baseMapView_:OnEnter()
	self:RefreshUI()

	if ChapterV2MapData:IsAutoTrack() then
		self:AutoTrackEvent()
	end

	self:CheckMapAutoEvent()
	self:CheckArchiveBtnShows()
	self:BindRedPoint()
end

function ChapterV2MapMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.collectBtn_.transform, RedPointConst.CHAPTER_MAP_V2_TASK .. "_" .. self.chapterClientID_)
end

function ChapterV2MapMainView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
end

function ChapterV2MapMainView:OnTop()
	SetActive(self.leftBtnGo_, true)
	self:UpdateBar()
	self:PopChapterView()
	self.trackView_:OnTop()
	self.baseMapView_:OnTop()
	self:PopChapterEndView()
end

function ChapterV2MapMainView:OnBehind()
	SetActive(self.leftBtnGo_, false)
end

function ChapterV2MapMainView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CHAPTER_MAP_TRACK_EVENT_CLICK, self.eventClickHandler_)
	manager.notify:RemoveListener(CHAPTER_MAP_TIMELINE_BTN_CLICK, self.timelineBtnClickHandler_)
	self:StopTimer()
	self.trackView_:OnExit()

	if self.test_test_ then
		self.testMapView_:OnExit()
	end

	self.baseMapView_:OnExit()
	self:UnbindRedPoint()
end

function ChapterV2MapMainView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.collectBtn_.transform, RedPointConst.CHAPTER_MAP_V2_TASK .. "_" .. self.chapterClientID_)
end

function ChapterV2MapMainView:StopTimer()
	if self.changeMapTimer_ then
		self.changeMapTimer_:Stop()

		self.changeMapTimer_ = nil
	end

	if self.autoGoMapTimer_ then
		self.autoGoMapTimer_:Stop()

		self.autoGoMapTimer_ = nil
	end
end

function ChapterV2MapMainView:RefreshUI()
	self.trackView_:RefreshUI(ChapterV2MapData:GetCurrentMapId())

	if self.test_test_ then
		self.testMapView_:RefreshUI()
	end

	self.baseMapView_:RefreshUI()
	self:RefreshMusic()
end

function ChapterV2MapMainView:RefreshMusic()
	self.mapId_ = ChapterV2MapData:GetCurrentMapId()

	manager.audio:PlayBGM(ChapterV2MapCfg[self.mapId_].sheet, ChapterV2MapCfg[self.mapId_].bgm, ChapterV2MapCfg[self.mapId_].bgm)

	self.soundsText_.text = ChapterV2MapCfg[self.mapId_].bgm
end

function ChapterV2MapMainView:Dispose()
	self.trackView_:Dispose()

	if self.test_test_ then
		self.testMapView_:Dispose()
	end

	self.baseMapView_:Dispose()
	ChapterV2MapMainView.super.Dispose(self)
	ChapterV2MapTools.ClearCache()
end

function ChapterV2MapMainView:PopChapterView()
	print("ChapterV2MapMainView:PopChapterView" .. " mapId: " .. tostring(self.mapId_))

	for iter_25_0, iter_25_1 in ipairs(ChapterV2ChapterCfg.get_id_list_by_unlock_event[ChapterV2MapTools.GetNextEvent(self.mapId_)] or {}) do
		if not string.isNullOrEmpty(ChapterV2ChapterCfg[iter_25_1].prefab) and not getData("ChapterV2MapData", "chapter_pop_" .. iter_25_1) then
			JumpTools.OpenPageByJump("chapterV2MapChapterUnlock", {
				chapterId = iter_25_1
			})

			return
		end
	end
end

function ChapterV2MapMainView:PopChapterEndView()
	if ChapterV2MapData:IsEventCompleted(ChapterV2MapConst.EVENT_ID_CONST.CHAPTER_23_END_EVENT) and self.chapterClientID_ == ChapterV2MapConst.CHAPTER_CLIENT_ID_CONST.CHAPTER_23 and not getData("ChapterV2MapData", "chapter_end_pop_chatper_23") then
		JumpTools.OpenPageByJump("chapterV2MapChapterEndPop", {
			visitedStr = "chapter_end_pop_chatper_23"
		})

		return
	end

	if ChapterV2MapData:IsEventCompleted(ChapterV2MapConst.EVENT_ID_CONST.CHAPTER_24_END_EVENT) and self.chapterClientID_ == ChapterV2MapConst.CHAPTER_CLIENT_ID_CONST.CHAPTER_24 and not getData("ChapterV2MapData", "chapter_end_pop_chatper_24") then
		JumpTools.OpenPageByJump("chapterV2MapChapterEndPop", {
			visitedStr = "chapter_end_pop_chatper_24"
		})

		return
	end

	if ChapterV2MapData:IsEventCompleted(ChapterV2MapConst.EVENT_ID_CONST.CHAPTER_25_END_EVENT) and ChapterV2MapData:IsEventCompleted(ChapterV2MapConst.EVENT_ID_CONST.CHAPTER_25_END_EVENT_2) and self.chapterClientID_ == ChapterV2MapConst.CHAPTER_CLIENT_ID_CONST.CHAPTER_25 and not getData("ChapterV2MapData", "chapter_end_pop_chatper_25") then
		JumpTools.OpenPageByJump("chapterV2MapChapterEndPop", {
			visitedStr = "chapter_end_pop_chatper_25"
		})

		return
	end
end

function ChapterV2MapMainView:CheckMapAutoEvent()
	local var_27_0 = ChapterV2MapTools.GetNextEvent(self.mapId_, nil, true, true)

	if var_27_0 == ChapterV2MapConst.EVENT_ID_CONST.CHAPTER_23_AUTO_EVENT then
		ChapterV2MapTools.OpenEvent(var_27_0)
	end
end

function ChapterV2MapMainView:AutoTrackEvent()
	local var_28_0 = self.trackView_:GetNextMapEventId()

	if var_28_0 then
		self.autoGoMapTimer_ = Timer.New(function()
			ChapterV2MapTools.GoMap(ChapterV2MapTools.GetMapIdByEvent(var_28_0))

			self.eventIdTracked_ = var_28_0
		end, 0, 1)

		self.autoGoMapTimer_:Start()

		return
	end

	local var_28_1 = ChapterV2MapTools.GetNextEvent(self.mapId_, nil, nil, true)

	if var_28_1 == self.trackEventId_ then
		-- block empty
	end

	self.trackEventId_ = var_28_1

	if var_28_1 == 0 then
		return
	end

	self.baseMapView_:OnClickMapLocation((ChapterV2MapTools.GetCurrentMainLocation(ChapterV2MapEventCfg[var_28_1].location)))

	local var_28_3, var_28_4 = ChapterV2MapTools.IsEventInteractable(var_28_1)

	if var_28_3 then
		self.baseMapView_:OnClickTrackEvent(var_28_1)
	end
end

function ChapterV2MapMainView:CheckArchiveBtnShows()
	if self.chapterClientID_ == ChapterV2MapConst.CHAPTER_CLIENT_ID_CONST.CHAPTER_24 or self.chapterClientID_ == ChapterV2MapConst.CHAPTER_CLIENT_ID_CONST.CHAPTER_25 then
		SetActive(self.archiveCollectBtn_.gameObject, false)
	else
		SetActive(self.archiveCollectBtn_.gameObject, true)
	end
end

return ChapterV2MapMainView
