local var_0_0 = class("ActivityFactoryStoryChapterItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.chapterID_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
end

function var_0_0.OnEnter(arg_2_0, arg_2_1)
	local var_2_0 = ChapterCfg[arg_2_0.chapterID_].section_id_list[1]

	arg_2_0.isLock_ = BattleStageData:GetStageData()[var_2_0] == nil

	arg_2_0:RefreshBtn(arg_2_1)

	local var_2_1 = ChapterCfg[arg_2_0.chapterID_].activity_id

	manager.redPoint:bindUIandKey(arg_2_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_2_0.chapterID_))
end

function var_0_0.OnExit(arg_3_0)
	local var_3_0 = ChapterCfg[arg_3_0.chapterID_].activity_id

	manager.redPoint:unbindUIandKey(arg_3_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_3_0.chapterID_))
end

function var_0_0.OnUpdate(arg_4_0, arg_4_1)
	arg_4_0:RefreshBtn(arg_4_1)
end

function var_0_0.RefreshBtn(arg_5_0, arg_5_1)
	if arg_5_0.chapterID_ == arg_5_1 then
		arg_5_0.selectController_:SetSelectedState("true")
		BattleStageAction.ClickSubPlot(arg_5_0.chapterID_)
	else
		arg_5_0.selectController_:SetSelectedState("false")
	end

	if arg_5_0.isLock_ then
		arg_5_0.controller_:SetSelectedState("false")
	else
		arg_5_0.controller_:SetSelectedState("true")
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.button_, nil, function()
		if arg_7_0.isLock_ then
			local var_8_0 = ChapterCfg[arg_7_0.chapterID_].activity_id
			local var_8_1 = ActivityData:GetActivityRefreshTime(var_8_0)

			if var_8_1 > manager.time:GetServerTime() then
				local var_8_2 = GetTips("OPEN_TIME")

				ShowTips(string.format(var_8_2, manager.time:GetLostTimeStr(var_8_1)))

				return
			end

			for iter_8_0, iter_8_1 in ipairs(ChapterCfg[arg_7_0.chapterID_].pre_chapter) do
				local var_8_3 = ChapterCfg[iter_8_1].section_id_list[#ChapterCfg[iter_8_1].section_id_list]
				local var_8_4 = BattleStageData:GetStageData()[var_8_3]

				if var_8_4 and var_8_4.clear_times > 0 then
					-- block empty
				else
					local var_8_5 = ChapterCfg[iter_8_1].subhead

					ShowTips(string.format(GetTips("NOTE_TASK_UNLOCK"), var_8_5))

					return
				end
			end
		else
			local var_8_6 = getChapterClientCfgByChapterID(arg_7_0.chapterID_)
			local var_8_7 = BattleFieldData:GetCacheStage(arg_7_0.chapterID_) or ChapterCfg[arg_7_0.chapterID_].section_id_list[1]

			BattleFieldData:SetStageByClientID(var_8_6.id, var_8_7)
			BattleFieldData:SetCacheChapterClient(getChapterToggle(var_8_6.id), var_8_6.id)
			BattleFieldData:SetSecondCacheChapter(getChapterToggle(var_8_6.id), arg_7_0.chapterID_, var_8_6.id)
			BattleStageAction.ClickSubPlot(arg_7_0.chapterID_)
			JumpTools.Jump2SubPlot(var_8_6.id, true)
		end
	end)
end

return var_0_0
