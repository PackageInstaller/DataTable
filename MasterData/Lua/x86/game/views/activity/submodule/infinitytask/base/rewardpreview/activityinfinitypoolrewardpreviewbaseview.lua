local ActivityInfinityPoolRewardPreviewBaseView = class("ActivityInfinityPoolRewardPreviewBaseView", ReduxView)

function ActivityInfinityPoolRewardPreviewBaseView:UIName()
	return "UI/VersionUI/OsirisUI/OsirisRewardUI"
end

function ActivityInfinityPoolRewardPreviewBaseView:GetRewardPreviewItem()
	return ActivityInfinityPoolRewardPreviewBaseItem
end

function ActivityInfinityPoolRewardPreviewBaseView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityInfinityPoolRewardPreviewBaseView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.mainRewardList_ = {}
	self.normalRewardList_ = {}
end

function ActivityInfinityPoolRewardPreviewBaseView:OnEnter()
	local var_5_0 = OsirisInfinityPoolData:GetPoolData(self.params_.poolID)

	if var_5_0.coreItem == nil then
		SetActive(self.goMainItem_, false)
	else
		SetActive(self.goMainItem_, true)

		for iter_5_0 = 1, 1 do
			local var_5_1 = var_5_0.coreItem

			if self.mainRewardList_[iter_5_0] == nil then
				self.mainRewardList_[iter_5_0] = self:GetRewardPreviewItem().New(self.goItem_, self.goMainParent_, var_5_1, var_5_0.isOpenCoreItem and 1 or 0, 1)
			else
				self.mainRewardList_[iter_5_0]:SetData(var_5_1, var_5_0.isOpenCoreItem and 1 or 0, 1)
			end
		end
	end

	for iter_5_1 = 1, #var_5_0.resultItemList do
		if self.normalRewardList_[iter_5_1] == nil then
			self.normalRewardList_[iter_5_1] = self:GetRewardPreviewItem().New(self.goItem_, self.goNormalParent_, var_5_0.resultItemList[iter_5_1].reward, var_5_0.resultItemList[iter_5_1].cnt, var_5_0.resultItemList[iter_5_1].maxCnt)
		else
			self.normalRewardList_[iter_5_1]:SetData(var_5_0.resultItemList[iter_5_1].reward, var_5_0.resultItemList[iter_5_1].cnt, var_5_0.resultItemList[iter_5_1].maxCnt)
		end
	end

	for iter_5_2 = #var_5_0.resultItemList + 1, #self.normalRewardList_ do
		self.normalRewardList_[iter_5_2]:Show(false)
	end

	self.scrollView_.verticalNormalizedPosition = 1
end

function ActivityInfinityPoolRewardPreviewBaseView:OnExit()
	return
end

function ActivityInfinityPoolRewardPreviewBaseView:Dispose()
	ActivityInfinityPoolRewardPreviewBaseView.super.Dispose(self)

	for iter_7_0, iter_7_1 in pairs(self.mainRewardList_) do
		iter_7_1:Dispose()
	end

	self.mainRewardList_ = nil

	for iter_7_2, iter_7_3 in pairs(self.normalRewardList_) do
		iter_7_3:Dispose()
	end

	self.normalRewardList_ = nil
end

function ActivityInfinityPoolRewardPreviewBaseView:AddListeners()
	self:AddBtnListener(self.btnClose_, nil, function()
		self:Back()
	end)
end

return ActivityInfinityPoolRewardPreviewBaseView
