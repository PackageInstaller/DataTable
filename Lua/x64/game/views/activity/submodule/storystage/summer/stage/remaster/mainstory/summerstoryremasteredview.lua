local var_0_0 = import("game.views.activity.Submodule.storyStage.summer.stage.mainStory.SummerStageMainView")
local var_0_1 = class("SummerStoryRemasteredView", var_0_0)

function var_0_1.GetStageItemClass(arg_1_0)
	return SummerStoryRemasteredItem
end

function var_0_1.IsOpenSectionInfo(arg_2_0)
	return arg_2_0:IsOpenRoute("subPlotSectionInfo")
end

function var_0_1.Init(arg_3_0)
	var_0_1.super.Init(arg_3_0)

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.transform_, "active")

	arg_3_0.controller_:SetSelectedState("off")
end

function var_0_1.RefreshData(arg_4_0)
	if arg_4_0.params_.chapterID == nil then
		local var_4_0 = arg_4_0.params_.chapterClientID
		local var_4_1 = ChapterClientCfg[var_4_0]

		arg_4_0.chapterID_ = BattleFieldData:GetCacheChapter(var_4_1.id)
	else
		arg_4_0.chapterID_ = arg_4_0.params_.chapterID
	end

	arg_4_0.stageData_ = BattleStageData:GetStageData()
	arg_4_0.stageList_ = ChapterCfg[arg_4_0.chapterID_].section_id_list
end

function var_0_1.RefreshUI(arg_5_0)
	local var_5_0 = arg_5_0.chapterID_

	arg_5_0.selectStageID_ = BattleFieldData:GetCacheStage(var_5_0) or ChapterCfg[var_5_0].section_id_list[1]

	local var_5_1 = arg_5_0:GetScrollPos()
	local var_5_2 = arg_5_0:GetScrollWidth()

	arg_5_0.scrollMoveView_:RefreshUI(var_5_1, var_5_2)
	arg_5_0:RefreshSelectItem()
end

function var_0_1.RefreshStageList(arg_6_0)
	for iter_6_0 = 1, #arg_6_0.stageItem_ do
		arg_6_0.stageItem_[iter_6_0]:Show(false)
	end

	local var_6_0 = BattleStageData:GetStageData()

	for iter_6_1 = 1, #arg_6_0.stageList_ do
		if iter_6_1 == 1 or var_6_0[arg_6_0.stageList_[iter_6_1]] then
			if not arg_6_0.stageItem_[iter_6_1] then
				arg_6_0.stageItem_[iter_6_1] = arg_6_0:GetStageItemClass().New(arg_6_0.itemGo_, arg_6_0.content_)
			end

			arg_6_0.stageItem_[iter_6_1]:SetData(arg_6_0.stageList_[iter_6_1], arg_6_0.chapterID_)
		end
	end
end

return var_0_1
