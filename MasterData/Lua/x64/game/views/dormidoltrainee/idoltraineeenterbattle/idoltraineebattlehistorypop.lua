local IdolTraineeBattleHistoryPop = class("IdolTraineeBattleHistoryPop", ReduxView)

function IdolTraineeBattleHistoryPop:UIName()
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleHistoryPopup"
end

function IdolTraineeBattleHistoryPop:UIParent()
	return manager.ui.uiPop.transform
end

function IdolTraineeBattleHistoryPop:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolTraineeBattleHistoryPop:InitUI()
	self:BindCfgUI()

	self.historyList_ = LuaList.New(handler(self, self.refreshItem), self.questList_, IdolTraineeBattleHistoryItem)
end

function IdolTraineeBattleHistoryPop:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function IdolTraineeBattleHistoryPop:OnEnter()
	self.dataList = {}

	for iter_7_0, iter_7_1 in pairs((IdolTraineeData:GetHistoryBattleData())) do
		table.insert(self.dataList, iter_7_1)
	end

	CommonTools.UniversalSortEx(self.dataList, {
		map = function(self)
			return self.startTime
		end
	})
	self:RefreshView()
end

function IdolTraineeBattleHistoryPop:RefreshView()
	self.historyList_:StartScroll(#self.dataList)
end

function IdolTraineeBattleHistoryPop:refreshItem(arg_10_1, arg_10_2)
	arg_10_2:RefreshUI(self.dataList[arg_10_1])
end

function IdolTraineeBattleHistoryPop:OnExit()
	self.dataList = nil
end

function IdolTraineeBattleHistoryPop:Dispose()
	if self.historyList_ then
		self.historyList_:Dispose()
	end

	IdolTraineeBattleHistoryPop.super.Dispose(self)
end

return IdolTraineeBattleHistoryPop
