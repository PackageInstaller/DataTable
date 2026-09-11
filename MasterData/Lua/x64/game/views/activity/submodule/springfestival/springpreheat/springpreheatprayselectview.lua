local SpringPreheatPraySelectView = class("SpringPreheatPraySelectView", ReduxView)

function SpringPreheatPraySelectView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeWishSelUI"
end

function SpringPreheatPraySelectView:UIParent()
	return manager.ui.uiPop.transform
end

function SpringPreheatPraySelectView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.itemUiList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, SpringPreheatPrayRewardItem)
	self.selectController_ = ControllerUtil.GetController(self.transform_, "Notoptional")
	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")

	self.stateController_:SetSelectedState("select")

	self.branch_ = SpringPreheatPrayBubbleView.New(self.branchGo_)
end

function SpringPreheatPraySelectView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:OnClickCancelBtn()
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:OnClickCancelBtn()
	end)
	self:AddBtnListener(self.confirmBtn_, nil, function()
		self:OnClickConfirmBtn()
	end)
end

function SpringPreheatPraySelectView:OnEnter()
	self.day_ = SpringPreheatData:GetNextSelectionIndex()

	self.branch_:SetData(self.day_)
	self.branch_:SetClickHandler(function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		self:OnClickBubble(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	end)
	self.branch_:OnEnter()

	self.itemIdList_ = self:GetSortedList()

	self.itemUiList_:StartScroll(#self.itemIdList_)
	self:ResetSelectItems()
	self.selectController_:SetSelectedState("no")
	self:RefreshUI()
end

function SpringPreheatPraySelectView:OnExit()
	for iter_10_0, iter_10_1 in ipairs(self.itemUiList_:GetItemList()) do
		iter_10_1:OnExit()
	end

	self.branch_:OnExit()
end

function SpringPreheatPraySelectView:Dispose()
	self.itemUiList_:Dispose()
	self.branch_:Dispose()
	SpringPreheatPraySelectView.super.Dispose(self)
end

function SpringPreheatPraySelectView:IndexItem(arg_12_1, arg_12_2)
	arg_12_2:SetClickHandler(function(arg_13_0)
		self:OnClickRewardItem(arg_12_1, arg_13_0)
	end)
	arg_12_2:SwitchToSelecting()
	arg_12_2:SetSelectable(not SpringPreheatData:IsSelected(self.itemIdList_[arg_12_1]))
	arg_12_2:SetSelected(false)
	arg_12_2:SetData(self.itemIdList_[arg_12_1])
end

function SpringPreheatPraySelectView:RefreshUI()
	self.branch_:UpdateItemIdList((self:GetSelectRewardList()))
	self.branch_:RefreshItemUiList()

	self.tipsText_.text = GetTips(string.format("SPRING_PREHEAT_EDIT_REWARD_DAY_%d", self.day_))
	self.selectNumText_.text = string.format("%d/%d", self.selectedCount, self.params_.maxSelectCount)
end

function SpringPreheatPraySelectView:OnClickRewardItem(arg_15_1, arg_15_2)
	if self.itemSelected[arg_15_1] then
		arg_15_2:SetSelected(false)
		self:RemoveSelectItem(arg_15_1)
	elseif self.selectedCount >= self.params_.maxSelectCount then
		ShowTips("SPRING_PREHEAT_SELECT_CONDITION")
	elseif not SpringPreheatData:IsSelected(self.itemIdList_[arg_15_1]) then
		arg_15_2:SetSelected(true)
		self:AddSelectItem(arg_15_1)
	end

	self.selectController_:SetSelectedState(self.selectedCount >= self.params_.maxSelectCount and "yes" or "no")
	arg_15_2:RefreshUI()
	self:RefreshUI()
end

function SpringPreheatPraySelectView:OnClickCancelBtn()
	if self.isAniPlaying_ then
		return
	end

	self:Back()
end

function SpringPreheatPraySelectView:OnClickConfirmBtn()
	if self.selectedCount ~= 2 then
		ShowTips("SPRING_PREHEAT_SELECT_CONDITION")

		return
	end

	self:TryUploadSelection()
end

function SpringPreheatPraySelectView:TryUploadSelection()
	local var_18_0 = self:GetSelectRewardList()

	if #var_18_0 ~= 2 then
		ShowTips("SPRING_PREHEAT_SELECT_CONDITION")

		return
	end

	if self.isAniPlaying_ then
		return
	end

	SpringPreheatAction:UploadPraySelection(SpringPreheatData:GetNextSelectionIndex(), var_18_0, function()
		self:PlayEffect(function()
			if self.params_.onSelectionConfirmed then
				self.params_.onSelectionConfirmed(var_18_0)
			end

			self:Back()
		end)
	end)
end

function SpringPreheatPraySelectView:GetSortedList()
	local var_21_0 = SpringPreheatData:GetPoolItemList()
	local var_21_1 = SpringPreheatData:GetPraySelectionFullList()

	table.sort(var_21_0, function(arg_22_0, arg_22_1)
		local var_22_0 = SpringPreheatData:IsSelected(arg_22_0)
		local var_22_1 = SpringPreheatData:IsSelected(arg_22_1)

		if var_22_0 and var_22_1 then
			return table.indexof(var_21_1, arg_22_0) < table.indexof(var_21_1, arg_22_1)
		elseif var_22_0 or var_22_1 then
			return not var_22_0
		end

		return arg_22_0 < arg_22_1
	end)

	return var_21_0
end

function SpringPreheatPraySelectView:AddSelectItem(arg_23_1)
	self.itemSelected[arg_23_1] = true
	self.selectedCount = self.selectedCount + 1

	table.insert(self.selectIndexList_, arg_23_1)
end

function SpringPreheatPraySelectView:RemoveSelectItem(arg_24_1)
	self.itemSelected[arg_24_1] = false
	self.selectedCount = self.selectedCount - 1

	table.removebyvalue(self.selectIndexList_, arg_24_1)
end

function SpringPreheatPraySelectView:ResetSelectItems()
	self.itemSelected = {}
	self.selectedCount = 0

	for iter_25_0, iter_25_1 in ipairs(self.itemIdList_) do
		self.itemSelected[iter_25_0] = false
	end

	self.selectIndexList_ = {}
end

function SpringPreheatPraySelectView:GetSelectRewardList()
	local var_26_0 = SpringPreheatData:GetPoolItemList()
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in ipairs(self.selectIndexList_) do
		table.insert(var_26_1, var_26_0[iter_26_1])
	end

	for iter_26_2 = #var_26_1 + 1, self.params_.maxSelectCount do
		table.insert(var_26_1, 0)
	end

	return var_26_1
end

function SpringPreheatPraySelectView:OnClickBubble(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	if arg_27_4 then
		ShowPopItem(POP_ITEM, {
			(arg_27_3:GetItemId())
		})
	end
end

function SpringPreheatPraySelectView:PlayEffect(arg_28_1)
	if self.selectAni_ then
		self.isAniPlaying_ = true

		self.selectAni_:Play("IndiaWishingTreeWishSelUI02", -1, 0)
		self.selectAni_:Update(0)
		AnimatorTools.PlayAnimationWithCallback(self.selectAni_, "IndiaWishingTreeWishSelUI02", function()
			self.isAniPlaying_ = false

			arg_28_1()
		end)
	else
		arg_28_1()
	end
end

return SpringPreheatPraySelectView
