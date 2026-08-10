local var_0_0 = class("ActivityHeroLetterItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.lockCon_ = arg_3_0.conCollecter_:GetController("lock")
	arg_3_0.rewardCon_ = arg_3_0.conCollecter_:GetController("reward")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		manager.redPoint:setTip(RedPointConst.ACTIVITY_HERO_LETTER_UNCOMPLETE .. "_" .. arg_4_0.activityID_, 0)

		local var_5_0 = manager.time:GetServerTime()

		if var_5_0 >= arg_4_0.startTime_ and var_5_0 < arg_4_0.stopTime_ then
			JumpTools.OpenPageByJump("/activityHeroLetterTask", {
				id = arg_4_0.id_,
				activityID = arg_4_0.cfg_.main_activity_id
			})
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.Refresh(arg_7_0, arg_7_1)
	arg_7_0.id_ = arg_7_1
	arg_7_0.cfg_ = ActivityHeroTaskCfg[arg_7_0.id_]

	arg_7_0:RefreshData()
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshData(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.cfg_.activity_id
	arg_8_0.activityData_ = ActivityData:GetActivityData(arg_8_0.activityID_)
	arg_8_0.startTime_ = arg_8_0.activityData_.startTime
	arg_8_0.stopTime_ = arg_8_0.activityData_.stopTime
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = arg_9_0.cfg_.hero_id

	arg_9_0.name_.text = HeroCfg[var_9_0].suffix
	arg_9_0.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. var_9_0)

	if ActivityHeroLetterTools.IsReward(arg_9_0.id_) then
		arg_9_0.rewardCon_:SetSelectedState("on")
	else
		arg_9_0.taskID_ = arg_9_0.cfg_.task_id

		local var_9_1 = AssignmentCfg[arg_9_0.taskID_]
		local var_9_2 = TaskData2:GetTask(arg_9_0.taskID_)
		local var_9_3 = var_9_1.need

		if var_9_2 and var_9_3 <= var_9_2.progress then
			arg_9_0.rewardCon_:SetSelectedState("off")
		else
			arg_9_0.rewardCon_:SetSelectedState("none")
		end
	end

	local var_9_4 = manager.redPoint:getTipValue(RedPointConst.ACTIVITY_HERO_LETTER_ITEM .. "_" .. arg_9_0.activityID_)

	SetActive(arg_9_0.redGo_, var_9_4 > 0)
end

function var_0_0.RefreshTime(arg_10_0, arg_10_1)
	if arg_10_1 < arg_10_0.startTime_ then
		arg_10_0.lockCon_:SetSelectedState("off")

		arg_10_0.timeLable_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr2(arg_10_0.startTime_))
	elseif arg_10_1 >= arg_10_0.stopTime_ then
		arg_10_0.lockCon_:SetSelectedState("off")

		arg_10_0.timeLable_.text = GetTips("TIME_OVER")
	else
		arg_10_0.lockCon_:SetSelectedState("on")
	end
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()
	arg_12_0.super.Dispose(arg_12_0)
end

return var_0_0
