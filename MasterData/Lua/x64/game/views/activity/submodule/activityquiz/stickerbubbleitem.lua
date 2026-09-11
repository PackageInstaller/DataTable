local StickerBubbleItem = class("StickerBubbleItem", ReduxView)
local QuizFunction = import("game.quiz.QuizFunction")

function StickerBubbleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function StickerBubbleItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function StickerBubbleItem:InitUI()
	self:BindCfgUI()

	self.isPlaying_ = false
	self.sticker_ = ChatStickerItem.New(self.stickerGo_)
	self.uiFollow_ = self.transform_:GetComponent("UIFollow")
end

function StickerBubbleItem:AddUIListeners()
	return
end

function StickerBubbleItem:OnEnter()
	return
end

function StickerBubbleItem:SetData(arg_6_1, arg_6_2)
	self.sticker_:RefreshData(arg_6_2)
	self:SetSticker(arg_6_1)
	SetActive(self.gameObject_, true)

	self.uiFollow_.enabled = true
	self.isPlaying_ = true

	self:SetTimer()
end

function StickerBubbleItem:SetSticker(arg_7_1)
	local var_7_0 = QuizFunction:GetPlyerModel(arg_7_1):GetAttachEmoji()

	if not var_7_0 then
		return
	end

	self.uiFollow_.origin = var_7_0

	self.uiFollow_:UpdatePos()
end

function StickerBubbleItem:SetTimer()
	self:StopTimer()

	local var_8_0 = 0

	self.timer_ = Timer.New(function()
		var_8_0 = var_8_0 + 1

		if var_8_0 >= 3 then
			SetActive(self.gameObject_, false)

			self.uiFollow_.enabled = false
			self.isPlaying_ = false

			self:StopTimer()
		end
	end, 1, -1)

	self.timer_:Start()
end

function StickerBubbleItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function StickerBubbleItem:OnExit()
	self:StopTimer()
	self.sticker_:OnExit()

	self.isPlaying_ = false

	self:RemoveAllEventListener()
end

function StickerBubbleItem:Dispose()
	self:RemoveAllListeners()
	self.sticker_:Dispose()

	self.sticker_ = nil

	self.super.Dispose(self)
end

return StickerBubbleItem
