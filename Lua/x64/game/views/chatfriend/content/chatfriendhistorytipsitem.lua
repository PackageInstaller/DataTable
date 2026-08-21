local var_0_0 = import("game.views.chat.chatItem.ChatBaseItemView")
local var_0_1 = class("ChatFriendHistoryTipsItem", var_0_0)

function var_0_1.SetData(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.index_ = arg_1_2
	arg_1_0.itemData_ = arg_1_1

	arg_1_0:Show(true)
end

return var_0_1
