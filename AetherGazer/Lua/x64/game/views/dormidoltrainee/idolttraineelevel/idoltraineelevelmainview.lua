local var_0_0 = class("IdolTraineeLevelMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleLevelView"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.curChapterID_ = 0
	arg_4_0.levelList_ = {}
	arg_4_0.chapterTitleItem_ = IdolTraineeChapterListItem.New(arg_4_0.chapter)
	arg_4_0.levelUIList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.levelUIList_, IdolTraineeLevelListItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		if arg_5_0.curChapterID_ then
			JumpTools.OpenPageByJump("/idolTraineeChapterRewardView", {
				chapterID = arg_5_0.curChapterID_
			})
		end
	end)
end

function var_0_0.OnEnter(arg_7_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_7_0.curChapterID_ = arg_7_0.params_.chapterID
	arg_7_0.levelList_ = IdolTraineeChapterCfg[arg_7_0.curChapterID_].section_id_list

	arg_7_0.chapterTitleItem_:SetData(arg_7_0.curChapterID_, true)
	arg_7_0.levelUIList_:StartScroll(#arg_7_0.levelList_)

	arg_7_0.titleText_.text = IdolTraineeChapterCfg[arg_7_0.curChapterID_].title

	manager.redPoint:bindUIandKey(arg_7_0.redpointTrs_, string.format("%s_%s", RedPointConst.IDOL_TRAINEE_CHAPTER_TASK, arg_7_0.curChapterID_))
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_8_0.redpointTrs_, string.format("%s_%s", RedPointConst.IDOL_TRAINEE_CHAPTER_TASK, arg_8_0.curChapterID_))
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_0.levelList_[arg_9_1], arg_9_1, arg_9_0.curChapterID_)
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.chapterTitleItem_ then
		arg_10_0.chapterTitleItem_:Dispose()

		arg_10_0.chapterTitleItem_ = nil
	end

	arg_10_0.levelUIList_:Dispose()

	arg_10_0.levelUIList_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
