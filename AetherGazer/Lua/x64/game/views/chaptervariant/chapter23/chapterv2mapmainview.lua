local var_0_0 = class("ChapterV2MapMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Xuheng_PlotMap/XuhengPlotMapMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.trackView_ = ChapterV2MapTrackView.New(arg_3_0.trackGo_, arg_3_0)

	if arg_3_0.test_test_ then
		arg_3_0.testMapView_ = ChapterV2MapTestMapView.New(arg_3_0.tmpMapGo_)

		SetActive(arg_3_0.tmpMapGo_, true)
	end

	arg_3_0.baseMapView_ = ChapterV2MapBaseMapView.New(arg_3_0, arg_3_0.baseMapGo_)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.archiveCollectBtn_, nil, function()
		JumpTools.OpenPageByJump("chapterV2MapArchiveCollect", {
			chapterClientID = ChapterV2MapTools.GetChapterClientIDByMap(arg_4_0.mapId_)
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.collectBtn_, nil, function()
		JumpTools.OpenPageByJump("chapterV2MapReward", {
			chapterClientID = ChapterV2MapTools.GetChapterClientIDByMap(arg_4_0.mapId_)
		})
	end)

	arg_4_0.eventClickHandler_ = handler(arg_4_0, arg_4_0.OnClickTrackEvent)
	arg_4_0.timelineBtnClickHandler_ = handler(arg_4_0, arg_4_0.OnMapTimelineEventReturn)
end

function var_0_0.OnMapEventFinish(arg_7_0, arg_7_1)
	arg_7_0:RefreshUI()
	arg_7_0.baseMapView_:RefreshMisUnlockingMap(eventID)
	arg_7_0:PopChapterEndView()
end

function var_0_0.OnMapMoveLocation(arg_8_0, arg_8_1)
	if arg_8_0.isChangeMap_ then
		return
	end

	arg_8_0:RefreshUI()
end

function var_0_0.OnClickTrackEvent(arg_9_0, arg_9_1)
	local var_9_0 = ChapterV2MapTools.GetMapIdByEvent(arg_9_1)

	if var_9_0 ~= arg_9_0.mapId_ then
		ChapterV2MapTools.GoMap(var_9_0)

		arg_9_0.eventIdTracked_ = arg_9_1

		return
	end

	local var_9_1, var_9_2 = ChapterV2MapTools.IsEventUnlock(arg_9_1)

	if var_9_1 then
		arg_9_0.baseMapView_:OnClickTrackEvent(arg_9_1)
	else
		local var_9_3 = ConditionCfg[var_9_2]

		ShowTips(var_9_3.desc)
	end
end

function var_0_0.OnMapChangeMap(arg_10_0, arg_10_1)
	arg_10_0.isChangeMap_ = true

	arg_10_0.swichMapAni_:Play("UI_SwitchScenesUI", -1, 0)

	if arg_10_0.changeMapTimer_ then
		arg_10_0.changeMapTimer_:Stop()

		arg_10_0.changeMapTimer_ = nil
	end

	arg_10_0.changeMapTimer_ = Timer.New(function()
		arg_10_0.mapId_ = ChapterV2MapData:GetCurrentMapId()

		arg_10_0:CheckMapAutoEvent()
		arg_10_0:RefreshUI()
		arg_10_0.baseMapView_:OnMapChangeMap(arg_10_1)
		arg_10_0:PopChapterView()

		arg_10_0.isChangeMap_ = false

		if arg_10_0.eventIdTracked_ then
			arg_10_0.baseMapView_:OnClickTrackEvent(arg_10_0.eventIdTracked_)

			arg_10_0.eventIdTracked_ = nil
		end
	end, 1, 1)

	arg_10_0.changeMapTimer_:Start()
end

function var_0_0.OnMapTimelineEventReturn(arg_12_0, arg_12_1)
	arg_12_0.baseMapView_:ClearAllLocationItem()
	arg_12_0:RefreshUI()

	if arg_12_1 and ChapterV2MapEventCfg[arg_12_1] then
		ChapterV2MapAction.MoveLocation(ChapterV2MapEventCfg[arg_12_1].location, function()
			arg_12_0.baseMapView_:SetInitialMapCenter()
		end)
	else
		arg_12_0.baseMapView_:SetInitialMapCenter()
	end
end

function var_0_0.OnEnter(arg_14_0)
	manager.notify:RegistListener(CHAPTER_MAP_TRACK_EVENT_CLICK, arg_14_0.eventClickHandler_)
	manager.notify:RegistListener(CHAPTER_MAP_TIMELINE_BTN_CLICK, arg_14_0.timelineBtnClickHandler_)

	arg_14_0.chapterClientID_ = arg_14_0.params_.chapterClientID

	print("ChapterV2章节客户端ID: " .. tostring(arg_14_0.chapterClientID_))

	local var_14_0 = ChapterV2MapTools.GetChapterClientWorkingMap(arg_14_0.chapterClientID_)

	if var_14_0 ~= ChapterV2MapData:GetCurrentMapId(var_14_0) then
		ChapterV2MapData:SetCurrentMapId(var_14_0)
		ChapterV2MapAction.QuitTracking(ChapterV2MapData:GetCurrentMapId())
		ChapterV2MapData:UpdateTrackData()
		ChapterV2MapAction.UpdateRedPoint()
		ChapterV2MapAction.MoveLocation(ChapterV2MapCfg[var_14_0].default_location)
	end

	arg_14_0.mapId_ = ChapterV2MapData:GetCurrentMapId()

	print("ChapterV2当前地图ID: " .. tostring(arg_14_0.mapId_))
	arg_14_0.trackView_:OnEnter()

	arg_14_0.isChangeMap_ = false

	if arg_14_0.test_test_ then
		arg_14_0.testMapView_:OnEnter()
	end

	arg_14_0.baseMapView_:OnEnter()
	arg_14_0:RefreshUI()

	if ChapterV2MapData:IsAutoTrack() then
		arg_14_0:AutoTrackEvent()
	end

	arg_14_0:CheckMapAutoEvent()
	arg_14_0:CheckArchiveBtnShows()
	arg_14_0:BindRedPoint()
end

function var_0_0.BindRedPoint(arg_15_0)
	manager.redPoint:bindUIandKey(arg_15_0.collectBtn_.transform, RedPointConst.CHAPTER_MAP_V2_TASK .. "_" .. arg_15_0.chapterClientID_)
end

function var_0_0.UpdateBar(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
end

function var_0_0.OnTop(arg_17_0)
	SetActive(arg_17_0.leftBtnGo_, true)
	arg_17_0:UpdateBar()
	arg_17_0:PopChapterView()
	arg_17_0.trackView_:OnTop()
	arg_17_0.baseMapView_:OnTop()
	arg_17_0:PopChapterEndView()
end

function var_0_0.OnBehind(arg_18_0)
	SetActive(arg_18_0.leftBtnGo_, false)
end

function var_0_0.OnExit(arg_19_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CHAPTER_MAP_TRACK_EVENT_CLICK, arg_19_0.eventClickHandler_)
	manager.notify:RemoveListener(CHAPTER_MAP_TIMELINE_BTN_CLICK, arg_19_0.timelineBtnClickHandler_)
	arg_19_0:StopTimer()
	arg_19_0.trackView_:OnExit()

	if arg_19_0.test_test_ then
		arg_19_0.testMapView_:OnExit()
	end

	arg_19_0.baseMapView_:OnExit()
	arg_19_0:UnbindRedPoint()
end

function var_0_0.UnbindRedPoint(arg_20_0)
	manager.redPoint:unbindUIandKey(arg_20_0.collectBtn_.transform, RedPointConst.CHAPTER_MAP_V2_TASK .. "_" .. arg_20_0.chapterClientID_)
end

function var_0_0.StopTimer(arg_21_0)
	if arg_21_0.changeMapTimer_ then
		arg_21_0.changeMapTimer_:Stop()

		arg_21_0.changeMapTimer_ = nil
	end

	if arg_21_0.autoGoMapTimer_ then
		arg_21_0.autoGoMapTimer_:Stop()

		arg_21_0.autoGoMapTimer_ = nil
	end
end

function var_0_0.RefreshUI(arg_22_0)
	arg_22_0.trackView_:RefreshUI(ChapterV2MapData:GetCurrentMapId())

	if arg_22_0.test_test_ then
		arg_22_0.testMapView_:RefreshUI()
	end

	arg_22_0.baseMapView_:RefreshUI()
	arg_22_0:RefreshMusic()
end

function var_0_0.RefreshMusic(arg_23_0)
	arg_23_0.mapId_ = ChapterV2MapData:GetCurrentMapId()

	local var_23_0 = ChapterV2MapCfg[arg_23_0.mapId_]

	manager.audio:PlayBGM(var_23_0.sheet, var_23_0.bgm, var_23_0.bgm)

	arg_23_0.soundsText_.text = var_23_0.bgm
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0.trackView_:Dispose()

	if arg_24_0.test_test_ then
		arg_24_0.testMapView_:Dispose()
	end

	arg_24_0.baseMapView_:Dispose()
	var_0_0.super.Dispose(arg_24_0)
	ChapterV2MapTools.ClearCache()
end

function var_0_0.PopChapterView(arg_25_0)
	print("ChapterV2MapMainView:PopChapterView" .. " mapId: " .. tostring(arg_25_0.mapId_))

	local var_25_0 = ChapterV2MapTools.GetNextEvent(arg_25_0.mapId_)

	for iter_25_0, iter_25_1 in ipairs(ChapterV2ChapterCfg.get_id_list_by_unlock_event[var_25_0] or {}) do
		local var_25_1 = ChapterV2ChapterCfg[iter_25_1]

		if not string.isNullOrEmpty(var_25_1.prefab) and not getData("ChapterV2MapData", "chapter_pop_" .. iter_25_1) then
			JumpTools.OpenPageByJump("chapterV2MapChapterUnlock", {
				chapterId = iter_25_1
			})

			return
		end
	end
end

function var_0_0.PopChapterEndView(arg_26_0)
	if ChapterV2MapData:IsEventCompleted(ChapterV2MapConst.EVENT_ID_CONST.CHAPTER_23_END_EVENT) and arg_26_0.chapterClientID_ == ChapterV2MapConst.CHAPTER_CLIENT_ID_CONST.CHAPTER_23 and not getData("ChapterV2MapData", "chapter_end_pop_chatper_23") then
		JumpTools.OpenPageByJump("chapterV2MapChapterEndPop", {
			visitedStr = "chapter_end_pop_chatper_23"
		})

		return
	end

	if ChapterV2MapData:IsEventCompleted(ChapterV2MapConst.EVENT_ID_CONST.CHAPTER_24_END_EVENT) and arg_26_0.chapterClientID_ == ChapterV2MapConst.CHAPTER_CLIENT_ID_CONST.CHAPTER_24 and not getData("ChapterV2MapData", "chapter_end_pop_chatper_24") then
		JumpTools.OpenPageByJump("chapterV2MapChapterEndPop", {
			visitedStr = "chapter_end_pop_chatper_24"
		})

		return
	end

	if ChapterV2MapData:IsEventCompleted(ChapterV2MapConst.EVENT_ID_CONST.CHAPTER_25_END_EVENT) and ChapterV2MapData:IsEventCompleted(ChapterV2MapConst.EVENT_ID_CONST.CHAPTER_25_END_EVENT_2) and arg_26_0.chapterClientID_ == ChapterV2MapConst.CHAPTER_CLIENT_ID_CONST.CHAPTER_25 and not getData("ChapterV2MapData", "chapter_end_pop_chatper_25") then
		JumpTools.OpenPageByJump("chapterV2MapChapterEndPop", {
			visitedStr = "chapter_end_pop_chatper_25"
		})

		return
	end
end

function var_0_0.CheckMapAutoEvent(arg_27_0)
	local var_27_0 = ChapterV2MapTools.GetNextEvent(arg_27_0.mapId_, nil, true, true)

	if var_27_0 == ChapterV2MapConst.EVENT_ID_CONST.CHAPTER_23_AUTO_EVENT then
		ChapterV2MapTools.OpenEvent(var_27_0)
	end
end

function var_0_0.AutoTrackEvent(arg_28_0)
	local var_28_0 = arg_28_0.trackView_:GetNextMapEventId()

	if var_28_0 then
		arg_28_0.autoGoMapTimer_ = Timer.New(function()
			ChapterV2MapTools.GoMap(ChapterV2MapTools.GetMapIdByEvent(var_28_0))

			arg_28_0.eventIdTracked_ = var_28_0
		end, 0, 1)

		arg_28_0.autoGoMapTimer_:Start()

		return
	end

	local var_28_1 = ChapterV2MapTools.GetNextEvent(arg_28_0.mapId_, nil, nil, true)

	if var_28_1 == arg_28_0.trackEventId_ then
		-- block empty
	end

	arg_28_0.trackEventId_ = var_28_1

	if var_28_1 == 0 then
		return
	end

	local var_28_2 = ChapterV2MapEventCfg[var_28_1]
	local var_28_3 = var_28_2.location
	local var_28_4 = ChapterV2MapTools.GetCurrentMainLocation(var_28_2.location)

	arg_28_0.baseMapView_:OnClickMapLocation(var_28_4)

	local var_28_5, var_28_6 = ChapterV2MapTools.IsEventInteractable(var_28_1)

	if var_28_5 then
		arg_28_0.baseMapView_:OnClickTrackEvent(var_28_1)
	end
end

function var_0_0.CheckArchiveBtnShows(arg_30_0)
	if arg_30_0.chapterClientID_ == ChapterV2MapConst.CHAPTER_CLIENT_ID_CONST.CHAPTER_24 or arg_30_0.chapterClientID_ == ChapterV2MapConst.CHAPTER_CLIENT_ID_CONST.CHAPTER_25 then
		SetActive(arg_30_0.archiveCollectBtn_.gameObject, false)
	else
		SetActive(arg_30_0.archiveCollectBtn_.gameObject, true)
	end
end

return var_0_0
