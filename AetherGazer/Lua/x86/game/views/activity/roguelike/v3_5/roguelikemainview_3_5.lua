ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("RoguelikeMainView_3_5", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_RoguelikeUI/SummerUI_3_5_RoguelikeMainUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.BtnReward, nil, handler(arg_3_0, arg_3_0.OnBtnRewardClick))
	arg_3_0:AddBtnListener(arg_3_0.BtnDifficult, nil, handler(arg_3_0, arg_3_0.OnBtnDifficultClick))
	arg_3_0:AddBtnListener(arg_3_0.BtnNormal, nil, handler(arg_3_0, arg_3_0.OnBtnNormalClick))
	arg_3_0:AddBtnListener(arg_3_0.BtnInfo, nil, handler(arg_3_0, arg_3_0.OnBtnInfoClick))
end

function var_0_0.OnEnter(arg_4_0)
	var_0_0.super.OnEnter(arg_4_0)
	manager.redPoint:bindUIandKey(arg_4_0.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5))
	manager.redPoint:bindUIandKey(arg_4_0.BtnDifficult.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_3_5))
	StrategyMatrixAction.SetStrategyRead(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5)
	arg_4_0.LockTag:SetActive(not StrategyMatrixData:GetIsClearance(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5))
	arg_4_0:UpdateBar()

	local var_4_0 = ActivityData:GetActivityData(arg_4_0.activityID_)

	arg_4_0.startTime_ = var_4_0.startTime
	arg_4_0.stopTime_ = var_4_0.stopTime
	arg_4_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_4_0.stopTime_, true)
end

function var_0_0.OnExit(arg_5_0)
	var_0_0.super.OnExit(arg_5_0)
	manager.redPoint:unbindUIandKey(arg_5_0.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5))
	manager.redPoint:unbindUIandKey(arg_5_0.BtnDifficult.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_3_5))
end

function var_0_0.UpdateBar(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnBtnRewardClick(arg_7_0)
	OperationRecorder.RecordButtonTouch("activity_polyhedron_izanami_reward1")
	JumpTools.OpenPageByJump("strategyMatrixRward", {
		task_activity_id = ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5
	})
end

function var_0_0.OnBtnNormalClick(arg_8_0)
	OperationRecorder.RecordButtonTouch("activity_polyhedron_izanami_easy")
	StrategyMatrixData:SetActivityId(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5)
	ActivityTools.JumpToSubmodulePage(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5)
end

function var_0_0.OnBtnInfoClick(arg_9_0)
	JumpTools.OpenPageByJump("gameHelp", {
		key = "ACTIVITY_ROGUELIKE_3_5_DESCRIBE",
		content = GetTips(StrategyMatrixTools.GetGameTipKey(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_3_5))
	})
end

function var_0_0.OnBtnDifficultClick(arg_10_0)
	OperationRecorder.RecordButtonTouch("activity_polyhedron_izanami_hard")

	local var_10_0 = ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_3_5

	if not ActivityTools.GetActivityIsOpenWithTip(var_10_0, true) then
		return
	end

	if not StrategyMatrixData:GetIsClearance(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5) then
		ShowTips("THOR_STRATEGY_UNLOCK")

		return
	end

	local var_10_1 = StrategyMatrixData:GetGameState(var_10_0)

	if not StrategyMatrixData:GetRead(var_10_0) then
		StrategyMatrixAction.SetStrategyRead(var_10_0)
	end

	if var_10_1 == MatrixConst.STATE_TYPE.NOTSTARTED or var_10_1 == MatrixConst.STATE_TYPE.FAIL then
		JumpTools.OpenPageByJump("/matrixBlank/roguelikeAffix", {
			activity_id = var_10_0
		})
	else
		StrategyMatrixData:SetActivityId(var_10_0)
		ActivityTools.JumpToSubmodulePage(var_10_0)
	end
end

return var_0_0
