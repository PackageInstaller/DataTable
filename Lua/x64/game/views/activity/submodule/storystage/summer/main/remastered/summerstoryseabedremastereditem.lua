local var_0_0 = class("SummerStorySeabedRemasterdItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.chapterID_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
end

function var_0_0.OnEnter(arg_2_0)
	local var_2_0 = ChapterCfg[arg_2_0.chapterID_]

	arg_2_0.unLockState_ = BattleStageData:GetStageData()[var_2_0.section_id_list[1]] ~= nil

	manager.redPoint:bindUIandKey(arg_2_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_2_0.chapterID_))
	arg_2_0:RefreshState()
end

function var_0_0.OnExit(arg_3_0)
	manager.redPoint:unbindUIandKey(arg_3_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_3_0.chapterID_))
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		if not arg_5_0.unLockState_ then
			ShowTips("ACTIVITY_FINISH_ALL_SUMMER_STORY")

			return
		end

		local var_6_0 = getChapterClientCfgByChapterID(arg_5_0.chapterID_)

		BattleFieldData:SetCacheChapterClient(getChapterToggle(var_6_0.id), var_6_0.id)
		BattleFieldData:SetCacheChapter(var_6_0.id, arg_5_0.chapterID_)
		BattleStageAction.ClickSubPlot(arg_5_0.chapterID_)
		arg_5_0:Go("/summerSeabedStoryRemastered", {
			chapterID = arg_5_0.chapterID_
		})
	end)
end

function var_0_0.RefreshState(arg_7_0)
	arg_7_0.timeText_.text = ""

	if arg_7_0.unLockState_ then
		arg_7_0.controller_:SetSelectedState("on")
	else
		arg_7_0.controller_:SetSelectedState("off")
	end
end

return var_0_0
