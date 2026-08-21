local var_0_0 = class("AffixSelectItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
	arg_2_0:StartTimer()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.btn_ = arg_3_0.gameObject_:GetComponent(typeof(Button))
	arg_3_0.item_stateController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "item_state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		OperationRecorder.RecordButtonTouch("activity_affixbattle_stage_" .. arg_4_0.activityId_)

		if not ActivityData:GetActivityIsOpen(arg_4_0.activityId_) then
			local var_5_0 = ActivityData:GetActivityData(arg_4_0.activityId_)
			local var_5_1 = manager.time:GetServerTime()

			if var_5_0 and var_5_1 < var_5_0.startTime then
				ShowTips(string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(var_5_0.startTime)))
			else
				ShowTips("SOLO_TIME_OVER")
			end

			return
		end

		ActivityAffixSelectData:ReadInnerRedPoint(arg_4_0.activityId_)
		ActivityAffixSelectData:SetClickState(arg_4_0.activityId_)

		local var_5_2 = ActivityCfg[arg_4_0.activityId_]

		JumpTools.OpenPageByJump("/affixSelectDetailJapanRegion", {
			activityId = arg_4_0.activityId_,
			index = arg_4_0.index_
		})
	end)
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.index_ = arg_7_1
	arg_7_0.activityId_ = arg_7_2

	arg_7_0:UpdateView()
end

function var_0_0.GetActivityData(arg_8_0)
	return ActivityAffixSelectData:GetSubActivityData(arg_8_0.activityId_)
end

function var_0_0.StartTimer(arg_9_0)
	if arg_9_0.timer_ == nil then
		arg_9_0.timer_ = Timer.New(function()
			arg_9_0:UpdateView()
		end, 1, -1)
	end

	arg_9_0.timer_:Start()
end

function var_0_0.StopTimer(arg_11_0)
	if arg_11_0.timer_ then
		arg_11_0.timer_:Stop()

		arg_11_0.timer_ = nil
	end
end

function var_0_0.UpdateView(arg_12_0)
	local var_12_0 = ActivityData:GetActivityIsOpen(arg_12_0.activityId_)

	if not var_12_0 or arg_12_0:GetActivityData() == nil then
		arg_12_0.item_stateController_:SetSelectedState("lock")

		local var_12_1 = ActivityData:GetActivityData(arg_12_0.activityId_)

		if manager.time:GetServerTime() >= var_12_1.startTime then
			arg_12_0.lockLabel_.text = GetTips("SOLO_TIME_OVER")
		else
			arg_12_0.lockLabel_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(var_12_1.startTime))
		end
	else
		if arg_12_0:GetActivityData().clearState == 1 then
			arg_12_0.item_stateController_:SetSelectedState("unlock")
		else
			arg_12_0.item_stateController_:SetSelectedState("passed")
		end

		arg_12_0.highestScoreLabel_.text = arg_12_0:GetActivityData().point

		local var_12_2 = ActivityAffixSelectCfg[arg_12_0.activityId_].boss_id[1]

		arg_12_0.bossIcon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. var_12_2)
	end

	if var_12_0 and not ActivityAffixSelectData:HaveReadInnerPoint(arg_12_0.activityId_) and arg_12_0:GetActivityData().clearState == 1 then
		SetActive(arg_12_0.noticeGo_, true)
	else
		SetActive(arg_12_0.noticeGo_, false)
	end
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:AddEventListeners()
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_15_0)
	return
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:StopTimer()
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
