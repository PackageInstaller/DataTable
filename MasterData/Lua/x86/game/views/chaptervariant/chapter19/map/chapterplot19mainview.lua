local ChapterPlot19MainView = class("ChapterPlot19MainView", ReduxView)

function ChapterPlot19MainView:UIName()
	return "Widget/System/Operation/OperationVerMapUI"
end

function ChapterPlot19MainView:UIParent()
	return manager.ui.uiMain.transform
end

function ChapterPlot19MainView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.updateAllHandler_ = handler(self, self.UpdateAll)
	self.OnCloseDayPanelHandler_ = handler(self, self.OnCloseDayPanel)
	self.mapView_ = ChapterPlot19MapView.New(self.mapGo_)
	self.dayView_ = ChapterPlotDayView.New(self, self.dayGo_)
	self.watchController_ = self.watchControllerEx_:GetController("watchState")
	self.hideScanController_ = self.watchControllerEx_:GetController("hideScan")
	self.showScanEffectController_ = self.watchControllerEx_:GetController("showScanEffect")
end

function ChapterPlot19MainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.notify:RegistListener(CHAPTER_DAY_CHANGED, self.updateAllHandler_)
	manager.notify:RegistListener(CHAPTER_CLOSE_DAY_LIST, self.OnCloseDayPanelHandler_)
	self:UpdateAll(true)
	self:OnCloseDayPanel()
	self.mapView_:OnEnter()
	self.dayView_:OnEnter()
	self:AddArrowTimer()
	manager.redPoint:bindUIandKey(self.collectTf_, RedPointConst.COMBAT_PLOT_CHAPTER_19_STAR)
end

function ChapterPlot19MainView:OnEnterOver()
	self:CheckNeedAutoBattle()
end

function ChapterPlot19MainView:OnUpdate()
	self.mapView_:OnUpdate()
	self.dayView_:OnUpdate()
	self:RefreshCollectClue()
end

function ChapterPlot19MainView:OnExit()
	manager.redPoint:unbindUIandKey(self.collectTf_, RedPointConst.COMBAT_PLOT_CHAPTER_19_STAR)
	manager.windowBar:HideBar()
	self:StopScan()
	self:StopArrowTimer()
	self.mapView_:OnExit()
	self.dayView_:OnExit()
	manager.notify:RemoveListener(CHAPTER_DAY_CHANGED, self.updateAllHandler_)
	manager.notify:RemoveListener(CHAPTER_CLOSE_DAY_LIST, self.OnCloseDayPanelHandler_)

	self.lastAudioID_ = nil
end

function ChapterPlot19MainView:AddListeners()
	self:AddBtnListener(self.collectBtn_, nil, function()
		if self.mapView_:GetBackCnt() > 0 then
			self:Back()

			return
		end

		JumpTools.OpenPageByJump("chapterPlot19Reward", {
			level = 1,
			chapterID = self.chapterID_
		})
	end)
	self:AddBtnListener(self.clueBtn_, nil, function()
		if self.mapView_:GetBackCnt() > 0 then
			self:Back()

			return
		end

		JumpTools.OpenPageByJump("chapterClue", {
			chapterID = self.chapterID_
		})
	end)
	self:AddBtnListener(self.scanBtn_, nil, function()
		if self.mapView_:GetBackCnt() > 0 then
			self:Back()

			return
		end

		manager.ui:UIEventEnabled(false)
		self:ScanAnimator(function()
			manager.ui:UIEventEnabled(true)
			BattleStageAction.ScanClueLocation(self.mapID_, function(arg_13_0)
				self:RefreshMap()
				self:RefreshScanBtn()
				ShowTips(string.format(GetTips("SCAN_MEMORY_FRAGMENT"), #arg_13_0.location_id_list))
			end)
		end)
	end)
	self:AddBtnListener(self.watchBtn_, nil, function()
		if self.mapView_:GetBackCnt() > 0 then
			self:Back()

			return
		end

		local var_14_0 = ChapterMapCfg.get_id_list_by_chapter_id[self.chapterID_]

		if ChapterTools.IsNeedOperateFirstDayWatch(self.chapterID_, self.selectDay_) then
			BattleStageAction.OperateChapterDay(self.chapterID_, ChapterMapCfg[var_14_0[1]].day, function()
				BattleFieldData:SaveChapterMapDay(self.chapterID_, ChapterMapCfg[var_14_0[2]].day)
				manager.notify:Invoke(CHAPTER_DAY_CHANGED)
				self:OnCloseDayPanel()
			end)

			return
		end

		if ChapterTools.IsNeedOperateLastDayWatch(self.chapterID_, self.selectDay_) then
			local var_14_1 = ChapterMapCfg[var_14_0[#var_14_0]].day

			BattleStageAction.OperateChapterDay(self.chapterID_, ChapterMapCfg[var_14_0[#var_14_0]].day, function()
				BattleFieldData:SaveChapterMapDay(self.chapterID_, var_14_1)
				manager.notify:Invoke(CHAPTER_DAY_CHANGED)
				self:OnCloseDayPanel()
			end)

			return
		end

		BattleFieldData:SaveChapterMapID(self.chapterID_, self.selectDay_, ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][self.selectDay_][(#ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][self.selectDay_] > 1 and table.keyof(ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][self.selectDay_], self.mapID_) == 1 or nil) and 2])
		manager.notify:Invoke(CHAPTER_DAY_CHANGED)
		self:OnCloseDayPanel()
	end)
	self:AddBtnListener(self.storyCollectBtn_, nil, function()
		if ChapterTools.IsReadFirstEvent(self.chapterID_) then
			JumpTools.OpenPageByJump("chapterPlot19StoryCollect", {
				chapterID = self.chapterID_
			})
		else
			ShowTips("COLLECTION_STORY_AND_READ")
		end
	end)
end

function ChapterPlot19MainView:UpdateAll(arg_18_1)
	self:RefreshData()
	self:ResetMapPosition()
	self:RefreshUI(arg_18_1)

	if not arg_18_1 then
		self:CheckNeedAutoBattle()
	end
end

function ChapterPlot19MainView:OnCloseDayPanel()
	self:RefreshSwitchBtn()
end

function ChapterPlot19MainView:RefreshData()
	self.chapterClientID_ = ChapterConst.CHAPTER_CLIENT_19
	self.chapterID_ = ChapterClientCfg[self.chapterClientID_].chapter_list[1]
	self.selectDay_ = BattleFieldData:GetChapterMapDay(self.chapterID_)
	self.mapID_ = BattleFieldData:GetChapterMapID(self.chapterID_, self.selectDay_)
end

function ChapterPlot19MainView:CheckNeedAutoBattle()
	if table.keyof(GameSetting.chapter19_auto_battle_day_list.value, self.selectDay_) then
		if ChapterLocationCfg[ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][self.selectDay_][1]].location_list[1]].stage_list[1] and not ChapterTools.IsClearStage(ChapterLocationCfg[ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][self.selectDay_][1]].location_list[1]].stage_list[1]) and not BattleStageData:GetAutoBattleFlag(ChapterLocationCfg[ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][self.selectDay_][1]].location_list[1]].stage_list[1]) then
			if BattleChapterStageCfg[ChapterLocationCfg[ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][self.selectDay_][1]].location_list[1]].stage_list[1]].cost > ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) then
				return
			end

			BattleFieldData:SetChapterLocationID(self.chapterID_, ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][self.selectDay_][1]].location_list[1])
			BattleStageData:SaveAutoBattleFlag(ChapterLocationCfg[ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][self.selectDay_][1]].location_list[1]].stage_list[1])
			ChapterTools.DoReadyBattle(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, ChapterLocationCfg[ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][self.selectDay_][1]].location_list[1]].stage_list[1])
		end
	end
end

function ChapterPlot19MainView:RefreshUI(arg_22_1)
	self:RefreshCollectStar()
	self:RefreshMap(arg_22_1)
	self:RefreshDay()
	self:RefreshScanBtn()
	self:RefreshCollectClue()
	self:RefreshAudio()
end

function ChapterPlot19MainView:ResetMapPosition()
	self.mapView_:ResetMapPosition()
end

function ChapterPlot19MainView:RefreshCollectStar()
	local var_24_0 = ChapterTools.GetChapterStarCnt(self.chapterID_)
	local var_24_1 = ChapterTools.GetChapterTotalStarCnt(self.chapterID_)

	self.numText_.text = var_24_0
	self.totalText_.text = string.format("/%s", var_24_1)
	self.collectImage_.fillAmount = var_24_0 / var_24_1
end

function ChapterPlot19MainView:RefreshMap(arg_25_1)
	self.mapView_:SetMapID(self.chapterID_, self.mapID_, arg_25_1)
end

function ChapterPlot19MainView:RefreshDay()
	self.dayView_:SetData(self.selectDay_, self.chapterID_)
end

function ChapterPlot19MainView:RefreshScanBtn()
	self.hideScanController_:SetSelectedState(tostring(not ChapterTools.HasClueLocation(self.mapID_)))
	self.showScanEffectController_:SetSelectedState(tostring(ChapterTools.HasUnscanClue(self.mapID_)))
end

function ChapterPlot19MainView:RefreshSwitchBtn()
	if self.selectDay_ == ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id[self.chapterID_][1]].day and not ChapterTools.IsNeedOperateFirstDayWatch(self.chapterID_, self.selectDay_) or ChapterTools.IsLastDay(self.chapterID_, self.selectDay_) then
		if self.isHideWatch_ ~= true then
			self.watchAnimator_:Play("View_out", 0, 1)

			self.isHideWatch_ = true
		end
	else
		if self.isHideWatch_ then
			self.watchAnimator_:Play("dayList_enter", 0, 0)

			self.isHideWatch_ = false
		end

		if ChapterTools.IsNeedOperateFirstDayWatch(self.chapterID_, self.selectDay_) then
			self.watchController_:SetSelectedState("lock")
		elseif ChapterTools.IsNeedOperateLastDayWatch(self.chapterID_, self.selectDay_) then
			self.watchController_:SetSelectedState("exitSpecialSpace")
		elseif table.keyof(ChapterMapCfg.get_id_list_by_chapter_id_day[self.chapterID_][self.selectDay_], self.mapID_) == 1 then
			self.watchController_:SetSelectedState("innerSpace")

			self.watchText_.text = GetTips("SURFACE_SPACE")
		else
			self.watchController_:SetSelectedState("outwardSpace")

			self.watchText_.text = self.selectDay_ == 4 and "???" or GetTips("INNER_SPACE")
		end
	end

	if ChapterTools.NeedShowSwitchMapGuild(self.chapterID_, self.selectDay_, self.mapID_) then
		self.watchGuildAnimator_:Play("map_unlock2", 0, 0)
	else
		self.watchGuildAnimator_:Play("empty", 0, 0)
	end
end

function ChapterPlot19MainView:RefreshCollectClue()
	local var_29_0, var_29_1 = ChapterTools.GetChapterClueCnt(self.chapterID_)

	self.clueCntText_.text = string.format("%s/%s", var_29_0, var_29_1)
end

function ChapterPlot19MainView:ScanAnimator(arg_30_1)
	self:StopScan()
	self.scanAnimator_:Play("scan", 0, 0)

	self.scanTimer_ = FrameTimer.New(function()
		if self.scanAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			arg_30_1()
			self:StopScan()
		end
	end, 1, -1)

	self.scanTimer_:Start()
end

function ChapterPlot19MainView:StopScan()
	if self.scanTimer_ then
		self.scanTimer_:Stop()

		self.scanTimer_ = nil
	end
end

function ChapterPlot19MainView:AddArrowTimer()
	self.arrowTimer_ = FrameTimer.New(function()
		self:ShowArrow()
	end, 1, -1)

	self.arrowTimer_:Start()
end

function ChapterPlot19MainView:StopArrowTimer()
	if self.arrowTimer_ then
		self.arrowTimer_:Stop()

		self.arrowTimer_ = nil
	end
end

function ChapterPlot19MainView:ShowArrow()
	local var_36_0 = ChapterTools.GetUnclearMainStageLocationID(self.mapID_)

	if var_36_0 then
		local var_36_1 = Vector3(ChapterLocationCfg[var_36_0].position[1], ChapterLocationCfg[var_36_0].position[2], 0) + self.contentTf_.localPosition

		if self.viewPortTf_.rect.width / 2 < math.abs(var_36_1.x) or self.viewPortTf_.rect.height / 2 < math.abs(var_36_1.y) then
			SetActive(self.arrowGo_, true)

			local var_36_2 = MathTools.GetAngle(Vector3(0, 0, 0), var_36_1) + 180

			self.arrowTf_.localEulerAngles = Vector3(0, 0, var_36_2)

			local var_36_3 = self.viewPortTf_.rect.width / 2 - 200
			local var_36_4 = (self.viewPortTf_.rect.width / 2 - 200) * math.tan(((var_36_2 + 180) % 360 - 180) / 180 * math.pi)

			if (var_36_2 + 180) % 360 - 180 > -90 and (var_36_2 + 180) % 360 - 180 < 90 then
				var_36_3 = -(self.viewPortTf_.rect.width / 2 - 200)
				var_36_4 = -(self.viewPortTf_.rect.width / 2 - 200) * math.tan(((var_36_2 + 180) % 360 - 180) / 180 * math.pi)
			end

			if self.viewPortTf_.rect.height / 2 - 200 < math.abs(var_36_4) then
				if (var_36_2 + 180) % 360 - 180 > -180 and (var_36_2 + 180) % 360 - 180 < 0 then
					var_36_4 = self.viewPortTf_.rect.height / 2 - 200
					var_36_3 = (self.viewPortTf_.rect.height / 2 - 200) / math.tan(((var_36_2 + 180) % 360 - 180) / 180 * math.pi)
				else
					var_36_4 = -(self.viewPortTf_.rect.height / 2 - 200)
					var_36_3 = -(self.viewPortTf_.rect.height / 2 - 200) / math.tan(((var_36_2 + 180) % 360 - 180) / 180 * math.pi)
				end
			end

			self.arrowTf_.localPosition = Vector3(var_36_3, var_36_4, 0)
		else
			SetActive(self.arrowGo_, false)
		end
	else
		SetActive(self.arrowGo_, false)
	end
end

function ChapterPlot19MainView:RefreshAudio()
	local var_37_0 = ChapterTools.GetChapterAudioIDList(self.mapID_)

	if self.lastAudioID_ == var_37_0[#var_37_0] then
		return
	end

	for iter_37_0, iter_37_1 in ipairs(var_37_0) do
		manager.audio:PlayUIAudio(ChapterAudioCfg[iter_37_1].bgm_id)
	end

	self.bgmNameText_.text = ChapterAudioCfg[var_37_0[#var_37_0]].name
	self.lastAudioID_ = var_37_0[#var_37_0]
end

function ChapterPlot19MainView:Dispose()
	self.updateAllHandler_ = nil
	self.OnCloseDayPanelHandler_ = nil

	self.mapView_:Dispose()

	self.mapView_ = nil

	self.dayView_:Dispose()

	self.dayView_ = nil

	ChapterPlot19MainView.super.Dispose(self)
end

return ChapterPlot19MainView
