local var_0_0 = class("HodurHomeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Hodur/Activity_Hodur_HomeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.mainlineItemList_ = {}

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	for iter_4_0, iter_4_1 in ipairs(ActivityHodurChapterCfg.get_id_list_by_chapter_type[HodurConst.CHAPTER_TYPE.MAINLINE]) do
		arg_4_0.mainlineItemList_[iter_4_0] = HodurChapterItem.New(arg_4_0["mainlineGo_" .. iter_4_0])
	end

	arg_4_0.challengeItem_ = HodurChapterChallengeItem.New(arg_4_0.challengeGo_)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		LimitTimeTaskTools.JumpToLimitTimeTaskView(ActivityConst.ACTIVITY_HODUR_LIMITED_TASK)
	end)
	arg_5_0:AddBtnListener(arg_5_0.pointBtn_, nil, function()
		JumpTools.OpenPageByJump("/hodurTaskView")
	end)
end

function var_0_0.OnEnter(arg_8_0)
	if not getData("activity_hodur", "first_enter") then
		saveData("activity_hodur", "first_enter", true)

		arg_8_0.mainTimeline_.enabled = false
		arg_8_0.bgTimeline_.enabled = true
	else
		arg_8_0.mainTimeline_.enabled = true
		arg_8_0.bgTimeline_.enabled = false
	end

	arg_8_0:RefreshUI()
	arg_8_0:RefreshLimitTime()
	arg_8_0:BindRedPoint()
	HodurSystemData:UpdateTaskRedPoint()
end

function var_0_0.BindRedPoint(arg_9_0)
	manager.redPoint:bindUIandKey(arg_9_0.rewardRedRoot_.transform, RedPointConst.HODUR_ACTIVITY_LIMIT_TASK .. ActivityConst.ACTIVITY_HODUR_LIMITED_TASK)
	manager.redPoint:bindUIandKey(arg_9_0.pointBtnTrs_, RedPointConst.HODUR_ACTIVITY_RESIDENT_TASK .. ActivityConst.ACTIVITY_HODUR_MAIN)
end

function var_0_0.UnbindRedPoint(arg_10_0)
	manager.redPoint:unbindUIandKey(arg_10_0.rewardRedRoot_.transform, RedPointConst.HODUR_ACTIVITY_LIMIT_TASK .. ActivityConst.ACTIVITY_HODUR_LIMITED_TASK)
	manager.redPoint:unbindUIandKey(arg_10_0.pointBtnTrs_, RedPointConst.HODUR_ACTIVITY_RESIDENT_TASK .. ActivityConst.ACTIVITY_HODUR_MAIN)
end

function var_0_0.RefreshLimitTime(arg_11_0)
	local var_11_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_HODUR_LIMITED_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_HODUR_LIMITED_TASK) then
		SetActive(arg_11_0.rewardRedRoot_.gameObject, true)

		arg_11_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_11_0.stopTime)
	else
		SetActive(arg_11_0.rewardRedRoot_.gameObject, false)
	end

	arg_11_0:LimitStopTimer()

	if arg_11_0.limittimer_ == nil then
		arg_11_0.limittimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_HODUR_LIMITED_TASK) then
				arg_11_0.limitTimeTxt_.text = manager.time:GetLostTimeStr2(var_11_0.stopTime)
			elseif manager.time:GetServerTime() < var_11_0.startTime then
				arg_11_0.limitTimeTxt_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStr2(var_11_0.startTime))
			elseif manager.time:GetServerTime() > var_11_0.stopTime then
				arg_11_0.limitTimeTxt_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)
	end

	arg_11_0.limittimer_:Start()
end

function var_0_0.RefreshUI(arg_13_0)
	SetActive(arg_13_0.unlockGo_, false)

	for iter_13_0, iter_13_1 in ipairs(ActivityHodurChapterCfg.get_id_list_by_chapter_type[HodurConst.CHAPTER_TYPE.MAINLINE]) do
		arg_13_0.mainlineItemList_[iter_13_0]:SetData(iter_13_1)

		if iter_13_0 ~= 1 and HodurTools.GetChapterState(iter_13_1) == HodurConst.COMMON_STATE.UNLOCK and not getData("activity_hodur", "chapter_unlock" .. iter_13_1) then
			saveData("activity_hodur", "chapter_unlock" .. iter_13_1, true)
			arg_13_0.mainlineItemList_[iter_13_0]:SetUnlockMode()
			SetActive(arg_13_0.unlockGo_, true)

			arg_13_0.aniTimer_ = Timer.New(function()
				if arg_13_0.unlockAni_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1.1 then
					SetActive(arg_13_0.unlockGo_, false)
					manager.audio:PlayEffect("minigame_activity_4_7", "minigame_activity_4_7_hodur_lock01", "")
					arg_13_0.mainlineItemList_[iter_13_0]:PlayUnlockAnim()
					manager.ui:UIEventEnabled(true)

					if arg_13_0.aniTimer_ then
						arg_13_0.aniTimer_:Stop()

						arg_13_0.aniTimer_ = nil
					end
				end
			end, 0.033, -1)

			arg_13_0.aniTimer_:Start()
			manager.ui:UIEventEnabled(false)
		else
			Timer.New(function()
				arg_13_0.mainlineItemList_[iter_13_0]:RefreshUI()
			end, 0, 1):Start()
		end
	end

	arg_13_0.challengeItem_:SetData(ActivityHodurChapterCfg.get_id_list_by_chapter_type[HodurConst.CHAPTER_TYPE.CHALLENGE][1])

	if HodurTools.GetChapterState(4) == HodurConst.COMMON_STATE.UNLOCK and not getData("activity_hodur", "chapter_unlock" .. 4) then
		saveData("activity_hodur", "chapter_unlock" .. 4, true)
		arg_13_0.challengeItem_:SetUnlockMode()
		SetActive(arg_13_0.unlockGo_, true)

		arg_13_0.aniTimer_ = Timer.New(function()
			if arg_13_0.unlockAni_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1.1 then
				SetActive(arg_13_0.unlockGo_, false)
				arg_13_0.challengeItem_:PlayUnlockAnim()
				manager.ui:UIEventEnabled(true)

				if arg_13_0.aniTimer_ then
					arg_13_0.aniTimer_:Stop()

					arg_13_0.aniTimer_ = nil
				end
			end
		end, 0.033, -1)

		arg_13_0.aniTimer_:Start()
		manager.ui:UIEventEnabled(false)
		manager.audio:PlayEffect("minigame_activity_4_7", "minigame_activity_4_7_hodur_lock01", "")
	else
		Timer.New(function()
			arg_13_0.challengeItem_:RefreshUI()
		end, 0, 1):Start()
	end

	local var_13_0 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_HODUR_MAIN]
	local var_13_1 = TaskTools.GetTaskNumInfo(ActivityConst.ACTIVITY_HODUR_MAIN)
	local var_13_2 = #var_13_0

	arg_13_0.taskProgressText_.text = var_13_1 .. "/" .. var_13_2

	arg_13_0:RefreshChapter()
end

function var_0_0.RefreshChapter(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.mainlineItemList_) do
		iter_18_1:RefreshUI()
	end

	arg_18_0.challengeItem_:RefreshUI()
end

function var_0_0.OnTop(arg_19_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnBehind(arg_20_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_21_0)
	arg_21_0:UnbindRedPoint()
	arg_21_0:LimitStopTimer()

	if arg_21_0.aniTimer_ then
		arg_21_0.aniTimer_:Stop()

		arg_21_0.aniTimer_ = nil
	end
end

function var_0_0.LimitStopTimer(arg_22_0)
	if arg_22_0.limittimer_ then
		arg_22_0.limittimer_:Stop()

		arg_22_0.limittimer_ = nil
	end
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0:LimitStopTimer()

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.mainlineItemList_) do
		iter_23_1:Dispose()
	end

	arg_23_0.challengeItem_:Dispose()
	var_0_0.super.Dispose(arg_23_0)
	arg_23_0:RemoveAllListeners()
end

return var_0_0
