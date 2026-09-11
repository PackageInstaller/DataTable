local PushBoxResultView = class("PushBoxResultView", ReduxView)

function PushBoxResultView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/BoxGameResultPopup"
end

function PushBoxResultView:UIParent()
	return manager.ui.uiPop.transform
end

function PushBoxResultView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function PushBoxResultView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, CommonItem)
end

function PushBoxResultView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshData(formatReward(self.list_[arg_5_1]))
end

function PushBoxResultView:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("/activityPushBoxMaterial", {
			activityID = self.params_.activityID
		})
	end)
end

function PushBoxResultView:OnEnter()
	self.list_ = self.params_.rewardList

	self.scrollHelper_:StartScroll(#self.list_)
	SetActive(self.rewardPanel_, #self.list_ > 0)
end

function PushBoxResultView:OnExit()
	for iter_9_0, iter_9_1 in ipairs(self.scrollHelper_:GetItemList()) do
		iter_9_1:OnExit()
	end
end

function PushBoxResultView:Dispose()
	self:RemoveAllListeners()

	for iter_10_0, iter_10_1 in ipairs(self.scrollHelper_:GetItemList()) do
		iter_10_1:Dispose()
	end

	self.scrollHelper_:Dispose()
	self.super.Dispose(self)
end

return PushBoxResultView
