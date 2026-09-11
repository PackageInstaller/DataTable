local BattleCatchDuckResultView = class("BattleCatchDuckResultView", ReduxView)

function BattleCatchDuckResultView:UIName()
	return "Widget/System/Summer2024/Summer2024_Duck/DuckPartyResultPopUI"
end

function BattleCatchDuckResultView:UIParent()
	return manager.ui.uiMain.transform
end

function BattleCatchDuckResultView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function BattleCatchDuckResultView:InitUI()
	self:BindCfgUI()

	self.resultController_ = self.resultCon_:GetController("result")
	self.endlessController_ = self.resultCon_:GetController("endless")
	self.btnController_ = self.btncontentControllerexcollection_:GetController("btnState")
end

function BattleCatchDuckResultView:AddUIListeners()
	self:AddBtnListener(self.btnBack_, nil, function()
		BattleInstance.QuitBattle(self.stageData_)
	end)
	self:AddBtnListener(self.btnReChallenge_, nil, function()
		BattleInstance.OnceMoreBattle(self.params_.stageData)
	end)
end

function BattleCatchDuckResultView:OnEnter()
	self.stageData_ = self.params_.stageData
	self.stageName_.text = BattleCatchDuckStageCfg[self.stageData_.stageID_].name

	local var_8_0 = ActivityCatchDuckCfg[ActivityCatchDuckCfg.get_id_list_by_stage_id[self.stageData_.stageID_][1]]
	local var_8_1 = CatchDuckData:GetBattleResult() or {
		score = 0,
		seconds = var_8_0.limit_time
	}
	local var_8_2 = var_8_1.score >= ActivityCatchDuckCfg[ActivityCatchDuckCfg.get_id_list_by_stage_id[self.stageData_.stageID_][1]].target_score

	self.resultController_:SetSelectedState(var_8_1.score >= ActivityCatchDuckCfg[ActivityCatchDuckCfg.get_id_list_by_stage_id[self.stageData_.stageID_][1]].target_score and "win" or "lose")

	self.timeText_.text = var_8_2 and GetTips("CATCH_DUCK_WIN_TIME") or GetTips("CATCH_DUCK_FAIL_TIME")

	local var_8_4 = var_8_0.type == 1

	self.endlessController_:SetSelectedState(var_8_0.type == 1 and "normal" or "endless")

	self.targetScore_.text = var_8_4 and var_8_0.limit_time .. GetTips("SECOND") or var_8_0.target_score
	self.score_.text = var_8_4 and var_8_1.seconds .. GetTips("SECOND") or var_8_1.score

	if manager.ChessBoardManager and manager.ChessBoardManager:IsBattleBack() then
		self.btnController_:SetSelectedState("chess")
	else
		self.btnController_:SetSelectedState("normal")
	end
end

function BattleCatchDuckResultView:OnExit()
	return
end

function BattleCatchDuckResultView:Dispose()
	BattleCatchDuckResultView.super.Dispose(self)
end

return BattleCatchDuckResultView
