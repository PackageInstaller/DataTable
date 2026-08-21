local var_0_0 = class("ActivityAutoCookLevelView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteenUI/SandPlay_Com_IdleCanteenSelectStageUI"
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

	arg_4_0.stageFinishController1_ = arg_4_0.stageControllerEx1_:GetController("state")
	arg_4_0.stageFinishController2_ = arg_4_0.stageControllerEx2_:GetController("state")
	arg_4_0.stageFinishController3_ = arg_4_0.stageControllerEx3_:GetController("state")
	arg_4_0.stageSelectController1_ = arg_4_0.stageControllerEx1_:GetController("select")
	arg_4_0.stageSelectController2_ = arg_4_0.stageControllerEx2_:GetController("select")
	arg_4_0.stageSelectController3_ = arg_4_0.stageControllerEx3_:GetController("select")
	arg_4_0.heroStateController_ = arg_4_0.heroStateControllerEx_:GetController("status")
	arg_4_0.heroController_ = arg_4_0.heroStateControllerEx_:GetController("hero")
end

function var_0_0.AddUIListeners(arg_5_0)
	for iter_5_0 = 1, 3 do
		arg_5_0:AddBtnListener(arg_5_0["stageBtn" .. iter_5_0 .. "_"], nil, function()
			if arg_5_0.curSelectIndex_ == iter_5_0 then
				JumpTools.OpenPageByJump("/activityAutoCookPlayView", {
					battleHeroID = arg_5_0.battleHeroID_,
					activityStageID = ActivityAutoCookStageCfg.get_id_list_by_hero[arg_5_0.battleHeroID_][iter_5_0]
				})
			else
				arg_5_0.curSelectIndex_ = iter_5_0

				arg_5_0:RefreshStageSelectUI()
			end
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		TaskTools:ShowActivityTaskPop(ActivityConst.AUTO_COOK, "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com/SandPlay_Com_rewardPopUI")
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = ActivityConst.AUTO_COOK
	arg_8_0.battleHeroID_ = arg_8_0.params_.battleHeroID

	arg_8_0.heroController_:SetSelectedState(arg_8_0.battleHeroID_)

	arg_8_0.curSelectIndex_ = 0

	arg_8_0:RefreshUI()
	manager.redPoint:bindUIandKey(arg_8_0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_8_0.activityID_))
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:PlayEnterAnimator()
	arg_10_0:RefreshStageSelectUI()
	arg_10_0:RefreshHeroState()
	arg_10_0:RefreshBubble()

	arg_10_0.firstFinishStageID_ = ActivityAutoCookData:GetFirstFinishStageID()

	for iter_10_0, iter_10_1 in pairs(ActivityAutoCookStageCfg.get_id_list_by_hero[arg_10_0.battleHeroID_]) do
		local var_10_0 = ActivityAutoCookStageCfg[iter_10_1]
		local var_10_1 = var_10_0.food

		arg_10_0["stageImage" .. iter_10_0 .. "_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteen/Cuisine/" .. ActivityAutoCookFoodCfg[var_10_1].icon_path)

		if var_10_0.condition ~= 0 then
			if IsConditionAchieved(var_10_0.condition) then
				SetActive(arg_10_0["stageBtn" .. iter_10_0 .. "_"], true)
			else
				SetActive(arg_10_0["stageBtn" .. iter_10_0 .. "_"], false)
			end
		else
			SetActive(arg_10_0["stageBtn" .. iter_10_0 .. "_"], true)
		end

		if ActivityAutoCookData:GetStageIsFinish(iter_10_1) then
			if arg_10_0.firstFinishStageID_ == iter_10_1 then
				arg_10_0["stageFinishController" .. iter_10_0 .. "_"]:SetSelectedState("finish")
				arg_10_0:PlayFirstClearStageAnimator(iter_10_0)
				arg_10_0[string.format("itemAnimator%s_", iter_10_0)]:Play("Stage_finish", 0, 0)
				arg_10_0[string.format("itemAnimator%s_", iter_10_0)]:Update(0)
			else
				arg_10_0["stageFinishController" .. iter_10_0 .. "_"]:SetSelectedState("finish")
				arg_10_0[string.format("itemAnimator%s_", iter_10_0)]:Play("Stage_finish", 0, 1)
				arg_10_0[string.format("itemAnimator%s_", iter_10_0)]:Update(0)
			end
		else
			arg_10_0["stageFinishController" .. iter_10_0 .. "_"]:SetSelectedState("unlock")
		end
	end
end

function var_0_0.RefreshStageSelectUI(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(ActivityAutoCookStageCfg.get_id_list_by_hero[arg_11_0.battleHeroID_]) do
		if iter_11_0 == arg_11_0.curSelectIndex_ then
			arg_11_0["stageSelectController" .. iter_11_0 .. "_"]:SetSelectedState("on")
		else
			arg_11_0["stageSelectController" .. iter_11_0 .. "_"]:SetSelectedState("off")
		end
	end
end

function var_0_0.RefreshBubble(arg_12_0)
	local var_12_0 = ActivityAutoCookStageCfg.get_id_list_by_hero[arg_12_0.battleHeroID_]
	local var_12_1 = var_12_0[math.random(1, #var_12_0)]

	arg_12_0.bubbleText_.text = ActivityAutoCookStageCfg[var_12_1].start_challenge_tips
end

function var_0_0.RefreshHeroState(arg_13_0)
	local var_13_0 = arg_13_0:IsFinishAllStage()

	arg_13_0.heroStateController_:SetSelectedState(var_13_0 and "finish" or "unFinish")
end

function var_0_0.IsFinishAllStage(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(ActivityAutoCookStageCfg.get_id_list_by_hero[arg_14_0.battleHeroID_]) do
		if not ActivityAutoCookData:GetStageIsFinish(iter_14_1) then
			return false
		end
	end

	return true
end

function var_0_0.PlayFirstClearStageAnimator(arg_15_0, arg_15_1)
	ActivityAutoCookData:SetFirstFinishStageID(0)
	arg_15_0:StopFinishTimer()

	arg_15_0.finishTimer_ = FrameTimer.New(function()
		if arg_15_0[string.format("itemAnimator%s_", arg_15_1)]:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			arg_15_0:StopFinishTimer()

			local var_16_0 = ActivityAutoCookData:GetSpeedTipsID()

			if var_16_0 ~= 0 then
				QWorldMgr:GetQWorldHintMgr():DisplayHintImmediate(var_16_0)
				ActivityAutoCookData:ClearSpeedTipsID()
			end
		end
	end, 1, -1)

	arg_15_0.finishTimer_:Start()
end

function var_0_0.StopFinishTimer(arg_17_0)
	if arg_17_0.finishTimer_ then
		arg_17_0.finishTimer_:Stop()

		arg_17_0.finishTimer_ = nil
	end
end

function var_0_0.PlayEnterAnimator(arg_18_0)
	if not arg_18_0.params_.isBack then
		arg_18_0.animator_:Play("Exit_02", 0, 0)
		arg_18_0.animator_:Update(0)
	else
		arg_18_0.animator_:Play("Exit_02", 0, 1)
		arg_18_0.animator_:Update(0)
	end
end

function var_0_0.OnExit(arg_19_0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_19_0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_19_0.activityID_))
	arg_19_0:StopFinishTimer()
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0.super.Dispose(arg_20_0)
end

return var_0_0
