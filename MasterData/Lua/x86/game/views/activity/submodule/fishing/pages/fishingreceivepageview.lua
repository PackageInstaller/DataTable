local FishingReceivePageView = class("FishingReceivePageView", ReduxView)

function FishingReceivePageView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function FishingReceivePageView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FishingReceivePageView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, FishingReceiveItemView)
end

function FishingReceivePageView:indexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(self.receiveDataList_[arg_4_1])
end

function FishingReceivePageView:AddUIListener()
	return
end

function FishingReceivePageView:AddEventListeners()
	self:RegistEventListener(RECEIVE_FISH_CHANGE, function()
		self.receiveDataList_ = FishingData:GetFishReceiveInfo()

		self:UpdateView()
	end)
end

function FishingReceivePageView:OnTop()
	self:UpdateBar()
end

function FishingReceivePageView:UpdateBar()
	return
end

function FishingReceivePageView:OnEnter()
	self:AddEventListeners()
	FishingAction.GetReceiveInfo(ActivityConst.SUMMER_FISHING, function()
		self.receiveDataList_ = FishingData:GetFishReceiveInfo()

		self:UpdateView()
	end)
end

function FishingReceivePageView:OnExit()
	self:RemoveAllEventListener()
end

function FishingReceivePageView:UpdateView()
	self.uiList_:StartScroll(#self.receiveDataList_)
end

function FishingReceivePageView:OnMainHomeViewTop()
	return
end

function FishingReceivePageView:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	FishingReceivePageView.super.Dispose(self)
end

return FishingReceivePageView
