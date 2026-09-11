local SummerWaterBattleStatisticsView = class("SummerWaterBattleStatisticsView", ReduxView)

function SummerWaterBattleStatisticsView:UIName()
	return "Widget/System/Formation/Cooperation/CooperationStatisticsUI"
end

function SummerWaterBattleStatisticsView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerWaterBattleStatisticsView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SummerWaterBattleStatisticsView:InitUI()
	self:BindCfgUI()

	self.staticHeroItemList = {}

	for iter_4_0 = 1, 3 do
		table.insert(self.staticHeroItemList, (SummerWaterBattleStatisticsHeroItem.New(self["hero" .. iter_4_0])))
	end
end

function SummerWaterBattleStatisticsView:AddUIListener()
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

function SummerWaterBattleStatisticsView:OnEnter()
	self.stageData = self.params_.stageData

	local var_10_0, var_10_1, var_10_2 = BattleTools.GetBattleStatisticsData()
	local var_10_3, var_10_4 = self.stageData:GetIsCooperation()

	for iter_10_0, iter_10_1 in ipairs(var_10_4) do
		for iter_10_2, iter_10_3 in ipairs(iter_10_1.heroList) do
			self.staticHeroItemList[1]:SetIsCooperation(var_10_3)
			self.staticHeroItemList[1]:SetCustomStaticData((ActivitySummerWaterData:GetSettlePlayer(ActivitySummerWaterData:GetMainActivityID(), iter_10_1.playerID)))
			self.staticHeroItemList[1]:SetData(iter_10_1, iter_10_3, var_10_0[1], var_10_2)
		end
	end

	self.staticHeroItemList[1]:SetCaptain(not var_10_3)

	self.battleTimeText_.text = GetTips("BATTLE_TOTAL_TIME") .. ":" .. self.params_.battleTime
end

function SummerWaterBattleStatisticsView:OnExit()
	return
end

function SummerWaterBattleStatisticsView:Dispose()
	for iter_12_0, iter_12_1 in ipairs(self.staticHeroItemList) do
		iter_12_1:Dispose()
	end

	self.staticHeroItemList = {}

	SummerWaterBattleStatisticsView.super.Dispose(self)
end

function SummerWaterBattleStatisticsView:OnCooperationRoomInit()
	for iter_13_0, iter_13_1 in ipairs(self.staticHeroItemList) do
		iter_13_1:RefreshState()
	end
end

function SummerWaterBattleStatisticsView:OnCooperationRoomUpdate()
	for iter_14_0, iter_14_1 in ipairs(self.staticHeroItemList) do
		iter_14_1:RefreshState()
	end
end

return SummerWaterBattleStatisticsView
