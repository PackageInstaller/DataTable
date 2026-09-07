local GuildChatBubble = class("GuildChatBubble", import(".ChatBubble"))

function GuildChatBubble:init()
	self.nameTF = findTF(self.tf, "name_bg/name"):GetComponent("Text")
	self.face = findTF(self.tf, "face/content")
	self.circle = findTF(self.tf, "shipicon/frame")
	self.timeTF = findTF(self.tf, "time"):GetComponent("Text")
	self.headTF = findTF(self.tf, "shipicon/icon"):GetComponent("Image")
	self.stars = findTF(self.tf, "shipicon/stars")
	self.star = findTF(self.stars, "star")
	self.frame = findTF(self.tf, "shipicon/frame"):GetComponent("Image")
	self.dutyTF = findTF(self.tf, "name_bg/duty")
	self.chatBgWidth = 550

	return
end

function GuildChatBubble:OnChatFrameLoaded(arg_2_1)
	local var_2_0 = tf(arg_2_1):Find("Text"):GetComponent(typeof(Text))

	self.prevChatFrameColor = self.prevChatFrameColor or var_2_0.color
	self.charFrameTxt = var_2_0

	return
end

function GuildChatBubble:dispose()
	GuildChatBubble.super.dispose(self)

	if self.charFrameTxt and self.prevChatFrameColor then
		self.charFrameTxt.color = self.prevChatFrameColor
	end

	return
end

return GuildChatBubble
