local FishingGivePopView = class("FishingGivePopView", ReduxView)

function FishingGivePopView:UIName()
	return "UI/Fishing/FishingGivePopUI"
end

function FishingGivePopView:UIParent()
	return manager.ui.uiPop.transform
end

function FishingGivePopView:OnCtor()
	return
end

function FishingGivePopView:Init()
	self.curId_ = 0

	self:InitUI()
	self:AddUIListener()
end

function FishingGivePopView:InitUI()
	self:BindCfgUI()

	self.currentList_ = LuaList.New(handler(self, self.indexCurrentItem), self.currentListGo_, FishIcon)
	self.requireList_ = LuaList.New(handler(self, self.indexRequireItem), self.requireListGo_, FishIcon)
end

function FishingGivePopView:indexCurrentItem(arg_6_1, arg_6_2)
	arg_6_2:RegisterClickListener(function(arg_7_0)
		self:SwitchSelect(arg_7_0)
	end)

	if self.curId_ == self.fishDataList_[arg_6_1].id then
		arg_6_2:SetSelected(true)
	else
		arg_6_2:SetSelected(false)
	end

	arg_6_2:SetId(self.fishDataList_[arg_6_1].id, self.fishDataList_[arg_6_1].num)
end

function FishingGivePopView:indexRequireItem(arg_8_1, arg_8_2)
	arg_8_2:SetId(self.params_.data.fishList[arg_8_1])
end

function FishingGivePopView:SwitchSelect(arg_9_1)
	self.curId_ = arg_9_1

	self.currentList_:Refresh()
end

function FishingGivePopView:AddUIListener()
	self:AddBtnListener(self.giveBtn_, nil, function()
		if self.curId_ ~= 0 then
			FishingAction.GiveRareFish(ActivityConst.SUMMER_FISHING, self.curId_, self.params_.data.friendId, function()
				self:Back()
			end)
		end
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function FishingGivePopView:AddEventListeners()
	return
end

function FishingGivePopView:OnTop()
	self:UpdateBar()
end

function FishingGivePopView:UpdateBar()
	return
end

function FishingGivePopView:OnEnter()
	self:AddEventListeners()

	self.fishDataList_ = {}

	for iter_19_0, iter_19_1 in pairs(FishingData:GetActivityData().fish_infos) do
		if iter_19_1.num > 0 then
			table.insert(self.fishDataList_, iter_19_1)
		end
	end

	self:UpdateView()
end

function FishingGivePopView:OnExit()
	self:RemoveAllEventListener()
end

function FishingGivePopView:UpdateView()
	self.requireList_:StartScroll(#self.params_.data.fishList)
	self.currentList_:StartScroll(#self.fishDataList_)
end

function FishingGivePopView:OnMainHomeViewTop()
	return
end

function FishingGivePopView:Dispose()
	if self.requireList_ then
		self.requireList_:Dispose()

		self.requireList_ = nil
	end

	if self.currentList_ then
		self.currentList_:Dispose()

		self.currentList_ = nil
	end

	FishingGivePopView.super.Dispose(self)
end

return FishingGivePopView
