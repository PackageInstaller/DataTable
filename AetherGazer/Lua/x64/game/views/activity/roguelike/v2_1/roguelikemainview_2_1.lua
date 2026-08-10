ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("RoguelikeMainView_2_1", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "UI/VersionUI/XuHeng2ndUI/XH2ndRoguelikeUI/XH2ndRoguelikeMainUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0.gameObject_:InjectUI(arg_2_0)
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
	manager.redPoint:bindUIandKey(arg_4_0.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_1))
	manager.redPoint:bindUIandKey(arg_4_0.BtnDifficult.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_1))
	StrategyMatrixAction.SetStrategyRead(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_1)
	arg_4_0.LockTag:SetActive(not StrategyMatrixData:GetIsClearance(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_1))
end

function var_0_0.OnExit(arg_5_0)
	var_0_0.super.OnExit(arg_5_0)
	manager.redPoint:unbindUIandKey(arg_5_0.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_1))
	manager.redPoint:unbindUIandKey(arg_5_0.BtnDifficult.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_1))
end

function var_0_0.OnBtnRewardClick(arg_6_0)
	JumpTools.OpenPageByJump("strategyMatrixRward", {
		task_activity_id = 170043
	})
end

function var_0_0.OnBtnNormalClick(arg_7_0)
	ActivityTools.JumpToSubmodulePage(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_1)
end

function var_0_0.OnBtnInfoClick(arg_8_0)
	JumpTools.OpenPageByJump("gameHelp", {
		key = "ACTIVITY_ROGUELIKE_DESCRIBE",
		content = GetTips(StrategyMatrixTools.GetGameTipKey(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_1))
	})
end

function var_0_0.OnBtnDifficultClick(arg_9_0)
	local var_9_0 = ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_1

	if not ActivityTools.GetActivityIsOpenWithTip(var_9_0, true) then
		return
	end

	if not StrategyMatrixData:GetIsClearance(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_1) then
		ShowTips("THOR_STRATEGY_UNLOCK")

		return
	end

	local var_9_1 = StrategyMatrixData:GetGameState(var_9_0)

	if not StrategyMatrixData:GetRead(var_9_0) then
		StrategyMatrixAction.SetStrategyRead(var_9_0)
	end

	if var_9_1 == MatrixConst.STATE_TYPE.NOTSTARTED or var_9_1 == MatrixConst.STATE_TYPE.FAIL then
		JumpTools.OpenPageByJump("/matrixBlank/roguelikeAffix", {
			activity_id = var_9_0
		})
	else
		ActivityTools.JumpToSubmodulePage(var_9_0)
	end
end

return var_0_0
