local var_0_0 = class("HellaStoryChapterBtnView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.chapterID_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
end

function var_0_0.OnEnter(arg_2_0, arg_2_1)
	local var_2_0 = ChapterCfg[arg_2_0.chapterID_].section_id_list[1]

	arg_2_0.isLock_ = BattleStageData:GetStageData()[var_2_0] == nil

	arg_2_0:RefreshBtn(arg_2_1)
	manager.redPoint:bindUIandKey(arg_2_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_2_0.chapterID_))
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:StopTimer()
	manager.redPoint:unbindUIandKey(arg_3_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_3_0.chapterID_))
end

function var_0_0.OnUpdate(arg_4_0, arg_4_1)
	arg_4_0:RefreshBtn(arg_4_1)
end

function var_0_0.RefreshBtn(arg_5_0, arg_5_1)
	if arg_5_0.chapterID_ == arg_5_1 then
		arg_5_0.controller_:SetSelectedState("value_2")
		StoryStageActivityData:SetUnlockState(arg_5_0.chapterID_ .. "re")
	elseif arg_5_0.isLock_ then
		arg_5_0.controller_:SetSelectedState("false")
	else
		arg_5_0.controller_:SetSelectedState("true")

		if StoryStageActivityData:GetUnlockState(arg_5_0.chapterID_ .. "re") then
			arg_5_0.animator_:Play("Ani_unselect", -1, 1)
		else
			arg_5_0:AddTimer()
		end
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.button_, nil, function()
		if arg_7_0.isLock_ then
			local var_8_0 = getChapterClientCfgByChapterID(arg_7_0.chapterID_)
			local var_8_1 = ChapterClientCfg[var_8_0.id].chapter_list
			local var_8_2 = table.keyof(var_8_1, arg_7_0.chapterID_) or 1

			if var_8_2 <= 1 then
				return
			end

			local var_8_3 = ChapterCfg[var_8_1[var_8_2 - 1]].subhead

			ShowTips(string.format(GetTips("NOTE_TASK_UNLOCK"), var_8_3))

			return
		else
			local var_8_4 = getChapterClientCfgByChapterID(arg_7_0.chapterID_)
			local var_8_5 = BattleFieldData:GetCacheStage(arg_7_0.chapterID_) or ChapterCfg[arg_7_0.chapterID_].section_id_list[1]

			BattleFieldData:SetStageByClientID(var_8_4.id, var_8_5)
			BattleFieldData:SetCacheChapterClient(getChapterToggle(var_8_4.id), var_8_4.id)
			BattleFieldData:SetSecondCacheChapter(getChapterToggle(var_8_4.id), arg_7_0.chapterID_, var_8_4.id)
			BattleStageAction.ClickSubPlot(arg_7_0.chapterID_)
			JumpTools.Jump2SubPlot(var_8_4.id, true)
		end
	end)
end

function var_0_0.AddTimer(arg_9_0)
	arg_9_0:StopTimer()

	local var_9_0 = arg_9_0.animator_:GetCurrentAnimatorStateInfo(0)

	arg_9_0.timer_ = Timer.New(function()
		if var_9_0.normalizedTime > 0.5 then
			StoryStageActivityData:SetUnlockState(arg_9_0.chapterID_ .. "re")
			arg_9_0:StopTimer()
		end
	end, 0.033, -1)

	arg_9_0.timer_:Start()
end

function var_0_0.StopTimer(arg_11_0)
	if arg_11_0.timer_ then
		arg_11_0.timer_:Stop()

		arg_11_0.timer_ = nil
	end
end

return var_0_0
