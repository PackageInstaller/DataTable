local ChatMsg = class("ChatMsg", import(".BaseVO"))

function ChatMsg:Ctor(arg_1_1, arg_1_2)
	assert(arg_1_1, "type should be clarified.")

	self.type = arg_1_1
	self.timestamp = arg_1_2.timestamp
	self.content = arg_1_2.content
	self.emojiId = arg_1_2.emojiId
	self.player = arg_1_2.player

	if self.player then
		self.playerId = self.player.id
	end

	self.unread = arg_1_2.unread or 0
	self.id = arg_1_2.id
	self.args = arg_1_2.args
	self.uniqueId = arg_1_2.uniqueId
	self.needBanRichText = true

	if arg_1_2.richText then
		self.needBanRichText = false
	end

	return
end

function ChatMsg:IsPublic()
	return self.id ~= nil
end

function ChatMsg:IsWorldBossNotify()
	return self.id == 4
end

function ChatMsg:IsSame(arg_4_1)
	return self.uniqueId == arg_4_1
end

return ChatMsg
