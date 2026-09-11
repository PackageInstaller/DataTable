local FishingGroupPageView = class("FishingGroupPageView", ReduxView)

function FishingGroupPageView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function FishingGroupPageView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FishingGroupPageView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, FishingIllustratedItemView)
end

function FishingGroupPageView:indexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_1, self.fishIdList_[arg_4_1])
end

function FishingGroupPageView:AddUIListener()
	return
end

function FishingGroupPageView:AddEventListeners()
	self:RegistEventListener(CURRENCY_UPDATE, function(arg_7_0)
		if arg_7_0 == 0 or arg_7_0 == CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN then
			self.coinValueLabel_.text = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN)
		end
	end)
	self:RegistEventListener(FISHING_GROUP_REWARD_CHANGE, function()
		self.uiList_:Refresh()
	end)
end

function FishingGroupPageView:OnTop()
	self:UpdateBar()
end

function FishingGroupPageView:UpdateBar()
	return
end

function FishingGroupPageView:OnEnter()
	self:AddEventListeners()
	self:SortData()
	self:UpdateView()
end

function FishingGroupPageView:SortData()
	self.fishIdList_ = RareFishCfg.all

	table.sort(self.fishIdList_, function(arg_13_0, arg_13_1)
		local var_13_0 = FishingData:GetFish(arg_13_0)
		local var_13_1 = FishingData:GetFish(arg_13_1)
		local var_13_2 = RareFishCfg[arg_13_0]
		local var_13_3 = RareFishCfg[arg_13_1]

		if var_13_0 == nil and var_13_1 ~= nil or var_13_0 ~= nil and var_13_1 == nil then
			return var_13_0 ~= nil
		end

		if var_13_2.rare ~= var_13_3.rare then
			return var_13_2.rare > var_13_3.rare
		end

		return var_13_2.id < var_13_3.id
	end)
end

function FishingGroupPageView:UpdateView()
	self:SortData()
	self.uiList_:StartScroll(#self.fishIdList_)

	self.coinValueLabel_.text = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN)
end

function FishingGroupPageView:OnExit()
	self:RemoveAllEventListener()
end

function FishingGroupPageView:OnMainHomeViewTop()
	return
end

function FishingGroupPageView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	FishingGroupPageView.super.Dispose(self)
end

return FishingGroupPageView
