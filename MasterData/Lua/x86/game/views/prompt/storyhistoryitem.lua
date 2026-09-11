local StoryHistoryItem = class("StoryHistoryItem", ReduxView)

function StoryHistoryItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
	SetActive(self.voiceBtn_.gameObject, false)
	SetActive(self.gameObject_, true)
end

function StoryHistoryItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function StoryHistoryItem:InitUI()
	self:BindCfgUI()

	self.voiceController_ = self.controller_:GetController("voice")
end

function StoryHistoryItem:AddUIListeners()
	self:AddBtnListener(self.voiceBtn_, nil, function()
		if self.callback_ then
			self:callback_()
		end
	end)
end

function StoryHistoryItem:SetTitle(arg_6_1)
	self.titleText_.text = arg_6_1
end

function StoryHistoryItem:SetContent(arg_7_1)
	self.contentText_.text = arg_7_1
end

function StoryHistoryItem:SetVoiceCallback(arg_8_1)
	self.callback_ = arg_8_1

	if arg_8_1 then
		SetActive(self.voiceBtn_.gameObject, true)
	else
		SetActive(self.voiceBtn_.gameObject, false)
	end
end

function StoryHistoryItem:PlayVoiceAni()
	self.voiceController_:SetSelectedState("play")
end

function StoryHistoryItem:StopVoiceAni()
	self.voiceController_:SetSelectedState("stop")
end

function StoryHistoryItem:Dispose()
	StoryHistoryItem.super.Dispose(self)
end

return StoryHistoryItem
