local IslandChatConst = class("IslandChatConst")

IslandChatConst.CHANNEL_ISLAND = 1
IslandChatConst.CHANNEL_WORLD = 2
IslandChatConst.CHANNEL_FRIEND = 4
IslandChatConst.CHANNEL_GUILD = 8

local var_0_1 = {
	IslandChatConst.CHANNEL_ISLAND,
	IslandChatConst.CHANNEL_WORLD,
	IslandChatConst.CHANNEL_FRIEND,
	IslandChatConst.CHANNEL_GUILD
}
local var_0_2 = {
	i18n("channel_name_6"),
	i18n("channel_name_2"),
	i18n("channel_name_4"),
	i18n("channel_name_5")
}

IslandChatConst.CHANNEL_ALL = IndexConst.BitAll(var_0_1)
IslandChatConst.CHANNELS = {}

table.insert(IslandChatConst.CHANNELS, IslandChatConst.CHANNEL_ALL)

for iter_0_0, iter_0_1 in ipairs(var_0_1) do
	table.insert(IslandChatConst.CHANNELS, iter_0_1)
end

function IslandChatConst:CHANNEL2CN()
	if self == IslandChatConst.CHANNEL_ALL then
		return i18n("channel_name_1")
	end

	return var_0_2[table.indexof(var_0_1, self)]
end

IslandChatConst.SEND_CHANNELS = {
	IslandChatConst.CHANNEL_ISLAND,
	IslandChatConst.CHANNEL_WORLD,
	IslandChatConst.CHANNEL_GUILD
}

return IslandChatConst
