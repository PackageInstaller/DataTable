local SpringPreheatPrayBranchView = class("SpringPreheatPrayBranchView", ReduxView)

function SpringPreheatPrayBranchView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeWishUIRewardsUI"
end

function SpringPreheatPrayBranchView:UIParent()
	return manager.ui.uiPop.transform
end

function SpringPreheatPrayBranchView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.branch_ = SpringPreheatPrayBubbleView.New(self.branchGo_)
end

function SpringPreheatPrayBranchView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function SpringPreheatPrayBranchView:OnEnter()
	self.day_ = self.params_.day or SpringPreheatData:GetNextSelectionIndex()

	self.branch_:SetData(self.day_)
	self.branch_:SetClickHandler(function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		self:OnClickBubble(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	end)
	self.branch_:OnEnter()
	self:RefreshUI()
end

function SpringPreheatPrayBranchView:OnExit()
	self.branch_:OnExit()
end

function SpringPreheatPrayBranchView:OnTop()
	SetActive(self.gameObject_, true)
end

function SpringPreheatPrayBranchView:OnBehind()
	SetActive(self.gameObject_, false)
end

function SpringPreheatPrayBranchView:Dispose()
	self.branch_:Dispose()
	SpringPreheatPrayBranchView.super.Dispose(self)
end

function SpringPreheatPrayBranchView:RefreshUI()
	return
end

function SpringPreheatPrayBranchView:OnClickBubble(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_4 then
		ShowPopItem(POP_ITEM, {
			(arg_13_3:GetItemId())
		})
	end
end

return SpringPreheatPrayBranchView
