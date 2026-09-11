local EquipBreakThroughResultView = class("EquipBreakThroughResultView", ReduxView)

function EquipBreakThroughResultView:UIName()
	return "UI/Stage/EquipBreakThroughMaterial/EquipChapterMapSettlementUI"
end

function EquipBreakThroughResultView:UIParent()
	return manager.ui.uiMain.transform
end

function EquipBreakThroughResultView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.heroView_ = EquipBreakThroughResultHeroView.New(self.heroPanel_)
	self.resultInfoView_ = EquipBreakThroughResultInfoView.New(self.infoPanel_)

	LeanTween.alphaCanvas(self.maskCanvas_, 0, 0.1)
	self:AddTimer()
end

function EquipBreakThroughResultView:OnEnter()
	self.stageData_ = self.params_.stageData

	BattleInstance.hideBattlePanel()

	if self.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				self:CloseFunc()
			end
		})
	end

	self.heroView_:SetData(self.stageData_)
	self.resultInfoView_:SetData(self.stageData_)
end

function EquipBreakThroughResultView:OnExit()
	self.heroView_:OnExit()
	self.resultInfoView_:OnExit()
end

function EquipBreakThroughResultView:Dispose()
	EquipBreakThroughResultView.super.Dispose(self)
	self.heroView_:Dispose()

	self.heroView_ = nil

	self.resultInfoView_:Dispose()

	self.resultInfoView_ = nil
end

function EquipBreakThroughResultView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.stasticsBtn_, nil, function()
		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = self.stageData,
			battleTime = self:GetBattleTime()
		})
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:EndAnimator()
	end)
end

function EquipBreakThroughResultView:CloseFunc()
	BattleInstance.QuitBattle(self.stageData_)
end

function EquipBreakThroughResultView:GetBattleTime()
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function EquipBreakThroughResultView:EndAnimator()
	self:StopTimer()

	self.maskCanvas_.blocksRaycasts = false
end

function EquipBreakThroughResultView:AddTimer()
	self:StopTimer()

	self.timer_ = Timer.New(function()
		self:EndAnimator()
	end, 1, 1)

	self.timer_:Start()
end

function EquipBreakThroughResultView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()
	end
end

return EquipBreakThroughResultView
