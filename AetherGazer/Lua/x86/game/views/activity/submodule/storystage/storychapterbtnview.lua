local var_0_0 = class("StoryChapterBtnView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.chapterID_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
end

function var_0_0.OnEnter(arg_2_0, arg_2_1)
	arg_2_0.isLock_ = table.length(StoryStageActivityData:GetStageData(arg_2_0.chapterID_)) <= 0

	arg_2_0:RefreshBtn(arg_2_1)
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:StopTimer()
end

function var_0_0.OnUpdate(arg_4_0, arg_4_1)
	arg_4_0:RefreshBtn(arg_4_1)
end

function var_0_0.RefreshBtn(arg_5_0, arg_5_1)
	if arg_5_0.chapterID_ == arg_5_1 then
		arg_5_0.controller_:SetSelectedState("value_2")
		StoryStageActivityData:SetUnlockState(arg_5_0.chapterID_)
	elseif arg_5_0.isLock_ then
		arg_5_0.controller_:SetSelectedState("false")
	else
		arg_5_0.controller_:SetSelectedState("true")

		if StoryStageActivityData:GetUnlockState(arg_5_0.chapterID_) then
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
			local var_8_0 = ActivityStoryChapterCfg[arg_7_0.chapterID_]
			local var_8_1 = ActivityStoryChapterCfg.get_id_list_by_activity_id[var_8_0.activity_id]
			local var_8_2 = table.keyof(var_8_1, arg_7_0.chapterID_) or 1

			if var_8_2 <= 1 then
				return
			end

			local var_8_3 = GetI18NText(ActivityStoryChapterCfg[var_8_1[var_8_2 - 1]].name)

			ShowTips(string.format(GetTips("NOTE_TASK_UNLOCK"), var_8_3))

			return
		else
			local var_8_4 = ActivityStoryChapterCfg[arg_7_0.chapterID_]

			StoryStageActivityData:SaveHistoryChapter(var_8_4.activity_id, arg_7_0.chapterID_)
			arg_7_0:Go("/storyStageActivity", {
				chapterID = arg_7_0.chapterID_,
				theme = ActivityCfg[var_8_4.activity_id].activity_theme
			})
		end
	end)
end

function var_0_0.AddTimer(arg_9_0)
	arg_9_0:StopTimer()

	local var_9_0 = arg_9_0.animator_:GetCurrentAnimatorStateInfo(0)

	arg_9_0.timer_ = Timer.New(function()
		if var_9_0.normalizedTime > 0.5 then
			StoryStageActivityData:SetUnlockState(arg_9_0.chapterID_)
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
