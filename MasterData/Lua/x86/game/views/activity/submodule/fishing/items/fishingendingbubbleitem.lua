local FishingEndingBubbleItem = class("FishingEndingBubbleItem", ReduxView)

function FishingEndingBubbleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function FishingEndingBubbleItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function FishingEndingBubbleItem:InitUI()
	return
end

function FishingEndingBubbleItem:AddUIListener()
	return
end

function FishingEndingBubbleItem:AddEventListeners()
	return
end

function FishingEndingBubbleItem:OnEnter()
	self:AddEventListeners()
end

function FishingEndingBubbleItem:OnExit()
	self:RemoveAllEventListener()
end

function FishingEndingBubbleItem:Dispose()
	FishingEndingBubbleItem.super.Dispose(self)
end

return FishingEndingBubbleItem
