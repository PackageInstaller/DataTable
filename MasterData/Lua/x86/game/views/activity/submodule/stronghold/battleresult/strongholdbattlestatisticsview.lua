local StrongholdBattleStatisticsView = class("StrongholdBattleStatisticsView", ReduxView)

function StrongholdBattleStatisticsView:UIName()
	return "UI/CooperationBattleResult/CooperationStatisticsUI"
end

function StrongholdBattleStatisticsView:UIParent()
	return manager.ui.uiMain.transform
end

function StrongholdBattleStatisticsView:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrongholdBattleStatisticsView:InitUI()
	self:BindCfgUI()

	self.staticHeroItemList = {}

	for iter_4_0 = 1, 3 do
		table.insert(self.staticHeroItemList, (StrongholdBattleStatisticsHeroItem.New(self["m_hero" .. iter_4_0])))
	end
end

function StrongholdBattleStatisticsView:AddUIListener()
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

function StrongholdBattleStatisticsView:OnEnter()
	self.stageData = self.params_.stageData

	local var_10_0, var_10_1, var_10_2 = BattleTools.GetBattleStatisticsData()
	local var_10_3, var_10_4 = self.stageData:GetIsCooperation()

	for iter_10_0, iter_10_1 in ipairs(self.staticHeroItemList) do
		iter_10_1:SetData(var_10_4[iter_10_0], var_10_0[iter_10_0], var_10_2)
	end

	self.battleTimeText_.text = self.params_.battleTime
end

function StrongholdBattleStatisticsView:OnExit()
	return
end

function StrongholdBattleStatisticsView:Dispose()
	for iter_12_0, iter_12_1 in ipairs(self.staticHeroItemList) do
		iter_12_1:Dispose()
	end

	self.staticHeroItemList = {}

	StrongholdBattleStatisticsView.super.Dispose(self)
end

function StrongholdBattleStatisticsView:OnCooperationRoomInit()
	for iter_13_0, iter_13_1 in ipairs(self.staticHeroItemList) do
		iter_13_1:RefreshState()
	end
end

function StrongholdBattleStatisticsView:OnCooperationRoomUpdate()
	for iter_14_0, iter_14_1 in ipairs(self.staticHeroItemList) do
		iter_14_1:RefreshState()
	end
end

return StrongholdBattleStatisticsView
