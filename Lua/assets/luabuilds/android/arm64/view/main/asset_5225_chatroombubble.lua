local ChatRoomBubble = class("ChatRoomBubble", import(".ChatBubble"))

function ChatRoomBubble:init()
	self.nameTF = findTF(self.tf, "desc/name"):GetComponent("Text")
	self.circle = findTF(self.tf, "shipicon/frame")
	self.face = findTF(self.tf, "face/content")
	self.timeTF = findTF(self.tf, "time"):GetComponent("Text")
	self.headTF = findTF(self.tf, "shipicon/icon"):GetComponent("Image")
	self.stars = findTF(self.tf, "shipicon/stars")
	self.star = findTF(self.stars, "star")
	self.frame = findTF(self.tf, "shipicon/frame"):GetComponent("Image")
	self.chatBgWidth = 665

	return
end

return ChatRoomBubble
