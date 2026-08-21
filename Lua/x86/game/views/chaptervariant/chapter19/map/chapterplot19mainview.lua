local var_0_0 = class("ChapterPlot19MainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/OperationVerMapUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.updateAllHandler_ = handler(arg_3_0, arg_3_0.UpdateAll)
	arg_3_0.OnCloseDayPanelHandler_ = handler(arg_3_0, arg_3_0.OnCloseDayPanel)
	arg_3_0.mapView_ = ChapterPlot19MapView.New(arg_3_0.mapGo_)
	arg_3_0.dayView_ = ChapterPlotDayView.New(arg_3_0, arg_3_0.dayGo_)
	arg_3_0.watchController_ = arg_3_0.watchControllerEx_:GetController("watchState")
	arg_3_0.hideScanController_ = arg_3_0.watchControllerEx_:GetController("hideScan")
	arg_3_0.showScanEffectController_ = arg_3_0.watchControllerEx_:GetController("showScanEffect")
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.notify:RegistListener(CHAPTER_DAY_CHANGED, arg_4_0.updateAllHandler_)
	manager.notify:RegistListener(CHAPTER_CLOSE_DAY_LIST, arg_4_0.OnCloseDayPanelHandler_)
	arg_4_0:UpdateAll(true)
	arg_4_0:OnCloseDayPanel()
	arg_4_0.mapView_:OnEnter()
	arg_4_0.dayView_:OnEnter()
	arg_4_0:AddArrowTimer()
	manager.redPoint:bindUIandKey(arg_4_0.collectTf_, RedPointConst.COMBAT_PLOT_CHAPTER_19_STAR)
end

function var_0_0.OnEnterOver(arg_5_0)
	arg_5_0:CheckNeedAutoBattle()
end

function var_0_0.OnUpdate(arg_6_0)
	arg_6_0.mapView_:OnUpdate()
	arg_6_0.dayView_:OnUpdate()
	arg_6_0:RefreshCollectClue()
end

function var_0_0.OnExit(arg_7_0)
	manager.redPoint:unbindUIandKey(arg_7_0.collectTf_, RedPointConst.COMBAT_PLOT_CHAPTER_19_STAR)
	manager.windowBar:HideBar()
	arg_7_0:StopScan()
	arg_7_0:StopArrowTimer()
	arg_7_0.mapView_:OnExit()
	arg_7_0.dayView_:OnExit()
	manager.notify:RemoveListener(CHAPTER_DAY_CHANGED, arg_7_0.updateAllHandler_)
	manager.notify:RemoveListener(CHAPTER_CLOSE_DAY_LIST, arg_7_0.OnCloseDayPanelHandler_)

	arg_7_0.lastAudioID_ = nil
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.collectBtn_, nil, function()
		if arg_8_0.mapView_:GetBackCnt() > 0 then
			arg_8_0:Back()

			return
		end

		JumpTools.OpenPageByJump("chapterPlot19Reward", {
			level = 1,
			chapterID = arg_8_0.chapterID_
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.clueBtn_, nil, function()
		if arg_8_0.mapView_:GetBackCnt() > 0 then
			arg_8_0:Back()

			return
		end

		JumpTools.OpenPageByJump("chapterClue", {
			chapterID = arg_8_0.chapterID_
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.scanBtn_, nil, function()
		if arg_8_0.mapView_:GetBackCnt() > 0 then
			arg_8_0:Back()

			return
		end

		manager.ui:UIEventEnabled(false)
		arg_8_0:ScanAnimator(function()
			manager.ui:UIEventEnabled(true)
			BattleStageAction.ScanClueLocation(arg_8_0.mapID_, function(arg_13_0)
				arg_8_0:RefreshMap()
				arg_8_0:RefreshScanBtn()

				local var_13_0 = #arg_13_0.location_id_list

				ShowTips(string.format(GetTips("SCAN_MEMORY_FRAGMENT"), var_13_0))
			end)
		end)
	end)
	arg_8_0:AddBtnListener(arg_8_0.watchBtn_, nil, function()
		if arg_8_0.mapView_:GetBackCnt() > 0 then
			arg_8_0:Back()

			return
		end

		local var_14_0 = ChapterMapCfg.get_id_list_by_chapter_id[arg_8_0.chapterID_]

		if ChapterTools.IsNeedOperateFirstDayWatch(arg_8_0.chapterID_, arg_8_0.selectDay_) then
			local var_14_1 = var_14_0[1]
			local var_14_2 = ChapterMapCfg[var_14_1].day

			BattleStageAction.OperateChapterDay(arg_8_0.chapterID_, var_14_2, function()
				local var_15_0 = ChapterMapCfg[var_14_0[2]].day

				BattleFieldData:SaveChapterMapDay(arg_8_0.chapterID_, var_15_0)
				manager.notify:Invoke(CHAPTER_DAY_CHANGED)
				arg_8_0:OnCloseDayPanel()
			end)

			return
		end

		if ChapterTools.IsNeedOperateLastDayWatch(arg_8_0.chapterID_, arg_8_0.selectDay_) then
			local var_14_3 = var_14_0[#var_14_0]
			local var_14_4 = ChapterMapCfg[var_14_3].day

			BattleStageAction.OperateChapterDay(arg_8_0.chapterID_, var_14_4, function()
				BattleFieldData:SaveChapterMapDay(arg_8_0.chapterID_, var_14_4)
				manager.notify:Invoke(CHAPTER_DAY_CHANGED)
				arg_8_0:OnCloseDayPanel()
			end)

			return
		end

		local var_14_5 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_8_0.chapterID_][arg_8_0.selectDay_]
		local var_14_6 = 1

		if #var_14_5 > 1 and table.keyof(var_14_5, arg_8_0.mapID_) == 1 then
			var_14_6 = 2
		end

		local var_14_7 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_8_0.chapterID_][arg_8_0.selectDay_][var_14_6]

		BattleFieldData:SaveChapterMapID(arg_8_0.chapterID_, arg_8_0.selectDay_, var_14_7)
		manager.notify:Invoke(CHAPTER_DAY_CHANGED)
		arg_8_0:OnCloseDayPanel()
	end)
	arg_8_0:AddBtnListener(arg_8_0.storyCollectBtn_, nil, function()
		if ChapterTools.IsReadFirstEvent(arg_8_0.chapterID_) then
			JumpTools.OpenPageByJump("chapterPlot19StoryCollect", {
				chapterID = arg_8_0.chapterID_
			})
		else
			ShowTips("COLLECTION_STORY_AND_READ")
		end
	end)
end

function var_0_0.UpdateAll(arg_18_0, arg_18_1)
	arg_18_0:RefreshData()
	arg_18_0:ResetMapPosition()
	arg_18_0:RefreshUI(arg_18_1)

	if not arg_18_1 then
		arg_18_0:CheckNeedAutoBattle()
	end
end

function var_0_0.OnCloseDayPanel(arg_19_0)
	arg_19_0:RefreshSwitchBtn()
end

function var_0_0.RefreshData(arg_20_0)
	arg_20_0.chapterClientID_ = ChapterConst.CHAPTER_CLIENT_19
	arg_20_0.chapterID_ = ChapterClientCfg[arg_20_0.chapterClientID_].chapter_list[1]
	arg_20_0.selectDay_ = BattleFieldData:GetChapterMapDay(arg_20_0.chapterID_)
	arg_20_0.mapID_ = BattleFieldData:GetChapterMapID(arg_20_0.chapterID_, arg_20_0.selectDay_)
end

function var_0_0.CheckNeedAutoBattle(arg_21_0)
	local var_21_0 = GameSetting.chapter19_auto_battle_day_list.value

	if table.keyof(var_21_0, arg_21_0.selectDay_) then
		local var_21_1 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_21_0.chapterID_][arg_21_0.selectDay_][1]
		local var_21_2 = ChapterMapCfg[var_21_1].location_list[1]
		local var_21_3 = ChapterLocationCfg[var_21_2].stage_list[1]

		if var_21_3 and not ChapterTools.IsClearStage(var_21_3) and not BattleStageData:GetAutoBattleFlag(var_21_3) then
			if BattleChapterStageCfg[var_21_3].cost > ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) then
				return
			end

			BattleFieldData:SetChapterLocationID(arg_21_0.chapterID_, var_21_2)
			BattleStageData:SaveAutoBattleFlag(var_21_3)
			ChapterTools.DoReadyBattle(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, var_21_3)
		end
	end
end

function var_0_0.RefreshUI(arg_22_0, arg_22_1)
	arg_22_0:RefreshCollectStar()
	arg_22_0:RefreshMap(arg_22_1)
	arg_22_0:RefreshDay()
	arg_22_0:RefreshScanBtn()
	arg_22_0:RefreshCollectClue()
	arg_22_0:RefreshAudio()
end

function var_0_0.ResetMapPosition(arg_23_0)
	arg_23_0.mapView_:ResetMapPosition()
end

function var_0_0.RefreshCollectStar(arg_24_0)
	local var_24_0 = ChapterTools.GetChapterStarCnt(arg_24_0.chapterID_)
	local var_24_1 = ChapterTools.GetChapterTotalStarCnt(arg_24_0.chapterID_)

	arg_24_0.numText_.text = var_24_0
	arg_24_0.totalText_.text = string.format("/%s", var_24_1)
	arg_24_0.collectImage_.fillAmount = var_24_0 / var_24_1
end

function var_0_0.RefreshMap(arg_25_0, arg_25_1)
	arg_25_0.mapView_:SetMapID(arg_25_0.chapterID_, arg_25_0.mapID_, arg_25_1)
end

function var_0_0.RefreshDay(arg_26_0)
	arg_26_0.dayView_:SetData(arg_26_0.selectDay_, arg_26_0.chapterID_)
end

function var_0_0.RefreshScanBtn(arg_27_0)
	arg_27_0.hideScanController_:SetSelectedState(tostring(not ChapterTools.HasClueLocation(arg_27_0.mapID_)))
	arg_27_0.showScanEffectController_:SetSelectedState(tostring(ChapterTools.HasUnscanClue(arg_27_0.mapID_)))
end

function var_0_0.RefreshSwitchBtn(arg_28_0)
	local var_28_0 = ChapterMapCfg.get_id_list_by_chapter_id[arg_28_0.chapterID_][1]
	local var_28_1 = ChapterMapCfg[var_28_0].day

	if arg_28_0.selectDay_ == var_28_1 and not ChapterTools.IsNeedOperateFirstDayWatch(arg_28_0.chapterID_, arg_28_0.selectDay_) or ChapterTools.IsLastDay(arg_28_0.chapterID_, arg_28_0.selectDay_) then
		if arg_28_0.isHideWatch_ ~= true then
			arg_28_0.watchAnimator_:Play("View_out", 0, 1)

			arg_28_0.isHideWatch_ = true
		end
	else
		if arg_28_0.isHideWatch_ then
			arg_28_0.watchAnimator_:Play("dayList_enter", 0, 0)

			arg_28_0.isHideWatch_ = false
		end

		if ChapterTools.IsNeedOperateFirstDayWatch(arg_28_0.chapterID_, arg_28_0.selectDay_) then
			arg_28_0.watchController_:SetSelectedState("lock")
		elseif ChapterTools.IsNeedOperateLastDayWatch(arg_28_0.chapterID_, arg_28_0.selectDay_) then
			arg_28_0.watchController_:SetSelectedState("exitSpecialSpace")
		elseif table.keyof(ChapterMapCfg.get_id_list_by_chapter_id_day[arg_28_0.chapterID_][arg_28_0.selectDay_], arg_28_0.mapID_) == 1 then
			arg_28_0.watchController_:SetSelectedState("innerSpace")

			arg_28_0.watchText_.text = GetTips("SURFACE_SPACE")
		else
			arg_28_0.watchController_:SetSelectedState("outwardSpace")

			if arg_28_0.selectDay_ == 4 then
				arg_28_0.watchText_.text = "???"
			else
				arg_28_0.watchText_.text = GetTips("INNER_SPACE")
			end
		end
	end

	if ChapterTools.NeedShowSwitchMapGuild(arg_28_0.chapterID_, arg_28_0.selectDay_, arg_28_0.mapID_) then
		arg_28_0.watchGuildAnimator_:Play("map_unlock2", 0, 0)
	else
		arg_28_0.watchGuildAnimator_:Play("empty", 0, 0)
	end
end

function var_0_0.RefreshCollectClue(arg_29_0)
	local var_29_0, var_29_1 = ChapterTools.GetChapterClueCnt(arg_29_0.chapterID_)

	arg_29_0.clueCntText_.text = string.format("%s/%s", var_29_0, var_29_1)
end

function var_0_0.ScanAnimator(arg_30_0, arg_30_1)
	arg_30_0:StopScan()
	arg_30_0.scanAnimator_:Play("scan", 0, 0)

	arg_30_0.scanTimer_ = FrameTimer.New(function()
		if arg_30_0.scanAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			arg_30_1()
			arg_30_0:StopScan()
		end
	end, 1, -1)

	arg_30_0.scanTimer_:Start()
end

function var_0_0.StopScan(arg_32_0)
	if arg_32_0.scanTimer_ then
		arg_32_0.scanTimer_:Stop()

		arg_32_0.scanTimer_ = nil
	end
end

function var_0_0.AddArrowTimer(arg_33_0)
	arg_33_0.arrowTimer_ = FrameTimer.New(function()
		arg_33_0:ShowArrow()
	end, 1, -1)

	arg_33_0.arrowTimer_:Start()
end

function var_0_0.StopArrowTimer(arg_35_0)
	if arg_35_0.arrowTimer_ then
		arg_35_0.arrowTimer_:Stop()

		arg_35_0.arrowTimer_ = nil
	end
end

function var_0_0.ShowArrow(arg_36_0)
	local var_36_0 = ChapterTools.GetUnclearMainStageLocationID(arg_36_0.mapID_)

	if var_36_0 then
		local var_36_1 = arg_36_0.contentTf_.localPosition
		local var_36_2 = ChapterLocationCfg[var_36_0]
		local var_36_3 = Vector3(var_36_2.position[1], var_36_2.position[2], 0) + var_36_1
		local var_36_4 = arg_36_0.viewPortTf_.rect.width / 2
		local var_36_5 = arg_36_0.viewPortTf_.rect.height / 2
		local var_36_6 = var_36_4 - 200
		local var_36_7 = var_36_5 - 200

		if var_36_4 < math.abs(var_36_3.x) or var_36_5 < math.abs(var_36_3.y) then
			SetActive(arg_36_0.arrowGo_, true)

			local var_36_8 = MathTools.GetAngle(Vector3(0, 0, 0), var_36_3) + 180

			arg_36_0.arrowTf_.localEulerAngles = Vector3(0, 0, var_36_8)

			local var_36_9 = (var_36_8 + 180) % 360 - 180
			local var_36_10 = var_36_6
			local var_36_11 = var_36_10 * math.tan(var_36_9 / 180 * math.pi)

			if var_36_9 > -90 and var_36_9 < 90 then
				var_36_10 = -var_36_6
				var_36_11 = var_36_10 * math.tan(var_36_9 / 180 * math.pi)
			end

			if var_36_7 < math.abs(var_36_11) then
				if var_36_9 > -180 and var_36_9 < 0 then
					var_36_11 = var_36_7
					var_36_10 = var_36_11 / math.tan(var_36_9 / 180 * math.pi)
				else
					var_36_11 = -var_36_7
					var_36_10 = var_36_11 / math.tan(var_36_9 / 180 * math.pi)
				end
			end

			arg_36_0.arrowTf_.localPosition = Vector3(var_36_10, var_36_11, 0)
		else
			SetActive(arg_36_0.arrowGo_, false)
		end
	else
		SetActive(arg_36_0.arrowGo_, false)
	end
end

function var_0_0.RefreshAudio(arg_37_0)
	local var_37_0 = ChapterTools.GetChapterAudioIDList(arg_37_0.mapID_)
	local var_37_1 = var_37_0[#var_37_0]

	if arg_37_0.lastAudioID_ == var_37_1 then
		return
	end

	for iter_37_0, iter_37_1 in ipairs(var_37_0) do
		local var_37_2 = ChapterAudioCfg[iter_37_1]

		manager.audio:PlayUIAudio(var_37_2.bgm_id)
	end

	local var_37_3 = ChapterAudioCfg[var_37_1]

	arg_37_0.bgmNameText_.text = var_37_3.name
	arg_37_0.lastAudioID_ = var_37_1
end

function var_0_0.Dispose(arg_38_0)
	arg_38_0.updateAllHandler_ = nil
	arg_38_0.OnCloseDayPanelHandler_ = nil

	arg_38_0.mapView_:Dispose()

	arg_38_0.mapView_ = nil

	arg_38_0.dayView_:Dispose()

	arg_38_0.dayView_ = nil

	var_0_0.super.Dispose(arg_38_0)
end

return var_0_0
