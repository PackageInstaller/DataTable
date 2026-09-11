local StoryTextItem = class("StoryTextItem")

function StoryTextItem:Ctor(arg_1_1, arg_1_2)
	self.storyPlayer_ = arg_1_2
	self.gameObject_ = arg_1_1
	self.transform = arg_1_1.transform
	self.text_ = self.gameObject_:GetComponent("Text")
	self.typeWritter_ = self.gameObject_:GetComponent("UITypewriterEffect")
	self.contentID_ = -1
	self.curTiem_ = 0
	self.duration_ = 0
end

function StoryTextItem:SetConfig(arg_2_1)
	self.config_ = arg_2_1
	self.contentID_ = arg_2_1.contentID
end

function StoryTextItem:GetContentID()
	return self.contentID_
end

function StoryTextItem:Init(arg_4_1)
	self.gameObject_ = arg_4_1
	self.transform_ = arg_4_1.transform
end

function StoryTextItem:OnUpdate(arg_5_1, arg_5_2)
	self.curTime_ = arg_5_1
	self.duration_ = arg_5_2

	if self.config_.enableEffect then
		self:UpdateEffect()
	end
end

function StoryTextItem:OnFinish()
	self:FinishEffect()
end

function StoryTextItem:Dispose()
	self.gameObject_ = nil
	self.transform_ = nil
end

function StoryTextItem:UpdateTextProperty()
	if not self.config_.enableTextPropertyChange then
		return
	end

	self.text_.lineSpacing = self.config_.textComProperty.lineSpacing

	if self.config_.textComProperty.fontAssetPath ~= "" then
		self.text_.font = Asset.Load(self.config_.textComProperty.fontAssetPath)
	end

	self.text_.fontSize = self.config_.textComProperty.fontSize
	self.text_.color = self.config_.textComProperty.textColor
	self.text_.alignment = self.config_.textComProperty.textAlignment
end

function StoryTextItem:UpdateContent()
	self.text_.text = self.storyPlayer_:FormatText(self.storyPlayer_:GetWordFromCfg(self.config_.contentID).content)

	LuaForUtil.ClearLinePrefixSymbol(self.text_)
end

function StoryTextItem:UpdateEffect()
	if self.config_.effectData.textEffectType == StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER then
		self:UpdateTypeWriterEffect()
	elseif self.config_.effectData.textEffectType == StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA then
		self:UpdateAlphaEffect()
	end
end

function StoryTextItem:UpdateTypeWriterEffect()
	self.typeWritter_.percent = Mathf.Lerp(0, 1, self.curTime_ / self.duration_)

	self.typeWritter_:SetDirty()
end

function StoryTextItem:UpdateAlphaEffect()
	self.text_.color.a = Mathf.Lerp(self.config_.effectData.startAlpha, self.config_.effectData.endAlpha, self.curTime_ / self.duration_)
	self.text_.color = self.text_.color
end

function StoryTextItem:FinishEffect()
	if self.config_.textEffectType == StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.NONE then
		return
	end

	if self.config_.textEffectType == StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER then
		self:FinishTypeWriterEffect()
	elseif self.config_.textEffectType == StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA then
		self:FinishAlphaEffect()
	end
end

function StoryTextItem:FinishTypeWriterEffect()
	self.typeWritter_.percent = 1

	self.typeWritter_:SetDirty()
end

function StoryTextItem:FinishAlphaEffect()
	self.text_.color.a = self.config_.effectData.endAlpha
	self.text_.color = self.text_.color
end

function StoryTextItem:SetActive(arg_16_1)
	SetActive(self.gameObject_, arg_16_1)
end

return StoryTextItem
