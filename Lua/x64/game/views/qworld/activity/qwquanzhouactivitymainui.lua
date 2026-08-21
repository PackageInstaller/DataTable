ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("QWActivityMainUI", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/Version/V4_0_1_QuanZhouUI_Com/QuanZhou_MainUI/QuanZhou_MainUI"
end

function var_0_0.isHasLeftTimeDes(arg_2_0)
	return true
end

function var_0_0.OnEnter(arg_3_0)
	var_0_0.super.OnEnter(arg_3_0)
	arg_3_0:AddEventListeners()
	arg_3_0:UpdatePreview()
	arg_3_0:RefreshUI()

	arg_3_0.rewardBtnActive_ = true

	manager.redPoint:bindUIandKey(arg_3_0.m_entrustBtn.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_3_0.activityID_), arg_3_0.activityID_))
	manager.redPoint:bindUIandKey(arg_3_0.btnReward_.transform, RedPointConst.QUANZHOU_LIMIT_TASK_ALL)
end

function var_0_0.OnExit(arg_4_0)
	var_0_0.super.OnExit(arg_4_0)
	arg_4_0:StopAwardTimer()
	arg_4_0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(arg_4_0.m_entrustBtn.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_4_0.activityID_), arg_4_0.activityID_))
	manager.redPoint:unbindUIandKey(arg_4_0.btnReward_.transform, RedPointConst.QUANZHOU_LIMIT_TASK_ALL)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_entrustBtn, nil, function()
		arg_5_0:EnterQWorld()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnReward_, nil, function()
		JumpTools.OpenPageByJump("/quanZhouLimitTimeTaskView", {
			activityID = ActivityConst.ACTIVITY_QUANZHOU_TASK
		})
	end)
	arg_5_0:BindHelpBtn("QUANZHOU_DESC")
end

function var_0_0.AddEventListeners(arg_8_0)
	arg_8_0:RegistEventListener(ACTIVITY_RED_ENVELOPE_NEW_DAY, function()
		arg_8_0:RefreshUI()
	end)
end

function var_0_0.UpdateBar(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.RefreshUI(arg_11_0)
	arg_11_0.entrustBtnTxt_.text = GetTips("BATTLE_READY_2")

	arg_11_0:AwardRemainTime()
end

function var_0_0.AwardRemainTime(arg_12_0)
	local var_12_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_QUANZHOU_TASK)

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_QUANZHOU_TASK) then
		arg_12_0.remainTime_.text = manager.time:GetLostTimeStr2(var_12_0.stopTime)
	else
		if manager.time:GetServerTime() < var_12_0.startTime then
			arg_12_0.remainTime_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_12_0.startTime))
		elseif manager.time:GetServerTime() > var_12_0.stopTime then
			arg_12_0.remainTime_.text = GetTips("TIME_OVER")
		end

		if arg_12_0.rewardBtnActive_ then
			SetActive(arg_12_0.btnReward_.gameObject, false)

			arg_12_0.rewardBtnActive_ = false
		end
	end

	arg_12_0:StopAwardTimer()

	if arg_12_0.awardTimer_ == nil then
		arg_12_0.awardTimer_ = Timer.New(function()
			if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_QUANZHOU_TASK) then
				arg_12_0.remainTime_.text = manager.time:GetLostTimeStr2(var_12_0.stopTime)
			else
				if manager.time:GetServerTime() < var_12_0.startTime then
					arg_12_0.remainTime_.text = string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_12_0.startTime))
				elseif manager.time:GetServerTime() > var_12_0.stopTime then
					arg_12_0.remainTime_.text = GetTips("TIME_OVER")
				end

				if arg_12_0.rewardBtnActive_ then
					SetActive(arg_12_0.btnReward_.gameObject, false)

					arg_12_0.rewardBtnActive_ = false
				end
			end
		end, 1, -1)
	end

	arg_12_0.awardTimer_:Start()

	arg_12_0.taskAnimator_.enabled = false

	local var_12_1 = ActivityCfg[ActivityConst.ACTIVITY_QUANZHOU_TASK].sub_activity_list

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_2 = TaskTools:GetActivityTaskList(iter_12_1) or {}

		for iter_12_2, iter_12_3 in pairs(var_12_2) do
			if iter_12_3.progress >= AssignmentCfg[iter_12_3.id].need and iter_12_3.complete_flag < 1 then
				arg_12_0.taskAnimator_.enabled = true

				break
			end
		end
	end
end

function var_0_0.StopAwardTimer(arg_14_0)
	if arg_14_0.awardTimer_ then
		arg_14_0.awardTimer_:Stop()

		arg_14_0.awardTimer_ = nil
	end
end

function var_0_0.EnterQWorld(arg_15_0)
	local var_15_0 = QWorldMgr:GetActivityMap(arg_15_0.activityID_)
	local var_15_1 = SandPlayMapCfg[var_15_0]
	local var_15_2 = var_15_1 and var_15_1.story_id

	if not var_15_2 or var_15_2 == 0 or manager.story:IsStoryPlayed(var_15_2) then
		LaunchQWorld(false, arg_15_0.activityID_)
	else
		manager.story:StartStoryById(var_15_2, function()
			LaunchQWorld(false, arg_15_0.activityID_)
		end)
	end
end

return var_0_0
