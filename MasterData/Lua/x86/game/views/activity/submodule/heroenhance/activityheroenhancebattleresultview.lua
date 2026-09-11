NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local ActivityHeroEnhanceBattleResultView = class("ActivityHeroEnhanceBattleResultView", NewBattleSettlementView)

function ActivityHeroEnhanceBattleResultView:InitUI()
	ActivityHeroEnhanceBattleResultView.super.InitUI(self)

	self.firstHeroModule = self.heroModule[1]

	SetActive(self.heroHead2Obj_, false)
	SetActive(self.heroHead3Obj_, false)
end

function ActivityHeroEnhanceBattleResultView:OnAddListner()
	SetActive(self.emptyMaskBtn_.gameObject, true)
	self:AddBtnListener(self.emptyMaskBtn_, nil, function()
		BattleInstance.QuitBattle(self.stageData)
	end)
end

function ActivityHeroEnhanceBattleResultView:onRenderMissionResultContent()
	self.missionView = self.missionView or ActivityHeroEnhanceBattleSettlementModule.New(self.contentContainer_, self.stageData:GetActivityID())

	self.missionView:RenderView({
		stageData = self.stageData,
		rewardList = self.params_.rewardList
	})
end

function ActivityHeroEnhanceBattleResultView:ShowContent()
	self:onRenderMissionResultContent()
end

function ActivityHeroEnhanceBattleResultView:PostRenderView()
	self.btnController:SetSelectedState("nobtn")
end

function ActivityHeroEnhanceBattleResultView:RenderTitleView()
	SetActive(self.titleObj_, true)

	self.titleTxt_.text = GetI18NText(BattleStageTools.GetStageCfg(self.stageType, self.stageId).name)
end

function ActivityHeroEnhanceBattleResultView:Dispose()
	self.missionView:Dispose()
	ActivityHeroEnhanceBattleResultView.super.Dispose(self)
end

return ActivityHeroEnhanceBattleResultView
