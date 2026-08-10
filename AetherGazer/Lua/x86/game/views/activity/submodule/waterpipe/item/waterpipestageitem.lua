local var_0_0 = class("WaterPipeStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.stageID = arg_1_2
	arg_1_0.stageCfg = ActivityWaterPipeStageCfg[arg_1_2]

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController = arg_2_0.controllerexcollection_:GetController("state")
	arg_2_0.pipePolaroid = WaterPipePolaroid.New(arg_2_0.polaroidGo_)

	arg_2_0:AddBtnListener(arg_2_0.pipestageitemBtn, nil, function()
		if ActivityData:GetActivityData(arg_2_0.stageCfg.activity_id).stopTime < manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		if WaterPipeData:CheckStageIsUnLock(arg_2_0.stageID) and not arg_2_0.timer_ then
			JumpTools.OpenPageByJump("waterPipeLetterPopView", {
				isSettle = false,
				stageID = arg_2_0.stageID
			})
		elseif not WaterPipeData:IsOpenPreStage(arg_2_0.stageID) then
			ShowTips("ACTIVITY_WATER_PIPE_PRE_STAGE_LOCK")
		else
			ShowTips("ACTIVITY_WATER_PIPE_TIME_LOCK")
		end
	end)
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = WaterPipeData:GetStageInfoByStageID(arg_4_0.stageID)

	if not WaterPipeData:CheckStageIsUnLock(arg_4_0.stageID) then
		arg_4_0.stateController:SetSelectedState("lock")
	elseif var_4_0 then
		arg_4_0:RefreshAniShow()
		arg_4_0.stateController:SetSelectedState("complete")
	else
		arg_4_0:RefreshAniShow()
		arg_4_0.stateController:SetSelectedState("unlock")
	end

	arg_4_0.pipePolaroid:RefreshUI(arg_4_0.stageID)

	local var_4_1 = WaterPipeData:GetStageOpenTimeTxt(arg_4_0.stageID)

	arg_4_0.textlockText_.text = var_4_1

	if not WaterPipeData:IsTimeOpenStage(arg_4_0.stageID) then
		arg_4_0:AddTimer()
	end
end

function var_0_0.AddTimer(arg_5_0)
	arg_5_0:StopTimer()
	arg_5_0:RefreshTimeShow()

	arg_5_0.timer_ = Timer.New(function()
		arg_5_0:RefreshTimeShow()
	end, 1, -1)

	arg_5_0.timer_:Start()
end

function var_0_0.RefreshTimeShow(arg_7_0)
	local var_7_0 = WaterPipeData:GetStageOpenTimeTxt(arg_7_0.stageID)
	local var_7_1 = WaterPipeData:IsTimeOpenStage(arg_7_0.stageID)

	arg_7_0.textlockText_.text = var_7_0

	if var_7_1 then
		arg_7_0:RefreshUI()
		arg_7_0:StopTimer()
	else
		arg_7_0.textlockText_.text = WaterPipeData:GetStageOpenTimeTxt(arg_7_0.stageID)
	end
end

function var_0_0.StopTimer(arg_8_0)
	if arg_8_0.timer_ then
		arg_8_0.timer_:Stop()

		arg_8_0.timer_ = nil
	end
end

function var_0_0.RefreshAniShow(arg_9_0)
	arg_9_0.starAni_:Play("UI_fangkuai_loop", 0, 0)
	arg_9_0.sugarAni_:Play("UI_sugar_cx", 0, 0)
end

function var_0_0.ShowStageAni(arg_10_0, arg_10_1)
	arg_10_0.completeAni_.enabled = arg_10_1
	arg_10_0.heroAni_.enabled = arg_10_1
end

function var_0_0.BindRedPoint(arg_11_0)
	manager.redPoint:bindUIandKey(arg_11_0.transform_, string.format("%s_%s", RedPointConst.ACTIVITY_WATER_PIPE_STAGE, arg_11_0.stageID))
end

function var_0_0.UnBindRedPoint(arg_12_0)
	manager.redPoint:unbindUIandKey(arg_12_0.transform_, string.format("%s_%s", RedPointConst.ACTIVITY_WATER_PIPE_STAGE, arg_12_0.stageID))
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:StopTimer()
	arg_13_0.pipePolaroid:Dispose()
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
