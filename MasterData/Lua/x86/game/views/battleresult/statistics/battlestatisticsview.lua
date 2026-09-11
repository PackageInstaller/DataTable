local BattleStatisticsView = class("BattleStatisticsView", ReduxView)

function BattleStatisticsView:UIName()
	return "Widget/System/MatrixlUI/BattleStatisticsUI"
end

function BattleStatisticsView:UIParent()
	return manager.ui.uiMain.transform
end

function BattleStatisticsView:Init()
	self:InitUI()
	self:AddListeners()
	SetActive(self.goShare_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
end

function BattleStatisticsView:OnEnter()
	self.stageData = self.params_.stageData
	self.statisticsHeroItem_ = {}

	local var_4_0, var_4_1, var_4_2 = BattleTools.GetBattleStatisticsData()
	local var_4_3 = LuaExchangeHelper.GetBattleStatisticsData()
	local var_4_4

	if var_4_3 then
		var_4_4 = var_4_3.dataForLua.currentHPHero or {}
	end

	local var_4_5 = self.stageData:GetHeroTeam()
	local var_4_6 = 0

	for iter_4_0, iter_4_1 in ipairs(var_4_5) do
		if iter_4_1 ~= 0 then
			var_4_6 = var_4_6 + 1
		end
	end

	local var_4_7 = var_4_4.Count or 0

	if var_4_7 ~= var_4_6 then
		print("special handling Battle Statistics")

		for iter_4_2 = 1, 3 do
			self.statisticsHeroItem_[iter_4_2] = iter_4_2 <= var_4_7 and self:GetStatisticsItem().New(self.heroItem_[iter_4_2], self.stageData:GetHeroDataByPos((table.indexof(var_4_5, var_4_4[iter_4_2 - 1]))), var_4_1, var_4_2, var_4_0[iter_4_2]) or self:GetStatisticsItem().New(self.heroItem_[iter_4_2], nil, var_4_1, var_4_2, var_4_0[iter_4_2])
		end
	else
		for iter_4_3 = 1, 3 do
			self.statisticsHeroItem_[iter_4_3] = self:GetStatisticsItem().New(self.heroItem_[iter_4_3], self.stageData:GetHeroDataByPos(iter_4_3), var_4_1, var_4_2, var_4_0[iter_4_3])
		end
	end

	self:SetLevelTitle()
	self:RefreshTimeText()

	if self.params_.battleResult ~= nil and self.params_.battleResult.errorCode ~= nil and self.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				self:CloseFunc()
			end
		})
	end
end

function BattleStatisticsView:CloseFunc()
	BattleInstance.QuitBattle(self.stageData)
end

function BattleStatisticsView:OnExit()
	for iter_7_0, iter_7_1 in pairs(self.statisticsHeroItem_) do
		iter_7_1:Dispose()
	end

	self.statisticsHeroItem_ = nil
end

function BattleStatisticsView:Dispose()
	self:RemoveListeners()
	BattleStatisticsView.super.Dispose(self)
end

function BattleStatisticsView:InitUI()
	self:BindCfgUI()

	self.heroItem_ = {}

	for iter_9_0 = 1, 3 do
		self.heroItem_[iter_9_0] = self["hero" .. iter_9_0]
	end
end

function BattleStatisticsView:GetStatisticsItem()
	return BattleStatisticsHeroItem
end

function BattleStatisticsView:SetLevelTitle(arg_11_1)
	local var_11_0 = self.stageData:GetStageId()
	local var_11_1 = self.stageData:GetType()

	self.lvText_.text = BattleStageTools.GetStageName(var_11_1, var_11_0)

	local var_11_2, var_11_3 = BattleStageTools.GetChapterSectionIndex(var_11_1, var_11_0)

	self.stareText_.text = var_11_2 ~= "" and string.format("%s-%s", GetI18NText(var_11_2), GetI18NText(var_11_3)) or ""

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.titleTransform_)
end

function BattleStatisticsView:RefreshTimeText()
	SetActive(self.battleTimeGo_, self.params_.battleTime ~= nil)

	if not self.params_.battleTime then
		return
	end

	self.battleTimeText_.text = self.params_.battleTime
end

function BattleStatisticsView:AddListeners()
	self:AddBtnListener(self.backBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.buttonShare_, nil, function()
		manager.share:Share(function()
			SetActive(self.goShare_, false)
			SetActive(self.goBack_, false)
		end, function()
			SetActive(self.goShare_, true)
			SetActive(self.goBack_, true)
		end)
	end)
end

function BattleStatisticsView:RemoveListeners()
	self.backBtn_.onClick:RemoveAllListeners()
end

return BattleStatisticsView
