local SpringPreheatPrayPreviewView = class("SpringPreheatPrayPreviewView", ReduxView)

function SpringPreheatPrayPreviewView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeWishSelUI"
end

function SpringPreheatPrayPreviewView:UIParent()
	return manager.ui.uiPop.transform
end

function SpringPreheatPrayPreviewView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.itemUiList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, SpringPreheatPrayRewardItem)
	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")

	self.stateController_:SetSelectedState("preview")
end

function SpringPreheatPrayPreviewView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function SpringPreheatPrayPreviewView:OnEnter()
	self.itemIdList_ = self:GetSortedList()

	self.itemUiList_:StartScroll(#self.itemIdList_)
	self:RefreshUI()
end

function SpringPreheatPrayPreviewView:OnExit()
	for iter_7_0, iter_7_1 in ipairs(self.itemUiList_:GetItemList()) do
		iter_7_1:OnExit()
	end
end

function SpringPreheatPrayPreviewView:OnTop()
	SetActive(self.gameObject_, true)
end

function SpringPreheatPrayPreviewView:OnBehind()
	SetActive(self.gameObject_, false)
end

function SpringPreheatPrayPreviewView:Dispose()
	self.itemUiList_:Dispose()
	SpringPreheatPrayPreviewView.super.Dispose(self)
end

function SpringPreheatPrayPreviewView:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:SetClickHandler(function(arg_12_0)
		self:OnClickRewardItem(arg_11_1, arg_12_0)
	end)
	arg_11_2:SwitchToSelecting()
	arg_11_2:SetSelectable(not SpringPreheatData:IsSelected(self.itemIdList_[arg_11_1]))
	arg_11_2:SetSelected(false)
	arg_11_2:SetData(self.itemIdList_[arg_11_1])
end

function SpringPreheatPrayPreviewView:RefreshUI()
	return
end

function SpringPreheatPrayPreviewView:OnClickRewardItem(arg_14_1, arg_14_2)
	ShowPopItem(POP_ITEM, {
		(arg_14_2:GetItemId())
	})
end

function SpringPreheatPrayPreviewView:GetSortedList()
	local var_15_0 = SpringPreheatData:GetPoolItemList()
	local var_15_1 = SpringPreheatData:GetPraySelectionFullList()

	table.sort(var_15_0, function(arg_16_0, arg_16_1)
		local var_16_0 = SpringPreheatData:IsSelected(arg_16_0)
		local var_16_1 = SpringPreheatData:IsSelected(arg_16_1)

		if var_16_0 and var_16_1 then
			return table.indexof(var_15_1, arg_16_0) < table.indexof(var_15_1, arg_16_1)
		elseif var_16_0 or var_16_1 then
			return not var_16_0
		end

		return arg_16_0 < arg_16_1
	end)

	return var_15_0
end

return SpringPreheatPrayPreviewView
