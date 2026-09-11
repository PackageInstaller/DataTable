local FishingReceiveItemView = class("FishingReceiveItemView", ReduxView)

function FishingReceiveItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function FishingReceiveItemView:Init()
	self:InitUI()
	self:AddUIListener()
	self:AddEventListeners()
end

function FishingReceiveItemView:InitUI()
	self:BindCfgUI()

	self.fishIcon_ = FishIcon.New(self.fishIconGo_)
end

function FishingReceiveItemView:AddUIListener()
	self:AddBtnListener(self.getBtn_, nil, function()
		FishingAction.GetFriendsFish(ActivityConst.SUMMER_FISHING, self.data_.giver_id, self.data_.timestamp)
	end)
end

function FishingReceiveItemView:AddEventListeners()
	return
end

function FishingReceiveItemView:OnTop()
	self:UpdateBar()
end

function FishingReceiveItemView:UpdateBar()
	return
end

function FishingReceiveItemView:SetData(arg_9_1)
	self.data_ = arg_9_1

	self:UpdateView()
end

function FishingReceiveItemView:UpdateView()
	self.playerNameLabel_.text = GetI18NText(self.data_.giver_nick)
	self.playerHeadIcon_.sprite = ItemTools.getItemSprite(self.data_.giver_icon)

	self.fishIcon_:SetId(self.data_.fish_id, 1)
end

function FishingReceiveItemView:OnEnter()
	return
end

function FishingReceiveItemView:OnExit()
	return
end

function FishingReceiveItemView:OnMainHomeViewTop()
	return
end

function FishingReceiveItemView:Dispose()
	self:RemoveAllEventListener()

	if self.fishIcon_ then
		self.fishIcon_:Dispose()

		self.fishIcon_ = nil
	end

	FishingReceiveItemView.super.Dispose(self)
end

return FishingReceiveItemView
