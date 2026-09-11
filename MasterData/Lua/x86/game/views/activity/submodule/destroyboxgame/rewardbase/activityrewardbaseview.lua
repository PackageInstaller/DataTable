local ActivityRewardBaseView = class("ActivityRewardBaseView", ReduxView)

ActivityRewardBaseView.OBJECT_TYPE = {
	ITEM = 2,
	TITLE = 1
}

function ActivityRewardBaseView:UIName()
	return ""
end

function ActivityRewardBaseView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityRewardBaseView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.refreshHandler_ = handler(self, self.OnUpdateUI)
	self.loopScrollView_ = LoopScrollView.New(self, self.scrollRectEx_, self.gridTrs_, self.contentTf_, self.contentTf_.rect.height, self.gridTrs_:GetComponent("VerticalLayoutGroup").spacing, true)
	self.titleItemPool_ = {}
	self.taskItemPool_ = {}
	self.receiveAllController_ = self.controllerEx_:GetController("receiveAll")
end

function ActivityRewardBaseView:OnEnter()
	self:InitData()
	self:RefreshUI()
	manager.notify:RegistListener(ACTIVITY_REWARD_REFRESH, self.refreshHandler_)
end

function ActivityRewardBaseView:OnExit()
	manager.notify:RemoveListener(ACTIVITY_REWARD_REFRESH, self.refreshHandler_)
end

function ActivityRewardBaseView:Dispose()
	self.refreshHandler_ = nil

	for iter_6_0, iter_6_1 in ipairs(self.titleItemPool_) do
		iter_6_1.itemView:Dispose()
	end

	self.titleItemPool_ = nil

	for iter_6_2, iter_6_3 in ipairs(self.taskItemPool_) do
		iter_6_3.itemView:Dispose()
	end

	self.taskItemPool_ = nil

	self.loopScrollView_:Dispose()

	self.loopScrollView_ = nil

	ActivityRewardBaseView.super.Dispose(self)
end

function ActivityRewardBaseView:AddListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		self:OnClickReceiveBtn()
	end)
end

function ActivityRewardBaseView:RefreshUI()
	self:RefreshText()
	self:RefreshScroll()
end

function ActivityRewardBaseView:RefreshScroll()
	self.loopScrollView_:NavigateIndex(1)
end

function ActivityRewardBaseView:RefreshText()
	self.getLabel1_.text = self:GetFinishRewardCnt()

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.getLabel1_.transform)

	self.getLabel2_.text = string.format("/%s", self:GetMaxTaskCnt())

	if #self.canReceiveRewardList_ > 0 then
		self.receiveAllController_:SetSelectedState("true")
	else
		self.receiveAllController_:SetSelectedState("false")
	end
end

function ActivityRewardBaseView:GetUnReceiveData()
	return
end

function ActivityRewardBaseView:OnUpdateUI()
	self:GetUnReceiveData()
	self:RefreshText()

	for iter_14_0, iter_14_1 in ipairs(self.loopScrollView_:GetItemList()) do
		iter_14_1.itemView:Update()
	end
end

function ActivityRewardBaseView:InitData()
	self.uiDataList_ = {}
end

function ActivityRewardBaseView:GetMaxTaskCnt()
	return 0
end

function ActivityRewardBaseView:GetFinishRewardCnt()
	return 0
end

function ActivityRewardBaseView:GetTaskItemClass()
	return ActivityRewardItemBase
end

function ActivityRewardBaseView:OnClickReceiveBtn()
	return
end

function ActivityRewardBaseView:LsAddItem(arg_20_1, arg_20_2)
	local var_20_0 = arg_20_1.objectType == ActivityRewardBaseView.OBJECT_TYPE.TITLE and self:GetFreeItem(self.titleItemPool_, function()
		return ActivityRewardTitleItem.New(self.titleItem_, self.parent_)
	end) or self:GetFreeItem(self.taskItemPool_, function()
		return self:GetTaskItemClass().New(self.taskItem_, self.parent_)
	end)

	var_20_0.itemView:SetData(arg_20_1.data, arg_20_2)

	return var_20_0
end

function ActivityRewardBaseView:LsRemoveItem(arg_23_1, arg_23_2)
	arg_23_1.itemView:Show(false)

	arg_23_1.isFree = true
end

function ActivityRewardBaseView:LsGetItemData()
	return self.uiDataList_
end

function ActivityRewardBaseView:GetFreeItem(arg_25_1, arg_25_2)
	for iter_25_0, iter_25_1 in pairs(arg_25_1) do
		if iter_25_1.isFree == true then
			iter_25_1.isFree = false

			return iter_25_1
		end
	end

	local var_25_0 = {
		isFree = false,
		itemView = arg_25_2()
	}

	table.insert(arg_25_1, var_25_0)

	return var_25_0
end

return ActivityRewardBaseView
