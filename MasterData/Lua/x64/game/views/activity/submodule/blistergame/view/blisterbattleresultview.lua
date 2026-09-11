local BlisterBattleResultView = class("BlisterBattleResultView", ReduxView)

function BlisterBattleResultView:UIName()
	return "Widget/System/Summer2024/Summer2024_Bubble/BubbleresultPopUI"
end

function BlisterBattleResultView:UIParent()
	return manager.ui.uiPop.transform
end

function BlisterBattleResultView:OnCtor()
	return
end

function BlisterBattleResultView:Init()
	self:InitUI()
	self:AddListeners()
end

function BlisterBattleResultView:InitUI()
	self:BindCfgUI()

	self.battleControl = self.bubbleresultpopuiControllerexcollection_:GetController("battleStatede")
	self.btnControl = self.bubbleresultpopuiControllerexcollection_:GetController("btnState")
	self.panelControllerexcollection_ = self.panelControllerexcollection_:GetController("Tittle")
	self.nodeList = {}
end

function BlisterBattleResultView:AddListeners()
	self:AddBtnListener(self.suminibtn02Btn_, nil, function()
		self:OnCancel()
	end)
	self:AddBtnListener(self.suminibtn01Btn_, nil, function()
		self:OnOk()
	end)
end

function BlisterBattleResultView:ChangeBar()
	return
end

function BlisterBattleResultView:OnTop()
	return
end

function BlisterBattleResultView:OnOk()
	if manager.ChessBoardManager and manager.ChessBoardManager:IsBattleBack() then
		ChessBoardAction.GoBackFromSmallGame(self.params_ and self.params_.isWin and 0 or 1, (self.params_ or nil) and (self.params_.score or 0))
	else
		BlisterGameTool.ExitGame()
	end
end

function BlisterBattleResultView:OnCancel()
	BlisterGameTool.ReStartGame()
	self:Back()
end

function BlisterBattleResultView:OnNextStage()
	BlisterGameTool.NextStage(self.nextId_, self.nextCfg_)
	self:Back()
end

function BlisterBattleResultView:Cacheable()
	return false
end

function BlisterBattleResultView:OnEnter()
	BlisterBattleResultView.super.OnEnter(self)

	local var_15_0

	if self.params_ then
		var_15_0 = self.params_.id or 1

		local var_15_1

		if self.params_ then
			var_15_1 = self.params_.score or 0

			local var_15_2

			if self.params_ then
				var_15_2 = self.params_.star or 0
			end
		end
	end

	local var_15_3 = ActivityBubbleCfg[var_15_0]
	local var_15_4 = self.params_ and self.params_.isWin
	local var_15_5 = nullable(self.params_, "forceQuit") or false

	self.battleControl:SetSelectedState(var_15_4 and "win" or "fail")

	if manager.ChessBoardManager and manager.ChessBoardManager:IsBattleBack() then
		self.btnControl:SetSelectedState("chess")
	else
		self.btnControl:SetSelectedState("normal")
	end

	local var_15_6 = false
	local var_15_7 = table.indexof(ActivityBubbleCfg.all, (BlisterGameData:GetPassId()))

	if var_15_5 then
		var_15_6 = false
	elseif var_15_7 then
		self.nextId_ = ActivityBubbleCfg.all[var_15_7 + 1]
		self.nextCfg_ = ActivityBubbleCfg[self.nextId_]
		var_15_6 = self.nextId_ and self.nextCfg_ ~= nil
	end

	if self.suminibtn03Btn_ then
		SetActive(self.suminibtn03Btn_.gameObject, var_15_4 and var_15_6)
	end

	self.panelControllerexcollection_:SetSelectedState(var_15_4 and "win" or "lose")

	if var_15_3 then
		self.textcheckpointText_.text = var_15_3.name
		self.textpointsText_.text = var_15_1

		for iter_15_0 = 1, 3 do
			self.nodeList[iter_15_0] = self.nodeList[iter_15_0] or BlisterGoalItem.New(self[string.format("nd0%sGo_", iter_15_0)])
			isGet = iter_15_0 <= var_15_2 or false

			self.nodeList[iter_15_0]:SetData(isGet, var_15_3.score_level[iter_15_0] or 0)
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.btncontentTrs_)
end

function BlisterBattleResultView:OnExit()
	BlisterBattleResultView.super.OnExit(self)
end

function BlisterBattleResultView:Dispose()
	BlisterBattleResultView.super.Dispose(self)
end

return BlisterBattleResultView
