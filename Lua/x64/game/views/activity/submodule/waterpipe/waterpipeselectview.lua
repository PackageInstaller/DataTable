local var_0_0 = class("WaterPipeSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_WaterPipeUI/WaterPipeStageSelectUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.stageMap = WaterPipeStageMapView.New(arg_4_0.stageGo_)
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.stageMap:RefreshUI()
	arg_5_0.stageMap:BindRedPoint()
	arg_5_0.stageMap:MoveToOptimal()
	arg_5_0:StartTimer()
	arg_5_0:UpdateTimeShow()

	if arg_5_0.params_ and arg_5_0.params_.finishStageID then
		arg_5_0.stageMap:PlaySettleAni(arg_5_0.params_.finishStageID)
	end
end

function var_0_0.UpdateTimeShow(arg_6_0)
	local var_6_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_WATER_PIPE)

	arg_6_0.textTimeText_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(var_6_0.stopTime, true))

	if not var_6_0 or not var_6_0:IsActivitying() then
		ShowTips("TIME_OVER")
		JumpTools.Back()
	end
end

function var_0_0.StartTimer(arg_7_0)
	arg_7_0:DisposeTimer()

	arg_7_0.timer = Timer.New(function()
		arg_7_0:UpdateTimeShow()
	end, 1, -1)

	arg_7_0.timer:Start()
end

function var_0_0.DisposeTimer(arg_9_0)
	if arg_9_0.timer then
		arg_9_0.timer:Stop()

		arg_9_0.timer = nil
	end
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:DisposeTimer()
	manager.windowBar:HideBar()
	arg_10_0.stageMap:UnBindRedPoint()
end

function var_0_0.OnTop(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistInfoCallBack(function()
		local var_12_0 = "ACTIVITY_WATER_PIPE_GAME_TIP"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(var_12_0),
			key = var_12_0
		})
	end)
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.stageMap:Dispose()
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
