local BubbleStep = class("BubbleStep", import(".IslandBaseStep"))

BubbleStep.HIDE_TYPE_IMMEDIATELY = 0
BubbleStep.HIDE_TYPE_NEVER = 1
BubbleStep.HIDE_TYPE_TIME = 2
BubbleStep.EMOJI_TYPE_CHAT = 1
BubbleStep.EMOJI_TYPE_EXPRESSION = 2

function BubbleStep:Ctor(arg_1_1, arg_1_2)
	BubbleStep.super.Ctor(self, arg_1_1, arg_1_2)

	self.emoji = arg_1_1.emoji
	self.emojiType = defaultValue(arg_1_1.emojiType, BubbleStep.EMOJI_TYPE_CHAT)
	self.time = arg_1_1.time or 3
	self.hideType = arg_1_1.hideType or BubbleStep.HIDE_TYPE_IMMEDIATELY
	self.hideTime = arg_1_1.hideTime or 0

	return
end

function BubbleStep:ExistEmoji()
	return self.emoji ~= nil
end

function BubbleStep:GetEmojiType()
	return self.emojiType
end

function BubbleStep:GetEmoji()
	return self.emoji, self.emojiType
end

function BubbleStep:GetHideType()
	return self.hideType, self.hideTime
end

function BubbleStep:GetTime()
	return self.time
end

return BubbleStep
