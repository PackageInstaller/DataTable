NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local NewBattleMythicFinalResultView = class("NewBattleMythicFinalResultView", NewBattleSettlementView)

function NewBattleMythicFinalResultView:AddListener()
	NewBattleMythicFinalResultView.super.AddListener(self)
	self:AddBtnListener(self.confirm2Btn_, nil, function()
		BattleInstance.TryNextBattle(self.stageData)
	end)
	self:AddBtnListener(self.restartBtn_, nil, function()
		self:RestartFunc()
	end)
	self:AddBtnListener(self.exitBtn_, nil, function()
		BattleInstance.QuitBattle(self.stageData)
	end)
end

function NewBattleMythicFinalResultView:RestartFunc()
	ShowMessageBox({
		content = GetTips("MYTHIC_FINAL_LEVEL_RETRY"),
		OkCallback = function()
			BattleInstance.OnceMoreBattle(self.stageData)
		end
	})
end

function NewBattleMythicFinalResultView:onRenderBlackRegionContent()
	self.blackRegionView = self.blackRegionView or BattleSettlementBlackRegionModule.New(self.contentContainer_)

	self.blackRegionView:RenderView({
		stageData = self.stageData
	})
end

function NewBattleMythicFinalResultView:ShowContent()
	self:onRenderBlackRegionContent()
end

function NewBattleMythicFinalResultView:PostRenderView()
	if self.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				BattleInstance.TryNextBattle(self.stageData)
			end
		})
	end

	self.btnController:SetSelectedState("blackzone")

	if #MythicData:GetCurLevelIdList() > 1 and self.stageData:GetDest() < #MythicData:GetCurLevelIdList() then
		SetActive(self.exitBtn_.gameObject, true)
	else
		SetActive(self.exitBtn_.gameObject, false)
	end
end

function NewBattleMythicFinalResultView:RenderTitleView()
	SetActive(self.titleObj_, true)

	self.titleTxt_.text = string.format(GetTips("MYTHIC_FINAL_LEVEL"), MythicData:GetCurHotLevelId())
end

function NewBattleMythicFinalResultView:Dispose()
	self.blackRegionView:Dispose()
	NewBattleMythicFinalResultView.super.Dispose(self)
end

return NewBattleMythicFinalResultView
