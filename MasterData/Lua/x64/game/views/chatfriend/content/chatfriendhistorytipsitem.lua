local ChatFriendHistoryTipsItem = class("ChatFriendHistoryTipsItem", (import("game.views.chat.chatItem.ChatBaseItemView")))

function ChatFriendHistoryTipsItem:SetData(arg_1_1, arg_1_2)
	self.index_ = arg_1_2
	self.itemData_ = arg_1_1

	self:Show(true)
end

return ChatFriendHistoryTipsItem
