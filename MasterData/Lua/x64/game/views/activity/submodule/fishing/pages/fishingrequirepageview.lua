local FishingRequirePageView = class("FishingRequirePageView", ReduxView)

function FishingRequirePageView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function FishingRequirePageView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FishingRequirePageView:InitUI()
	self:BindCfgUI()

	self.requireList_ = LuaList.New(handler(self, self.indexRequireItem), self.requireListGo_, FishIcon)
	self.currentList_ = LuaList.New(handler(self, self.indexCurrentItem), self.currentListGo_, FishIcon)
end

function FishingRequirePageView:indexRequireItem(arg_4_1, arg_4_2)
	arg_4_2:RegisterClickListener(function(arg_5_0)
		self:SwitchSelect(arg_5_0)
	end)
	arg_4_2:SetId(RareFishCfg.all[arg_4_1])

	if table.indexof(self.currentRequireDataList_, RareFishCfg.all[arg_4_1]) then
		arg_4_2:SetSelected(true)
	else
		arg_4_2:SetSelected(false)
	end
end

function FishingRequirePageView:SwitchSelect(arg_6_1)
	local var_6_0 = table.indexof(self.currentRequireDataList_, arg_6_1)

	if var_6_0 then
		table.remove(self.currentRequireDataList_, var_6_0)
	else
		if #self.currentRequireDataList_ >= 3 then
			return
		end

		table.insert(self.currentRequireDataList_, arg_6_1)
	end

	self.requireList_:Refresh()
end

function FishingRequirePageView:indexCurrentItem(arg_7_1, arg_7_2)
	arg_7_2:SetId(self.currentRequireDataList_[arg_7_1])
end

function FishingRequirePageView:AddUIListener()
	self:AddBtnListener(self.setBtn_, nil, function()
		FishingAction.UpdateRequest(ActivityConst.SUMMER_FISHING, self.currentRequireDataList_)
	end)
end

function FishingRequirePageView:AddEventListeners()
	self:RegistEventListener(FISHING_REQUEST_CHANGE, function()
		self.currentRequireDataList_ = FishingData:GetActivityData().request_infos

		self.requireList_:StartScroll(#RareFishCfg.all)
		self.currentList_:StartScroll(#self.currentRequireDataList_)
	end)
end

function FishingRequirePageView:OnTop()
	self:UpdateBar()
end

function FishingRequirePageView:UpdateBar()
	return
end

function FishingRequirePageView:OnEnter()
	self:AddEventListeners()

	self.currentRequireDataList_ = FishingData:GetActivityData().request_infos

	self.requireList_:StartScroll(#RareFishCfg.all)
	self.currentList_:StartScroll(#self.currentRequireDataList_)
end

function FishingRequirePageView:OnExit()
	self:RemoveAllEventListener()
end

function FishingRequirePageView:OnMainHomeViewTop()
	return
end

function FishingRequirePageView:Dispose()
	if self.requireList_ then
		self.requireList_:Dispose()

		self.requireList_ = nil
	end

	if self.currentList_ then
		self.currentList_:Dispose()

		self.currentList_ = nil
	end

	FishingRequirePageView.super.Dispose(self)
end

return FishingRequirePageView
