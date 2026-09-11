local BattleWhackMoleResultView = class("BattleWhackMoleResultView", ReduxView)

function BattleWhackMoleResultView:UIName()
	return "Widget/System/Summer2024/Summer2024_WhackMoleUI/WhackmoleresultPopUI"
end

function BattleWhackMoleResultView:UIParent()
	return manager.ui.uiPop.transform
end

function BattleWhackMoleResultView:Init()
	self:InitUI()
	self:AddListener()
end

function BattleWhackMoleResultView:InitUI()
	self:BindCfgUI()

	self.resultController_ = self.resultControllerEx_:GetController("result")
	self.stageTypeController_ = self.controllerEx_:GetController("stageType")
end

function BattleWhackMoleResultView:AddListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		BattleInstance.QuitBattle(self.params_.stageData)
	end)
	self:AddBtnListener(self.onceMoreBtn_, nil, function()
		BattleInstance.OnceMoreBattle(self.params_.stageData)
	end)
end

function BattleWhackMoleResultView:OnEnter()
	self.stageData_ = self.params_.stageData
	self.whackMoleID_ = self.stageData_:GetDest()

	self:RefreshUI()
end

function BattleWhackMoleResultView:RefreshUI()
	self.scoreText_.text = self.stageData_:GetScore()
	self.targetScoreText_.text = ActivityWhackMoleCfg[self.whackMoleID_].target_point

	self.resultController_:SetSelectedState(self.stageData_:GetBattleResult() == true and "win" or "lose")
	self:RefreshStageType()
end

function BattleWhackMoleResultView:RefreshStageType()
	if ActivityWhackMoleCfg[self.whackMoleID_].type == WhackMoleConst.STAGE_TYPE.CHESS then
		self.stageTypeController_:SetSelectedState("chess")
	elseif ActivityWhackMoleCfg[self.whackMoleID_].type == WhackMoleConst.STAGE_TYPE.INFINITY then
		self.stageTypeController_:SetSelectedState("infinity")
	else
		self.stageTypeController_:SetSelectedState("normal")
	end
end

return BattleWhackMoleResultView
