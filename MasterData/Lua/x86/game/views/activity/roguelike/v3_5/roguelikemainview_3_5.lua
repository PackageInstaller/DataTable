ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local RoguelikeMainView_3_5 = class("RoguelikeMainView_3_5", ActivityMainBasePanel)

function RoguelikeMainView_3_5:GetUIName()
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_RoguelikeUI/SummerUI_3_5_RoguelikeMainUI"
end

function RoguelikeMainView_3_5:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function RoguelikeMainView_3_5:AddListeners()
	self:AddBtnListener(self.BtnReward, nil, handler(self, self.OnBtnRewardClick))
	self:AddBtnListener(self.BtnDifficult, nil, handler(self, self.OnBtnDifficultClick))
	self:AddBtnListener(self.BtnNormal, nil, handler(self, self.OnBtnNormalClick))
	self:AddBtnListener(self.BtnInfo, nil, handler(self, self.OnBtnInfoClick))
end

function RoguelikeMainView_3_5:OnEnter()
	RoguelikeMainView_3_5.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5))
	manager.redPoint:bindUIandKey(self.BtnDifficult.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_3_5))
	StrategyMatrixAction.SetStrategyRead(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5)
	self.LockTag:SetActive(not StrategyMatrixData:GetIsClearance(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5))
	self:UpdateBar()

	local var_4_0 = ActivityData:GetActivityData(self.activityID_)

	self.startTime_ = var_4_0.startTime
	self.stopTime_ = var_4_0.stopTime
	self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
end

function RoguelikeMainView_3_5:OnExit()
	RoguelikeMainView_3_5.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5))
	manager.redPoint:unbindUIandKey(self.BtnDifficult.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_3_5))
end

function RoguelikeMainView_3_5:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function RoguelikeMainView_3_5:OnBtnRewardClick()
	OperationRecorder.RecordButtonTouch("activity_polyhedron_izanami_reward1")
	JumpTools.OpenPageByJump("strategyMatrixRward", {
		task_activity_id = ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5
	})
end

function RoguelikeMainView_3_5:OnBtnNormalClick()
	OperationRecorder.RecordButtonTouch("activity_polyhedron_izanami_easy")
	StrategyMatrixData:SetActivityId(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5)
	ActivityTools.JumpToSubmodulePage(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5)
end

function RoguelikeMainView_3_5:OnBtnInfoClick()
	JumpTools.OpenPageByJump("gameHelp", {
		key = "ACTIVITY_ROGUELIKE_3_5_DESCRIBE",
		content = GetTips(StrategyMatrixTools.GetGameTipKey(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_3_5))
	})
end

function RoguelikeMainView_3_5:OnBtnDifficultClick()
	OperationRecorder.RecordButtonTouch("activity_polyhedron_izanami_hard")

	if not ActivityTools.GetActivityIsOpenWithTip(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_3_5, true) then
		return
	end

	if not StrategyMatrixData:GetIsClearance(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5) then
		ShowTips("THOR_STRATEGY_UNLOCK")

		return
	end

	local var_10_0 = StrategyMatrixData:GetGameState(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_3_5)

	if not StrategyMatrixData:GetRead(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_3_5) then
		StrategyMatrixAction.SetStrategyRead(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_3_5)
	end

	if var_10_0 == MatrixConst.STATE_TYPE.NOTSTARTED or var_10_0 == MatrixConst.STATE_TYPE.FAIL then
		JumpTools.OpenPageByJump("/matrixBlank/roguelikeAffix", {
			activity_id = ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_3_5
		})
	else
		StrategyMatrixData:SetActivityId(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_3_5)
		ActivityTools.JumpToSubmodulePage(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_3_5)
	end
end

return RoguelikeMainView_3_5
