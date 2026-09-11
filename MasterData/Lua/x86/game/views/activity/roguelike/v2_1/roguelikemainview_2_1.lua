ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local RoguelikeMainView_2_1 = class("RoguelikeMainView_2_1", ActivityMainBasePanel)

function RoguelikeMainView_2_1:GetUIName()
	return "UI/VersionUI/XuHeng2ndUI/XH2ndRoguelikeUI/XH2ndRoguelikeMainUI"
end

function RoguelikeMainView_2_1:Init()
	self.gameObject_:InjectUI(self)
	self:AddListeners()
end

function RoguelikeMainView_2_1:AddListeners()
	self:AddBtnListener(self.BtnReward, nil, handler(self, self.OnBtnRewardClick))
	self:AddBtnListener(self.BtnDifficult, nil, handler(self, self.OnBtnDifficultClick))
	self:AddBtnListener(self.BtnNormal, nil, handler(self, self.OnBtnNormalClick))
	self:AddBtnListener(self.BtnInfo, nil, handler(self, self.OnBtnInfoClick))
end

function RoguelikeMainView_2_1:OnEnter()
	RoguelikeMainView_2_1.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_1))
	manager.redPoint:bindUIandKey(self.BtnDifficult.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_1))
	StrategyMatrixAction.SetStrategyRead(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_1)
	self.LockTag:SetActive(not StrategyMatrixData:GetIsClearance(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_1))
end

function RoguelikeMainView_2_1:OnExit()
	RoguelikeMainView_2_1.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_1))
	manager.redPoint:unbindUIandKey(self.BtnDifficult.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_1))
end

function RoguelikeMainView_2_1:OnBtnRewardClick()
	JumpTools.OpenPageByJump("strategyMatrixRward", {
		task_activity_id = 170043
	})
end

function RoguelikeMainView_2_1:OnBtnNormalClick()
	ActivityTools.JumpToSubmodulePage(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_1)
end

function RoguelikeMainView_2_1:OnBtnInfoClick()
	JumpTools.OpenPageByJump("gameHelp", {
		key = "ACTIVITY_ROGUELIKE_DESCRIBE",
		content = GetTips(StrategyMatrixTools.GetGameTipKey(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_1))
	})
end

function RoguelikeMainView_2_1:OnBtnDifficultClick()
	if not ActivityTools.GetActivityIsOpenWithTip(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_1, true) then
		return
	end

	if not StrategyMatrixData:GetIsClearance(ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_1) then
		ShowTips("THOR_STRATEGY_UNLOCK")

		return
	end

	local var_9_0 = StrategyMatrixData:GetGameState(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_1)

	if not StrategyMatrixData:GetRead(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_1) then
		StrategyMatrixAction.SetStrategyRead(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_1)
	end

	if var_9_0 == MatrixConst.STATE_TYPE.NOTSTARTED or var_9_0 == MatrixConst.STATE_TYPE.FAIL then
		JumpTools.OpenPageByJump("/matrixBlank/roguelikeAffix", {
			activity_id = ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_1
		})
	else
		ActivityTools.JumpToSubmodulePage(ActivityConst.ACTIVITY_ROGUELIKE_DIFFICULT_2_1)
	end
end

return RoguelikeMainView_2_1
