local AdvanceTestRewardView = class("AdvanceTestRewardView", ReduxView)

function AdvanceTestRewardView:UIName()
	return "UI/AdvancetestingUI/ATestingRankRewardUI"
end

function AdvanceTestRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function AdvanceTestRewardView:Init()
	self:InitUI()
	self:AddListeners()
end

function AdvanceTestRewardView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, AdvanceTestRewardItemView)
end

function AdvanceTestRewardView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function AdvanceTestRewardView:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_1 == 1 and 1 or ActivityPointRewardCfg[self.taskIdList[arg_7_1 - 1]].need + 1, self.taskIdList[arg_7_1])
end

function AdvanceTestRewardView:OnTop()
	return
end

function AdvanceTestRewardView:OnEnter()
	self.activityID = self.params_.activityID
	self.taskIdList = ActivityPointRewardCfg.get_id_list_by_activity_id[self.activityID]

	self.uiList_:StartScroll(#self.taskIdList)
end

function AdvanceTestRewardView:OnExit()
	return
end

function AdvanceTestRewardView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	AdvanceTestRewardView.super.Dispose(self)
end

return AdvanceTestRewardView
