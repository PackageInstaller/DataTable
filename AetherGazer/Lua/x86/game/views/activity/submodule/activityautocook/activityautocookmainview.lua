local var_0_0 = class("ActivityAutoCookMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteenUI/SandPlay_Com_IdleCanteenEnterUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.revenueController_ = arg_4_0.controllerEx_:GetController("RevenueState")
	arg_4_0.rewardController_ = arg_4_0.controllerEx_:GetController("Claima")
	arg_4_0.detailController_ = arg_4_0.controllerEx_:GetController("Boost")
	arg_4_0.stateController1_ = arg_4_0.heroControllerEx1_:GetController("status")
	arg_4_0.stateController2_ = arg_4_0.heroControllerEx2_:GetController("status")
	arg_4_0.stateController3_ = arg_4_0.heroControllerEx3_:GetController("status")
	arg_4_0.stateController4_ = arg_4_0.heroControllerEx4_:GetController("status")
	arg_4_0.heroController1_ = arg_4_0.heroControllerEx1_:GetController("hero")
	arg_4_0.heroController2_ = arg_4_0.heroControllerEx2_:GetController("hero")
	arg_4_0.heroController3_ = arg_4_0.heroControllerEx3_:GetController("hero")
	arg_4_0.heroController4_ = arg_4_0.heroControllerEx4_:GetController("hero")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.getRewardBtn_, nil, function()
		ActivityAutoCookAction:GetAutoCookReward(arg_5_0.activityID_)
	end)

	for iter_5_0 = 1, 4 do
		arg_5_0:AddBtnListener(arg_5_0["heroBtn" .. iter_5_0 .. "_"], nil, function()
			local var_7_0
			local var_7_1 = 1

			for iter_7_0, iter_7_1 in pairs(ActivityAutoCookStageCfg.get_id_list_by_hero) do
				if var_7_1 == iter_5_0 then
					var_7_0 = iter_7_0

					break
				end

				var_7_1 = var_7_1 + 1
			end

			local var_7_2 = false
			local var_7_3

			for iter_7_2, iter_7_3 in pairs(ActivityAutoCookStageCfg.get_id_list_by_hero[var_7_0]) do
				local var_7_4 = ActivityAutoCookStageCfg[iter_7_3]

				if var_7_4.condition > 0 then
					if IsConditionAchieved(var_7_4.condition) then
						var_7_2 = true

						break
					else
						var_7_2 = false
						var_7_3 = var_7_4.condition
					end
				else
					var_7_2 = true
				end
			end

			if var_7_2 then
				manager.ui:UIEventEnabled(false)
				arg_5_0:PlayExitAnimator(function()
					manager.ui:UIEventEnabled(true)
					JumpTools.OpenPageByJump("/activityAutoCookLevelView", {
						battleHeroID = var_7_0
					})
				end)
			else
				local var_7_5 = QWorldQuestTool.GetQuestProgressText(SandplayTaskCfg.get_id_list_by_main_task_id[ConditionCfg[var_7_3].params[1]][1])

				ShowTips(string.format(GetTips("ACTIVITY_AUTO_COOK_TIP2"), var_7_5))
			end
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		TaskTools:ShowActivityTaskPop(ActivityConst.AUTO_COOK, "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com/SandPlay_Com_rewardPopUI")
	end)
	arg_5_0:AddBtnListener(arg_5_0.showDetailBtn_, nil, function()
		arg_5_0:HideEffect()
		arg_5_0.detailController_:SetSelectedState("unfold")
	end)
	arg_5_0:AddBtnListener(arg_5_0.hideDetailBtn_, nil, function()
		arg_5_0.detailController_:SetSelectedState("closed")
	end)
end

function var_0_0.OnEnter(arg_12_0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_AUTO_COOK_NEW_LEVLE .. ActivityConst.AUTO_COOK, 0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_AUTO_COOK_GOLDMAX .. ActivityConst.AUTO_COOK, 0)
	arg_12_0.exitAnimator_:Play("New State", 0, 0)

	arg_12_0.activityID_ = ActivityConst.AUTO_COOK
	arg_12_0.titleText_.text = ActivityCfg[arg_12_0.activityID_].remark

	local var_12_0 = ActivityData:GetActivityData(arg_12_0.activityID_).stopTime

	if var_12_0 < manager.time:GetServerTime() then
		arg_12_0.timeText_.text = string.format(GetTips("TIME_OVER"))

		return
	else
		arg_12_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_12_0, true)
	end

	arg_12_0.activityTimer_ = Timer.New(function()
		if manager.time:GetServerTime() > var_12_0 then
			arg_12_0.timeText_.text = string.format(GetTips("TIME_OVER"))

			arg_12_0:StopTimer()
		else
			arg_12_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(var_12_0, true)
		end
	end, 1, -1)

	arg_12_0.activityTimer_:Start()
	arg_12_0:RefreshUI()

	arg_12_0.timer_ = Timer.New(function()
		arg_12_0:RefreshCurHaveGold()
	end, 61, -1)

	arg_12_0.timer_:Start()
	manager.redPoint:bindUIandKey(arg_12_0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_12_0.activityID_))
end

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_AUTO_COOK_TIP1")
end

function var_0_0.RefreshUI(arg_16_0)
	arg_16_0:RefreshCurHaveGold()
	arg_16_0:RefreshDetailInfo()
	arg_16_0:RefreshSpeedPanel()
	arg_16_0:RefreshHeroStage()
end

function var_0_0.RefreshCurHaveGold(arg_17_0)
	local var_17_0 = ActivityAutoCookData:GetCurHaveGold()

	arg_17_0.curHaveGoldText_.text = var_17_0
	arg_17_0.curHaveGoldMaxText_.text = "/" .. ActivityAutoCookData:GetCurHaveGoldMax()
	arg_17_0.curGetGoldText_.text = ActivityAutoCookData:GetCurGetGold()
	arg_17_0.curGetGoldMaxText_.text = "/" .. GameSetting.auto_cook_item_week_max.value[1]

	if var_17_0 > 0 then
		arg_17_0.rewardController_:SetSelectedState("claimable")
	else
		arg_17_0.rewardController_:SetSelectedState("normal")
	end

	if ActivityAutoCookData:GetCurGetGold() >= GameSetting.auto_cook_item_week_max.value[1] then
		arg_17_0.revenueController_:SetSelectedState("rest")
	else
		arg_17_0.revenueController_:SetSelectedState("inOperation")
	end
end

function var_0_0.RefreshSpeedPanel(arg_18_0)
	if arg_18_0.needShowSpeedPanel_ then
		arg_18_0.detailController_:SetSelectedState("unfold")
	else
		arg_18_0.detailController_:SetSelectedState("closed")
	end
end

function var_0_0.RefreshDetailInfo(arg_19_0)
	arg_19_0.needShowSpeedPanel_ = false

	local var_19_0 = {}
	local var_19_1 = {}
	local var_19_2 = ActivityAutoCookData:GetCurElemontList()

	for iter_19_0, iter_19_1 in pairs(var_19_2) do
		local var_19_3 = ActivityAutoCookSpeedCfg[iter_19_1]

		if var_19_3 then
			local var_19_4 = false

			for iter_19_2, iter_19_3 in pairs(var_19_0) do
				if iter_19_3.type == var_19_3.type then
					iter_19_3.speed = iter_19_3.speed + var_19_3.speed
					var_19_4 = true

					break
				end
			end

			if not var_19_4 then
				table.insert(var_19_0, {
					type = var_19_3.type,
					speed = var_19_3.speed
				})
				table.insert(var_19_1, var_19_3.des)
			end
		end
	end

	local var_19_5 = false

	for iter_19_4 = 1, 3 do
		if var_19_0[iter_19_4] == nil then
			SetActive(arg_19_0["speedItemGo" .. iter_19_4 .. "_"], false)
		else
			SetActive(arg_19_0["speedItemGo" .. iter_19_4 .. "_"], true)

			arg_19_0["speedItemText" .. iter_19_4 .. "_"].text = var_19_1[iter_19_4]
			arg_19_0["speedItemNumText" .. iter_19_4 .. "_"].text = var_19_0[iter_19_4].speed * 10 .. "/" .. GetTips("HOUR")

			if ActivityAutoCookData:GetLocalSpeedRate(iter_19_4) ~= var_19_0[iter_19_4].speed then
				SetActive(arg_19_0[string.format("speedAnimatorGo%s_", iter_19_4)], false)
				arg_19_0[string.format("speedAnimator%s_", iter_19_4)]:Play("Num_up", 0, 0)
				arg_19_0[string.format("speedAnimator%s_", iter_19_4)]:Update(0)
				ActivityAutoCookData:SetLocalSpeedRate(iter_19_4, var_19_0[iter_19_4].speed)

				arg_19_0.needShowSpeedPanel_ = true
			else
				SetActive(arg_19_0[string.format("speedAnimatorGo%s_", iter_19_4)], false)
			end

			var_19_5 = true
		end
	end

	if var_19_5 then
		SetActive(arg_19_0.speedGo_, true)
	else
		SetActive(arg_19_0.speedGo_, false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.speedContentTrans_)
end

function var_0_0.RefreshHeroStage(arg_20_0)
	local var_20_0 = 1

	for iter_20_0, iter_20_1 in pairs(ActivityAutoCookStageCfg.get_id_list_by_hero) do
		local var_20_1 = false
		local var_20_2 = true

		for iter_20_2, iter_20_3 in pairs(iter_20_1) do
			local var_20_3 = ActivityAutoCookStageCfg[iter_20_3]

			var_20_1 = not (var_20_3.condition > 0) or not not IsConditionAchieved(var_20_3.condition) and true

			if not ActivityAutoCookData:GetStageIsFinish(iter_20_3) then
				var_20_2 = false
			end
		end

		arg_20_0["heroController" .. var_20_0 .. "_"]:SetSelectedState(iter_20_0)

		if var_20_1 then
			if var_20_2 then
				arg_20_0["stateController" .. var_20_0 .. "_"]:SetSelectedState("finish")
			else
				arg_20_0["stateController" .. var_20_0 .. "_"]:SetSelectedState("unFinish")
			end
		else
			arg_20_0["stateController" .. var_20_0 .. "_"]:SetSelectedState("empty")
		end

		var_20_0 = var_20_0 + 1
	end
end

function var_0_0.OnExit(arg_21_0)
	manager.windowBar:HideBar()
	arg_21_0:StopTimer()
	arg_21_0:StopExitAnimator()
	arg_21_0:HideEffect()
	manager.redPoint:unbindUIandKey(arg_21_0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_21_0.activityID_))
end

function var_0_0.StopTimer(arg_22_0)
	if arg_22_0.timer_ then
		arg_22_0.timer_:Stop()

		arg_22_0.timer_ = nil
	end

	if arg_22_0.activityTimer_ then
		arg_22_0.activityTimer_:Stop()

		arg_22_0.activityTimer_ = nil
	end
end

function var_0_0.PlayExitAnimator(arg_23_0, arg_23_1)
	arg_23_0.exitAnimator_:Play("Exit", 0, 0)
	arg_23_0.exitAnimator_:Update(0)
	arg_23_0:StopExitAnimator()

	arg_23_0.exitTimer_ = FrameTimer.New(function()
		if arg_23_0.exitAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			arg_23_0:StopExitAnimator()
			arg_23_1()
		end
	end, 1, -1)

	arg_23_0.exitTimer_:Start()
end

function var_0_0.StopExitAnimator(arg_25_0)
	if arg_25_0.exitTimer_ then
		arg_25_0.exitTimer_:Stop()

		arg_25_0.exitTimer_ = nil
	end
end

function var_0_0.HideEffect(arg_26_0)
	for iter_26_0 = 1, 3 do
		SetActive(arg_26_0[string.format("speedAnimatorGo%s_", iter_26_0)], false)
	end
end

function var_0_0.OnActivityAutoCookGetReward(arg_27_0)
	arg_27_0:RefreshUI()
end

function var_0_0.Dispose(arg_28_0)
	arg_28_0.super.Dispose(arg_28_0)
end

return var_0_0
