ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local RoguelikeMainView_2_6 = class("RoguelikeMainView_2_6", ActivityMainBasePanel)

function RoguelikeMainView_2_6:GetUIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRoguelikeUI/JapanRoguelikeMainUI"
end

function RoguelikeMainView_2_6:Init()
	self.gameObject_:InjectUI(self)
	self:AddListeners()
end

function RoguelikeMainView_2_6:AddListeners()
	self:AddBtnListener(self.BtnReward, nil, handler(self, self.OnBtnRewardClick))
	self:AddBtnListener(self.BtnDifficult, nil, handler(self, self.OnBtnDifficultClick))
	self:AddBtnListener(self.BtnNormal, nil, handler(self, self.OnBtnNormalClick))
	self:AddBtnListener(self.BtnInfo, nil, handler(self, self.OnBtnInfoClick))
end

function RoguelikeMainView_2_6:OnEnter()
	RoguelikeMainView_2_6.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6))
	manager.redPoint:bindUIandKey(self.BtnDifficult.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_6))
	StrategyMatrixAction.SetStrategyRead(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6)
	self.LockTag:SetActive(not StrategyMatrixData:GetIsClearance(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6))
end

function RoguelikeMainView_2_6:OnExit()
	RoguelikeMainView_2_6.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6))
	manager.redPoint:unbindUIandKey(self.BtnDifficult.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_6))
end

function RoguelikeMainView_2_6:OnBtnRewardClick()
	OperationRecorder.RecordButtonTouch("activity_polyhedron_izanami_reward1")
	JumpTools.OpenPageByJump("strategyMatrixRward", {
		task_activity_id = ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6
	})
end

function RoguelikeMainView_2_6:OnBtnNormalClick()
	OperationRecorder.RecordButtonTouch("activity_polyhedron_izanami_easy")
	ActivityTools.JumpToSubmodulePage(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6)
end

function RoguelikeMainView_2_6:OnBtnInfoClick()
	JumpTools.OpenPageByJump("gameHelp", {
		key = "ACTIVITY_ROGUELIKE_DESCRIBE",
		content = GetTips(StrategyMatrixTools.GetGameTipKey(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_6))
	})
end

function RoguelikeMainView_2_6:OnBtnDifficultClick()
	OperationRecorder.RecordButtonTouch("activity_polyhedron_izanami_hard")

	if not ActivityTools.GetActivityIsOpenWithTip(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_6, true) then
		return
	end

	if not StrategyMatrixData:GetIsClearance(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6) then
		ShowTips("THOR_STRATEGY_UNLOCK")

		return
	end

	local var_9_0 = StrategyMatrixData:GetGameState(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_6)

	if not StrategyMatrixData:GetRead(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_6) then
		StrategyMatrixAction.SetStrategyRead(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_6)
	end

	if var_9_0 == MatrixConst.STATE_TYPE.NOTSTARTED or var_9_0 == MatrixConst.STATE_TYPE.FAIL then
		JumpTools.OpenPageByJump("/matrixBlank/roguelikeAffix", {
			activity_id = ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_6
		})
	else
		ActivityTools.JumpToSubmodulePage(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_6)
	end
end

return RoguelikeMainView_2_6
