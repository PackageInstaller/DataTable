local var_0_0 = import("game.views.osiris.storyStage.section.OsirisStoryStageView")
local var_0_1 = class("OsirisStoryStageRemasteredView", var_0_0)

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "active")

	arg_1_0.controller_:SetSelectedState("off")

	arg_1_0.switchChapterView_ = SubPlotSwitchChapterView.New(arg_1_0.chooseGo_, arg_1_0.extraStoryBtn_)
	arg_1_0.extraStoryView_ = SubPlotExtraStoryBtn.New(arg_1_0.extraStoryGo_)
end

function var_0_1.OnEnter(arg_2_0)
	var_0_1.super.OnEnter(arg_2_0)
	arg_2_0.switchChapterView_:OnEnter()
	arg_2_0.extraStoryView_:OnEnter()
end

function var_0_1.OnExit(arg_3_0)
	var_0_1.super.OnExit(arg_3_0)
	arg_3_0.switchChapterView_:OnExit()
	arg_3_0.extraStoryView_:OnExit()
end

function var_0_1.Dispose(arg_4_0)
	arg_4_0.switchChapterView_:Dispose()

	arg_4_0.switchChapterView_ = nil

	arg_4_0.extraStoryView_:Dispose()

	arg_4_0.extraStoryView_ = nil

	var_0_1.super.Dispose(arg_4_0)
end

function var_0_1.RefreshData(arg_5_0)
	if arg_5_0.params_.chapterID == nil then
		local var_5_0 = arg_5_0.params_.chapterClientID

		arg_5_0.chapterID_ = BattleFieldData:GetCacheChapter(var_5_0)
	else
		arg_5_0.chapterID_ = arg_5_0.params_.chapterID
	end

	arg_5_0.stageData_ = BattleStageData:GetStageData()
	arg_5_0.stageList_ = ChapterCfg[arg_5_0.chapterID_].section_id_list

	arg_5_0.switchChapterView_:SetData(arg_5_0.chapterID_)
	arg_5_0.extraStoryView_:SetData(arg_5_0.chapterID_)
end

function var_0_1.RefreshUI(arg_6_0)
	arg_6_0:RefreshMissionList()

	local var_6_0 = arg_6_0.chapterID_

	arg_6_0.selectSection_ = BattleFieldData:GetCacheStage(var_6_0) or ChapterCfg[var_6_0].section_id_list[1]

	local var_6_1 = arg_6_0:GetScrollPos()
	local var_6_2 = arg_6_0:GetScrollWidth()

	arg_6_0.scrollMoveView_:RefreshUI(var_6_1, var_6_2)
	arg_6_0:RefreshSelectItem()
	arg_6_0.switchChapterView_:RefreshUI()
end

function var_0_1.GetSectionItemClass(arg_7_0)
	return OsirisStoryStageRemasteredItem
end

function var_0_1.IsOpenSectionInfo(arg_8_0)
	return arg_8_0:IsOpenRoute("subPlotSectionInfo")
end

return var_0_1
