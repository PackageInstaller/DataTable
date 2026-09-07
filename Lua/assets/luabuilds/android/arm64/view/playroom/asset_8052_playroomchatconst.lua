local PlayRoomChatConst = class("PlayRoomChatConst")

PlayRoomChatConst.CHANNEL_PLAYROOM = 1
PlayRoomChatConst.CHANNEL_WORLD = 2
PlayRoomChatConst.CHANNEL_FRIEND = 4
PlayRoomChatConst.CHANNEL_GUILD = 8

local var_0_1 = {
	PlayRoomChatConst.CHANNEL_PLAYROOM,
	PlayRoomChatConst.CHANNEL_WORLD,
	PlayRoomChatConst.CHANNEL_FRIEND,
	PlayRoomChatConst.CHANNEL_GUILD
}
local var_0_2 = {
	i18n("match_ui_chat"),
	i18n("channel_name_2"),
	i18n("island_friend"),
	i18n("channel_name_5")
}

PlayRoomChatConst.CHANNEL_ALL = IndexConst.BitAll(var_0_1)
PlayRoomChatConst.CHANNELS = {}

table.insert(PlayRoomChatConst.CHANNELS, PlayRoomChatConst.CHANNEL_ALL)

for iter_0_0, iter_0_1 in ipairs(var_0_1) do
	table.insert(PlayRoomChatConst.CHANNELS, iter_0_1)
end

function PlayRoomChatConst:CHANNEL2CN()
	if self == PlayRoomChatConst.CHANNEL_ALL then
		return i18n("channel_name_1")
	end

	return var_0_2[table.indexof(var_0_1, self)]
end

PlayRoomChatConst.SEND_CHANNELS = {
	PlayRoomChatConst.CHANNEL_PLAYROOM,
	PlayRoomChatConst.CHANNEL_WORLD,
	PlayRoomChatConst.CHANNEL_GUILD
}

return PlayRoomChatConst
