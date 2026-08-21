local var_0_0 = class("BloodCardEntraceView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_BloodCardUI/BloodCardEnterUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.taskBtn_, nil, function()
		local var_5_0 = ActivityCfg[arg_4_0.activityID_].sub_activity_list[#ActivityCfg[arg_4_0.activityID_].sub_activity_list]

		TaskTools:ShowActivityTaskPop(var_5_0, "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com/SandPlay_Com_rewardPopUI")
	end)
	arg_4_0:AddBtnListener(arg_4_0.startBtn_, nil, function()
		JumpTools.OpenPageByJump("/bloodCardSelectNpc", {
			isEnter = true,
			selectNpc = arg_4_0.params_.optionParams[1],
			isAllNpc = arg_4_0.params_.optionParams[2] and arg_4_0.params_.optionParams[2] == 1,
			posX = arg_4_0.params_.optionParams[3],
			posY = arg_4_0.params_.optionParams[4],
			posZ = arg_4_0.params_.optionParams[5],
			rotationX = arg_4_0.params_.optionParams[6],
			rotationY = arg_4_0.params_.optionParams[7],
			rotationZ = arg_4_0.params_.optionParams[8]
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.buildCardBtn_, nil, function()
		JumpTools.OpenPageByJump("/bloodCardBuild")
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = BloodCardData:GetMainActivityID()
	arg_8_0.titleText_.text = ActivityTools.GetActivityTitleName(arg_8_0.activityID_)
	_, arg_8_0.stopTime_ = ActivityData:GetActivityTime(arg_8_0.activityID_)

	local var_8_0 = true

	for iter_8_0, iter_8_1 in ipairs(BloodCardConst.guideStageList) do
		if not BloodCardData:GetStageHasPass(iter_8_1) then
			var_8_0 = false

			break
		end
	end

	SetActive(arg_8_0.buildCardGo_, var_8_0)
	arg_8_0:AddTimer()

	if BloodCardData:GetTaskActivityID(arg_8_0.activityID_) ~= 0 then
		local var_8_1 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, BloodCardData:GetTaskActivityID(arg_8_0.activityID_))

		manager.redPoint:bindUIandKey(arg_8_0.taskBtn_.transform, var_8_1)
	end

	local var_8_2 = string.format("%s_%s", RedPointConst.ACTIVITY_BLOOD_CARD_STAGE_UNLOCK, BloodCardData:GetMainActivityID())

	manager.redPoint:bindUIandKey(arg_8_0.startBtn_.transform, var_8_2)
end

function var_0_0.OnEnterOver(arg_9_0)
	BloodCardTools.CheckCacheUnlockCard()
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_BLOOD_CARD_GAME_RULE")
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
	arg_11_0:StopTimer()

	if BloodCardData:GetTaskActivityID(arg_11_0.activityID_) ~= 0 then
		local var_11_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, BloodCardData:GetTaskActivityID(arg_11_0.activityID_))

		manager.redPoint:unbindUIandKey(arg_11_0.taskBtn_.transform, var_11_0)
	end

	local var_11_1 = string.format("%s_%s", RedPointConst.ACTIVITY_BLOOD_CARD_STAGE_UNLOCK, BloodCardData:GetMainActivityID())

	manager.redPoint:unbindUIandKey(arg_11_0.startBtn_.transform, var_11_1)
end

function var_0_0.AddTimer(arg_12_0)
	arg_12_0:StopTimer()
	arg_12_0:RefreshTimeText()

	arg_12_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > arg_12_0.stopTime_ then
			return
		end

		arg_12_0:RefreshTimeText()
	end, 1, -1)

	arg_12_0.timer_:Start()
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.timer_ then
		arg_14_0.timer_:Stop()

		arg_14_0.timer_ = nil
	end
end

function var_0_0.RefreshTimeText(arg_15_0)
	if arg_15_0.timeText_ then
		arg_15_0.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(arg_15_0.stopTime_, true)
	end
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:StopTimer()
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
