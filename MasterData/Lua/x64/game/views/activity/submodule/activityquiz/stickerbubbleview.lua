local StickerBubbleView = class("StickerBubbleView", ReduxView)

function StickerBubbleView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function StickerBubbleView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function StickerBubbleView:InitUI()
	self:BindCfgUI()

	self.bubbles_ = {}
end

function StickerBubbleView:AddUIListeners()
	return
end

function StickerBubbleView:OnEnter()
	return
end

function StickerBubbleView:RefreshBubbleView(arg_6_1, arg_6_2)
	self:GetBubble(arg_6_1):SetData(arg_6_1, arg_6_2)
end

function StickerBubbleView:GetBubble(arg_7_1)
	local var_7_0 = self.bubbles_[arg_7_1]

	if not self.bubbles_[arg_7_1] then
		var_7_0 = StickerBubbleItem.New((GameObject.Instantiate(self.bubbleTemplate_, self.transform_)))
		self.bubbles_[arg_7_1] = var_7_0
	end

	return var_7_0
end

function StickerBubbleView:OnExit()
	self:RemoveAllEventListener()

	for iter_8_0, iter_8_1 in pairs(self.bubbles_) do
		iter_8_1:OnExit()
	end
end

function StickerBubbleView:Dispose()
	self:RemoveAllListeners()

	for iter_9_0, iter_9_1 in pairs(self.bubbles_) do
		iter_9_1:Dispose()
	end

	self.bubbles_ = {}

	self.super.Dispose(self)
end

return StickerBubbleView
