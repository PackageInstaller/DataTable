local StrategyMatrixOverView = class("StrategyMatrixOverView", (import("game.views.matrixOver.MatrixOverView")))

function StrategyMatrixOverView:UIBackCount()
	return 2
end

function StrategyMatrixOverView:UIName()
	return "Widget/System/MatrixlUI/StrategyBattleMatrixOverUI"
end

function StrategyMatrixOverView:InitUI()
	self:BindCfgUI()

	self.heroItemList_ = {}

	for iter_3_0 = 1, 3 do
		self.heroItemList_[iter_3_0] = StrategyMatrixOverHeroItem.New(self[string.format("heroItem%s_", iter_3_0)])
	end

	self.affixList_ = LuaList.New(handler(self, self.AffixIndexItem), self.m_affixList, MatrixOverAffixItem)
	self.treasureList_ = LuaList.New(handler(self, self.ArtifactIndexItem), self.m_treasureList, MatrixOverArtifactItem)
	self.beaconList_ = LuaList.New(handler(self, self.BeaconIndexItem), self.m_beaconList, MatrixOverBeaconItem)
	self.resultController_ = ControllerUtil.GetController(self.transform_, "result")
	self.difficultyController_ = ControllerUtil.GetController(self.transform_, "difficulty")
end

function StrategyMatrixOverView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		if self:GetGameState() == MatrixConst.STATE_TYPE.NOTSTARTED then
			StrategyMatrixAction.GotoStrategyMatrixPrepare(self.matrix_activity_id)
		else
			StrategyMatrixAction.QueryMatrixOver(self.matrix_activity_id)
		end
	end)
	self:AddBtnListener(self.statisticsBtn_, nil, function()
		JumpTools.OpenPageByJump("battleStatisticsStrategyMatrixOver", {
			matrix_activity_id = self.matrix_activity_id
		})
	end)
end

function StrategyMatrixOverView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	for iter_7_0 = 1, 3 do
		self.heroItemList_[iter_7_0]:SetMatrixActivityId(self.matrix_activity_id)
	end

	self:Refresh()
end

function StrategyMatrixOverView:Refresh()
	StrategyMatrixOverView.super.Refresh(self)
end

function StrategyMatrixOverView:OnMatrixUserUpdate()
	local var_9_0 = MatrixData:GetGameState()

	if MatrixConst.STATE_TYPE.NOTSTARTED == var_9_0 then
		-- block empty
	elseif MatrixConst.STATE_TYPE.SUCCESS ~= var_9_0 and MatrixConst.STATE_TYPE.FAIL == var_9_0 then
		-- block empty
	end
end

function StrategyMatrixOverView:GetGameState()
	return StrategyMatrixData:GetGameState(self.matrix_activity_id)
end

function StrategyMatrixOverView:GetCurrentClearTime()
	return StrategyMatrixData:GetCurrentClearTime(self.matrix_activity_id)
end

function StrategyMatrixOverView:GetMinClearTime()
	return StrategyMatrixData:GetMinClearTime(self.matrix_activity_id)
end

function StrategyMatrixOverView:GetEvaluateList()
	return {}
end

function StrategyMatrixOverView:GetTierDes()
	local var_14_0 = StrategyMatrixTierTemplateCfg[StrategyMatrixData:GetTierID(self.matrix_activity_id)]

	return string.format("%s-%s", var_14_0.tier, var_14_0.level)
end

function StrategyMatrixOverView:GetAffixList()
	return StrategyMatrixData:GetAffixList(self.matrix_activity_id)
end

function StrategyMatrixOverView:GetArtifactList()
	return StrategyMatrixData:GetArtifactList(self.matrix_activity_id)
end

function StrategyMatrixOverView:GetUseBeaconList()
	return {}
end

function StrategyMatrixOverView:GetMatrixCurrencyList()
	return StrategyMatrixData:GetMatrixCurrencyList(self.matrix_activity_id)
end

function StrategyMatrixOverView:GetMatrixHeroTeam()
	return StrategyMatrixData:GetMatrixHeroTeam(self.matrix_activity_id)
end

function StrategyMatrixOverView:GetMatrixOverScore()
	return StrategyMatrixData:GetMatrixOverPoint(self.matrix_activity_id)
end

function StrategyMatrixOverView:GetDifficulty()
	return (StrategyMatrixCfg[self.matrix_activity_id] or nil) and (StrategyMatrixCfg[self.matrix_activity_id].activity_difficulty or 1)
end

function StrategyMatrixOverView:GetRegularAffix()
	return {}
end

function StrategyMatrixOverView:GetCustomAffix()
	return StrategyMatrixData:GetCustomAffix(self.matrix_activity_id)
end

return StrategyMatrixOverView
