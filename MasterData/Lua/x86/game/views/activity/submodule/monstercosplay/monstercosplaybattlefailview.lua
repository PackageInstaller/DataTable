NewBattleFailedView = import("game.views.battleFailed.newBattleFailed.NewBattleFailedView")

local MonsterCosplayBattleFailView = class("MonsterCosplayBattleFailView", NewBattleFailedView)

function MonsterCosplayBattleFailView:UIName()
	return "Widget/System/Summer2024/Summer2024_MonsterPlayUI/Summer2024_MonsterPlayBattleResultLoseUI"
end

function MonsterCosplayBattleFailView:AddUIListener()
	MonsterCosplayBattleFailView.super.AddUIListener(self)
	self.btnMask_.onClick:RemoveAllListeners()
	self:AddBtnListener(self.btnMask_, nil, function()
		self:Back(false, function()
			return
		end)
	end)
	self.btnController:SetSelectedState("2btn")
end

function MonsterCosplayBattleFailView:OnEnter()
	self.stageData_ = self.params_.stageData
	self.stageID_ = self.stageData_:GetStageId()
	self.stageType_ = self.stageData_:GetType()

	BattleInstance.hideBattlePanel()
	self:RebuildUI()
end

function MonsterCosplayBattleFailView:RebuildUI()
	self:ChangeStyle()
	self:RefreshRecommendType()
	self:RefreshRecommendLevel()

	local var_6_0 = {
		GetTips("BATTLE_TOTAL_TIME"),
		": "
	}

	var_6_0[3] = self:GetBattleTime() or "00"
	self.battleTimeText_.text = table.concat(var_6_0)
	self.titleTxt_.text = BattleStageTools.GetStageName(self.stageType_, self.stageID_)

	local var_6_1 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_)
end

return MonsterCosplayBattleFailView
