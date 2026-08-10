local var_0_0 = class("DailyView", import("..SectionBaseView"))

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0.switchChapterView_ = SubPlotSwitchChapterView.New(arg_1_0.chooseGo_, arg_1_0.extraStoryBtn_)
	arg_1_0.changeChapterHandler_ = handler(arg_1_0, arg_1_0.SwitchDailyChapter)
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)
	arg_2_0.switchChapterView_:OnEnter()
	manager.notify:RegistListener(CHANGE_CHAPTER, arg_2_0.changeChapterHandler_)
end

function var_0_0.OnExit(arg_3_0)
	var_0_0.super.OnExit(arg_3_0)
	arg_3_0.switchChapterView_:OnExit()
	manager.notify:RemoveListener(CHANGE_CHAPTER, arg_3_0.changeChapterHandler_)

	local var_3_0 = arg_3_0:GetStayTime()

	OperationRecorder.RecordStayView("STAY_VIEW_SECTION", var_3_0, arg_3_0.chapterID_)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	arg_4_0.changeChapterHandler_ = nil

	arg_4_0.switchChapterView_:Dispose()

	arg_4_0.switchChapterView_ = nil
end

function var_0_0.IsOpenSectionInfo(arg_5_0)
	return arg_5_0:IsOpenRoute("dailySectionInfo")
end

function var_0_0.GetSectionItemClass(arg_6_0)
	return DailyItem
end

function var_0_0.RefreshCustomData(arg_7_0)
	arg_7_0.switchChapterView_:SetData(arg_7_0.chapterID_)
end

function var_0_0.RefreshUI(arg_8_0)
	var_0_0.super.RefreshUI(arg_8_0)

	local var_8_0 = getChapterClientCfgByChapterID(arg_8_0.chapterID_).chapter_list
	local var_8_1 = #var_8_0 > 1

	if not arg_8_0:IsOpenSectionInfo() and not arg_8_0:IsOpenRoute("chapterSectionReward") and var_8_1 then
		SetActive(arg_8_0.chooseGo_, true)
	else
		SetActive(arg_8_0.chooseGo_, false)
	end

	if var_8_1 then
		arg_8_0:RefreshChapterItemBtn()

		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			if arg_8_0.chapterItem_[iter_8_0] then
				arg_8_0.chapterItem_[iter_8_0]:SetData(iter_8_1)
			else
				arg_8_0.chapterItem_[iter_8_0] = DailyChapterItemBtn.New(arg_8_0, arg_8_0.selectResourceItem_, arg_8_0.selectResourcePanel_, iter_8_1)
			end
		end
	end

	arg_8_0.switchChapterView_:RefreshUI()
	arg_8_0:SwitchBG()
end

function var_0_0.GetCfgName(arg_9_0)
	return BattleDailyStageCfg
end

function var_0_0.RefreshChapterItemBtn(arg_10_0)
	arg_10_0.selectResourceText_.text = GetI18NText(ChapterCfg[arg_10_0.chapterID_].subhead)
end

function var_0_0.SwitchDailyChapter(arg_11_0, arg_11_1)
	local var_11_0 = getChapterClientCfgByChapterID(arg_11_1)
	local var_11_1 = BattleFieldData:GetCacheStage(arg_11_1) or GetI18NText(ChapterCfg[arg_11_1].section_id_list[1])

	if arg_11_0.params_.section == var_11_1 then
		return
	end

	arg_11_0.params_.chapterID = arg_11_1
	arg_11_0.params_.section = var_11_1

	BattleFieldData:SetStageByClientID(var_11_0.id, var_11_1)
	BattleFieldData:SetCacheChapterClient(getChapterToggle(var_11_0.id), var_11_0.id)
	arg_11_0:RefreshData(arg_11_1)
	var_0_0.super.RefreshUI(arg_11_0)
	arg_11_0:RefreshChapterItemBtn()
end

return var_0_0
