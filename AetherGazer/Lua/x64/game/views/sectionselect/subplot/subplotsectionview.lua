local var_0_0 = class("SubPlotSectionView", import("..SectionBaseView"))

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0.changeChapterHandler_ = handler(arg_1_0, arg_1_0.ChangeChapter)
	arg_1_0.stopMoveHandler_ = handler(arg_1_0, arg_1_0.StopMove)
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)
	manager.notify:RegistListener(CHANGE_CHAPTER, arg_2_0.changeChapterHandler_)
	manager.notify:RegistListener(CHAPTER_SCROLL_STOP, arg_2_0.stopMoveHandler_)
	BattleStageAction.ClickSubPlot(arg_2_0.chapterID_)
end

function var_0_0.OnExit(arg_3_0)
	manager.notify:RemoveListener(CHAPTER_SCROLL_STOP, arg_3_0.stopMoveHandler_)
	var_0_0.super.OnExit(arg_3_0)
	manager.notify:RemoveListener(CHANGE_CHAPTER, arg_3_0.changeChapterHandler_)
end

function var_0_0.ChangeChapter(arg_4_0, arg_4_1)
	local var_4_0 = getChapterClientCfgByChapterID(arg_4_1)
	local var_4_1 = BattleFieldData:GetCacheStage(arg_4_1) or ChapterCfg[arg_4_1].section_id_list[1]

	if arg_4_0.params_.section == var_4_1 and var_4_1 then
		return
	end

	arg_4_0.params_.chapterID = arg_4_1
	arg_4_0.params_.section = var_4_1

	BattleFieldData:SetStageByClientID(var_4_0.id, var_4_1)
	BattleFieldData:SetCacheChapterClient(getChapterToggle(var_4_0.id), var_4_0.id)
	BattleFieldAction.ChangeSelectChapterID(arg_4_1)
	JumpTools.Jump2SubPlot(var_4_0.id, true)
end

function var_0_0.RefreshData(arg_5_0)
	var_0_0.super.RefreshData(arg_5_0)
end

function var_0_0.RefreshUI(arg_6_0)
	var_0_0.super.RefreshUI(arg_6_0)
	arg_6_0:SwitchBG()
	arg_6_0:RefreshText()
end

function var_0_0.StopMove(arg_7_0)
	arg_7_0.stopMove_ = true
end

function var_0_0.RefreshText(arg_8_0)
	SetActive(arg_8_0.titleGo_, true)

	local var_8_0 = arg_8_0.chapterID_
	local var_8_1 = ChapterCfg[var_8_0]

	arg_8_0.chapterNameText_.text = var_8_1.subhead
end

function var_0_0.GetSectionItemClass(arg_9_0)
	return SubPlotSectionItem
end

function var_0_0.IsOpenSectionInfo(arg_10_0)
	return arg_10_0:IsOpenRoute("subPlotSectionInfo")
end

function var_0_0.GetCfgName(arg_11_0)
	return BattleActivityStoryStageCfg
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.stopMoveHandler_ = nil
	arg_12_0.changeChapterHandler_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
