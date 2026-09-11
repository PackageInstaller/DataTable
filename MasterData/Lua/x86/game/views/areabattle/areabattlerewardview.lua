local AreaBattleRewardView = class("AreaBattleRewardView", ReduxView)

function AreaBattleRewardView:UIName()
	return ActivityAreaBattleData:GetPrefabByActivityID(self.params_.mainActivityID) .. "NormalfightingSeizuresTipsUI"
end

function AreaBattleRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function AreaBattleRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AreaBattleRewardView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.SetListItem), self.uiList_, AreaBattleRewardItem)
	self.controller = self.controller_:GetController("show")
end

function AreaBattleRewardView:SetListItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_1, self.taskList[arg_5_1], self.areaData, self.activityID)
end

function AreaBattleRewardView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.receiveAllBtn_, nil, function()
		AreaBattleAction.GetReward(self.activityID, self.completeTaskList)
	end)
end

function AreaBattleRewardView:UpdateData()
	self.activityID = self.params_.activityID
	self.mainActivityID = self.params_.mainActivityID
	self.completeTaskList = {}
	self.cfg = ActivityAreaBattleCfg[self.activityID]
	self.areaData = ActivityAreaBattleData:GetDataByActivityID(self.mainActivityID)[self.activityID]
	self.taskList = deepClone(self.cfg.reward_list)

	table.sort(self.taskList, function(arg_10_0, arg_10_1)
		return (self.areaData.gotChallengeRewardList[arg_10_0[1]] and 100000 or 1) + arg_10_0[1] / 10000 < (self.areaData.gotChallengeRewardList[arg_10_1[1]] and 100000 or 1) + arg_10_1[1] / 10000
	end)
end

function AreaBattleRewardView:UpdateView()
	self.passtext_.text = string.format(GetTips("ACTIVITY_AREA_BATTLE_REWARD_SUM_POINT"), math.min(self.areaData.allChallengeValue, self.cfg.reward_list[#self.cfg.reward_list][1]) .. "/" .. self.cfg.reward_list[#self.cfg.reward_list][1])

	self.list:StartScroll(#self.cfg.reward_list)

	for iter_11_0, iter_11_1 in ipairs(self.cfg.reward_list) do
		if self.areaData.allChallengeValue >= self.taskList[iter_11_0][1] and self.areaData.gotChallengeRewardList[self.taskList[iter_11_0][1]] ~= true then
			table.insert(self.completeTaskList, self.taskList[iter_11_0][1])
		end
	end

	self.controller:SetSelectedState(tostring(#self.completeTaskList ~= 0))
end

function AreaBattleRewardView:OnEnter()
	self:UpdateData()
	self:UpdateView()
end

function AreaBattleRewardView:OnAreaBattleGetReward()
	self:OnEnter()
end

function AreaBattleRewardView:OnExit()
	self.completeTaskList = nil

	manager.windowBar:HideBar()
end

function AreaBattleRewardView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	AreaBattleRewardView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AreaBattleRewardView
